Received: from eggs.gnu.org ([2001:4830:134:3::10]:54649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nanjekyejoannah@gmail.com>) id 1eBkOt-0005Hz-9f
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nanjekyejoannah@gmail.com>) id 1eBkOq-0002GD-1O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:37:27 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:53274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nanjekyejoannah@gmail.com>)
	id 1eBkOp-0002Fc-RB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:37:23 -0500
Received: by mail-wr0-x242.google.com with SMTP id u40so9159208wrf.10
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 08:37:23 -0800 (PST)
From: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Date: Mon,  6 Nov 2017 19:35:55 +0300
Message-Id: <1509986155-4735-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: [Qemu-devel] [RFC PATCH] remove numpy dependency
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

Users tend to hit an ImportError when running analyze-migration.py due
to the numpy dependency.  numpy functionality isn't actually used, just
binary serialization that the standard library 'struct' module already
provides.  Removing the dependency allows the script to run
out-of-the-box.

Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
---
 scripts/analyze-migration.py | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 1455387..6175c99 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -17,7 +17,6 @@
 # You should have received a copy of the GNU Lesser General Public
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 
-import numpy as np
 import json
 import os
 import argparse
@@ -36,23 +35,29 @@ class MigrationFile(object):
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
+        read_format = str(len) + 'd'
         if len is None:
             len = self.read8()
         if len == 0:
             return ""
-        return np.fromfile(self.file, count=1, dtype=('S%d' % len))[0]
+        buffer = file.read(8)
+        return struct.unpack(read_format, buffer[0:(0 + struct.calcsize(read_format))])
 
     def readvar(self, size = None):
         if size is None:
@@ -303,8 +308,10 @@ class VMSDFieldInt(VMSDFieldGeneric):
 
     def read(self):
         super(VMSDFieldInt, self).read()
-        self.sdata = np.fromstring(self.data, count=1, dtype=(self.sdtype))[0]
-        self.udata = np.fromstring(self.data, count=1, dtype=(self.udtype))[0]
+        buffer = file.read(self.data)
+        read_format = self.sdtype
+        self.sdata = struct.unpack(self.sdtype, buffer[0:(0 + struct.calcsize(self.sdtype))])
+        self.sdata = struct.unpack(self.udtype, buffer[0:(0 + struct.calcsize(self.udtype))])
         self.data = self.sdata
         return self.data
 
-- 
2.7.4
