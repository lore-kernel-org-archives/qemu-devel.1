Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44610C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147C32146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ciE+6hfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147C32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih559-0006r4-Qd
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jE-0001SQ-F5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jC-0006qg-Tz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:00 -0500
Received: from ozlabs.org ([203.11.71.1]:33027)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jC-0006oL-Id; Mon, 16 Dec 2019 23:44:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWb6DfBz9sTH; Tue, 17 Dec 2019 15:43:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557819;
 bh=i12A5ZnvX8+6HSOGcBYPXVsT2ReFZORAeCbOhhExg7o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ciE+6hfZWU/jTd08hHd2J0fqBqIRp4Y6IxuI3o4FKqZIMPhIFtnBs/66hnX4UGcIQ
 HP3vxh9b6m+vnX/K8ofRMvO3oPp6FIObb4Z+izEgNpM5LPQmKPGyuYY6guMu8umN7S
 0H0pO+KB579T5JNxqDeZliPltCgQx1dJ9bsVChBI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 48/88] ppc/pnv: Introduce a pnv_xive_block_id() helper
Date: Tue, 17 Dec 2019 15:42:42 +1100
Message-Id: <20191217044322.351838-49-david@gibson.dropbear.id.au>
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

When PC_TCTXT_CHIPID_OVERRIDE is configured, the PC_TCTXT_CHIPID field
overrides the hardwired chip ID in the Powerbus operations and for CAM
compares. This is typically used in the one block-per-chip configuration
to associate a unique block id number to each IC of the system.

Simplify the model with a pnv_xive_block_id() helper and remove
'tctx_chipid' which becomes useless.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-19-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c        | 64 ++++++++++++++++++++-------------------
 include/hw/ppc/pnv_xive.h |  3 --
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 216ebc150a..23e73641f2 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -85,13 +85,30 @@ static inline uint64_t SETFIELD(uint64_t mask, uint64=
_t word,
     return (word & ~mask) | ((value << ctz64(mask)) & mask);
 }
=20
+/*
+ * When PC_TCTXT_CHIPID_OVERRIDE is configured, the PC_TCTXT_CHIPID
+ * field overrides the hardwired chip ID in the Powerbus operations
+ * and for CAM compares
+ */
+static uint8_t pnv_xive_block_id(PnvXive *xive)
+{
+    uint8_t blk =3D xive->chip->chip_id;
+    uint64_t cfg_val =3D xive->regs[PC_TCTXT_CFG >> 3];
+
+    if (cfg_val & PC_TCTXT_CHIPID_OVERRIDE) {
+        blk =3D GETFIELD(PC_TCTXT_CHIPID, cfg_val);
+    }
+
+    return blk;
+}
+
 /*
  * Remote access to controllers. HW uses MMIOs. For now, a simple scan
  * of the chips is good enough.
  *
  * TODO: Block scope support
  */
-static PnvXive *pnv_xive_get_ic(uint8_t blk)
+static PnvXive *pnv_xive_get_remote(uint8_t blk)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
     int i;
@@ -100,7 +117,7 @@ static PnvXive *pnv_xive_get_ic(uint8_t blk)
         Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
         PnvXive *xive =3D &chip9->xive;
=20
-        if (xive->chip->chip_id =3D=3D blk) {
+        if (pnv_xive_block_id(xive) =3D=3D blk) {
             return xive;
         }
     }
@@ -216,7 +233,7 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint=
32_t type, uint8_t blk,
=20
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
-        xive =3D pnv_xive_get_ic(blk);
+        xive =3D pnv_xive_get_remote(blk);
=20
         return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
     }
@@ -364,7 +381,10 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
 {
     PnvXive *xive =3D PNV_XIVE(xrtr);
=20
-    if (pnv_xive_get_ic(blk) !=3D xive) {
+    /*
+     * EAT lookups should be local to the IC
+     */
+    if (pnv_xive_block_id(xive) !=3D blk) {
         xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx))=
;
         return -1;
     }
@@ -470,7 +490,7 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
 static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno)
 {
     PnvXive *xive =3D PNV_XIVE(xn);
-    uint8_t blk =3D xive->chip->chip_id;
+    uint8_t blk =3D pnv_xive_block_id(xive);
=20
     xive_router_notify(xn, XIVE_EAS(blk, srcno));
 }
@@ -834,20 +854,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwad=
dr offset,
     case PC_TCTXT_CFG:
         /*
          * TODO: block group support
-         *
-         * PC_TCTXT_CFG_BLKGRP_EN
-         * PC_TCTXT_CFG_HARD_CHIPID_BLK :
-         *   Moves the chipid into block field for hardwired CAM compare=
s.
-         *   Block offset value is adjusted to 0b0..01 & ThrdId
-         *
-         *   Will require changes in xive_presenter_tctx_match(). I am
-         *   not sure how to handle that yet.
          */
-
-        /* Overrides hardwired chip ID with the chip ID field */
-        if (val & PC_TCTXT_CHIPID_OVERRIDE) {
-            xive->tctx_chipid =3D GETFIELD(PC_TCTXT_CHIPID, val);
-        }
         break;
     case PC_TCTXT_TRACK:
         /*
@@ -1656,19 +1663,20 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D =
{
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
-    uint8_t blk =3D xive->chip->chip_id;
+    uint8_t blk =3D pnv_xive_block_id(xive);
+    uint8_t chip_id =3D xive->chip->chip_id;
     uint32_t srcno0 =3D XIVE_EAS(blk, 0);
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
     XiveEAS eas;
     XiveEND end;
     int i;
=20
-    monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_ipis - 1);
+    monitor_printf(mon, "XIVE[%x] #%d Source %08x .. %08x\n", chip_id, b=
lk,
+                   srcno0, srcno0 + nr_ipis - 1);
     xive_source_pic_print_info(&xive->ipi_source, srcno0, mon);
=20
-    monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_ipis - 1);
+    monitor_printf(mon, "XIVE[%x] #%d EAT %08x .. %08x\n", chip_id, blk,
+                   srcno0, srcno0 + nr_ipis - 1);
     for (i =3D 0; i < nr_ipis; i++) {
         if (xive_router_get_eas(xrtr, blk, i, &eas)) {
             break;
@@ -1678,13 +1686,13 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
or *mon)
         }
     }
=20
-    monitor_printf(mon, "XIVE[%x] ENDT\n", blk);
+    monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i =3D 0;
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_pic_print_info(&end, i++, mon);
     }
=20
-    monitor_printf(mon, "XIVE[%x] END Escalation EAT\n", blk);
+    monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, bl=
k);
     i =3D 0;
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_eas_pic_print_info(&end, i++, mon);
@@ -1697,12 +1705,6 @@ static void pnv_xive_reset(void *dev)
     XiveSource *xsrc =3D &xive->ipi_source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
=20
-    /*
-     * Use the PnvChip id to identify the XIVE interrupt controller.
-     * It can be overriden by configuration at runtime.
-     */
-    xive->tctx_chipid =3D xive->chip->chip_id;
-
     /* Default page size (Should be changed at runtime to 64k) */
     xive->ic_shift =3D xive->vc_shift =3D xive->pc_shift =3D 12;
=20
diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 4fdaa9247d..f4c7caad40 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -72,9 +72,6 @@ typedef struct PnvXive {
     /* Interrupt controller registers */
     uint64_t      regs[0x300];
=20
-    /* Can be configured by FW */
-    uint32_t      tctx_chipid;
-
     /*
      * Virtual Structure Descriptor tables : EAT, SBE, ENDT, NVTT, IRQ
      * These are in a SRAM protected by ECC.
--=20
2.23.0


