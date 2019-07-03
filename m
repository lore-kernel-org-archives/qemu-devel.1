Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51704C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA19218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA19218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hij65-0002SE-B0
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3s-0007bK-Ns
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3r-0008P7-Gt
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3o-0007wf-9A; Wed, 03 Jul 2019 13:28:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 303B83082200;
 Wed,  3 Jul 2019 17:28:27 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF7D17DE5;
 Wed,  3 Jul 2019 17:28:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:06 +0200
Message-Id: <20190703172813.6868-6-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 03 Jul 2019 17:28:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 05/12] block: Reduce (un)drains when
 replacing a child
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
---
 block.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index 96b3dc7d53..1fc9e709ad 100644
--- a/block.c
+++ b/block.c
@@ -2246,13 +2246,27 @@ static void bdrv_replace_child_noperm(BdrvChild *=
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
@@ -2260,28 +2274,22 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
         if (child->role->detach) {
             child->role->detach(child);
         }
-        while (child->parent_quiesce_counter) {
-            bdrv_parent_drained_end_single(child, true);
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
@@ -2290,6 +2298,15 @@ static void bdrv_replace_child_noperm(BdrvChild *c=
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
+        bdrv_parent_drained_end_single(child, true);
+        drain_saldo++;
+    }
 }
=20
 /*
--=20
2.21.0


