Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D087C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF212073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF212073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDCF-0003Hg-GP
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5i-0007r1-7R; Tue, 30 Jun 2020 06:02:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5a-0004MA-5f; Tue, 30 Jun 2020 06:02:13 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 934B7BF7FB;
 Tue, 30 Jun 2020 10:01:57 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 09/10] hw/block/nvme: allow zone excursions
Date: Tue, 30 Jun 2020 12:01:38 +0200
Message-Id: <20200630100139.1483002-10-its@irrelevant.dk>
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

Allow the controller to release active resources by transitioning zones
to the full state.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    |   2 +
 hw/block/nvme.c       | 171 ++++++++++++++++++++++++++++++++++++++----
 hw/block/trace-events |   4 +
 include/block/nvme.h  |  10 +++
 4 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 6d3a6dc07cd8..6acda5c2cf3f 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -75,6 +75,8 @@ typedef struct NvmeNamespace {
             QTAILQ_HEAD(, NvmeZone) lru_open;
             QTAILQ_HEAD(, NvmeZone) lru_active;
         } resources;
+
+        NvmeChangedZoneList changed_list;
     } zns;
 } NvmeNamespace;
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f7b4618bc805..6db6daa62bc5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -859,10 +859,11 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.dw0;
+        result = (NvmeAerResult *) &req->cqe.qw0;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
+        result->nsid = event->result.nsid;
         g_free(event);
 
         req->status = NVME_SUCCESS;
@@ -874,8 +875,9 @@ static void nvme_process_aers(void *opaque)
     }
 }
 
-static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
-                               uint8_t event_info, uint8_t log_page)
+static void nvme_enqueue_event(NvmeCtrl *n, NvmeNamespace *ns,
+                               uint8_t event_type, uint8_t event_info,
+                               uint8_t log_page)
 {
     NvmeAsyncEvent *event;
 
@@ -893,6 +895,11 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
         .log_page   = log_page,
     };
 
+    if (event_info == NVME_AER_INFO_NOTICE_ZONE_DESCR_CHANGED) {
+        assert(ns);
+        event->result.nsid = ns->params.nsid;
+    }
+
     QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
     n->aer_queued++;
 
@@ -1187,15 +1194,50 @@ static void nvme_update_zone_descr(NvmeNamespace *ns, NvmeRequest *req,
     nvme_req_add_aio(req, aio);
 }
 
+static void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
+{
+    uint16_t num_ids = le16_to_cpu(ns->zns.changed_list.num_ids);
+
+    trace_pci_nvme_zone_changed(ns->params.nsid, nvme_zslba(zone));
+
+    if (num_ids < NVME_CHANGED_ZONE_LIST_MAX_IDS) {
+        ns->zns.changed_list.ids[num_ids] = zone->zd.zslba;
+        ns->zns.changed_list.num_ids = cpu_to_le16(num_ids + 1);
+    } else {
+        memset(&ns->zns.changed_list, 0x0, sizeof(NvmeChangedZoneList));
+        ns->zns.changed_list.num_ids = cpu_to_le16(0xffff);
+    }
+
+    nvme_enqueue_event(n, ns, NVME_AER_TYPE_NOTICE,
+                       NVME_AER_INFO_NOTICE_ZONE_DESCR_CHANGED,
+                       NVME_LOG_CHANGED_ZONE_LIST);
+}
+
 static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, NvmeZoneState to,
                                     NvmeRequest *req);
 
