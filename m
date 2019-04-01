Received: from eggs.gnu.org ([209.51.188.92]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB442-0000um-Nv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB441-00038c-IG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43376
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB441-00038A-9z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1p1l095691
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegv8j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:52 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:46 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:53 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-20-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/97] qemu-img: fix regression copying secrets
 during convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

When the convert command is creating an output file that needs
secrets, we need to ensure those secrets are passed to both the
blk_new_open and bdrv_create API calls.

This is done by qemu-img extracting all opts matching the name
suffix "key-secret". Unfortunately the code doing this was run after the
call to bdrv_create(), which meant the QemuOpts it was extracting
secrets from was now empty.

Previously this worked by luks as a bug meant the "key-secret"
parameters were not purged from the QemuOpts. This bug was fixed in

  commit b76b4f604521e59f857d6177bc55f6f2e41fd392
  Author: Kevin Wolf <kwolf@redhat.com>
  Date:   Thu Jan 11 16:18:08 2018 +0100

    qcow2: Use visitor for options in qcow2_create()

Exposing the latent bug in qemu-img. This fix simply moves the copying
of secrets to before the bdrv_create() call.

Cc: qemu-stable@nongnu.org
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 8d65a3ccfd5db7f0436e095cd952f5d0c3a873ba)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1acddf693c..b12f4cd19b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -345,21 +345,6 @@ static int img_add_key_secrets(void *opaque,
     return 0;
 }
=20
-static BlockBackend *img_open_new_file(const char *filename,
-                                       QemuOpts *create_opts,
-                                       const char *fmt, int flags,
-                                       bool writethrough, bool quiet,
-                                       bool force_share)
-{
-    QDict *options =3D NULL;
-
-    options =3D qdict_new();
-    qemu_opt_foreach(create_opts, img_add_key_secrets, options, &error_a=
bort);
-
-    return img_open_file(filename, options, fmt, flags, writethrough, qu=
iet,
-                         force_share);
-}
-
=20
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
@@ -2018,6 +2003,7 @@ static int img_convert(int argc, char **argv)
     BlockDriverState *out_bs;
     QemuOpts *opts =3D NULL, *sn_opts =3D NULL;
     QemuOptsList *create_opts =3D NULL;
+    QDict *open_opts =3D NULL;
     char *options =3D NULL;
     Error *local_err =3D NULL;
     bool writethrough, src_writethrough, quiet =3D false, image_opts =3D=
 false,
@@ -2362,6 +2348,16 @@ static int img_convert(int argc, char **argv)
         }
     }
=20
+    /*
+     * The later open call will need any decryption secrets, and
+     * bdrv_create() will purge "opts", so extract them now before
+     * they are lost.
+     */
+    if (!skip_create) {
+        open_opts =3D qdict_new();
+        qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_ab=
ort);
+    }
+
     if (!skip_create) {
         /* Create the new image */
         ret =3D bdrv_create(drv, out_filename, opts, &local_err);
@@ -2388,8 +2384,9 @@ static int img_convert(int argc, char **argv)
          * That has to wait for bdrv_create to be improved
          * to allow filenames in option syntax
          */
-        s.target =3D img_open_new_file(out_filename, opts, out_fmt,
-                                     flags, writethrough, quiet, false);
+        s.target =3D img_open_file(out_filename, open_opts, out_fmt,
+                                 flags, writethrough, quiet, false);
+        open_opts =3D NULL; /* blk_new_open will have freed it */
     }
     if (!s.target) {
         ret =3D -1;
@@ -2464,6 +2461,7 @@ out:
     qemu_opts_del(opts);
     qemu_opts_free(create_opts);
     qemu_opts_del(sn_opts);
+    qobject_unref(open_opts);
     blk_unref(s.target);
     if (s.src) {
         for (bs_i =3D 0; bs_i < s.src_num; bs_i++) {
--=20
2.17.1
