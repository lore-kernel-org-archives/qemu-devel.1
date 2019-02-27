Received: from eggs.gnu.org ([209.51.188.92]:51501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2wT-0003fX-PQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2wO-0003et-6z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:24:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 27 Feb 2019 18:22:38 +0100
Message-Id: <20190227172256.30368-3-kwolf@redhat.com>
In-Reply-To: <20190227172256.30368-1-kwolf@redhat.com>
References: <20190227172256.30368-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/20] qcow2: Simplify preallocation code
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

Image creation already involves a bdrv_co_truncate() call, which allows
to specify a preallocation mode. Just pass the right mode there and
remove the code that is made redundant by this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1de5e24613..e38041e817 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2940,19 +2940,6 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
         goto out;
     }
=20
-    if (qcow2_opts->preallocation =3D=3D PREALLOC_MODE_FULL ||
-        qcow2_opts->preallocation =3D=3D PREALLOC_MODE_FALLOC)
-    {
-        int64_t prealloc_size =3D
-            qcow2_calc_prealloc_size(qcow2_opts->size, cluster_size,
-                                     refcount_order);
-
-        ret =3D blk_truncate(blk, prealloc_size, qcow2_opts->preallocati=
on, errp);
-        if (ret < 0) {
-            goto out;
-        }
-    }
-
     /* Write the header */
     QEMU_BUILD_BUG_ON((1 << MIN_CLUSTER_BITS) < sizeof(*header));
     header =3D g_malloc0(cluster_size);
@@ -3034,7 +3021,7 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
     }
=20
     /* Okay, now that we have a valid image, let's give it the right siz=
e */
-    ret =3D blk_truncate(blk, qcow2_opts->size, PREALLOC_MODE_OFF, errp)=
;
+    ret =3D blk_truncate(blk, qcow2_opts->size, qcow2_opts->preallocatio=
n, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
@@ -3066,19 +3053,6 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
         }
     }
=20
-    /* And if we're supposed to preallocate metadata, do that now */
-    if (qcow2_opts->preallocation !=3D PREALLOC_MODE_OFF) {
-        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
-        qemu_co_mutex_lock(&s->lock);
-        ret =3D preallocate_co(blk_bs(blk), 0, qcow2_opts->size);
-        qemu_co_mutex_unlock(&s->lock);
-
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Could not preallocate metadata=
");
-            goto out;
-        }
-    }
-
     blk_unref(blk);
     blk =3D NULL;
=20
--=20
2.20.1
