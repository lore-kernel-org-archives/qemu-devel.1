Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F9F2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T9DZMEm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F9F2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5KE-0004hG-AR
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ji-00027R-7k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jg-0007W6-Fb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:30 -0500
Received: from ozlabs.org ([203.11.71.1]:52363)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jf-00071S-If; Mon, 16 Dec 2019 23:45:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWd3lBSz9sTN; Tue, 17 Dec 2019 15:43:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557821;
 bh=vomrH429h1FwgoecOnUgRXJ8QtgZWOpq3eZ7u7hPP/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T9DZMEm3MCNx9CWDB0KVOJh9NVkP1L9z6OzW3NWQVxmbbhOWTsjWGkQ8hDqNUorqE
 x9wORSD8CGF1EQqMScc5YhXpLogDJmo5gf+iaKu51KmsH3p7hcq65wv7vEne+DsfBI
 Nen+bPin2h6PUeU5159NJJ1JYYa45bUlSTj+8zVI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 50/88] ppc/pnv: Dump the XIVE NVT table
Date: Tue, 17 Dec 2019 15:42:44 +1100
Message-Id: <20191217044322.351838-51-david@gibson.dropbear.id.au>
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

This is useful to dump the saved contexts of the vCPUs : configuration
of the base END index of the vCPU and the Interrupt Pending Buffer
register, which is updated when an interrupt can not be presented.

When dumping the NVT table, we skip empty indirect pages which are not
necessarily allocated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-21-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c         | 64 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/xive_regs.h |  3 ++
 2 files changed, 67 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 43c760efd1..a0a69b98a7 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -527,6 +527,44 @@ static uint32_t pnv_xive_nr_ipis(PnvXive *xive, uint=
8_t blk)
     return VSD_INDIRECT & vsd ? 0 : vst_tsize * SBE_PER_BYTE;
 }
=20
+/*
+ * Compute the number of entries per indirect subpage.
+ */
+static uint64_t pnv_xive_vst_per_subpage(PnvXive *xive, uint32_t type)
+{
+    uint8_t blk =3D pnv_xive_block_id(xive);
+    uint64_t vsd =3D xive->vsds[type][blk];
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t vsd_addr;
+    uint32_t page_shift;
+
+    /* For direct tables, fake a valid value */
+    if (!(VSD_INDIRECT & vsd)) {
+        return 1;
+    }
+
+    /* Get the page size of the indirect table. */
+    vsd_addr =3D vsd & VSD_ADDRESS_MASK;
+    vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
+
+    if (!(vsd & VSD_ADDRESS_MASK)) {
+#ifdef XIVE_DEBUG
+        xive_error(xive, "VST: invalid %s entry %x !?", info->name, idx)=
;
+#endif
+        return 0;
+    }
+
+    page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
+
+    if (!pnv_xive_vst_page_size_allowed(page_shift)) {
+        xive_error(xive, "VST: invalid %s page shift %d", info->name,
+                   page_shift);
+        return 0;
+    }
+
+    return (1ull << page_shift) / info->size;
+}
+
 /*
  * EDT Table
  *
@@ -1665,6 +1703,21 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
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
+    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x\n", nvt_idx,
+                   eq_blk, eq_idx,
+                   xive_get_field32(NVT_W4_IPB, nvt->w4));
+}
+
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
@@ -1674,7 +1727,9 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
     XiveEAS eas;
     XiveEND end;
+    XiveNVT nvt;
     int i;
+    uint64_t xive_nvt_per_subpage;
=20
     monitor_printf(mon, "XIVE[%x] #%d Source %08x .. %08x\n", chip_id, b=
lk,
                    srcno0, srcno0 + nr_ipis - 1);
@@ -1702,6 +1757,15 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_eas_pic_print_info(&end, i++, mon);
     }
+
+    monitor_printf(mon, "XIVE[%x] #%d NVTT %08x .. %08x\n", chip_id, blk=
,
+                   0, XIVE_NVT_COUNT - 1);
+    xive_nvt_per_subpage =3D pnv_xive_vst_per_subpage(xive, VST_TSEL_VPD=
T);
+    for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D xive_nvt_per_subpage) {
+        while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
+            xive_nvt_pic_print_info(&nvt, i++, mon);
+        }
+    }
 }
=20
 static void pnv_xive_reset(void *dev)
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 1a5622f8de..09f243600c 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -252,6 +252,8 @@ typedef struct XiveNVT {
         uint32_t        w0;
 #define NVT_W0_VALID             PPC_BIT32(0)
         uint32_t        w1;
+#define NVT_W1_EQ_BLOCK          PPC_BITMASK32(0, 3)
+#define NVT_W1_EQ_INDEX          PPC_BITMASK32(4, 31)
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
@@ -277,6 +279,7 @@ typedef struct XiveNVT {
  * field of the XIVE END
  */
 #define XIVE_NVT_SHIFT                19
+#define XIVE_NVT_COUNT                (1 << XIVE_NVT_SHIFT)
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
 {
--=20
2.23.0


