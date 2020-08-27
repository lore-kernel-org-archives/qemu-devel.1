Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F71C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FEE2078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBn3IUtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FEE2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGHW-0000HX-KN
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGGY-0007it-I9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:40:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGGS-0005tZ-1g
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598528418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jOm04fHcXIfQRdrxPnd54zDgfa1WG07n38J3lSXxtU0=;
 b=EBn3IUtSXP2kMUZrp4pwM3EUDyX5VMlfEpsR9qJ6yozwhlVCTzesgOU8FxAWXONNtucreL
 RZ93M7lUVzh8sQOJClzmuhMcLOfUwccRSVYlgAE5oE30Z7tu7bnTaYckT6D765w8Yd5c7Q
 GskPp4PgzEwizwvgnJzRmZTtCrgamRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-HomIeHsqOiusVUpu1IIjfg-1; Thu, 27 Aug 2020 07:40:13 -0400
X-MC-Unique: HomIeHsqOiusVUpu1IIjfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 595E91DDFF;
 Thu, 27 Aug 2020 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-91.phx2.redhat.com
 [10.3.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A058B1972A;
 Thu, 27 Aug 2020 11:40:09 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: [PATCH] fdc: check null block pointer before blk_pwrite
Date: Thu, 27 Aug 2020 17:08:06 +0530
Message-Id: <20200827113806.1850687-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While transferring data via fdctrl_write_data(), check that
current drive does not have a null block pointer. Avoid
null pointer dereference.

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
 hw/block/fdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index e9ed3eef45..dedadac68a 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2419,7 +2419,8 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint32_t value)
         if (pos == FD_SECTOR_LEN - 1 ||
             fdctrl->data_pos == fdctrl->data_len) {
             cur_drv = get_cur_drv(fdctrl);
-            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
+            if (cur_drv->blk
+                && blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
                            BDRV_SECTOR_SIZE, 0) < 0) {
                 FLOPPY_DPRINTF("error writing sector %d\n",
                                fd_sector(cur_drv));
-- 
2.26.2


