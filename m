Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31F0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD382206CB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD382206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD91-0004qj-O5
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5a-0007lN-6C; Tue, 30 Jun 2020 06:02:07 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5P-0004JS-T2; Tue, 30 Jun 2020 06:02:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id EC92BBF758;
 Tue, 30 Jun 2020 10:01:53 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 03/10] hw/block/nvme: add basic read/write for zoned namespaces
Date: Tue, 30 Jun 2020 12:01:32 +0200
Message-Id: <20200630100139.1483002-4-its@irrelevant.dk>
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

This adds basic read and write for zoned namespaces.

A zoned namespace is created by setting the iocs parameter to 0x2 and
supplying a zero-sized blockdev for zone info persistent state
(zns.zoneinfo parameter) and the zns.zcap parameter to specify the
individual zone capacities. The namespace device will compute the
resulting zone size to be the next power of two and fit in as many zones
as possible on the underlying namespace blockdev.

If the zone info blockdev pointed to by zns.zoneinfo is non-zero in size
it will be assumed to contain existing zone state.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c    | 227 +++++++++++++++++++++++++-
 hw/block/nvme-ns.h    | 103 ++++++++++++
 hw/block/nvme.c       | 361 +++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h       |   1 +
 hw/block/trace-events |  10 ++
 5 files changed, 677 insertions(+), 25 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index ae051784caaf..9a08b2ba0fb2 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -28,6 +28,26 @@
 #include "nvme.h"
 #include "nvme-ns.h"
 
+const char *nvme_zs_str(NvmeZone *zone)
+{
+    return nvme_zs_to_str(nvme_zs(zone));
+}
+
+const char *nvme_zs_to_str(NvmeZoneState zs)
+{
+    switch (zs) {
+    case NVME_ZS_ZSE:  return "ZSE";
+    case NVME_ZS_ZSIO: return "ZSIO";
+    case NVME_ZS_ZSEO: return "ZSEO";
+    case NVME_ZS_ZSC:  return "ZSC";
+    case NVME_ZS_ZSRO: return "ZSRO";
+    case NVME_ZS_ZSF:  return "ZSF";
+    case NVME_ZS_ZSO:  return "ZSO";
+    }
+
+    return NULL;
+}
+
 static int nvme_ns_blk_resize(BlockBackend *blk, size_t len, Error **errp)
 {
 	Error *local_err = NULL;
@@ -57,6 +77,171 @@ static int nvme_ns_blk_resize(BlockBackend *blk, size_t len, Error **errp)
 	return 0;
 }
 
