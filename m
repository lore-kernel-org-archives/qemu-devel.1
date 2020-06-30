Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7624EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3407F206CB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3407F206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq7oC-00046C-GY
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7nb-0003bu-AO; Tue, 30 Jun 2020 00:23:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7nY-00035i-QF; Tue, 30 Jun 2020 00:23:11 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D1FD5BF670;
 Tue, 30 Jun 2020 04:23:06 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH] hw/block/nvme: add support for dulbe
Date: Tue, 30 Jun 2020 06:23:04 +0200
Message-Id: <20200630042304.1305269-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:09:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds support for reporting the Deallocated or Unwritten Logical
Block error (DULBE). This requires tracking the allocated/deallocated
status of all logical blocks.

Introduce a bitmap that does this. The bitmap is persisted on the new
'state' drive that is associated with a namespace. If no such drive is
attached, the controller will not indicate support for DULBE.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Based-on: <20200630041956.1304473-1-its@irrelevant.dk>
("[PATCH] hw/block/nvme: make lba data size configurable")

 hw/block/nvme-ns.c    | 103 +++++++++++++++++++++++++++++++++++++
 hw/block/nvme-ns.h    |  12 +++++
 hw/block/nvme.c       | 117 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |   4 +-
 hw/block/trace-events |   3 ++
 include/block/nvme.h  |   5 ++
 6 files changed, 240 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index d6ec55860a5e..7c825c38c69d 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -28,6 +28,35 @@
 #include "nvme.h"
 #include "nvme-ns.h"
 
+static int nvme_ns_blk_resize(BlockBackend *blk, size_t len, Error **errp)
+{
+	Error *local_err = NULL;
+	int ret;
+	uint64_t perm, shared_perm;
+
+	blk_get_perm(blk, &perm, &shared_perm);
+
+	ret = blk_set_perm(blk, perm | BLK_PERM_RESIZE, shared_perm, &local_err);
+	if (ret < 0) {
+		error_propagate_prepend(errp, local_err, "blk_set_perm: ");
+		return ret;
+	}
+
+	ret = blk_truncate(blk, len, false, PREALLOC_MODE_OFF, 0, &local_err);
+	if (ret < 0) {
+		error_propagate_prepend(errp, local_err, "blk_truncate: ");
+		return ret;
+	}
+
+	ret = blk_set_perm(blk, perm, shared_perm, &local_err);
+	if (ret < 0) {
+		error_propagate_prepend(errp, local_err, "blk_set_perm: ");
+		return ret;
+	}
+
+	return 0;
+}
+
 static void nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
@@ -41,6 +70,66 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->nuse = id_ns->ncap;
 }
 
+static int nvme_ns_init_blk_state(NvmeNamespace *ns, Error **errp)
+{
+    BlockBackend *blk = ns->blk_state;
+    uint64_t perm, shared_perm;
+    int64_t len, state_len;
+
+    Error *local_err = NULL;
+    int ret;
+
+    perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    shared_perm = BLK_PERM_ALL;
+
+    ns->utilization = bitmap_new(nvme_ns_nlbas(ns));
+
+    ret = blk_set_perm(blk, perm, shared_perm, &local_err);
+    if (ret) {
+        error_propagate_prepend(errp, local_err, "blk_set_perm: ");
+        return ret;
+    }
+
+    state_len = nvme_ns_blk_state_len(ns);
+
+    len = blk_getlength(blk);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "blk_getlength: ");
+        return len;
+    }
+
+    if (len) {
+        if (len != state_len) {
+            error_setg(errp, "state size mismatch "
+                "(expected %"PRIu64" bytes; was %"PRIu64" bytes)",
+                state_len, len);
+            error_append_hint(errp,
+                "Did you change the 'lbads' parameter? "
+                "Or re-formatted the namespace using Format NVM?\n");
+            return -1;
+        }
+
+        ret = blk_pread(blk, 0, ns->utilization, state_len);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "blk_pread: ");
+            return ret;
+        } else if (ret != state_len) {
+            error_setg(errp, "blk_pread: short read");
+            return -1;
+        }
+
+        return 0;
+    }
+
+    ret = nvme_ns_blk_resize(blk, state_len, &local_err);
+    if (ret < 0) {
+        error_propagate_prepend(errp, local_err, "nvme_ns_blk_resize: ");
+        return ret;
+    }
+
+    return 0;
+}
+
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, NvmeIdCtrl *id,
                             Error **errp)
 {
@@ -111,6 +200,19 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     nvme_ns_init(ns);
+
+    if (ns->blk_state) {
+        if (nvme_ns_init_blk_state(ns, errp)) {
+            return -1;
+        }
+
+        /*
+         * With a state file in place we can enable the Deallocated or
+         * Unwritten Logical Block Error feature.
+         */
+        ns->id_ns.nsfeat |= 0x4;
+    }
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
@@ -136,6 +238,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_DRIVE("drive", NvmeNamespace, blk),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
+    DEFINE_PROP_DRIVE("state", NvmeNamespace, blk_state),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index bee46b32efa5..eb901acc912b 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -27,11 +27,18 @@ typedef struct NvmeNamespaceParams {
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockBackend *blk;
+    BlockBackend *blk_state;
     int32_t      bootindex;
     int64_t      size;
 
     NvmeIdNs            id_ns;
     NvmeNamespaceParams params;
+
+    unsigned long *utilization;
+
+    struct {
+        uint32_t err_rec;
+    } features;
 } NvmeNamespace;
 
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
@@ -60,6 +67,11 @@ static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
     return ns->size >> nvme_ns_lbads(ns);
 }
 
