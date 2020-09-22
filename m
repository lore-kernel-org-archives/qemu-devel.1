Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1EC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D132075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NITWVlbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D132075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKefN-0006NM-V6
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kKecM-0003Fw-Vf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kKecE-0006VA-EA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600766976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3GgwqzX7XMBe7c0URWFwkkHtsTYTiI3bXMAq9ylSl+o=;
 b=NITWVlbVNvJp+/+OErTAnNoZ51xMxl71brJkujq7IT5K+K3wGQIIWud+bOOdOMs7nXtBzp
 BCaPPm8V4A4+i8wbw8+PGWrcwa0jjz+ClgQYC4vO0ufXpRwBL4xuAFLgJpgEb/K9ZGOK22
 m6tV1oje3R12EcsOp5+RTdXl3vMTxnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-FujbP47UM5O5LNOdhWyaCg-1; Tue, 22 Sep 2020 05:29:31 -0400
X-MC-Unique: FujbP47UM5O5LNOdhWyaCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15364186DD26;
 Tue, 22 Sep 2020 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-36.sin2.redhat.com
 [10.67.117.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67AF229676;
 Tue, 22 Sep 2020 09:29:26 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: [PATCH v2] fdc: check null block pointer before r/w data transfer
Date: Tue, 22 Sep 2020 14:57:22 +0530
Message-Id: <20200922092722.344518-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Ruhr-University <bugs-syssec@rub.de>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While transferring data via fdctrl_read/write_data() routines,
check that current drive does not have a null block pointer.
Avoid null pointer dereference.

 -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Ffdc_nullptr1
    ==1658854==Hint: address points to the zero page.
    #0 blk_inc_in_flight block/block-backend.c:1327
    #1 blk_prw block/block-backend.c:1299
    #2 blk_pwrite block/block-backend.c:1464
    #3 fdctrl_write_data hw/block/fdc.c:2418
    #4 fdctrl_write hw/block/fdc.c:962
    #5 portio_write ioport.c:205
    #6 memory_region_write_accessor memory.c:483
    #7 access_with_adjusted_size memory.c:544
    #8 memory_region_dispatch_write memory.c:1476

Reported-by: Ruhr-University <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/block/fdc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Update v2: treat NULL blk pointer as an error
  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg06642.html

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 224bac504f..bf968dc66f 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1923,7 +1923,8 @@ static uint32_t fdctrl_read_data(FDCtrl *fdctrl)
                                    fd_sector(cur_drv));
                     return 0;
                 }
-            if (blk_pread(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
+            if (!cur_drv->blk
+                || blk_pread(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
                           BDRV_SECTOR_SIZE)
                 < 0) {
                 FLOPPY_DPRINTF("error getting sector %d\n",
@@ -2427,7 +2428,8 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint32_t value)
         if (pos == FD_SECTOR_LEN - 1 ||
             fdctrl->data_pos == fdctrl->data_len) {
             cur_drv = get_cur_drv(fdctrl);
-            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
+            if (!cur_drv->blk
+                || blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
                            BDRV_SECTOR_SIZE, 0) < 0) {
                 FLOPPY_DPRINTF("error writing sector %d\n",
                                fd_sector(cur_drv));
--
2.26.2


