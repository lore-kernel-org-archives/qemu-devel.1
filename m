Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79066C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C45D2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C45D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDE0-00078q-E4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5i-0007sd-Sa; Tue, 30 Jun 2020 06:02:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5a-0004M9-4z; Tue, 30 Jun 2020 06:02:14 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1B14DBF803;
 Tue, 30 Jun 2020 10:01:58 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 10/10] hw/block/nvme: support reset/finish recommended limits
Date: Tue, 30 Jun 2020 12:01:39 +0200
Message-Id: <20200630100139.1483002-11-its@irrelevant.dk>
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

Add the rrl and frl device parameters. The parameters specify the number
of seconds before the device may perform an internal operation to
"clear" the Reset Zone Recommended and Finish Zone Recommended
attributes respectively.

When the attibutes are set is governed by the rrld and frld parameters
(Reset/Finish Recomended Limit Delay). The Reset Zone Recommended Delay
starts when a zone becomes full. The Finish Zone Recommended Delay
starts when the zone is first activated.  When the limits are reached,
the attributes are cleared again and the process is restarted.

If zone excursions are enabled (they are by default), when the Finish
Recommended Limit is reached, the device will finish the zone.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c    | 105 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme-ns.h    |  13 ++++++
 hw/block/nvme.c       |  49 +++++++++++++-------
 hw/block/nvme.h       |   7 +++
 hw/block/trace-events |   3 +-
 5 files changed, 160 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 3b9fa91c7af8..7f9b1d526197 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 
+#include "trace.h"
 #include "nvme.h"
 #include "nvme-ns.h"
 
@@ -48,6 +49,91 @@ const char *nvme_zs_to_str(NvmeZoneState zs)
     return NULL;
 }
 
+static void nvme_ns_process_timer(void *opaque)
+{
+    NvmeNamespace *ns = opaque;
+    BusState *s = qdev_get_parent_bus(&ns->parent_obj);
+    NvmeCtrl *n = NVME(s->parent);
+    NvmeZone *zone;
+
+    trace_pci_nvme_ns_process_timer(ns->params.nsid);
+
+    int64_t next_timer = INT64_MAX, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    QTAILQ_FOREACH(zone, &ns->zns.resources.lru_open, lru_entry) {
+        int64_t activated_ns = now - zone->stats.activated_ns;
+        if (activated_ns < ns->zns.frld_ns) {
+            next_timer = MIN(next_timer, zone->stats.activated_ns +
+                             ns->zns.frld_ns);
+
+            break;
+        }
+
+        if (activated_ns < ns->zns.frld_ns + ns->zns.frl_ns) {
+            NVME_ZA_SET_FZR(zone->zd.za, 0x1);
+            nvme_zone_changed(n, ns, zone);
+
+            next_timer = MIN(next_timer, now + ns->zns.frl_ns);
+
+            continue;
+        }
+
+        if (zone->wp_staging != le64_to_cpu(zone->zd.wp)) {
+            next_timer = now + 500;
+            continue;
+        }
+
+        nvme_zone_excursion(n, ns, zone, NULL);
+    }
+
+    QTAILQ_FOREACH(zone, &ns->zns.resources.lru_active, lru_entry) {
+        int64_t activated_ns = now - zone->stats.activated_ns;
+        if (activated_ns < ns->zns.frld_ns) {
+            next_timer = MIN(next_timer, zone->stats.activated_ns +
+                             ns->zns.frld_ns);
+
+            break;
+        }
+
+        if (activated_ns < ns->zns.frld_ns + ns->zns.frl_ns) {
+            NVME_ZA_SET_FZR(zone->zd.za, 0x1);
+            nvme_zone_changed(n, ns, zone);
+
+            next_timer = MIN(next_timer, now + ns->zns.frl_ns);
+
+            continue;
+        }
+
+        nvme_zone_excursion(n, ns, zone, NULL);
+    }
+
+    QTAILQ_FOREACH(zone, &ns->zns.lru_finished, lru_entry) {
+        int64_t finished_ns = now - zone->stats.finished_ns;
+        if (finished_ns < ns->zns.rrld_ns) {
+            next_timer = MIN(next_timer, zone->stats.finished_ns +
+                             ns->zns.rrld_ns);
+
+            break;
+        }
+
+        if (finished_ns < ns->zns.rrld_ns + ns->zns.rrl_ns) {
+            NVME_ZA_SET_RZR(zone->zd.za, 0x1);
+            nvme_zone_changed(n, ns, zone);
+
+            next_timer = MIN(next_timer, now + ns->zns.rrl_ns);
+
+            nvme_zone_changed(n, ns, zone);
+            continue;
+        }
+
+        NVME_ZA_SET_RZR(zone->zd.za, 0x0);
+    }
+
+    if (next_timer != INT64_MAX) {
+        timer_mod(ns->zns.timer, next_timer);
+    }
+}
+
 static int nvme_ns_blk_resize(BlockBackend *blk, size_t len, Error **errp)
 {
 	Error *local_err = NULL;
@@ -262,6 +348,21 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
 
     id_ns->ncap = ns->zns.info.num_zones * ns->params.zns.zcap;
 
+    id_ns_zns->rrl = ns->params.zns.rrl;
+    id_ns_zns->frl = ns->params.zns.frl;
+
+    if (ns->params.zns.rrl || ns->params.zns.frl) {
+        ns->zns.rrl_ns = ns->params.zns.rrl * NANOSECONDS_PER_SECOND;
+        ns->zns.rrld_ns = ns->params.zns.rrld * NANOSECONDS_PER_SECOND;
+        ns->zns.frl_ns = ns->params.zns.frl * NANOSECONDS_PER_SECOND;
+        ns->zns.frld_ns = ns->params.zns.frld * NANOSECONDS_PER_SECOND;
+
+        ns->zns.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                     nvme_ns_process_timer, ns);
+
+        QTAILQ_INIT(&ns->zns.lru_finished);
+    }
+
     id_ns_zns->mar = cpu_to_le32(ns->params.zns.mar);
     id_ns_zns->mor = cpu_to_le32(ns->params.zns.mor);
 
