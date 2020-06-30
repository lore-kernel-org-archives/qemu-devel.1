Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3FCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D329D20771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329D20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD78-0001aB-Vl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5T-0007hE-2P; Tue, 30 Jun 2020 06:01:59 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5O-0004J9-Ur; Tue, 30 Jun 2020 06:01:58 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id A460FBF717;
 Tue, 30 Jun 2020 10:01:52 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 01/10] hw/block/nvme: support I/O Command Sets
Date: Tue, 30 Jun 2020 12:01:30 +0200
Message-Id: <20200630100139.1483002-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630100139.1483002-1-its@irrelevant.dk>
References: <20200630100139.1483002-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Implement support for TP 4056 ("Namespace Types"). This adds the 'iocs'
(I/O Command Set) device parameter to the nvme-ns device.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 block/nvme.c          |   6 +-
 hw/block/nvme-ns.c    |  24 +++--
 hw/block/nvme-ns.h    |  11 +-
 hw/block/nvme.c       | 226 +++++++++++++++++++++++++++++++++---------
 hw/block/nvme.h       |  52 ++++++----
 hw/block/trace-events |   6 +-
 include/block/nvme.h  |  53 ++++++++--
 7 files changed, 285 insertions(+), 93 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 05485fdd1189..e7fe0c7accd1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le32_to_cpu(c->dw0),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
@@ -495,7 +495,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
-    NvmeIdNs *idns;
+    NvmeIdNsNvm *idns;
     NvmeLBAF *lbaf;
     uint8_t *resp;
     uint16_t oncs;
@@ -512,7 +512,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         goto out;
     }
     idctrl = (NvmeIdCtrl *)resp;
-    idns = (NvmeIdNs *)resp;
+    idns = (NvmeIdNsNvm *)resp;
     r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 7c825c38c69d..ae051784caaf 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -59,8 +59,16 @@ static int nvme_ns_blk_resize(BlockBackend *blk, size_t len, Error **errp)
 
 static void nvme_ns_init(NvmeNamespace *ns)
 {
-    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns;
 
+    int unmap = blk_get_flags(ns->blk) & BDRV_O_UNMAP;
+
+    ns->id_ns[NVME_IOCS_NVM] = g_new0(NvmeIdNsNvm, 1);
+    id_ns = nvme_ns_id_nvm(ns);
+
+    ns->iocs = ns->params.iocs;
+
+    id_ns->dlfeat = unmap ? 0x9 : 0x0;
     id_ns->lbaf[0].ds = ns->params.lbads;
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
@@ -130,8 +138,7 @@ static int nvme_ns_init_blk_state(NvmeNamespace *ns, Error **errp)
     return 0;
 }
 
-static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, NvmeIdCtrl *id,
-                            Error **errp)
+static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
     uint64_t perm, shared_perm;
 
@@ -174,7 +181,8 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, NvmeIdCtrl *id,
     return 0;
 }
 
