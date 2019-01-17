Received: from eggs.gnu.org ([209.51.188.92]:42731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqf-00059q-2R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqc-0005sA-St
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:04 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:21 -0500
Message-Id: <20190117185628.21862-12-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/18] scripts/qemu.py: support adding a
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

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

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index ec3567d4e2..88e1608b42 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -121,6 +121,7 @@ class QEMUMachine(object):
         self._temp_dir =3D None
         self._launched =3D False
         self._machine =3D None
+        self._console_set =3D False
         self._console_device_type =3D None
         self._console_address =3D None
         self._console_socket =3D None
@@ -240,13 +241,17 @@ class QEMUMachine(object):
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
@@ -479,23 +484,20 @@ class QEMUMachine(object):
         machine launch time, as it depends on the temporary directory
         to be created.
=20
-        @param device_type: the device type, such as "isa-serial"
+        @param device_type: the device type, such as "isa-serial".  If
+                            None is given (the default value) a "-serial
+                            chardev:console" command line argument will
+                            be used instead, resorting to the machine's
+                            default device type.
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
