Received: from eggs.gnu.org ([209.51.188.92]:33053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfw0-0007zH-3u
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfvw-0001Uo-9R
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:22 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 26 Feb 2019 10:50:11 -0600
Message-Id: <20190226165013.24867-2-eblake@redhat.com>
In-Reply-To: <20190226165013.24867-1-eblake@redhat.com>
References: <20190226165013.24867-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/3] iotests: handle TypeError for Python 3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The data type for bytes in Python 3 differs from the one in Python 2.
The type cast that is compatible with both versions was applied.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reported-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1551197495-24425-1-git-send-email-andrey.shinkevich@virtuozz=
o.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/242 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 16c65edcd7f..c176e92da6a 100755
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
-        c =3D f.read(1)
-        toggled =3D chr(ord(c) ^ bitmap_flag_unknown)
+        # Read one byte in a way compatible with Python 2
+        flags =3D struct.unpack("B", f.read(1))
+        toggled =3D flags[0] ^ bitmap_flag_unknown
         f.seek(-1, 1)
-        f.write(toggled)
+        f.write(struct.pack("B", toggled))


 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
--=20
2.20.1