+static int nvme_ns_init_blk_zoneinfo(NvmeNamespace *ns, size_t len,
+                                     Error **errp)
+{
+    NvmeZone *zone;
+    NvmeZoneDescriptor *zd;
+    uint64_t zslba;
+    int ret;
+
+    BlockBackend *blk = ns->zns.info.blk;
+
+    Error *local_err = NULL;
+
+    for (int i = 0; i < ns->zns.info.num_zones; i++) {
+        zslba = i * nvme_ns_zsze(ns);
+        zone = nvme_ns_get_zone(ns, zslba);
+        zd = &zone->zd;
+
+        zd->zt = NVME_ZT_SEQ;
+        nvme_zs_set(zone, NVME_ZS_ZSE);
+        zd->zcap = ns->params.zns.zcap;
+        zone->wp_staging = zslba;
+        zd->wp = zd->zslba = cpu_to_le64(zslba);
+    }
+
+    ret = nvme_ns_blk_resize(blk, len, &local_err);
+    if (ret) {
+        error_propagate_prepend(errp, local_err,
+                                "could not resize zoneinfo blockdev: ");
+        return ret;
+    }
+
+    for (int i = 0; i < ns->zns.info.num_zones; i++) {
+        zd = &ns->zns.info.zones[i].zd;
+
+        ret = blk_pwrite(blk, i * sizeof(NvmeZoneDescriptor), zd,
+                         sizeof(NvmeZoneDescriptor), 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "blk_pwrite: ");
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static int nvme_ns_setup_blk_zoneinfo(NvmeNamespace *ns, Error **errp)
+{
+    NvmeZone *zone;
+    NvmeZoneDescriptor *zd;
+    BlockBackend *blk = ns->zns.info.blk;
+    uint64_t perm, shared_perm;
+    int64_t len, zoneinfo_len;
+
+    Error *local_err = NULL;
+    int ret;
+
+    perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    shared_perm = BLK_PERM_ALL;
+
+    ret = blk_set_perm(blk, perm, shared_perm, &local_err);
+    if (ret) {
+        error_propagate_prepend(errp, local_err, "blk_set_perm: ");
+        return ret;
+    }
+
+    zoneinfo_len = ROUND_UP(ns->zns.info.num_zones *
+                            sizeof(NvmeZoneDescriptor), BDRV_SECTOR_SIZE);
+
+    len = blk_getlength(blk);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "blk_getlength: ");
+        return len;
+    }
+
+    if (len) {
+        if (len != zoneinfo_len) {
+            error_setg(errp, "zoneinfo size mismatch "
+                       "(expected %"PRIu64" bytes; was %"PRIu64" bytes)",
+                       zoneinfo_len, len);
+            error_append_hint(errp, "Did you change the zone size or "
+                              "zone descriptor size?\n");
+            return -1;
+        }
+
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zone = &ns->zns.info.zones[i];
+            zd = &zone->zd;
+
+            ret = blk_pread(blk, i * sizeof(NvmeZoneDescriptor), zd,
+                            sizeof(NvmeZoneDescriptor));
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "blk_pread: ");
+                return ret;
+            } else if (ret != sizeof(NvmeZoneDescriptor)) {
+                error_setg(errp, "blk_pread: short read");
+                return -1;
+            }
+
+            zone->wp_staging = nvme_wp(zone);
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSE:
+            case NVME_ZS_ZSF:
+            case NVME_ZS_ZSRO:
+            case NVME_ZS_ZSO:
+                continue;
+
+            case NVME_ZS_ZSC:
+                if (nvme_wp(zone) == nvme_zslba(zone)) {
+                    nvme_zs_set(zone, NVME_ZS_ZSE);
+                    continue;
+                }
+
+                /* fallthrough */
+
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+                nvme_zs_set(zone, NVME_ZS_ZSF);
+                NVME_ZA_SET_ZFC(zd->za, 0x1);
+            }
+        }
+
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            zd = &ns->zns.info.zones[i].zd;
+
+            ret = blk_pwrite(blk, i * sizeof(NvmeZoneDescriptor), zd,
+                             sizeof(NvmeZoneDescriptor), 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "blk_pwrite: ");
+                return ret;
+            }
+        }
+
+        return 0;
+    }
+
+    if (nvme_ns_init_blk_zoneinfo(ns, zoneinfo_len, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+                                "could not initialize zoneinfo blockdev: ");
+    }
+
+    return 0;
+}
+
+static void nvme_ns_init_zoned(NvmeNamespace *ns)
+{
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+    NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
+
+    id_ns_zns->zoc = cpu_to_le16(ns->params.zns.zoc);
+    id_ns_zns->ozcs = cpu_to_le16(ns->params.zns.ozcs);
+
+    for (int i = 0; i <= id_ns->nlbaf; i++) {
+        id_ns_zns->lbafe[i].zsze = cpu_to_le64(pow2ceil(ns->params.zns.zcap));
+    }
+
+    ns->zns.info.num_zones = nvme_ns_nlbas(ns) / nvme_ns_zsze(ns);
+    ns->zns.info.zones = g_malloc0_n(ns->zns.info.num_zones, sizeof(NvmeZone));
+
+    id_ns->ncap = ns->zns.info.num_zones * ns->params.zns.zcap;
+
+    id_ns_zns->mar = 0xffffffff;
+    id_ns_zns->mor = 0xffffffff;
+}
+
 static void nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNsNvm *id_ns;
@@ -69,12 +254,20 @@ static void nvme_ns_init(NvmeNamespace *ns)
     ns->iocs = ns->params.iocs;
 
     id_ns->dlfeat = unmap ? 0x9 : 0x0;
