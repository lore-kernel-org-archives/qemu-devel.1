Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87061C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495342073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495342073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDAo-00088x-HN
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5f-0007oD-GQ; Tue, 30 Jun 2020 06:02:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5U-0004LW-Sy; Tue, 30 Jun 2020 06:02:09 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 110A3BF676;
 Tue, 30 Jun 2020 10:01:56 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 08/10] hw/block/nvme: allow open to close transitions by
 controller
Date: Tue, 30 Jun 2020 12:01:37 +0200
Message-Id: <20200630100139.1483002-9-its@irrelevant.dk>
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

Allow the controller to release open resources by transitioning
implicitly and explicitly opened zones to closed. This is done using a
naive "least recently opened" strategy. Some workloads may behave very
badly with this, but for the purpose of testing how software deals with
this it is acceptable for now.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c    |   3 +
 hw/block/nvme-ns.h    |   5 ++
 hw/block/nvme.c       | 176 +++++++++++++++++++++++++++++++-----------
 hw/block/nvme.h       |   5 ++
 hw/block/trace-events |   5 ++
 5 files changed, 147 insertions(+), 47 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 5a55a0191f55..3b9fa91c7af8 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -269,6 +269,9 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
         ns->params.zns.mar + 1 : ns->zns.info.num_zones;
     ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
         ns->params.zns.mor + 1 : ns->zns.info.num_zones;
+
+    QTAILQ_INIT(&ns->zns.resources.lru_open);
+    QTAILQ_INIT(&ns->zns.resources.lru_active);
 }
 
 static void nvme_ns_init(NvmeNamespace *ns)
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 5660934d6199..6d3a6dc07cd8 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -39,6 +39,8 @@ typedef struct NvmeZone {
     uint8_t             *zde;
 
     uint64_t wp_staging;
+
+    QTAILQ_ENTRY(NvmeZone) lru_entry;
 } NvmeZone;
 
 typedef struct NvmeNamespace {
@@ -69,6 +71,9 @@ typedef struct NvmeNamespace {
         struct {
             uint32_t open;
             uint32_t active;
+
+            QTAILQ_HEAD(, NvmeZone) lru_open;
+            QTAILQ_HEAD(, NvmeZone) lru_active;
         } resources;
     } zns;
 } NvmeNamespace;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d5d521954cfc..f7b4618bc805 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1187,6 +1187,41 @@ static void nvme_update_zone_descr(NvmeNamespace *ns, NvmeRequest *req,
     nvme_req_add_aio(req, aio);
 }
 
+static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
+                                    NvmeZone *zone, NvmeZoneState to,
+                                    NvmeRequest *req);
+
+static uint16_t nvme_zrm_release_open(NvmeCtrl *n, NvmeNamespace *ns,
+                                      NvmeRequest *req)
+{
+    NvmeZone *candidate;
+    NvmeZoneState zs;
+
+    trace_pci_nvme_zone_zrm_release_open(nvme_cid(req), ns->params.nsid);
+
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_open, lru_entry) {
+        zs = nvme_zs(candidate);
+
+        trace_pci_nvme_zone_zrm_candidate(nvme_cid(req), ns->params.nsid,
+                                          nvme_zslba(candidate),
+                                          nvme_wp(candidate), zs);
+
+        /* skip explicitly opened zones */
+        if (zs == NVME_ZS_ZSEO) {
+            continue;
+        }
+
+        /* the zone cannot be closed if it is currently writing */
+        if (candidate->wp_staging != nvme_wp(candidate)) {
+            continue;
+        }
+
+        return nvme_zrm_transition(n, ns, candidate, NVME_ZS_ZSC, req);
+    }
+
+    return NVME_TOO_MANY_OPEN_ZONES;
+}
+
 /*
  * nvme_zrm_transition validates zone state transitions under the constraint of
  * the Number of Active and Open Resources (NAR and NOR) limits as reported by
@@ -1195,52 +1230,59 @@ static void nvme_update_zone_descr(NvmeNamespace *ns, NvmeRequest *req,
  * The function does NOT change the Zone Attribute field; this must be done by
  * the caller.
  */
