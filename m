Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOQ-0006Ef-In
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOO-0007L7-LW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:26 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Dec 2018 18:52:06 +0100
Message-Id: <20181203175211.8230-2-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-1-mreitz@redhat.com>
References: <20181203175211.8230-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 1/6] qemu-img: Move quiet into
 ImgConvertState
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

Move img_convert()'s quiet flag into the ImgConvertState so it is
accessible by nested functions.  -q dictates that it suppresses anything
but errors, so if those functions want to emit warnings, they need to
query this flag first.  (There currently are no such warnings, but there
will be as of the next patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ad04f59565..1582ef63f3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1569,6 +1569,7 @@ typedef struct ImgConvertState {
     int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
     bool copy_range;
+    bool quiet;
     int min_sparse;
     int alignment;
     size_t cluster_sectors;
@@ -2008,7 +2009,7 @@ static int img_convert(int argc, char **argv)
     QDict *open_opts =3D NULL;
     char *options =3D NULL;
     Error *local_err =3D NULL;
-    bool writethrough, src_writethrough, quiet =3D false, image_opts =3D=
 false,
+    bool writethrough, src_writethrough, image_opts =3D false,
          skip_create =3D false, progress =3D false, tgt_image_opts =3D f=
alse;
     int64_t ret =3D -EINVAL;
     bool force_share =3D false;
@@ -2116,7 +2117,7 @@ static int img_convert(int argc, char **argv)
             src_cache =3D optarg;
             break;
         case 'q':
-            quiet =3D true;
+            s.quiet =3D true;
             break;
         case 'n':
             skip_create =3D true;
@@ -2205,7 +2206,7 @@ static int img_convert(int argc, char **argv)
     }
=20
     /* Initialize before goto out */
-    if (quiet) {
+    if (s.quiet) {
         progress =3D false;
     }
     qemu_progress_init(progress, 1.0);
@@ -2216,7 +2217,7 @@ static int img_convert(int argc, char **argv)
=20
     for (bs_i =3D 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] =3D img_open(image_opts, argv[optind + bs_i],
-                               fmt, src_flags, src_writethrough, quiet,
+                               fmt, src_flags, src_writethrough, s.quiet=
,
                                force_share);
         if (!s.src[bs_i]) {
             ret =3D -1;
@@ -2379,7 +2380,7 @@ static int img_convert(int argc, char **argv)
=20
     if (skip_create) {
         s.target =3D img_open(tgt_image_opts, out_filename, out_fmt,
-                            flags, writethrough, quiet, false);
+                            flags, writethrough, s.quiet, false);
     } else {
         /* TODO ultimately we should allow --target-image-opts
          * to be used even when -n is not given.
@@ -2387,7 +2388,7 @@ static int img_convert(int argc, char **argv)
          * to allow filenames in option syntax
          */
         s.target =3D img_open_file(out_filename, open_opts, out_fmt,
-                                 flags, writethrough, quiet, false);
+                                 flags, writethrough, s.quiet, false);
         open_opts =3D NULL; /* blk_new_open will have freed it */
     }
     if (!s.target) {
--=20
2.19.2
