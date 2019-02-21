Received: from eggs.gnu.org ([209.51.188.92]:37264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gwsPG-0003ke-L1
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gwsPC-0002XA-OG
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:45:08 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 21 Feb 2019 18:37:58 +0100
Message-Id: <20190221173758.24672-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-img: implement copy offload (-C) for dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Sergio Lopez <slp@redhat.com>

This parameter is analogous to convert's "-C", making use of
bdrv_co_copy_range().

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 qemu-img-cmds.hx |   4 +-
 qemu-img.c       | 146 ++++++++++++++++++++++++++++++++++++-----------
 qemu-img.texi    |   2 +-
 3 files changed, 117 insertions(+), 35 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1526f327a5..7b85d183e5 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -56,9 +56,9 @@ STEXI
 ETEXI
=20
 DEF("dd", img_dd,
-    "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=3Dblock_size] [=
count=3Dblocks] [skip=3Dblocks] if=3Dinput of=3Doutput")
+    "dd [--image-opts] [-U] [-C] [-f fmt] [-O output_fmt] [bs=3Dblock_si=
ze] [count=3Dblocks] [skip=3Dblocks] if=3Dinput of=3Doutput")
 STEXI
-@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D=
@var{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D@var{=
input} of=3D@var{output}
+@item dd [--image-opts] [-U] [-C] [-f @var{fmt}] [-O @var{output_fmt}] [=
bs=3D@var{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D=
@var{input} of=3D@var{output}
 ETEXI
=20
 DEF("info", img_info,
diff --git a/qemu-img.c b/qemu-img.c
index 25288c4d18..75ac0318a1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4310,7 +4310,6 @@ struct DdInfo {
 struct DdIo {
     int bsz;    /* Block size */
     char *filename;
-    uint8_t *buf;
     int64_t offset;
 };
=20
@@ -4320,6 +4319,18 @@ struct DdOpts {
     unsigned int flag;
 };
=20
+typedef struct ImgDdState {
+    BlockBackend *src;
+    int64_t src_offset;
+    BlockBackend *dst;
+    int64_t dst_offset;
+    int bsz;
+    int64_t size;
+    bool copy_range;
+    int running_coroutines;
+    int ret;
+} ImgDdState;
+
 static int img_dd_bs(const char *arg,
                      struct DdIo *in, struct DdIo *out,
                      struct DdInfo *dd)
@@ -4383,6 +4394,86 @@ static int img_dd_skip(const char *arg,
     return 0;
 }
=20
+static void coroutine_fn dd_co_do_copy(void *opaque)
+{
+    ImgDdState *s =3D opaque;
+    int64_t block_count, in_pos, out_pos;
+    uint8_t *buf;
+    int ret =3D 0;
+
+    s->running_coroutines++;
+
+    in_pos =3D s->src_offset;
+    out_pos =3D s->dst_offset;
+
+    if (s->copy_range) {
+        /*
+         * We don't impose any kind of alignment requirements nor
+         * adjustments here. It's up to the user to set the best
+         * parameters for a particular storage/driver.
+         */
+        for (; in_pos < s->size && ret =3D=3D 0; block_count++) {
+            int bytes =3D s->bsz;
+
+            if (in_pos + bytes > s->size) {
+                bytes =3D s->size - in_pos;
+            }
+
+            ret =3D blk_co_copy_range(s->src, in_pos,
+                                    s->dst, out_pos,
+                                    bytes, 0, 0);
+            in_pos +=3D bytes;
+            out_pos +=3D bytes;
+        }
+
+        /*
+         * If copy_range succeded, jump to the end. Otherwise,
+         * fall through to try with the usual bouncing buffers.
+         */
+        if (ret =3D=3D 0) {
+            goto out;
+        } else {
+            warn_report("copy_range failed, continuing with the conventi=
onal "
+                        "read/write approach.");
+        }
+    }
+
+    buf =3D g_new(uint8_t, s->bsz);
+
+    for (; in_pos < s->size; block_count++) {
+        int in_ret, out_ret;
+
+        if (in_pos + s->bsz > s->size) {
+            in_ret =3D blk_pread(s->src, in_pos, buf, s->size - in_pos);
+        } else {
+            in_ret =3D blk_pread(s->src, in_pos, buf, s->bsz);
+        }
+        if (in_ret < 0) {
+            error_report("error while reading from input image file: %s"=
,
+                         strerror(-in_ret));
+            ret =3D -1;
+            goto free_out;
+        }
+        in_pos +=3D in_ret;
+
+        out_ret =3D blk_pwrite(s->dst, out_pos, buf, in_ret, 0);
+
+        if (out_ret < 0) {
+            error_report("error while writing to output image file: %s",
+                         strerror(-out_ret));
+            ret =3D -1;
+            goto free_out;
+        }
+        out_pos +=3D out_ret;
+    }
+
+ free_out:
+    g_free(buf);
+ out:
+    s->running_coroutines--;
+    s->ret =3D ret;
+}
+
 static int img_dd(int argc, char **argv)
 {
     int ret =3D 0;
@@ -4390,6 +4481,7 @@ static int img_dd(int argc, char **argv)
     char *tmp;
     BlockDriver *drv =3D NULL, *proto_drv =3D NULL;
     BlockBackend *blk1 =3D NULL, *blk2 =3D NULL;
+    Coroutine *co =3D NULL;
     QemuOpts *opts =3D NULL;
     QemuOptsList *create_opts =3D NULL;
     Error *local_err =3D NULL;
@@ -4398,8 +4490,9 @@ static int img_dd(int argc, char **argv)
     const char *out_fmt =3D "raw";
     const char *fmt =3D NULL;
     int64_t size =3D 0;
-    int64_t block_count =3D 0, out_pos, in_pos;
+    int64_t in_pos;
     bool force_share =3D false;
+    bool copy_range =3D false;
     struct DdInfo dd =3D {
         .flags =3D 0,
         .count =3D 0,
@@ -4407,13 +4500,11 @@ static int img_dd(int argc, char **argv)
     struct DdIo in =3D {
         .bsz =3D 512, /* Block size is by default 512 bytes */
         .filename =3D NULL,
-        .buf =3D NULL,
         .offset =3D 0
     };
     struct DdIo out =3D {
         .bsz =3D 512,
         .filename =3D NULL,
-        .buf =3D NULL,
         .offset =3D 0
     };
=20
@@ -4433,7 +4524,7 @@ static int img_dd(int argc, char **argv)
         { 0, 0, 0, 0 }
     };
=20
-    while ((c =3D getopt_long(argc, argv, ":hf:O:U", long_options, NULL)=
)) {
+    while ((c =3D getopt_long(argc, argv, ":hf:O:UC", long_options, NULL=
))) {
         if (c =3D=3D EOF) {
             break;
         }
@@ -4456,6 +4547,9 @@ static int img_dd(int argc, char **argv)
         case 'U':
             force_share =3D true;
             break;
+        case 'C':
+            copy_range =3D true;
+            break;
         case OPTION_OBJECT:
             if (!qemu_opts_parse_noisily(&qemu_object_opts, optarg, true=
)) {
                 ret =3D -1;
@@ -4606,35 +4700,25 @@ static int img_dd(int argc, char **argv)
         in_pos =3D in.offset * in.bsz;
     }
=20
-    in.buf =3D g_new(uint8_t, in.bsz);
-
-    for (out_pos =3D 0; in_pos < size; block_count++) {
-        int in_ret, out_ret;
-
-        if (in_pos + in.bsz > size) {
-            in_ret =3D blk_pread(blk1, in_pos, in.buf, size - in_pos);
-        } else {
-            in_ret =3D blk_pread(blk1, in_pos, in.buf, in.bsz);
-        }
-        if (in_ret < 0) {
-            error_report("error while reading from input image file: %s"=
,
-                         strerror(-in_ret));
-            ret =3D -1;
-            goto out;
-        }
-        in_pos +=3D in_ret;
+    ImgDdState s =3D (ImgDdState) {
+        .src =3D blk1,
+        .src_offset =3D in_pos,
+        .dst =3D blk2,
+        .dst_offset =3D 0,
+        .bsz =3D in.bsz,
+        .size =3D size,
+        .copy_range =3D copy_range,
+    };
=20
-        out_ret =3D blk_pwrite(blk2, out_pos, in.buf, in_ret, 0);
+    co =3D qemu_coroutine_create(dd_co_do_copy, &s);
+    qemu_coroutine_enter(co);
=20
-        if (out_ret < 0) {
-            error_report("error while writing to output image file: %s",
-                         strerror(-out_ret));
-            ret =3D -1;
-            goto out;
-        }
-        out_pos +=3D out_ret;
+    while (s.running_coroutines) {
+        main_loop_wait(false);
     }
=20
+    ret =3D s.ret;
+
 out:
     g_free(arg);
     qemu_opts_del(opts);
@@ -4643,8 +4727,6 @@ out:
     blk_unref(blk2);
     g_free(in.filename);
     g_free(out.filename);
-    g_free(in.buf);
-    g_free(out.buf);
=20
     if (ret) {
         return 1;
diff --git a/qemu-img.texi b/qemu-img.texi
index 3b6710a580..5c5079e3bc 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -390,7 +390,7 @@ way.
 The size can also be specified using the @var{size} option with @code{-o=
},
 it doesn't need to be specified separately in this case.
=20
-@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D=
@var{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D@var{=
input} of=3D@var{output}
+@item dd [--image-opts] [-U] [-C] [-f @var{fmt}] [-O @var{output_fmt}] [=
bs=3D@var{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D=
@var{input} of=3D@var{output}
=20
 Dd copies from @var{input} file to @var{output} file converting it from
 @var{fmt} format to @var{output_fmt} format.
--=20
2.20.1