+static void nvme_zone_excursion(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+    NvmeRequest *req)
+{
+    trace_pci_nvme_zone_excursion(ns->params.nsid, nvme_zslba(zone),
+                                  nvme_zs_str(zone));
+
+    assert(nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req) == NVME_SUCCESS);
+
+    NVME_ZA_SET_ZFC(zone->zd.za, 0x1);
+
+    nvme_zone_changed(n, ns, zone);
+
+    nvme_update_zone_info(ns, req, zone);
+}
+
 static uint16_t nvme_zrm_release_open(NvmeCtrl *n, NvmeNamespace *ns,
                                       NvmeRequest *req)
 {
     NvmeZone *candidate;
     NvmeZoneState zs;
+    uint16_t status;
 
     trace_pci_nvme_zone_zrm_release_open(nvme_cid(req), ns->params.nsid);
 
@@ -1216,12 +1258,73 @@ static uint16_t nvme_zrm_release_open(NvmeCtrl *n, NvmeNamespace *ns,
             continue;
         }
 
-        return nvme_zrm_transition(n, ns, candidate, NVME_ZS_ZSC, req);
+        status = nvme_zrm_transition(n, ns, candidate, NVME_ZS_ZSC, req);
+        if (status) {
+            return status;
+        }
+
+        nvme_update_zone_info(ns, req, candidate);
+        return NVME_SUCCESS;
     }
 
     return NVME_TOO_MANY_OPEN_ZONES;
 }
 
