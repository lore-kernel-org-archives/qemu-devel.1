Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOd-0006NG-0m
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOa-0007TI-PV
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:38 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Dec 2018 18:52:07 +0100
Message-Id: <20181203175211.8230-3-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-1-mreitz@redhat.com>
References: <20181203175211.8230-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 2/6] qemu-img: Add salvaging mode to
 convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This adds a salvaging mode (--salvage) to qemu-img convert which ignores
read errors and treats the respective areas as containing only zeroes.
This can be used for instance to at least partially recover the data
from terminally corrupted qcow2 images.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c       | 84 +++++++++++++++++++++++++++++++++++++-----------
 qemu-img-cmds.hx |  4 +--
 qemu-img.texi    |  5 +++
 3 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1582ef63f3..395c1973fe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -66,6 +66,7 @@ enum {
     OPTION_SIZE =3D 264,
     OPTION_PREALLOCATION =3D 265,
     OPTION_SHRINK =3D 266,
+    OPTION_SALVAGE =3D 267,
 };
=20
 typedef enum OutputFormat {
@@ -1569,6 +1570,7 @@ typedef struct ImgConvertState {
     int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
     bool copy_range;
+    bool salvage;
     bool quiet;
     int min_sparse;
     int alignment;
@@ -1616,23 +1618,43 @@ static int convert_iteration_sectors(ImgConvertSt=
ate *s, int64_t sector_num)
     }
=20
     if (s->sector_next_status <=3D sector_num) {
-        int64_t count =3D n * BDRV_SECTOR_SIZE;
+        uint64_t offset =3D (sector_num - src_cur_offset) * BDRV_SECTOR_=
SIZE;
+        int64_t count;
=20
-        if (s->target_has_backing) {
+        do {
+            count =3D n * BDRV_SECTOR_SIZE;
+
+            if (s->target_has_backing) {
+                ret =3D bdrv_block_status(blk_bs(s->src[src_cur]), offse=
t,
+                                        count, &count, NULL, NULL);
+            } else {
+                ret =3D bdrv_block_status_above(blk_bs(s->src[src_cur]),=
 NULL,
+                                              offset, count, &count, NUL=
L,
+                                              NULL);
+            }
+
+            if (ret < 0) {
+                if (s->salvage) {
+                    if (n =3D=3D 1) {
+                        if (!s->quiet) {
+                            warn_report("Failed to inquire block status =
of %s "
+                                        "at offset %#" PRIx64 ": %s",
+                                        blk_bs(s->src[src_cur])->filenam=
e,
+                                        offset, strerror(-ret));
+                        }
+                        /* Just try to read the data, then */
+                        ret =3D BDRV_BLOCK_DATA;
+                        count =3D BDRV_SECTOR_SIZE;
+                    } else {
+                        /* Retry on a shorter range */
+                        n =3D DIV_ROUND_UP(n, 4);
+                    }
+                } else {
+                    return ret;
+                }
+            }
+        } while (ret < 0);
=20
-            ret =3D bdrv_block_status(blk_bs(s->src[src_cur]),
-                                    (sector_num - src_cur_offset) *
-                                    BDRV_SECTOR_SIZE,
-                                    count, &count, NULL, NULL);
-        } else {
-            ret =3D bdrv_block_status_above(blk_bs(s->src[src_cur]), NUL=
L,
-                                          (sector_num - src_cur_offset) =
*
-                                          BDRV_SECTOR_SIZE,
-                                          count, &count, NULL, NULL);
-        }
-        if (ret < 0) {
-            return ret;
-        }
         n =3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
=20
         if (ret & BDRV_BLOCK_ZERO) {
@@ -1669,6 +1691,7 @@ static int convert_iteration_sectors(ImgConvertStat=
e *s, int64_t sector_num)
 static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sect=
or_num,
                                         int nb_sectors, uint8_t *buf)
 {
+    uint64_t single_read_until =3D 0;
     int n, ret;
     QEMUIOVector qiov;
     struct iovec iov;
@@ -1678,6 +1701,7 @@ static int coroutine_fn convert_co_read(ImgConvertS=
tate *s, int64_t sector_num,
         BlockBackend *blk;
         int src_cur;
         int64_t bs_sectors, src_cur_offset;
+        uint64_t offset;
=20
         /* In the case of compression with multiple source files, we can=
 get a
          * nb_sectors that spreads into the next part. So we must be abl=
e to
@@ -1686,16 +1710,34 @@ static int coroutine_fn convert_co_read(ImgConver=
tState *s, int64_t sector_num,
         blk =3D s->src[src_cur];
         bs_sectors =3D s->src_sectors[src_cur];
=20
+        offset =3D (sector_num - src_cur_offset) << BDRV_SECTOR_BITS;
+
         n =3D MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset)=
);
+        if (single_read_until > offset) {
+            n =3D 1;
+        }
+
         iov.iov_base =3D buf;
         iov.iov_len =3D n << BDRV_SECTOR_BITS;
         qemu_iovec_init_external(&qiov, &iov, 1);
=20
-        ret =3D blk_co_preadv(
-                blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
-                n << BDRV_SECTOR_BITS, &qiov, 0);
+        ret =3D blk_co_preadv(blk, offset, n << BDRV_SECTOR_BITS, &qiov,=
 0);
         if (ret < 0) {
-            return ret;
+            if (s->salvage) {
+                if (n > 1) {
+                    single_read_until =3D offset + (n << BDRV_SECTOR_BIT=
S);
+                    continue;
+                } else {
+                    if (!s->quiet) {
+                        warn_report("Failed to read offset %#" PRIx64 " =
from "
+                                    "%s: %s", offset, blk_bs(blk)->filen=
ame,
+                                    strerror(-ret));
+                    }
+                    memset(buf, 0, BDRV_SECTOR_SIZE);
+                }
+            } else {
+                return ret;
+            }
         }
=20
         sector_num +=3D n;
@@ -2031,6 +2073,7 @@ static int img_convert(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OP=
TS},
+            {"salvage", no_argument, 0, OPTION_SALVAGE},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2148,6 +2191,9 @@ static int img_convert(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts =3D true;
             break;
+        case OPTION_SALVAGE:
+            s.salvage =3D true;
+            break;
         case OPTION_TARGET_IMAGE_OPTS:
             tgt_image_opts =3D true;
             break;
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1526f327a5..d6f444586c 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -44,9 +44,9 @@ STEXI
 ETEXI
=20
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [=
-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O outpu=
t_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size=
] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [=
-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O outpu=
t_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size=
] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_=
filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-=
opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{s=
rc_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options=
}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutin=
es}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-=
opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{s=
rc_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options=
}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutin=
es}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_=
filename}
 ETEXI
=20
 DEF("create", img_create,
diff --git a/qemu-img.texi b/qemu-img.texi
index 3b6710a580..827ee9fe32 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -175,6 +175,11 @@ improve performance if the data is remote, such as w=
ith NFS or iSCSI backends,
 but will not automatically sparsify zero sectors, and may result in a fu=
lly
 allocated target image depending on the host support for getting allocat=
ion
 information.
+@item --salvage
+Try to ignore I/O errors when reading.  Unless in quiet mode (@code{-q})=
, errors
+will still be printed.  Areas that cannot be read from the source will b=
e
+treated as containing only zeroes.  This option has no effect in copy of=
floading
+mode (@code{-C}).
 @end table
=20
 Parameters to dd subcommand:
--=20
2.19.2