-static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
+static int nvme_ns_check_constraints(NvmeCtrl *n, NvmeNamespace *ns, Error
+                                     **errp)
 {
     if (!ns->blk) {
         error_setg(errp, "block backend not configured");
@@ -191,11 +199,11 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
 
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
-    if (nvme_ns_check_constraints(ns, errp)) {
+    if (nvme_ns_check_constraints(n, ns, errp)) {
         return -1;
     }
 
-    if (nvme_ns_init_blk(n, ns, &n->id_ctrl, errp)) {
+    if (nvme_ns_init_blk(n, ns, errp)) {
         return -1;
     }
 
@@ -210,7 +218,8 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
          * With a state file in place we can enable the Deallocated or
          * Unwritten Logical Block Error feature.
          */
-        ns->id_ns.nsfeat |= 0x4;
+        NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+        id_ns->nsfeat |= 0x4;
     }
 
     if (nvme_register_namespace(n, ns, errp)) {
@@ -239,6 +248,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
     DEFINE_PROP_DRIVE("state", NvmeNamespace, blk_state),
+    DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, 0x0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index eb901acc912b..4124f20f1cef 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  iocs;
     uint8_t  lbads;
 } NvmeNamespaceParams;
 
@@ -30,8 +31,9 @@ typedef struct NvmeNamespace {
     BlockBackend *blk_state;
     int32_t      bootindex;
     int64_t      size;
+    uint8_t      iocs;
 
-    NvmeIdNs            id_ns;
+    void         *id_ns[256];
     NvmeNamespaceParams params;
 
     unsigned long *utilization;
@@ -50,9 +52,14 @@ static inline uint32_t nvme_nsid(NvmeNamespace *ns)
     return -1;
 }
 
+static inline NvmeIdNsNvm *nvme_ns_id_nvm(NvmeNamespace *ns)
+{
+    return ns->id_ns[NVME_IOCS_NVM];
+}
+
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
 {
-    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
     return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
 }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 25d79bcd0bc9..1662c11a4cf3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -854,7 +854,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.dw0;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -916,7 +916,8 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb)
 {
-    uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+    uint64_t nsze = le64_to_cpu(id_ns->nsze);
 
     if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
         return NVME_LBA_RANGE | NVME_DNR;
@@ -951,8 +952,9 @@ static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
 
     status = nvme_check_bounds(n, ns, req->slba, req->nlb);
     if (status) {
+        NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
         trace_pci_nvme_err_invalid_lba_range(req->slba, req->nlb,
-                                             ns->id_ns.nsze);
+                                             id_ns->nsze);
         return status;
     }
 
@@ -1154,8 +1156,9 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 
     status = nvme_check_bounds(n, ns, req->slba, req->nlb);
     if (status) {
+        NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
         trace_pci_nvme_err_invalid_lba_range(req->slba, req->nlb,
-                                             ns->id_ns.nsze);
+                                             id_ns->nsze);
         return status;
     }
 
@@ -1481,14 +1484,19 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
     NvmeRequest *req)
 {
     uint32_t trans_len;
+    uint8_t csi = le32_to_cpu(req->cmd.cdw14) >> 24;
 
-    if (off > sizeof(nvme_effects)) {
+    if (!(n->iocscs[n->features.iocsci] & (1 << csi))) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    trans_len = MIN(sizeof(nvme_effects) - off, buf_len);
+    if (off > sizeof(NvmeEffectsLog)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
 
-    return nvme_dma(n, (uint8_t *)&nvme_effects + off, trans_len,
+    trans_len = MIN(sizeof(NvmeEffectsLog) - off, buf_len);
+
+    return nvme_dma(n, (uint8_t *)&nvme_effects[csi] + off, trans_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
@@ -1648,69 +1656,129 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, uint8_t cns, uint8_t csi,
+                                   NvmeRequest *req)
 {
+    NvmeIdCtrl empty = { 0 };
+    NvmeIdCtrl *id_ctrl = &empty;
+
     trace_pci_nvme_identify_ctrl();
 
-    return nvme_dma(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
+    switch (cns) {
+    case NVME_ID_CNS_CTRL:
+        id_ctrl = &n->id_ctrl;
+
+        break;
+
+    case NVME_ID_CNS_CTRL_IOCS:
+        if (!(n->iocscs[n->features.iocsci] & (1 << csi))) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        if (n->id_ctrl_iocss[csi]) {
+            id_ctrl = n->id_ctrl_iocss[csi];
+        }
+
+        break;
+
+    default:
+        assert(cns);
+    }
+
+    return nvme_dma(n, (uint8_t *)id_ctrl, sizeof(*id_ctrl),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, uint8_t cns, uint8_t csi,
+                                 NvmeRequest *req)
 {
+    NvmeIdNsNvm empty = { 0 };
+    void *id_ns = &empty;
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
     NvmeNamespace *ns;
-    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    NvmeIdNs *id_ns, inactive = { 0 };
-    uint32_t nsid = le32_to_cpu(c->nsid);
 
-    trace_pci_nvme_identify_ns(nsid);
+    trace_pci_nvme_identify_ns(nsid, csi);
 
     if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
     ns = nvme_ns(n, nsid);
-    if (unlikely(!ns)) {
-        id_ns = &inactive;
-    } else {
-        id_ns = &ns->id_ns;
+    if (ns) {
+        switch (cns) {
+        case NVME_ID_CNS_NS:
+            id_ns = ns->id_ns[NVME_IOCS_NVM];
+            if (!id_ns) {
+                return NVME_INVALID_IOCS | NVME_DNR;
+            }
+
+            break;
+
+        case NVME_ID_CNS_NS_IOCS:
+            if (csi == NVME_IOCS_NVM) {
+                break;
+            }
+
+            id_ns = ns->id_ns[csi];
+            if (!id_ns) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            break;
+
+        default:
+            assert(cns);
+        }
     }
 
-    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
+    return nvme_dma(n, (uint8_t *)id_ns, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, uint8_t cns, uint8_t csi,
+                                     NvmeRequest *req)
 {
-    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
-    uint32_t min_nsid = le32_to_cpu(c->nsid);
+    static const int len = NVME_IDENTIFY_DATA_SIZE;
+    uint32_t min_nsid = le32_to_cpu(req->cmd.nsid);
     uint32_t *list;
     uint16_t ret;
     int j = 0;
 
-    trace_pci_nvme_identify_nslist(min_nsid);
+    trace_pci_nvme_identify_nslist(min_nsid, csi);
 
-    list = g_malloc0(data_len);
+    if (min_nsid == 0xfffffffe || min_nsid == 0xffffffff) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    if (cns == NVME_ID_CNS_NS_ACTIVE_LIST_IOCS && !csi) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    list = g_malloc0(len);
     for (int i = 1; i <= n->num_namespaces; i++) {
-        if (i <= min_nsid || !nvme_ns(n, i)) {
+        NvmeNamespace *ns = nvme_ns(n, i);
+        if (i <= min_nsid || !ns) {
             continue;
         }
+
+        if (cns == NVME_ID_CNS_NS_ACTIVE_LIST_IOCS && csi && csi != ns->iocs) {
+            continue;
+        }
+
         list[j++] = cpu_to_le32(i);
-        if (j == data_len / sizeof(uint32_t)) {
+        if (j == len / sizeof(uint32_t)) {
             break;
         }
     }
-    ret = nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DEVICE,
-                   req);
+    ret = nvme_dma(n, (uint8_t *)list, len, DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
 
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    uint32_t nsid = le32_to_cpu(c->nsid);
+    NvmeNamespace *ns;
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
 
     struct data {
@@ -1718,6 +1786,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
             NvmeIdNsDescr hdr;
             uint8_t v[16];
         } uuid;
+
+        struct {
+            NvmeIdNsDescr hdr;
+            uint8_t v;
+        } iocs;
     };
 
     struct data *ns_descrs = (struct data *)list;
@@ -1728,7 +1801,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (unlikely(!nvme_ns(n, nsid))) {
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1744,25 +1818,45 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
+    ns_descrs->iocs.hdr.nidt = NVME_NIDT_CSI;
+    ns_descrs->iocs.hdr.nidl = NVME_NIDT_CSI_LEN;
+    stb_p(&ns_descrs->iocs.v, ns->iocs);
+
     return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_iocs(NvmeCtrl *n, uint16_t cntid,
+                                   NvmeRequest *req)
+{
+    return nvme_dma(n, (uint8_t *) n->iocscs, sizeof(n->iocscs),
+                    DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeIdentify *id = (NvmeIdentify *) &req->cmd;
 
-    switch (le32_to_cpu(c->cns)) {
+    trace_pci_nvme_identify(nvme_cid(req), le32_to_cpu(req->cmd.nsid),
+                            le16_to_cpu(id->cntid), id->cns, id->csi,
+                            le16_to_cpu(id->nvmsetid));
+
+    switch (le32_to_cpu(id->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, req);
+    case NVME_ID_CNS_NS_IOCS:
+        return nvme_identify_ns(n, id->cns, id->csi, req);
     case NVME_ID_CNS_CTRL:
-        return nvme_identify_ctrl(n, req);
+    case NVME_ID_CNS_CTRL_IOCS:
+        return nvme_identify_ctrl(n, id->cns, id->csi, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, req);
+    case NVME_ID_CNS_NS_ACTIVE_LIST_IOCS:
+        return nvme_identify_nslist(n, id->cns, id->csi, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
+    case NVME_ID_CNS_IOCS:
+        return nvme_identify_iocs(n, id->cntid, req);
     default:
-        trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
+        trace_pci_nvme_err_invalid_identify_cns(id->cns);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
@@ -1771,7 +1865,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.dw0 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1954,13 +2048,17 @@ defaults:
 
         result = cpu_to_le32(result);
         break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = cpu_to_le32(n->features.iocsci & 0x1ff);
+        break;
     default:
         result = cpu_to_le32(nvme_feature_default[fid]);
         break;
     }
 
 out:
-    req->cqe.result = result;
+    req->cqe.dw0 = result;
+
     return NVME_SUCCESS;
 }
 
@@ -1983,6 +2081,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns = NULL;
+    NvmeIdNsNvm *id_ns;
 
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -2059,7 +2158,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                     continue;
                 }
 
-                if (NVME_ID_NS_NSFEAT_DULBE(ns->id_ns.nsfeat)) {
+                id_ns = nvme_ns_id_nvm(ns);
+                if (NVME_ID_NS_NSFEAT_DULBE(id_ns->nsfeat)) {
                     ns->features.err_rec = dw11;
                 }
             }
@@ -2075,6 +2175,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 
         for (int i = 1; i <= n->num_namespaces; i++) {
             ns = nvme_ns(n, i);
+
             if (!ns) {
                 continue;
             }
@@ -2105,14 +2206,34 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                     ((dw11 >> 16) & 0xFFFF) + 1,
                                     n->params.max_ioqpairs,
                                     n->params.max_ioqpairs);
-        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                                      ((n->params.max_ioqpairs - 1) << 16));
+        req->cqe.dw0 = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                   ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config = dw11;
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, req);
+    case NVME_COMMAND_SET_PROFILE:
+        if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ALL) {
+            uint16_t iocsci = dw11 & 0x1ff;
+            uint64_t iocsc = n->iocscs[iocsci];
+
+            for (int i = 1; i <= n->num_namespaces; i++) {
+                ns = nvme_ns(n, i);
+                if (!ns) {
+                    continue;
+                }
+
+                if (!(iocsc & (1 << ns->iocs))) {
+                    return NVME_IOCS_COMB_REJECTED | NVME_DNR;
+                }
+            }
+
+            n->features.iocsci = iocsci;
+        }
+
+        break;
     default:
         return NVME_FEAT_NOT_CHANGABLE | NVME_DNR;
     }
@@ -2265,6 +2386,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;
 
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
     if (unlikely(n->cq[0])) {
         trace_pci_nvme_err_startfail_cq();
         return -1;
@@ -2304,28 +2427,28 @@ static int nvme_start_ctrl(NvmeCtrl *n)
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) <
-                 NVME_CTRL_CQES_MIN(n->id_ctrl.cqes))) {
+                 NVME_CTRL_CQES_MIN(id_ctrl->cqes))) {
         trace_pci_nvme_err_startfail_cqent_too_small(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) >
-                 NVME_CTRL_CQES_MAX(n->id_ctrl.cqes))) {
+                 NVME_CTRL_CQES_MAX(id_ctrl->cqes))) {
         trace_pci_nvme_err_startfail_cqent_too_large(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MAX(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) <
-                 NVME_CTRL_SQES_MIN(n->id_ctrl.sqes))) {
+                 NVME_CTRL_SQES_MIN(id_ctrl->sqes))) {
         trace_pci_nvme_err_startfail_sqent_too_small(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) >
-                 NVME_CTRL_SQES_MAX(n->id_ctrl.sqes))) {
+                 NVME_CTRL_SQES_MAX(id_ctrl->sqes))) {
         trace_pci_nvme_err_startfail_sqent_too_large(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MAX(n->bar.cap));
@@ -2774,6 +2897,8 @@ static void nvme_init_state(NvmeCtrl *n)
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
+    n->iocscs[0] = 1 << NVME_IOCS_NVM;
+    n->features.iocsci = 0;
 }
 
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -2977,7 +3102,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
-    NVME_CAP_SET_CSS(n->bar.cap, 1);
+    NVME_CAP_SET_CSS(n->bar.cap, (NVME_CAP_CSS_NVM | NVME_CAP_CSS_CSI));
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
     n->bar.vs = NVME_SPEC_VER;
@@ -3037,6 +3162,11 @@ static void nvme_exit(PCIDevice *pci_dev)
     if (n->pmrdev) {
         host_memory_backend_set_mapped(n->pmrdev, false);
     }
+
+    for (int i = 0; i < 256; i++) {
+        g_free(n->id_ctrl_iocss[i]);
+    }
+
     msix_uninit_exclusive_bar(pci_dev);
 }
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e62bcd12a7a8..69be47963f5d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -18,28 +18,33 @@ typedef struct NvmeParams {
     bool     use_intel_id;
 } NvmeParams;
 
