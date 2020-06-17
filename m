Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9639CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA0621548
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QCSjRc0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA0621548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlgDm-0007Fd-GL
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 18:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfiF-0004U9-9L; Wed, 17 Jun 2020 17:35:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfiA-0005JL-Md; Wed, 17 Jun 2020 17:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429710; x=1623965710;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kwrY53sPRnDUcfHWzyMpaug9UTWDAFQUu7bDu1cvpK0=;
 b=QCSjRc0g6HnY3qdspy25AJBI63p59P7vvDjKURuDn13akWlxiR/zC5fW
 mVYO7GWE922nJFJJ8ZE6TSjylBBQwQKC5zUbbmIAAfAAg9aYU6GkQ/No7
 fYZSl5YULWL406r5u+DPPrpKGUNK3m1d541HhaazBDgEQAsl6HuXGOdUt
 yDiRtKGxfChdGjQBA9L84oMt3aRoRf+vW73qb3sNPQLcl+G0/BsyyjJji
 OQfVuPcw51gTDf4lcT2JKOw10UlLXURZMB3lUKBydijmX74MfpYIa2WPp
 qbkOs4HuUEXtKF7RwIi/XYTk3wTi/cu7h70E5unuRMm4FC8+DOj+jcUKb A==;
IronPort-SDR: CIysAxiTHJS3QV6KjevBxXOtozcyAj8qnbPYnJxdGxBGfTg/lWbahQD6bSZNQuTG+P8f0X8GoQ
 9tIJncR6DyZkJXQhATmi7eW+/aMAqhOEO0o5MHBm3c0Y2wzG1UpnpXbMOhli/bWHD4BUEUqTlU
 4RZu+deELLbweaTln/ddo5FRD/2QTmk73E4dB5bqsIv0WmgLqZOxgLiuaJKJJ06E4J6ckzxnDt
 yWiaXhp4odeke9nJK6k83KuIQhIZG1ZQqqi8pUYS0iTy2vcn52pU9sQJPe8Iken39rW+BrFQPu
 nqE=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439825"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:48 +0800
IronPort-SDR: hOQQwUvCp6OpV7dEghQhBy4dbKciFtJ4IVIwRzgiChOIk+exomehjGk0uLKgDzj8mETxPeWND1
 CZuyGowuVxH0ZAraTgXRS1Elobbi8P/dU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:29 -0700
IronPort-SDR: iYeozAJ6zYhFYG2661x5fUAPbBXfUbO/tqFpYjwxiWzMYYbd1SeBDr+FzF0SWS+U8mkXLzKzrM
 1TyXiH021tBA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:46 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 11/18] hw/block/nvme: Introduce max active and open zone
 limits
Date: Thu, 18 Jun 2020 06:34:08 +0900
Message-Id: <20200617213415.22417-12-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added two module properties, "max_active" and "max_open" to control
the maximum number of zones that can be active or open. Once these
variables are set to non-default values, the driver checks these
limits during I/O and returns Too Many Active or Too Many Open
command status if they are exceeded.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h |   4 ++
 2 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2e03b0b6ed..05a7cbcfcc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -120,6 +120,87 @@ static void nvme_remove_zone(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
     zone->prev = zone->next = 0;
 }
 
