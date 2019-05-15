Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB2C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4314620449
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4314620449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0L2-0006ql-DF
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:17:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0JF-0005tg-75
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0J7-0007fn-Lq
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hR0Iv-0007Zq-Og; Wed, 15 May 2019 16:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 329DA7FDCD;
	Wed, 15 May 2019 20:15:08 +0000 (UTC)
Received: from localhost (unknown [10.40.205.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BAAA51972A;
	Wed, 15 May 2019 20:15:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 15 May 2019 22:15:00 +0200
Message-Id: <20190515201503.19069-2-mreitz@redhat.com>
In-Reply-To: <20190515201503.19069-1-mreitz@redhat.com>
References: <20190515201503.19069-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 15 May 2019 20:15:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] block: Improve "Block node is read-only"
 message
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This message does not make any sense when it appears as the response to
making an R/W node read-only.  We should detect that case and emit a
different message, then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 16ef5edfd8..af662d5f17 100644
--- a/block.c
+++ b/block.c
@@ -1689,6 +1689,8 @@ static int bdrv_child_check_perm(BdrvChild *c, Bloc=
kReopenQueue *q,
                                  GSList *ignore_children, Error **errp);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t sh=
ared);
+static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *per=
m,
+                                     uint64_t *shared_perm);
=20
 typedef struct BlockReopenQueueEntry {
      bool prepared;
@@ -1775,7 +1777,20 @@ static int bdrv_check_perm(BlockDriverState *bs, B=
lockReopenQueue *q,
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))=
 &&
         !bdrv_is_writable_after_reopen(bs, q))
     {
-        error_setg(errp, "Block node is read-only");
+        if (!bdrv_is_writable_after_reopen(bs, NULL)) {
+            error_setg(errp, "Block node is read-only");
+        } else {
+            uint64_t current_perms, current_shared;
+            bdrv_get_cumulative_perm(bs, &current_perms, &current_shared=
);
+            if (current_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANG=
ED)) {
+                error_setg(errp, "Cannot make block node read-only, ther=
e is "
+                           "a writer on it");
+            } else {
+                error_setg(errp, "Cannot make block node read-only and c=
reate "
+                           "a writer on it");
+            }
+        }
+
         return -EPERM;
     }
=20
--=20
2.21.0


