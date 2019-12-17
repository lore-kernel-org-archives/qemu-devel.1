Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25469C2D0C5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E834A2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m6i7wqdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E834A2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Kj-0005U8-Jk
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jK-0001c4-QC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jJ-00070z-EE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45849 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jJ-0006Qf-2I; Mon, 16 Dec 2019 23:45:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWZ6LY5z9sTB; Tue, 17 Dec 2019 15:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557818;
 bh=X9t78hdpVHh941VAJHuK29vpxbHkZ/R4dADMSE3VC54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m6i7wqdO4d4YBwzEhzwovnqyySwkfV6NhXCK81IqPjFW1L1mUmxKh1b8JHuJ/cz5R
 U91fUiLu+IoB0LEOEL95sIlVeIYS1ldTS0aIPIqgmii8wnuvwNjUKEgREckfj5dcn+
 xkAS1eMJINs1qgya4oZs0pGxSGr1l4v2UQX8RnSI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 43/88] ppc/pnv: Clarify how the TIMA is accessed on a multichip
 system
Date: Tue, 17 Dec 2019 15:42:37 +1100
Message-Id: <20191217044322.351838-44-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The TIMA region gives access to the thread interrupt context registers
of a CPU. It is mapped at the same address on all chips and can be
accessed by any CPU of the system. To identify the chip from which the
access is being done, the PowerBUS uses a 'chip' field in the
load/store messages. QEMU does not model these messages, instead, we
extract the chip id from the CPU PIR and do a lookup at the machine
level to fetch the targeted interrupt controller.

Introduce pnv_get_chip() and pnv_xive_tm_get_xive() helpers to clarify
this process in pnv_xive_get_tctx(). The latter will be removed in the
subsequent patches but the same principle will be kept.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-14-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c   | 40 +++++++++++++++++++++++-----------------
 hw/ppc/pnv.c         | 14 ++++++++++++++
 include/hw/ppc/pnv.h |  3 +++
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 95e9de312c..db9d9c11a8 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -439,31 +439,37 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
     return count;
 }
=20
+/*
+ * The TIMA MMIO space is shared among the chips and to identify the
+ * chip from which the access is being done, we extract the chip id
+ * from the PIR.
+ */
+static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
+{
+    int pir =3D ppc_cpu_pir(cpu);
+    PnvChip *chip;
+    PnvXive *xive;
+
+    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
+    assert(chip);
+    xive =3D &PNV9_CHIP(chip)->xive;
+
+    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+        xive_error(xive, "IC: CPU %x is not enabled", pir);
+    }
+    return xive;
+}
+
 static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-    PnvXive *xive =3D NULL;
-    CPUPPCState *env =3D &cpu->env;
-    int pir =3D env->spr_cb[SPR_PIR].default_value;
+    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
=20
-    /*
-     * Perform an extra check on the HW thread enablement.
-     *
-     * The TIMA is shared among the chips and to identify the chip
-     * from which the access is being done, we extract the chip id
-     * from the PIR.
-     */
-    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
     if (!xive) {
         return NULL;
     }
=20
-    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
-        xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
-    }
-
-    return tctx;
+    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
 }
=20
 /*
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5b8b07f6ae..fa656858b2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1472,6 +1472,20 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t =
format,
     return total_count;
 }
=20
+PnvChip *pnv_get_chip(uint32_t chip_id)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        PnvChip *chip =3D pnv->chips[i];
+        if (chip->chip_id =3D=3D chip_id) {
+            return chip;
+        }
+    }
+    return NULL;
+}
+
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index a58cfea3f2..3a7bc3c57e 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -103,6 +103,7 @@ typedef struct Pnv9Chip {
  * A SMT8 fused core is a pair of SMT4 cores.
  */
 #define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
+#define PNV9_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
=20
 typedef struct PnvChipClass {
     /*< private >*/
@@ -197,6 +198,8 @@ static inline bool pnv_is_power9(PnvMachineState *pnv=
)
     return pnv_chip_is_power9(pnv->chips[0]);
 }
=20
+PnvChip *pnv_get_chip(uint32_t chip_id);
+
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
=20
--=20
2.23.0