@@ -515,6 +616,10 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT16("zns.ozcs", NvmeNamespace, params.zns.ozcs, 0),
     DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
     DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
+    DEFINE_PROP_UINT32("zns.rrl", NvmeNamespace, params.zns.rrl, 0),
+    DEFINE_PROP_UINT32("zns.frl", NvmeNamespace, params.zns.frl, 0),
+    DEFINE_PROP_UINT32("zns.rrld", NvmeNamespace, params.zns.rrld, 0),
+    DEFINE_PROP_UINT32("zns.frld", NvmeNamespace, params.zns.frld, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 6acda5c2cf3f..f92045f19948 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -31,6 +31,10 @@ typedef struct NvmeNamespaceParams {
         uint16_t ozcs;
         uint32_t mar;
         uint32_t mor;
+        uint32_t rrl;
+        uint32_t frl;
+        uint32_t rrld;
+        uint32_t frld;
     } zns;
 } NvmeNamespaceParams;
 
@@ -40,6 +44,11 @@ typedef struct NvmeZone {
 
     uint64_t wp_staging;
 
+    struct {
+        int64_t activated_ns;
+        int64_t finished_ns;
+    } stats;
+
     QTAILQ_ENTRY(NvmeZone) lru_entry;
 } NvmeZone;
 
@@ -77,6 +86,10 @@ typedef struct NvmeNamespace {
         } resources;
 
         NvmeChangedZoneList changed_list;
+
+        QTAILQ_HEAD(, NvmeZone) lru_finished;
+        QEMUTimer *timer;
+        int64_t rrl_ns, rrld_ns, frl_ns, frld_ns;
     } zns;
 } NvmeNamespace;
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 6db6daa62bc5..f28373feb887 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -875,13 +875,13 @@ static void nvme_process_aers(void *opaque)
     }
 }
 
