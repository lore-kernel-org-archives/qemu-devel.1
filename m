Received: from eggs.gnu.org ([209.51.188.92]:37871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHJ-00042z-NC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHH-0006xs-WA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHH-0006x6-OR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:23 -0300
Message-Id: <20190503004130.8285-13-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/19] scripts/qemu.py: support adding a console
 with the default serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

The set_console() utility function either adds a device based on the
explicitly given device type, or adds a known good type of device
based on the machine type.

But, for a number of machine types, it may be impossible or
inconvenient to add the devices by means of "-device" command line
options, and then it may better to just use the "-serial" option and
let QEMU itself, based on the machine type, set the device
accordingly.

To achieve that, the behavior of set_console() now flags the intention
to add a console device on launch(), and if no explicit device type is
given the "-serial" option is going to be added to the QEMU command
line, instead of raising exceptions.

Based on testing with different machine types, the CONSOLE_DEV_TYPES
is not necessary anymore, so it's being removed, as is the logic to
use it.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-13-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 python/qemu/__init__.py | 50 ++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index fd144c0006..81d9657ec0 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -41,17 +41,6 @@ def kvm_available(target_arch=None):
     return os.access("/dev/kvm", os.R_OK | os.W_OK)
 
 
-#: Maps machine types to the preferred console device types
-CONSOLE_DEV_TYPES = {
-    r'^clipper$': 'isa-serial',
-    r'^malta': 'isa-serial',
-    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
-    r'^(40p|powernv|prep)$': 'isa-serial',
-    r'^pseries.*': 'spapr-vty',
-    r'^s390-ccw-virtio.*': 'sclpconsole',
-    }
-
-
 class QEMUMachineError(Exception):
     """
     Exception called when an error in QEMUMachine happens.
@@ -130,6 +119,7 @@ class QEMUMachine(object):
         self._temp_dir = None
         self._launched = False
         self._machine = None
+        self._console_set = False
         self._console_device_type = None
         self._console_address = None
         self._console_socket = None
@@ -248,13 +238,17 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
         if self._machine is not None:
             args.extend(['-machine', self._machine])
-        if self._console_device_type is not None:
+        if self._console_set:
             self._console_address = os.path.join(self._temp_dir,
                                                  self._name + "-console.sock")
             chardev = ('socket,id=console,path=%s,server,nowait' %
                        self._console_address)
-            device = '%s,chardev=console' % self._console_device_type
-            args.extend(['-chardev', chardev, '-device', device])
+            args.extend(['-chardev', chardev])
+            if self._console_device_type is None:
+                args.extend(['-serial', 'chardev:console'])
+            else:
+                device = '%s,chardev=console' % self._console_device_type
+                args.extend(['-device', device])
         return args
 
     def _pre_launch(self):
@@ -480,30 +474,20 @@ class QEMUMachine(object):
         line.
 
         This is a convenience method that will either use the provided
-        device type, of if not given, it will used the device type set
-        on CONSOLE_DEV_TYPES.
+        device type, or default to a "-serial chardev:console" command
+        line argument.
 
         The actual setting of command line arguments will be be done at
         machine launch time, as it depends on the temporary directory
         to be created.
 
-        @param device_type: the device type, such as "isa-serial"
-        @raises: QEMUMachineAddDeviceError if the device type is not given
-                 and can not be determined.
-        """
-        if device_type is None:
-            if self._machine is None:
-                raise QEMUMachineAddDeviceError("Can not add a console device:"
-                                                " QEMU instance without a "
-                                                "defined machine type")
-            for regex, device in CONSOLE_DEV_TYPES.items():
-                if re.match(regex, self._machine):
-                    device_type = device
-                    break
-            if device_type is None:
-                raise QEMUMachineAddDeviceError("Can not add a console device:"
-                                                " no matching console device "
-                                                "type definition")
+        @param device_type: the device type, such as "isa-serial".  If
+                            None is given (the default value) a "-serial
+                            chardev:console" command line argument will
+                            be used instead, resorting to the machine's
+                            default device type.
+        """
+        self._console_set = True
         self._console_device_type = device_type
 
     @property
-- 
2.18.0.rc1.1.g3f1ff2140