+/*
+ * Take the first zone out from a list, return NULL if the list is empty.
+ */
+static NvmeZone *nvme_remove_zone_head(NvmeCtrl *n, NvmeNamespace *ns,
+    NvmeZoneList *zl)
+{
+    NvmeZone *zone = nvme_peek_zone_head(ns, zl);
+
+    if (zone) {
+        --zl->size;
+        if (zl->size == 0) {
+            zl->head = NVME_ZONE_LIST_NIL;
+            zl->tail = NVME_ZONE_LIST_NIL;
+        } else {
+            zl->head = zone->next;
+            ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
+        }
+        zone->prev = zone->next = 0;
+    }
+
+    return zone;
+}
+
+/*
+ * Check if we can open a zone without exceeding open/active limits.
+ * AOR stands for "Active and Open Resources" (see TP 4053 section 2.5).
+ */
+static int nvme_aor_check(NvmeCtrl *n, NvmeNamespace *ns,
+     uint32_t act, uint32_t opn)
+{
+    if (n->params.max_active_zones != 0 &&
+        ns->nr_active_zones + act > n->params.max_active_zones) {
+        trace_pci_nvme_err_insuff_active_res(n->params.max_active_zones);
+        return NVME_ZONE_TOO_MANY_ACTIVE | NVME_DNR;
+    }
+    if (n->params.max_open_zones != 0 &&
+        ns->nr_open_zones + opn > n->params.max_open_zones) {
+        trace_pci_nvme_err_insuff_open_res(n->params.max_open_zones);
+        return NVME_ZONE_TOO_MANY_OPEN | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static inline void nvme_aor_inc_open(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    assert(ns->nr_open_zones >= 0);
+    if (n->params.max_open_zones) {
+        ns->nr_open_zones++;
+        assert(ns->nr_open_zones <= n->params.max_open_zones);
+    }
+}
+
+static inline void nvme_aor_dec_open(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    if (n->params.max_open_zones) {
+        assert(ns->nr_open_zones > 0);
+        ns->nr_open_zones--;
+    }
+    assert(ns->nr_open_zones >= 0);
+}
+
+static inline void nvme_aor_inc_active(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    assert(ns->nr_active_zones >= 0);
+    if (n->params.max_active_zones) {
+        ns->nr_active_zones++;
+        assert(ns->nr_active_zones <= n->params.max_active_zones);
+    }
+}
+
+static inline void nvme_aor_dec_active(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    if (n->params.max_active_zones) {
+        assert(ns->nr_active_zones > 0);
+        ns->nr_active_zones--;
+        assert(ns->nr_active_zones >= ns->nr_open_zones);
+    }
+    assert(ns->nr_active_zones >= 0);
+}
+
 static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
     NvmeZone *zone, uint8_t state)
 {
@@ -454,6 +535,24 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
 }
 
+static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
+    bool implicit, bool adding_active)
+{
+    NvmeZone *zone;
+
+    if (implicit && n->params.max_open_zones &&
+        ns->nr_open_zones == n->params.max_open_zones) {
+        zone = nvme_remove_zone_head(n, ns, ns->imp_open_zones);
+        if (zone) {
+            /*
+             * Automatically close this implicitly open zone.
+             */
+            nvme_aor_dec_open(n, ns);
+            nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
+        }
+    }
+}
+
 static uint16_t nvme_check_zone_write(NvmeZone *zone, uint64_t slba,
     uint32_t nlb)
 {
@@ -531,6 +630,23 @@ static uint16_t nvme_check_zone_read(NvmeCtrl *n, NvmeZone *zone, uint64_t slba,
     return status;
 }
 
+static uint16_t nvme_auto_open_zone(NvmeCtrl *n, NvmeNamespace *ns,
+    NvmeZone *zone)
+{
+    uint16_t status = NVME_SUCCESS;
+    uint8_t zs = nvme_get_zone_state(zone);
+
+    if (zs == NVME_ZONE_STATE_EMPTY) {
+        nvme_auto_transition_zone(n, ns, true, true);
+        status = nvme_aor_check(n, ns, 1, 1);
+    } else if (zs == NVME_ZONE_STATE_CLOSED) {
+        nvme_auto_transition_zone(n, ns, true, false);
+        status = nvme_aor_check(n, ns, 0, 1);
+    }
+
+    return status;
+}
+
 static uint64_t nvme_finalize_zone_write(NvmeCtrl *n, NvmeNamespace *ns,
     NvmeZone *zone, uint32_t nlb)
 {
@@ -543,7 +659,11 @@ static uint64_t nvme_finalize_zone_write(NvmeCtrl *n, NvmeNamespace *ns,
         switch (zs) {
         case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_aor_dec_open(n, ns);
+            /* fall through */
         case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_dec_active(n, ns);
+            /* fall through */
         case NVME_ZONE_STATE_EMPTY:
             break;
         default:
@@ -553,7 +673,10 @@ static uint64_t nvme_finalize_zone_write(NvmeCtrl *n, NvmeNamespace *ns,
     } else {
         switch (zs) {
         case NVME_ZONE_STATE_EMPTY:
+            nvme_aor_inc_active(n, ns);
+            /* fall through */
         case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_inc_open(n, ns);
             nvme_assign_zone_state(n, ns, zone,
                                    NVME_ZONE_STATE_IMPLICITLY_OPEN);
         }
@@ -636,6 +759,11 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
                                                zone->d.wp);
             return NVME_ZONE_INVALID_WRITE | NVME_DNR;
         }
+
+        status = nvme_auto_open_zone(n, ns, zone);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
     }
 
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
@@ -709,6 +837,11 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
                                                    zone->d.wp);
                 return NVME_ZONE_INVALID_WRITE | NVME_DNR;
             }
