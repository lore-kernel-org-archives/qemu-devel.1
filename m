Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838FC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DAB20771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DAB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDAu-0008Qm-Dk
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5h-0007pV-Gy; Tue, 30 Jun 2020 06:02:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5T-0004K0-1n; Tue, 30 Jun 2020 06:02:13 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id BA508BF7F2;
 Tue, 30 Jun 2020 10:01:55 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 06/10] hw/block/nvme: add the zone append command
Date: Tue, 30 Jun 2020 12:01:35 +0200
Message-Id: <20200630100139.1483002-7-its@irrelevant.dk>
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

Add the Zone Append command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 106 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h       |   3 ++
 hw/block/trace-events |   2 +
 3 files changed, 111 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a4527ad9840e..6b394d374c8e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1294,6 +1294,12 @@ static void nvme_aio_zone_reset_cb(NvmeAIO *aio, void *opaque, int ret)
     }
 }
 
+static void nvme_zone_append_cb(NvmeRequest *req, void *opaque)
+{
+    trace_pci_nvme_zone_append_cb(nvme_cid(req), le64_to_cpu(req->cqe.qw0));
+    nvme_rw_cb(req, opaque);
+}
+
 static void nvme_aio_cb(void *opaque, int ret)
 {
     NvmeAIO *aio = opaque;
@@ -1424,6 +1430,104 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_do_zone_append(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeAIO *aio;
+    NvmeNamespace *ns = req->ns;
+
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t wp = zone->wp_staging;
+
+    size_t len;
+    uint16_t status;
+
+    req->cqe.qw0 = cpu_to_le64(wp);
+    req->slba = wp;
+
+    len = req->nlb << nvme_ns_lbads(ns);
+
+    trace_pci_nvme_zone_append(nvme_cid(req), zslba, wp, req->nlb);
+
+    status = nvme_check_rw(n, req);
+    if (status) {
+        goto invalid;
+    }
+
+    status = nvme_check_zone_write(n, req->slba, req->nlb, req, zone);
+    if (status) {
+        goto invalid;
+    }
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSE:
+    case NVME_ZS_ZSC:
+        nvme_zs_set(zone, NVME_ZS_ZSIO);
+    default:
+        break;
+    }
+
+    status = nvme_map(n, len, req);
+    if (status) {
+        goto invalid;
+    }
+
+    aio = g_new0(NvmeAIO, 1);
+    *aio = (NvmeAIO) {
+        .opc = NVME_AIO_OPC_WRITE,
+        .blk = ns->blk,
+        .offset = req->slba << nvme_ns_lbads(ns),
+        .req = req,
+        .cb = nvme_aio_zone_write_cb,
+        .cb_arg = zone,
+    };
+
+    if (req->qsg.sg) {
+        aio->len = req->qsg.size;
+        aio->flags |= NVME_AIO_DMA;
+    } else {
+        aio->len = req->iov.size;
+    }
+
+    nvme_req_add_aio(req, aio);
+    nvme_req_set_cb(req, nvme_zone_append_cb, zone);
+
+    zone->wp_staging += req->nlb;
+
+    return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
+    return status;
+}
+
+static uint16_t nvme_zone_append(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZone *zone;
+    NvmeZoneAppendCmd *zappend = (NvmeZoneAppendCmd *) &req->cmd;
+    NvmeNamespace *ns = req->ns;
+    uint64_t zslba = le64_to_cpu(zappend->zslba);
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    if (zslba & (nvme_ns_zsze(ns) - 1)) {
+        trace_pci_nvme_err_invalid_zslba(nvme_cid(req), zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    req->nlb = le16_to_cpu(zappend->nlb) + 1;
+
+    zone = nvme_ns_get_zone(ns, zslba);
+    if (!zone) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), req->slba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return nvme_do_zone_append(n, req, zone);
+}
+
 static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
     NvmeZone *zone)
 {
@@ -2142,6 +2246,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_zone_mgmt_send(n, req);
     case NVME_CMD_ZONE_MGMT_RECV:
         return nvme_zone_mgmt_recv(n, req);
+    case NVME_CMD_ZONE_APPEND:
+        return nvme_zone_append(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 757277d339bf..6b4eb0098450 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -53,6 +53,8 @@ static const NvmeEffectsLog nvme_effects[] = {
             [NVME_CMD_ZONE_MGMT_RECV]   = NVME_EFFECTS_CSUPP,
             [NVME_CMD_ZONE_MGMT_SEND]   = NVME_EFFECTS_CSUPP |
                 NVME_EFFECTS_LBCC,
+            [NVME_CMD_ZONE_APPEND]      = NVME_EFFECTS_CSUPP |
+                NVME_EFFECTS_LBCC,
         }
     },
 };
@@ -177,6 +179,7 @@ static inline bool nvme_req_is_write(NvmeRequest *req)
     switch (req->cmd.opcode) {
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
+    case NVME_CMD_ZONE_APPEND:
         return true;
     default:
         return false;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 1da48d1c29d0..0dfc6e22008e 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -50,6 +50,8 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" s
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_zone_append(uint16_t cid, uint64_t zslba, uint64_t wp, uint16_t nlb) "cid %"PRIu16" zslba 0x%"PRIx64" wp 0x%"PRIx64" nlb %"PRIu16""
+pci_nvme_zone_append_cb(uint16_t cid, uint64_t slba) "cid %"PRIu16" slba 0x%"PRIx64""
 pci_nvme_zone_mgmt_send(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t zsa, uint8_t zsflags) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zsa 0x%"PRIx8" zsflags 0x%"PRIx8""
 pci_nvme_zone_mgmt_send_all(uint16_t cid, uint32_t nsid, uint8_t za) "cid %"PRIu16" nsid %"PRIu32" za 0x%"PRIx8""
 pci_nvme_zone_mgmt_send_close(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
-- 
2.27.0


