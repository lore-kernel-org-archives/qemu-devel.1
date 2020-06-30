Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E004C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F9220771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F9220771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD98-000522-1o
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5f-0007oR-KA; Tue, 30 Jun 2020 06:02:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5U-0004LX-SH; Tue, 30 Jun 2020 06:02:11 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 66748BF7F3;
 Tue, 30 Jun 2020 10:01:56 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 07/10] hw/block/nvme: track and enforce zone resources
Date: Tue, 30 Jun 2020 12:01:36 +0200
Message-Id: <20200630100139.1483002-8-its@irrelevant.dk>
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

Move all zone transition rules to a single state machine that also
manages zone resources.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c |  17 ++-
 hw/block/nvme-ns.h |   7 ++
 hw/block/nvme.c    | 304 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 242 insertions(+), 86 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 68996c2f0e72..5a55a0191f55 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -262,8 +262,13 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
 
     id_ns->ncap = ns->zns.info.num_zones * ns->params.zns.zcap;
 
-    id_ns_zns->mar = 0xffffffff;
-    id_ns_zns->mor = 0xffffffff;
+    id_ns_zns->mar = cpu_to_le32(ns->params.zns.mar);
+    id_ns_zns->mor = cpu_to_le32(ns->params.zns.mor);
+
+    ns->zns.resources.active = ns->params.zns.mar != 0xffffffff ?
+        ns->params.zns.mar + 1 : ns->zns.info.num_zones;
+    ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
+        ns->params.zns.mor + 1 : ns->zns.info.num_zones;
 }
 
 static void nvme_ns_init(NvmeNamespace *ns)
@@ -426,6 +431,12 @@ static int nvme_ns_check_constraints(NvmeCtrl *n, NvmeNamespace *ns, Error
             return -1;
         }
 
+        if (ns->params.zns.mor > ns->params.zns.mar) {
+            error_setg(errp, "maximum open resources (MOR) must be less "
+                       "than or equal to maximum active resources (MAR)");
+            return -1;
+        }
+
         break;
 
     default:
@@ -499,6 +510,8 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
     DEFINE_PROP_UINT16("zns.zoc", NvmeNamespace, params.zns.zoc, 0),
     DEFINE_PROP_UINT16("zns.ozcs", NvmeNamespace, params.zns.ozcs, 0),
+    DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
+    DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 5940fb73e72b..5660934d6199 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -29,6 +29,8 @@ typedef struct NvmeNamespaceParams {
         uint8_t  zdes;
         uint16_t zoc;
         uint16_t ozcs;
+        uint32_t mar;
+        uint32_t mor;
     } zns;
 } NvmeNamespaceParams;
 
@@ -63,6 +65,11 @@ typedef struct NvmeNamespace {
             uint64_t  num_zones;
             NvmeZone *zones;
         } info;
+
+        struct {
+            uint32_t open;
+            uint32_t active;
+        } resources;
     } zns;
 } NvmeNamespace;
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 6b394d374c8e..d5d521954cfc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1187,6 +1187,155 @@ static void nvme_update_zone_descr(NvmeNamespace *ns, NvmeRequest *req,
     nvme_req_add_aio(req, aio);
 }
 
