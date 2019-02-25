Received: from eggs.gnu.org ([209.51.188.92]:36618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyI3u-0007sT-5h
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyI3o-0000DH-D3
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:20:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Feb 2019 09:20:13 -0600
Message-Id: <20190225152015.26089-2-eblake@redhat.com>
In-Reply-To: <20190225152015.26089-1-eblake@redhat.com>
References: <20190225152015.26089-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] iotests: handle TypeError for Python3 in
 test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The data type for bytes in Python3 differs from the one in Python2.
Those cases should be managed separately.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reported-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/242 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 16c65edcd7f..446fbf8ea13 100755
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
         c =3D f.read(1)
-        toggled =3D chr(ord(c) ^ bitmap_flag_unknown)
+        toggled =3D ord(c) ^ bitmap_flag_unknown
         f.seek(-1, 1)
-        f.write(toggled)
+        if sys.version_info.major >=3D 3:
+            f.write(bytes([toggled]))
+        else:
+            f.write(chr(toggled))


 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
--=20
2.20.1
