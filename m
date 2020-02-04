Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A46C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5DF217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Am+VD5Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5DF217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuxE-0005Ai-R2
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusa-0003rN-Id
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusY-00077N-Ik
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusY-00075L-6j
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095221euoutp017473c85f2f17f9095bf9a3ec38af56f0~wKkQfDJUj3108931089euoutp01S
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095221euoutp017473c85f2f17f9095bf9a3ec38af56f0~wKkQfDJUj3108931089euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809941;
 bh=MZRg6GzYfH7UdUopDQJNr89To4xPQpqHZI7PEG5DF0o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Am+VD5Ddyz0ZJuIRuG497Z3N+hDgoe67xnCo397UDsoY9vAoJ8LNR4baKRTby8RGn
 R1tBv8QbFyGKQFRRxSpEK54XRrr/TrJlckb5HGAlZlK89fjOc6JpPWfCVL0JLvlfgj
 QQNrdlzDQHalj4EWDQQeQiqWRPrmu3dP72vhrt+M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095221eucas1p1b0d3a253496d823c30041582c1096f8b~wKkQV86q10921609216eucas1p15;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.DF.60698.5DE393E5; Tue,  4
 Feb 2020 09:52:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095220eucas1p186b0de598359750d49278e0226ae45fb~wKkP9ZQmM0921809218eucas1p1z;
 Tue,  4 Feb 2020 09:52:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095220eusmtrp2beaaa363c57bc85d48e1852e3738b584~wKkP81wlA0487104871eusmtrp2Z;
 Tue,  4 Feb 2020 09:52:20 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-eb-5e393ed5d468
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.6A.07950.4DE393E5; Tue,  4
 Feb 2020 09:52:20 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095220eusmtip106e4c5ba824aa15f8fa45eea748ed08b~wKkPxT78j3070630706eusmtip16;
 Tue,  4 Feb 2020 09:52:20 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:19 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:19 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 08/26] nvme: refactor device realization
Date: Tue, 4 Feb 2020 10:51:50 +0100
Message-ID: <20200204095208.269131-9-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7pX7SzjDP53s1ps7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujOcLr7AUnPWsuLZgI1MDY79FFyMnh4SAicTueb1MXYxcHEICKxgl
 rpwEcTiAnC+MEn9ZIOKfGSWONnYwg8RBGjYtzoeIL2eUWPNlPzNc0ba+d4wQzmlGiQlTf7JB
 ODsZJQ6tm8UGso9NQFNi+5//LCC2iIC0RPvVSawgRcwCvxkl5jZOBCsSFrCWuHVvOTOIzSKg
 IrH+/RUmEJtXwEri1p3D7BCHy0vMbjwNVs8JVL9/1QmoGkGJkzOfgC1gBqpp3jqbGcKWkDj4
 4gXYrRICu9gl3ny8AzXIReLR7w2sELawxKvjW6DiMhL/d85ngmjoZpTo+/AVqnsGo8T0Zd/Z
 IMFhLdF3JgeiwVHi1v81UGE+iRtvBSEW80lM2jYdGni8Eh1tQhDVahI7mrYyTmBUnoXk7FlI
 zp6F5OwFjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAtPN6X/Hv+5g3Pcn6RCjAAej
 Eg+vhqNFnBBrYllxZe4hRgkOZiUR3vP6lnFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwV
 EkhPLEnNTk0tSC2CyTJxcEo1MHrGNbwK1bgdHqTDGhD/bt62arHaZe7Xu95Ih9Xr/csyuRvi
 b/xv3cOJ/wL23D6Qk6AanCPgb7CnQlvh//8b0qrz5qt3WG2vyuUxPDrlUu5L9ThZh4tbFew3
 LDPbrKYju65m8VrVNAPN335S93cr9ejlnLt52Gf6nJZzrAw3/9yfxyj0ZH/MaiWW4oxEQy3m
 ouJEADlIg60zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7pX7CzjDLbdULHY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gc8X
 XmEpOOtZcW3BRqYGxn6LLkYODgkBE4lNi/O7GLk4hASWMkqs/vaQpYuREyguI/Hpykd2CFtY
 4s+1LjaIoo+MEquu/WSGcE4zSrzZ1M0EUiUksJNRYuc/dxCbTUBTYvuf/2CTRASkJdqvTmIF
 sZkFfjNK/OkLBLGFBawlbt1bzgxiswioSKx/fwVsDq+AlcStO4ehNstLzG48zQZicwLV7191
 ggnkaiGgmtaj3BDlghInZz5hgRgvL9G8dTYzhC0hcfDFC+YJjMKzkJTNQlI2C0nZAkbmVYwi
 qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIERt+3Yzy07GLveBR9iFOBgVOLh1XC0iBNiTSwrrsw9
 xCjBwawkwnte3zJOiDclsbIqtSg/vqg0J7X4EKMp0G8TmaVEk/OBySCvJN7Q1NDcwtLQ3Njc
 2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjLoP4189+XF2qXZ8ZT29VfZW8nK+5ddFR
 0X8OXJp1G17PLw0tdbzEYfr/vnFCUmVNkJ331qdT+x5f2KQp5svdtDL26irpafPVWotun/lv
 3Z504X3SXsv+c6ddL3QUHVTbzMz6Yb7bYZfLPxyfzHM8J6G9iSGv4/MN96cy5hzLJujMWfhS
 V0paiaU4I9FQi7moOBEAQ3df2M4CAAA=