+/*
+ * nvme_zrm_transition validates zone state transitions under the constraint of
+ * the Number of Active and Open Resources (NAR and NOR) limits as reported by
+ * the Identify Namespace Data Structure.
+ *
+ * The function does NOT change the Zone Attribute field; this must be done by
+ * the caller.
+ */
+static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
+                                    NvmeZoneState to)
+{
+    NvmeZoneState from = nvme_zs(zone);
+
+    /* fast path */
+    if (from == to) {
+        return NVME_SUCCESS;
+    }
+
+    switch (from) {
+    case NVME_ZS_ZSE:
+        switch (to) {
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+        case NVME_ZS_ZSF:
+            nvme_zs_set(zone, to);
+            return NVME_SUCCESS;
+
+        case NVME_ZS_ZSC:
+            if (!ns->zns.resources.active) {
+                return NVME_TOO_MANY_ACTIVE_ZONES;
+            }
+
+            ns->zns.resources.active--;
+
+            nvme_zs_set(zone, to);
+
+            return NVME_SUCCESS;
+
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            if (!ns->zns.resources.active) {
+                return NVME_TOO_MANY_ACTIVE_ZONES;
+            }
+
+            if (!ns->zns.resources.open) {
+                return NVME_TOO_MANY_OPEN_ZONES;
+            }
+
+            ns->zns.resources.active--;
+            ns->zns.resources.open--;
+
+            nvme_zs_set(zone, to);
+
+            return NVME_SUCCESS;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+    case NVME_ZS_ZSEO:
+        switch (to) {
+        case NVME_ZS_ZSIO:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        default:
+            break;
+        }
+
+        /* fallthrough */
+
+    case NVME_ZS_ZSIO:
+        switch (to) {
+        case NVME_ZS_ZSEO:
+            nvme_zs_set(zone, to);
+            return NVME_SUCCESS;
+
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+            ns->zns.resources.active++;
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSC:
+            ns->zns.resources.open++;
+
+            nvme_zs_set(zone, to);
+
+            return NVME_SUCCESS;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+    case NVME_ZS_ZSC:
+        switch (to) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+            ns->zns.resources.active++;
+            nvme_zs_set(zone, to);
+
+            return NVME_SUCCESS;
+
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            if (!ns->zns.resources.open) {
+                return NVME_TOO_MANY_OPEN_ZONES;
+            }
+
+            ns->zns.resources.open--;
+
+            nvme_zs_set(zone, to);
+
+            return NVME_SUCCESS;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+    case NVME_ZS_ZSRO:
+        switch (to) {
+        case NVME_ZS_ZSO:
+            nvme_zs_set(zone, to);
+            return NVME_SUCCESS;
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+    case NVME_ZS_ZSF:
+        switch (to) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+            nvme_zs_set(zone, to);
+            return NVME_SUCCESS;
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+    case NVME_ZS_ZSO:
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+
+    default:
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    }
+}
+
 static void nvme_aio_write_cb(NvmeAIO *aio, void *opaque, int ret)
 {
     NvmeRequest *req = aio->req;
@@ -1212,7 +1361,8 @@ static void nvme_zone_advance_wp(NvmeZone *zone, uint32_t nlb,
 
     wp += nlb;
     if (wp == zslba + nvme_zcap(zone)) {
-        nvme_zs_set(zone, NVME_ZS_ZSF);
+        /* if we cannot transition to ZFS something is horribly wrong */
+        assert(nvme_zrm_transition(req->ns, zone, NVME_ZS_ZSF) == NVME_SUCCESS);
     }
 
     zd->wp = cpu_to_le64(wp);
@@ -1280,7 +1430,8 @@ static void nvme_aio_zone_reset_cb(NvmeAIO *aio, void *opaque, int ret)
 
     trace_pci_nvme_aio_zone_reset_cb(nvme_cid(req), ns->params.nsid, zslba);
 
-    nvme_zs_set(zone, NVME_ZS_ZSE);
+    /* if we cannot transition to ZSE something is horribly wrong */
+    assert(nvme_zrm_transition(ns, zone, NVME_ZS_ZSE) == NVME_SUCCESS);
     NVME_ZA_CLEAR(zone->zd.za);
 
     zone->zd.wp = zone->zd.zslba;
@@ -1360,7 +1511,7 @@ static void nvme_aio_cb(void *opaque, int ret)
             if (nvme_ns_zoned(ns)) {
                 NvmeZone *zone = nvme_ns_get_zone(ns, req->slba);
 
-                nvme_zs_set(zone, NVME_ZS_ZSO);
+                assert(!nvme_zrm_transition(ns, zone, NVME_ZS_ZSO));
                 NVME_ZA_CLEAR(zone->zd.za);
 
                 nvme_update_zone_info(ns, req, zone);
@@ -1431,10 +1582,11 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 }
 
 static uint16_t nvme_do_zone_append(NvmeCtrl *n, NvmeRequest *req,
-    NvmeZone *zone)
+                                    NvmeZone *zone)
 {
     NvmeAIO *aio;
     NvmeNamespace *ns = req->ns;
+    NvmeZoneState zs_orig = nvme_zs(zone);
 
     uint64_t zslba = nvme_zslba(zone);
     uint64_t wp = zone->wp_staging;
@@ -1459,17 +1611,20 @@ static uint16_t nvme_do_zone_append(NvmeCtrl *n, NvmeRequest *req,
         goto invalid;
     }
 
-    switch (nvme_zs(zone)) {
-    case NVME_ZS_ZSE:
-    case NVME_ZS_ZSC:
-        nvme_zs_set(zone, NVME_ZS_ZSIO);
-    default:
+    switch (zs_orig) {
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
         break;
+    default:
+        status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+        if (status) {
+            goto invalid;
+        }
     }
 
     status = nvme_map(n, len, req);
     if (status) {
-        goto invalid;
+        goto zrm_revert;
     }
 
     aio = g_new0(NvmeAIO, 1);
@@ -1496,6 +1651,10 @@ static uint16_t nvme_do_zone_append(NvmeCtrl *n, NvmeRequest *req,
 
     return NVME_NO_COMPLETE;
 
+zrm_revert:
+    /* if we cannot revert the transition something is horribly wrong */
+    assert(nvme_zrm_transition(ns, zone, zs_orig) == NVME_SUCCESS);
+
 invalid:
     block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
     return status;
@@ -1532,91 +1691,66 @@ static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
     NvmeZone *zone)
 {
     NvmeNamespace *ns = req->ns;
+    NvmeZoneState zs = nvme_zs(zone);
+    uint16_t status;
 
     trace_pci_nvme_zone_mgmt_send_close(nvme_cid(req), nvme_nsid(ns),
                                         nvme_zslba(zone), nvme_zs_str(zone));
 
-
-    switch (nvme_zs(zone)) {
-    case NVME_ZS_ZSIO:
-    case NVME_ZS_ZSEO:
-        nvme_zs_set(zone, NVME_ZS_ZSC);
-
-        nvme_update_zone_info(ns, req, zone);
-
-        return NVME_NO_COMPLETE;
-
-    case NVME_ZS_ZSC:
-        return NVME_SUCCESS;
-
-    default:
-        break;
+    /*
+     * The state machine in nvme_zrm_transition allows zones to transition fram
+     * ZSE to ZSC. That transition is only valid if done as part Set Zone
+     * Descriptor, so do an early check here.
+     */
+    if (zs == NVME_ZS_ZSE) {
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
 
-    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
-                                              nvme_zs(zone));
-    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    if (status) {
+        return status;
+    }
+
+    nvme_update_zone_info(ns, req, zone);
+
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
     NvmeZone *zone)
 {
     NvmeNamespace *ns = req->ns;
+    uint16_t status;
 
     trace_pci_nvme_zone_mgmt_send_finish(nvme_cid(req), nvme_nsid(ns),
                                          nvme_zslba(zone), nvme_zs_str(zone));
 
-
-    switch (nvme_zs(zone)) {
-    case NVME_ZS_ZSIO:
-    case NVME_ZS_ZSEO:
-    case NVME_ZS_ZSC:
-    case NVME_ZS_ZSE:
-        nvme_zs_set(zone, NVME_ZS_ZSF);
-
-        nvme_update_zone_info(ns, req, zone);
-
-        return NVME_NO_COMPLETE;
-
-    case NVME_ZS_ZSF:
-        return NVME_SUCCESS;
-
-    default:
-        break;
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSF);
+    if (status) {
+        return status;
     }
 
-    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
-                                              nvme_zs(zone));
-    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    nvme_update_zone_info(ns, req, zone);
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
     NvmeZone *zone)
 {
     NvmeNamespace *ns = req->ns;
+    uint16_t status;
 
     trace_pci_nvme_zone_mgmt_send_open(nvme_cid(req), nvme_nsid(ns),
                                        nvme_zslba(zone), nvme_zs_str(zone));
 
-    switch (nvme_zs(zone)) {
-    case NVME_ZS_ZSE:
-    case NVME_ZS_ZSC:
-    case NVME_ZS_ZSIO:
-        nvme_zs_set(zone, NVME_ZS_ZSEO);
-
-        nvme_update_zone_info(ns, req, zone);
-        return NVME_NO_COMPLETE;
-
-    case NVME_ZS_ZSEO:
-        return NVME_SUCCESS;
-
-    default:
-        break;
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSEO);
+    if (status) {
+        return status;
     }
 
-    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
-                                              nvme_zs(zone));
-    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    nvme_update_zone_info(ns, req, zone);
+
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
@@ -1624,6 +1758,7 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
 {
     NvmeAIO *aio;
     NvmeNamespace *ns = req->ns;
+    NvmeZoneState zs = nvme_zs(zone);
     uint64_t zslba = nvme_zslba(zone);
     uint64_t zcap = nvme_zcap(zone);
     uint8_t lbads = nvme_ns_lbads(ns);
@@ -1631,7 +1766,10 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
     trace_pci_nvme_zone_mgmt_send_reset(nvme_cid(req), nvme_nsid(ns),
                                         nvme_zslba(zone), nvme_zs_str(zone));
 
-    switch (nvme_zs(zone)) {
+    switch (zs) {
+    case NVME_ZS_ZSE:
+        return NVME_SUCCESS;
+
     case NVME_ZS_ZSIO:
     case NVME_ZS_ZSEO:
     case NVME_ZS_ZSC:
@@ -1653,18 +1791,13 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
 
         return NVME_NO_COMPLETE;
 
-    case NVME_ZS_ZSE:
-        return NVME_SUCCESS;
-
     case NVME_ZS_ZSRO:
-        nvme_zs_set(zone, NVME_ZS_ZSO);
-
+        assert(nvme_zrm_transition(ns, zone, NVME_ZS_ZSO) == NVME_SUCCESS);
         nvme_update_zone_info(ns, req, zone);
-
         return NVME_NO_COMPLETE;
 
-    default:
-        break;
+    case NVME_ZS_ZSO:
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
 
     trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), nvme_zslba(zone),
@@ -1682,14 +1815,10 @@ static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
 
     switch (nvme_zs(zone)) {
     case NVME_ZS_ZSRO:
-        nvme_zs_set(zone, NVME_ZS_ZSO);
-
+        assert(!nvme_zrm_transition(ns, zone, NVME_ZS_ZSO));
         nvme_update_zone_info(ns, req, zone);
         return NVME_NO_COMPLETE;
 
-    case NVME_ZS_ZSO:
-        return NVME_SUCCESS;
-
     default:
         break;
     }
@@ -1715,11 +1844,15 @@ static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
         return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
 
-    nvme_zs_set(zone, NVME_ZS_ZSEO);
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    if (status) {
+        return status;
+    }
 
     status = nvme_dma(n, zone->zde, nvme_ns_zdes_bytes(ns),
                       DMA_DIRECTION_TO_DEVICE, req);
     if (status) {
+        assert(!nvme_zrm_transition(ns, zone, NVME_ZS_ZSE));
         return status;
     }
 
@@ -2024,11 +2157,14 @@ static uint16_t nvme_do_rw(NvmeCtrl *n, NvmeRequest *req)
 
         if (nvme_req_is_write(req)) {
             switch (nvme_zs(zone)) {
-            case NVME_ZS_ZSE:
-            case NVME_ZS_ZSC:
-                nvme_zs_set(zone, NVME_ZS_ZSIO);
-            default:
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
                 break;
+            default:
+                status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                if (status) {
+                    return status;
+                }
             }
 
             cb = nvme_aio_zone_write_cb;
-- 
2.27.0


