Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAEDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DD220684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dtirUoML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYmL-0004Ad-8G
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKa-0004ye-Ae
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKY-0005Ol-H7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40291 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKY-0005IN-3v; Thu, 24 Oct 2019 04:18:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrc1jf3z9sRs; Thu, 24 Oct 2019 19:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905120;
 bh=U2SbhbG10Q31T/En/uIElsIUQzlSawLqGYxd7BEmbcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dtirUoMLuKsi7E+qp3tzeIOrUhadgLyotNIf5jpZ5+lu3tl6tnMfiqiDQFiSIiGPp
 tcknkFlDUqiLfT2JtreCvylqRGSlGpKoAz9ZmJKqWc7iI5ibDEX06GF1anC46fpZK0
 rVH4gEXrReOoAuOazztjnAcv1+b82HimoIArXPYo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 28/28] spapr/xive: Set the OS CAM line at reset
Date: Thu, 24 Oct 2019 19:18:13 +1100
Message-Id: <20191024081813.2115-29-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When a Virtual Processor is scheduled to run on a HW thread, the
hypervisor pushes its identifier in the OS CAM line. When running with
kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.

Set the OS CAM line when the interrupt presenter of the sPAPR core is
reset. This will also cover the case of hot-plugged CPUs.

This change also has the benefit to remove the use of CPU_FOREACH()
which can be unsafe.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20191022163812.330-8-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 48 +++++++++++++------------------------
 include/hw/ppc/spapr_xive.h |  1 -
 2 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 20a8d8285f..d8e1291905 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -205,23 +205,6 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, bo=
ol enable)
     memory_region_set_enabled(&xive->end_source.esb_mmio, false);
 }
=20
-/*
- * When a Virtual Processor is scheduled to run on a HW thread, the
- * hypervisor pushes its identifier in the OS CAM line. Emulate the
- * same behavior under QEMU.
- */
-void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
-{
-    uint8_t  nvt_blk;
-    uint32_t nvt_idx;
-    uint32_t nvt_cam;
-
-    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
-
-    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, nvt=
_idx));
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
-}
-
 static void spapr_xive_end_reset(XiveEND *end)
 {
     memset(end, 0, sizeof(*end));
@@ -544,21 +527,32 @@ static int spapr_xive_cpu_intc_create(SpaprInterrup=
tController *intc,
     }
=20
     spapr_cpu->tctx =3D XIVE_TCTX(obj);
-
-    /*
-     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
-     * don't beneficiate from the reset of the XIVE IRQ backend
-     */
-    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
     return 0;
 }
=20
+static void xive_tctx_set_os_cam(XiveTCTX *tctx, uint32_t os_cam)
+{
+    uint32_t qw1w2 =3D cpu_to_be32(TM_QW1W2_VO | os_cam);
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+}
+
 static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
                                      PowerPCCPU *cpu)
 {
     XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
+    uint8_t  nvt_blk;
+    uint32_t nvt_idx;
=20
     xive_tctx_reset(tctx);
+
+    /*
+     * When a Virtual Processor is scheduled to run on a HW thread,
+     * the hypervisor pushes its identifier in the OS CAM line.
+     * Emulate the same behavior under QEMU.
+     */
+    spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
+
+    xive_tctx_set_os_cam(tctx, xive_nvt_cam_line(nvt_blk, nvt_idx));
 }
=20
 static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
@@ -651,14 +645,6 @@ static void spapr_xive_dt(SpaprInterruptController *=
intc, uint32_t nr_servers,
 static int spapr_xive_activate(SpaprInterruptController *intc, Error **e=
rrp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-        /* (TCG) Set the OS CAM line of the thread interrupt context. */
-        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
-    }
=20
     if (kvm_enabled()) {
         int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index d84bd5c229..742b7e834f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -57,7 +57,6 @@ typedef struct SpaprXive {
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
=20
 void spapr_xive_hcall_init(SpaprMachineState *spapr);
-void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
 void spapr_xive_map_mmio(SpaprXive *xive);
=20
--=20
2.21.0