X-CMS-MailID: 20200204095220eucas1p186b0de598359750d49278e0226ae45fb
X-Msg-Generator: CA
X-RootMTR: 20200204095220eucas1p186b0de598359750d49278e0226ae45fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095220eucas1p186b0de598359750d49278e0226ae45fb
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095220eucas1p186b0de598359750d49278e0226ae45fb@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch splits up nvme_realize into multiple individual functions,
each initializing a different subset of the device.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 175 +++++++++++++++++++++++++++++++-----------------
 hw/block/nvme.h |  21 ++++++
 2 files changed, 133 insertions(+), 63 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e1810260d40b..81514eaef63a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -44,6 +44,7 @@
 #include "nvme.h"
=20
 #define NVME_SPEC_VER 0x00010201
+#define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
=20
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1325,67 +1326,106 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     },
 };
=20
-static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
-    NvmeIdCtrl *id =3D &n->id_ctrl;
-
-    int i;
-    int64_t bs_size;
-    uint8_t *pci_conf;
-
-    if (!n->params.num_queues) {
-        error_setg(errp, "num_queues can't be zero");
-        return;
-    }
+    NvmeParams *params =3D &n->params;
=20
     if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
-        return;
+        error_setg(errp, "nvme: block backend not configured");
+        return 1;
     }
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
+    if (!params->serial) {
+        error_setg(errp, "nvme: serial not configured");
+        return 1;
     }
=20
-    if (!n->params.serial) {
-        error_setg(errp, "serial property not set");
-        return;
+    if ((params->num_queues < 1 || params->num_queues > NVME_MAX_QS)) {
+        error_setg(errp, "nvme: invalid queue configuration");
+        return 1;
     }
+
+    return 0;
+}
+
+static int nvme_init_blk(NvmeCtrl *n, Error **errp)
+{
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
-                                       false, errp)) {
-        return;
+        false, errp)) {
+        return 1;
     }
=20
-    pci_conf =3D pci_dev->config;
-    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(pci_dev, 0x80);
+    return 0;
+}
=20
+static void nvme_init_state(NvmeCtrl *n)
+{
     n->num_namespaces =3D 1;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
-    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
-
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+}
=20
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
-                          "nvme", n->reg_size);
+static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
+    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+
+    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
+    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+
+    n->cmbloc =3D n->bar.cmbloc;
+    n->cmbsz =3D n->bar.cmbsz;
+
+    n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                            "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz)=
);
+    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
+        PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+}
+
+static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    uint8_t *pci_conf =3D pci_dev->config;
+
+    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
+    pci_config_set_prog_interface(pci_conf, 0x2);
+    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+    pci_config_set_device_id(pci_conf, 0x5845);
+    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+
+    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme=
",
+        n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
     msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
=20
+    if (n->params.cmb_size_mb) {
+        nvme_init_cmb(n, pci_dev);
+    }
+}
+
+static void nvme_init_ctrl(NvmeCtrl *n)
+{
+    NvmeIdCtrl *id =3D &n->id_ctrl;
+    NvmeParams *params =3D &n->params;
+    uint8_t *pci_conf =3D n->parent_obj.config;
+
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), params->serial, ' ');
     id->rab =3D 6;
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
@@ -1431,46 +1471,55 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     n->bar.vs =3D NVME_SPEC_VER;
     n->bar.intmc =3D n->bar.intms =3D 0;
+}
=20
-    if (n->params.cmb_size_mb) {
+static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
+{
+    int64_t bs_size;
+    NvmeIdNs *id_ns =3D &ns->id_ns;
=20
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+    bs_size =3D blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg_errno(errp, -bs_size, "blk_getlength");
+        return 1;
+    }
=20
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    n->ns_size =3D bs_size;
=20
-        n->cmbloc =3D n->bar.cmbloc;
-        n->cmbsz =3D n->bar.cmbsz;
+    id_ns->ncap =3D id_ns->nuse =3D id_ns->nsze =3D
+        cpu_to_le64(nvme_ns_nlbas(n, ns));
=20
-        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+    return 0;
+}
=20
+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+{
+    NvmeCtrl *n =3D NVME(pci_dev);
+    Error *local_err =3D NULL;
+    int i;
+
+    if (nvme_check_constraints(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_check_constraints=
: ");
+        return;
+    }
+
+    nvme_init_state(n);
+
+    if (nvme_init_blk(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
+        return;
     }
=20
     for (i =3D 0; i < n->num_namespaces; i++) {
-        NvmeNamespace *ns =3D &n->namespaces[i];
-        NvmeIdNs *id_ns =3D &ns->id_ns;
-        id_ns->nsfeat =3D 0;
-        id_ns->nlbaf =3D 0;
-        id_ns->flbas =3D 0;
-        id_ns->mc =3D 0;
-        id_ns->dpc =3D 0;
-        id_ns->dps =3D 0;
-        id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-        id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
+        if (nvme_init_namespace(n, &n->namespaces[i], &local_err)) {
+            error_propagate_prepend(errp, local_err, "nvme_init_namespac=
e: ");
+            return;
+        }
     }
+
+    nvme_init_pci(n, pci_dev);
+    nvme_init_ctrl(n);
 }
=20
 static void nvme_exit(PCIDevice *pci_dev)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 9957c4a200e2..a867bdfabafd 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -65,6 +65,22 @@ typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
 } NvmeNamespace;
=20
+static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    return nvme_ns_lbaf(ns).ds;
+}
+
+static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
+{
+    return 1 << nvme_ns_lbads(ns);
+}
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
@@ -101,4 +117,9 @@ typedef struct NvmeCtrl {
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
+static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    return n->ns_size >> nvme_ns_lbads(ns);
+}
+
 #endif /* HW_NVME_H */
--=20
2.25.0