+static inline size_t nvme_ns_blk_state_len(NvmeNamespace *ns)
+{
+    return ROUND_UP(DIV_ROUND_UP(nvme_ns_nlbas(ns), 8), BDRV_SECTOR_SIZE);
+}
+
 typedef struct NvmeCtrl NvmeCtrl;
 
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9e512c88656d..8e147b667c81 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -681,6 +681,10 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
 
 static void nvme_aio_destroy(NvmeAIO *aio)
 {
+    if (aio->flags & NVME_AIO_INTERNAL) {
+        qemu_iovec_destroy((QEMUIOVector *)aio->payload);
+    }
+
     g_free(aio);
 }
 
@@ -915,6 +919,18 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static inline uint16_t nvme_check_dulbe(NvmeCtrl *n, NvmeNamespace *ns,
+                                        uint64_t slba, uint32_t nlb)
+{
+    uint64_t elba = slba + nlb;
+
+    if (find_next_zero_bit(ns->utilization, elba, slba) < elba) {
+        return NVME_DULB;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns = req->ns;
@@ -934,9 +950,57 @@ static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
+    if (!nvme_req_is_write(req) && NVME_ERR_REC_DULBE(ns->features.err_rec)) {
+        status = nvme_check_dulbe(n, ns, req->slba, req->nlb);
+        if (status) {
+            return status;
+        }
+    }
+
     return NVME_SUCCESS;
 }
 
+static void nvme_ns_update_util(NvmeNamespace *ns, uint64_t slba,
+    uint32_t nlb, NvmeRequest *req)
+{
+    int64_t offset = slba >> 3;
+    size_t len = DIV_ROUND_UP(nlb, 8);
+
+    QEMUIOVector *iov = g_new0(QEMUIOVector, 1);
+    NvmeAIO *aio = g_new0(NvmeAIO, 1);
+
+    *aio = (NvmeAIO) {
+        .opc = NVME_AIO_OPC_WRITE,
+        .blk = ns->blk_state,
+        .offset = offset,
+        .len = len,
+        .payload = iov,
+        .req = req,
+        .flags = NVME_AIO_INTERNAL,
+    };
+
+    qemu_iovec_init(iov, 1);
+    qemu_iovec_add(iov, ((uint8_t *) ns->utilization) + offset, len);
+
+    trace_pci_nvme_ns_update_util(nvme_cid(req), nvme_nsid(ns));
+
+    nvme_req_add_aio(req, aio);
+}
+
+static void nvme_aio_write_cb(NvmeAIO *aio, void *opaque, int ret)
+{
+    NvmeRequest *req = aio->req;
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_aio_write_cb(nvme_cid(req), nvme_nsid(ns), req->slba,
+        req->nlb);
+
+    if (!ret && ns->blk_state) {
+        bitmap_set(ns->utilization, req->slba, req->nlb);
+        nvme_ns_update_util(ns, req->slba, req->nlb, req);
+    }
+}
+
 static void nvme_rw_cb(NvmeRequest *req, void *opaque)
 {
     NvmeNamespace *ns = req->ns;
@@ -1025,7 +1089,8 @@ static void nvme_aio_cb(void *opaque, int ret)
     nvme_aio_destroy(aio);
 }
 
-static void nvme_aio_rw(NvmeNamespace *ns, NvmeAIOOp opc, NvmeRequest *req)
+static void nvme_aio_rw(NvmeNamespace *ns, NvmeAIOOp opc,
+                        NvmeAIOCompletionFunc *cb, NvmeRequest *req)
 {
     NvmeAIO *aio = g_new(NvmeAIO, 1);
 
@@ -1034,6 +1099,7 @@ static void nvme_aio_rw(NvmeNamespace *ns, NvmeAIOOp opc, NvmeRequest *req)
         .blk = ns->blk,
         .offset = req->slba << nvme_ns_lbads(ns),
         .req = req,
+        .cb = cb,
     };
 
     if (req->qsg.sg) {
@@ -1098,6 +1164,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         .offset = offset,
         .len = count,
         .req = req,
+        .cb = nvme_aio_write_cb,
     };
 
     nvme_req_add_aio(req, aio);
@@ -1115,10 +1182,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 
     enum BlockAcctType acct = BLOCK_ACCT_READ;
     NvmeAIOOp opc = NVME_AIO_OPC_READ;
+    NvmeAIOCompletionFunc *cb = NULL;
 
     if (nvme_req_is_write(req)) {
         acct = BLOCK_ACCT_WRITE;
         opc = NVME_AIO_OPC_WRITE;
+        cb = nvme_aio_write_cb;
     }
 
     req->nlb  = le16_to_cpu(rw->nlb) + 1;
@@ -1138,7 +1207,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    nvme_aio_rw(ns, opc, req);
+    nvme_aio_rw(ns, opc, cb, req);
     nvme_req_set_cb(req, nvme_rw_cb, NULL);
 
     return NVME_NO_COMPLETE;
@@ -1737,6 +1806,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
+
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
@@ -1802,6 +1873,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
             break;
         }
 
