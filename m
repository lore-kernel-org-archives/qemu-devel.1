Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B2DECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21169206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21169206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2dH-0005Ea-BP
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Qd-0002hO-7G
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Qb-00016M-O1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iJ2QX-000151-OF; Fri, 11 Oct 2019 17:26:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECE9C30224AC;
 Fri, 11 Oct 2019 21:26:20 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 909C81EC;
 Fri, 11 Oct 2019 21:26:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 09/19] block: switch reopen queue from QSIMPLEQ to QTAILQ
Date: Fri, 11 Oct 2019 17:25:40 -0400
Message-Id: <20191011212550.27269-10-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
References: <20191011212550.27269-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 11 Oct 2019 21:26:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We'll need reverse-foreach in the following commit, QTAILQ support it,
so move to QTAILQ.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190927122355.7344-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 37c9de7446d..f5099435136 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -195,7 +195,7 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
=20
-typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReop=
enQueue;
+typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopen=
Queue;
=20
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
diff --git a/block.c b/block.c
index 5b5b0337acc..aaf5d796284 100644
--- a/block.c
+++ b/block.c
@@ -1719,7 +1719,7 @@ typedef struct BlockReopenQueueEntry {
      bool prepared;
      bool perms_checked;
      BDRVReopenState state;
-     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
+     QTAILQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
=20
 /*
@@ -1732,7 +1732,7 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *=
q, BlockDriverState *bs)
     BlockReopenQueueEntry *entry;
=20
     if (q !=3D NULL) {
-        QSIMPLEQ_FOREACH(entry, q, entry) {
+        QTAILQ_FOREACH(entry, q, entry) {
             if (entry->state.bs =3D=3D bs) {
                 return entry->state.flags;
             }
@@ -3249,7 +3249,7 @@ static bool bdrv_recurse_has_child(BlockDriverState=
 *bs,
  * Adds a BlockDriverState to a simple queue for an atomic, transactiona=
l
  * reopen of multiple devices.
  *
- * bs_queue can either be an existing BlockReopenQueue that has had QSIM=
PLE_INIT
+ * bs_queue can either be an existing BlockReopenQueue that has had QTAI=
LQ_INIT
  * already performed, or alternatively may be NULL a new BlockReopenQueu=
e will
  * be created and initialized. This newly created BlockReopenQueue shoul=
d be
  * passed back in for subsequent calls that are intended to be of the sa=
me
@@ -3290,7 +3290,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
=20
     if (bs_queue =3D=3D NULL) {
         bs_queue =3D g_new0(BlockReopenQueue, 1);
-        QSIMPLEQ_INIT(bs_queue);
+        QTAILQ_INIT(bs_queue);
     }
=20
     if (!options) {
@@ -3298,7 +3298,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
     }
=20
     /* Check if this BlockDriverState is already in the queue */
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         if (bs =3D=3D bs_entry->state.bs) {
             break;
         }
@@ -3354,7 +3354,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
=20
     if (!bs_entry) {
         bs_entry =3D g_new0(BlockReopenQueueEntry, 1);
-        QSIMPLEQ_INSERT_TAIL(bs_queue, bs_entry, entry);
+        QTAILQ_INSERT_TAIL(bs_queue, bs_entry, entry);
     } else {
         qobject_unref(bs_entry->state.options);
         qobject_unref(bs_entry->state.explicit_options);
@@ -3455,7 +3455,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue=
, Error **errp)
=20
     assert(bs_queue !=3D NULL);
=20
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         assert(bs_entry->state.bs->quiesce_counter > 0);
         if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
             goto cleanup;
@@ -3463,7 +3463,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue=
, Error **errp)
         bs_entry->prepared =3D true;
     }
=20
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state =3D &bs_entry->state;
         ret =3D bdrv_check_perm(state->bs, bs_queue, state->perm,
                               state->shared_perm, NULL, NULL, errp);
@@ -3489,13 +3489,13 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_que=
ue, Error **errp)
     /* If we reach this point, we have success and just need to apply th=
e
      * changes
      */
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         bdrv_reopen_commit(&bs_entry->state);
     }
=20
     ret =3D 0;
 cleanup_perm:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         BDRVReopenState *state =3D &bs_entry->state;
=20
         if (!bs_entry->perms_checked) {
@@ -3512,7 +3512,7 @@ cleanup_perm:
         }
     }
 cleanup:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (ret) {
             if (bs_entry->prepared) {
                 bdrv_reopen_abort(&bs_entry->state);
@@ -3552,7 +3552,7 @@ static BlockReopenQueueEntry *find_parent_in_reopen=
_queue(BlockReopenQueue *q,
 {
     BlockReopenQueueEntry *entry;
=20
-    QSIMPLEQ_FOREACH(entry, q, entry) {
+    QTAILQ_FOREACH(entry, q, entry) {
         BlockDriverState *bs =3D entry->state.bs;
         BdrvChild *child;
=20
--=20
2.21.0