+static uint16_t nvme_zrm_release_active(NvmeCtrl *n, NvmeNamespace *ns,
+    NvmeRequest *req)
+{
+    NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
+    NvmeZone *candidate = NULL;
+    NvmeZoneDescriptor *zd;
+    NvmeZoneState zs;
+
+    trace_pci_nvme_zone_zrm_release_active(nvme_cid(req), ns->params.nsid);
+
+    /* bail out if Zone Active Excursions are not permitted */
+    if (!(le16_to_cpu(id_ns_zns->zoc) & NVME_ID_NS_ZNS_ZOC_ZAE)) {
+        trace_pci_nvme_zone_zrm_excursion_not_allowed(nvme_cid(req),
+                                                      ns->params.nsid);
+        return NVME_TOO_MANY_ACTIVE_ZONES;
+    }
+
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_active, lru_entry) {
+        zd = &candidate->zd;
+        zs = nvme_zs(candidate);
+
+        trace_pci_nvme_zone_zrm_candidate(nvme_cid(req), ns->params.nsid,
+                                          nvme_zslba(candidate),
+                                          nvme_wp(candidate), zs);
+
+        goto out;
+    }
+
+    /*
+     * If all zone resources are tied up on open zones we have to transition
+     * one of those to full.
+     */
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_open, lru_entry) {
+        zd = &candidate->zd;
+        zs = nvme_zs(candidate);
+
+        trace_pci_nvme_zone_zrm_candidate(nvme_cid(req), ns->params.nsid,
+                                          nvme_zslba(candidate),
+                                          nvme_wp(candidate), zs);
+
+        /* the zone cannot be finished if it is currently writing */
+        if (candidate->wp_staging != le64_to_cpu(zd->wp)) {
+            continue;
+        }
+
+        break;
+    }
+
+    assert(candidate);
+
+out:
+    nvme_zone_excursion(n, ns, candidate, req);
+    return NVME_SUCCESS;
+}
+
 /*
  * nvme_zrm_transition validates zone state transitions under the constraint of
  * the Number of Active and Open Resources (NAR and NOR) limits as reported by
@@ -1253,8 +1356,10 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
 
         case NVME_ZS_ZSC:
             if (!ns->zns.resources.active) {
-                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
-                return NVME_TOO_MANY_ACTIVE_ZONES;
+                status = nvme_zrm_release_active(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.active--;
@@ -1266,8 +1371,10 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.active) {
-                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
-                return NVME_TOO_MANY_ACTIVE_ZONES;
+                status = nvme_zrm_release_active(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             if (!ns->zns.resources.open) {
@@ -2716,6 +2823,41 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_changed_zone_info(NvmeCtrl *n, uint32_t buf_len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+    NvmeNamespace *ns = nvme_ns(n, nsid);
+    uint32_t trans_len;
+    uint16_t status;
+
+    if (unlikely(!ns)) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_LOG_ID | NVME_DNR;
+    }
+
+    if (off > 4096) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len = MIN(4096 - off, buf_len);
+
+    status = nvme_dma(n, (uint8_t *) &ns->zns.changed_list + off, trans_len,
+                      DMA_DIRECTION_FROM_DEVICE, req);
+    if (status) {
+        return status;
+    }
+
+    memset(&ns->zns.changed_list, 0x0, sizeof(NvmeChangedZoneList));
+
+    nvme_clear_events(n, NVME_AER_TYPE_NOTICE);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -2761,6 +2903,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_fw_log_info(n, len, off, req);
     case NVME_LOG_EFFECTS:
         return nvme_effects_log(n, len, off, req);
+    case NVME_LOG_CHANGED_ZONE_LIST:
+        return nvme_changed_zone_info(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -3359,7 +3503,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         if (((n->temperature >= n->features.temp_thresh_hi) ||
             (n->temperature <= n->features.temp_thresh_low)) &&
             NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
-            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+            nvme_enqueue_event(n, NULL, NVME_AER_TYPE_SMART,
                                NVME_AER_INFO_SMART_TEMP_THRESH,
                                NVME_LOG_SMART_INFO);
         }
@@ -3924,7 +4068,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            " sqid=%"PRIu32", ignoring", qid);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -3941,7 +4085,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            qid, new_head);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_VALUE,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -3978,7 +4122,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            " sqid=%"PRIu32", ignoring", qid);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -3995,7 +4139,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            qid, new_tail);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_VALUE,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -4286,6 +4430,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
     id->cntrltype = 0x1;
+    id->oaes = cpu_to_le32(NVME_OAES_ZDCN);
     id->oacs = cpu_to_le16(0);
 
     /*
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 4b4f2ed7605f..c4c80644f782 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -101,6 +101,10 @@ pci_nvme_update_zone_descr(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"P
 pci_nvme_zone_zrm_transition(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t from, uint8_t to) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" from 0x%"PRIx8" to 0x%"PRIx8""
 pci_nvme_zone_zrm_candidate(uint16_t cid, uint32_t nsid, uint64_t zslba, uint64_t wp, uint8_t zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" wp 0x%"PRIx64" zc 0x%"PRIx8""
 pci_nvme_zone_zrm_release_open(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_zrm_release_active(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_zrm_excursion_not_allowed(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_changed(uint32_t nsid, uint64_t zslba) "nsid %"PRIu32" zslba 0x%"PRIx64""
+pci_nvme_zone_excursion(uint32_t nsid, uint64_t zslba, const char *zc) "nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 68dac2582b06..688ee5496168 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -778,6 +778,7 @@ typedef struct NvmeDsmRange {
 enum NvmeAsyncEventRequest {
     NVME_AER_TYPE_ERROR                     = 0,
     NVME_AER_TYPE_SMART                     = 1,
+    NVME_AER_TYPE_NOTICE                    = 2,
     NVME_AER_TYPE_IO_SPECIFIC               = 6,
     NVME_AER_TYPE_VENDOR_SPECIFIC           = 7,
     NVME_AER_INFO_ERR_INVALID_DB_REGISTER   = 0,
@@ -993,6 +994,14 @@ typedef struct NvmeZoneDescriptor {
 #define NVME_ZS(zs) (((zs) >> 4) & 0xf)
 #define NVME_ZS_SET(zs, state) ((zs) = ((state) << 4))
 
+#define NVME_CHANGED_ZONE_LIST_MAX_IDS 511
+
+typedef struct NvmeChangedZoneList {
+    uint16_t num_ids;
+    uint8_t  rsvd2[6];
+    uint64_t ids[NVME_CHANGED_ZONE_LIST_MAX_IDS];
+} NvmeChangedZoneList;
+
 #define NVME_ZA_ZFC(za)  ((za) & (1 << 0))
 #define NVME_ZA_FZR(za)  ((za) & (1 << 1))
 #define NVME_ZA_RZR(za)  ((za) & (1 << 2))
@@ -1428,5 +1437,6 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescriptor) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeChangedZoneList) != 4096);
 }
 #endif
-- 
2.27.0