+        break;
+    case NVME_ERROR_RECOVERY:
+        if (!nvme_nsid_valid(n, nsid)) {
+            return NVME_INVALID_NSID | NVME_DNR;
+        }
+
+        ns = nvme_ns(n, nsid);
+        if (unlikely(!ns)) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result = cpu_to_le32(ns->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         result = cpu_to_le32(n->features.vwc);
@@ -1876,7 +1959,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
+    NvmeNamespace *ns = NULL;
 
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -1943,6 +2026,26 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                NVME_LOG_SMART_INFO);
         }
 
+        break;
+    case NVME_ERROR_RECOVERY:
+        if (nsid == NVME_NSID_BROADCAST) {
+            for (int i = 1; i <= n->num_namespaces; i++) {
+                ns = nvme_ns(n, i);
+
+                if (!ns) {
+                    continue;
+                }
+
+                if (NVME_ID_NS_NSFEAT_DULBE(ns->id_ns.nsfeat)) {
+                    ns->features.err_rec = dw11;
+                }
+            }
+
+            break;
+        }
+
+        assert(ns);
+        ns->features.err_rec = dw11;
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         n->features.vwc = dw11 & 0x1;
@@ -2091,6 +2194,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
 
         blk_drain(ns->blk);
+
+        if (ns->blk_state) {
+            blk_drain(ns->blk_state);
+        }
     }
 
     for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
@@ -2121,6 +2228,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
 
         blk_flush(ns->blk);
+
+        if (ns->blk_state) {
+            blk_flush(ns->blk_state);
+        }
     }
 
     n->bar.cc = 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8bf1a050497e..66187902b7cf 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -93,7 +93,8 @@ typedef enum NvmeAIOOp {
 } NvmeAIOOp;
 
 typedef enum NvmeAIOFlags {
-    NVME_AIO_DMA = 1 << 0,
+    NVME_AIO_DMA      = 1 << 0,
+    NVME_AIO_INTERNAL = 1 << 1,
 } NvmeAIOFlags;
 
 typedef struct NvmeAIO NvmeAIO;
@@ -171,6 +172,7 @@ typedef struct NvmeFeatureVal {
 
 static const uint32_t nvme_feature_cap[0x100] = {
     [NVME_TEMPERATURE_THRESHOLD]    = NVME_FEAT_CAP_CHANGE,
+    [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cbcfbfdfbafc..c570c7d0e2a5 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -40,6 +40,8 @@ pci_nvme_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_t prp1,
 pci_nvme_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
 pci_nvme_req_add_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
 pci_nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
+pci_nvme_aio_discard_cb(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
+pci_nvme_aio_write_cb(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
@@ -75,6 +77,7 @@ pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
 pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
 pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
+pci_nvme_ns_update_util(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 6e133469cf28..2a9c5e95bfd2 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -675,6 +675,7 @@ enum NvmeStatusCodes {
     NVME_E2E_REF_ERROR          = 0x0284,
     NVME_CMP_FAILURE            = 0x0285,
     NVME_ACCESS_DENIED          = 0x0286,
+    NVME_DULB                   = 0x0287,
     NVME_MORE                   = 0x2000,
     NVME_DNR                    = 0x4000,
     NVME_NO_COMPLETE            = 0xffff,
@@ -890,6 +891,9 @@ enum NvmeIdCtrlLpa {
 #define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
 #define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
 
+#define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
+#define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                = 0x1,
     NVME_POWER_MANAGEMENT           = 0x2,
@@ -1007,6 +1011,7 @@ enum {
 
 
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
+#define NVME_ID_NS_NSFEAT_DULBE(nsfeat)     ((nsfeat >> 2) & 0x1)
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
 #define NVME_ID_NS_MC_SEPARATE(mc)          ((mc >> 1) & 0x1)
-- 
2.27.0


