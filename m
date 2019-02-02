Received: from eggs.gnu.org ([209.51.188.92]:54763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcT-0002f1-MF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcK-0003To-7x
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:12 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  1 Feb 2019 19:56:03 -0500
Message-Id: <20190202005610.24048-14-crosa@redhat.com>
In-Reply-To: <20190202005610.24048-1-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/20] scripts/qemu.py: support adding a
 console with the default serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

The set_console() utility function traditionally adds a device either
based on the explicitly given device type, or based on the machine type,
a known good type of device.

But, for a number of machine types, it may be impossible or
inconvenient to add the devices my means of "-device" command line
options, and then it may better to just use the "-serial" option and
let QEMU itself, based on the machine type, set the device
accordingly.

To achieve that, the behavior of set_console() now flags the intention
to add a console device on launch(), and if no explicit device type is
given, and there's no definition on CONSOLE_DEV_TYPES, the "-serial"
is going to be added to the QEMU command line, instead of raising
exceptions.

Based on testing with different machine types, the CONSOLE_DEV_TYPES
is now being set to the bare essential entries (one entry to be
honest), for machine types that can not easily give us a working
console with "-serial".

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index eeaab99906..53bdc46ce2 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -34,11 +34,6 @@ def kvm_available(target_arch=3DNone):
=20
 #: Maps machine types to the preferred console device types
 CONSOLE_DEV_TYPES =3D {
-    r'^clipper$': 'isa-serial',
-    r'^malta': 'isa-serial',
-    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
-    r'^(40p|powernv|prep)$': 'isa-serial',
-    r'^pseries.*': 'spapr-vty',
     r'^s390-ccw-virtio.*': 'sclpconsole',
     }
=20
@@ -121,6 +116,7 @@ class QEMUMachine(object):
         self._temp_dir =3D None
         self._launched =3D False
         self._machine =3D None
+        self._console_set =3D False
         self._console_device_type =3D None
         self._console_address =3D None
         self._console_socket =3D None
@@ -240,13 +236,17 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
         if self._machine is not None:
             args.extend(['-machine', self._machine])
-        if self._console_device_type is not None:
+        if self._console_set:
             self._console_address =3D os.path.join(self._temp_dir,
                                                  self._name + "-console.=
sock")
             chardev =3D ('socket,id=3Dconsole,path=3D%s,server,nowait' %
                        self._console_address)
-            device =3D '%s,chardev=3Dconsole' % self._console_device_typ=
e
-            args.extend(['-chardev', chardev, '-device', device])
+            args.extend(['-chardev', chardev])
+            if self._console_device_type is None:
+                args.extend(['-serial', 'chardev:console'])
+            else:
+                device =3D '%s,chardev=3Dconsole' % self._console_device=
_type
+                args.extend(['-device', device])
         return args
=20
     def _pre_launch(self):
@@ -472,30 +472,29 @@ class QEMUMachine(object):
         line.
=20
         This is a convenience method that will either use the provided
-        device type, of if not given, it will used the device type set
-        on CONSOLE_DEV_TYPES.
+        device type, of if not given, it will use the device type set
+        on CONSOLE_DEV_TYPES if a machine type is set, and a matching
+        entry exists on CONSOLE_DEV_TYPES.
=20
         The actual setting of command line arguments will be be done at
         machine launch time, as it depends on the temporary directory
         to be created.
=20
-        @param device_type: the device type, such as "isa-serial"
+        @param device_type: the device type, such as "isa-serial".  If
+                            None is given (the default value) a "-serial
+                            chardev:console" command line argument will
+                            be used instead, resorting to the machine's
+                            default device type, if a machine type is se=
t,
+                            and a matching entry exists on CONSOLE_DEV_T=
YPES.
         @raises: QEMUMachineAddDeviceError if the device type is not giv=
en
                  and can not be determined.
         """
-        if device_type is None:
-            if self._machine is None:
-                raise QEMUMachineAddDeviceError("Can not add a console d=
evice:"
-                                                " QEMU instance without =
a "
-                                                "defined machine type")
+        self._console_set =3D True
+        if device_type is None and self._machine is not None:
             for regex, device in CONSOLE_DEV_TYPES.items():
                 if re.match(regex, self._machine):
                     device_type =3D device
                     break
-            if device_type is None:
-                raise QEMUMachineAddDeviceError("Can not add a console d=
evice:"
-                                                " no matching console de=
vice "
-                                                "type definition")
         self._console_device_type =3D device_type
=20
     @property
--=20
2.20.1
