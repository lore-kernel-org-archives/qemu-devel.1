Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398BAC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA4B2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA4B2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYQ6-0005oa-7R
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hpYPY-0003ui-AK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hpYPX-0002M7-4g
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hpYPQ-0002EU-NW; Mon, 22 Jul 2019 09:31:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFD4581DE3;
 Mon, 22 Jul 2019 13:31:19 +0000 (UTC)
Received: from localhost (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C989960BF1;
 Mon, 22 Jul 2019 13:31:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 22 Jul 2019 15:30:54 +0200
Message-Id: <20190722133054.21781-3-mreitz@redhat.com>
In-Reply-To: <20190722133054.21781-1-mreitz@redhat.com>
References: <20190722133054.21781-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 22 Jul 2019 13:31:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 2/2] block: Only the main loop can
 change AioContexts
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_set_aio_context_ignore() can only work in the main loop:
bdrv_drained_begin() only works in the main loop and the node's (old)
AioContext; and bdrv_drained_end() really only works in the main loop
and the node's (new) AioContext (contrary to its current comment, which
is just wrong).

Consequentially, bdrv_set_aio_context_ignore() must be called from the
main loop.  Luckily, assuming that we can make block graph changes only
from the main loop as well, all its callers do that already.

Note that changing a node's context in a sense is an operation that
changes the block graph, so it actually makes sense to require this
function to be called from the main loop.

Also, fix bdrv_drained_end()'s description.  You can only use it from
the main loop or the node's AioContext, and in the latter case, the
whole subtree must be in the same context.

Fixes: e037c09c78520cbdb6da7cfc6ad0256d5870b814
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  8 +++-----
 block.c               | 13 ++++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 60f00479e0..50a07c1c33 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -667,11 +667,9 @@ void bdrv_subtree_drained_begin(BlockDriverState *bs=
);
  *
  * This polls @bs's AioContext until all scheduled sub-drained_ends
  * have settled.  On one hand, that may result in graph changes.  On
- * the other, this requires that all involved nodes (@bs and all of
- * its parents) are in the same AioContext, and that the caller has
- * acquired it.
- * If there are any nodes that are in different contexts from @bs,
- * these contexts must not be acquired.
+ * the other, this requires that the caller either runs in the main
+ * loop; or that all involved nodes (@bs and all of its parents) are
+ * in the caller's AioContext.
  */
 void bdrv_drained_end(BlockDriverState *bs);
=20
diff --git a/block.c b/block.c
index 9c94f7f28a..cbd8da5f3b 100644
--- a/block.c
+++ b/block.c
@@ -5914,6 +5914,8 @@ static void bdrv_attach_aio_context(BlockDriverStat=
e *bs,
  * Changes the AioContext used for fd handlers, timers, and BHs by this
  * BlockDriverState and all its children and parents.
  *
+ * Must be called from the main AioContext.
+ *
  * The caller must own the AioContext lock for the old AioContext of bs,=
 but it
  * must not own the AioContext lock for new_context (unless new_context =
is the
  * same as the current context of bs).
@@ -5925,9 +5927,10 @@ void bdrv_set_aio_context_ignore(BlockDriverState =
*bs,
                                  AioContext *new_context, GSList **ignor=
e)
 {
     AioContext *old_context =3D bdrv_get_aio_context(bs);
-    AioContext *current_context =3D qemu_get_current_aio_context();
     BdrvChild *child;
=20
+    g_assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context(=
));
+
     if (old_context =3D=3D new_context) {
         return;
     }
@@ -5953,7 +5956,7 @@ void bdrv_set_aio_context_ignore(BlockDriverState *=
bs,
     bdrv_detach_aio_context(bs);
=20
     /* Acquire the new context, if necessary */
-    if (current_context !=3D new_context) {
+    if (qemu_get_aio_context() !=3D new_context) {
         aio_context_acquire(new_context);
     }
=20
@@ -5965,16 +5968,16 @@ void bdrv_set_aio_context_ignore(BlockDriverState=
 *bs,
      * subtree that have not yet been moved to the new AioContext.
      * Release the old one so bdrv_drained_end() can poll them.
      */
-    if (current_context !=3D old_context) {
+    if (qemu_get_aio_context() !=3D old_context) {
         aio_context_release(old_context);
     }
=20
     bdrv_drained_end(bs);
=20
-    if (current_context !=3D old_context) {
+    if (qemu_get_aio_context() !=3D old_context) {
         aio_context_acquire(old_context);
     }
-    if (current_context !=3D new_context) {
+    if (qemu_get_aio_context() !=3D new_context) {
         aio_context_release(new_context);
     }
 }
--=20
2.21.0


