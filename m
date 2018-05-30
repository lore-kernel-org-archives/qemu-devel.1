Received: from eggs.gnu.org ([2001:4830:134:3::10]:57180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8Xz-0001Ca-Am
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8Xy-0007Tu-59
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:22:19 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:45001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8Xx-0007TW-Uf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:22:18 -0400
Received: by mail-ua0-x241.google.com with SMTP id f30-v6so11776726uab.11
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:22:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e6a3908-5288-0627-abf9-15bfc96ff811@amsat.org>
Date: Wed, 30 May 2018 18:22:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180530184156.15634-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/5] scripts/qemu.py: introduce
 set_console() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> The set_console() method is intended to ease higher level use cases
> that require a console device.
> 
> The amount of intelligence is limited on purpose, requiring either the
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

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu.py | 97 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 7cd8193df8..f099ce7278 100644
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
>          self._args.extend(args)
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
> 
