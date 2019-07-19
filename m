Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1B6C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FBE2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FBE2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTCM-0008Gt-AZ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTB9-0003TU-JF
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTB6-0003VL-Id
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTB3-0003Sj-CE; Fri, 19 Jul 2019 09:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE9D630BD1BB;
 Fri, 19 Jul 2019 13:44:00 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDA05608D0;
 Fri, 19 Jul 2019 13:43:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:36 +0200
Message-Id: <20190719134345.23526-5-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 13:44:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/13] block: Add @drained_end_counter
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Callers can now pass a pointer to an integer that bdrv_drain_invoke()
(and its recursive callees) will increment for every
bdrv_drain_invoke_entry() operation they schedule.
bdrv_drain_invoke_entry() in turn will decrement it once it has invoked
BlockDriver.bdrv_co_drain_end().

We use atomic operations to access the pointee, because the
bdrv_do_drained_end() caller may wish to end drained sections for
multiple nodes in different AioContexts (bdrv_drain_all_end() does, for
example).

This is the first step to moving the polling for BdrvCoDrainData.done to
become true out of bdrv_drain_invoke() and into the root drained_end
function.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 58 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1e618f9a37..c42e18b068 100644
--- a/block/io.c
+++ b/block/io.c
@@ -194,6 +194,7 @@ typedef struct {
     bool poll;
     BdrvChild *parent;
     bool ignore_bds_parents;
+    int *drained_end_counter;
 } BdrvCoDrainData;
=20
 static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
@@ -211,13 +212,18 @@ static void coroutine_fn bdrv_drain_invoke_entry(vo=
id *opaque)
     atomic_mb_set(&data->done, true);
     bdrv_dec_in_flight(bs);
=20
-    if (data->begin) {
+    if (data->drained_end_counter) {
+        atomic_dec(data->drained_end_counter);
+    }
+
+    if (data->begin || data->drained_end_counter) {
         g_free(data);
     }
 }
=20
 /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
-static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
+static void bdrv_drain_invoke(BlockDriverState *bs, bool begin,
+                              int *drained_end_counter)
 {
     BdrvCoDrainData *data;
=20
@@ -230,16 +236,25 @@ static void bdrv_drain_invoke(BlockDriverState *bs,=
 bool begin)
     *data =3D (BdrvCoDrainData) {
         .bs =3D bs,
         .done =3D false,
-        .begin =3D begin
+        .begin =3D begin,
+        .drained_end_counter =3D drained_end_counter,
     };
=20
+    if (!begin && drained_end_counter) {
+        atomic_inc(drained_end_counter);
+    }
+
     /* Make sure the driver callback completes during the polling phase =
for
      * drain_begin. */
     bdrv_inc_in_flight(bs);
     data->co =3D qemu_coroutine_create(bdrv_drain_invoke_entry, data);
     aio_co_schedule(bdrv_get_aio_context(bs), data->co);
=20
-    if (!begin) {
+    /*
+     * TODO: Drop this and make callers pass @drained_end_counter and po=
ll
+     * themselves
+     */
+    if (!begin && !drained_end_counter) {
         BDRV_POLL_WHILE(bs, !data->done);
         g_free(data);
     }
@@ -281,7 +296,8 @@ static void bdrv_do_drained_begin(BlockDriverState *b=
s, bool recursive,
                                   BdrvChild *parent, bool ignore_bds_par=
ents,
                                   bool poll);
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent, bool ignore_bds_paren=
ts);
+                                BdrvChild *parent, bool ignore_bds_paren=
ts,
+                                int *drained_end_counter);
=20
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
@@ -308,7 +324,8 @@ static void bdrv_co_drain_bh_cb(void *opaque)
                                   data->ignore_bds_parents, data->poll);
         } else {
             bdrv_do_drained_end(bs, data->recursive, data->parent,
-                                data->ignore_bds_parents);
+                                data->ignore_bds_parents,
+                                data->drained_end_counter);
         }
         if (ctx =3D=3D co_ctx) {
             aio_context_release(ctx);
@@ -326,7 +343,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
                                                 bool begin, bool recursi=
ve,
                                                 BdrvChild *parent,
                                                 bool ignore_bds_parents,
-                                                bool poll)
+                                                bool poll,
+                                                int *drained_end_counter=
)
 {
     BdrvCoDrainData data;
=20
@@ -343,7 +361,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
         .parent =3D parent,
         .ignore_bds_parents =3D ignore_bds_parents,
         .poll =3D poll,
+        .drained_end_counter =3D drained_end_counter,
     };
+
     if (bs) {
         bdrv_inc_in_flight(bs);
     }
@@ -367,7 +387,7 @@ void bdrv_do_drained_begin_quiesce(BlockDriverState *=
bs,
     }
=20
     bdrv_parent_drained_begin(bs, parent, ignore_bds_parents);
-    bdrv_drain_invoke(bs, true);
+    bdrv_drain_invoke(bs, true, NULL);
 }
=20
 static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
@@ -378,7 +398,7 @@ static void bdrv_do_drained_begin(BlockDriverState *b=
s, bool recursive,
=20
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, true, recursive, parent, ignore_bds_p=
arents,
-                               poll);
+                               poll, NULL);
         return;
     }
=20
@@ -419,20 +439,21 @@ void bdrv_subtree_drained_begin(BlockDriverState *b=
s)
 }
=20
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent, bool ignore_bds_paren=
ts)
+                                BdrvChild *parent, bool ignore_bds_paren=
ts,
+                                int *drained_end_counter)
 {
     BdrvChild *child, *next;
     int old_quiesce_counter;
=20
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false, recursive, parent, ignore_bds_=
parents,
-                               false);
+                               false, drained_end_counter);
         return;
     }
     assert(bs->quiesce_counter > 0);
=20
     /* Re-enable things in child-to-parent order */
-    bdrv_drain_invoke(bs, false);
+    bdrv_drain_invoke(bs, false, drained_end_counter);
     bdrv_parent_drained_end(bs, parent, ignore_bds_parents);
=20
     old_quiesce_counter =3D atomic_fetch_dec(&bs->quiesce_counter);
@@ -444,19 +465,20 @@ static void bdrv_do_drained_end(BlockDriverState *b=
s, bool recursive,
         assert(!ignore_bds_parents);
         bs->recursive_quiesce_counter--;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts);
+            bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts,
+                                drained_end_counter);
         }
     }
 }
=20
 void bdrv_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, false, NULL, false);
+    bdrv_do_drained_end(bs, false, NULL, false, NULL);
 }
=20
 void bdrv_subtree_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, true, NULL, false);
+    bdrv_do_drained_end(bs, true, NULL, false, NULL);
 }
=20
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent)
@@ -473,7 +495,7 @@ void bdrv_unapply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *old_parent)
     int i;
=20
     for (i =3D 0; i < old_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_end(child->bs, true, child, false);
+        bdrv_do_drained_end(child->bs, true, child, false, NULL);
     }
 }
=20
@@ -543,7 +565,7 @@ void bdrv_drain_all_begin(void)
     BlockDriverState *bs =3D NULL;
=20
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(NULL, true, false, NULL, true, true);
+        bdrv_co_yield_to_drain(NULL, true, false, NULL, true, true, NULL=
);
         return;
     }
=20
@@ -579,7 +601,7 @@ void bdrv_drain_all_end(void)
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        bdrv_do_drained_end(bs, false, NULL, true);
+        bdrv_do_drained_end(bs, false, NULL, true, NULL);
         aio_context_release(aio_context);
     }
=20
--=20
2.20.1


