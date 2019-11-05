Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0BC49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCF0217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCF0217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRuuW-0006w0-Id
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRusx-00051t-AF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusw-0007mn-35
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2192 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRuss-0007hm-V6; Tue, 05 Nov 2019 04:12:19 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2B7146A7B79F7F75ACDF;
 Tue,  5 Nov 2019 17:12:13 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:06 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 07/14] arm/sdei: add support to trigger event by GIC
 interrupt ID
Date: Tue, 5 Nov 2019 17:10:49 +0800
Message-ID: <20191105091056.9541-8-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
 target/arm/sdei.c | 37 +++++++++++++++++++++++++++++++++++++
 target/arm/sdei.h |  7 +++++++
 2 files changed, 44 insertions(+)

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index 6af4a9044b..713ac97775 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -476,6 +476,28 @@ static int64_t sdei_version(QemuSDEState *s, CPUStat=
e *cs, struct kvm_run *run)
            (0ULL << SDEI_VERSION_MINOR_SHIFT);
 }
=20
+static bool inject_event(QemuSDEState *s, CPUState *cs, int32_t event, i=
nt irq)
+{
+    QemuSDE *sde;
+
+    if (event < 0) {
+        return false;
+    }
+    sde =3D get_sde_no_check(s, event, cs);
+    if (sde->event_id =3D=3D SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return false;
+    }
+    if (irq > 0 && sde->prop->interrupt !=3D irq) {
+        /* Someone unbinds the interrupt! */
+        put_sde(sde, cs);
+        return false;
+    }
+    sde->pending =3D true;
+    dispatch_single(s, sde, cs);
+    return true;
+}
+
 static int64_t unregister_single_sde(QemuSDEState *s, int32_t event,
                                      CPUState *cs, bool force)
 {
@@ -1104,6 +1126,21 @@ void sdei_handle_request(CPUState *cs, struct kvm_=
run *run)
     }
 }
=20
+bool trigger_sdei_by_irq(int cpu, int irq)
+{
+    QemuSDEState *s =3D sde_state;
+
+    if (!s || irq >=3D ARRAY_SIZE(s->irq_map)) {
+        return false;
+    }
+
+    if (s->irq_map[irq] =3D=3D SDEI_INVALID_EVENT_ID) {
+        return false;
+    }
+
+    return inject_event(s, qemu_get_cpu(cpu), s->irq_map[irq], irq);
+}
+
 static void sde_array_init(QemuSDE **array, int count)
 {
     int i;
diff --git a/target/arm/sdei.h b/target/arm/sdei.h
index 828f70bbf1..5ecc32d667 100644
--- a/target/arm/sdei.h
+++ b/target/arm/sdei.h
@@ -31,4 +31,11 @@
=20
 void sdei_handle_request(CPUState *cs, struct kvm_run *run);
=20
+/*
+ * Trigger an SDEI event bound to an interrupt.
+ * Return true if event has been triggered successfully.
+ * Return false if event has not been triggered for some reason.
+ */
+bool trigger_sdei_by_irq(int cpu, int irq);
+
 #endif
--=20
2.19.1