-static const NvmeEffectsLog nvme_effects = {
-    .acs = {
-        [NVME_ADM_CMD_DELETE_SQ]    = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_CREATE_SQ]    = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_GET_LOG_PAGE] = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_DELETE_CQ]    = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_CREATE_CQ]    = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_IDENTIFY]     = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_ABORT]        = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_SET_FEATURES] = NVME_EFFECTS_CSUPP | NVME_EFFECTS_CCC |
-            NVME_EFFECTS_NIC | NVME_EFFECTS_NCC,
-        [NVME_ADM_CMD_GET_FEATURES] = NVME_EFFECTS_CSUPP,
-        [NVME_ADM_CMD_FORMAT_NVM]   = NVME_EFFECTS_CSUPP | NVME_EFFECTS_LBCC |
-            NVME_EFFECTS_NCC | NVME_EFFECTS_NIC | NVME_EFFECTS_CSE_MULTI,
-        [NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_EFFECTS_CSUPP,
-    },
+static const NvmeEffectsLog nvme_effects[] = {
+    [NVME_IOCS_NVM] = {
+        .acs = {
+            [NVME_ADM_CMD_DELETE_SQ]    = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_CREATE_SQ]    = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_GET_LOG_PAGE] = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_DELETE_CQ]    = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_CREATE_CQ]    = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_IDENTIFY]     = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_ABORT]        = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_SET_FEATURES] = NVME_EFFECTS_CSUPP |
+                NVME_EFFECTS_CCC | NVME_EFFECTS_NIC | NVME_EFFECTS_NCC,
+            [NVME_ADM_CMD_GET_FEATURES] = NVME_EFFECTS_CSUPP,
+            [NVME_ADM_CMD_FORMAT_NVM]   = NVME_EFFECTS_CSUPP |
+                NVME_EFFECTS_LBCC | NVME_EFFECTS_NCC | NVME_EFFECTS_NIC |
+                NVME_EFFECTS_CSE_MULTI,
+            [NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_EFFECTS_CSUPP,
+        },
 