-static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
-                                    NvmeZoneState to)
+static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
+                                    NvmeZone *zone, NvmeZoneState to,
+                                    NvmeRequest *req)
 {
     NvmeZoneState from = nvme_zs(zone);
+    uint16_t status;
 
-    /* fast path */
-    if (from == to) {
-        return NVME_SUCCESS;
-    }
+    trace_pci_nvme_zone_zrm_transition(nvme_cid(req), ns->params.nsid,
+                                       nvme_zslba(zone), nvme_zs(zone), to);
 
     switch (from) {
     case NVME_ZS_ZSE:
         switch (to) {
+        case NVME_ZS_ZSE:
+            return NVME_SUCCESS;
+
         case NVME_ZS_ZSRO:
         case NVME_ZS_ZSO:
         case NVME_ZS_ZSF:
-            nvme_zs_set(zone, to);
-            return NVME_SUCCESS;
+            goto out;
 
         case NVME_ZS_ZSC:
             if (!ns->zns.resources.active) {
+                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
                 return NVME_TOO_MANY_ACTIVE_ZONES;
             }
 
             ns->zns.resources.active--;
 
-            nvme_zs_set(zone, to);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
-            return NVME_SUCCESS;
+            goto out;
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.active) {
+                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
                 return NVME_TOO_MANY_ACTIVE_ZONES;
             }
 
             if (!ns->zns.resources.open) {
-                return NVME_TOO_MANY_OPEN_ZONES;
+                status = nvme_zrm_release_open(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.active--;
             ns->zns.resources.open--;
 
-            nvme_zs_set(zone, to);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
-            return NVME_SUCCESS;
+            goto out;
 
         default:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
@@ -1248,6 +1290,9 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     case NVME_ZS_ZSEO:
         switch (to) {
+        case NVME_ZS_ZSEO:
+            return NVME_SUCCESS;
+
         case NVME_ZS_ZSIO:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
         default:
@@ -1258,24 +1303,30 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     case NVME_ZS_ZSIO:
         switch (to) {
-        case NVME_ZS_ZSEO:
-            nvme_zs_set(zone, to);
+        case NVME_ZS_ZSIO:
             return NVME_SUCCESS;
 
+        case NVME_ZS_ZSEO:
+            goto out;
+
         case NVME_ZS_ZSE:
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
         case NVME_ZS_ZSO:
             ns->zns.resources.active++;
+            ns->zns.resources.open++;
 
-            /* fallthrough */
+            QTAILQ_REMOVE(&ns->zns.resources.lru_open, zone, lru_entry);
+
+            goto out;
 
         case NVME_ZS_ZSC:
             ns->zns.resources.open++;
 
-            nvme_zs_set(zone, to);
+            QTAILQ_REMOVE(&ns->zns.resources.lru_open, zone, lru_entry);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
-            return NVME_SUCCESS;
+            goto out;
 
         default:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
@@ -1283,26 +1334,33 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     case NVME_ZS_ZSC:
         switch (to) {
+        case NVME_ZS_ZSC:
+            return NVME_SUCCESS;
+
         case NVME_ZS_ZSE:
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
         case NVME_ZS_ZSO:
             ns->zns.resources.active++;
-            nvme_zs_set(zone, to);
 
-            return NVME_SUCCESS;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_active, zone, lru_entry);
+
+            goto out;
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.open) {
-                return NVME_TOO_MANY_OPEN_ZONES;
+                status = nvme_zrm_release_open(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.open--;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_active, zone, lru_entry);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
-            nvme_zs_set(zone, to);
-
-            return NVME_SUCCESS;
+            goto out;
 
         default:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
@@ -1310,30 +1368,46 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     case NVME_ZS_ZSRO:
         switch (to) {
-        case NVME_ZS_ZSO:
-            nvme_zs_set(zone, to);
+        case NVME_ZS_ZSRO:
             return NVME_SUCCESS;
+
+        case NVME_ZS_ZSO:
+            goto out;
+
         default:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
         }
 
     case NVME_ZS_ZSF:
         switch (to) {
+        case NVME_ZS_ZSF:
+            return NVME_SUCCESS;
+
         case NVME_ZS_ZSE:
         case NVME_ZS_ZSRO:
         case NVME_ZS_ZSO:
-            nvme_zs_set(zone, to);
-            return NVME_SUCCESS;
+            goto out;
+
         default:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
         }
 
     case NVME_ZS_ZSO:
-        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        switch (to) {
+        case NVME_ZS_ZSO:
+            return NVME_SUCCESS;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
 
     default:
         return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
+
+out:
+    nvme_zs_set(zone, to);
+    return NVME_SUCCESS;
 }
 
 static void nvme_aio_write_cb(NvmeAIO *aio, void *opaque, int ret)
@@ -1361,8 +1435,11 @@ static void nvme_zone_advance_wp(NvmeZone *zone, uint32_t nlb,
 
     wp += nlb;
     if (wp == zslba + nvme_zcap(zone)) {
-        /* if we cannot transition to ZFS something is horribly wrong */
-        assert(nvme_zrm_transition(req->ns, zone, NVME_ZS_ZSF) == NVME_SUCCESS);
+        NvmeCtrl *n = nvme_ctrl(req);
+
+        /* if we cannot transition to ZSF something is horribly wrong */
+        assert(nvme_zrm_transition(n, req->ns, zone, NVME_ZS_ZSF, req) ==
+               NVME_SUCCESS);
     }
 
     zd->wp = cpu_to_le64(wp);
@@ -1418,6 +1495,7 @@ static void nvme_zone_mgmt_send_reset_cb(NvmeRequest *req, void *opaque)
 static void nvme_aio_zone_reset_cb(NvmeAIO *aio, void *opaque, int ret)
 {
     NvmeRequest *req = aio->req;
+    NvmeCtrl *n = nvme_ctrl(req);
     NvmeZone *zone = opaque;
     NvmeNamespace *ns = req->ns;
 
@@ -1431,7 +1509,7 @@ static void nvme_aio_zone_reset_cb(NvmeAIO *aio, void *opaque, int ret)
     trace_pci_nvme_aio_zone_reset_cb(nvme_cid(req), ns->params.nsid, zslba);
 
     /* if we cannot transition to ZSE something is horribly wrong */
-    assert(nvme_zrm_transition(ns, zone, NVME_ZS_ZSE) == NVME_SUCCESS);
+    assert(nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSE, req) == NVME_SUCCESS);
     NVME_ZA_CLEAR(zone->zd.za);
 
     zone->zd.wp = zone->zd.zslba;
@@ -1476,6 +1554,7 @@ static void nvme_aio_cb(void *opaque, int ret)
 
         if (req) {
             NvmeNamespace *ns = req->ns;
+            NvmeCtrl *n = nvme_ctrl(req);
             uint16_t status;
 
             switch (aio->opc) {
@@ -1511,7 +1590,7 @@ static void nvme_aio_cb(void *opaque, int ret)
             if (nvme_ns_zoned(ns)) {
                 NvmeZone *zone = nvme_ns_get_zone(ns, req->slba);
 
-                assert(!nvme_zrm_transition(ns, zone, NVME_ZS_ZSO));
+                assert(!nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSO, req));
                 NVME_ZA_CLEAR(zone->zd.za);
 
                 nvme_update_zone_info(ns, req, zone);
@@ -1616,7 +1695,7 @@ static uint16_t nvme_do_zone_append(NvmeCtrl *n, NvmeRequest *req,
     case NVME_ZS_ZSEO:
         break;
     default:
-        status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+        status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSIO, req);
         if (status) {
             goto invalid;
         }
@@ -1653,7 +1732,7 @@ static uint16_t nvme_do_zone_append(NvmeCtrl *n, NvmeRequest *req,
 
 zrm_revert:
     /* if we cannot revert the transition something is horribly wrong */
-    assert(nvme_zrm_transition(ns, zone, zs_orig) == NVME_SUCCESS);
+    assert(nvme_zrm_transition(n, ns, zone, zs_orig, req) == NVME_SUCCESS);
 
 invalid:
     block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
@@ -1706,7 +1785,7 @@ static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
         return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, req);
     if (status) {
         return status;
     }
@@ -1725,7 +1804,7 @@ static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
     trace_pci_nvme_zone_mgmt_send_finish(nvme_cid(req), nvme_nsid(ns),
                                          nvme_zslba(zone), nvme_zs_str(zone));
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSF);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req);
     if (status) {
         return status;
     }
@@ -1743,7 +1822,7 @@ static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
     trace_pci_nvme_zone_mgmt_send_open(nvme_cid(req), nvme_nsid(ns),
                                        nvme_zslba(zone), nvme_zs_str(zone));
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSEO);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSEO, req);
     if (status) {
         return status;
     }
@@ -1792,7 +1871,7 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
         return NVME_NO_COMPLETE;
 
     case NVME_ZS_ZSRO:
-        assert(nvme_zrm_transition(ns, zone, NVME_ZS_ZSO) == NVME_SUCCESS);
+        assert(!nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSO, req));
         nvme_update_zone_info(ns, req, zone);
         return NVME_NO_COMPLETE;
 
@@ -1815,7 +1894,7 @@ static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
 
     switch (nvme_zs(zone)) {
     case NVME_ZS_ZSRO:
-        assert(!nvme_zrm_transition(ns, zone, NVME_ZS_ZSO));
+        assert(!nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSO, req));
         nvme_update_zone_info(ns, req, zone);
         return NVME_NO_COMPLETE;
 
@@ -1844,7 +1923,7 @@ static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
         return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, req);
     if (status) {
         return status;
     }
@@ -1852,7 +1931,7 @@ static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
     status = nvme_dma(n, zone->zde, nvme_ns_zdes_bytes(ns),
                       DMA_DIRECTION_TO_DEVICE, req);
     if (status) {
-        assert(!nvme_zrm_transition(ns, zone, NVME_ZS_ZSE));
+        assert(!nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSE, req));
         return status;
     }
 
@@ -2072,11 +2151,14 @@ static uint16_t nvme_do_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         }
 
         switch (nvme_zs(zone)) {
-        case NVME_ZS_ZSE:
-        case NVME_ZS_ZSC:
-            nvme_zs_set(zone, NVME_ZS_ZSIO);
-        default:
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
             break;
+        default:
+            status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSIO, req);
+            if (status) {
+                return status;
+            }
         }
 
         cb = nvme_aio_zone_write_cb;
