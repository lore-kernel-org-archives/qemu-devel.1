Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A8BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7155220872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l0x7DldM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7155220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSSAY-0004io-Gn
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS46-0005jh-AZ; Tue, 13 Oct 2020 17:42:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS43-0001lt-K6; Tue, 13 Oct 2020 17:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602625356; x=1634161356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qC0MGM8sAyPys4yE4bYRH9iCuqrzdx7FRQ1XqgRn37k=;
 b=l0x7DldMXC8dqe2QACzmYIqVpwE0SDnrlDHYy+RUQugOK9fK9saEmBWw
 aE/YTrMjVI/KMrOuv7LCTD/RpLPLk5pd6rvx0cHxNQvsifpC0UZfGktEt
 re/MQaRGDalH4aW4WLwFjWYpYuweGi+0Ph/5LwgXXABroGp70zbhKoti1
 gcPMTf9SilXF9EYtW7SSUSg4u4c8ttEfgRuL753W6UBzMeUC1Xu13tCqG
 mpWdjGlteI74GNQE2mce3+JxLCa+g7hy/60Y4V4AN4GJwNfguOGlnmMSf
 DyZurWDxYTIwCxoQHzgJdRLBQAlwhtPWQhTnZQPRlTFULkmeTjVKk9vs1 w==;
IronPort-SDR: xzOBvQjSRKkO0V1T/Mwz6/F0RmNV8b+60YIi/23MxitbOIclrK/YrY6619IFBQ6cOL5WDne4Ah
 MbP03AYJoEwVkbXAsRtLzWpUnd596YOsVYu0GDa37wEsBKfSOJaBljW6acvdo8W4jxmm+SEFgF
 eN3fwSBAZPMFFzb7A2GfF26fWOSUcjyjgPuTBF5w8lHKkZltvAX0yjhJDzdXK/QIvVZ7V8NR6m
 nGIJZ9nWWSke0uSCGgI+QeG1jzwAIZyPWda02KCxf8MiDjiirYlWdcyFEFsuNvvpBPGSrQZjc2
 Elw=
X-IronPort-AV: E=Sophos;i="5.77,371,1596470400"; d="scan'208";a="154185935"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 05:42:34 +0800
IronPort-SDR: 1/QFurA8Tx4E1O8OJ9L4Hgoo+v8fLQXM+8iWBkzU08C5SmYrcW7NIHsVrUlXiv5TpMtHMVqLs6
 O5BTR1xugwyxflSCmyzV8ORm6XhwqGtKcbr798sniS5MWQJrb/tBwvmgOxJpBNMFlljpB73Rdp
 0i2CdtD489r7OesDSGzT1j6BDxK16PiituCQbnJWUebOvDDmgbHz7DwUsxfcoYBQghguyc/P68
 TDqQSzmPbpSlpbGwNNolWHR7QMoGZnmJzMV8/e54ujKPGNPtHzpqeq1q4VoiFvu9x0d7NCdl1f
 BBiixmBzsUm+PG26T29ZOwVV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 14:29:08 -0700
IronPort-SDR: mJXIoF6Zz21D2X/MMq9NBVHRaPpOta6nWbejYn7lSL8zF0K5TKGlTlsWj7TClITayWlCOwh9LU
 qE14SoZnHygdjrjGFleJKF3jW6TMOibv+uFdL3kr/UmVLKcgQuOX2t5Hw+v4DNW1YILq/iFHg0
 S0h3I+vgpNSYna/M1PKzBRb36GZxHQ4zbPPks6VnCW0nqn6zL5rpVf5iYQnSHmWGSn6vB5fU0s
 wlRPMU3dJajVpgORPJv3NeA2Lm64Y3CzmN8GHW/bFkf2wSObYJ0WOM1bDHWKh6PQXRLVky2oN7
 UVg=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 14:42:32 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v6 07/11] hw/block/nvme: Support Zone Descriptor Extensions
Date: Wed, 14 Oct 2020 06:42:08 +0900
Message-Id: <20201013214212.2152-8-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5487bf209=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:42:19
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
 hw/block/nvme-ns.c    | 14 ++++++++++--
 hw/block/nvme-ns.h    |  8 +++++++
 hw/block/nvme.c       | 51 +++++++++++++++++++++++++++++++++++++++++--
 hw/block/trace-events |  2 ++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 8d9e11eef2..255ded2b43 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -143,6 +143,10 @@ static void nvme_init_zone_state(NvmeNamespace *ns)
     int i;
 
     ns->zone_array = g_malloc0(ns->zone_array_size);
+    if (ns->params.zd_extension_size) {
+        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
+                                      ns->num_zones);
+    }
 
     QTAILQ_INIT(&ns->exp_open_zones);
     QTAILQ_INIT(&ns->imp_open_zones);
@@ -192,7 +196,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
 
     id_ns_z->lbafe[lba_index].zsze = cpu_to_le64(ns->zone_size);
