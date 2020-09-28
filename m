Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FFDC4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB1122262
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IONB8yJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB1122262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj6x-0004WL-0v
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1H-000734-Vr; Sun, 27 Sep 2020 22:36:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1E-0003Me-9M; Sun, 27 Sep 2020 22:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260560; x=1632796560;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RRUH3XJ5WtNv6SkJC3qV061JD5ws6PVCqRhg5m53NkA=;
 b=IONB8yJhR4vswXSbvajfX4bY5pZUmicX8g3iFLKPWbeZezr2JWXIfmwg
 quOkF7AMR9cjbxeUfJHUhrZbS1U/O8u0OCDy/xIkue3GzMU4SfNJt0Sp3
 RdSOEUszUdcER+CYQuX03D4YyXaIRLv/yXjlrsJrQ3u/gJbcpsZBSAueb
 Nv8eKpJ45XbJgpC/G5OuLNz/zH8cmMO+FpbgpJTsJ9WF5paVK8I1drM/i
 w0TVNsvsCk2qkQMAAH2FUPIS0dQKX7UbsIK7C6GbCAwT0xBUcm2KhNEzG
 HHkVM9Fy+VjP6yrdSMT5oZJKv/hbMUaBjGlF2Qy4rfk1PFf0w6sw5UL1G g==;
IronPort-SDR: 5FNnv0wW2WoafNMQhI9G/v9LcEgZrGit7kWzZu729ZyFY7f2ZVaj7+97LM6TfXkuUGAwFc1he2
 AVNgNJqCHjjIKgrRRFS4lLizgXgZSp7VqHWcXtlup7klmUHwnjgC/deCRet5bvXfu08wiUX91M
 gCwJCBJL0iXISdddYki0ieHVPcKfEc/At9OaG2rOx/Q/d1b/LbR1z0zTfQ1qCEj7GpDkiYx6QU
 0aGjCqmOQ6Qh+wRAiS7N5B4ZHDAzLeZGTFn7Nb7Ayvck/tnycT7gTT+vUw1y5B0L+txZtH05qD
 s3I=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125250"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:58 +0800
IronPort-SDR: dTDOdPVP7WssZHoqj6WpuoAfQdoxpc/FonsJMbh2HXJO/rZpG0/vDrbzLq61r4moF6w8z5WL21
 wBRtXtPAklpA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:54 -0700
IronPort-SDR: xoT52ZGRlhqaC9MjMehB37rXtMJo2u1t5i+76EWpFB1pmMU08hxFEbsA0FaSI2Ev6opohFvmZa
 rOkaMnD18lUg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:57 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 11/14] hw/block/nvme: Support Zone Descriptor Extensions
Date: Mon, 28 Sep 2020 11:35:25 +0900
Message-Id: <20200928023528.15260-12-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zone Descriptor Extension is a label that can be assigned to a zone.
It can be set to an Empty zone and it stays assigned until the zone
is reset.

This commit adds a new optional module property, "zone_descr_ext_size".
Its value must be a multiple of 64 bytes. If this value is non-zero,
it becomes possible to assign extensions of that size to any Empty
zones. The default value for this property is 0, therefore setting
extensions is disabled by default.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c | 10 ++++++++-
 hw/block/nvme-ns.h |  8 ++++++++
 hw/block/nvme.c    | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 63a2e3f47d..60156dfeaf 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -207,6 +207,10 @@ static void nvme_init_zone_meta(NvmeNamespace *ns)
     ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
     ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
     ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
+    if (ns->params.zd_extension_size) {
+        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
+                                      ns->num_zones);
+    }
 
     nvme_init_zone_list(ns->exp_open_zones);
     nvme_init_zone_list(ns->imp_open_zones);
@@ -257,7 +261,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
 
     id_ns_z->lbafe[lba_index].zsze = cpu_to_le64(ns->zone_size);
-    id_ns_z->lbafe[lba_index].zdes = 0; /* FIXME make helper */
+    id_ns_z->lbafe[lba_index].zdes =
+        ns->params.zd_extension_size >> 6; /* Units of 64B */
 
     ns->csi = NVME_CSI_ZONED;
     ns->id_ns.ncap = cpu_to_le64(ns->zone_capacity * ns->num_zones);
