Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF83EC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E0B20815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E0B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38251 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlBu-00057J-JU
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:31:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkxG-0000FK-7M
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkxE-0003nZ-L3
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkx6-0003hu-G4; Mon, 20 May 2019 12:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 588163092664;
	Mon, 20 May 2019 16:15:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 70ECF75261;
	Mon, 20 May 2019 16:15:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:50 +0200
Message-Id: <20190520161453.30723-22-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 20 May 2019 16:15:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 21/24] block: Improve "Block node is read-only"
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This message does not make any sense when it appears as the response to
making an R/W node read-only.  We should detect that case and emit a
different message, then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1e5230f98e..cb11537029 100644
--- a/block.c
+++ b/block.c
@@ -1709,6 +1709,8 @@ static int bdrv_child_check_perm(BdrvChild *c, Bloc=
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
@@ -1795,7 +1797,20 @@ static int bdrv_check_perm(BlockDriverState *bs, B=
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
2.20.1