+    if (!nvme_ns_zoned(ns)) {
+        id_ns->dlfeat = unmap ? 0x9 : 0x0;
+    }
     id_ns->lbaf[0].ds = ns->params.lbads;
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
+    id_ns->ncap = id_ns->nsze;
+
+    if (ns->iocs == NVME_IOCS_ZONED) {
+        ns->id_ns[NVME_IOCS_ZONED] = g_new0(NvmeIdNsZns, 1);
+        nvme_ns_init_zoned(ns);
+    }
 
     /* no thin provisioning */
-    id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
 }
 
@@ -194,6 +387,28 @@ static int nvme_ns_check_constraints(NvmeCtrl *n, NvmeNamespace *ns, Error
         return -1;
     }
 
+    switch (ns->params.iocs) {
+    case NVME_IOCS_NVM:
+        break;
+
+    case NVME_IOCS_ZONED:
+        if (!ns->zns.info.blk) {
+            error_setg(errp, "zone info block backend not configured");
+            return -1;
+        }
+
+        if (!ns->params.zns.zcap) {
+            error_setg(errp, "zero zone capacity");
+            return -1;
+        }
+
+        break;
+
+    default:
+        error_setg(errp, "unsupported I/O command set");
+        return -1;
+    }
+
     return 0;
 }
 
@@ -222,6 +437,12 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         id_ns->nsfeat |= 0x4;
     }
 
+    if (nvme_ns_zoned(ns)) {
+        if (nvme_ns_setup_blk_zoneinfo(ns, errp)) {
+            return -1;
+        }
+    }
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
@@ -249,6 +470,10 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
     DEFINE_PROP_DRIVE("state", NvmeNamespace, blk_state),
     DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, 0x0),
+    DEFINE_PROP_DRIVE("zns.zoneinfo", NvmeNamespace, zns.info.blk),
+    DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
+    DEFINE_PROP_UINT16("zns.zoc", NvmeNamespace, params.zns.zoc, 0),
+    DEFINE_PROP_UINT16("zns.ozcs", NvmeNamespace, params.zns.ozcs, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 4124f20f1cef..7dcf0f02a07f 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -23,8 +23,20 @@ typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     uint8_t  iocs;
     uint8_t  lbads;
+
+    struct {
+        uint64_t zcap;
+        uint16_t zoc;
+        uint16_t ozcs;
+    } zns;
 } NvmeNamespaceParams;
 
+typedef struct NvmeZone {
+    NvmeZoneDescriptor zd;
+
+    uint64_t wp_staging;
+} NvmeZone;
+
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockBackend *blk;
@@ -41,8 +53,22 @@ typedef struct NvmeNamespace {
     struct {
         uint32_t err_rec;
     } features;
+
+    struct {
+        struct {
+            BlockBackend *blk;
+
+            uint64_t  num_zones;
+            NvmeZone *zones;
+        } info;
+    } zns;
 } NvmeNamespace;
 
