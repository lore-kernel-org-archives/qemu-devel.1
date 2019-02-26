Received: from eggs.gnu.org ([209.51.188.92]:53043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyfKY-0005FT-9K
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyfKX-0006Pe-5c
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:11:42 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 26 Feb 2019 19:11:35 +0300
Message-Id: <1551197495-24425-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3] iotests: handle TypeError for Python 3 in
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
Cc: eblake@redhat.com, nsoffer@redhat.com, mreitz@redhat.com, kwolf@redhat.com, ehabkost@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The data type for bytes in Python 3 differs from the one in Python 2.
The type cast that is compatible with both versions was applied.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reported-by: Kevin Wolf <kwolf@redhat.com>
---
v2:
The TypeError in Python 3 was handled based on the version check.
Discussed in the e-mail thread with the Message ID:
<1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>

v1:
The TypeError in Python 3 was handled as the exception.
Discussed in the e-mail thread with the Message ID:
<1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>

 tests/qemu-iotests/242 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 16c65ed..c176e92 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -20,6 +20,7 @@
 
 import iotests
 import json
+import struct
 from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
     file_path, img_info_log, log, filter_qemu_io
 
@@ -64,10 +65,11 @@ def write_to_disk(offset, size):
 def toggle_flag(offset):
     with open(disk, "r+b") as f:
         f.seek(offset, 0)
-        c = f.read(1)
-        toggled = chr(ord(c) ^ bitmap_flag_unknown)
+        # Read one byte in a way compatible with Python 2
+        flags = struct.unpack("B", f.read(1))
+        toggled = flags[0] ^ bitmap_flag_unknown
         f.seek(-1, 1)
-        f.write(toggled)
+        f.write(struct.pack("B", toggled))
 
 
 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
-- 
1.8.3.1
