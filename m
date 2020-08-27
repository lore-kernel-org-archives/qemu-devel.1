Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53C52177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlaF0skq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53C52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGNH-0003N6-Rh
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGMg-0002kc-Q8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:46:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47115
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGMe-0006w4-RB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598528803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tOsxx+fqigrLxDJOkhzgXsA2Ui9uyEGgNbc/S/z3OQ=;
 b=WlaF0skqH1EK4zpOzyPJR5sfhq+793cO3mubo79LhOUVqwQVUlCtEdCO6lH0mqQBy1g1r1
 T7tCA5H2Sfl7nDnYQjnlPCzQ8+R6hRVvlGjDL7qxo0TbZN8XKSm8Ohlq5YTSJyskqSS/bn
 Jao0y777z02Gt9f1jXQkrIkbInGuikg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-qmLmxje4MfWg5pPSO4SmoQ-1; Thu, 27 Aug 2020 07:46:35 -0400
X-MC-Unique: qmLmxje4MfWg5pPSO4SmoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03663185FD78;
 Thu, 27 Aug 2020 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-91.phx2.redhat.com
 [10.3.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADB735D9CC;
 Thu, 27 Aug 2020 11:46:31 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: [PATCH] hw/ide: check null block pointer before blk_drain
Date: Thu, 27 Aug 2020 17:14:28 +0530
Message-Id: <20200827114428.1850912-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While cancelling an i/o operation via ide_cancel_dma_sync(),
check for null block pointer before calling blk_drain(). Avoid
null pointer dereference.

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
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47..038af1cd6b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -718,7 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
      * whole DMA operation will be submitted to disk with a single
      * aio operation with preadv/pwritev.
      */
-    if (s->bus->dma->aiocb) {
+    if (s->blk && s->bus->dma->aiocb) {
         trace_ide_cancel_dma_sync_remaining();
         blk_drain(s->blk);
         assert(s->bus->dma->aiocb == NULL);
-- 
2.26.2