+static inline bool nvme_ns_zoned(NvmeNamespace *ns)
+{
+    return ns->iocs == NVME_IOCS_ZONED;
+}
+
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
 {
     if (ns) {
@@ -57,17 +83,39 @@ static inline NvmeIdNsNvm *nvme_ns_id_nvm(NvmeNamespace *ns)
     return ns->id_ns[NVME_IOCS_NVM];
 }
 
+static inline NvmeIdNsZns *nvme_ns_id_zoned(NvmeNamespace *ns)
+{
+    return ns->id_ns[NVME_IOCS_ZONED];
+}
+
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
 {
     NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
     return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
 }
 
+static inline NvmeLBAFE *nvme_ns_lbafe(NvmeNamespace *ns)
+{
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+    NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
+    return &id_ns_zns->lbafe[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
 static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 {
     return nvme_ns_lbaf(ns)->ds;
 }
 
+static inline uint64_t nvme_ns_zsze(NvmeNamespace *ns)
+{
+    return nvme_ns_lbafe(ns)->zsze;
+}
+
+static inline uint64_t nvme_ns_zsze_bytes(NvmeNamespace *ns)
+{
+    return nvme_ns_zsze(ns) << nvme_ns_lbads(ns);
+}
+
 /* calculate the number of LBAs that the namespace can accomodate */
 static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
 {
@@ -79,8 +127,63 @@ static inline size_t nvme_ns_blk_state_len(NvmeNamespace *ns)
     return ROUND_UP(DIV_ROUND_UP(nvme_ns_nlbas(ns), 8), BDRV_SECTOR_SIZE);
 }
 
+static inline uint64_t nvme_ns_zone_idx(NvmeNamespace *ns, uint64_t lba)
+{
+    return lba / nvme_ns_zsze(ns);
+}
+
+static inline NvmeZone *nvme_ns_get_zone(NvmeNamespace *ns, uint64_t lba)
+{
+    uint64_t idx = nvme_ns_zone_idx(ns, lba);
+    if (unlikely(idx >= ns->zns.info.num_zones)) {
+        return NULL;
+    }
+
+    return &ns->zns.info.zones[idx];
+}
+
+static inline NvmeZoneState nvme_zs(NvmeZone *zone)
+{
+    return (zone->zd.zs >> 4) & 0xf;
+}
+
+static inline void nvme_zs_set(NvmeZone *zone, NvmeZoneState zs)
+{
+    zone->zd.zs = zs << 4;
+}
+
+static inline bool nvme_ns_zone_wp_valid(NvmeZone *zone)
+{
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSF:
+    case NVME_ZS_ZSRO:
+    case NVME_ZS_ZSO:
+        return false;
+    default:
+        return false;
+    }
+}
+
+static inline uint64_t nvme_zslba(NvmeZone *zone)
+{
+    return le64_to_cpu(zone->zd.zslba);
+}
+
+static inline uint64_t nvme_zcap(NvmeZone *zone)
+{
+    return le64_to_cpu(zone->zd.zcap);
+}
+
+static inline uint64_t nvme_wp(NvmeZone *zone)
+{
+    return le64_to_cpu(zone->zd.wp);
+}
+
 typedef struct NvmeCtrl NvmeCtrl;
 
+const char *nvme_zs_str(NvmeZone *zone);
+const char *nvme_zs_to_str(NvmeZoneState zs);
+
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1662c11a4cf3..4ec3b3029388 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -902,6 +902,115 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
     }
 }
 
