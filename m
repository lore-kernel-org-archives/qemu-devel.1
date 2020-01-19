Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E4C33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 13:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B39820663
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 13:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B39820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itAiP-0003qW-7E
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 08:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1itAgy-0003J2-DS
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 08:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1itAgx-0007zE-Ai
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 08:32:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2688 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1itAgu-0007uI-Hl; Sun, 19 Jan 2020 08:32:36 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0BB7FE69CDB940A01276;
 Sun, 19 Jan 2020 21:32:27 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sun, 19 Jan 2020 21:32:17 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH] hw/intc/arm_gicv3_kvm: Stop wrongly programming
 GICR_PENDBASER.PTZ bit
Date: Sun, 19 Jan 2020 21:30:51 +0800
Message-ID: <20200119133051.642-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.222.27]
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, wanghaibin.wang@huawei.com,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If LPIs are disabled, KVM will just ignore the GICR_PENDBASER.PTZ bit whe=
n
restoring GICR_CTLR.  Setting PTZ here makes littlt sense in "reduce GIC
initialization time".

And what's worse, PTZ is generally programmed by guest to indicate to the
Redistributor whether the LPI Pending table is zero when enabling LPIs.
If migration is triggered when the PTZ has just been cleared by guest (an=
d
before enabling LPIs), we will see PTZ=3D=3D1 on the destination side, wh=
ich
is not as expected.  Let's just drop this hackish userspace behavior.

Also take this chance to refine the comment a bit.

Fixes: 367b9f527bec ("hw/intc/arm_gicv3_kvm: Implement get/put functions"=
)
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9c7f4ab871..49304ca589 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -336,7 +336,10 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     kvm_gicd_access(s, GICD_CTLR, &reg, true);
=20
     if (redist_typer & GICR_TYPER_PLPIS) {
-        /* Set base addresses before LPIs are enabled by GICR_CTLR write=
 */
+        /*
+         * Restore base addresses before LPIs are potentially enabled by
+         * GICR_CTLR write
+         */
         for (ncpu =3D 0; ncpu < s->num_cpu; ncpu++) {
             GICv3CPUState *c =3D &s->cpu[ncpu];
=20
@@ -347,12 +350,6 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
=20
             reg64 =3D c->gicr_pendbaser;
-            if (!(c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS)) {
-                /* Setting PTZ is advised if LPIs are disabled, to reduc=
e
-                 * GIC initialization time.
-                 */
-                reg64 |=3D GICR_PENDBASER_PTZ;
-            }
             regl =3D (uint32_t)reg64;
             kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, true);
             regh =3D (uint32_t)(reg64 >> 32);
--=20
2.19.1



