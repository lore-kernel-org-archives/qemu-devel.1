Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCD7206CB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCD7206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD8d-000487-Tq
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5b-0007mB-TJ; Tue, 30 Jun 2020 06:02:09 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5Q-0004Jb-DJ; Tue, 30 Jun 2020 06:02:07 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 90E29BF762;
 Tue, 30 Jun 2020 10:01:54 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 04/10] hw/block/nvme: add the zone management receive command
Date: Tue, 30 Jun 2020 12:01:33 +0200
Message-Id: <20200630100139.1483002-5-its@irrelevant.dk>
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

Add the Zone Management Receive command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c    |  33 +++++++++--
 hw/block/nvme-ns.h    |   9 ++-
 hw/block/nvme.c       | 130 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h       |   6 ++
 hw/block/trace-events |   1 +
 include/block/nvme.h  |   5 ++
 6 files changed, 179 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 9a08b2ba0fb2..68996c2f0e72 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -99,6 +99,10 @@ static int nvme_ns_init_blk_zoneinfo(NvmeNamespace *ns, size_t len,
         zd->zcap = ns->params.zns.zcap;
         zone->wp_staging = zslba;
         zd->wp = zd->zslba = cpu_to_le64(zslba);
+
+        if (ns->params.zns.zdes) {
+            zone->zde = g_malloc0(nvme_ns_zdes_bytes(ns));
+        }
     }
 
     ret = nvme_ns_blk_resize(blk, len, &local_err);
@@ -128,7 +132,7 @@ static int nvme_ns_setup_blk_zoneinfo(NvmeNamespace *ns, Error **errp)
     NvmeZoneDescriptor *zd;
     BlockBackend *blk = ns->zns.info.blk;
     uint64_t perm, shared_perm;
-    int64_t len, zoneinfo_len;
+    int64_t len, zoneinfo_len, zone_len;
 
     Error *local_err = NULL;
     int ret;
@@ -142,8 +146,9 @@ static int nvme_ns_setup_blk_zoneinfo(NvmeNamespace *ns, Error **errp)
         return ret;
     }
 
