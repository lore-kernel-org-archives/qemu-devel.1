Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2EC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C59C2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C59C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmwN-0001GH-LL
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfD-0001Q0-Tw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfB-0006nk-Va
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46724 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmf4-0006hR-LV; Tue, 24 Sep 2019 11:23:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5EA36BE9A1306E7B3A53;
 Tue, 24 Sep 2019 23:23:27 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:17 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 05/12] arm/sdei: add support to trigger event by GIC
 interrupt ID
Date: Tue, 24 Sep 2019 23:21:44 +0800
Message-ID: <1569338511-3572-6-git-send-email-guoheyi@huawei.com>
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

Add an external interface to trigger an SDEI event bound to an
interrupt by providing GIC interrupt ID.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/sdei.c | 38 ++++++++++++++++++++++++++++++++++++++
 target/arm/sdei.h |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index f9a1208..088ed76 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -453,6 +453,29 @@ static int64_t sdei_version(QemuSDEState *s, CPUState *cs, struct kvm_run *run)
            (0ULL << SDEI_VERSION_MINOR_SHIFT);
 }
 
+static bool inject_event(QemuSDEState *s, CPUState *cs,
+                             int32_t event, int irq)
+{
+    QemuSDE *sde;
+
+    if (event < 0) {
+        return false;
+    }
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return false;
+    }
+    if (irq > 0 && sde->prop->interrupt != irq) {
+        /* Someone unbinds the interrupt! */
+        put_sde(sde, cs);
+        return false;
+    }
+    sde->pending = true;
+    dispatch_single(s, sde, cs);
+    return true;
+}
+
 static int64_t unregister_single_sde(QemuSDEState *s, int32_t event,
                                      CPUState *cs, bool force)
 {
@@ -1033,6 +1056,21 @@ void sdei_handle_request(CPUState *cs, struct kvm_run *run)
     }
 }
 
+bool trigger_sdei_by_irq(int cpu, int irq)
+{
+    QemuSDEState *s = sde_state;
+
+    if (!s || irq >= ARRAY_SIZE(s->irq_map)) {
+        return false;
+    }
+
+    if (s->irq_map[irq] == SDEI_INVALID_EVENT_ID) {
+        return false;
+    }
+
+    return inject_event(s, arm_get_cpu_by_id(cpu), s->irq_map[irq], irq);
+}
+
 static void qemu_shared_sde_init(QemuSDEState *s)
 {
     int i;
diff --git a/target/arm/sdei.h b/target/arm/sdei.h
index a69a0e4..a61e788 100644
--- a/target/arm/sdei.h
+++ b/target/arm/sdei.h
@@ -31,4 +31,11 @@
 
 void sdei_handle_request(CPUState *cs, struct kvm_run *run);
 
+/*
+ * Trigger an SDEI event bound to an interrupt.
+ * Return true if event has been triggered successfully.
+ * Return false if event has not been triggered for some reason.
+ */
+bool trigger_sdei_by_irq(int cpu, int irq);
+
 #endif
-- 
1.8.3.1