+static uint16_t nvme_check_zone_readable(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeZoneState zs = nvme_zs(zone);
+    uint64_t zslba = nvme_zslba(zone);
+
+    if (zs == NVME_ZS_ZSO) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), zslba,
+                                                  NVME_ZS_ZSO);
+        return NVME_ZONE_IS_OFFLINE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_check_zone_read(NvmeCtrl *n, uint64_t slba, uint32_t nlb,
+    NvmeRequest *req, NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t zsze = nvme_ns_zsze(ns);
+    uint16_t status;
+
+    status = nvme_check_zone_readable(n, req, zone);
+    if (status) {
+        return status;
+    }
+
+    if ((slba + nlb) > (zslba + zsze)) {
+        if (!(id_ns_zns->ozcs & NVME_ID_NS_ZNS_OZCS_RAZB)) {
+            trace_pci_nvme_err_zone_boundary(nvme_cid(req), slba, nlb, zsze);
+            return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
+        }
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_check_zone_writeable(NvmeCtrl *n, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    NvmeZoneState zs = nvme_zs(zone);
+    uint64_t zslba = nvme_zslba(zone);
+
+    if (zs == NVME_ZS_ZSO) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), zslba,
+                                                  NVME_ZS_ZSO);
+        return NVME_ZONE_IS_OFFLINE | NVME_DNR;
+    }
+
+    switch (zs) {
+    case NVME_ZS_ZSE:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+        return NVME_SUCCESS;
+    case NVME_ZS_ZSF:
+        trace_pci_nvme_err_zone_is_full(nvme_cid(req), req->slba);
+        return NVME_ZONE_IS_FULL | NVME_DNR;
+    case NVME_ZS_ZSRO:
+        trace_pci_nvme_err_zone_is_read_only(nvme_cid(req), req->slba);
+        return NVME_ZONE_IS_READ_ONLY | NVME_DNR;
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), zslba, zs);
+    return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+}
+
+static uint16_t nvme_check_zone_write(NvmeCtrl *n, uint64_t slba, uint32_t nlb,
+    NvmeRequest *req, NvmeZone *zone)
+{
+    uint64_t zslba, wp, zcap;
+    uint16_t status;
+
+    zslba = nvme_zslba(zone);
+    wp = zone->wp_staging;
+    zcap = nvme_zcap(zone);
+
+    status = nvme_check_zone_writeable(n, req, zone);
+    if (status) {
+        return status;
+    }
+
+    if ((wp - zslba) + nlb > zcap) {
+        trace_pci_nvme_err_zone_boundary(nvme_cid(req), slba, nlb, zcap);
+        return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
+    }
+
+    if (slba != wp) {
+        trace_pci_nvme_err_zone_invalid_write(nvme_cid(req), slba, wp);
+        return NVME_ZONE_INVALID_WRITE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static inline uint16_t nvme_check_rwz_zone(NvmeCtrl *n, uint64_t slba,
+    uint32_t nlb, NvmeRequest *req, NvmeZone *zone)
+{
+    if (nvme_req_is_write(req)) {
+        return nvme_check_zone_write(n, slba, nlb, req, zone);
+    }
+
+    return nvme_check_zone_read(n, slba, nlb, req, zone);
+}
+
 static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 {
     uint8_t mdts = n->params.mdts;
@@ -995,6 +1104,44 @@ static void nvme_ns_update_util(NvmeNamespace *ns, uint64_t slba,
     nvme_req_add_aio(req, aio);
 }
 
+static void nvme_update_zone_info(NvmeNamespace *ns, NvmeRequest *req,
+    NvmeZone *zone)
+{
+    uint64_t zslba = -1;
+
+    QEMUIOVector *iov = g_new0(QEMUIOVector, 1);
+    NvmeAIO *aio = g_new0(NvmeAIO, 1);
+
+    *aio = (NvmeAIO) {
+        .opc = NVME_AIO_OPC_WRITE,
+        .blk = ns->zns.info.blk,
+        .payload = iov,
+        .req = req,
+        .flags = NVME_AIO_INTERNAL,
+    };
+
+    qemu_iovec_init(iov, 1);
+
+    if (zone) {
+        zslba = nvme_zslba(zone);
+        trace_pci_nvme_update_zone_info(nvme_cid(req), ns->params.nsid, zslba);
+
+        aio->offset = nvme_ns_zone_idx(ns, zslba) * sizeof(NvmeZoneDescriptor);
+        qemu_iovec_add(iov, &zone->zd, sizeof(NvmeZoneDescriptor));
+    } else {
+        trace_pci_nvme_update_zone_info(nvme_cid(req), ns->params.nsid, zslba);
+
+        for (int i = 0; i < ns->zns.info.num_zones; i++) {
+            qemu_iovec_add(iov, &ns->zns.info.zones[i].zd,
+                           sizeof(NvmeZoneDescriptor));
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
@@ -1009,6 +1156,44 @@ static void nvme_aio_write_cb(NvmeAIO *aio, void *opaque, int ret)
     }
 }
 
+static void nvme_zone_advance_wp(NvmeZone *zone, uint32_t nlb,
+    NvmeRequest *req)
+{
+    NvmeZoneDescriptor *zd = &zone->zd;
+    uint64_t wp = nvme_wp(zone);
+    uint64_t zslba = nvme_zslba(zone);
+
+    trace_pci_nvme_zone_advance_wp(nvme_cid(req), zslba, nlb, wp, wp + nlb);
+
+    wp += nlb;
+    if (wp == zslba + nvme_zcap(zone)) {
+        nvme_zs_set(zone, NVME_ZS_ZSF);
+    }
+
+    zd->wp = cpu_to_le64(wp);
+}
+
+static void nvme_aio_zone_write_cb(NvmeAIO *aio, void *opaque, int ret)
+{
+    NvmeZone *zone = opaque;
+    NvmeRequest *req = aio->req;
+    NvmeNamespace *ns = req->ns;
+    uint32_t nlb = req->nlb;
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t wp = nvme_wp(zone);
+
+    trace_pci_nvme_aio_zone_write_cb(nvme_cid(req), zslba, nlb, wp);
+
+    if (ret) {
+        return;
+    }
+
+    nvme_aio_write_cb(aio, opaque, ret);
+    nvme_zone_advance_wp(zone, nlb, req);
+
+    nvme_update_zone_info(ns, req, zone);
+}
+
 static void nvme_rw_cb(NvmeRequest *req, void *opaque)
 {
     NvmeNamespace *ns = req->ns;
@@ -1045,6 +1230,7 @@ static void nvme_aio_cb(void *opaque, int ret)
         block_acct_failed(stats, acct);
 
         if (req) {
+            NvmeNamespace *ns = req->ns;
             uint16_t status;
 
             switch (aio->opc) {
@@ -1075,6 +1261,16 @@ static void nvme_aio_cb(void *opaque, int ret)
             if (!req->status || (status & 0xfff) == NVME_INTERNAL_DEV_ERROR) {
                 req->status = status;
             }
+
+            /* transition the zone to offline state */
+            if (nvme_ns_zoned(ns)) {
+                NvmeZone *zone = nvme_ns_get_zone(ns, req->slba);
+
+                nvme_zs_set(zone, NVME_ZS_ZSO);
+                NVME_ZA_CLEAR(zone->zd.za);
+
+                nvme_update_zone_info(ns, req, zone);
+            }
         }
     }
 
@@ -1098,7 +1294,8 @@ static void nvme_aio_cb(void *opaque, int ret)
 }
 
 static void nvme_aio_rw(NvmeNamespace *ns, NvmeAIOOp opc,
-                        NvmeAIOCompletionFunc *cb, NvmeRequest *req)
+                        NvmeAIOCompletionFunc *cb, void *cb_arg,
+                        NvmeRequest *req)
 {
     NvmeAIO *aio = g_new(NvmeAIO, 1);
 
@@ -1108,6 +1305,7 @@ static void nvme_aio_rw(NvmeNamespace *ns, NvmeAIOOp opc,
         .offset = req->slba << nvme_ns_lbads(ns),
         .req = req,
         .cb = cb,
+        .cb_arg = cb_arg,
     };
 
     if (req->qsg.sg) {
@@ -1138,33 +1336,59 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_do_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
-    NvmeNamespace *ns = req->ns;
     NvmeAIO *aio;
+    NvmeAIOCompletionFunc *cb = nvme_aio_write_cb;
+    void *cb_arg = NULL;
+
+    NvmeNamespace *ns = req->ns;
 
     int64_t offset;
     size_t count;
     uint16_t status;
 
-    req->slba = le64_to_cpu(rw->slba);
-    req->nlb  = le16_to_cpu(rw->nlb) + 1;
-
     trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), req->slba,
                                 req->nlb);
 
     status = nvme_check_bounds(n, ns, req->slba, req->nlb);
     if (status) {
         NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
-        trace_pci_nvme_err_invalid_lba_range(req->slba, req->nlb,
-                                             id_ns->nsze);
-        return status;
+        trace_pci_nvme_err_invalid_lba_range(req->slba, req->nlb, id_ns->nsze);
+
+        goto invalid;
     }
 
     offset = req->slba << nvme_ns_lbads(ns);
     count = req->nlb << nvme_ns_lbads(ns);
 
+    if (nvme_ns_zoned(ns)) {
+        NvmeZone *zone = nvme_ns_get_zone(ns, req->slba);
+        if (!zone) {
+            trace_pci_nvme_err_invalid_zone(nvme_cid(req), req->slba);
+            status = NVME_INVALID_FIELD | NVME_DNR;
+            goto invalid;
+        }
+
+        status = nvme_check_zone_write(n, req->slba, req->nlb, req, zone);
+        if (status) {
+            goto invalid;
+        }
+
+        switch (nvme_zs(zone)) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSC:
+            nvme_zs_set(zone, NVME_ZS_ZSIO);
+        default:
+            break;
+        }
+
+        cb = nvme_aio_zone_write_cb;
+        cb_arg = zone;
+
+        zone->wp_staging += req->nlb;
+    }
+
     aio = g_new0(NvmeAIO, 1);
 
     *aio = (NvmeAIO) {
@@ -1173,25 +1397,33 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         .offset = offset,
         .len = count,
         .req = req,
-        .cb = nvme_aio_write_cb,
+        .cb = cb,
+        .cb_arg = cb_arg,
     };
 
     nvme_req_add_aio(req, aio);
 
+    nvme_req_set_cb(req, nvme_rw_cb, NULL);
+
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
+    return status;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_do_rw(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeAIOCompletionFunc *cb = NULL;
+    void *cb_arg = NULL;
+
     NvmeNamespace *ns = req->ns;
 
-    uint32_t len;
-    int status;
+    size_t len;
+    uint16_t status;
 
     enum BlockAcctType acct = BLOCK_ACCT_READ;
     NvmeAIOOp opc = NVME_AIO_OPC_READ;
-    NvmeAIOCompletionFunc *cb = NULL;
 
     if (nvme_req_is_write(req)) {
         acct = BLOCK_ACCT_WRITE;
@@ -1199,8 +1431,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         cb = nvme_aio_write_cb;
     }
 
-    req->nlb  = le16_to_cpu(rw->nlb) + 1;
-    req->slba = le64_to_cpu(rw->slba);
     len = req->nlb << nvme_ns_lbads(ns);
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_req_is_write(req) ? "write" : "read",
@@ -1216,7 +1446,38 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    nvme_aio_rw(ns, opc, cb, req);
+    if (nvme_ns_zoned(ns)) {
+        NvmeZone *zone = nvme_ns_get_zone(ns, req->slba);
+        if (!zone) {
+            trace_pci_nvme_err_invalid_zone(nvme_cid(req), req->slba);
+            status = NVME_INVALID_FIELD | NVME_DNR;
+            goto invalid;
+        }
+
+        status = nvme_check_rwz_zone(n, req->slba, req->nlb, req, zone);
+        if (status) {
+            goto invalid;
+        }
+
+        if (nvme_req_is_write(req)) {
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSE:
+            case NVME_ZS_ZSC:
+                nvme_zs_set(zone, NVME_ZS_ZSIO);
+            default:
+                break;
+            }
+
+            cb = nvme_aio_zone_write_cb;
+            cb_arg = zone;
+
+            zone->wp_staging += req->nlb;
+        }
+    } else if (nvme_req_is_write(req)) {
+        cb = nvme_aio_write_cb;
+    }
+
+    nvme_aio_rw(ns, opc, cb, cb_arg, req);
     nvme_req_set_cb(req, nvme_rw_cb, NULL);
 
     return NVME_NO_COMPLETE;
@@ -1226,6 +1487,47 @@ invalid:
     return status;
 }
 
+static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+
+    req->nlb  = le16_to_cpu(rw->nlb) + 1;
+    req->slba = le64_to_cpu(rw->slba);
+
+    if (nvme_ns_zoned(ns) && nvme_req_is_write(req)) {
+        zone = nvme_ns_get_zone(ns, req->slba);
+        if (!zone) {
+            trace_pci_nvme_err_invalid_zone(nvme_cid(req), req->slba);
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        if (zone->wp_staging != nvme_wp(zone)) {
+            NVME_GUEST_ERR(pci_nvme_zone_pending_writes,
+                           "cid %"PRIu16"; zone (zslba 0x%"PRIx64") has "
+                           "pending writes "
+                           "(wp 0x%"PRIx64" wp_staging 0x%"PRIx64"; "
+                           "additional writes should not be submitted",
+                           nvme_cid(req), nvme_zslba(zone), nvme_wp(zone),
+                           zone->wp_staging);
+
+            if (n->params.defensive) {
+                return NVME_ZONE_INVALID_WRITE;
+            }
+        }
+    }
+
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE_ZEROES:
+        return nvme_do_write_zeroes(n, req);
+    default:
+        break;
+    }
+
+    return nvme_do_rw(n, req);
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
@@ -1245,11 +1547,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
-    case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, req);
-    case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, req);
+    case NVME_CMD_WRITE:
+    case NVME_CMD_WRITE_ZEROES:
+        return nvme_rwz(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -2342,6 +2643,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         if (ns->blk_state) {
             blk_drain(ns->blk_state);
         }
+
+        if (nvme_ns_zoned(ns)) {
+            blk_drain(ns->zns.info.blk);
+        }
     }
 
     for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
