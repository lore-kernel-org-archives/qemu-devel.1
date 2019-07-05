Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2EBC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9546121670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9546121670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjImb-0003fZ-Sd
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44208)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZr-0005R8-Ao
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZn-0005tc-5v
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZW-0005hB-3J; Fri, 05 Jul 2019 03:23:54 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id D1365C0628;
 Fri,  5 Jul 2019 07:23:52 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:25 +0200
Message-Id: <20190705072333.17171-9-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 08/16] nvme: refactor device realization
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
Cc: kwolf@redhat.com, matt.fitzpatrick@oakgatetech.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 196 ++++++++++++++++++++++++++++++++++--------------
 hw/block/nvme.h |  11 +++
 2 files changed, 152 insertions(+), 55 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4b9ff51868c0..eb6af6508e2d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -38,6 +38,7 @@
 #include "trace.h"
 #include "nvme.h"
=20
+#define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
 #define NVME_OP_ABORTED 0xff
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1365,66 +1366,105 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     },
 };
=20
-static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
-    NvmeIdCtrl *id =3D &n->id_ctrl;
-    NvmeIdNs *id_ns =3D &n->namespace.id_ns;
-
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
+    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 1);
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
@@ -1458,36 +1498,82 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     n->bar.vs =3D 0x00010201;
     n->bar.intmc =3D n->bar.intms =3D 0;
+}
=20
-    if (n->params.cmb_size_mb) {
+static uint64_t nvme_ns_calc_blks(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    return n->ns_size / nvme_ns_lbads_bytes(ns);
+}
=20
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+static void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
+{
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
+        cpu_to_le64(n->ns_size >>
+            id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)].ds);
+}
=20
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
+{
+    uint64_t ns_blks;
+    NvmeIdNs *id_ns =3D &ns->id_ns;
=20
-        n->cmbloc =3D n->bar.cmbloc;
-        n->cmbsz =3D n->bar.cmbsz;
+    nvme_ns_init_identify(n, id_ns);
=20
-        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+    ns_blks =3D nvme_ns_calc_blks(n, ns);
+    id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D cpu_to_le64(ns_blks)=
;
=20
+    return 0;
+}
+
+static int nvme_init_namespaces(NvmeCtrl *n, Error **errp)
+{
+    int64_t bs_size;
+    Error *local_err =3D NULL;
+    NvmeNamespace *ns =3D &n->namespace;
+
+    bs_size =3D blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg_errno(errp, -bs_size, "blk_getlength");
+        return 1;
     }
=20
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-    id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-        cpu_to_le64(n->ns_size >>
-            id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)].ds);
+    n->ns_size =3D bs_size / (uint64_t) n->num_namespaces;
+
+    if (nvme_init_namespace(n, ns, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+            "nvme_init_namespace: ");
+        return 1;
+    }
+
+    return 0;
+}
+
+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+{
+    NvmeCtrl *n =3D NVME(pci_dev);
+    Error *local_err =3D NULL;
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
+    }
+
+    if (nvme_init_namespaces(n, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+            "nvme_init_namespaces: ");
+        return;
+    }
+
+    nvme_init_pci(n, pci_dev);
+    nvme_init_ctrl(n);
 }
=20
 static void nvme_exit(PCIDevice *pci_dev)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 77fe6fb46b71..bea622ea71e0 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -101,4 +101,15 @@ typedef struct NvmeCtrl {
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    NvmeIdNs *id =3D &ns->id_ns;
+    return id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].ds;
+}
+
+static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
+{
+    return 1 << nvme_ns_lbads(ns);
+}
+
 #endif /* HW_NVME_H */
--=20
2.20.1


