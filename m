Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E0C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8E720709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZebIJuR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8E720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDu4V-0004iY-OD
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDu3Y-0004Hn-Jc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:33:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDu3W-0003C5-4A
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599158032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mhuHg2UUlQ5+ztLojjQBo/7d9vvLmT7q8pONMIvh4k4=;
 b=ZebIJuR9EN0NJmNn6FawrGD7XQHVPKrHqIIgrVlAmsfXeo1TFgs11bZQLzcLjV6Nk1Wpf7
 cGLIJizjyhLZzKUcR6akEmaDPHT1izqV5NHIwcqyyoBByxqct+hIH4ic3Wf+vgNG36D02l
 jklpvy4I2ihTuJ2R4jVeXYh0sXz38D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-jzfuBiPYNAmKQ5DWOEd_DQ-1; Thu, 03 Sep 2020 14:33:47 -0400
X-MC-Unique: jzfuBiPYNAmKQ5DWOEd_DQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B6E6425DE;
 Thu,  3 Sep 2020 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-113-31.rdu2.redhat.com
 [10.10.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B12521C4;
 Thu,  3 Sep 2020 18:33:42 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
Date: Fri,  4 Sep 2020 00:01:38 +0530
Message-Id: <20200903183138.2161977-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: John Snow <jsnow@redhat.com>, Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When cancelling an i/o operation via ide_cancel_dma_sync(),
a block pointer may be null. Add check to avoid null pointer
dereference.

 -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fide_nullptr1
 ==1803100==Hint: address points to the zero page.
 #0 blk_bs ../block/block-backend.c:714
 #1 blk_drain ../block/block-backend.c:1715
 #2 ide_cancel_dma_sync ../hw/ide/core.c:723
 #3 bmdma_cmd_writeb ../hw/ide/pci.c:298
 #4 bmdma_write ../hw/ide/piix.c:75
 #5 memory_region_write_accessor ../softmmu/memory.c:483
 #6 access_with_adjusted_size ../softmmu/memory.c:544
 #7 memory_region_dispatch_write ../softmmu/memory.c:1465
 #8 flatview_write_continue ../exec.c:3176
 ...

Reported-by: Ruhr-University <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ide/core.c | 1 +
 hw/ide/pci.c  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

Update v2: use an assert() call
 -> https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.html

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f76f7e5234..8105187f49 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -718,6 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
      * whole DMA operation will be submitted to disk with a single
      * aio operation with preadv/pwritev.
      */
+    assert(s->blk);
     if (s->bus->dma->aiocb) {
         trace_ide_cancel_dma_sync_remaining();
         blk_drain(s->blk);
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index b50091b615..b47e675456 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -295,7 +295,10 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
     /* Ignore writes to SSBM if it keeps the old value */
     if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
         if (!(val & BM_CMD_START)) {
-            ide_cancel_dma_sync(idebus_active_if(bm->bus));
+            IDEState *s = idebus_active_if(bm->bus);
+            if (s->blk) {
+                ide_cancel_dma_sync(s);
+            }
             bm->status &= ~BM_STATUS_DMAING;
         } else {
             bm->cur_addr = bm->addr;
-- 
2.26.2