@@ -321,6 +326,7 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
     g_free(ns->imp_open_zones);
     g_free(ns->closed_zones);
     g_free(ns->full_zones);
+    g_free(ns->zd_extensions);
 }
 
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
@@ -350,6 +356,8 @@ static Property nvme_ns_props[] = {
                       params.cross_zone_read, false),
     DEFINE_PROP_UINT32("max_active", NvmeNamespace, params.max_active_zones, 0),
     DEFINE_PROP_UINT32("max_open", NvmeNamespace, params.max_open_zones, 0),
+    DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeNamespace,
+                       params.zd_extension_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 0664fe0892..ed14644e09 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -47,6 +47,7 @@ typedef struct NvmeNamespaceParams {
     uint64_t zone_capacity_mb;
     uint32_t max_active_zones;
     uint32_t max_open_zones;
+    uint32_t zd_extension_size;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -68,6 +69,7 @@ typedef struct NvmeNamespace {
     uint64_t        zone_capacity;
     uint64_t        zone_array_size;
     uint32_t        zone_size_log2;
+    uint8_t         *zd_extensions;
     int32_t         nr_open_zones;
     int32_t         nr_active_zones;
 
@@ -142,6 +144,12 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
            st != NVME_ZONE_STATE_OFFLINE;
 }
 
+static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
+                                             uint32_t zone_idx)
+{
+    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
+}
+
 /*
  * Initialize a zone list head.
  */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 40947aa659..27d191c659 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1644,6 +1644,26 @@ static bool nvme_cond_offline_all(uint8_t state)
     return state == NVME_ZONE_STATE_READ_ONLY;
 }
 
+static uint16_t nvme_set_zd_ext(NvmeNamespace *ns, NvmeZone *zone,
+                                uint8_t state)
+{
+    uint16_t status;
+
+    if (state == NVME_ZONE_STATE_EMPTY) {
+        nvme_auto_transition_zone(ns, false, true);
+        status = nvme_aor_check(ns, 1, 0);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+        nvme_aor_inc_active(ns);
+        zone->d.za |= NVME_ZA_ZD_EXT_VALID;
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
 typedef uint16_t (*op_handler_t)(NvmeNamespace *, NvmeZone *,
                                  uint8_t);
 typedef bool (*need_to_proc_zone_t)(uint8_t);
@@ -1684,6 +1704,7 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     uint8_t action, state;
     bool all;
     NvmeZone *zone;
+    uint8_t *zd_ext;
 
     action = dw13 & 0xff;
     all = dw13 & 0x100;
@@ -1738,7 +1759,22 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        if (all || !ns->params.zd_extension_size) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        zd_ext = nvme_get_zd_extension(ns, zone_idx);
+        status = nvme_dma(n, zd_ext, ns->params.zd_extension_size,
+                          DMA_DIRECTION_TO_DEVICE, req);
+        if (status) {
+            trace_pci_nvme_err_zd_extension_map_error(zone_idx);
+            return status;
+        }
+
+        status = nvme_set_zd_ext(ns, zone, state);
+        if (status == NVME_SUCCESS) {
+            trace_pci_nvme_zd_extension_set(zone_idx);
+            return status;
+        }
         break;
 
     default:
@@ -1816,7 +1852,7 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+    if (zra == NVME_ZONE_REPORT_EXTENDED && !ns->params.zd_extension_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1828,6 +1864,9 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     partial = (dw13 >> 16) & 0x01;
 
     zone_entry_sz = sizeof(NvmeZoneDescr);
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        zone_entry_sz += ns->params.zd_extension_size;
+    }
 
     max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
     buf = g_malloc0(len);
@@ -1859,6 +1898,14 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
             z->wp = cpu_to_le64(~0ULL);
         }
 
+        if (zra == NVME_ZONE_REPORT_EXTENDED) {
+            if (zs->d.za & NVME_ZA_ZD_EXT_VALID) {
+                memcpy(buf_p, nvme_get_zd_extension(ns, zone_idx),
+                       ns->params.zd_extension_size);
+            }
+            buf_p += ns->params.zd_extension_size;
+        }
+
         zone_idx++;
     }
 
-- 
2.21.0


