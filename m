Received: from eggs.gnu.org ([2001:4830:134:3::10]:43868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fM5Zw-0002gj-28
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fM5Zs-0002nT-T0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fM5Zs-0002nB-M9
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:47:48 -0400
Date: Fri, 25 May 2018 13:47:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180525054744.GC28589@lemon.usersys.redhat.com>
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525005839.11556-5-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525005839.11556-5-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] scripts/qemu.py: introduce
 set_console() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>

On Thu, 05/24 20:58, Cleber Rosa wrote:
> The set_console() method is intended to ease higher level use cases
> that require a console device.
> 
> The amount of inteligence is limited on purpose, requiring either the
> device type explicitly, or the existence of a machine (pattern)
> definition.
> 
> Because of the console device type selection criteria (by machine
> type), users should also be able to define that.  It'll then be used
> for both '-machine' and for the console device type selection.
> 
> Users of the set_console() method will certainly be interested in
> accessing the console device, and for that a console_socket property
> has been added.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qemu.py      |  97 +++++++++++++++++++++++-
>  scripts/test_qemu.py | 176 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 272 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/test_qemu.py
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 7813dd45ad..89db5bc6b2 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -17,19 +17,41 @@ import logging
>  import os
>  import subprocess
>  import qmp.qmp
> +import re
>  import shutil
> +import socket
>  import tempfile
>  
>  
>  LOG = logging.getLogger(__name__)
>  
>  
> +#: Maps machine types to the preferred console device types
> +CONSOLE_DEV_TYPES = {
> +    r'^clipper$': 'isa-serial',
> +    r'^malta': 'isa-serial',
> +    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
> +    r'^(40p|powernv|prep)$': 'isa-serial',
> +    r'^pseries.*': 'spapr-vty',
> +    r'^s390-ccw-virtio.*': 'sclpconsole',
> +    }
> +
> +
>  class QEMUMachineError(Exception):
>      """
>      Exception called when an error in QEMUMachine happens.
>      """
>  
>  
> +class QEMUMachineAddDeviceError(QEMUMachineError):
> +    """
> +    Exception raised when a request to add a device can not be fulfilled
> +
> +    The failures are caused by limitations, lack of information or conflicting
> +    requests on the QEMUMachine methods.  This exception does not represent
> +    failures reported by the QEMU binary itself.
> +    """
> +
>  class MonitorResponseError(qmp.qmp.QMPError):
>      '''
>      Represents erroneous QMP monitor reply
> @@ -91,6 +113,10 @@ class QEMUMachine(object):
>          self._test_dir = test_dir
>          self._temp_dir = None
>          self._launched = False
> +        self._machine = None
> +        self._console_device_type = None
> +        self._console_address = None
> +        self._console_socket = None
>  
>          # just in case logging wasn't configured by the main script:
>          logging.basicConfig()
> @@ -175,9 +201,19 @@ class QEMUMachine(object):
>                  self._monitor_address[1])
>          else:
>              moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
> -        return ['-chardev', moncdev,
> +        args = ['-chardev', moncdev,
>                  '-mon', 'chardev=mon,mode=control',
>                  '-display', 'none', '-vga', 'none']
> +        if self._machine is not None:
> +            args.extend(['-machine', self._machine])
> +        if self._console_device_type is not None:
> +            self._console_address = os.path.join(self._temp_dir,
> +                                                 self._name + "-console.sock")
> +            chardev = ('socket,id=console,path=%s,server,nowait' %
> +                       self._console_address)
> +            device = '%s,chardev=console' % self._console_device_type
> +            args.extend(['-chardev', chardev, '-device', device])
> +        return args
>  
>      def _pre_launch(self):
>          self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> @@ -202,6 +238,10 @@ class QEMUMachine(object):
>  
>          self._qemu_log_path = None
>  
> +        if self._console_socket is not None:
> +            self._console_socket.close()
> +            self._console_socket = None
> +
>          if self._temp_dir is not None:
>              shutil.rmtree(self._temp_dir)
>              self._temp_dir = None
> @@ -365,3 +405,58 @@ class QEMUMachine(object):
>          Adds to the list of extra arguments to be given to the QEMU binary
>          '''
>          return self._args.extend(args)
> +
> +    def set_machine(self, machine_type):
> +        '''
> +        Sets the machine type
> +
> +        If set, the machine type will be added to the base arguments
> +        of the resulting QEMU command line.
> +        '''
> +        self._machine = machine_type
> +
> +    def set_console(self, device_type=None):
> +        '''
> +        Sets the device type for a console device
> +
> +        If set, the console device and a backing character device will
> +        be added to the base arguments of the resulting QEMU command
> +        line.
> +
> +        This is a convenience method that will either use the provided
> +        device type, of if not given, it will used the device type set
> +        on CONSOLE_DEV_TYPES.
> +
> +        The actual setting of command line arguments will be be done at
> +        machine launch time, as it depends on the temporary directory
> +        to be created.
> +
> +        @param device_type: the device type, such as "isa-serial"
> +        @raises: QEMUMachineAddDeviceError if the device type is not given
> +                 and can not be determined.
> +        '''
> +        if device_type is None:
> +            if self._machine is None:
> +                raise QEMUMachineAddDeviceError("Can not add a console device:"
> +                                                " QEMU instance without a "
> +                                                "defined machine type")
> +            for regex, device in CONSOLE_DEV_TYPES.items():
> +                if re.match(regex, self._machine):
> +                    device_type = device
> +                    break
> +            if device_type is None:
> +                raise QEMUMachineAddDeviceError("Can not add a console device:"
> +                                                " no matching console device "
> +                                                "type definition")
> +        self._console_device_type = device_type
> +
> +    @property
> +    def console_socket(self):
> +        """
> +        Returns a socket connected to the console
> +        """
> +        if self._console_socket is None:
> +            self._console_socket = socket.socket(socket.AF_UNIX,
> +                                                 socket.SOCK_STREAM)
> +            self._console_socket.connect(self._console_address)
> +        return self._console_socket
> diff --git a/scripts/test_qemu.py b/scripts/test_qemu.py
> new file mode 100644
> index 0000000000..5e016d3751
> --- /dev/null
> +++ b/scripts/test_qemu.py
> @@ -0,0 +1,176 @@

