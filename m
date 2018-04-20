Received: from eggs.gnu.org ([2001:4830:134:3::10]:37527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aeJ-0004q1-6L
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aeF-0005Zs-8w
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9aeE-0005Y9-UC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:29 -0300
Message-Id: <20180420181951.7252-3-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 02/24] Introduce the basic framework to run
 Avocado tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Amador Pahim <apahim@redhat.com>

Avocado Testing Framework can help with functional tests in
qemu development process. This patch creates the basic infrastructure
to use with Avocado tests. It contains:

- A README file with the initial documentation.
- The test module which inherits from avocado.Test and adds a VM object,
  created from scripts/qemu.py module. The QemuTest class is the test
  API for the actual Qemu tests to inherit from.
- A parameters yaml file with the supported keys.
- A variants yaml file with the Qemu supported architectures.

After this commit, you can expect a series of real-world tests, written
using this new framework.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py                        |  12 +-
 tests/avocado/README.rst               | 111 ++++++++++
 tests/avocado/avocado_qemu/__init__.py |   0
 tests/avocado/avocado_qemu/test.py     | 365 +++++++++++++++++++++++++++++++++
 tests/avocado/parameters.yaml          |  28 +++
 tests/avocado/variants.yaml            |  62 ++++++
 tests/qemu-iotests/iotests.py          |  28 +--
 7 files changed, 586 insertions(+), 20 deletions(-)
 create mode 100644 tests/avocado/README.rst
 create mode 100644 tests/avocado/avocado_qemu/__init__.py
 create mode 100644 tests/avocado/avocado_qemu/test.py
 create mode 100644 tests/avocado/parameters.yaml
 create mode 100644 tests/avocado/variants.yaml

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9e9d502543..bd66620f45 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -81,7 +81,7 @@ class QEMUMachine(object):
         self._qemu_log_file = None
         self._popen = None
         self._binary = binary
-        self._args = list(args)     # Force copy args in case we modify them
+        self.args = list(args)     # Force copy args in case we modify them
         self._wrapper = wrapper
         self._events = []
         self._iolog = None
@@ -109,8 +109,8 @@ class QEMUMachine(object):
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
         args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
-        self._args.append('-monitor')
-        self._args.append(args)
+        self.args.append('-monitor')
+        self.args.append(args)
 
     def add_fd(self, fd, fdset, opaque, opts=''):
         '''Pass a file descriptor to the VM'''
@@ -120,8 +120,8 @@ class QEMUMachine(object):
         if opts:
             options.append(opts)
 
-        self._args.append('-add-fd')
-        self._args.append(','.join(options))
+        self.args.append('-add-fd')
+        self.args.append(','.join(options))
         return self
 
     def send_fd_scm(self, fd_file_path):
@@ -184,7 +184,7 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
 
     def _create_console(self, console_address):
-        for item in self._args:
+        for item in self.args:
             for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
                 if option in item:
                     return []
diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
new file mode 100644
index 0000000000..f0e703fe06
--- /dev/null
+++ b/tests/avocado/README.rst
@@ -0,0 +1,111 @@
+This directory is hosting functional tests written using Avocado Testing
+Framework. To install Avocado, follow the instructions from this link::
+
+    http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
+
+Tests here are written keeping the minimum amount of dependencies. To
+run the tests, you need the Avocado core package (`python-avocado` on
+Fedora, `avocado-framework` on pip). Extra dependencies should be
+documented in this file.
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
+- ``image_path``: VMs are defined without image. If the ``image_path``
+  is specified, it will be used as the VM image. The ``-snapshot``
+  option will then be used to avoid writing into the image. Example:
+  ``image_path: /var/lib/images/fedora-25.img``
+- ``image_user`` and ``image_pass``: When using a ``image_path``, if you
+  want to get the console from the Guest OS you have to define the Guest
+  OS credentials. Example: ``image_user: root`` and
+  ``image_pass: p4ssw0rd``
+- ``machine_type``: Use this option to define a machine type for the VM.
+  Example: ``machine_type: pc``
+- ``machine_accel``: Use this option to define a machine acceleration
+  for the VM. Example: ``machine_accel: kvm``.
+- ``machine_kvm_type``: Use this option to select the KVM type when the
+  ``accel`` is ``kvm`` and there are more than one KVM types available.
+  Example: ``machine_kvm_type: PR``
+
+To use a parameters file, you have to install the yaml_to_mux plugin
+(`python2-avocado-plugins-varianter-yaml-to-mux` on Fedora,
+`avocado-framework-plugin-varianter-yaml-to-mux` on pip).
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
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
new file mode 100644
index 0000000000..e74de97a3e
--- /dev/null
+++ b/tests/avocado/avocado_qemu/test.py
@@ -0,0 +1,365 @@
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
+import sys
+import time
+import uuid
+
+import aexpect
+
+from avocado import Test
+from avocado.utils.data_structures import Borg
+from avocado.utils import network
+from avocado.utils import process
+from avocado.utils import path as utils_path
+from avocado.utils import wait
+sys.path.append(os.path.join(os.path.dirname(__file__),
+                             '..', '..', '..', 'scripts'))
+import qemu
+
+
+class QEMULoginTimeoutError(Exception):
+    """
+    If timeout expires
+    """
+    pass
+
+
+class QEMULoginAuthenticationError(Exception):
+    """
+    If authentication fails
+    """
+    pass
+
+
+class QEMULoginProcessTerminatedError(Exception):
+    """
+    If the client terminates during login
+    """
+    pass
+
+
+class QEMULoginError(Exception):
+    """
+    If some other error occurs
+    """
+    pass
+
+
+class QEMUConsoleError(Exception):
+    """
+    If some error with the console access happens
+    """
+    pass
+
+
+class QEMUMigrationError(Exception):
+    """
+    If some error with the migration happens
+    """
+    pass
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
+def _handle_prompts(session, username, password, prompt, timeout=10,
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
+    password_prompt_count = 0
+    login_prompt_count = 0
+    last_chance = False
+
+    output = ""
+    while True:
+        try:
+            match, text = session.read_until_last_line_matches(
+                [r"[Aa]re you sure", r"[Pp]assword:\s*",
+                 # Prompt of rescue mode for Red Hat.
+                 r"\(or (press|type) Control-D to continue\):\s*$",
+                 r"[Gg]ive.*[Ll]ogin:\s*$",  # Prompt of rescue mode for SUSE.
+                 r"(?<![Ll]ast )[Ll]ogin:\s*$",  # Don't match "Last Login:"
+                 r"[Cc]onnection.*closed", r"[Cc]onnection.*refused",
+                 r"[Pp]lease wait", r"[Ww]arning", r"[Ee]nter.*username",
+                 r"[Ee]nter.*password", r"[Cc]onnection timed out", prompt,
+                 r"Escape character is.*"],
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
+class _PortTracker(Borg):
+
+    """
+    Tracks ports used in the host machine.
+    """
+
+    def __init__(self):
+        Borg.__init__(self)
+        self.address = 'localhost'
+        self.start_port = 5000
+        if not hasattr(self, 'retained_ports'):
+            self._reset_retained_ports()
+
+    def __str__(self):
+        return 'Ports tracked: %r' % self.retained_ports
+
+    def _reset_retained_ports(self):
+        self.retained_ports = []
+
+    def register_port(self, port):
+        if ((port not in self.retained_ports) and
+                (network.is_port_free(port, self.address))):
+            self.retained_ports.append(port)
+        else:
+            raise ValueError('Port %d in use' % port)
+        return port
+
+    def find_free_port(self, start_port=None):
+        if start_port is None:
+            start_port = self.start_port
+        port = start_port
+        while ((port in self.retained_ports) or
+               (not network.is_port_free(port, self.address))):
+            port += 1
+        self.retained_ports.append(port)
+        return port
+
+    def release_port(self, port):
+        if port in self.retained:
+            self.retained.remove(port)
+
+
+class _VM(qemu.QEMUMachine):
+    '''A QEMU VM'''
+
+    def __init__(self, qemu_bin=None, arch=None, username=None, password=None,
+                 qemu_dst_bin=None):
+        if arch is None:
+            arch = os.uname()[4]
+        self.ports = _PortTracker()
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
+
+    def get_console(self, console_address=None, prompt="[\#\$]"):
+        """
+        :param address: Socket address, can be either a unix socket path
+                        (string) or a tuple in the form (address, port)
+                        for a TCP connection
+        :param prompt: The regex to identify we reached the prompt.
+        """
+
+        if not self.is_running():
+            raise QEMUConsoleError('VM is not running.')
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
+            _handle_prompts(console, self.username, self.password, "[\#\$]")
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
+                raise QEMUMigrateError("Migration of %s failed" % self)
+            return False
+
+        port = self.ports.find_free_port()
+        newvm = _VM(self.qemu_dst_bin, self._arch, self.username, self.password)
+        newvm.args = self.args
+        newvm.args.extend(['-incoming', 'tcp:0:%s' % port])
+
+        newvm.launch(console_address)
+        cmd = 'migrate -d tcp:0:%s' % port
+        self.qmp('human-monitor-command', command_line=cmd)
+        mig_result = wait.wait_for(migrate_complete, timeout=timeout,
+                                   text='Waiting for migration to complete')
+
+        if mig_result is None:
+            raise QEMUMigrateError("Migration of %s did not complete after "
+                                   "%s s" % (self.name, timeout))
+
+        return newvm
+
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
+                      username=self.params.get('image_user'),
+                      password=self.params.get('image_pass'),
+                      qemu_dst_bin=self.params.get('qemu_dst_bin'))
+
+        self.vm.image = self.params.get('image_path')
+        if self.vm.image is not None:
+            self.vm.args.extend(['-drive', 'file=%s' % self.vm.image])
+            self.vm.args.append('-snapshot')
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
index 0000000000..3c5a0f92e0
--- /dev/null
+++ b/tests/avocado/parameters.yaml
@@ -0,0 +1,28 @@
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
+# VMs are defined without image. If the 'image_path' is specified, it
+# will be used as the VM image. The '-snapshot' option will then be used
+# to avoid writing data to the image.
+image_path: null
+# Username used to get the console from the Guest OS.
+image_user: null
+# Password used to get the console from the Guest OS.
+image_pass: null
+
+# Use this option to define a machine type for the VM.
+machine_type: null
+# Use this option to define a machine acceleration for the VM.
+machine_accel: null
+# Use this option to select the KVM type when the 'machine_accel' is set
+# to 'kvm' and there are more than one KVM types available.
+machine_kvm_type: null
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
2.14.3
