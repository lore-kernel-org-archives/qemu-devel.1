Received: from eggs.gnu.org ([209.51.188.92]:51646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGaN-0006ls-At
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGa2-0005Mj-0W
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:49 +0100
Message-Id: <20190131175549.11691-12-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 11/11] qcow2: Add data file to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 1 +
 block/qcow2.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 060df28797..0eb0637b64 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -74,6 +74,7 @@
 { 'struct': 'ImageInfoSpecificQCow2',
   'data': {
       'compat': 'str',
+      '*data-file': 'str',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
diff --git a/block/qcow2.c b/block/qcow2.c
index 4959bf16a4..e3427f9fcd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1459,7 +1459,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
         s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs,
                                        &child_file, false, &local_err);
-        if (!s->data_file) {
+        if (s->data_file) {
+            s->image_data_file =3D g_strdup(s->data_file->bs->filename);
+        } else {
             if (s->image_data_file) {
                 error_free(local_err);
                 local_err =3D NULL;
@@ -4533,6 +4535,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(B=
lockDriverState *bs)
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        =3D true,
             .refcount_bits      =3D s->refcount_bits,
+            .has_data_file      =3D !!s->image_data_file,
+            .data_file          =3D g_strdup(s->image_data_file),
         };
     } else {
         /* if this assertion fails, this probably means a new version wa=
s
--=20
2.20.1
