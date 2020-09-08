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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12FAC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570E5206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i1VTksq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570E5206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgiZ-0008Qs-Fy
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghY-00075w-22
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:36 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:49894)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghV-0002Lj-Sc
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=ue6ZFmUxcoAPwFD/W8
 EjddlF4L1dxZ5iyH/qq+Mkd7Q=; b=i1VTksq9cypu4xvCMDCvtI5anP35ZHT7/V
 kvpQx75HCJXNXQ2oSNsjPvK7hR8FzJaUWhdxmrn729R6kL+E77+uJzKCdE31o5Cw
 lsXNcx76xC8TdEC0L06Y7vSirqLtljNYxn7MNWGcgB8EH0mKneHxQdPoisbPdDhF
 RnQJQ1w7U=
Received: from localhost.localdomain (unknown [183.158.94.209])
 by smtp5 (Coremail) with SMTP id HdxpCgCnGRhetFdf9j7RJg--.1087S8;
 Wed, 09 Sep 2020 00:42:15 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: dmitry.fleytman@gmail.com, jasowang@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
Subject: [RFC 4/4] hcd-xhci: use the new memory_region_init_io_with_dev
 interface
Date: Tue,  8 Sep 2020 09:41:57 -0700
Message-Id: <20200908164157.47108-5-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908164157.47108-1-liq3ea@163.com>
References: <20200908164157.47108-1-liq3ea@163.com>
X-CM-TRANSID: HdxpCgCnGRhetFdf9j7RJg--.1087S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykCFWfGF18ZrWxGr15urg_yoW8KFy5pF
 4fXas8WryfJFnIqrsxta1kZFs5A34kKryxGFyxA3sFqFs2kw1qya1Iyw1FkF97KrykJr45
 XF4rJF1fWw1DJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzmhrUUUUU=
X-Originating-IP: [183.158.94.209]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBZgeZbVaD53waIAAAsh
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

https://bugs.launchpad.net/qemu/+bug/1891354
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/usb/hcd-xhci.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 46a2186d91..1954ae2ae7 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3437,14 +3437,18 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
     memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
-    memory_region_init_io(&xhci->mem_cap, OBJECT(xhci), &xhci_cap_ops, xhci,
-                          "capabilities", LEN_CAP);
-    memory_region_init_io(&xhci->mem_oper, OBJECT(xhci), &xhci_oper_ops, xhci,
-                          "operational", 0x400);
-    memory_region_init_io(&xhci->mem_runtime, OBJECT(xhci), &xhci_runtime_ops, xhci,
-                          "runtime", LEN_RUNTIME);
-    memory_region_init_io(&xhci->mem_doorbell, OBJECT(xhci), &xhci_doorbell_ops, xhci,
-                          "doorbell", LEN_DOORBELL);
+    memory_region_init_io_with_dev(&xhci->mem_cap, OBJECT(xhci),
+                                   &xhci_cap_ops, xhci,
+                                   "capabilities", LEN_CAP, &dev->qdev);
+    memory_region_init_io_with_dev(&xhci->mem_oper, OBJECT(xhci),
+                                   &xhci_oper_ops, xhci,
+                                   "operational", 0x400, &dev->qdev);
+    memory_region_init_io_with_dev(&xhci->mem_runtime, OBJECT(xhci),
+                                   &xhci_runtime_ops, xhci,
+                                   "runtime", LEN_RUNTIME, &dev->qdev);
+    memory_region_init_io_with_dev(&xhci->mem_doorbell, OBJECT(xhci),
+                                   &xhci_doorbell_ops, xhci,
+                                   "doorbell", LEN_DOORBELL, &dev->qdev);
 
     memory_region_add_subregion(&xhci->mem, 0,            &xhci->mem_cap);
     memory_region_add_subregion(&xhci->mem, OFF_OPER,     &xhci->mem_oper);
@@ -3455,8 +3459,9 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
         XHCIPort *port = &xhci->ports[i];
         uint32_t offset = OFF_OPER + 0x400 + 0x10 * i;
         port->xhci = xhci;
-        memory_region_init_io(&port->mem, OBJECT(xhci), &xhci_port_ops, port,
-                              port->name, 0x10);
+        memory_region_init_io_with_dev(&port->mem, OBJECT(xhci),
+                                       &xhci_port_ops, port,
+                                       port->name, 0x10, &dev->qdev);
         memory_region_add_subregion(&xhci->mem, offset, &port->mem);
     }
 
-- 
2.17.1


