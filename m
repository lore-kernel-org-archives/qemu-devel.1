Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92337C004C9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0CB2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gPuqG02R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0CB2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLBGl-0004KU-HY
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:44:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF2-0003Hf-18
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF0-0002Qg-Th
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hLBF0-0002Pd-IN; Mon, 29 Apr 2019 14:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=DSgYzoTxyKoJ5zGTX00jdWTyzuRuzs/sQOg2O0JISzQ=; 
	b=gPuqG02RLH23nNeWN2QQB0IglKKnbfRIkr+y/aYbwjnVDKpIIC5YDYNTWobA0eejIpZ4AdxTM408HPmZtpfAfci29gsn5SQMN+ronAICUPiAArsgmn4xUNh6sJp8eA9ZkKlDXYqlWhY//YrZh6DPHJhFamuoWLUfhVLtVibEGqgJgr3tNjugEUoAVaxxsKNggRPZwhbAgMwDadMCoxROogAmSktUJoc3NUj8C/mEZd0Uo4S3DUrunmNEShhp6+RXFAdWi80p6ptK/6VqqTUz/tBVB9l3qVcIn1aEBxIRWq7cTifk+8t43GvERP2mZml/lNKzdi7z4wCyH4wheN6Nnw==;
Received: from static-191-95-145-212.ipcom.comunitel.net ([212.145.95.191]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hLBEx-0006XM-Ov; Mon, 29 Apr 2019 20:42:59 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hLBEl-0002ZU-8R; Mon, 29 Apr 2019 21:42:47 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 20:42:39 +0200
Message-Id:
 <1e84aa54bf7ac50636308384ac13ee89c4a1c850.1556562150.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH 4/5] block: Remove bdrv_read() and bdrv_write()
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
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429184239.DE1lWuKUASdpFKttO5IdzryhuMtnooo9DK9tnKep00U@z>

No one is using these functions anymore, all callers have switched to
the byte-based bdrv_pread() and bdrv_pwrite()

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c            | 36 ------------------------------------
 include/block/block.h |  4 ----
 2 files changed, 40 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfc153b8d8..adf759171a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -837,42 +837,6 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
     return rwco.ret;
 }
 
-/*
- * Process a synchronous request using coroutines
- */
-static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
-                      int nb_sectors, bool is_write, BdrvRequestFlags flags)
-{
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf,
-                                            nb_sectors * BDRV_SECTOR_SIZE);
-
-    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
-        return -EINVAL;
-    }
-
-    return bdrv_prwv_co(child, sector_num << BDRV_SECTOR_BITS,
-                        &qiov, is_write, flags);
-}
-
-/* return < 0 if error. See bdrv_write() for the return codes */
-int bdrv_read(BdrvChild *child, int64_t sector_num,
-              uint8_t *buf, int nb_sectors)
-{
-    return bdrv_rw_co(child, sector_num, buf, nb_sectors, false, 0);
-}
-
-/* Return < 0 if error. Important errors are:
-  -EIO         generic I/O error (may happen for all errors)
-  -ENOMEDIUM   No media inserted.
-  -EINVAL      Invalid sector number or nb_sectors
-  -EACCES      Trying to write a read-only device
-*/
-int bdrv_write(BdrvChild *child, int64_t sector_num,
-               const uint8_t *buf, int nb_sectors)
-{
-    return bdrv_rw_co(child, sector_num, (uint8_t *)buf, nb_sectors, true, 0);
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..5e2b98b0ee 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -316,10 +316,6 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                         BlockReopenQueue *queue, Error **errp);
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
 void bdrv_reopen_abort(BDRVReopenState *reopen_state);
-int bdrv_read(BdrvChild *child, int64_t sector_num,
-              uint8_t *buf, int nb_sectors);
-int bdrv_write(BdrvChild *child, int64_t sector_num,
-               const uint8_t *buf, int nb_sectors);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
-- 
2.11.0


