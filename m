Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A09C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C811221721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kFyedJuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C811221721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCwV-00066r-QE
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59310)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC08-0006HM-Rf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC07-0003gi-2F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39415 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC06-0003Rl-DX; Tue, 02 Jul 2019 02:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp4n5rz9sRH; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=4RMAqbf0r+i90JTVL5P3MJmHRY9ilxQdu++8Qxjn/H8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kFyedJuwj/KqQvvyo8ebEyDW3gEea4ShsLr18S0thOw+ntodOODlHO3YG0aMCobqm
 jUoVIFot5mIB7fQC9uEzSapMyscruk9o+Z71fg1nujwmpt4CT9qdBRUcx0raf4TX22
 ixDwQb9tFUPVMtecoIZm8CTZvI7LZ5bsKOmLMrBo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:55 +1000
Message-Id: <20190702060857.3926-48-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 47/49] ppc/pnv: Rework cache watch model of
 PnvXIVE
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When the software modifies the XIVE internal structures, ESB, EAS,
END, NVT, it also must update the caches of the different XIVE
sub-engines. HW offers a set of common interface for such purpose.

The CWATCH_SPEC register defines the block/index of the target and a
set of flags to perform a full update and to watch for update
conflicts.

The cache watch CWATCH_DATAX registers are then loaded with the target
data with a first read on CWATCH_DATA0. Writing back is done in the
opposit order, CWATCH_DATA0 triggering the update.

The SCRUB_TRIG registers are used to flush the cache in RAM, and to
possibly invalidate it. Cache disablement is also an option but as we
do not model the cache, these registers are no-ops

Today, the modeling of these registers is incorrect but it did not
impact the set up of a baremetal system. However, running KVM requires
a rework.

Fixes: 2dfa91a2aa5a ("ppc/pnv: add a XIVE interrupt controller model for =
POWER9")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190630204601.30574-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c | 142 +++++++++++++++++++++++++++++++++------------
 1 file changed, 106 insertions(+), 36 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9ab77feee9..4dc92ef1e3 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -169,7 +169,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
     vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
=20
     if (!(vsd & VSD_ADDRESS_MASK)) {
-        xive_error(xive, "VST: invalid %s entry %x !?", info->name, 0);
+        xive_error(xive, "VST: invalid %s entry %x !?", info->name, idx)=
;
         return 0;
     }
=20
@@ -190,7 +190,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
         vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
=20
         if (!(vsd & VSD_ADDRESS_MASK)) {
-            xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
0);
+            xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
idx);
             return 0;
         }
=20
@@ -294,8 +294,12 @@ static int pnv_xive_write_end(XiveRouter *xrtr, uint=
8_t blk, uint32_t idx,
                               word_number);
 }
