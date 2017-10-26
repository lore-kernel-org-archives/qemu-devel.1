Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nanjekyejoannah@gmail.com>) id 1e7h3k-0000Gx-1e
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nanjekyejoannah@gmail.com>) id 1e7h3f-0007Cj-AZ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:14:52 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:45778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nanjekyejoannah@gmail.com>)
	id 1e7h3f-0007Bx-3L
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:14:47 -0400
Received: by mail-wm0-x241.google.com with SMTP id q124so7592221wmb.0
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 05:14:46 -0700 (PDT)
From: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Date: Thu, 26 Oct 2017 15:14:14 +0300
Message-Id: <1509020054-25434-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: [Qemu-devel] [PATCH WIP] replace numpy with struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: qemu-devel@nongnu.org, Joannah Nanjekye <nanjekyejoannah@gmail.com>

This patch replaces the use of numpy with the standard Library struct module where possible.

Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
---
 
 scripts/analyze-migration.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 1455387..f421012 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -36,23 +36,28 @@ class MigrationFile(object):
         self.file = open(self.filename, "rb")
 
     def read64(self):
-        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i8')[0])
+        buffer = file.read(64)
+        return struct.unpack('>i16', buffer)[0]
 
     def read32(self):
-        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i4')[0])
+        buffer = file.read(32)
+        return struct.unpack('>i8', buffer)[0]
 
     def read16(self):
-        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i2')[0])
+        buffer = file.read(16)
+        return struct.unpack('>i4', buffer)[0]
 
     def read8(self):
-        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i1')[0])
+        buffer = file.read(8)
+        return struct.unpack('>i2', buffer)[0]
 
     def readstr(self, len = None):
+        buffer = file.read(8)
         if len is None:
             len = self.read8()
         if len == 0:
             return ""
-        return np.fromfile(self.file, count=1, dtype=('S%d' % len))[0]
+        return np.array(struct.unpack(str(len) + 'd', buffer)[0])
 
     def readvar(self, size = None):
         if size is None:
@@ -303,8 +308,8 @@ class VMSDFieldInt(VMSDFieldGeneric):
 
     def read(self):
         super(VMSDFieldInt, self).read()
-        self.sdata = np.fromstring(self.data, count=1, dtype=(self.sdtype))[0]
-        self.udata = np.fromstring(self.data, count=1, dtype=(self.udtype))[0]
+        self.sdata = np.array(struct.unpack(self.sdtype, self.data)[0])
+        self.udata = np.array(struct.unpack(self.udtype, self.data)[0])
         self.data = self.sdata
         return self.data
 
-- 
2.7.4