-static void nvme_enqueue_event(NvmeCtrl *n, NvmeNamespace *ns,
-                               uint8_t event_type, uint8_t event_info,
-                               uint8_t log_page)
+void nvme_enqueue_event(NvmeCtrl *n, NvmeNamespace *ns, uint8_t event_type,
+                        uint8_t event_info, uint8_t log_page)
 {
     NvmeAsyncEvent *event;
 
-    trace_pci_nvme_enqueue_event(event_type, event_info, log_page);
+    trace_pci_nvme_enqueue_event(ns ? ns->params.nsid : -1, event_type,
+                                 event_info, log_page);
 
     if (n->aer_queued == n->params.aer_max_queued) {
         trace_pci_nvme_enqueue_event_noqueue(n->aer_queued);
@@ -1194,7 +1194,7 @@ static void nvme_update_zone_descr(NvmeNamespace *ns, NvmeRequest *req,
     nvme_req_add_aio(req, aio);
 }
 
-static void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
+void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
 {
     uint16_t num_ids = le16_to_cpu(ns->zns.changed_list.num_ids);
 
@@ -1213,12 +1213,8 @@ static void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
                        NVME_LOG_CHANGED_ZONE_LIST);
 }
 
-static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
-                                    NvmeZone *zone, NvmeZoneState to,
-                                    NvmeRequest *req);
-
-static void nvme_zone_excursion(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
-    NvmeRequest *req)
+void nvme_zone_excursion(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                         NvmeRequest *req)
 {
     trace_pci_nvme_zone_excursion(ns->params.nsid, nvme_zslba(zone),
                                   nvme_zs_str(zone));
@@ -1226,6 +1222,7 @@ static void nvme_zone_excursion(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
     assert(nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req) == NVME_SUCCESS);
 
     NVME_ZA_SET_ZFC(zone->zd.za, 0x1);
+    NVME_ZA_SET_FZR(zone->zd.za, 0x0);
 
     nvme_zone_changed(n, ns, zone);
 
@@ -1333,9 +1330,8 @@ out:
  * The function does NOT change the Zone Attribute field; this must be done by
  * the caller.
  */
-static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
-                                    NvmeZone *zone, NvmeZoneState to,
-                                    NvmeRequest *req)
+uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                             NvmeZoneState to, NvmeRequest *req)
 {
     NvmeZoneState from = nvme_zs(zone);
     uint16_t status;
@@ -1366,7 +1362,7 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
 
             QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
-            goto out;
+            goto activated;
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
@@ -1389,7 +1385,7 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
 
             QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
-            goto out;
+            goto activated;
 
         default:
             return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
@@ -1512,8 +1508,28 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
         return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
     }
 
+activated:
+    zone->stats.activated_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (ns->params.zns.frld && !timer_pending(ns->zns.timer)) {
+        int64_t next_timer = zone->stats.activated_ns + ns->zns.frld_ns;
+        timer_mod(ns->zns.timer, next_timer);
+    }
+
 out:
     nvme_zs_set(zone, to);
+
+    if (to == NVME_ZS_ZSF && ns->params.zns.rrld) {
+        QTAILQ_INSERT_TAIL(&ns->zns.lru_finished, zone, lru_entry);
+
+        zone->stats.finished_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+        if (!timer_pending(ns->zns.timer)) {
+            int64_t next_timer = zone->stats.finished_ns + ns->zns.rrld_ns;
+            timer_mod(ns->zns.timer, next_timer);
+        }
+    }
+
     return NVME_SUCCESS;
 }
 
@@ -1979,6 +1995,7 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
 
     case NVME_ZS_ZSRO:
         assert(!nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSO, req));
+
         nvme_update_zone_info(ns, req, zone);
         return NVME_NO_COMPLETE;
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 309fb1b94ecb..e51a38546080 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -318,5 +318,12 @@ static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
 }
 
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
+uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                             NvmeZoneState to, NvmeRequest *req);
+void nvme_enqueue_event(NvmeCtrl *n, NvmeNamespace *ns, uint8_t event_type,
+                        uint8_t event_info, uint8_t log_page);
+void nvme_zone_excursion(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                         NvmeRequest *req);
+void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone);
 
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c4c80644f782..249487ae79fc 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -85,7 +85,7 @@ pci_nvme_aer(uint16_t cid) "cid %"PRIu16""
 pci_nvme_aer_aerl_exceeded(void) "aerl exceeded"
 pci_nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
 pci_nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
-pci_nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+pci_nvme_enqueue_event(uint32_t nsid, uint8_t typ, uint8_t info, uint8_t log_page) "nsid 0x%"PRIx32" type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 pci_nvme_enqueue_event_noqueue(int queued) "queued %d"
 pci_nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
 pci_nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
@@ -105,6 +105,7 @@ pci_nvme_zone_zrm_release_active(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsi
 pci_nvme_zone_zrm_excursion_not_allowed(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_zone_changed(uint32_t nsid, uint64_t zslba) "nsid %"PRIu32" zslba 0x%"PRIx64""
 pci_nvme_zone_excursion(uint32_t nsid, uint64_t zslba, const char *zc) "nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_ns_process_timer(uint32_t nsid) "nsid %"PRIu32""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
-- 
2.27.0


