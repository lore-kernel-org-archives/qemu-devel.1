Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B47C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D12420675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D12420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD6n-0000wX-Cq
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5Y-0007kP-9O; Tue, 30 Jun 2020 06:02:05 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5T-0004Jy-1E; Tue, 30 Jun 2020 06:02:03 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 19135BF7EC;
 Tue, 30 Jun 2020 10:01:55 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 05/10] hw/block/nvme: add the zone management send command
Date: Tue, 30 Jun 2020 12:01:34 +0200
Message-Id: <20200630100139.1483002-6-its@irrelevant.dk>
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

Add the Zone Management Send command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 461 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h       |   4 +
 hw/block/trace-events |  12 ++
 3 files changed, 477 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7e943dece352..a4527ad9840e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -748,6 +748,11 @@ static void nvme_submit_aio(NvmeAIO *aio)
         }
 
         break;
+
+    case NVME_AIO_OPC_DISCARD:
+        aio->aiocb = blk_aio_pdiscard(blk, aio->offset, aio->len, nvme_aio_cb,
+                                      aio);
+        break;
     }
 }
 
@@ -1142,6 +1147,46 @@ static void nvme_update_zone_info(NvmeNamespace *ns, NvmeRequest *req,
     nvme_req_add_aio(req, aio);
 }
 
+static void nvme_update_zone_descr(NvmeNamespace *ns, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    uint64_t zslba = -1;
+    QEMUIOVector *iov = g_new0(QEMUIOVector, 1);
+    NvmeAIO *aio = g_new0(NvmeAIO, 1);
+
+    *aio = (NvmeAIO) {
+        .opc = NVME_AIO_OPC_WRITE,
+        .blk = ns->zns.info.blk,
+        .payload = iov,
+        .offset = ns->zns.info.num_zones * sizeof(NvmeZoneDescriptor),
+        .req = req,
+        .flags = NVME_AIO_INTERNAL,
+    };
+
+    qemu_iovec_init(iov, 1);
+
+    if (zone) {
+        zslba = nvme_zslba(zone);
+        trace_pci_nvme_update_zone_descr(nvme_cid(req), ns->params.nsid,
+                                         zslba);
+
+        aio->offset += nvme_ns_zone_idx(ns, zslba) * nvme_ns_zdes_bytes(ns);
+        qemu_iovec_add(iov, zone->zde, nvme_ns_zdes_bytes(ns));
+    } else {
+        trace_pci_nvme_update_zone_descr(nvme_cid(req), ns->params.nsid,
+                                         zslba);
+
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            qemu_iovec_add(iov, ns->zns.info.zones[i].zde,
+                nvme_ns_zdes_bytes(ns));
+        }
+    }
+
+    aio->len = iov->size;
+
+    nvme_req_add_aio(req, aio);
+}
+
 static void nvme_aio_write_cb(NvmeAIO *aio, void *opaque, int ret)
 {
     NvmeRequest *req = aio->req;
@@ -1206,6 +1251,49 @@ static void nvme_rw_cb(NvmeRequest *req, void *opaque)
     nvme_enqueue_req_completion(cq, req);
 }
 
