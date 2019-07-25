Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7674AC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F548217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F548217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgaw-0004yA-0A
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqgaT-0003QO-30
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqgaR-0003tW-OO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqgaO-0003oz-91; Thu, 25 Jul 2019 12:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D504306031E;
 Thu, 25 Jul 2019 16:27:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-146.ams2.redhat.com
 [10.36.117.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DBBB5D71A;
 Thu, 25 Jul 2019 16:27:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:27:02 +0200
Message-Id: <20190725162704.12622-3-kwolf@redhat.com>
In-Reply-To: <20190725162704.12622-1-kwolf@redhat.com>
References: <20190725162704.12622-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 25 Jul 2019 16:27:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] block: Reduce (un)drains when replacing a
 child
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Currently, bdrv_replace_child_noperm() undrains the parent until it is
completely undrained, then re-drains it after attaching the new child
node.

This is a problem with bdrv_drop_intermediate(): We want to keep the
whole subtree drained, including parents, while the operation is
under way.  bdrv_replace_child_noperm() breaks this by allowing every
parent to become unquiesced briefly, and then redraining it.

In fact, there is no reason why the parent should become unquiesced and
be allowed to submit requests to the new child node if that new node is
supposed to be kept drained.  So if anything, we have to drain the
parent before detaching the old child node.  Conversely, we have to
undrain it only after attaching the new child node.

Thus, change the whole drain algorithm here: Calculate the number of
times we have to drain/undrain the parent before replacing the child
node then drain it (if necessary), replace the child node, and then
undrain it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index cbd8da5f3b..e1595bd058 100644
--- a/block.c
+++ b/block.c
@@ -2238,13 +2238,27 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
                                       BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs =3D child->bs;
-    int i;
+    int new_bs_quiesce_counter;
+    int drain_saldo;
=20
     assert(!child->frozen);
=20
     if (old_bs && new_bs) {
         assert(bdrv_get_aio_context(old_bs) =3D=3D bdrv_get_aio_context(=
new_bs));
     }
+
+    new_bs_quiesce_counter =3D (new_bs ? new_bs->quiesce_counter : 0);
+    drain_saldo =3D new_bs_quiesce_counter - child->parent_quiesce_count=
er;
+
+    /*
+     * If the new child node is drained but the old one was not, flush
+     * all outstanding requests to the old child node.
+     */
+    while (drain_saldo > 0 && child->role->drained_begin) {
+        bdrv_parent_drained_begin_single(child, true);
+        drain_saldo--;
+    }
+
     if (old_bs) {
         /* Detach first so that the recursive drain sections coming from=
 @child
          * are already gone and we only end the drain sections that came=
 from
@@ -2252,28 +2266,22 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
         if (child->role->detach) {
             child->role->detach(child);
         }
-        while (child->parent_quiesce_counter) {
-            bdrv_parent_drained_end_single(child);
-        }
         QLIST_REMOVE(child, next_parent);
-    } else {
-        assert(child->parent_quiesce_counter =3D=3D 0);
     }
=20
     child->bs =3D new_bs;
=20
     if (new_bs) {
         QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
-        if (new_bs->quiesce_counter) {
-            int num =3D new_bs->quiesce_counter;
-            if (child->role->parent_is_bds) {
-                num -=3D bdrv_drain_all_count;
-            }
-            assert(num >=3D 0);
-            for (i =3D 0; i < num; i++) {
-                bdrv_parent_drained_begin_single(child, true);
-            }
-        }
+
+        /*
+         * Detaching the old node may have led to the new node's
+         * quiesce_counter having been decreased.  Not a problem, we
+         * just need to recognize this here and then invoke
+         * drained_end appropriately more often.
+         */
+        assert(new_bs->quiesce_counter <=3D new_bs_quiesce_counter);
+        drain_saldo +=3D new_bs->quiesce_counter - new_bs_quiesce_counte=
r;
=20
         /* Attach only after starting new drained sections, so that recu=
rsive
          * drain sections coming from @child don't get an extra .drained=
_begin
@@ -2282,6 +2290,15 @@ static void bdrv_replace_child_noperm(BdrvChild *c=
hild,
             child->role->attach(child);
         }
     }
+
+    /*
+     * If the old child node was drained but the new one is not, allow
+     * requests to come in only after the new node has been attached.
+     */
+    while (drain_saldo < 0 && child->role->drained_end) {
+        bdrv_parent_drained_end_single(child);
+        drain_saldo++;
+    }
 }
=20
 /*
--=20
2.20.1


