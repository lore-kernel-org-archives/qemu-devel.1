Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5965C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2E220673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2E220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnSL-0001Wj-4w
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfB-0001Li-4Q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmf9-0006lw-DV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46632 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmf4-0006hL-N5; Tue, 24 Sep 2019 11:23:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 51FF67C2680FDC283024;
 Tue, 24 Sep 2019 23:23:27 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:18 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 06/12] core/irq: add qemu_irq_remove_intercept interface
Date: Tue, 24 Sep 2019 23:21:45 +0800
Message-ID: <1569338511-3572-7-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 James Morse <james.morse@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use qemu_irq as the bridge for other qemu modules to switch from
irq injection to SDEI event trigger after VM binds the interrupt to
SDEI event. We use qemu_irq_intercept_in() to override qemu_irq
handler with SDEI event trigger, so we also need a corresponding
interface to restore the handler to default one (i.e. ARM GIC).

qemu_irq_remove_intercept() is the new interface to do the above
job.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 hw/core/irq.c    | 11 +++++++++++
 include/hw/irq.h |  8 ++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 7cc0295..114bce6 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -145,6 +145,17 @@ void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
     }
 }
 
+void qemu_irq_remove_intercept(qemu_irq *gpio_in, int n)
+{
+    int i;
+    qemu_irq *old_irqs = gpio_in[0]->opaque;
+    for (i = 0; i < n; i++) {
+        gpio_in[i]->handler = old_irqs[i]->handler;
+        gpio_in[i]->opaque = old_irqs[i]->opaque;
+    }
+    qemu_free_irqs(old_irqs, n);
+}
+
 static const TypeInfo irq_type_info = {
    .name = TYPE_IRQ,
    .parent = TYPE_OBJECT,
diff --git a/include/hw/irq.h b/include/hw/irq.h
index fe527f6..1af1db9 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -56,8 +56,12 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
  */
 qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
 
-/* For internal use in qtest.  Similar to qemu_irq_split, but operating
-   on an existing vector of qemu_irq.  */
+/*
+ * Similar to qemu_irq_split, but operating on an existing vector of qemu_irq.
+ */
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
 
+/* Restore the irq handler intercepted by qemu_irq_intercept_in() */
+void qemu_irq_remove_intercept(qemu_irq *gpio_in, int n);
+
 #endif
-- 
1.8.3.1


