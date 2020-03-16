Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8CC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8CC20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsvp-0008UP-7Z
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkX-0008S2-91
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkV-00086e-BQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:49 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkP-0007S9-OT; Mon, 16 Mar 2020 10:29:42 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 71B91BF6A1;
 Mon, 16 Mar 2020 14:29:40 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 10/42] nvme: refactor device realization
Date: Mon, 16 Mar 2020 07:28:56 -0700
Message-Id: <20200316142928.153431-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This patch splits up nvme_realize into multiple individual functions,
each initializing a different subset of the device.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 178 ++++++++++++++++++++++++++++++------------------
 hw/block/nvme.h |  23 ++++++-
 2 files changed, 134 insertions(+), 67 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7dfd8a1a392d..665485045066 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -44,6 +44,8 @@
 #include "trace.h"
 #include "nvme.h"
=20
+#define NVME_CMB_BIR 2
+
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
         (trace_##trace)(__VA_ARGS__); \
@@ -63,7 +65,7 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr=
 addr)
=20
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
 {
-    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
+    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
         return;
     }
@@ -157,7 +159,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
     if (unlikely(!prp1)) {
         trace_nvme_dev_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
+    } else if (n->bar.cmbsz && prp1 >=3D n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
         qsg->nsg =3D 0;
         qemu_iovec_init(iov, num_prps);
@@ -1324,14 +1326,9 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
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
+    NvmeParams *params =3D &n->params;
=20
     if (n->params.num_queues) {
         warn_report("nvme: num_queues is deprecated; please use max_ioqp=
airs "
@@ -1340,57 +1337,100 @@ static void nvme_realize(PCIDevice *pci_dev, Err=
or **errp)
         n->params.max_ioqpairs =3D n->params.num_queues - 1;
     }
=20
-    if (!n->params.max_ioqpairs) {
-        error_setg(errp, "max_ioqpairs can't be less than 1");
+    if (params->max_ioqpairs < 1 ||
+        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
+        error_setg(errp, "nvme: max_ioqpairs must be ");
+        return -1;
     }
=20
     if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
-        return;
+        error_setg(errp, "nvme: block backend not configured");
+        return -1;
     }
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
+    if (!params->serial) {
+        error_setg(errp, "nvme: serial not configured");
+        return -1;
     }
=20
-    if (!n->params.serial) {
-        error_setg(errp, "serial property not set");
-        return;
-    }
+    return 0;
+}
+
+static int nvme_init_blk(NvmeCtrl *n, Error **errp)
+{
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
                                        false, errp)) {
-        return;
+        return -1;
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
     n->reg_size =3D pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
-    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
-
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
     n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+}
=20
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
-                          "nvme", n->reg_size);
-    pci_register_bar(pci_dev, 0,
-        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
-        &n->iomem);
+static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
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
+    n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
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
+                          n->reg_size);
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
     msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
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
@@ -1431,46 +1471,54 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     n->bar.vs =3D 0x00010200;
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
+        return -1;
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
+    id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(n, ns));
=20
-        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+    /* no thin provisioning */
+    id_ns->ncap =3D id_ns->nsze;
+    id_ns->nuse =3D id_ns->ncap;
=20
+    return 0;
+}
+
+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+{
+    NvmeCtrl *n =3D NVME(pci_dev);
+    int i;
+
+    if (nvme_check_constraints(n, errp)) {
+        return;
+    }
+
+    nvme_init_state(n);
+
+    if (nvme_init_blk(n, errp)) {
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
+        if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
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
index 98f5b9479244..b7c465560eea 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -67,6 +67,22 @@ typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
 } NvmeNamespace;
=20
+static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    return nvme_ns_lbaf(ns)->ds;
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
@@ -88,8 +104,6 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
-    uint32_t    cmbsz;
-    uint32_t    cmbloc;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
@@ -103,4 +117,9 @@ typedef struct NvmeCtrl {
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
2.25.1


