Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF8C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDF020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDF020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnX0-0005O3-RP
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfA-0001LN-Pd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmf9-0006lk-2o
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46676 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmf4-0006hO-ID; Tue, 24 Sep 2019 11:23:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 58A3B3FBB55EA3E76511;
 Tue, 24 Sep 2019 23:23:27 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:16 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 04/12] arm/sdei: add system reset callback
Date: Tue, 24 Sep 2019 23:21:43 +0800
Message-ID: <1569338511-3572-5-git-send-email-guoheyi@huawei.com>
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
Cc: Mark
 Rutland <mark.rutland@arm.com>, Peter Maydell <peter.maydell@linaro.org>,
 James Morse <james.morse@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Jingyi Wang <wangjingyi11@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For this is a logical device which is not attached to system bus, we
cannot use DeviceClass->reset interface directly. Instead we register
our own reset callback to reset SDEI services when system resets.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/sdei.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index b40fa36..f9a1208 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -1083,6 +1083,26 @@ static void qemu_sde_init(QemuSDEState *s)
     qemu_private_sde_init(s);
 }
 
+static void qemu_sde_reset(void *opaque)
+{
+    int64_t         ret;
+    CPUState        *cs;
+    QemuSDEState    *s = opaque;
+
+    CPU_FOREACH(cs) {
+        QemuSDECpu *sde_cpu = get_sde_cpu(s, cs);
+        sdei_private_reset_common(s, cs, true);
+        sde_cpu->masked = true;
+        sde_cpu->critical_running_event = SDEI_INVALID_EVENT_ID;
+        sde_cpu->normal_running_event = SDEI_INVALID_EVENT_ID;
+    }
+
+    ret = sdei_shared_reset_common(s, first_cpu, true);
+    if (ret) {
+        error_report("SDEI system reset failed: 0x%lx", ret);
+    }
+}
+
 static int qemu_sdei_pre_save(void *opaque)
 {
     QemuSDEState *s = opaque;
@@ -1235,6 +1255,7 @@ static void sdei_initfn(Object *obj)
     sde_state = s;
 
     qemu_sde_init(s);
+    qemu_register_reset(qemu_sde_reset, s);
 }
 
 static void qemu_sde_class_init(ObjectClass *klass, void *data)
-- 
1.8.3.1