-    zoneinfo_len = ROUND_UP(ns->zns.info.num_zones *
-                            sizeof(NvmeZoneDescriptor), BDRV_SECTOR_SIZE);
+    zone_len = sizeof(NvmeZoneDescriptor) + nvme_ns_zdes_bytes(ns);
+    zoneinfo_len = ROUND_UP(ns->zns.info.num_zones * zone_len,
+                            BDRV_SECTOR_SIZE);
 
     len = blk_getlength(blk);
     if (len < 0) {
@@ -177,6 +182,23 @@ static int nvme_ns_setup_blk_zoneinfo(NvmeNamespace *ns, Error **errp)
 
             zone->wp_staging = nvme_wp(zone);
 
+            if (ns->params.zns.zdes) {
+                uint16_t zde_bytes = nvme_ns_zdes_bytes(ns);
+                int64_t offset = ns->zns.info.num_zones *
+                    sizeof(NvmeZoneDescriptor);
+                ns->zns.info.zones[i].zde = g_malloc(zde_bytes);
+
+                ret = blk_pread(blk, offset + i * zde_bytes,
+                                ns->zns.info.zones[i].zde, zde_bytes);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret, "blk_pread: ");
+                    return ret;
+                } else if (ret != zde_bytes) {
+                    error_setg(errp, "blk_pread: short read");
+                    return -1;
+                }
+            }
+
             switch (nvme_zs(zone)) {
             case NVME_ZS_ZSE:
             case NVME_ZS_ZSF:
@@ -185,7 +207,8 @@ static int nvme_ns_setup_blk_zoneinfo(NvmeNamespace *ns, Error **errp)
                 continue;
 
             case NVME_ZS_ZSC:
-                if (nvme_wp(zone) == nvme_zslba(zone)) {
+                if (nvme_wp(zone) == nvme_zslba(zone) &&
+                    !NVME_ZA_ZDEV(zd->za)) {
                     nvme_zs_set(zone, NVME_ZS_ZSE);
                     continue;
                 }
@@ -231,6 +254,7 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
 
     for (int i = 0; i <= id_ns->nlbaf; i++) {
         id_ns_zns->lbafe[i].zsze = cpu_to_le64(pow2ceil(ns->params.zns.zcap));
+        id_ns_zns->lbafe[i].zdes = ns->params.zns.zdes;
     }
 
     ns->zns.info.num_zones = nvme_ns_nlbas(ns) / nvme_ns_zsze(ns);
@@ -472,6 +496,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, 0x0),
     DEFINE_PROP_DRIVE("zns.zoneinfo", NvmeNamespace, zns.info.blk),
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
+    DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
     DEFINE_PROP_UINT16("zns.zoc", NvmeNamespace, params.zns.zoc, 0),
     DEFINE_PROP_UINT16("zns.ozcs", NvmeNamespace, params.zns.ozcs, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 7dcf0f02a07f..5940fb73e72b 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -26,13 +26,15 @@ typedef struct NvmeNamespaceParams {
 
     struct {
         uint64_t zcap;
+        uint8_t  zdes;
         uint16_t zoc;
         uint16_t ozcs;
     } zns;
 } NvmeNamespaceParams;
 
 typedef struct NvmeZone {
-    NvmeZoneDescriptor zd;
+    NvmeZoneDescriptor  zd;
+    uint8_t             *zde;
 
     uint64_t wp_staging;
 } NvmeZone;
@@ -152,6 +154,11 @@ static inline void nvme_zs_set(NvmeZone *zone, NvmeZoneState zs)
     zone->zd.zs = zs << 4;
 }
 
+static inline size_t nvme_ns_zdes_bytes(NvmeNamespace *ns)
+{
+    return ns->params.zns.zdes << 6;
+}
+
 static inline bool nvme_ns_zone_wp_valid(NvmeZone *zone)
 {
     switch (nvme_zs(zone)) {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4ec3b3029388..7e943dece352 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1528,6 +1528,134 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
     return nvme_do_rw(n, req);
 }
 
+static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementRecvCmd *recv;
+    NvmeZoneManagementRecvAction zra;
+    NvmeZoneManagementRecvActionSpecificField zrasp;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+
+    uint8_t *buf, *bufp, zs_list;
+    uint64_t slba, num_zones = 0, zidx = 0, zidx_begin;
+    uint16_t zes, status;
+    size_t len;
+
+    recv = (NvmeZoneManagementRecvCmd *) &req->cmd;
+
+    zra = recv->zra;
+    zrasp = recv->zrasp;
+    slba = le64_to_cpu(recv->slba);
+    len = (le32_to_cpu(recv->numdw) + 1) << 2;
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    trace_pci_nvme_zone_mgmt_recv(nvme_cid(req), nvme_nsid(ns), slba, len,
+                                  zra, zrasp, recv->zrasf);
+
+    if (!len) {
+        return NVME_SUCCESS;
+    }
+
+    switch (zrasp) {
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ALL:
+        zs_list = 0;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSE:
+        zs_list = NVME_ZS_ZSE;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSIO:
+        zs_list = NVME_ZS_ZSIO;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSEO:
+        zs_list = NVME_ZS_ZSEO;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSC:
+        zs_list = NVME_ZS_ZSC;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSF:
+        zs_list = NVME_ZS_ZSF;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSRO:
+        zs_list = NVME_ZS_ZSRO;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSO:
+        zs_list = NVME_ZS_ZSO;
+        break;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    status = nvme_check_mdts(n, len);
+    if (status) {
+        return status;
+    }
+
+    if (!nvme_ns_get_zone(ns, slba)) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), slba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zidx_begin = zidx = nvme_ns_zone_idx(ns, slba);
+    zes = sizeof(NvmeZoneDescriptor);
+    if (zra == NVME_CMD_ZONE_MGMT_RECV_EXTENDED_REPORT_ZONES) {
+        zes += nvme_ns_zdes_bytes(ns);
+    }
+
+    buf = bufp = g_malloc0(len);
+    bufp += sizeof(NvmeZoneReportHeader);
+
+    while ((bufp + zes) - buf <= len && zidx < ns->zns.info.num_zones) {
+        zone = &ns->zns.info.zones[zidx++];
+
+        if (zs_list && zs_list != nvme_zs(zone)) {
+            continue;
+        }
+
+        num_zones++;
+
+        memcpy(bufp, &zone->zd, sizeof(NvmeZoneDescriptor));
+
+        if (zra == NVME_CMD_ZONE_MGMT_RECV_EXTENDED_REPORT_ZONES) {
+            memcpy(bufp + sizeof(NvmeZoneDescriptor), zone->zde,
+                   nvme_ns_zdes_bytes(ns));
+        }
+
+        bufp += zes;
+    }
+
+    if (!(recv->zrasf & NVME_CMD_ZONE_MGMT_RECEIVE_PARTIAL)) {
+        if (!zs_list) {
+            num_zones = ns->zns.info.num_zones - zidx_begin;
+        } else {
+            num_zones = 0;
+            for (int i = zidx_begin; i < ns->zns.info.num_zones; i++) {
+                zone = &ns->zns.info.zones[i];
+
+                if (zs_list == nvme_zs(zone)) {
+                    num_zones++;
+                }
+            }
+        }
+    }
+
+    stq_le_p(buf, num_zones);
+
+    status = nvme_dma(n, buf, len, DMA_DIRECTION_FROM_DEVICE, req);
+    g_free(buf);
+
+    return status;
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
@@ -1551,6 +1679,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
         return nvme_rwz(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1ec1af8d6291..92aebb6a6416 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -47,6 +47,12 @@ static const NvmeEffectsLog nvme_effects[] = {
                 NVME_EFFECTS_LBCC,
         },
     },
+
+    [NVME_IOCS_ZONED] = {
+        .iocs = {
+            [NVME_CMD_ZONE_MGMT_RECV]   = NVME_EFFECTS_CSUPP,
+        }
+    },
 };
 
 typedef struct NvmeAsyncEvent {
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 9e0b848186c8..9d2a7c2766b6 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -49,6 +49,7 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" s
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_zone_mgmt_recv(uint16_t cid, uint32_t nsid, uint64_t slba, uint64_t len, uint8_t zra, uint8_t zrasp, uint8_t zrasf) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" len %"PRIu64" zra 0x%"PRIx8" zrasp 0x%"PRIx8" zrasf 0x%"PRIx8""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index ddf948132272..68dac2582b06 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -746,6 +746,11 @@ typedef enum NvmeZoneManagementRecvActionSpecificField {
 
 #define NVME_CMD_ZONE_MGMT_RECEIVE_PARTIAL 0x1
 
+typedef struct NvmeZoneReportHeader {
+    uint64_t num_zones;
+    uint8_t  rsvd[56];
+} NvmeZoneReportHeader;
+
 typedef struct NvmeDsmCmd {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.27.0