Again, a file header is missing.

> +import sys
> +import os
> +import glob
> +import unittest
> +import shutil
> +import tempfile
> +import subprocess
> +
> +import qemu
> +import qmp.qmp
> +
> +
> +class QEMUMachineProbeError(Exception):
> +    """
> +    Exception raised when a probe a fails to be deterministic
> +    """
> +
> +
> +def get_built_qemu_binaries(root_dir=None):
> +    """
> +    Attempts to find QEMU binaries in a tree
> +
> +    If root_dir is None, it will attempt to find the binaries at the
> +    source tree.  It's possible to override it by setting the environment
> +    variable QEMU_ROOT_DIR.
> +    """
> +    if root_dir is None:
> +        src_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
> +        root_dir = os.environ.get("QEMU_ROOT_DIR", src_dir)
> +    binaries = glob.glob(os.path.join(root_dir, '*-softmmu/qemu-system-*'))
> +    if 'win' in sys.platform:
> +        bin_filter = lambda x: x.endswith(".exe")
> +    else:
> +        bin_filter = lambda x: not x.endswith(".exe")
> +    return [_ for _ in binaries if bin_filter(_)]
> +
> +
> +def subprocess_dev_null(mode='w'):
> +    """
> +    A portable null file object suitable for use with the subprocess module
> +    """
> +    if hasattr(subprocess, 'DEVNULL'):
> +        return subprocess.DEVNULL
> +    else:
> +        return open(os.path.devnull, mode)
> +
> +
> +def qmp_execute(binary_path, qmp_command):
> +    """
> +    Executes a QMP command on a given QEMU binary
> +
> +    Useful for one-off execution of QEMU binaries to get runtime
> +    information.
> +
> +    @param binary_path: path to a QEMU binary
> +    @param qmp_command: the QMP command
> +    @note: passing arguments to the QMP command is not supported at
> +           this time.
> +    """
> +    try:
> +        tempdir = tempfile.mkdtemp()
> +        monitor_socket = os.path.join(tempdir, 'monitor.sock')
> +        args = [binary_path, '-nodefaults', '-machine', 'none',
> +                '-nographic', '-S', '-qmp', 'unix:%s' % monitor_socket]
> +        monitor = qmp.qmp.QEMUMonitorProtocol(monitor_socket, True)
> +        try:
> +            qemu_proc = subprocess.Popen(args,
> +                                         stdin=subprocess.PIPE,
> +                                         stdout=subprocess.PIPE,
> +                                         stderr=subprocess_dev_null(),
> +                                         universal_newlines=True)
> +        except OSError:
> +            return None
> +        monitor.accept()
> +        res = monitor.cmd(qmp_command)
> +        monitor.cmd("quit")
> +        qemu_proc.wait()
> +        monitor.close()
> +        return res.get("return", None)
> +    finally:
> +        shutil.rmtree(tempdir)
> +
> +
> +def qemu_bin_probe_arch(binary_path):
> +    """
> +    Probes the architecture from the QEMU binary
> +
> +    @returns: either the probed arch or None
> +    @rtype: str or None
> +    @raises: QEMUMachineProbeError
> +    """
> +    res = qmp_execute(binary_path, "query-target")
> +    if res is None:
> +        raise QEMUMachineProbeError('Failed to probe the QEMU arch by querying'
> +                                    ' the target of binary "%s"' % binary_path)
> +    return res.get("arch", None)
> +
> +
> +class QEMU(unittest.TestCase):

'QEMU' is too generic, what is the intended tests to do here? It seems to be
more about exercising the set_console() method.