+static void nvme_zone_mgmt_send_reset_cb(NvmeRequest *req, void *opaque)
+{
+    NvmeSQueue *sq = req->sq;
+    NvmeCtrl *n = sq->ctrl;
+    NvmeCQueue *cq = n->cq[sq->cqid];
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_reset_cb(nvme_cid(req), nvme_nsid(ns));
+
+    g_free(opaque);
+
+    nvme_enqueue_req_completion(cq, req);
+}
+
+static void nvme_aio_zone_reset_cb(NvmeAIO *aio, void *opaque, int ret)
+{
+    NvmeRequest *req = aio->req;
+    NvmeZone *zone = opaque;
+    NvmeNamespace *ns = req->ns;
+
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t zcap = nvme_zcap(zone);
+
+    if (ret) {
+        return;
+    }
+
+    trace_pci_nvme_aio_zone_reset_cb(nvme_cid(req), ns->params.nsid, zslba);
+
+    nvme_zs_set(zone, NVME_ZS_ZSE);
+    NVME_ZA_CLEAR(zone->zd.za);
+
+    zone->zd.wp = zone->zd.zslba;
+    zone->wp_staging = zslba;
+
+    nvme_update_zone_info(ns, req, zone);
+
+    if (ns->blk_state) {
+        bitmap_clear(ns->utilization, zslba, zcap);
+        nvme_ns_update_util(ns, zslba, zcap, req);
+    }
+}
+
 static void nvme_aio_cb(void *opaque, int ret)
 {
     NvmeAIO *aio = opaque;
@@ -1336,6 +1424,377 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_close(nvme_cid(req), nvme_nsid(ns),
+                                        nvme_zslba(zone), nvme_zs_str(zone));
+
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+        nvme_zs_set(zone, NVME_ZS_ZSC);
+
+        nvme_update_zone_info(ns, req, zone);
+
+        return NVME_NO_COMPLETE;
+
+    case NVME_ZS_ZSC:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
+                                              nvme_zs(zone));
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_finish(nvme_cid(req), nvme_nsid(ns),
+                                         nvme_zslba(zone), nvme_zs_str(zone));
+
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSE:
+        nvme_zs_set(zone, NVME_ZS_ZSF);
+
+        nvme_update_zone_info(ns, req, zone);
+
+        return NVME_NO_COMPLETE;
+
+    case NVME_ZS_ZSF:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
+                                              nvme_zs(zone));
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_open(nvme_cid(req), nvme_nsid(ns),
+                                       nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSE:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSIO:
+        nvme_zs_set(zone, NVME_ZS_ZSEO);
+
+        nvme_update_zone_info(ns, req, zone);
+        return NVME_NO_COMPLETE;
+
+    case NVME_ZS_ZSEO:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
+                                              nvme_zs(zone));
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeAIO *aio;
+    NvmeNamespace *ns = req->ns;
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t zcap = nvme_zcap(zone);
+    uint8_t lbads = nvme_ns_lbads(ns);
+
+    trace_pci_nvme_zone_mgmt_send_reset(nvme_cid(req), nvme_nsid(ns),
+                                        nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSF:
+        aio = g_new0(NvmeAIO, 1);
+
+        *aio = (NvmeAIO) {
+            .opc = NVME_AIO_OPC_DISCARD,
+            .blk = ns->blk,
+            .offset = zslba << lbads,
+            .len = zcap << lbads,
+            .req = req,
+            .cb = nvme_aio_zone_reset_cb,
+            .cb_arg = zone,
+        };
+
+        nvme_req_add_aio(req, aio);
+        nvme_req_set_cb(req, nvme_zone_mgmt_send_reset_cb, NULL);
+
+        return NVME_NO_COMPLETE;
+
+    case NVME_ZS_ZSE:
+        return NVME_SUCCESS;
+
+    case NVME_ZS_ZSRO:
+        nvme_zs_set(zone, NVME_ZS_ZSO);
+
+        nvme_update_zone_info(ns, req, zone);
+
+        return NVME_NO_COMPLETE;
+
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
+                                              nvme_zs(zone));
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_offline(nvme_cid(req), nvme_nsid(ns),
+                                          nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSRO:
+        nvme_zs_set(zone, NVME_ZS_ZSO);
+
+        nvme_update_zone_info(ns, req, zone);
+        return NVME_NO_COMPLETE;
+
+    case NVME_ZS_ZSO:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
+                                              nvme_zs(zone));
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_set_zde(nvme_cid(req), nvme_nsid(ns),
+                                          nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) != NVME_ZS_ZSE) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req),
+                                                  nvme_zslba(zone),
+                                                  nvme_zs(zone));
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    }
+
+    nvme_zs_set(zone, NVME_ZS_ZSEO);
+
+    status = nvme_dma(n, zone->zde, nvme_ns_zdes_bytes(ns),
+                      DMA_DIRECTION_TO_DEVICE, req);
+    if (status) {
+        return status;
+    }
+
+    NVME_ZA_SET_ZDEV(zone->zd.za, 0x1);
+    nvme_update_zone_descr(ns, req, zone);
+    nvme_update_zone_info(ns, req, zone);
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+    NvmeZoneState zs;
+
+    uint16_t status = NVME_SUCCESS;
+
+    trace_pci_nvme_zone_mgmt_send_all(nvme_cid(req), nvme_nsid(ns), send->zsa);
+
+    switch (send->zsa) {
+    case NVME_CMD_ZONE_MGMT_SEND_SET_ZDE:
+        return NVME_INVALID_FIELD | NVME_DNR;
+
+    case NVME_CMD_ZONE_MGMT_SEND_CLOSE:
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zone = &ns->zns.info.zones[i];
+            zs = nvme_zs(zone);
+
+            switch (zs) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+                status = nvme_zone_mgmt_send_close(n, req, zone);
+                if (status && status != NVME_NO_COMPLETE) {
+                    goto err_out;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_FINISH:
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zone = &ns->zns.info.zones[i];
+            zs = nvme_zs(zone);
+
+            switch (zs) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+            case NVME_ZS_ZSC:
+                status = nvme_zone_mgmt_send_finish(n, req, zone);
+                if (status && status != NVME_NO_COMPLETE) {
+                    goto err_out;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zone = &ns->zns.info.zones[i];
+            zs = nvme_zs(zone);
+
+            if (zs == NVME_ZS_ZSC) {
+                status = nvme_zone_mgmt_send_open(n, req, zone);
+                if (status && status != NVME_NO_COMPLETE) {
+                    goto err_out;
+                }
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_RESET:
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zone = &ns->zns.info.zones[i];
+            zs = nvme_zs(zone);
+
+            switch (zs) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+            case NVME_ZS_ZSC:
+            case NVME_ZS_ZSF:
+                status = nvme_zone_mgmt_send_reset(n, req, zone);
+                if (status && status != NVME_NO_COMPLETE) {
+                    goto err_out;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_OFFLINE:
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zone = &ns->zns.info.zones[i];
+            zs = nvme_zs(zone);
+
+            if (zs == NVME_ZS_ZSRO) {
+                status = nvme_zone_mgmt_send_offline(n, req, zone);
+                if (status && status != NVME_NO_COMPLETE) {
+                    goto err_out;
+                }
+            }
+        }
+
+        break;
+    }
+
+    return status;
+
+err_out:
+    req->status = status;
+
+    if (!QTAILQ_EMPTY(&req->aio_tailq)) {
+        return NVME_NO_COMPLETE;
+    }
+
+    return status;
+}
+
+static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
+    NvmeZoneManagementSendAction zsa = send->zsa;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+    uint64_t zslba = le64_to_cpu(send->slba);
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    trace_pci_nvme_zone_mgmt_send(nvme_cid(req), ns->params.nsid, zslba, zsa,
+                                  send->zsflags);
+
+    if (NVME_CMD_ZONE_MGMT_SEND_SELECT_ALL(send->zsflags)) {
+        return nvme_zone_mgmt_send_all(n, req);
+    }
+
+    if (zslba & (nvme_ns_zsze(ns) - 1)) {
+        trace_pci_nvme_err_invalid_zslba(nvme_cid(req), zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zone = nvme_ns_get_zone(ns, zslba);
+    if (!zone) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (zsa) {
+    case NVME_CMD_ZONE_MGMT_SEND_CLOSE:
+        return nvme_zone_mgmt_send_close(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_FINISH:
+        return nvme_zone_mgmt_send_finish(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        return nvme_zone_mgmt_send_open(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_RESET:
+        return nvme_zone_mgmt_send_reset(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_OFFLINE:
+        return nvme_zone_mgmt_send_offline(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_SET_ZDE:
+        return nvme_zone_mgmt_send_set_zde(n, req, zone);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_do_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeAIO *aio;
@@ -1679,6 +2138,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
         return nvme_rwz(n, req);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
     case NVME_CMD_ZONE_MGMT_RECV:
         return nvme_zone_mgmt_recv(n, req);
     default:
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 92aebb6a6416..757277d339bf 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -51,6 +51,8 @@ static const NvmeEffectsLog nvme_effects[] = {
     [NVME_IOCS_ZONED] = {
         .iocs = {
             [NVME_CMD_ZONE_MGMT_RECV]   = NVME_EFFECTS_CSUPP,
+            [NVME_CMD_ZONE_MGMT_SEND]   = NVME_EFFECTS_CSUPP |
+                NVME_EFFECTS_LBCC,
         }
     },
 };
@@ -127,6 +129,7 @@ typedef enum NvmeAIOOp {
     NVME_AIO_OPC_READ         = 0x2,
     NVME_AIO_OPC_WRITE        = 0x3,
     NVME_AIO_OPC_WRITE_ZEROES = 0x4,
+    NVME_AIO_OPC_DISCARD      = 0x5,
 } NvmeAIOOp;
 
 typedef enum NvmeAIOFlags {
@@ -164,6 +167,7 @@ static inline const char *nvme_aio_opc_str(NvmeAIO *aio)
     case NVME_AIO_OPC_READ:         return "NVME_AIO_OP_READ";
     case NVME_AIO_OPC_WRITE:        return "NVME_AIO_OP_WRITE";
     case NVME_AIO_OPC_WRITE_ZEROES: return "NVME_AIO_OP_WRITE_ZEROES";
+    case NVME_AIO_OPC_DISCARD:      return "NVME_AIO_OP_DISCARD";
     default:                        return "NVME_AIO_OP_UNKNOWN";
     }
 }
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 9d2a7c2766b6..1da48d1c29d0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -43,12 +43,22 @@ pci_nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, c
 pci_nvme_aio_discard_cb(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_aio_write_cb(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_aio_zone_write_cb(uint16_t cid, uint64_t lba, uint32_t nlb, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" wp 0x%"PRIx64""
+pci_nvme_aio_zone_reset_cb(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
 pci_nvme_zone_advance_wp(uint16_t cid, uint64_t lba, uint32_t nlb, uint64_t wp_old, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" wp_old 0x%"PRIx64" wp 0x%"PRIx64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_zone_mgmt_send(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t zsa, uint8_t zsflags) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zsa 0x%"PRIx8" zsflags 0x%"PRIx8""
+pci_nvme_zone_mgmt_send_all(uint16_t cid, uint32_t nsid, uint8_t za) "cid %"PRIu16" nsid %"PRIu32" za 0x%"PRIx8""
+pci_nvme_zone_mgmt_send_close(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_finish(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_open(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_reset(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_reset_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_mgmt_send_offline(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_set_zde(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
 pci_nvme_zone_mgmt_recv(uint16_t cid, uint32_t nsid, uint64_t slba, uint64_t len, uint8_t zra, uint8_t zrasp, uint8_t zrasf) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" len %"PRIu64" zra 0x%"PRIx8" zrasp 0x%"PRIx8" zrasf 0x%"PRIx8""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
@@ -85,6 +95,7 @@ pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_
 pci_nvme_ns_update_util(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_zone_pending_writes(uint16_t cid, uint64_t zslba, uint64_t wp, uint64_t wp_staging) "cid %"PRIu16" zslba 0x%"PRIx64" wp 0x%"PRIx64" wp_staging 0x%"PRIx64""
 pci_nvme_update_zone_info(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
+pci_nvme_update_zone_descr(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
@@ -138,6 +149,7 @@ pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx
 pci_nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
 pci_nvme_err_invalid_zone(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0x%"PRIx64""
 pci_nvme_err_invalid_zone_condition(uint16_t cid, uint64_t zslba, uint8_t condition) "cid %"PRIu16" zslba 0x%"PRIx64" condition 0x%"PRIx8""
+pci_nvme_err_invalid_zslba(uint16_t cid, uint64_t zslba) "cid %"PRIu16" zslba 0x%"PRIx64""
 pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
 pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
 pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
-- 
2.27.0


