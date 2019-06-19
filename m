Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C652C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E4821721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E4821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcZ4-0000yL-IO
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcTw-0003Hk-QR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcTv-0002CQ-KZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcTs-00026V-SY; Wed, 19 Jun 2019 11:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9030981D3;
 Wed, 19 Jun 2019 15:26:25 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47E7A5C2E8;
 Wed, 19 Jun 2019 15:26:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 17:25:59 +0200
Message-Id: <20190619152603.5937-6-mreitz@redhat.com>
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
References: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 19 Jun 2019 15:26:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/9] block: Add @poll to
 bdrv_parent_drained_end_single()
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function has two callers; one wants it to poll, the other does not.

To implement this parameter, we also need a new BdrvChildRole method,
namely .drained_end_unquiesce().  This function differs from
.drained_end() in that it should poll and is thus allowed to modify the
block graph.

Note that currently every BDS child's .drained_end() implementation is
simply broken in exactly that regard; the current implementation is
actually fit for .drained_end_unquiesce().  However, at this point we
cannot implement .drained_end() correctly, so a later patch in this
series will address that issue.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     |  5 ++++-
 include/block/block_int.h | 14 ++++++++++++++
 block.c                   |  2 +-
 block/io.c                | 10 +++++++---
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 3c084e8222..d98237f0f1 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -620,8 +620,11 @@ void bdrv_parent_drained_begin_single(BdrvChild *c, =
bool poll);
  * bdrv_parent_drained_end_single:
  *
  * End a quiesced section for the parent of @c.
+ *
+ * If @poll is true, poll until the parent is unquiesced.  This may
+ * lead to changes in the block graph.
  */
-void bdrv_parent_drained_end_single(BdrvChild *c);
+void bdrv_parent_drained_end_single(BdrvChild *c, bool poll);
=20
 /**
  * bdrv_parent_drained_end:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7f62907932..fce9a9e7ee 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -670,6 +670,20 @@ struct BdrvChildRole {
     void (*drained_begin)(BdrvChild *child);
     void (*drained_end)(BdrvChild *child);
=20
+    /*
+     * Parents that require polling to actually become unquiesced
+     * should implement this function in addition to .drained_end().
+     * In it, the parent should end the drain and aio_poll() until it
+     * is no longer quiesced.
+     *
+     * Thus, in contrast to .drained_end(), this function is allowed
+     * to change the graph.
+     *
+     * (This pointer may be NULL, in which case .drained_end() is
+     * called instead.)
+     */
+    void (*drained_end_unquiesce)(BdrvChild *child);
+
     /*
      * Returns whether the parent has pending requests for the child. Th=
is
      * callback is polled after .drained_begin() has been called until a=
ll
diff --git a/block.c b/block.c
index f7d7d8ccef..31b85df0f0 100644
--- a/block.c
+++ b/block.c
@@ -2252,7 +2252,7 @@ static void bdrv_replace_child_noperm(BdrvChild *ch=
ild,
             child->role->detach(child);
         }
         while (child->parent_quiesce_counter) {
-            bdrv_parent_drained_end_single(child);
+            bdrv_parent_drained_end_single(child, true);
         }
         QLIST_REMOVE(child, next_parent);
     } else {
diff --git a/block/io.c b/block/io.c
index 426ad5b4a1..5f30baa8e5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -55,12 +55,16 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, =
BdrvChild *ignore,
     }
 }
=20
-void bdrv_parent_drained_end_single(BdrvChild *c)
+void bdrv_parent_drained_end_single(BdrvChild *c, bool poll)
 {
     assert(c->parent_quiesce_counter > 0);
     c->parent_quiesce_counter--;
     if (c->role->drained_end) {
-        c->role->drained_end(c);
+        if (poll && c->role->drained_end_unquiesce) {
+            c->role->drained_end_unquiesce(c);
+        } else {
+            c->role->drained_end(c);
+        }
     }
 }
=20
@@ -73,7 +77,7 @@ void bdrv_parent_drained_end(BlockDriverState *bs, Bdrv=
Child *ignore,
         if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
-        bdrv_parent_drained_end_single(c);
+        bdrv_parent_drained_end_single(c, false);
     }
 }
=20
--=20
2.21.0


