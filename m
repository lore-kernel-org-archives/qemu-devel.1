Received: from eggs.gnu.org ([2001:4830:134:3::10]:33140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Ci9-0003HR-Gg
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Ci5-0007Nl-4c
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:36 -0300
Message-Id: <20180419164642.9536-2-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/7] AVOCADO_QEMU: Snapshot commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Amador Pahim <apahim@redhat.com>

Applied https://patch-diff.githubusercontent.com/raw/apahim/qemu/pull/17.patch
following http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03891.html.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py                               |  59 ++-
 tests/avocado/README.rst                      | 132 ++++++
 tests/avocado/avocado_qemu/__init__.py        |   0
 tests/avocado/avocado_qemu/test.py            | 418 ++++++++++++++++++
 tests/avocado/parameters.yaml                 |  19 +
 tests/avocado/test_info_memdev_host_nodes.py  |  66 +++
 tests/avocado/test_nec-usb-xhci.py            |  63 +++
 .../test_nec-usb-xhci.py.data/parameters.yaml |   4 +
 tests/avocado/test_numa_hotplug.py            | 120 +++++
 tests/avocado/test_ovmf_with_240_vcpus.py     |  70 +++
 .../parameters.yaml                           |   2 +
 tests/avocado/variants.yaml                   |  62 +++
 tests/qemu-iotests/iotests.py                 |  28 +-
 13 files changed, 1019 insertions(+), 24 deletions(-)
 create mode 100644 tests/avocado/README.rst
 create mode 100644 tests/avocado/avocado_qemu/__init__.py
 create mode 100644 tests/avocado/avocado_qemu/test.py
 create mode 100644 tests/avocado/parameters.yaml
 create mode 100644 tests/avocado/test_info_memdev_host_nodes.py
 create mode 100644 tests/avocado/test_nec-usb-xhci.py
 create mode 100644 tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml
 create mode 100644 tests/avocado/test_numa_hotplug.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml
 create mode 100644 tests/avocado/variants.yaml

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 08a3e9af5a..bd66620f45 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -55,7 +55,7 @@ class QEMUMachine(object):
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None):
+                 socket_scm_helper=None, arch=None):
         '''
         Initialize a QEMUMachine
 
@@ -81,7 +81,7 @@ class QEMUMachine(object):
         self._qemu_log_file = None
         self._popen = None
         self._binary = binary
-        self._args = list(args)     # Force copy args in case we modify them
+        self.args = list(args)     # Force copy args in case we modify them
         self._wrapper = wrapper
         self._events = []
         self._iolog = None
@@ -91,6 +91,10 @@ class QEMUMachine(object):
         self._test_dir = test_dir
         self._temp_dir = None
         self._launched = False
+        if arch is None:
+            arch = binary.split('-')[-1]
+        self._arch = arch
+        self._console_address = None
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -105,8 +109,8 @@ class QEMUMachine(object):
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
         args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
-        self._args.append('-monitor')
-        self._args.append(args)
+        self.args.append('-monitor')
+        self.args.append(args)
 
     def add_fd(self, fd, fdset, opaque, opts=''):
         '''Pass a file descriptor to the VM'''
@@ -116,8 +120,8 @@ class QEMUMachine(object):
         if opts:
             options.append(opts)
 
-        self._args.append('-add-fd')
-        self._args.append(','.join(options))
+        self.args.append('-add-fd')
+        self.args.append(','.join(options))
         return self
 
     def send_fd_scm(self, fd_file_path):
@@ -179,6 +183,39 @@ class QEMUMachine(object):
                 '-mon', 'chardev=mon,mode=control',
                 '-display', 'none', '-vga', 'none']
 
+    def _create_console(self, console_address):
+        for item in self.args:
+            for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
+                if option in item:
+                    return []
+
+        chardev = 'socket,id=console,{address},server,nowait'
+        if console_address is None:
+            console_address = tempfile.mktemp()
+            chardev = chardev.format(address='path=%s' %
+                                     console_address)
+        elif isinstance(console_address, tuple):
+            chardev = chardev.format(address='host=%s,port=%s' %
+                                     (console_address[0],
+                                     console_address[1]))
+        else:
+            chardev = chardev.format(address='path=%s' % console_address)
+
+        self._console_address = console_address
+
+        device = '{dev_type},chardev=console'
+        if '86' in self._arch:
+            device = device.format(dev_type='isa-serial')
+        elif 'ppc' in self._arch:
+            device = device.format(dev_type='spapr-vty')
+        elif 's390x' in self._arch:
+            device = device.format(dev_type='sclpconsole')
+        else:
+            return []
+
+        return ['-chardev', chardev,
+                '-device', device]
+
     def _pre_launch(self):
         self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
         if self._monitor_address is not None:
@@ -206,7 +243,7 @@ class QEMUMachine(object):
             shutil.rmtree(self._temp_dir)
             self._temp_dir = None
 
-    def launch(self):
+    def launch(self, console_address=None):
         """
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
@@ -218,7 +255,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._qemu_full_args = None
         try:
-            self._launch()
+            self._launch(console_address)
             self._launched = True
         except:
             self.shutdown()
@@ -230,12 +267,14 @@ class QEMUMachine(object):
                 LOG.debug('Output: %r', self._iolog)
             raise
 
-    def _launch(self):
+    def _launch(self, console_address):
         '''Launch the VM and establish a QMP connection'''
         devnull = open(os.path.devnull, 'rb')
         self._pre_launch()
+        bargs = self._base_args()
+        bargs.extend(self._create_console(console_address))
         self._qemu_full_args = (self._wrapper + [self._binary] +
-                                self._base_args() + self._args)
+                                bargs + self.args)
         self._popen = subprocess.Popen(self._qemu_full_args,
                                        stdin=devnull,
                                        stdout=self._qemu_log_file,
diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
new file mode 100644
index 0000000000..a33c4a2577
--- /dev/null
+++ b/tests/avocado/README.rst
@@ -0,0 +1,132 @@
+========================================
+ QEMU tests using the Avocado Framework
+========================================
+
+This directory hosts functional tests written using Avocado Testing
+Framework.
+
+Installation
+============
+
+To install Avocado and the dependencies needed for these tests, run::
+
+    pip install --user avocado-framework avocado-framework-plugin-varianter-yaml-to-mux aexpect
+
+Alternatively, follow the instructions on this link::
+
+    http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
+
+Overview
+========
+
+In this directory, an ``avocado_qemu`` package is provided, containing
+the ``test`` module, which inherits from ``avocado.Test`` and provides
+a builtin and easy-to-use Qemu virtual machine. Here's a template that
+can be used as reference to start writing your own tests::
+
+    from avocado_qemu import test
+
+    class MyTest(test.QemuTest):
+        """
+        :avocado: enable
+        """
+
+        def setUp(self):
+            self.vm.args.extend(['-m', '512'])
+            self.vm.launch()
+
+        def test_01(self):
+            res = self.vm.qmp('human-monitor-command',
+                              command_line='info version')
+            self.assertIn('v2.9.0', res['return'])
+
+        def tearDown(self):
+            self.vm.shutdown()
+
+To execute your test, run::
+
+    avocado run test_my_test.py
+
+To execute all tests, run::
+
+    avocado run .
+
+If you don't specify the Qemu binary to use, the ``avocado_qemu``
+package will automatically probe it. The probe will try to use the Qemu
+binary from the git tree build directory, using the same architecture as
+the local system (if the architecture is not specified). If the Qemu
+binary is not available in the git tree build directory, the next try is
+to use the system installed Qemu binary.
+
+You can define a number of optional parameters, providing them via YAML
+file using the Avocado parameters system:
+
+- ``qemu_bin``: Use a given Qemu binary, skipping the automatic
+  probe. Example: ``qemu_bin: /usr/libexec/qemu-kvm``.
+- ``qemu_dst_bin``: Use a given Qemu binary to create the destination VM
+  when the migration process takes place. If it's not provided, the same
+  binary used in the source VM will be used for the destination VM.
+  Example: ``qemu_dst_bin: /usr/libexec/qemu-kvm-binary2``.
+- ``arch``: Probe the Qemu binary from a given architecture. It has no
+  effect if ``qemu_bin`` is specified. If not provided, the binary probe
+  will use the system architecture. Example: ``arch: x86_64``
+- ``image_path``: When a test requires (usually a bootable) image, this
+  parameter is used to define where the image is located. When undefined
+  it uses ``$QEMU_ROOT/bootable_image_$arch.qcow2``. The image is added
+  to the qemu command __only__ when the test requires an image. By
+  default ``,snapshot=on`` is used, but it can be altered by
+  ``image_snapshot`` parameter.
+- ``image_user`` and ``image_pass``: When using a ``image_path``, if you
+  want to get the console from the Guest OS you have to define the Guest
+  OS credentials. Example: ``image_user: avocado`` and
+  ``image_pass: p4ssw0rd``. Both parameters have defaults to ``avocado``.
+- ``machine_type``: Use this option to define a machine type for the VM.
+  Example: ``machine_type: pc``
+- ``machine_accel``: Use this option to define a machine acceleration
+  for the VM. Example: ``machine_accel: kvm``.
+- ``machine_kvm_type``: Use this option to select the KVM type when the
+  ``accel`` is ``kvm`` and there are more than one KVM types available.
+  Example: ``machine_kvm_type: PR``
+
+Run the test with::
+
+    $ avocado run test_my_test.py -m parameters.yaml
+
+Additionally, you can use a variants file to to set different values
+for each parameter. Using the YAML tag ``!mux`` Avocado will execute the
+tests once per combination of parameters. Example::
+
+    $ cat variants.yaml
+    architecture: !mux
+        x86_64:
+            arch: x86_64
+        i386:
+            arch: i386
+
+Run it the with::
+
+    $ avocado run test_my_test.py -m variants.yaml
+
+You can use both the parameters file and the variants file in the same
+command line::
+
+    $ avocado run test_my_test.py -m parameters.yaml variants.yaml
+
+Avocado will then merge the parameters from both files and create the
+proper variants.
+
+See ``avocado run --help`` and ``man avocado`` for several other
+options, such as ``--filter-by-tags``, ``--show-job-log``,
+``--failfast``, etc.
+
+Uninstallation
+==============
+
+If you've followed the installation instructions above, you can easily
+uninstall Avocado.  Start by listing the packages you have installed::
+
+    pip list --user
+
+And remove any package you want with::
+
+    pip uninstall <package_name>
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
new file mode 100644
index 0000000000..5a08dace45
--- /dev/null
+++ b/tests/avocado/avocado_qemu/test.py
@@ -0,0 +1,418 @@
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+#
+# See LICENSE for more details.
+#
+# Copyright (C) 2017 Red Hat Inc
+#
+# Authors:
+#  Amador Pahim <apahim@redhat.com>
+#
+# Based on code from:
+#   https://github.com/avocado-framework/avocado-virt
+
+
+"""
+Avocado Qemu Test module to extend the Avocado Test module providing
+extra features intended for Qemu testing.
+"""
+
+
+import logging
+import os
+import re
+import sys
+import tempfile
+import time
+import uuid
+
+import aexpect
+
+from avocado import Test
+from avocado.utils import network
+from avocado.utils import process
+from avocado.utils import path as utils_path
+from avocado.utils import wait
+
+QEMU_ROOT = os.path.abspath(os.path.dirname(os.path.dirname(os.path.dirname(
+    os.path.dirname(__file__)))))
+sys.path.append(os.path.join(QEMU_ROOT, 'scripts'))
+import qemu
+
+
+class QEMULoginTimeoutError(Exception):
+    """
+    If timeout expires
+    """
+
+
+class QEMULoginAuthenticationError(Exception):
+    """
+    If authentication fails
+    """
+
+
+class QEMULoginProcessTerminatedError(Exception):
+    """
+    If the client terminates during login
+    """
+
+
+class QEMULoginError(Exception):
+    """
+    If some other error occurs
+    """
+
+
+class QEMUConsoleError(Exception):
+    """
+    If some error with the console access happens
+    """
+
+
+class QEMUMigrationError(Exception):
+    """
+    If some error with the migration happens
+    """
+
+
+class QEMUCloudinitError(Exception):
+    """
+    If some error with the cloudinit happens
+    """
+
+
+def _get_qemu_bin(arch):
+    git_root = process.system_output('git rev-parse --show-toplevel',
+                                     ignore_status=True,
+                                     verbose=False)
+    qemu_binary = os.path.join(git_root,
+                               "%s-softmmu" % arch,
+                               "qemu-system-%s" % arch)
+    if not os.path.exists(qemu_binary):
+        qemu_binary = utils_path.find_command('qemu-system-%s' % arch)
+    return qemu_binary
+
+
+def _handle_prompts(session, username, password, prompt, timeout=60,
+                    debug=False):
+    """
+    Connect to a remote host (guest) using SSH or Telnet or else.
+
+    Wait for questions and provide answers.  If timeout expires while
+    waiting for output from the child (e.g. a password prompt or
+    a shell prompt) -- fail.
+
+    :param session: An Expect or ShellSession instance to operate on
+    :param username: The username to send in reply to a login prompt
+    :param password: The password to send in reply to a password prompt
+    :param prompt: The shell prompt that indicates a successful login
+    :param timeout: The maximal time duration (in seconds) to wait for each
+            step of the login procedure (i.e. the "Are you sure" prompt, the
+            password prompt, the shell prompt, etc)
+    :raise QEMULoginTimeoutError: If timeout expires
+    :raise QEMULoginAuthenticationError: If authentication fails
+    :raise QEMULoginProcessTerminatedError: If the client terminates during login
+    :raise QEMULoginError: If some other error occurs
+    :return: If connect succeed return the output text to script for further
+             debug.
+    """
+    re_kernel_message = re.compile(r"^\[\s*\d+.\d+\] ")
+
+    def get_last_nonempty_line(cont):
+        """Return last non-empty non-kernel line"""
+        nonempty_lines = [_ for _ in cont.splitlines()
+                          if _.strip() and not re_kernel_message.match(_)]
+        if nonempty_lines:
+            return nonempty_lines[-1]
+        else:
+            return ""
+
+    password_prompt_count = 0
+    login_prompt_count = 0
+    last_chance = False
+    # Send enter to refresh output (in case session was attached after boot)
+    session.sendline()
+    output = ""
+    while True:
+        try:
+            match, text = session.read_until_output_matches(
+                [r"[Aa]re you sure", r"[Pp]assword:\s*",
+                 # Prompt of rescue mode for Red Hat.
+                 r"\(or (press|type) Control-D to continue\):\s*",
+                 r"[Gg]ive.*[Ll]ogin:\s*",  # Prompt of rescue mode for SUSE.
+                 r"(?<![Ll]ast )[Ll]ogin:\s*",  # Don't match "Last Login:"
+                 r"[Cc]onnection.*closed", r"[Cc]onnection.*refused",
+                 r"[Pp]lease wait", r"[Ww]arning", r"[Ee]nter.*username",
+                 r"[Ee]nter.*password", r"[Cc]onnection timed out", prompt,
+                 r"Escape character is.*"], get_last_nonempty_line,
+                timeout=timeout, internal_timeout=0.5)
+            output += text
+            if match == 0:  # "Are you sure you want to continue connecting"
+                if debug:
+                    logging.debug("Got 'Are you sure...', sending 'yes'")
+                session.sendline("yes")
+                continue
+            elif match in [1, 2, 3, 10]:  # "password:"
+                if password_prompt_count == 0:
+                    if debug:
+                        logging.debug("Got password prompt, sending '%s'",
+                                      password)
+                    session.sendline(password)
+                    password_prompt_count += 1
+                    continue
+                else:
+                    raise QEMULoginAuthenticationError("Got password prompt "
+                                                       "twice", text)
+            elif match == 4 or match == 9:  # "login:"
+                if login_prompt_count == 0 and password_prompt_count == 0:
+                    if debug:
+                        logging.debug("Got username prompt; sending '%s'",
+                                      username)
+                    session.sendline(username)
+                    login_prompt_count += 1
+                    continue
+                else:
+                    if login_prompt_count > 0:
+                        msg = "Got username prompt twice"
+                    else:
+                        msg = "Got username prompt after password prompt"
+                    raise QEMULoginAuthenticationError(msg, text)
+            elif match == 5:  # "Connection closed"
+                raise QEMULoginError("Client said 'connection closed'", text)
+            elif match == 6:  # "Connection refused"
+                raise QEMULoginError("Client said 'connection refused'", text)
+            elif match == 11:  # Connection timeout
+                raise QEMULoginError("Client said 'connection timeout'", text)
+            elif match == 7:  # "Please wait"
+                if debug:
+                    logging.debug("Got 'Please wait'")
+                timeout = 30
+                continue
+            elif match == 8:  # "Warning added RSA"
+                if debug:
+                    logging.debug("Got 'Warning added RSA to known host list")
+                continue
+            elif match == 12:  # prompt
+                if debug:
+                    logging.debug("Got shell prompt -- logged in")
+                break
+            elif match == 13:  # console prompt
+                logging.debug("Got console prompt, send return to show login")
+                session.sendline()
+        except aexpect.ExpectTimeoutError as details:
+            # sometimes, linux kernel print some message to console
+            # the message maybe impact match login pattern, so send
+            # a empty line to avoid unexpect login timeout
+            if not last_chance:
+                time.sleep(0.5)
+                session.sendline()
+                last_chance = True
+                continue
+            else:
+                raise QEMULoginTimeoutError(details.output)
+        except aexpect.ExpectProcessTerminatedError as details:
+            raise QEMULoginProcessTerminatedError(details.status, details.output)
+
+    return output
+
+
+class _VM(qemu.QEMUMachine):
+    '''A QEMU VM'''
+
+    def __init__(self, qemu_bin=None, arch=None, qemu_dst_bin=None,
+                 username=None, password=None):
+        if arch is None:
+            arch = os.uname()[4]
+        self.arch = arch
+        self.ports = network.PortTracker()
+        self.name = "qemu-%s" % str(uuid.uuid4())[:8]
+        if qemu_bin is None:
+            qemu_bin = _get_qemu_bin(arch)
+        if qemu_dst_bin is None:
+            qemu_dst_bin = qemu_bin
+        self.qemu_bin = qemu_bin
+        self.qemu_dst_bin = qemu_dst_bin
+        self.username = username
+        self.password = password
+        super(_VM, self).__init__(qemu_bin, name=self.name, arch=arch)
+        logging.getLogger('QMP').setLevel(logging.INFO)
+
+    def get_console(self, console_address=None, prompt=r"[\#\$] "):
+        """
+        :param address: Socket address, can be either a unix socket path
+                        (string) or a tuple in the form (address, port)
+                        for a TCP connection
+        :param prompt: The regex to identify we reached the prompt.
+        """
+
+        if not all((self.username, self.password)):
+            raise QEMULoginError('Username or password not set.')
+
+        if not self.is_running():
+            raise QEMULoginError('VM is not running.')
+
+        if console_address is None:
+            if self._console_address is None:
+                raise QEMUConsoleError("Can't determine the console address "
+                                       "to connect to.")
+            else:
+                console_address = self._console_address
+
+        nc_cmd = 'nc'
+        if isinstance(console_address, tuple):
+            nc_cmd += ' %s %s' % (console_address[0], console_address[1])
+        else:
+            nc_cmd += ' -U %s' % console_address
+
+        console = aexpect.ShellSession(nc_cmd)
+        try:
+            logging.info('Console: Waiting login prompt...')
+            _handle_prompts(console, self.username, self.password, prompt)
+            logging.info('Console: Ready!')
+        except:
+            console.close()
+            raise
+
+        return console
+
+    def migrate(self, console_address=None, timeout=20):
+        def migrate_complete():
+            cmd = 'info migrate'
+            res = self.qmp('human-monitor-command', command_line=cmd)
+            if 'completed' in res['return']:
+                logging.info("Migration successful")
+                return True
+            elif 'failed' in res['return']:
+                logging.error(res)
+                raise QEMUMigrationError("Migration of %s failed" % self.name)
+            return False
+
+        port = self.ports.find_free_port()
+        newvm = _VM(self.qemu_dst_bin, self._arch, username=self.username,
+                    password=self.password)
+        newvm.args = self.args
+        newvm.args.extend(['-incoming', 'tcp:0:%s' % port])
+        newvm.username = self.username
+        newvm.password = self.password
+
+        newvm.launch(console_address)
+        cmd = 'migrate -d tcp:0:%s' % port
+        self.qmp('human-monitor-command', command_line=cmd)
+        mig_result = wait.wait_for(migrate_complete, timeout=timeout,
+                                   text='Waiting for migration to complete')
+
+        if mig_result is None:
+            raise QEMUMigrationError("Migration of %s did not complete after "
+                                     "%s s" % (self.name, timeout))
+
+        return newvm
+
+    def add_image(self, path, username=None, password=None, cloudinit=False,
+                  snapshot=True, extra=None):
+        """
+        Adds the '-drive' command line option and its parameters to
+        the Qemu VM
+
+        :param path: Image path (i.e. /var/lib/images/guestos.qcow2)
+        :param username: The username to log into the Guest OS with
+        :param password: The password to log into the Guest OS with
+        :param cloudinit: Whether the cloudinit cdrom will be attached to
+                          the image
+        :param snapshot: Whether the parameter snapshot=on will be used
+        :param extra: Extra parameters to the -drive option
+        """
+        file_option = 'file=%s' % path
+        for item in self.args:
+            if file_option in item:
+                logging.error('Image %s already present', path)
+                return
+
+        if extra is not None:
+            file_option += ',%s' % extra
+
+        if snapshot:
+            file_option += ',snapshot=on'
+
+        self.args.extend(['-drive', file_option])
+
+        if username is not None:
+            self.username = username
+
+        if password is not None:
+            self.password = password
+
+        if cloudinit:
+            self._cloudinit()
+
+    def _cloudinit(self):
+        """
+        Creates a CDROM Iso Image with the required cloudinit files
+        (meta-data and user-data) to make the initial Cloud Image
+        configuration, attaching the CDROM to the VM.
+        """
+        try:
+            geniso_bin = utils_path.find_command('genisoimage')
+        except:
+            raise QEMUCloudinitError('Command not found (genisoimage)')
+
+        data_dir = tempfile.mkdtemp()
+
+        metadata_path = os.path.join(data_dir, 'meta-data')
+        metadata_content = ("instance-id: %s\n"
+                            "local-hostname: %s\n" % (self.name, self.name))
+        with open(metadata_path, 'w') as metadata_file:
+            metadata_file.write(metadata_content)
+
+        userdata_path = os.path.join(data_dir, 'user-data')
+        userdata_content = ("#cloud-config\n"
+                            "password: %s\n"
+                            "ssh_pwauth: True\n"
+                            "chpasswd: { expire: False }\n"
+                            "system_info:\n"
+                            "    default_user:\n"
+                            "        name: %s\n" %
+                            (self.password, self.username))
+
+        with open(userdata_path, 'w') as userdata_file:
+            userdata_file.write(userdata_content)
+
+        iso_path = os.path.join(data_dir, 'cdrom.iso')
+        process.run("%s -output %s -volid cidata -joliet -rock %s %s" %
+                    (geniso_bin, iso_path, metadata_path, userdata_path))
+
+        self.args.extend(['-cdrom', iso_path])
+
+class QemuTest(Test):
+
+    def __init__(self, methodName=None, name=None, params=None,
+                 base_logdir=None, job=None, runner_queue=None):
+        super(QemuTest, self).__init__(methodName=methodName, name=name,
+                                       params=params, base_logdir=base_logdir,
+                                       job=job, runner_queue=runner_queue)
+        self.vm = _VM(qemu_bin=self.params.get('qemu_bin'),
+                      arch=self.params.get('arch'),
+                      qemu_dst_bin=self.params.get('qemu_dst_bin'),
+                      username=self.params.get('image_user',
+                                               default='avocado'),
+                      password=self.params.get('image_pass',
+                                               default='avocado'))
+
+        machine_type = self.params.get('machine_type')
+        machine_accel = self.params.get('machine_accel')
+        machine_kvm_type = self.params.get('machine_kvm_type')
+        machine = ""
+        if machine_type is not None:
+            machine += "%s," % machine_type
+        if machine_accel is not None:
+            machine += "accel=%s," % machine_accel
+        if machine_kvm_type is not None:
+            machine += "kvm-type=%s," % machine_kvm_type
+        if machine:
+            self.vm.args.extend(['-machine', machine])
diff --git a/tests/avocado/parameters.yaml b/tests/avocado/parameters.yaml
new file mode 100644
index 0000000000..03c4ed1416
--- /dev/null
+++ b/tests/avocado/parameters.yaml
@@ -0,0 +1,19 @@
+# Probe the Qemu binary from a given architecture. It has no effect if
+# 'qemu_bin' is specified. If not provided, the binary probe will use
+# the local system architecture.
+arch: null
+
+# Use a given Qemu binary, skipping the automatic probe.
+qemu_bin: null
+# Use a given Qemu binary to create the destination VM when the
+# migration process is called. If it's not provided, the same binary
+# used in the source VM will be used for the destination VM.
+qemu_dst_bin: null
+
+# Use this option to define a machine type for the VM.
+machine_type: null
+# Use this option to define a machine acceleration for the VM.
+machine_accel: null
+# Use this option to select the KVM type when the 'machine_accel' is set
+# to 'kvm' and there are more than one KVM types available.
+machine_kvm_type: null
diff --git a/tests/avocado/test_info_memdev_host_nodes.py b/tests/avocado/test_info_memdev_host_nodes.py
new file mode 100644
index 0000000000..69891b723d
--- /dev/null
+++ b/tests/avocado/test_info_memdev_host_nodes.py
@@ -0,0 +1,66 @@
+from avocado import main
+from avocado_qemu import test
+
+
+class TestInfoMemdev(test.QemuTest):
+    """
+
+    :avocado: enable
+    :avocado: tags=qmp,object_add,device_add,memdev
+    """
+
+    def setUp(self):
+        self.vm.args.extend(['-m', '4G,slots=32,maxmem=40G'])
+        self.vm.launch()
+
+    def test_hotplug_memory_default_policy(self):
+        """
+        According to the RHBZ1431939, the issue is 'host nodes'
+        returning '128'. It should return empty value when memory
+        hotplug default policy is used.
+
+        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
+        :avocado: tags=RHBZ1431939
+        """
+
+        cmd = 'object_add memory-backend-ram,id=mem1,size=1G'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'device_add pc-dimm,id=dimm1,memdev=mem1'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'info memdev'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertIn('policy: default\r', res['return'])
+        self.assertIn('host nodes: \r', res['return'])
+
+    def test_hotplug_memory_bind_policy(self):
+        """
+        According to the RHBZ1431939, the issue is 'host nodes'
+        returning '128'. It should return 0 when memory hotplug
+        bind policy is used.
+
+        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
+        :avocado: tags=RHBZ1431939
+        """
+
+        cmd = 'object_add memory-backend-ram,id=mem1,host-nodes=0,size=2G,policy=bind'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'device_add pc-dimm,id=dimm1,memdev=mem1'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'info memdev'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertIn('policy: bind\r', res['return'])
+        self.assertIn('host nodes: 0\r', res['return'])
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+if __name__ == "__main__":
+    avocado.main()
diff --git a/tests/avocado/test_nec-usb-xhci.py b/tests/avocado/test_nec-usb-xhci.py
new file mode 100644
index 0000000000..c29b5ebaa1
--- /dev/null
+++ b/tests/avocado/test_nec-usb-xhci.py
@@ -0,0 +1,63 @@
+import copy
+import os
+import tempfile
+
+from avocado_qemu import test
+from avocado.utils import process
+from avocado.utils import vmimage
+
+class TestNecUsbXhci(test.QemuTest):
+    """
+    Run with:
+
+        avocado run test_nec-usb-xhci.py \
+        -m test_nec-usb-xhci.py.data/parameters.yaml
+
+    :avocado: enable
+    :avocado: tags=usbstorage
+    """
+
+    def setUp(self):
+        self.vm_dst = None
+        self.image = vmimage.get('Fedora')
+        self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
+        self.vm.args.extend(['-machine', 'accel=kvm'])
+
+        usbdevice = os.path.join(self.workdir, 'usb.img')
+        process.run('dd if=/dev/zero of=%s bs=1M count=10' % usbdevice)
+        self.vm.args.extend(['-device', 'pci-bridge,id=bridge1,chassis_nr=1'])
+        self.vm.args.extend(['-device', 'nec-usb-xhci,id=xhci1,bus=bridge1,addr=0x3'])
+        self.vm.args.extend(['-drive', 'file=%s,format=raw,id=drive_usb,if=none' % usbdevice])
+        self.vm.args.extend(['-device', 'usb-storage,drive=drive_usb,id=device_usb,bus=xhci1.0'])
+        self.vm.launch()
+
+    def test_available_after_migration(self):
+        """
+        According to the RHBZ1436616, the issue is: usb-storage device
+        under pci-bridge is unusable after migration.
+
+        Fixed in commit 243afe858b95765b98d16a1f0dd50dca262858ad.
+
+        :avocado: tags=migration,RHBZ1436616
+        """
+
+        console = self.vm.get_console()
+        console.sendline('sudo fdisk -l')
+        result = console.read_up_to_prompt()
+        console.close()
+        self.assertIn('Disk /dev/sdb: 10 MiB, 10485760 bytes, 20480 sectors',
+                      result)
+
+        self.vm_dst = self.vm.migrate()
+        console = self.vm_dst.get_console()
+        console.sendline('sudo fdisk -l')
+        result = console.read_up_to_prompt()
+        console.close()
+        self.assertIn('Disk /dev/sdb: 10 MiB, 10485760 bytes, 20480 sectors',
+                      result)
+
+    def tearDown(self):
+        self.vm.shutdown()
+        if self.vm_dst is not None:
+            self.vm_dst.shutdown()
+        os.remove(self.image.path)
diff --git a/tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml b/tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml
new file mode 100644
index 0000000000..37a4e9dc37
--- /dev/null
+++ b/tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml
@@ -0,0 +1,4 @@
+machine_accel: kvm
+image_path: /var/lib/images/fedora-25.img
+image_user: root
+image_pass: p4ssw0rd
diff --git a/tests/avocado/test_numa_hotplug.py b/tests/avocado/test_numa_hotplug.py
new file mode 100644
index 0000000000..256ec0f49f
--- /dev/null
+++ b/tests/avocado/test_numa_hotplug.py
@@ -0,0 +1,120 @@
+import re
+import time
+
+from avocado_qemu import test
+from avocado.utils import vmimage
+
+
+class TestNumaHotplug(test.QemuTest):
+    """
+    Verifies that "info numa" and "/sys/devices/system/node/" contains
+    correct values before/after inserting memory devices into default
+    and then into 13th numa node.
+
+    Associated bug trackers: RHBZ1473203
+        https://bugzilla.redhat.com/show_bug.cgi?id=1473203
+
+    Fixed in kernel commit dc421b200f91930c9c6a9586810ff8c232cf10fc.
+
+    :avocado: enable
+    :avocado: tags=RHBZ1473203,requires_linux,numa,memory,ppc64le
+    """
+
+    def setUp(self):
+        self.image = vmimage.get('Fedora')
+        self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
+
+        self.vm.args.extend(['-machine', 'accel=kvm'])
+        self.vm.args.extend(["-m", "4G,slots=208,maxmem=80G"])
+        self.vm.args.extend(["-numa", "node"] * 16)
+        self.vm.launch()
+
+    def check_mem_console(self, console, exp):
+        """
+        Verifies that memory layout is according to exp using console/ssh
+
+        :param console: session
+        :param exp: list of MemTotals per node in MB, tolerance is +-100MB
+        """
+        out = console.cmd_output_safe("echo /sys/devices/system/node/node*")
+        nodes = re.findall(r"/sys/devices/system/node/node\d+", out)
+        self.assertEqual(len(nodes), len(exp), "Number of nodes is not "
+                         "%s:\n%s" % (len(exp), out))
+        for i in xrange(len(exp)):
+            out = console.cmd_output_safe("cat /sys/devices/system/node/"
+                                          "node%s/meminfo" % i)
+            mem = re.search(r"MemTotal:\s*(\d+) kB", out)
+            self.assertTrue(mem, "Failed to obtain node%s MemTotal:\n%s"
+                            % (i, out))
+            _exp = exp[i] * 1024
+            mem = int(mem.group(1))
+            self.assertGreater(mem, _exp - 102400, "TotalMem of node%s is not "
+                               "%s+-51200 kb (%s)" % (i, _exp, mem))
+            self.assertLess(mem, _exp + 102400, "TotalMem of node%s is not "
+                            "%s+-51200 kb (%s)" % (i, _exp, mem))
+
+    def check_mem_monitor(self, monitor, exp):
+        """
+        Verifies that memory layout is according to exp using QMP monitor
+
+        :param console: session
+        :param exp: list of MemTotals per node in MB, tolerance is +-100MB
+        """
+        ret = monitor("human-monitor-command", command_line="info numa")
+        out = ret["return"]
+        self.assertTrue(out.startswith("%s nodes" % len(exp)), "Number of "
+                        "nodes is not %s:\n%s" % (len(exp), out))
+        for i in xrange(len(exp)):
+            _exp = "node %s size: %s MB" % (i, exp[i])
+            self.assertIn(_exp, out, "%s is not in 'info numa' output, "
+                          "probably wrong memory size reported:\n%s"
+                          % (_exp, out))
+
+    @staticmethod
+    def _retry_until_timeout(timeout, func, *args, **kwargs):
+        """
+        Repeat the function until it returns anything ignoring AssertionError.
+        After the deadline repeate the function one more time without ignoring
+        timeout.
+        """
+        end = time.time() + timeout
+        while time.time() < end:
+            try:
+                ret = func(*args, **kwargs)
+            except AssertionError:
+                continue
+            break
+        else:
+            ret = func(*args, **kwargs)
+        return ret
+
+    def test_hotplug_mem_into_node(self):
+        console = self.vm.get_console()
+        exp = [256] * 16
+        self.check_mem_monitor(self.vm.qmp, exp)
+        self.check_mem_console(console, exp)
+        cmd = "object_add memory-backend-ram,id=mem2,size=1G"
+        res = self.vm.qmp("human-monitor-command", command_line=cmd)
+        self.assertEqual(res["return"], "")
+        cmd = "device_add pc-dimm,id=dimm2,memdev=mem2"
+        res = self.vm.qmp("human-monitor-command", command_line=cmd)
+        self.assertEqual(res["return"], "")
+        exp = [1280] + [256] * 15
+        self.check_mem_monitor(self.vm.qmp, exp)
+        # Wait up to 10s to propagate the changes
+        self._retry_until_timeout(10, self.check_mem_console, console, exp)
+        cmd = "object_add memory-backend-ram,id=mem8,size=1G"
+        res = self.vm.qmp("human-monitor-command", command_line=cmd)
+        self.assertEqual(res["return"], "")
+        cmd = "device_add pc-dimm,id=dimm8,memdev=mem8,node=13"
+        res = self.vm.qmp("human-monitor-command", command_line=cmd)
+        self.assertEqual(res["return"], "")
+        time.sleep(5)
+        exp = [1280] + [256] * 12 + [1280] + [256] * 2
+        self.check_mem_monitor(self.vm.qmp, exp)
+        # Wait up to 10s to propagate the changes
+        self._retry_until_timeout(10, self.check_mem_console, console, exp)
+        console.close()
+
+    def tearDown(self):
+        self.vm.shutdown()
diff --git a/tests/avocado/test_ovmf_with_240_vcpus.py b/tests/avocado/test_ovmf_with_240_vcpus.py
new file mode 100644
index 0000000000..da688dbc76
--- /dev/null
+++ b/tests/avocado/test_ovmf_with_240_vcpus.py
@@ -0,0 +1,70 @@
+import os
+import shutil
+import sys
+
+from avocado import main
+from avocado_qemu import test
+
+
+class TestOvmfVcpus(test.QemuTest):
+    """
+    Run with:
+
+        avocado run test_ovmf_with_240_vcpus.py \
+        -m test_ovmf_with_240_vcpus.py.data/parameters.yaml
+
+    :avocado: enable
+    :avocado: tags=ovmf
+    """
+
+    def setUp(self):
+        ovmf_code_path = self.params.get('OVMF_CODE',
+                                         default='/usr/share/edk2/ovmf/OVMF_CODE.secboot.fd')
+        ovmf_vars_path = self.params.get('OVMF_VARS',
+                                         default='/usr/share/edk2/ovmf/OVMF_VARS.fd')
+        if not ovmf_code_path or not os.path.exists(ovmf_code_path):
+            basename = os.path.basename(__file__)
+            self.cancel('OVMF_CODE file not found. Set the correct '
+                        'path on "%s.data/parameters.yaml" and run this test '
+                        'with: "avocado run %s -m %s.data/parameters.yaml"' %
+                        (basename, basename, basename))
+        if not ovmf_vars_path or not os.path.exists(ovmf_vars_path):
+            basename = os.path.basename(__file__)
+            self.cancel('OVMF_VARS file not found. Set the correct '
+                        'path on "%s.data/parameters.yaml" and run this test '
+                        'with: "avocado run %s -m %s.data/parameters.yaml"' %
+                        (basename, basename, basename))
+
+        ovmf_vars_tmp = os.path.join(self.workdir,
+                                     os.path.basename(ovmf_vars_path))
+        if not os.path.exists(ovmf_vars_tmp):
+            shutil.copy(ovmf_vars_path, self.workdir)
+
+        self.vm.args.extend(['-drive',
+                             'file=%s,if=pflash,format=raw,readonly=on,unit=0' %
+                             ovmf_code_path])
+        self.vm.args.extend(['-drive',
+                             'file=%s,if=pflash,format=raw,unit=1' %
+                             ovmf_vars_tmp])
+
+        self.vm.args.extend(['-smp', '240'])
+
+    def test_run_vm(self):
+        """
+        According to the RHBZ1447027, the issue is: Guest cannot boot
+        with 240 or above vcpus when using ovmf.
+        Fixed in commit e85c0d14014514a2f0faeae5b4c23fab5b234de4.
+
+        :avocado: tags=RHBZ1447027
+        """
+
+        try:
+            self.vm.launch()
+        except Exception as details:
+            self.fail(details)
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+if __name__ == "__main__":
+    avocado.main()
diff --git a/tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml b/tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml
new file mode 100644
index 0000000000..79f6da1d29
--- /dev/null
+++ b/tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml
@@ -0,0 +1,2 @@
+OVMF_CODE: /usr/share/edk2/ovmf/OVMF_CODE.secboot.fd
+OVMF_VARS: /usr/share/edk2/ovmf/OVMF_VARS.fd
diff --git a/tests/avocado/variants.yaml b/tests/avocado/variants.yaml
new file mode 100644
index 0000000000..6fc689b3ba
--- /dev/null
+++ b/tests/avocado/variants.yaml
@@ -0,0 +1,62 @@
+architecture: !mux
+    # Set the architecture of the qemu binary to execute tests
+    # with. This setting has no effect if you're using custom
+    # qemu_bin configuration.
+    x86_64:
+        arch: x86_64
+    aarch64:
+        arch: aarch64
+    alpha:
+        arch: alpha
+    arm:
+        arch: arm
+    cris:
+        arch: cris
+    i386:
+        arch: i386
+    lm32:
+        arch: lm32
+    m68k:
+        arch: m68k
+    microblazeel:
+        arch: microblazeel
+    microblaze:
+        arch: microblaze
+    mips64el:
+        arch: mips64el
+    mips64:
+        arch: mips64
+    mipsel:
+        arch: mipsel
+    mips:
+        arch: mips
+    moxie:
+        arch: moxie
+    nios2:
+        arch: nios2
+    or1k:
+        arch: or1k
+    ppc64:
+        arch: ppc64
+    ppcemb:
+        arch: ppcemb
+    ppc:
+        arch: ppc
+    s390x:
+        arch: s390x
+    sh4eb:
+        arch: sh4eb
+    sh4:
+        arch: sh4
+    sparc64:
+        arch: sparc64
+    sparc:
+        arch: sparc
+    tricore:
+        arch: tricore
+    unicore32:
+        arch: unicore32
+    xtensaeb:
+        arch: xtensaeb
+    xtensa:
+        arch: xtensa
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b25d48a91b..a2e4f03743 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -293,18 +293,18 @@ class VM(qtest.QEMUQtestMachine):
         self._num_drives = 0
 
     def add_object(self, opts):
-        self._args.append('-object')
-        self._args.append(opts)
+        self.args.append('-object')
+        self.args.append(opts)
         return self
 
     def add_device(self, opts):
-        self._args.append('-device')
-        self._args.append(opts)
+        self.args.append('-device')
+        self.args.append(opts)
         return self
 
     def add_drive_raw(self, opts):
-        self._args.append('-drive')
-        self._args.append(opts)
+        self.args.append('-drive')
+        self.args.append(opts)
         return self
 
     def add_drive(self, path, opts='', interface='virtio', format=imgfmt):
@@ -322,27 +322,27 @@ class VM(qtest.QEMUQtestMachine):
 
         if format == 'luks' and 'key-secret' not in opts:
             # default luks support
-            if luks_default_secret_object not in self._args:
+            if luks_default_secret_object not in self.args:
                 self.add_object(luks_default_secret_object)
 
             options.append(luks_default_key_secret_opt)
 
-        self._args.append('-drive')
-        self._args.append(','.join(options))
+        self.args.append('-drive')
+        self.args.append(','.join(options))
         self._num_drives += 1
         return self
 
     def add_blockdev(self, opts):
-        self._args.append('-blockdev')
+        self.args.append('-blockdev')
         if isinstance(opts, str):
-            self._args.append(opts)
+            self.args.append(opts)
         else:
-            self._args.append(','.join(opts))
+            self.args.append(','.join(opts))
         return self
 
     def add_incoming(self, addr):
-        self._args.append('-incoming')
-        self._args.append(addr)
+        self.args.append('-incoming')
+        self.args.append(addr)
         return self
 
     def pause_drive(self, drive, event=None):
-- 
2.17.0