@@ -2161,7 +2243,7 @@ static uint16_t nvme_do_rw(NvmeCtrl *n, NvmeRequest *req)
             case NVME_ZS_ZSEO:
                 break;
             default:
-                status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSIO, req);
                 if (status) {
                     return status;
                 }
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 6b4eb0098450..309fb1b94ecb 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -312,6 +312,11 @@ static inline uint16_t nvme_sqid(NvmeRequest *req)
     return le16_to_cpu(req->sq->sqid);
 }
 
+static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
+{
+    return req->sq->ctrl;
+}
+
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 0dfc6e22008e..4b4f2ed7605f 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -98,6 +98,9 @@ pci_nvme_ns_update_util(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu3
 pci_nvme_zone_pending_writes(uint16_t cid, uint64_t zslba, uint64_t wp, uint64_t wp_staging) "cid %"PRIu16" zslba 0x%"PRIx64" wp 0x%"PRIx64" wp_staging 0x%"PRIx64""
 pci_nvme_update_zone_info(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
 pci_nvme_update_zone_descr(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
+pci_nvme_zone_zrm_transition(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t from, uint8_t to) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" from 0x%"PRIx8" to 0x%"PRIx8""
+pci_nvme_zone_zrm_candidate(uint16_t cid, uint32_t nsid, uint64_t zslba, uint64_t wp, uint8_t zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" wp 0x%"PRIx64" zc 0x%"PRIx8""
+pci_nvme_zone_zrm_release_open(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
@@ -121,6 +124,8 @@ pci_nvme_err_zone_is_full(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0x%"PR
 pci_nvme_err_zone_is_read_only(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0x%"PRIx64""
 pci_nvme_err_zone_invalid_write(uint16_t cid, uint64_t slba, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" wp 0x%"PRIx64""
 pci_nvme_err_zone_boundary(uint16_t cid, uint64_t slba, uint32_t nlb, uint64_t zcap) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" zcap 0x%"PRIx64""
+pci_nvme_err_too_many_active_zones(uint16_t cid) "cid %"PRIu16""
+pci_nvme_err_too_many_open_zones(uint16_t cid) "cid %"PRIu16""
 pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
-- 
2.27.0


