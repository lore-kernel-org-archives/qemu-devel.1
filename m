Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F20C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8AB208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8AB208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBj0-00067x-AS
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45532)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBS6-0007WF-5n
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBS4-0007ff-Mt
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBS0-0007W8-3g; Wed, 12 Jun 2019 18:10:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D9C2C04AC69;
 Wed, 12 Jun 2019 22:10:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A11D05DEDF;
 Wed, 12 Jun 2019 22:10:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:31 +0200
Message-Id: <20190612221004.2317-10-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 12 Jun 2019 22:10:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 09/42] block: Include filters when freezing
 backing chain
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to make filters work in backing chains, the associated
functions must be able to deal with them and freeze all filter links, be
they COW or R/W filter links.

While at it, add some comments that note which functions require their
caller to ensure that a given child link is not frozen, and how the
callers do so.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 8438b0699e..45882a3470 100644
--- a/block.c
+++ b/block.c
@@ -2214,12 +2214,15 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
  * If @new_bs is not NULL, bdrv_check_perm() must be called beforehand, =
as this
  * function uses bdrv_set_perm() to update the permissions according to =
the new
  * reference that @new_bs gets.
+ *
+ * Callers must ensure that child->frozen is false.
  */
 static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_b=
s)
 {
     BlockDriverState *old_bs =3D child->bs;
     uint64_t perm, shared_perm;
=20
+    /* Asserts that child->frozen =3D=3D false */
     bdrv_replace_child_noperm(child, new_bs);
=20
     if (old_bs) {
@@ -2360,6 +2363,7 @@ static void bdrv_detach_child(BdrvChild *child)
     g_free(child);
 }
=20
+/* Callers must ensure that child->frozen is false. */
 void bdrv_root_unref_child(BdrvChild *child)
 {
     BlockDriverState *child_bs;
@@ -2369,6 +2373,7 @@ void bdrv_root_unref_child(BdrvChild *child)
     bdrv_unref(child_bs);
 }
=20
+/* Callers must ensure that child->frozen is false. */
 void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
 {
     if (child =3D=3D NULL) {
@@ -2435,6 +2440,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
     }
=20
     if (bs->backing) {
+        /* Cannot be frozen, we checked that above */
         bdrv_unref_child(bs, bs->backing);
     }
=20
@@ -3908,6 +3914,7 @@ static void bdrv_close(BlockDriverState *bs)
=20
     if (bs->drv) {
         if (bs->drv->bdrv_close) {
+            /* Must unfreeze all children, so bdrv_unref_child() works *=
/
             bs->drv->bdrv_close(bs);
         }
         bs->drv =3D NULL;
@@ -4281,17 +4288,20 @@ BlockDriverState *bdrv_find_base(BlockDriverState=
 *bs)
  * Return true if at least one of the backing links between @bs and
  * @base is frozen. @errp is set if that's the case.
  * @base must be reachable from @bs, or NULL.
+ * (Filters are treated as normal elements of the backing chain.)
  */
 bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState=
 *base,
                                   Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing && i->backing->frozen) {
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
+
+        if (child && child->frozen) {
             error_setg(errp, "Cannot change '%s' link from '%s' to '%s'"=
,
-                       i->backing->name, i->node_name,
-                       backing_bs(i)->node_name);
+                       child->name, i->node_name, child->bs->node_name);
             return true;
         }
     }
@@ -4305,19 +4315,22 @@ bool bdrv_is_backing_chain_frozen(BlockDriverStat=
e *bs, BlockDriverState *base,
  * none of the links are modified.
  * @base must be reachable from @bs, or NULL.
  * Returns 0 on success. On failure returns < 0 and sets @errp.
+ * (Filters are treated as normal elements of the backing chain.)
  */
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *ba=
se,
                               Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
=20
     if (bdrv_is_backing_chain_frozen(bs, base, errp)) {
         return -EPERM;
     }
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing) {
-            i->backing->frozen =3D true;
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
+        if (child) {
+            child->frozen =3D true;
         }
     }
=20
@@ -4328,15 +4341,18 @@ int bdrv_freeze_backing_chain(BlockDriverState *b=
s, BlockDriverState *base,
  * Unfreeze all backing links between @bs and @base. The caller must
  * ensure that all links are frozen before using this function.
  * @base must be reachable from @bs, or NULL.
+ * (Filters are treated as normal elements of the backing chain.)
  */
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState =
*base)
 {
     BlockDriverState *i;
+    BdrvChild *child;
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing) {
-            assert(i->backing->frozen);
-            i->backing->frozen =3D false;
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
+        if (child) {
+            assert(child->frozen);
+            child->frozen =3D false;
         }
     }
 }
@@ -4438,8 +4454,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, =
BlockDriverState *base,
             }
         }
=20
-        /* Do the actual switch in the in-memory graph.
-         * Completes bdrv_check_update_perm() transaction internally. */
+        /*
+         * Do the actual switch in the in-memory graph.
+         * Completes bdrv_check_update_perm() transaction internally.
+         * c->frozen is false, we have checked that above.
+         */
         bdrv_ref(base);
         bdrv_replace_child(c, base);
         bdrv_unref(top);
--=20
2.21.0