@@ -2376,6 +2681,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         if (ns->blk_state) {
             blk_flush(ns->blk_state);
         }
+
+        if (nvme_ns_zoned(ns)) {
+            blk_flush(ns->zns.info.blk);
+        }
     }
 
     n->bar.cc = 0;
@@ -2897,7 +3206,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
-    n->iocscs[0] = 1 << NVME_IOCS_NVM;
+    n->iocscs[0] = (1 << NVME_IOCS_NVM) | (1 << NVME_IOCS_ZONED);
     n->features.iocsci = 0;
 }
 
@@ -3047,6 +3356,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NvmeIdCtrl *id = &n->id_ctrl;
     uint8_t *pci_conf = pci_dev->config;
 
+    n->id_ctrl_iocss[NVME_IOCS_NVM] = g_new0(NvmeIdCtrl, 1);
+    n->id_ctrl_iocss[NVME_IOCS_ZONED] = g_new0(NvmeIdCtrl, 1);
+
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
@@ -3183,6 +3495,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
+    DEFINE_PROP_BOOL("defensive", NvmeCtrl, params.defensive, false),
     DEFINE_PROP_BOOL("x-use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 69be47963f5d..1ec1af8d6291 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -7,6 +7,7 @@
 #define NVME_MAX_NAMESPACES 256
 
 typedef struct NvmeParams {
+    bool     defensive;
     char     *serial;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 4cf0236631d2..9e0b848186c8 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -42,6 +42,8 @@ pci_nvme_req_add_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offs
 pci_nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
 pci_nvme_aio_discard_cb(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_aio_write_cb(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
+pci_nvme_aio_zone_write_cb(uint16_t cid, uint64_t lba, uint32_t nlb, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" wp 0x%"PRIx64""
+pci_nvme_zone_advance_wp(uint16_t cid, uint64_t lba, uint32_t nlb, uint64_t wp_old, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" wp_old 0x%"PRIx64" wp 0x%"PRIx64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
@@ -80,6 +82,8 @@ pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRI
 pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
 pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
 pci_nvme_ns_update_util(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_pending_writes(uint16_t cid, uint64_t zslba, uint64_t wp, uint64_t wp_staging) "cid %"PRIu16" zslba 0x%"PRIx64" wp 0x%"PRIx64" wp_staging 0x%"PRIx64""
+pci_nvme_update_zone_info(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
@@ -99,6 +103,10 @@ pci_nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset,
 pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status, uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc 0x%"PRIx8""
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_zone_is_full(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0x%"PRIx64""
+pci_nvme_err_zone_is_read_only(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0x%"PRIx64""
+pci_nvme_err_zone_invalid_write(uint16_t cid, uint64_t slba, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" wp 0x%"PRIx64""
+pci_nvme_err_zone_boundary(uint16_t cid, uint64_t slba, uint32_t nlb, uint64_t zcap) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" zcap 0x%"PRIx64""
 pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
@@ -127,6 +135,8 @@ pci_nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx1
 pci_nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
 pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
 pci_nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
+pci_nvme_err_invalid_zone(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0x%"PRIx64""
+pci_nvme_err_invalid_zone_condition(uint16_t cid, uint64_t zslba, uint8_t condition) "cid %"PRIu16" zslba 0x%"PRIx64" condition 0x%"PRIx8""
 pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
 pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
 pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
-- 
2.27.0


