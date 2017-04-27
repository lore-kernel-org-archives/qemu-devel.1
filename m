Received: from eggs.gnu.org ([2001:4830:134:3::10]:33653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW1-0007Wb-Mo
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW0-00045j-IE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:41 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:16 -0500
Message-Id: <20170427014626.11553-8-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 07/17] qemu-io: Switch 'alloc' command to
 byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

For the 'alloc' command, accepting an offset in bytes but a length
in sectors, and reporting output in sectors, is confusing.  Do
everything in bytes, and adjust the expected output accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
v10: rebase to code cleanup
v9: new patch
---
 qemu-io-cmds.c                    | 30 ++++++++++++++++++------------
 tests/qemu-iotests/019.out        |  8 ++++----
 tests/qemu-iotests/common.pattern |  2 +-
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index fabc394..34f6707 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1760,7 +1760,7 @@ out:
 static int alloc_f(BlockBackend *blk, int argc, char **argv)
 {
     BlockDriverState *bs =3D blk_bs(blk);
-    int64_t offset, sector_num, nb_sectors, remaining;
+    int64_t offset, sector_num, nb_sectors, remaining, bytes;
     char s1[64];
     int num, ret;
     int64_t sum_alloc;
@@ -1776,18 +1776,24 @@ static int alloc_f(BlockBackend *blk, int argc, c=
har **argv)
     }

     if (argc =3D=3D 3) {
-        nb_sectors =3D cvtnum(argv[2]);
-        if (nb_sectors < 0) {
-            print_cvtnum_err(nb_sectors, argv[2]);
+        bytes =3D cvtnum(argv[2]);
+        if (bytes < 0) {
+            print_cvtnum_err(bytes, argv[2]);
             return 0;
-        } else if (nb_sectors > INT_MAX) {
-            printf("length argument cannot exceed %d, given %s\n",
-                   INT_MAX, argv[2]);
+        } else if (bytes > INT_MAX * BDRV_SECTOR_SIZE) {
+            printf("length argument cannot exceed %llu, given %s\n",
+                   INT_MAX * BDRV_SECTOR_SIZE, argv[2]);
             return 0;
         }
     } else {
-        nb_sectors =3D 1;
+        bytes =3D BDRV_SECTOR_SIZE;
     }
+    if (!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE)) {
+        printf("bytes %" PRId64 " is not sector aligned\n",
+               bytes);
+        return 0;
+    }
+    nb_sectors =3D bytes >> BDRV_SECTOR_BITS;

     remaining =3D nb_sectors;
     sum_alloc =3D 0;
@@ -1811,8 +1817,8 @@ static int alloc_f(BlockBackend *blk, int argc, cha=
r **argv)

     cvtstr(offset, s1, sizeof(s1));

-    printf("%"PRId64"/%"PRId64" sectors allocated at offset %s\n",
-           sum_alloc, nb_sectors, s1);
+    printf("%"PRId64"/%"PRId64" bytes allocated at offset %s\n",
+           sum_alloc << BDRV_SECTOR_BITS, nb_sectors << BDRV_SECTOR_BITS=
, s1);
     return 0;
 }

@@ -1822,8 +1828,8 @@ static const cmdinfo_t alloc_cmd =3D {
     .argmin     =3D 1,
     .argmax     =3D 2,
     .cfunc      =3D alloc_f,
-    .args       =3D "off [sectors]",
-    .oneline    =3D "checks if a sector is present in the file",
+    .args       =3D "offset [bytes]",
+    .oneline    =3D "checks if offset is allocated in the file",
 };


diff --git a/tests/qemu-iotests/019.out b/tests/qemu-iotests/019.out
index 0124264..17a7c03 100644
--- a/tests/qemu-iotests/019.out
+++ b/tests/qemu-iotests/019.out
@@ -542,8 +542,8 @@ Testing conversion with -B TEST_DIR/t.IMGFMT.base

 Checking if backing clusters are allocated when they shouldn't

-0/128 sectors allocated at offset 1 MiB
-0/128 sectors allocated at offset 4.001 GiB
+0/65536 bytes allocated at offset 1 MiB
+0/65536 bytes allocated at offset 4.001 GiB
 Reading

 =3D=3D=3D IO: pattern 42
@@ -1086,8 +1086,8 @@ Testing conversion with -o backing_file=3DTEST_DIR/=
t.IMGFMT.base

 Checking if backing clusters are allocated when they shouldn't

-0/128 sectors allocated at offset 1 MiB
-0/128 sectors allocated at offset 4.001 GiB
+0/65536 bytes allocated at offset 1 MiB
+0/65536 bytes allocated at offset 4.001 GiB
 Reading

 =3D=3D=3D IO: pattern 42
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/commo=
n.pattern
index ddfbca1..34f4a8d 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -18,7 +18,7 @@

 function do_is_allocated() {
     local start=3D$1
-    local size=3D$(( $2 / 512))
+    local size=3D$2
     local step=3D$3
     local count=3D$4

--=20
2.9.3
