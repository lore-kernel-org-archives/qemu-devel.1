Received: from eggs.gnu.org ([209.51.188.92]:35697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gx8z5-0008Nb-3w
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gx8z4-0000l8-80
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:27:15 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri, 22 Feb 2019 14:26:13 +0300
Message-Id: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] iotests: handle TypeError for Python3 in
 test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, crosa@redhat.com, mreitz@redhat.com, kwolf@redhat.com, ehabkost@redhat.com, philmd@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The data type for bytes in Python3 differs from the one in Python2.
Those cases should be managed separately.

v1:
In the first version, the TypeError in Python3 was handled as the
exception.
Discussed in the e-mail thread with the Message ID:
<1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reported-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/242 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 16c65ed..446fbf8 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -20,6 +20,7 @@
 
 import iotests
 import json
+import sys
 from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
     file_path, img_info_log, log, filter_qemu_io
 
@@ -65,9 +66,12 @@ def toggle_flag(offset):
     with open(disk, "r+b") as f:
         f.seek(offset, 0)
         c = f.read(1)
-        toggled = chr(ord(c) ^ bitmap_flag_unknown)
+        toggled = ord(c) ^ bitmap_flag_unknown
         f.seek(-1, 1)
-        f.write(toggled)
+        if sys.version_info.major >= 3:
+            f.write(bytes([toggled]))
+        else:
+            f.write(chr(toggled))
 
 
 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
-- 
1.8.3.1
