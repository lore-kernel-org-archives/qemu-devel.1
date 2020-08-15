Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C0C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E6723101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="azujKpAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E6723101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xmU-0003WU-R9
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k6xif-00070V-L2
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:03:41 -0400
Received: from mail-m9763.mail.163.com ([123.126.97.63]:46538)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k6xiZ-0006bQ-Jm
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=GRipXL1wXwapZA2mgs
 copNepRvF0IcwJJiMPyjZeykA=; b=azujKpAGdyW1XusGyBUlmjlsJOX41GpsTh
 CC75MfhSPyS9asHJGeQy7lduiMoUzP/ga8CGmVJl97jlifd1OGuOakfa77y7uY97
 /4gj4iSYi3dBHg2CO2r6Kuc9wsT3nMkcfuarJ9Wt0ZFsPcVtliDQ93qCZWcpx9L1
 c1R/km92g=
Received: from localhost.localdomain (unknown [115.204.244.155])
 by smtp5 (Coremail) with SMTP id HdxpCgBn0O7WjDdfslvODQ--.349S4;
 Sat, 15 Aug 2020 15:20:56 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jsnow@redhat.com,
	alxndr@bu.edu
Subject: [PATCH] hw: ide: check the pointer before do dma memory unmap
Date: Sat, 15 Aug 2020 00:20:52 -0700
Message-Id: <20200815072052.73228-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgBn0O7WjDdfslvODQ--.349S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4UGr4fuF17Zr1kZFy7Jrb_yoWfCrb_X3
 yfX348Wa95Jayj9w13tw4rJ347t395Jr1kurySgry3uF17Jay3JFW8t3ZrWrW3tFZrtrW3
 GF1F9FWrurWDKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1fWFUUUUUU==
X-Originating-IP: [115.204.244.155]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBmBbVaD6+TB1AAAsu
Received-SPF: pass client-ip=123.126.97.63; envelope-from=liq3ea@163.com;
 helo=mail-m9763.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 03:37:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In 'map_page' we need to check the return value of
'dma_memory_map' to ensure the we actully maped something.
Otherwise, we will hit an assert in 'address_space_unmap'.
This is because we can't find the MR with the NULL buffer.
This is the LP#1884693:

-->https://bugs.launchpad.net/qemu/+bug/1884693

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/ide/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 009120f88b..63e9fccdbe 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -250,6 +250,11 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
     }
 
     *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
+
+    if (!*ptr) {
+        return;
+    }
+
     if (len < wanted) {
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
         *ptr = NULL;
-- 
2.17.1


