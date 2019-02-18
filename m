Received: from eggs.gnu.org ([209.51.188.92]:35150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gvp58-0006Gm-4I
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gvp57-0007am-Ci
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:00:02 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 18 Feb 2019 22:59:57 +0300
Message-Id: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] iotests: handle TypeError for Python3 in test
 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

To write one byte to disk, Python2 may use 'chr' type.
In Python3, conversion to 'byte' type is required.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/242 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 16c65ed..6b1f7b8 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -65,9 +65,14 @@ def toggle_flag(offset):
     with open(disk, "r+b") as f:
         f.seek(offset, 0)
         c = f.read(1)
-        toggled = chr(ord(c) ^ bitmap_flag_unknown)
+        toggled = ord(c) ^ bitmap_flag_unknown
         f.seek(-1, 1)
-        f.write(toggled)
+        try:
+            # python2
+            f.write(chr(toggled))
+        except TypeError:
+            # python3
+            f.write(bytes([toggled]))
 
 
 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
-- 
1.8.3.1
