Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A1C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D10820665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D10820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmmz-000889-0a
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfB-0001M0-AC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmf9-0006lp-8X
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46810 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmf4-0006hW-NK; Tue, 24 Sep 2019 11:23:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6C35B257579530C63335;
 Tue, 24 Sep 2019 23:23:27 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:21 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 10/12] arm/sdei: check KVM cap and enable SDEI
Date: Tue, 24 Sep 2019 23:21:49 +0800
Message-ID: <1569338511-3572-11-git-send-email-guoheyi@huawei.com>
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

Check KVM hypercall forward capability and enable it, and set global
flag "sdei_enabled" to true if everything works well.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/sdei.c | 17 +++++++++++++++++
 target/arm/sdei.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index efdb681..000545e 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -43,6 +43,7 @@
 #define TYPE_QEMU_SDEI "qemu_sdei"
 #define QEMU_SDEI(obj) OBJECT_CHECK(QemuSDEState, (obj), TYPE_QEMU_SDEI)
 
+bool sdei_enabled;
 static QemuSDEState *sde_state;
 
 typedef struct QemuSDEIBindNotifyEntry {
@@ -1465,6 +1466,7 @@ static const VMStateDescription vmstate_sde_state = {
 static void sdei_initfn(Object *obj)
 {
     QemuSDEState *s = QEMU_SDEI(obj);
+    KVMState *kvm = KVM_STATE(current_machine->accelerator);
 
     if (sde_state) {
         error_report("Only one SDEI dispatcher is allowed!");
@@ -1474,6 +1476,21 @@ static void sdei_initfn(Object *obj)
 
     qemu_sde_init(s);
     qemu_register_reset(qemu_sde_reset, s);
+
+    if (kvm_check_extension(kvm, KVM_CAP_FORWARD_HYPERCALL)) {
+        int ret;
+        ret = kvm_vm_enable_cap(kvm, KVM_CAP_FORWARD_HYPERCALL, 0,
+                                KVM_CAP_FORWARD_HYPERCALL_EXCL_PSCI);
+        if (ret < 0) {
+            error_report("Enable hypercall forwarding failed: %s",
+                         strerror(-ret));
+            abort();
+        }
+        sdei_enabled = true;
+        info_report("qemu sdei enabled");
+    } else {
+        info_report("KVM does not support forwarding hypercall.");
+    }
 }
 
 static void qemu_sde_class_init(ObjectClass *klass, void *data)
diff --git a/target/arm/sdei.h b/target/arm/sdei.h
index feaaf1a..95e7d8d 100644
--- a/target/arm/sdei.h
+++ b/target/arm/sdei.h
@@ -29,6 +29,8 @@
 
 #define SDEI_MAX_REQ        SDEI_1_0_FN(0x12)
 
+extern bool sdei_enabled;
+
 void sdei_handle_request(CPUState *cs, struct kvm_run *run);
 
 /*
-- 
1.8.3.1


