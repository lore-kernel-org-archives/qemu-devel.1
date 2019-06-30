Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BCEC5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17122089F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17122089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgnm-0005cF-6N
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgjR-0000Fc-Js
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgjO-0002eR-2h
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:29 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:53705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgjM-0002Zx-00
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:24 -0400
Received: from player157.ha.ovh.net (unknown [10.109.160.143])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 222D2137712
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:47:21 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id C245E7575B1C;
 Sun, 30 Jun 2019 20:47:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:46:01 +0200
Message-Id: <20190630204601.30574-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2294865489247046630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.26
Subject: [Qemu-devel] [PATCH 10/10] ppc/pnv: Dump the XIVE NVT table
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is to track the configuration of the base END index of the vCPU
and the Interrupt Pending Buffer. The NVT IPB is updated when an
interrupt can not be presented to a vCPU.

We try to loop on the full table skipping empty indirect pages which
are not necessarily allocated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h |  2 ++
 hw/intc/pnv_xive.c         | 60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 7ba0fb055174..50802bbdaab0 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -229,6 +229,8 @@ typedef struct XiveNVT {
         uint32_t        w0;
 #define NVT_W0_VALID             PPC_BIT32(0)
         uint32_t        w1;
+#define NVT_W1_EQ_BLOCK          PPC_BITMASK32(0, 3)
+#define NVT_W1_EQ_INDEX          PPC_BITMASK32(4, 31)
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ff1226485983..8778c11623dc 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -121,6 +121,20 @@ static uint64_t pnv_xive_vst_page_size_allowed(uint3=
2_t page_shift)
          page_shift =3D=3D 21 || page_shift =3D=3D 24;
 }
=20
+static uint64_t pnv_xive_vst_indirect_page_shift(uint64_t vsd)
+{
+    uint32_t page_shift;
+
+    vsd =3D ldq_be_dma(&address_space_memory, vsd & VSD_ADDRESS_MASK);
+    page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
+
+    if (!pnv_xive_vst_page_size_allowed(page_shift)) {
+        return 0;
+    }
+
+    return page_shift;
+}
+
 static uint64_t pnv_xive_vst_size(uint64_t vsd)
 {
     uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
@@ -466,6 +480,24 @@ static uint32_t pnv_xive_nr_ends(PnvXive *xive)
         / vst_infos[VST_TSEL_EQDT].size;
 }
=20
+static uint32_t pnv_xive_nr_indirect(PnvXive *xive, uint32_t type)
+{
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint8_t blk =3D xive->chip->chip_id;
+    uint32_t page_shift =3D
+        pnv_xive_vst_indirect_page_shift(xive->vsds[type][blk]);
+
+    return (1ull << page_shift) / info->size;
+}
+
+static uint32_t pnv_xive_nr_nvts(PnvXive *xive)
+{
+    uint8_t blk =3D xive->chip->chip_id;
+
+    return pnv_xive_vst_size(xive->vsds[VST_TSEL_VPDT][blk])
+        / vst_infos[VST_TSEL_VPDT].size;
+}
+
 /*
  * EDT Table
  *
@@ -1560,6 +1592,21 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
     },
 };
=20
+static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
+                                    Monitor *mon)
+{
+    uint8_t  eq_blk =3D xive_get_field32(NVT_W1_EQ_BLOCK, nvt->w1);
+    uint32_t eq_idx =3D xive_get_field32(NVT_W1_EQ_INDEX, nvt->w1);
+
+    if (!xive_nvt_is_valid(nvt)) {
+        return;
+    }
+
+    monitor_printf(mon, "  %08x end:%02x/%04x ipb:%02x\n", nvt_idx,
+                   eq_blk, eq_idx,
+                   xive_get_field32(NVT_W4_IPB, nvt->w4));
+}
+
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
@@ -1567,8 +1614,11 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
     uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive);
     uint32_t nr_ends =3D pnv_xive_nr_ends(xive);
+    uint32_t nr_nvts =3D pnv_xive_nr_nvts(xive);
+    uint32_t nr_indirect_nvts =3D pnv_xive_nr_indirect(xive, VST_TSEL_VP=
DT);
     XiveEAS eas;
     XiveEND end;
+    XiveNVT nvt;
     int i;
=20
     monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
@@ -1602,6 +1652,16 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
         }
         xive_end_eas_pic_print_info(&end, i, mon);
     }
+
+    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0, nr_nvts =
- 1);
+    for (i =3D 0; i < nr_nvts; i++) {
+        if (xive_router_get_nvt(xrtr, blk, i, &nvt)) {
+            /* skip an indirect page */
+            i +=3D nr_indirect_nvts - 1;
+            continue;
+        }
+        xive_nvt_pic_print_info(&nvt, i, mon);
+    }
 }
=20
 static void pnv_xive_reset(void *dev)
--=20
2.21.0