-    .iocs = {
-        [NVME_CMD_FLUSH]            = NVME_EFFECTS_CSUPP,
-        [NVME_CMD_WRITE]            = NVME_EFFECTS_CSUPP | NVME_EFFECTS_LBCC,
-        [NVME_CMD_READ]             = NVME_EFFECTS_CSUPP,
-        [NVME_CMD_WRITE_ZEROES]     = NVME_EFFECTS_CSUPP | NVME_EFFECTS_LBCC,
+        .iocs = {
+            [NVME_CMD_FLUSH]            = NVME_EFFECTS_CSUPP,
+            [NVME_CMD_WRITE]            = NVME_EFFECTS_CSUPP |
+                NVME_EFFECTS_LBCC,
+            [NVME_CMD_READ]             = NVME_EFFECTS_CSUPP,
+            [NVME_CMD_WRITE_ZEROES]     = NVME_EFFECTS_CSUPP |
+                NVME_EFFECTS_LBCC,
+        },
     },
 };
 
@@ -193,6 +198,7 @@ typedef struct NvmeFeatureVal {
     };
     uint32_t    async_config;
     uint32_t    vwc;
+    uint32_t    iocsci;
 } NvmeFeatureVal;
 
 static const uint32_t nvme_feature_cap[0x100] = {
@@ -202,6 +208,7 @@ static const uint32_t nvme_feature_cap[0x100] = {
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
+    [NVME_COMMAND_SET_PROFILE]      = NVME_FEAT_CAP_CHANGE,
 };
 
 static const uint32_t nvme_feature_default[0x100] = {
@@ -220,6 +227,7 @@ static const bool nvme_feature_support[0x100] = {
     [NVME_WRITE_ATOMICITY]          = true,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
     [NVME_TIMESTAMP]                = true,
+    [NVME_COMMAND_SET_PROFILE]      = true,
 };
 
 typedef struct NvmeCtrl {
@@ -247,6 +255,7 @@ typedef struct NvmeCtrl {
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
     uint64_t    starttime_ms;
     uint16_t    temperature;
+    uint64_t    iocscs[512];
 
     HostMemoryBackend *pmrdev;
 
@@ -262,6 +271,7 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+    void            *id_ctrl_iocss[256];
     NvmeFeatureVal  features;
 } NvmeCtrl;
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index ed21609f1a4f..4cf0236631d2 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -51,10 +51,12 @@ pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize,
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
 pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
+pci_nvme_identify(uint16_t cid, uint32_t nsid, uint16_t cntid, uint8_t cns, uint8_t csi, uint16_t nvmsetid) "cid %"PRIu16" nsid %"PRIu32" cntid 0x%"PRIx16" cns 0x%"PRIx8" csi 0x%"PRIx8" nvmsetid %"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
-pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
-pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns(uint32_t ns, uint8_t csi) "nsid %"PRIu32" csi 0x%"PRIx8""
+pci_nvme_identify_nslist(uint32_t ns, uint8_t csi) "nsid %"PRIu32" csi 0x%"PRIx8""
 pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_io_cmd_set(uint16_t cid) "cid %"PRIu16""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
 pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint8_t save, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" save 0x%"PRIx8" cdw11 0x%"PRIx32""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 040e4ef36ddc..637be0ddd2fc 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -93,6 +93,11 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMBS_MASK)\
                                                             << CAP_CMBS_SHIFT)
 
+enum NvmeCapCss {
+    NVME_CAP_CSS_NVM = 1 << 0,
+    NVME_CAP_CSS_CSI = 1 << 6,
+};
+
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
     CC_CSS_SHIFT    = 4,
@@ -121,6 +126,11 @@ enum NvmeCcMask {
 #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
 #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
 
+enum NvmeCcCss {
+    NVME_CC_CSS_NVM = 0x0,
+    NVME_CC_CSS_ALL = 0x6,
+};
+
 enum NvmeCstsShift {
     CSTS_RDY_SHIFT      = 0,
     CSTS_CFS_SHIFT      = 1,
@@ -454,6 +464,10 @@ enum NvmeCmbmscMask {
 
 #define NVME_CMBSTS_CBAI(cmbsts) (cmsts & 0x1)
 
+enum NvmeCommandSet {
+    NVME_IOCS_NVM = 0x0,
+};
+
 enum NvmeSglDescriptorType {
     NVME_SGL_DESCR_TYPE_DATA_BLOCK          = 0x0,
     NVME_SGL_DESCR_TYPE_BIT_BUCKET          = 0x1,
@@ -604,7 +618,8 @@ typedef struct NvmeIdentify {
     uint8_t     rsvd3;
     uint16_t    cntid;
     uint16_t    nvmsetid;
-    uint16_t    rsvd4;
+    uint8_t     rsvd4;
+    uint8_t     csi;
     uint32_t    rsvd11[4];
 } NvmeIdentify;
 
@@ -697,8 +712,15 @@ typedef struct NvmeAerResult {
 } NvmeAerResult;
 
 typedef struct NvmeCqe {
-    uint32_t    result;
-    uint32_t    rsvd;
+    union {
+        struct {
+            uint32_t    dw0;
+            uint32_t    dw1;
+        };
+
+        uint64_t qw0;
+    };
+
     uint16_t    sq_head;
     uint16_t    sq_id;
     uint16_t    cid;
@@ -746,6 +768,10 @@ enum NvmeStatusCodes {
     NVME_FEAT_NOT_CHANGABLE     = 0x010e,
     NVME_FEAT_NOT_NS_SPEC       = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
+    NVME_IOCS_NOT_SUPPORTED     = 0x0127,
+    NVME_IOCS_NOT_ENABLED       = 0x0128,
+    NVME_IOCS_COMB_REJECTED     = 0x0129,
+    NVME_INVALID_IOCS           = 0x0126,
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
@@ -890,10 +916,14 @@ typedef struct NvmePSD {
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
 enum {
-    NVME_ID_CNS_NS             = 0x0,
-    NVME_ID_CNS_CTRL           = 0x1,
-    NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
-    NVME_ID_CNS_NS_DESCR_LIST  = 0x3,
+    NVME_ID_CNS_NS                     = 0x00,
+    NVME_ID_CNS_CTRL                   = 0x01,
+    NVME_ID_CNS_NS_ACTIVE_LIST         = 0x02,
+    NVME_ID_CNS_NS_DESCR_LIST          = 0x03,
+    NVME_ID_CNS_NS_IOCS                = 0x05,
+    NVME_ID_CNS_CTRL_IOCS              = 0x06,
+    NVME_ID_CNS_NS_ACTIVE_LIST_IOCS    = 0x07,
+    NVME_ID_CNS_IOCS                   = 0x1c,
 };
 
 typedef struct NvmeIdCtrl {
@@ -1058,6 +1088,7 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
+    NVME_COMMAND_SET_PROFILE        = 0x19,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
 };
 
@@ -1105,7 +1136,7 @@ typedef struct NvmeLBAF {
 
 #define NVME_NSID_BROADCAST 0xffffffff
 
-typedef struct NvmeIdNs {
+typedef struct NvmeIdNsNvm {
     uint64_t    nsze;
     uint64_t    ncap;
     uint64_t    nuse;
@@ -1143,7 +1174,7 @@ typedef struct NvmeIdNs {
     NvmeLBAF    lbaf[16];
     uint8_t     rsvd192[192];
     uint8_t     vs[3712];
-} NvmeIdNs;
+} NvmeIdNsNvm;
 
 typedef struct NvmeIdNsDescr {
     uint8_t nidt;
@@ -1154,11 +1185,13 @@ typedef struct NvmeIdNsDescr {
 #define NVME_NIDT_EUI64_LEN 8
 #define NVME_NIDT_NGUID_LEN 16
 #define NVME_NIDT_UUID_LEN  16
+#define NVME_NIDT_CSI_LEN   1
 
 enum {
     NVME_NIDT_EUI64 = 0x1,
     NVME_NIDT_NGUID = 0x2,
     NVME_NIDT_UUID  = 0x3,
+    NVME_NIDT_CSI   = 0x4,
 };
 
 /*Deallocate Logical Block Features*/
@@ -1211,7 +1244,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEnduranceGroupLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeNvmSetAttributes) != 128);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNvmSetList) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
-- 
2.27.0


