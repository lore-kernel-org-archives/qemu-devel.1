Received: from eggs.gnu.org ([2001:4830:134:3::10]:39845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahF-0007UQ-2K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahC-00070V-Rq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9ahC-0006z0-IW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:48 -0300
Message-Id: <20180420181951.7252-22-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 21/24] avocado_qemu: Introduce the add_image() VM
 API
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

Uses can not add an image to the virtual machine with the option to
configure the user/password using cloudinit.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/README.rst           |   4 +-
 tests/avocado/avocado_qemu/test.py | 136 ++++++++++++++++++++++++++-----------
 tests/avocado/parameters.yaml      |   9 ---
 tests/avocado/test_nec-usb-xhci.py |  14 ++--
 tests/avocado/test_numa_hotplug.py |   5 +-
 5 files changed, 111 insertions(+), 57 deletions(-)

diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
index e2aa993501..a33c4a2577 100644
--- a/tests/avocado/README.rst
+++ b/tests/avocado/README.rst
@@ -78,8 +78,8 @@ file using the Avocado parameters system:
   ``image_snapshot`` parameter.
 - ``image_user`` and ``image_pass``: When using a ``image_path``, if you
   want to get the console from the Guest OS you have to define the Guest
-  OS credentials. Example: ``image_user: root`` and
-  ``image_pass: p4ssw0rd``. By default it uses ``root`` and ``123456``.
+  OS credentials. Example: ``image_user: avocado`` and
+  ``image_pass: p4ssw0rd``. Both parameters have defaults to ``avocado``.
 - ``machine_type``: Use this option to define a machine type for the VM.
   Example: ``machine_type: pc``
 - ``machine_accel``: Use this option to define a machine acceleration
diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index 308fdfa514..5a08dace45 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -28,6 +28,7 @@ import logging
 import os
 import re
 import sys
+import tempfile
 import time
 import uuid
 
@@ -81,6 +82,12 @@ class QEMUMigrationError(Exception):
     """
 
 
+class QEMUCloudinitError(Exception):
+    """
+    If some error with the cloudinit happens
+    """
+
+
 def _get_qemu_bin(arch):
     git_root = process.system_output('git rev-parse --show-toplevel',
                                      ignore_status=True,
@@ -219,8 +226,8 @@ def _handle_prompts(session, username, password, prompt, timeout=60,
 class _VM(qemu.QEMUMachine):
     '''A QEMU VM'''
 
-    def __init__(self, qemu_bin=None, arch=None, username=None, password=None,
-                 qemu_dst_bin=None):
+    def __init__(self, qemu_bin=None, arch=None, qemu_dst_bin=None,
+                 username=None, password=None):
         if arch is None:
             arch = os.uname()[4]
         self.arch = arch
@@ -245,8 +252,11 @@ class _VM(qemu.QEMUMachine):
         :param prompt: The regex to identify we reached the prompt.
         """
 
+        if not all((self.username, self.password)):
+            raise QEMULoginError('Username or password not set.')
+
         if not self.is_running():
-            raise QEMUConsoleError('VM is not running.')
+            raise QEMULoginError('VM is not running.')
 
         if console_address is None:
             if self._console_address is None:
@@ -285,9 +295,12 @@ class _VM(qemu.QEMUMachine):
             return False
 
         port = self.ports.find_free_port()
-        newvm = _VM(self.qemu_dst_bin, self._arch, self.username, self.password)
+        newvm = _VM(self.qemu_dst_bin, self._arch, username=self.username,
+                    password=self.password)
         newvm.args = self.args
         newvm.args.extend(['-incoming', 'tcp:0:%s' % port])
+        newvm.username = self.username
+        newvm.password = self.password
 
         newvm.launch(console_address)
         cmd = 'migrate -d tcp:0:%s' % port
@@ -301,6 +314,80 @@ class _VM(qemu.QEMUMachine):
 
         return newvm
 
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
 
 class QemuTest(Test):
 
@@ -311,9 +398,11 @@ class QemuTest(Test):
                                        job=job, runner_queue=runner_queue)
         self.vm = _VM(qemu_bin=self.params.get('qemu_bin'),
                       arch=self.params.get('arch'),
-                      username=self.params.get('image_user', default="root"),
-                      password=self.params.get('image_pass', default="123456"),
-                      qemu_dst_bin=self.params.get('qemu_dst_bin'))
+                      qemu_dst_bin=self.params.get('qemu_dst_bin'),
+                      username=self.params.get('image_user',
+                                               default='avocado'),
+                      password=self.params.get('image_pass',
+                                               default='avocado'))
 
         machine_type = self.params.get('machine_type')
         machine_accel = self.params.get('machine_accel')
@@ -327,36 +416,3 @@ class QemuTest(Test):
             machine += "kvm-type=%s," % machine_kvm_type
         if machine:
             self.vm.args.extend(['-machine', machine])