+
+            status = nvme_auto_open_zone(n, ns, zone);
+            if (status != NVME_SUCCESS) {
+                return status;
+            }
         } else {
             status = nvme_check_zone_read(n, zone, slba, nlb,
                                           n->params.cross_zone_read);
@@ -804,9 +937,27 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeCtrl *n, NvmeNamespace *ns,
 static uint16_t nvme_open_zone(NvmeCtrl *n, NvmeNamespace *ns,
     NvmeZone *zone, uint8_t state)
 {
+    uint16_t status;
+
     switch (state) {
     case NVME_ZONE_STATE_EMPTY:
+        nvme_auto_transition_zone(n, ns, false, true);
+        status = nvme_aor_check(n, ns, 1, 0);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+        nvme_aor_inc_active(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        status = nvme_aor_check(n, ns, 0, 1);
+        if (status != NVME_SUCCESS) {
+            if (state == NVME_ZONE_STATE_EMPTY) {
+                nvme_aor_dec_active(n, ns);
+            }
+            return status;
+        }
+        nvme_aor_inc_open(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
         /* fall through */
@@ -828,6 +979,7 @@ static uint16_t nvme_close_zone(NvmeCtrl *n,  NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(n, ns);
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
         /* fall through */
     case NVME_ZONE_STATE_CLOSED:
@@ -849,7 +1001,11 @@ static uint16_t nvme_finish_zone(NvmeCtrl *n, NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        nvme_aor_dec_active(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_EMPTY:
         zone->d.wp = nvme_zone_wr_boundary(zone);
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
@@ -874,7 +1030,11 @@ static uint16_t nvme_reset_zone(NvmeCtrl *n, NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        nvme_aor_dec_active(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_FULL:
         zone->d.wp = zone->d.zslba;
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EMPTY);
@@ -2412,6 +2572,15 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
     uint64_t zone_size = 0, capacity;
     uint32_t nz;
 
+    if (n->params.max_open_zones < 0) {
+        error_setg(errp, "invalid max_open_zones value");
+        return;
+    }
+    if (n->params.max_active_zones < 0) {
+        error_setg(errp, "invalid max_active_zones value");
+        return;
+    }
+
     if (n->params.zone_size) {
         zone_size = n->params.zone_size;
     } else {
@@ -2435,6 +2604,14 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
     n->num_zones = nz;
     n->zone_array_size = sizeof(NvmeZone) * nz;
 
+    /* Make sure that the values of all Zoned Command Set properties are sane */
+    if (n->params.max_open_zones > nz) {
+        n->params.max_open_zones = nz;
+    }
+    if (n->params.max_active_zones > nz) {
+        n->params.max_active_zones = nz;
+    }
+
     return;
 }
 
@@ -2452,8 +2629,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     ns->id_ns_zoned = g_malloc0(sizeof(*ns->id_ns_zoned));
 
     /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
-    ns->id_ns_zoned->mar = 0xffffffff;
-    ns->id_ns_zoned->mor = 0xffffffff;
+    ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
+    ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
     ns->id_ns_zoned->zoc = 0;
     ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
 
@@ -2813,6 +2990,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT64("zone_size", NvmeCtrl, params.zone_size, 512),
     DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity, 512),
     DEFINE_PROP_UINT32("zone_append_max_size", NvmeCtrl, params.zamds_bs, 0),
+    DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
+    DEFINE_PROP_INT32("max_open", NvmeCtrl, params.max_open_zones, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
     DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 2c932b5e29..f5a4679702 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -19,6 +19,8 @@ typedef struct NvmeParams {
     uint32_t    zamds_bs;
     uint64_t    zone_size;
     uint64_t    zone_capacity;
+    int32_t     max_active_zones;
+    int32_t     max_open_zones;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -103,6 +105,8 @@ typedef struct NvmeNamespace {
     NvmeZoneList    *imp_open_zones;
     NvmeZoneList    *closed_zones;
     NvmeZoneList    *full_zones;
+    int32_t         nr_open_zones;
+    int32_t         nr_active_zones;
 } NvmeNamespace;
 
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
-- 
2.21.0


