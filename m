Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86540C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3072087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TWdWK56h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3072087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLBGo-0004NU-HS
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:44:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF2-0003Hj-89
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF1-0002Qm-0a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hLBF0-0002Pg-Nx; Mon, 29 Apr 2019 14:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=5hlDL+SlzXFcKk1w5AWpFGHs9i0tIxFXhQcbdcq/eUc=; 
	b=TWdWK56h0zWgVBidKJ87DOAgy77Fe38anPxzetala46g4JehY5TCSU6/0WxOuyM8D+5jTymGgFY7mL86PD4ZXD0z+35YLY9LdThIJaKviiGT6OVCRQ3X72JRnP7KyxueWxST2NrJ4ByX7nLi+3ziabiMq/4pXe2XFFLOnjQE5u/mBlVDM6PVQFYXpxD6offCEqG8RnI2uyf4+Ik0Ews9HMygPa3xHuBxFbis83tK81e8DewuucvUuQ3j3BUi0VB70XCngUMbMHz4fjTq+s6mxYzaBU6xGkdi0wLtwHDLboLx9mMyYhTLR2qEfP1Z3NAGbkpiSWLOH+50ZvD6/l4Sgw==;
Received: from static-191-95-145-212.ipcom.comunitel.net ([212.145.95.191]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hLBEx-0006XL-NH; Mon, 29 Apr 2019 20:42:59 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hLBEl-0002ZP-5w; Mon, 29 Apr 2019 21:42:47 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 20:42:38 +0200
Message-Id:
 <08ed89d9905a7143201743ec8003058a083c7b72.1556562150.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Message-ID: <20190429184238.xDoI-rJCEXIMFsqim_nhW6RTNbTA-rmnCTMpRMpsmJk@z>

There's only a couple of bdrv_read() and bdrv_write() calls left in
the vvfat code, and they can be trivially replaced with the byte-based
bdrv_pread() and bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/vvfat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 5f66787890..35c7e2761f 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1494,8 +1494,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
                 DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
                              " allocated\n", sector_num,
                              n >> BDRV_SECTOR_BITS));
-                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
-                              n >> BDRV_SECTOR_BITS)) {
+                if (bdrv_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE,
+                               buf + i * 0x200, n)) {
                     return -1;
                 }
                 i += (n >> BDRV_SECTOR_BITS) - 1;
@@ -1983,7 +1983,8 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
                         if (res) {
                             return -1;
                         }
-                        res = bdrv_write(s->qcow, offset, s->cluster_buffer, 1);
+                        res = bdrv_pwrite(s->qcow, offset * BDRV_SECTOR_SIZE,
+                                          s->cluster_buffer, BDRV_SECTOR_SIZE);
                         if (res) {
                             return -2;
                         }
@@ -3050,7 +3051,8 @@ DLOG(checkpoint());
      * Use qcow backend. Commit later.
      */
 DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
-    ret = bdrv_write(s->qcow, sector_num, buf, nb_sectors);
+    ret = bdrv_pwrite(s->qcow, sector_num * BDRV_SECTOR_SIZE, buf,
+                      nb_sectors * BDRV_SECTOR_SIZE);
     if (ret < 0) {
         fprintf(stderr, "Error writing to qcow backend\n");
         return ret;
-- 
2.11.0