-
-    def request_image(self, path=None, snapshot=None, extra=None):
-        """
-        Add image to the `self.vm` using params or arguments.
-
-        Unless it's overridden by arguments it uses following test params
-        to specify the image:
-
-        * image_path - defines the path to the user-image. If not specified
-                       it uses "QEMU_ROOT/boot_image_$arch.qcow2"
-        * image_snapshot - whether to use "snapshot=on" (snapshot=off is not
-                           supplied)
-        * image_extra - free-form string to extend the "-drive" params
-
-        :param path: Override the path ("image_path" param is used otherwise)
-        :param snapshot: Override the usage of snapshot
-        :param extra: Extra arguments to be added to drive definition
-        """
-        if snapshot is None:
-            snapshot = self.params.get("image_snapshot", default=True)
-        if extra is None:
-            extra = self.params.get("image_extra", default="")
-        if path is None:
-            path = self.params.get("image_path")
-            if path is None:
-                arch = self.vm.arch
-                path = os.path.join(QEMU_ROOT, "boot_image_%s.qcow2" % arch)
-        if not os.path.exists(path):
-            self.error("Require a bootable image, which was not found. "
-                       "Please provide one in '%s'." % path)
-        if snapshot:
-            extra += ",snapshot=on"
-        self.vm.args.extend(['-drive', 'file=%s%s' % (path, extra)])
diff --git a/tests/avocado/parameters.yaml b/tests/avocado/parameters.yaml
index 3c5a0f92e0..03c4ed1416 100644
--- a/tests/avocado/parameters.yaml
+++ b/tests/avocado/parameters.yaml
@@ -10,15 +10,6 @@ qemu_bin: null
 # used in the source VM will be used for the destination VM.
 qemu_dst_bin: null
 
-# VMs are defined without image. If the 'image_path' is specified, it
-# will be used as the VM image. The '-snapshot' option will then be used
-# to avoid writing data to the image.
-image_path: null
-# Username used to get the console from the Guest OS.
-image_user: null
-# Password used to get the console from the Guest OS.
-image_pass: null
-
 # Use this option to define a machine type for the VM.
 machine_type: null
 # Use this option to define a machine acceleration for the VM.
diff --git a/tests/avocado/test_nec-usb-xhci.py b/tests/avocado/test_nec-usb-xhci.py
index 3f0d645032..1c4822544e 100644
--- a/tests/avocado/test_nec-usb-xhci.py
+++ b/tests/avocado/test_nec-usb-xhci.py
@@ -4,6 +4,7 @@ import tempfile
 
 from avocado_qemu import test
 from avocado.utils import process
+from avocado.utils import vmimage
 
 class TestNecUsbXhci(test.QemuTest):
     """
@@ -17,8 +18,10 @@ class TestNecUsbXhci(test.QemuTest):
     """
 
     def setUp(self):
+        self.image = vmimage.get()
+        self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
+
         usbdevice = os.path.join(self.workdir, 'usb.img')
-        self.request_image()
         process.run('dd if=/dev/zero of=%s bs=1M count=10' % usbdevice)
         self.vm.args.extend(['-device', 'pci-bridge,id=bridge1,chassis_nr=1'])
         self.vm.args.extend(['-device', 'nec-usb-xhci,id=xhci1,bus=bridge1,addr=0x3'])
@@ -35,17 +38,18 @@ class TestNecUsbXhci(test.QemuTest):
 
         :avocado: tags=migration,RHBZ1436616
         """
+
         console = self.vm.get_console()
-        console.sendline('fdisk -l')
-        result = console.read_nonblocking()
+        console.sendline('sudo fdisk -l')
+        result = console.read_up_to_prompt()
         console.close()
         self.assertIn('Disk /dev/sdb: 10 MiB, 10485760 bytes, 20480 sectors',
                       result)
 
         self.vm_dst = self.vm.migrate()
         console = self.vm_dst.get_console()
-        console.sendline('fdisk -l')
-        result = console.read_nonblocking()
+        console.sendline('sudo fdisk -l')
+        result = console.read_up_to_prompt()
         console.close()
         self.assertIn('Disk /dev/sdb: 10 MiB, 10485760 bytes, 20480 sectors',
                       result)
diff --git a/tests/avocado/test_numa_hotplug.py b/tests/avocado/test_numa_hotplug.py
index a99b8dcebf..ee43e60089 100644
--- a/tests/avocado/test_numa_hotplug.py
+++ b/tests/avocado/test_numa_hotplug.py
@@ -2,6 +2,7 @@ import re
 import time
 
 from avocado_qemu import test
+from avocado.utils import vmimage
 
 
 class TestNumaHotplug(test.QemuTest):
@@ -20,7 +21,9 @@ class TestNumaHotplug(test.QemuTest):
     """
 
     def setUp(self):
-        self.request_image()
+        self.image = vmimage.get()
+        self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
+
         self.vm.args.extend(["-m", "4G,slots=208,maxmem=80G"])
         self.vm.args.extend(["-numa", "node"] * 16)
         self.vm.launch()
-- 
2.14.3
