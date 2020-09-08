Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA74C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BE2206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E0jL09vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BE2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgiX-0008MH-AY
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghW-00075N-E7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:34 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:49878)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghS-0002Lc-MY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=sPsqanpMwV8rF74sva
 ZiLXEHyS8k70SBROldCWnc19c=; b=E0jL09vlZ4vdpEaza0ZruF3Go798GSvsve
 SAy5K4QcTeXdSlIZL58szZ1/cOADnyM8D9fpQkWxvnEMMYaIuMLmjODLJ5m0dJi1
 W+iGmVvJQHsQcI7cWeMLNqXhE8f8JaNI9exgP6L6jca/cGIdd3mceBgMs+k5J5k5
 eL2+BNltQ=
Received: from localhost.localdomain (unknown [183.158.94.209])
 by smtp5 (Coremail) with SMTP id HdxpCgCnGRhetFdf9j7RJg--.1087S7;
 Wed, 09 Sep 2020 00:42:12 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: dmitry.fleytman@gmail.com, jasowang@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
Subject: [RFC 3/4] e1000e: use the new memory_region_init_io_with_dev interface
Date: Tue,  8 Sep 2020 09:41:56 -0700
Message-Id: <20200908164157.47108-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908164157.47108-1-liq3ea@163.com>
References: <20200908164157.47108-1-liq3ea@163.com>
X-CM-TRANSID: HdxpCgCnGRhetFdf9j7RJg--.1087S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw18ZF45XF43WF1kJrWxCrg_yoW8Gry7p3
 yfJ3Z5uryrtFZFvF429F18WFn5JwsFq348Cr4UZw4Sga9FgF1qyr1FyF4ayrWI9ayUAryr
 Za18tryI9w4DtwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb0eQUUUUU=
X-Originating-IP: [183.158.94.209]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKQaZbVXlxmTIXwAAse
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:42:19
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can avoid the DMA to MMIO issue here:

https://bugs.launchpad.net/qemu/+bug/1886362
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/net/e1000e.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index fda34518c9..0aac5cea2e 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -439,8 +439,8 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     s->subsys_used = s->subsys;
 
     /* Define IO/MMIO regions */
-    memory_region_init_io(&s->mmio, OBJECT(s), &mmio_ops, s,
-                          "e1000e-mmio", E1000E_MMIO_SIZE);
+    memory_region_init_io_with_dev(&s->mmio, OBJECT(s), &mmio_ops, s,
+                          "e1000e-mmio", E1000E_MMIO_SIZE, &pci_dev->qdev);
     pci_register_bar(pci_dev, E1000E_MMIO_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
 
@@ -453,8 +453,8 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, E1000E_FLASH_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY, &s->flash);
 
-    memory_region_init_io(&s->io, OBJECT(s), &io_ops, s,
-                          "e1000e-io", E1000E_IO_SIZE);
+    memory_region_init_io_with_dev(&s->io, OBJECT(s), &io_ops, s,
+                          "e1000e-io", E1000E_IO_SIZE, &pci_dev->qdev);
     pci_register_bar(pci_dev, E1000E_IO_IDX,
                      PCI_BASE_ADDRESS_SPACE_IO, &s->io);
 
-- 
2.17.1


