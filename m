Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A2C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AAA20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="beeJyb4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AAA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQl2-00055l-9T
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@163.com>) id 1hfQjB-00032F-PY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1hfQiw-0006Ua-75
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:17:44 -0400
Received: from m12-14.163.com ([220.181.12.14]:43278)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1hfQik-0002cR-0y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=V5yl62g0Qv/QxvLell
 tpl1QAsqKgDuF2CwL6ufZTHpk=; b=beeJyb4gaD534U+iV+ow7uIa4cyAswfCMi
 EFMi02CyNF1mJTgonKOXdbYaeNH5ehLH1kuailaoZKV4fO8SsQwYCN9AU+7KySBN
 Je0IFlNo/gpnuiVyoivoWb8GIZM2ZHITL61UvW0I8f8zi4z4RUPMWgUfwI4Jikxl
 HcVk/8Bmg=
Received: from localhost.localdomain (unknown [115.200.202.73])
 by smtp10 (Coremail) with SMTP id DsCowACHnNlq6RBdnbOzCQ--.50452S2;
 Mon, 24 Jun 2019 23:16:59 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: peterx@redhat.com,
	mst@redhat.com,
	pbonzini@redhat.com
Date: Mon, 24 Jun 2019 08:16:35 -0700
Message-Id: <20190624151635.22494-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowACHnNlq6RBdnbOzCQ--.50452S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1UKrWrGryftrW7Gry7trb_yoW3JFX_Xa
 y8JFZ5u34DJr1Fva1DCF4xZr1fWw1rWrySk34xWF1vya45Xr4Dta1kXrZxXrnagFW7X3sx
 uFyrtry5ur43ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUHKuUUUUUU==
X-Originating-IP: [115.200.202.73]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTwzdbVsGQCGQZgAAs5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH] ioapic: clear irq_eoi when updating the ioapic
 redirect table entry
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

irq_eoi is used to count the number of irq injected during eoi
broadcast. It should be set to 0 when updating the ioapic's redirect
table entry.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/intc/ioapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 7074489fdf..db9e518602 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -380,6 +380,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
                 /* restore RO bits */
                 s->ioredtbl[index] &= IOAPIC_RW_BITS;
                 s->ioredtbl[index] |= ro_bits;
+                s->irq_eoi[index] = 0;
                 ioapic_fix_edge_remote_irr(&s->ioredtbl[index]);
                 ioapic_service(s);
             }
-- 
2.17.1



