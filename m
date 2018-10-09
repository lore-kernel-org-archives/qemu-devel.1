Received: from eggs.gnu.org ([2001:4830:134:3::10]:35995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OX-0003NC-Iz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OW-0000or-9N
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OV-0000lO-Uz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:28 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:04 -0400
Message-Id: <20181009232607.15521-5-crosa@redhat.com>
In-Reply-To: <20181009232607.15521-1-crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/7] scripts/qemu.py: set predefined machine
 type based on arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Some targets require a machine type to be set, as there's no default
(aarch64 is one example).  To give a consistent interface to users of
this API, this changes set_machine() so that a predefined default can
be used, if one is not given.  The approach used is exactly the same
with the console device type.

Also, even when there's a default machine type, for some purposes,
testing included, it's better if outside code is explicit about the
machine type, instead of relying on whatever is set internally.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index d9e24a0c1a..fca9b76990 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES = {
     r'^s390-ccw-virtio.*': 'sclpconsole',
     }
 
+#: Maps archictures to the preferred machine type
+MACHINE_TYPES = {
+    r'^aarch64$': 'virt',
+    r'^ppc$': 'g3beige',
+    r'^ppc64$': 'pseries',
+    r'^s390x$': 's390-ccw-virtio',
+    r'^x86_64$': 'q35',
+    }
+
 
 class QEMUMachineError(Exception):
     """
@@ -413,13 +422,24 @@ class QEMUMachine(object):
         """
         self._arch = arch
 
-    def set_machine(self, machine_type):
+    def set_machine(self, machine_type=None):
         '''
         Sets the machine type
 
         If set, the machine type will be added to the base arguments
         of the resulting QEMU command line.
         '''
+        if machine_type is None:
+            if self._arch is None:
+                raise QEMUMachineError("Can not set a default machine type: "
+                                       "QEMU instance without a defined arch")
+            for regex, machine in MACHINE_TYPES.items():
+                if re.match(regex, self._arch):
+                    machine_type = machine
+                    break
+            if machine_type is None:
+                raise QEMUMachineError("Can not set a machine type: no "
+                                       "matching machine type definition")
         self._machine = machine_type
 
     def set_console(self, device_type=None):
-- 
2.17.1