=20
-static int pnv_xive_end_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+static int pnv_xive_end_update(PnvXive *xive)
 {
+    uint8_t  blk =3D GETFIELD(VC_EQC_CWATCH_BLOCKID,
+                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
+    uint32_t idx =3D GETFIELD(VC_EQC_CWATCH_OFFSET,
+                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
     int i;
     uint64_t eqc_watch[4];
=20
@@ -307,6 +311,24 @@ static int pnv_xive_end_update(PnvXive *xive, uint8_=
t blk, uint32_t idx)
                               XIVE_VST_WORD_ALL);
 }
=20
+static void pnv_xive_end_cache_load(PnvXive *xive)
+{
+    uint8_t  blk =3D GETFIELD(VC_EQC_CWATCH_BLOCKID,
+                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
+    uint32_t idx =3D GETFIELD(VC_EQC_CWATCH_OFFSET,
+                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
+    uint64_t eqc_watch[4] =3D { 0 };
+    int i;
+
+    if (pnv_xive_vst_read(xive, VST_TSEL_EQDT, blk, idx, eqc_watch)) {
+        xive_error(xive, "VST: no END entry %x/%x !?", blk, idx);
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(eqc_watch); i++) {
+        xive->regs[(VC_EQC_CWATCH_DAT0 >> 3) + i] =3D be64_to_cpu(eqc_wa=
tch[i]);
+    }
+}
+
 static int pnv_xive_get_nvt(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
                             XiveNVT *nvt)
 {
@@ -320,8 +342,12 @@ static int pnv_xive_write_nvt(XiveRouter *xrtr, uint=
8_t blk, uint32_t idx,
                               word_number);
 }
=20
-static int pnv_xive_nvt_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+static int pnv_xive_nvt_update(PnvXive *xive)
 {
+    uint8_t  blk =3D GETFIELD(PC_VPC_CWATCH_BLOCKID,
+                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
+    uint32_t idx =3D GETFIELD(PC_VPC_CWATCH_OFFSET,
+                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
     int i;
     uint64_t vpc_watch[8];
=20
@@ -333,6 +359,24 @@ static int pnv_xive_nvt_update(PnvXive *xive, uint8_=
t blk, uint32_t idx)
                               XIVE_VST_WORD_ALL);
 }
=20
+static void pnv_xive_nvt_cache_load(PnvXive *xive)
+{
+    uint8_t  blk =3D GETFIELD(PC_VPC_CWATCH_BLOCKID,
+                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
+    uint32_t idx =3D GETFIELD(PC_VPC_CWATCH_OFFSET,
+                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
+    uint64_t vpc_watch[8] =3D { 0 };
+    int i;
+
+    if (pnv_xive_vst_read(xive, VST_TSEL_VPDT, blk, idx, vpc_watch)) {
+        xive_error(xive, "VST: no NVT entry %x/%x !?", blk, idx);
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(vpc_watch); i++) {
+        xive->regs[(PC_VPC_CWATCH_DAT0 >> 3) + i] =3D be64_to_cpu(vpc_wa=
tch[i]);
+    }
+}
+
 static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
                             XiveEAS *eas)
 {
@@ -346,12 +390,6 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
     return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
 }
=20
-static int pnv_xive_eas_update(PnvXive *xive, uint8_t blk, uint32_t idx)
-{
-    /* All done. */
-    return 0;
-}
-
 static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -950,28 +988,43 @@ static void pnv_xive_ic_reg_write(void *opaque, hwa=
ddr offset,
      * XIVE PC & VC cache updates for EAS, NVT and END
      */
     case VC_IVC_SCRUB_MASK:
-        break;
     case VC_IVC_SCRUB_TRIG:
-        pnv_xive_eas_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
-                            GETFIELD(VC_SCRUB_OFFSET, val));
         break;
=20
-    case VC_EQC_SCRUB_MASK:
     case VC_EQC_CWATCH_SPEC:
-    case VC_EQC_CWATCH_DAT0 ... VC_EQC_CWATCH_DAT3:
+        val &=3D ~VC_EQC_CWATCH_CONFLICT; /* HW resets this bit */
+        break;
+    case VC_EQC_CWATCH_DAT1 ... VC_EQC_CWATCH_DAT3:
         break;
+    case VC_EQC_CWATCH_DAT0:
+        /* writing to DATA0 triggers the cache write */
+        xive->regs[reg] =3D val;
+        pnv_xive_end_update(xive);
+        break;
+    case VC_EQC_SCRUB_MASK:
     case VC_EQC_SCRUB_TRIG:
-        pnv_xive_end_update(xive, GETFIELD(VC_SCRUB_BLOCK_ID, val),
-                            GETFIELD(VC_SCRUB_OFFSET, val));
+        /*
+         * The scrubbing registers flush the cache in RAM and can also
+         * invalidate.
+         */
         break;
=20
-    case PC_VPC_SCRUB_MASK:
     case PC_VPC_CWATCH_SPEC:
-    case PC_VPC_CWATCH_DAT0 ... PC_VPC_CWATCH_DAT7:
+        val &=3D ~PC_VPC_CWATCH_CONFLICT; /* HW resets this bit */
+        break;
+    case PC_VPC_CWATCH_DAT1 ... PC_VPC_CWATCH_DAT7:
         break;
+    case PC_VPC_CWATCH_DAT0:
+        /* writing to DATA0 triggers the cache write */
+        xive->regs[reg] =3D val;
+        pnv_xive_nvt_update(xive);
+        break;
+    case PC_VPC_SCRUB_MASK:
     case PC_VPC_SCRUB_TRIG:
-        pnv_xive_nvt_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
-                           GETFIELD(PC_SCRUB_OFFSET, val));
+        /*
+         * The scrubbing registers flush the cache in RAM and can also
+         * invalidate.
+         */
         break;
=20
=20
@@ -1022,15 +1075,6 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque,=
 hwaddr offset, unsigned size)
     case PC_GLOBAL_CONFIG:
=20
     case PC_VPC_SCRUB_MASK:
-    case PC_VPC_CWATCH_SPEC:
-    case PC_VPC_CWATCH_DAT0:
-    case PC_VPC_CWATCH_DAT1:
-    case PC_VPC_CWATCH_DAT2:
-    case PC_VPC_CWATCH_DAT3:
-    case PC_VPC_CWATCH_DAT4:
-    case PC_VPC_CWATCH_DAT5:
-    case PC_VPC_CWATCH_DAT6:
-    case PC_VPC_CWATCH_DAT7:
=20
     case VC_GLOBAL_CONFIG:
     case VC_AIB_TX_ORDER_TAG2:
@@ -1043,12 +1087,6 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque,=
 hwaddr offset, unsigned size)
     case VC_IRQ_CONFIG_IPI_CASC:
=20
     case VC_EQC_SCRUB_MASK:
-    case VC_EQC_CWATCH_DAT0:
-    case VC_EQC_CWATCH_DAT1:
-    case VC_EQC_CWATCH_DAT2:
-    case VC_EQC_CWATCH_DAT3:
-
-    case VC_EQC_CWATCH_SPEC:
     case VC_IVC_SCRUB_MASK:
     case VC_SBC_CONFIG:
     case VC_AT_MACRO_KILL_MASK:
@@ -1080,6 +1118,38 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque,=
 hwaddr offset, unsigned size)
     /*
      * XIVE PC & VC cache updates for EAS, NVT and END
      */
+    case VC_EQC_CWATCH_SPEC:
+        xive->regs[reg] =3D ~(VC_EQC_CWATCH_FULL | VC_EQC_CWATCH_CONFLIC=
T);
+        val =3D xive->regs[reg];
+        break;
+    case VC_EQC_CWATCH_DAT0:
+        /*
+         * Load DATA registers from cache with data requested by the
+         * SPEC register
+         */
+        pnv_xive_end_cache_load(xive);
+        val =3D xive->regs[reg];
+        break;
+    case VC_EQC_CWATCH_DAT1 ... VC_EQC_CWATCH_DAT3:
+        val =3D xive->regs[reg];
+        break;
+
+    case PC_VPC_CWATCH_SPEC:
+        xive->regs[reg] =3D ~(PC_VPC_CWATCH_FULL | PC_VPC_CWATCH_CONFLIC=
T);
+        val =3D xive->regs[reg];
+        break;
+    case PC_VPC_CWATCH_DAT0:
+        /*
+         * Load DATA registers from cache with data requested by the
+         * SPEC register
+         */
+        pnv_xive_nvt_cache_load(xive);
+        val =3D xive->regs[reg];
+        break;
+    case PC_VPC_CWATCH_DAT1 ... PC_VPC_CWATCH_DAT7:
+        val =3D xive->regs[reg];
+        break;
+
     case PC_VPC_SCRUB_TRIG:
     case VC_IVC_SCRUB_TRIG:
     case VC_EQC_SCRUB_TRIG:
--=20
2.21.0