-    id_ns_z->lbafe[lba_index].zdes = 0;
+    id_ns_z->lbafe[lba_index].zdes =
+        ns->params.zd_extension_size >> 6; /* Units of 64B */
 
     ns->csi = NVME_CSI_ZONED;
     ns->id_ns.nsze = cpu_to_le64(ns->zone_size * ns->num_zones);
@@ -232,7 +237,9 @@ static void nvme_zoned_clear_ns(NvmeNamespace *ns)
             continue;
         }
 
-        if (zone->d.wp == zone->d.zslba) {
+        if (zone->d.za & NVME_ZA_ZD_EXT_VALID) {
+            set_state = NVME_ZONE_STATE_CLOSED;
+        } else if (zone->d.wp == zone->d.zslba) {
             set_state = NVME_ZONE_STATE_EMPTY;
         } else if (ns->params.max_active_zones == 0 ||
                    ns->nr_active_zones < ns->params.max_active_zones) {
@@ -320,6 +327,7 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
     if (ns->params.zoned) {
         g_free(ns->id_ns_zoned);
         g_free(ns->zone_array);
+        g_free(ns->zd_extensions);
     }
 }
 
@@ -350,6 +358,8 @@ static Property nvme_ns_props[] = {
                      params.cross_zone_read, false),
     DEFINE_PROP_UINT32("max_active", NvmeNamespace, params.max_active_zones, 0),
     DEFINE_PROP_UINT32("max_open", NvmeNamespace, params.max_open_zones, 0),
+    DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeNamespace,
+                       params.zd_extension_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index b0633d0def..2d70a13701 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -36,6 +36,7 @@ typedef struct NvmeNamespaceParams {
     uint64_t zone_cap_bs;
     uint32_t max_active_zones;
     uint32_t max_open_zones;
+    uint32_t zd_extension_size;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -58,6 +59,7 @@ typedef struct NvmeNamespace {
     uint64_t        zone_capacity;
     uint64_t        zone_array_size;
     uint32_t        zone_size_log2;
+    uint8_t         *zd_extensions;
     int32_t         nr_open_zones;
     int32_t         nr_active_zones;
 
@@ -127,6 +129,12 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
            st != NVME_ZONE_STATE_OFFLINE;
 }
 
+static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
+                                             uint32_t zone_idx)
+{
+    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
+}
+
 static inline void nvme_aor_inc_open(NvmeNamespace *ns)
 {
     assert(ns->nr_open_zones >= 0);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 088df2e813..18547722af 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1747,6 +1747,26 @@ static bool nvme_cond_offline_all(uint8_t state)
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
@@ -1787,6 +1807,7 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     uint8_t action, state;
     bool all;
     NvmeZone *zone;
+    uint8_t *zd_ext;
 
     action = dw13 & 0xff;
     all = dw13 & 0x100;
@@ -1841,7 +1862,22 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 
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
@@ -1919,7 +1955,7 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+    if (zra == NVME_ZONE_REPORT_EXTENDED && !ns->params.zd_extension_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1931,6 +1967,9 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     partial = (dw13 >> 16) & 0x01;
 
     zone_entry_sz = sizeof(NvmeZoneDescr);
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        zone_entry_sz += ns->params.zd_extension_size;
+    }
 
     max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
     buf = g_malloc0(len);
@@ -1962,6 +2001,14 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
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
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index af53e31fcb..962084e40c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -96,6 +96,7 @@ pci_nvme_finish_zone(uint64_t slba, uint32_t zone_idx, int all) "finish zone, sl
 pci_nvme_reset_zone(uint64_t slba, uint32_t zone_idx, int all) "reset zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
 pci_nvme_offline_zone(uint64_t slba, uint32_t zone_idx, int all) "offline zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
 pci_nvme_set_descriptor_extension(uint64_t slba, uint32_t zone_idx) "set zone descriptor extension, slba=%"PRIu64", idx=%"PRIu32""
+pci_nvme_zd_extension_set(uint32_t zone_idx) "set descriptor extension for zone_idx=%"PRIu32""
 pci_nvme_clear_ns_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
 pci_nvme_clear_ns_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
 pci_nvme_clear_ns_full(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Full state"
@@ -127,6 +128,7 @@ pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slb
 pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zasl) "slba=%"PRIu64", nlb=%"PRIu32", zasl=%"PRIu8""
 pci_nvme_err_insuff_active_res(uint32_t max_active) "max_active=%"PRIu32" zone limit exceeded"
 pci_nvme_err_insuff_open_res(uint32_t max_open) "max_open=%"PRIu32" zone limit exceeded"
+pci_nvme_err_zd_extension_map_error(uint32_t zone_idx) "can't map descriptor extension for zone_idx=%"PRIu32""
 pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
 pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
 pci_nvme_err_only_zoned_cmd_set_avail(void) "setting 001b CC.CSS, but only ZONED+NVM command set is enabled"
-- 
2.21.0


