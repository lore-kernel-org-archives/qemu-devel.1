Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD6C388F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99AA20815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99AA20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57655 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF3Oe-0001RM-PL
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 17:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iF3NK-0000Rv-0p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iF3NI-0003vO-3I
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iF3NE-0003s5-2c; Mon, 30 Sep 2019 17:38:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44EE085362;
 Mon, 30 Sep 2019 21:38:27 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97E7810013A1;
 Mon, 30 Sep 2019 21:38:25 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] nbd: add empty .bdrv_reopen_prepare
Date: Tue,  1 Oct 2019 00:38:20 +0300
Message-Id: <20190930213820.29777-2-mlevitsk@redhat.com>
In-Reply-To: <20190930213820.29777-1-mlevitsk@redhat.com>
References: <20190930213820.29777-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 30 Sep 2019 21:38:27 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes commit job / qemu-img commit, when
commiting qcow2 file which is based on nbd export.


Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1718727

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nbd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 813c40d8f0..fd78e5f330 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1158,6 +1158,18 @@ static int coroutine_fn nbd_client_co_block_status(
         BDRV_BLOCK_OFFSET_VALID;
 }
 
+static int nbd_client_reopen_prepare(BDRVReopenState *state,
+                                     BlockReopenQueue *queue, Error **errp)
+{
+    BDRVNBDState *s = (BDRVNBDState *)state->bs->opaque;
+
+    if ((state->flags & BDRV_O_RDWR) && (s->info.flags & NBD_FLAG_READ_ONLY)) {
+        error_setg(errp, "Can't reopen read-only NBD mount as read/write");
+        return -EACCES;
+    }
+    return 0;
+}
+
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
@@ -1798,6 +1810,7 @@ static BlockDriver bdrv_nbd = {
     .instance_size              = sizeof(BDRVNBDState),
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_file_open             = nbd_open,
+    .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      = nbd_client_co_pwrite_zeroes,
@@ -1820,6 +1833,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .instance_size              = sizeof(BDRVNBDState),
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_file_open             = nbd_open,
+    .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      = nbd_client_co_pwrite_zeroes,
@@ -1842,6 +1856,7 @@ static BlockDriver bdrv_nbd_unix = {
     .instance_size              = sizeof(BDRVNBDState),
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_file_open             = nbd_open,
+    .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      = nbd_client_co_pwrite_zeroes,
-- 
2.17.2


