Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41967C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FCD2773F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FCD2773F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXosZ-0003aN-8J
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:28:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoWE-0001hb-9H
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoW8-0001ei-1i
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoW2-0001Rz-9E; Mon, 03 Jun 2019 11:04:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DC5DC05B1CA;
	Mon,  3 Jun 2019 15:04:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA33A67279;
	Mon,  3 Jun 2019 15:04:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:30 +0200
Message-Id: <20190603150233.6614-26-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 03 Jun 2019 15:04:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 25/28] block: Remove bdrv_set_aio_context()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers of bdrv_set_aio_context() are eliminated now, they have
moved to bdrv_try_set_aio_context() and related safe functions. Remove
bdrv_set_aio_context().

With this, we can now know that the .set_aio_ctx callback must be
present in bdrv_set_aio_context_ignore() because
bdrv_can_set_aio_context() would have returned false previously, so
instead of checking the condition, we can assert it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/devel/multiple-iothreads.txt |  4 ++--
 include/block/block.h             |  9 ---------
 block.c                           | 30 ++++++++++++++----------------
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/docs/devel/multiple-iothreads.txt b/docs/devel/multiple-ioth=
reads.txt
index 4f9012d154..aeb997bed5 100644
--- a/docs/devel/multiple-iothreads.txt
+++ b/docs/devel/multiple-iothreads.txt
@@ -109,7 +109,7 @@ The AioContext originates from the QEMU block layer, =
even though nowadays
 AioContext is a generic event loop that can be used by any QEMU subsyste=
m.
=20
 The block layer has support for AioContext integrated.  Each BlockDriver=
State
-is associated with an AioContext using bdrv_set_aio_context() and
+is associated with an AioContext using bdrv_try_set_aio_context() and
 bdrv_get_aio_context().  This allows block layer code to process I/O ins=
ide the
 right AioContext.  Other subsystems may wish to follow a similar approac=
h.
=20
@@ -134,5 +134,5 @@ Long-running jobs (usually in the form of coroutines)=
 are best scheduled in
 the BlockDriverState's AioContext to avoid the need to acquire/release a=
round
 each bdrv_*() call.  The functions bdrv_add/remove_aio_context_notifier,
 or alternatively blk_add/remove_aio_context_notifier if you use BlockBac=
kends,
-can be used to get a notification whenever bdrv_set_aio_context() moves =
a
+can be used to get a notification whenever bdrv_try_set_aio_context() mo=
ves a
 BlockDriverState to a different AioContext.
diff --git a/include/block/block.h b/include/block/block.h
index 531cf595cf..13ea050a5b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -583,15 +583,6 @@ AioContext *bdrv_get_aio_context(BlockDriverState *b=
s);
  */
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co);
=20
-/**
- * bdrv_set_aio_context:
- *
- * Changes the #AioContext used for fd handlers, timers, and BHs by this
- * BlockDriverState and all its children.
- *
- * This function must be called with iothread lock held.
- */
-void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)=
;
 void bdrv_set_aio_context_ignore(BlockDriverState *bs,
                                  AioContext *new_context, GSList **ignor=
e);
 int bdrv_try_set_aio_context(BlockDriverState *bs, AioContext *ctx,
diff --git a/block.c b/block.c
index ddfae15d9b..e3e77feee0 100644
--- a/block.c
+++ b/block.c
@@ -5789,8 +5789,17 @@ static void bdrv_attach_aio_context(BlockDriverSta=
te *bs,
     bs->walking_aio_notifiers =3D false;
 }
=20
-/* @ignore will accumulate all visited BdrvChild object. The caller is
- * responsible for freeing the list afterwards. */
+/*
+ * Changes the AioContext used for fd handlers, timers, and BHs by this
+ * BlockDriverState and all its children and parents.
+ *
+ * The caller must own the AioContext lock for the old AioContext of bs,=
 but it
+ * must not own the AioContext lock for new_context (unless new_context =
is the
+ * same as the current context of bs).
+ *
+ * @ignore will accumulate all visited BdrvChild object. The caller is
+ * responsible for freeing the list afterwards.
+ */
 void bdrv_set_aio_context_ignore(BlockDriverState *bs,
                                  AioContext *new_context, GSList **ignor=
e)
 {
@@ -5813,10 +5822,9 @@ void bdrv_set_aio_context_ignore(BlockDriverState =
*bs,
         if (g_slist_find(*ignore, child)) {
             continue;
         }
-        if (child->role->set_aio_ctx) {
-            *ignore =3D g_slist_prepend(*ignore, child);
-            child->role->set_aio_ctx(child, new_context, ignore);
-        }
+        assert(child->role->set_aio_ctx);
+        *ignore =3D g_slist_prepend(*ignore, child);
+        child->role->set_aio_ctx(child, new_context, ignore);
     }
=20
     bdrv_detach_aio_context(bs);
@@ -5830,16 +5838,6 @@ void bdrv_set_aio_context_ignore(BlockDriverState =
*bs,
     aio_context_release(new_context);
 }
=20
-/* The caller must own the AioContext lock for the old AioContext of bs,=
 but it
- * must not own the AioContext lock for new_context (unless new_context =
is
- * the same as the current context of bs). */
-void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
-{
-    GSList *ignore_list =3D NULL;
-    bdrv_set_aio_context_ignore(bs, new_context, &ignore_list);
-    g_slist_free(ignore_list);
-}
-
 static bool bdrv_parent_can_set_aio_context(BdrvChild *c, AioContext *ct=
x,
                                             GSList **ignore, Error **err=
p)
 {
--=20
2.20.1


