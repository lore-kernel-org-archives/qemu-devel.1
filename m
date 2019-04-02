Received: from eggs.gnu.org ([209.51.188.92]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqz-0002KZ-VX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqy-00039S-Ti
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:04 +0200
Message-Id: <20190402124907.24421-7-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] block: continue until base is found in
 bdrv_freeze_backing_chain() et al
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

All three functions that handle the BdrvChild.frozen attribute walk
the backing chain from 'bs' to 'base' and stop either when 'base' is
found or at the end of the chain if 'base' is NULL.

However if 'base' is not found then the functions return without
errors as if it was NULL.

This is wrong: if the caller passed an incorrect parameter that means
that there is a bug in the code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 0a93ee9ac8..3050854528 100644
--- a/block.c
+++ b/block.c
@@ -4218,14 +4218,15 @@ BlockDriverState *bdrv_find_base(BlockDriverState=
 *bs)
 /*
  * Return true if at least one of the backing links between @bs and
  * @base is frozen. @errp is set if that's the case.
+ * @base must be reachable from @bs, or NULL.
  */
 bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState=
 *base,
                                   Error **errp)
 {
     BlockDriverState *i;
=20
-    for (i =3D bs; i !=3D base && i->backing; i =3D backing_bs(i)) {
-        if (i->backing->frozen) {
+    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+        if (i->backing && i->backing->frozen) {
             error_setg(errp, "Cannot change '%s' link from '%s' to '%s'"=
,
                        i->backing->name, i->node_name,
                        backing_bs(i)->node_name);
@@ -4240,6 +4241,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState =
*bs, BlockDriverState *base,
  * Freeze all backing links between @bs and @base.
  * If any of the links is already frozen the operation is aborted and
  * none of the links are modified.
+ * @base must be reachable from @bs, or NULL.
  * Returns 0 on success. On failure returns < 0 and sets @errp.
  */
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *ba=
se,
@@ -4251,8 +4253,10 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs=
, BlockDriverState *base,
         return -EPERM;
     }
=20
-    for (i =3D bs; i !=3D base && i->backing; i =3D backing_bs(i)) {
-        i->backing->frozen =3D true;
+    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+        if (i->backing) {
+            i->backing->frozen =3D true;
+        }
     }
=20
     return 0;
@@ -4261,14 +4265,17 @@ int bdrv_freeze_backing_chain(BlockDriverState *b=
s, BlockDriverState *base,
 /*
  * Unfreeze all backing links between @bs and @base. The caller must
  * ensure that all links are frozen before using this function.
+ * @base must be reachable from @bs, or NULL.
  */
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState =
*base)
 {
     BlockDriverState *i;
=20
-    for (i =3D bs; i !=3D base && i->backing; i =3D backing_bs(i)) {
-        assert(i->backing->frozen);
-        i->backing->frozen =3D false;
+    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+        if (i->backing) {
+            assert(i->backing->frozen);
+            i->backing->frozen =3D false;
+        }
     }
 }
=20
--=20
2.20.1