Any test should be added to tests/, not scripts/.

> +
> +
> +    TEST_ARCH_MACHINE_CONSOLES = {
> +        'alpha': ['clipper'],
> +        'mips': ['malta'],
> +        'x86_64': ['isapc',
> +                   'pc', 'pc-0.10', 'pc-0.11', 'pc-0.12', 'pc-0.13',
> +                   'pc-0.14', 'pc-0.15', 'pc-1.0', 'pc-1.1', 'pc-1.2',
> +                   'pc-1.3',
> +                   'pc-i440fx-1.4', 'pc-i440fx-1.5', 'pc-i440fx-1.6',
> +                   'pc-i440fx-1.7', 'pc-i440fx-2.0', 'pc-i440fx-2.1',
> +                   'pc-i440fx-2.10', 'pc-i440fx-2.11', 'pc-i440fx-2.2',
> +                   'pc-i440fx-2.3', 'pc-i440fx-2.4', 'pc-i440fx-2.5',
> +                   'pc-i440fx-2.6', 'pc-i440fx-2.7', 'pc-i440fx-2.8',
> +                   'pc-i440fx-2.9', 'pc-q35-2.10', 'pc-q35-2.11',
> +                   'q35', 'pc-q35-2.4', 'pc-q35-2.5', 'pc-q35-2.6',
> +                   'pc-q35-2.7', 'pc-q35-2.8', 'pc-q35-2.9'],
> +        'ppc64': ['40p', 'powernv', 'prep', 'pseries', 'pseries-2.1',
> +                  'pseries-2.2', 'pseries-2.3', 'pseries-2.4', 'pseries-2.5',
> +                  'pseries-2.6', 'pseries-2.7', 'pseries-2.8', 'pseries-2.9',
> +                  'pseries-2.10', 'pseries-2.11', 'pseries-2.12'],
> +        's390x': ['s390-ccw-virtio', 's390-ccw-virtio-2.4',
> +                  's390-ccw-virtio-2.5', 's390-ccw-virtio-2.6',
> +                  's390-ccw-virtio-2.7', 's390-ccw-virtio-2.8',
> +                  's390-ccw-virtio-2.9', 's390-ccw-virtio-2.10',
> +                  's390-ccw-virtio-2.11', 's390-ccw-virtio-2.12']
> +    }
> +
> +
> +    def test_set_console(self):
> +        for machines in QEMU.TEST_ARCH_MACHINE_CONSOLES.values():
> +            for machine in machines:
> +                qemu_machine = qemu.QEMUMachine('/fake/path/to/binary')
> +                qemu_machine.set_machine(machine)
> +                qemu_machine.set_console()
> +
> +    def test_set_console_no_machine(self):
> +        qemu_machine = qemu.QEMUMachine('/fake/path/to/binary')
> +        self.assertRaises(qemu.QEMUMachineAddDeviceError,
> +                          qemu_machine.set_console)
> +
> +    def test_set_console_no_machine_match(self):
> +        qemu_machine = qemu.QEMUMachine('/fake/path/to/binary')
> +        qemu_machine.set_machine('unknown-machine-model')
> +        self.assertRaises(qemu.QEMUMachineAddDeviceError,
> +                          qemu_machine.set_console)
> +
> +    @unittest.skipUnless(get_built_qemu_binaries(),
> +                         "Could not find any QEMU binaries built to use on "
> +                         "console check")
> +    def test_set_console_launch(self):
> +        for binary in get_built_qemu_binaries():
> +            probed_arch = qemu_bin_probe_arch(binary)
> +            for machine in QEMU.TEST_ARCH_MACHINE_CONSOLES.get(probed_arch, []):
> +                qemu_machine = qemu.QEMUMachine(binary)
> +
> +                # the following workarounds are target specific required for
> +                # this test.  users are of QEMUMachine are expected to deal with
> +                # target specific requirements just the same in their own code
> +                cap_htm_off = ('pseries-2.7', 'pseries-2.8', 'pseries-2.9',
> +                               'pseries-2.10', 'pseries-2.11', 'pseries-2.12')
> +                if probed_arch == 'ppc64' and machine in cap_htm_off:
> +                    qemu_machine._machine = machine   # pylint: disable=W0212
> +                    qemu_machine.args.extend(['-machine',
> +                                              '%s,cap-htm=off' % machine])
> +                elif probed_arch == 's390x':
> +                    qemu_machine.set_machine(machine)
> +                    qemu_machine.args.append('-nodefaults')
> +                elif probed_arch == 'mips':
> +                    qemu_machine.set_machine(machine)
> +                    qemu_machine.args.extend(['-bios', os.path.devnull])
> +                else:
> +                    qemu_machine.set_machine(machine)
> +
> +                qemu_machine.set_console()
> +                qemu_machine.launch()
> +                qemu_machine.shutdown()
> -- 
> 2.17.0
> 

Fam
