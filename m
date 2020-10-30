Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0289C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A26206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYj+hdJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A26206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKHu-0003CI-4N
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKE2-0006CJ-El; Thu, 29 Oct 2020 22:33:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDx-0006bi-LA; Thu, 29 Oct 2020 22:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025185; x=1635561185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BEC5MqIBZllbG4GdXksNrI/GzE16zo2NDNlpfssRlB4=;
 b=GYj+hdJ020WLp5ljHMqpmZSefEpfamZe/VkNzk1/KLnzPi2LBy7RI2RT
 lWpVJvwb9l47Enk0gh3s+U6CWVLuO4dhDMlIORhYW4NUiXleWOCJ0zue1
 g3upWB0wI8Iz6jTWnn0UY1J9CvoF9VA5JgiIllPHdesccn6gOGbWURp0j
 pifuwAxAWjYkn60y90VbnU3DHhXoCmAqqf6clobvdnfKGpviqa5/TvMG9
 rniUxxjp/D3ivh4iH0FnF6T/p3DdydQQiKcKN7Q4EC/lgMfaND6rQAT5O
 WN0Or0j8MyC79cUfvcrU9xeHbxu424ZOZ0xss/iebbmjs5ySS0MDCC9WZ g==;
IronPort-SDR: QyZba68Xb8KGXxz/vdip0ZphFLvEOFJyXMfU+4OrmoiUVMtQ6MmcADBFJJY/hF3tyH2mkocjPN
 S2hEVI5apc3RVten0cEv+vriw2X1kJKnV1Eg4M+w8R9ZrCZXbzOwesTxqXz8aa+MF5Hf0N8+hq
 Dt2zi6nUa9/7Ua6WKvxcIuAWj74t5HfojX25aqgs3ZkfLJAqQL29rsww4NbXzdz9zvX34snq7D
 NTvvqDVu3SvBa2xvKIf8aK5RVMnT3RVD+vdfhCgUDbeUXRH+IdDtJQHXaqUUFAlKd/uOaTFdOI
 Co4=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748084"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:33:03 +0800
IronPort-SDR: esplyxTfwucJqABax7LUlZGOZTxfZPInkep7JQpPTzPMAqyEU8oeWdU5IsWT1gfKuNEnEPoYFg
 wFShM00PUYZvgYFGq6SLAsR1bIBFwsZjEspV2kARGAKNe0E++ZngPguNxoGVTQyhj/5UEDlP4G
 9+hTFPvesORpiQ6s98xYgqLvjZdHJDyumj3y6to9ATPicMUHTmKlg8u1kiToz4uRBVr+h+nbvL
 oFNNYA5GGGf7qwW8bUE/RfupvxR9WpC3Xyw0C6y4FXtFYlil0oadi856x3kmPCGjna8ICFpCNS
 8RHrdng9a5PeOoiJh7xhY/fR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:18:08 -0700
IronPort-SDR: E4nHlLGmVYR807jJRyi68UAFIjKkkXTbFjdzQcQqkhBOnmVKg+Zs6affpXCVSOm9y0wc3xnc18
 4oGf/Fob/+ahXa9gCi/3lcxcxwHrenM/HD4F4uq/6hHxCcB7sYa4ycHobwJBbqhJ2CpnsXsEwC
 8spMFvMyazZm6UfFnQUdBWfTHZl4TNtvLXwsdJZbc4yFm3+DfuxKYUTOaS587AO/N+zXY6BC7o
 w6KORoufVpxzYAC9RNOMhkt9rddSMmGdIMbKUaUuOepFbY4LVtr3c1kC2rvRICp1DZlqdBKAaA
 09w=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:33:03 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 07/11] hw/block/nvme: Support Zoned Namespace Command Set
Date: Fri, 30 Oct 2020 11:32:38 +0900
Message-Id: <20201030023242.5204-8-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=56530b5a8=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:32:49
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

The emulation code has been changed to advertise NVM Command Set when
"zoned" device property is not set (default) and Zoned Namespace
Command Set otherwise.

Define values and structures that are needed to support Zoned
Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
Define trace events where needed in newly introduced code.

In order to improve scalability, all open, closed and full zones
are organized in separate linked lists. Consequently, almost all
zone operations don't require scanning of the entire zone array
(which potentially can be quite large) - it is only necessary to
enumerate one or more zone lists.

Handlers for three new NVMe commands introduced in Zoned Namespace
Command Set specification are added, namely for Zone Management
Receive, Zone Management Send and Zone Append.

Device initialization code has been extended to create a proper
configuration for zoned operation using device properties.

Read/Write command handler is modified to only allow writes at the
write pointer if the namespace is zoned. For Zone Append command,
writes implicitly happen at the write pointer and the starting write
pointer value is returned as the result of the command. Write Zeroes
handler is modified to add zoned checks that are identical to those
done as a part of Write flow.

Subsequent commits in this series add ZDE support and checks for
active and open zone limits.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 block/nvme.c          |   2 +-
 hw/block/nvme-ns.c    | 173 ++++++++
 hw/block/nvme-ns.h    |  54 +++
 hw/block/nvme.c       | 977 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |   8 +
 hw/block/trace-events |  18 +-
 include/block/nvme.h  | 113 ++++-
 7 files changed, 1322 insertions(+), 23 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 05485fdd11..7a513c9a17 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le32_to_cpu(c->result32),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index e191ef9be0..e6db7f7d3b 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 
+#include "trace.h"
 #include "nvme.h"
 #include "nvme-ns.h"
 
@@ -77,6 +78,151 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     return 0;
 }
 
+static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
+{
+    uint64_t zone_size, zone_cap;
+    uint32_t nz, lbasz = ns->blkconf.logical_block_size;
+
+    if (ns->params.zone_size_bs) {
+        zone_size = ns->params.zone_size_bs;
+    } else {
+        zone_size = NVME_DEFAULT_ZONE_SIZE;
+    }
+    if (ns->params.zone_cap_bs) {
+        zone_cap = ns->params.zone_cap_bs;
+    } else {
+        zone_cap = zone_size;
+    }
+    if (zone_cap > zone_size) {
+        error_setg(errp, "zone capacity %luB exceeds zone size %luB",
+                   zone_cap, zone_size);
+        return -1;
+    }
+    if (zone_size < lbasz) {
+        error_setg(errp, "zone size %luB too small, must be at least %uB",
+                   zone_size, lbasz);
+        return -1;
+    }
+    if (zone_cap < lbasz) {
+        error_setg(errp, "zone capacity %luB too small, must be at least %uB",
+                   zone_cap, lbasz);
+        return -1;
+    }
+    ns->zone_size = zone_size / lbasz;
+    ns->zone_capacity = zone_cap / lbasz;
+
+    nz = DIV_ROUND_UP(ns->size / lbasz, ns->zone_size);
+    ns->num_zones = nz;
+    ns->zone_array_size = sizeof(NvmeZone) * nz;
+    ns->zone_size_log2 = 0;
+    if (is_power_of_2(ns->zone_size)) {
+        ns->zone_size_log2 = 63 - clz64(ns->zone_size);
+    }
+
+    return 0;
+}
+
+static void nvme_init_zone_state(NvmeNamespace *ns)
+{
+    uint64_t start = 0, zone_size = ns->zone_size;
+    uint64_t capacity = ns->num_zones * zone_size;
+    NvmeZone *zone;
+    int i;
+
+    ns->zone_array = g_malloc0(ns->zone_array_size);
+
+    QTAILQ_INIT(&ns->exp_open_zones);
+    QTAILQ_INIT(&ns->imp_open_zones);
+    QTAILQ_INIT(&ns->closed_zones);
+    QTAILQ_INIT(&ns->full_zones);
+
+    zone = ns->zone_array;
+    for (i = 0; i < ns->num_zones; i++, zone++) {
+        if (start + zone_size > capacity) {
+            zone_size = capacity - start;
+        }
+        zone->d.zt = NVME_ZONE_TYPE_SEQ_WRITE;
+        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
+        zone->d.za = 0;
+        zone->d.zcap = ns->zone_capacity;
+        zone->d.zslba = start;
+        zone->d.wp = start;
+        zone->w_ptr = start;
+        start += zone_size;
+    }
+}
+
+static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
+                              Error **errp)
+{
+    NvmeIdNsZoned *id_ns_z;
+
+    if (nvme_calc_zone_geometry(ns, errp) != 0) {
+        return -1;
+    }
+
+    nvme_init_zone_state(ns);
+
+    id_ns_z = g_malloc0(sizeof(NvmeIdNsZoned));
+
+    /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
+    id_ns_z->mar = 0xffffffff;
+    id_ns_z->mor = 0xffffffff;
+    id_ns_z->zoc = 0;
+    id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
+
+    id_ns_z->lbafe[lba_index].zsze = cpu_to_le64(ns->zone_size);
+    id_ns_z->lbafe[lba_index].zdes = 0;
+
+    ns->csi = NVME_CSI_ZONED;
+    ns->id_ns.nsze = cpu_to_le64(ns->zone_size * ns->num_zones);
+    ns->id_ns.ncap = cpu_to_le64(ns->zone_capacity * ns->num_zones);
+    ns->id_ns.nuse = ns->id_ns.ncap;
+
+    ns->id_ns_zoned = id_ns_z;
+
+    return 0;
+}
+
+static void nvme_clear_zone(NvmeNamespace *ns, NvmeZone *zone)
+{
+    uint8_t state;
+
+    zone->w_ptr = zone->d.wp;
+    state = nvme_get_zone_state(zone);
+    if (zone->d.wp != zone->d.zslba) {
+        if (state != NVME_ZONE_STATE_CLOSED) {
+            trace_pci_nvme_clear_ns_close(state, zone->d.zslba);
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_CLOSED);
+        }
+        QTAILQ_INSERT_HEAD(&ns->closed_zones, zone, entry);
+    } else {
+        trace_pci_nvme_clear_ns_reset(state, zone->d.zslba);
+        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
+    }
+}
+
+/*
+ * Close all the zones that are currently open.
+ */
+static void nvme_zoned_ns_shutdown(NvmeNamespace *ns)
+{
+    NvmeZone *zone, *next;
+
+    QTAILQ_FOREACH_SAFE(zone, &ns->closed_zones, entry, next) {
+        QTAILQ_REMOVE(&ns->closed_zones, zone, entry);
+        nvme_clear_zone(ns, zone);
+    }
+    QTAILQ_FOREACH_SAFE(zone, &ns->imp_open_zones, entry, next) {
+        QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
+        nvme_clear_zone(ns, zone);
+    }
+    QTAILQ_FOREACH_SAFE(zone, &ns->exp_open_zones, entry, next) {
+        QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
+        nvme_clear_zone(ns, zone);
+    }
+}
+
 static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
 {
     if (!ns->blkconf.blk) {
@@ -98,6 +244,12 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     nvme_ns_init(ns);
+    if (ns->params.zoned) {
+        if (nvme_zoned_init_ns(n, ns, 0, errp) != 0) {
+            return -1;
+        }
+    }
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
@@ -115,6 +267,21 @@ void nvme_ns_flush(NvmeNamespace *ns)
     blk_flush(ns->blkconf.blk);
 }
 
+void nvme_ns_shutdown(NvmeNamespace *ns)
+{
+    if (ns->params.zoned) {
+        nvme_zoned_ns_shutdown(ns);
+    }
+}
+
+void nvme_ns_cleanup(NvmeNamespace *ns)
+{
+    if (ns->params.zoned) {
+        g_free(ns->id_ns_zoned);
+        g_free(ns->zone_array);
+    }
+}
+
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
@@ -133,6 +300,12 @@ static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
+    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),
+    DEFINE_PROP_SIZE("zoned.zsze", NvmeNamespace, params.zone_size_bs,
+                     NVME_DEFAULT_ZONE_SIZE),
+    DEFINE_PROP_SIZE("zoned.zcap", NvmeNamespace, params.zone_cap_bs, 0),
+    DEFINE_PROP_BOOL("zoned.cross_read", NvmeNamespace,
+                     params.cross_zone_read, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 2d9cd29d07..d2631ff5a3 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -19,9 +19,20 @@
 #define NVME_NS(obj) \
     OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
 
+typedef struct NvmeZone {
+    NvmeZoneDescr   d;
+    uint64_t        w_ptr;
+    QTAILQ_ENTRY(NvmeZone) entry;
+} NvmeZone;
+
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     QemuUUID uuid;
+
+    bool     zoned;
+    bool     cross_zone_read;
+    uint64_t zone_size_bs;
+    uint64_t zone_cap_bs;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -34,6 +45,18 @@ typedef struct NvmeNamespace {
     bool         attached;
     uint8_t      csi;
 
+    NvmeIdNsZoned   *id_ns_zoned;
+    NvmeZone        *zone_array;
+    QTAILQ_HEAD(, NvmeZone) exp_open_zones;
+    QTAILQ_HEAD(, NvmeZone) imp_open_zones;
+    QTAILQ_HEAD(, NvmeZone) closed_zones;
+    QTAILQ_HEAD(, NvmeZone) full_zones;
+    uint32_t        num_zones;
+    uint64_t        zone_size;
+    uint64_t        zone_capacity;
+    uint64_t        zone_array_size;
+    uint32_t        zone_size_log2;
+
     NvmeNamespaceParams params;
 } NvmeNamespace;
 
@@ -71,8 +94,39 @@ static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
 
 typedef struct NvmeCtrl NvmeCtrl;
 
+static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
+{
+    return zone->d.zs >> 4;
+}
+
+static inline void nvme_set_zone_state(NvmeZone *zone, enum NvmeZoneState state)
+{
+    zone->d.zs = state << 4;
+}
+
+static inline uint64_t nvme_zone_rd_boundary(NvmeNamespace *ns, NvmeZone *zone)
+{
+    return zone->d.zslba + ns->zone_size;
+}
+
+static inline uint64_t nvme_zone_wr_boundary(NvmeZone *zone)
+{
+    return zone->d.zslba + zone->d.zcap;
+}
+
+static inline bool nvme_wp_is_valid(NvmeZone *zone)
+{
+    uint8_t st = nvme_get_zone_state(zone);
+
+    return st != NVME_ZONE_STATE_FULL &&
+           st != NVME_ZONE_STATE_READ_ONLY &&
+           st != NVME_ZONE_STATE_OFFLINE;
+}
+
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
+void nvme_ns_shutdown(NvmeNamespace *ns);
+void nvme_ns_cleanup(NvmeNamespace *ns);
 
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7b3eafad03..0326e1611c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -133,6 +133,16 @@ static const uint32_t nvme_cse_iocs_nvm[256] = {
     [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
 };
 
+static const uint32_t nvme_cse_iocs_zoned[256] = {
+    [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
+};
+
 static void nvme_process_sq(void *opaque);
 
 static uint16_t nvme_cid(NvmeRequest *req)
@@ -149,6 +159,46 @@ static uint16_t nvme_sqid(NvmeRequest *req)
     return le16_to_cpu(req->sq->sqid);
 }
 
+static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
+                                   uint8_t state)
+{
+    if (QTAILQ_IN_USE(zone, entry)) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            QTAILQ_REMOVE(&ns->closed_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_FULL:
+            QTAILQ_REMOVE(&ns->full_zones, zone, entry);
+        }
+    }
+
+    nvme_set_zone_state(zone, state);
+
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        QTAILQ_INSERT_TAIL(&ns->exp_open_zones, zone, entry);
+        break;
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        QTAILQ_INSERT_TAIL(&ns->imp_open_zones, zone, entry);
+        break;
+    case NVME_ZONE_STATE_CLOSED:
+        QTAILQ_INSERT_TAIL(&ns->closed_zones, zone, entry);
+        break;
+    case NVME_ZONE_STATE_FULL:
+        QTAILQ_INSERT_TAIL(&ns->full_zones, zone, entry);
+    case NVME_ZONE_STATE_READ_ONLY:
+        break;
+    default:
+        zone->d.za = 0;
+    }
+}
+
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low = n->ctrl_mem.addr;
@@ -841,7 +891,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.result32;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -910,6 +960,318 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static void nvme_fill_read_data(NvmeRequest *req, uint64_t offset,
+                                uint32_t max_len)
+{
+    QEMUSGList *qsg = &req->qsg;
+    QEMUIOVector *iov = &req->iov;
+    ScatterGatherEntry *entry;
+    uint32_t len, ent_len;
+
+    if (qsg->nsg > 0) {
+        entry = qsg->sg;
+        len = qsg->size;
+        if (max_len) {
+            len = MIN(len, max_len);
+        }
+        for (; len > 0; len -= ent_len) {
+            ent_len = MIN(len, entry->len);
+            if (offset > ent_len) {
+                offset -= ent_len;
+            } else if (offset != 0) {
+                dma_memory_set(qsg->as, entry->base + offset,
+                               0, ent_len - offset);
+                offset = 0;
+            } else {
+                dma_memory_set(qsg->as, entry->base, 0, ent_len);
+            }
+            entry++;
+        }
+    } else if (iov->iov) {
+        len = iov_size(iov->iov, iov->niov);
+        if (max_len) {
+            len = MIN(len, max_len);
+        }
+        qemu_iovec_memset(iov, offset, 0, len - offset);
+    }
+}
+
+static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
+{
+    return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
+                                    slba / ns->zone_size;
+}
+
+static inline NvmeZone *nvme_get_zone_by_slba(NvmeNamespace *ns, uint64_t slba)
+{
+    uint32_t zone_idx = nvme_zone_idx(ns, slba);
+
+    assert(zone_idx < ns->num_zones);
+    return &ns->zone_array[zone_idx];
+}
+
+static uint16_t nvme_zone_state_ok_to_write(NvmeZone *zone)
+{
+    uint16_t status;
+
+    switch (nvme_get_zone_state(zone)) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+        status = NVME_SUCCESS;
+        break;
+    case NVME_ZONE_STATE_FULL:
+        status = NVME_ZONE_FULL;
+        break;
+    case NVME_ZONE_STATE_OFFLINE:
+        status = NVME_ZONE_OFFLINE;
+        break;
+    case NVME_ZONE_STATE_READ_ONLY:
+        status = NVME_ZONE_READ_ONLY;
+        break;
+    default:
+        assert(false);
+    }
+
+    return status;
+}
+
+static uint16_t nvme_check_zone_write(NvmeCtrl *n, NvmeNamespace *ns,
+                                      NvmeZone *zone, uint64_t slba,
+                                      uint32_t nlb, bool append)
+{
+    uint16_t status;
+
+    if (unlikely((slba + nlb) > nvme_zone_wr_boundary(zone))) {
+        status = NVME_ZONE_BOUNDARY_ERROR;
+    } else {
+        status = nvme_zone_state_ok_to_write(zone);
+    }
+
+    if (status != NVME_SUCCESS) {
+        trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
+    } else {
+        assert(nvme_wp_is_valid(zone));
+        if (append) {
+            if (unlikely(slba != zone->d.zslba)) {
+                trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
+                status = NVME_ZONE_INVALID_WRITE;
+            }
+            if (nvme_l2b(ns, nlb) > (n->page_size << n->zasl)) {
+                trace_pci_nvme_err_append_too_large(slba, nlb, n->zasl);
+                status = NVME_INVALID_FIELD;
+            }
+        } else if (unlikely(slba != zone->w_ptr)) {
+            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
+                                               zone->w_ptr);
+            status = NVME_ZONE_INVALID_WRITE;
+        }
+    }
+
+    return status;
+}
+
+static uint16_t nvme_zone_state_ok_to_read(NvmeZone *zone)
+{
+    uint16_t status;
+
+    switch (nvme_get_zone_state(zone)) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_FULL:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_READ_ONLY:
+        status = NVME_SUCCESS;
+        break;
+    case NVME_ZONE_STATE_OFFLINE:
+        status = NVME_ZONE_OFFLINE | NVME_DNR;
+        break;
+    default:
+        assert(false);
+    }
+
+    return status;
+}
+
+typedef struct NvmeReadFillCtx {
+    uint64_t  pre_rd_fill_slba;
+    uint64_t  read_slba;
+    uint64_t  post_rd_fill_slba;
+
+    uint32_t  pre_rd_fill_nlb;
+    uint32_t  read_nlb;
+    uint32_t  post_rd_fill_nlb;
+} NvmeReadFillCtx;
+
+static uint16_t nvme_check_zone_read(NvmeNamespace *ns, uint64_t slba,
+                                     uint32_t nlb, NvmeReadFillCtx *rfc)
+{
+    NvmeZone *zone = nvme_get_zone_by_slba(ns, slba);
+    NvmeZone *next_zone;
+    uint64_t bndry = nvme_zone_rd_boundary(ns, zone);
+    uint64_t end = slba + nlb, wp1, wp2;
+    uint16_t status;
+
+    rfc->read_slba = slba;
+    rfc->read_nlb = nlb;
+
+    status = nvme_zone_state_ok_to_read(zone);
+    if (status != NVME_SUCCESS) {
+        ;
+    } else if (likely(end <= bndry)) {
+        if (end > zone->w_ptr) {
+            wp1 = zone->w_ptr;
+            if (slba >= wp1) {
+                /* No i/o necessary, just fill */
+                rfc->pre_rd_fill_slba = slba;
+                rfc->pre_rd_fill_nlb = nlb;
+                rfc->read_nlb = 0;
+            } else {
+                rfc->read_nlb = wp1 - slba;
+                rfc->post_rd_fill_slba = wp1;
+                rfc->post_rd_fill_nlb = nlb - rfc->read_nlb;
+           }
+        }
+    } else if (!ns->params.cross_zone_read) {
+        status = NVME_ZONE_BOUNDARY_ERROR;
+    } else {
+        /*
+         * Read across zone boundary - look at the next zone.
+         * Earlier bounds checks ensure that the current zone
+         * is not the last one.
+         */
+        next_zone = zone + 1;
+        status = nvme_zone_state_ok_to_read(next_zone);
+        if (status != NVME_SUCCESS) {
+            ;
+        } else if (end > nvme_zone_rd_boundary(ns, next_zone)) {
+            /*
+             * As zone size is much larger than a typical maximum
+             * i/o size in real hardware, only allow the i/o range
+             * to span no more than one pair of zones.
+             */
+            status = NVME_ZONE_BOUNDARY_ERROR;
+        } else {
+            wp1 = zone->w_ptr;
+            wp2 = next_zone->w_ptr;
+            if (wp2 == bndry) {
+                if (slba >= wp1) {
+                    /* Again, no i/o necessary, just fill */
+                    rfc->pre_rd_fill_slba = slba;
+                    rfc->pre_rd_fill_nlb = nlb;
+                    rfc->read_nlb = 0;
+                } else {
+                    rfc->read_nlb = wp1 - slba;
+                    rfc->post_rd_fill_slba = wp1;
+                    rfc->post_rd_fill_nlb = nlb - rfc->read_nlb;
+                }
+            } else if (slba < wp1) {
+                if (end > wp2) {
+                    if (wp1 == bndry) {
+                        rfc->post_rd_fill_slba = wp2;
+                        rfc->post_rd_fill_nlb = end - wp2;
+                        rfc->read_nlb = wp2 - slba;
+                    } else {
+                        rfc->pre_rd_fill_slba = wp2;
+                        rfc->pre_rd_fill_nlb = end - wp2;
+                        rfc->read_nlb = wp2 - slba;
+                        rfc->post_rd_fill_slba = wp1;
+                        rfc->post_rd_fill_nlb = bndry - wp1;
+                    }
+                } else {
+                    rfc->post_rd_fill_slba = wp1;
+                    rfc->post_rd_fill_nlb = bndry - wp1;
+                }
+            } else {
+                if (end > wp2) {
+                    rfc->pre_rd_fill_slba = slba;
+                    rfc->pre_rd_fill_nlb = end - slba;
+                    rfc->read_slba = bndry;
+                    rfc->read_nlb = wp2 - bndry;
+                } else {
+                    rfc->read_slba = bndry;
+                    rfc->read_nlb = end - bndry;
+                    rfc->post_rd_fill_slba = slba;
+                    rfc->post_rd_fill_nlb = bndry - slba;
+                }
+            }
+        }
+    }
+
+    return status;
+}
+
+static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req,
+                                      bool failed)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeZone *zone;
+    uint64_t slba, start_wp = req->cqe.result64;
+    uint32_t nlb;
+
+    if (rw->opcode != NVME_CMD_WRITE &&
+        rw->opcode != NVME_CMD_ZONE_APPEND &&
+        rw->opcode != NVME_CMD_WRITE_ZEROES) {
+        return false;
+    }
+
+    slba = le64_to_cpu(rw->slba);
+    nlb = le16_to_cpu(rw->nlb) + 1;
+    zone = nvme_get_zone_by_slba(ns, slba);
+
+    if (!failed && zone->w_ptr < start_wp + nlb) {
+        /*
+         * A preceding queued write to the zone has failed,
+         * now this write is not at the WP, fail it too.
+         */
+        failed = true;
+    }
+
+    if (failed) {
+        req->cqe.result64 = 0;
+    } else if (zone->w_ptr == nvme_zone_wr_boundary(zone)) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        case NVME_ZONE_STATE_CLOSED:
+        case NVME_ZONE_STATE_EMPTY:
+            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
+            /* fall through */
+        case NVME_ZONE_STATE_FULL:
+            break;
+        default:
+            assert(false);
+        }
+        zone->d.wp = zone->w_ptr;
+    } else {
+        zone->d.wp += nlb;
+    }
+
+    return failed;
+}
+
+static uint64_t nvme_advance_zone_wp(NvmeNamespace *ns, NvmeZone *zone,
+                                     uint32_t nlb)
+{
+    uint64_t result = zone->w_ptr;
+    uint8_t zs;
+
+    zone->w_ptr += nlb;
+
+    if (zone->w_ptr < nvme_zone_wr_boundary(zone)) {
+        zs = nvme_get_zone_state(zone);
+        switch (zs) {
+        case NVME_ZONE_STATE_EMPTY:
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_IMPLICITLY_OPEN);
+        }
+    }
+
+    return result;
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -924,10 +1286,26 @@ static void nvme_rw_cb(void *opaque, int ret)
     trace_pci_nvme_rw_cb(nvme_cid(req), blk_name(blk));
 
     if (!ret) {
-        block_acct_done(stats, acct);
+        if (ns->params.zoned) {
+            if (nvme_finalize_zoned_write(ns, req, false)) {
+                ret = EIO;
+                block_acct_failed(stats, acct);
+                req->status = NVME_ZONE_INVALID_WRITE;
+            } else if (req->fill_len) {
+                nvme_fill_read_data(req, req->fill_off, req->fill_len);
+                req->fill_len = 0;
+            }
+        }
+        if (!ret) {
+            block_acct_done(stats, acct);
+        }
     } else {
         uint16_t status;
 
+        if (ns->params.zoned) {
+            nvme_finalize_zoned_write(ns, req, true);
+        }
+
         block_acct_failed(stats, acct);
 
         switch (req->cmd.opcode) {
@@ -970,7 +1348,9 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t data_size = nvme_l2b(ns, nlb);
-    uint64_t data_offset;
+    uint64_t data_offset, fill_off;
+    uint32_t fill_len;
+    NvmeReadFillCtx rfc = {};
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
@@ -988,11 +1368,40 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        status = nvme_check_zone_read(ns, slba, nlb, &rfc);
+        if (status != NVME_SUCCESS) {
+            trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
+            goto invalid;
+        }
+    }
+
     status = nvme_map_dptr(n, data_size, req);
     if (status) {
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        if (rfc.pre_rd_fill_nlb) {
+            fill_off = nvme_l2b(ns, rfc.pre_rd_fill_slba - slba);
+            fill_len = nvme_l2b(ns, rfc.pre_rd_fill_nlb);
+            nvme_fill_read_data(req, fill_off, fill_len);
+        }
+        if (!rfc.read_nlb) {
+            /* No backend I/O necessary, only needed to fill the buffer */
+            req->status = NVME_SUCCESS;
+            return NVME_SUCCESS;
+        }
+        if (rfc.post_rd_fill_nlb) {
+            req->fill_off = nvme_l2b(ns, rfc.post_rd_fill_slba - slba);
+            req->fill_len = nvme_l2b(ns, rfc.post_rd_fill_nlb);
+        } else {
+            req->fill_len = 0;
+        }
+        slba = rfc.read_slba;
+        data_size = nvme_l2b(ns, rfc.read_nlb);
+    }
+
     data_offset = nvme_l2b(ns, slba);
 
     block_acct_start(blk_get_stats(blk), &req->acct, data_size,
@@ -1011,7 +1420,7 @@ invalid:
     return status | NVME_DNR;
 }
 
-static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool wrz)
+static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append, bool wrz)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
@@ -1019,6 +1428,7 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool wrz)
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t data_offset;
+    NvmeZone *zone;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
@@ -1039,6 +1449,25 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool wrz)
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        zone = nvme_get_zone_by_slba(ns, slba);
+
+        status = nvme_check_zone_write(n, ns, zone, slba, nlb, append);
+        if (status != NVME_SUCCESS) {
+            goto invalid;
+        }
+
+        if (append) {
+            slba = zone->w_ptr;
+        }
+
+        req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
+    } else if (append) {
+        trace_pci_nvme_err_invalid_opc(rw->opcode);
+        status = NVME_INVALID_OPCODE;
+        goto invalid;
+    }
+
     data_offset = nvme_l2b(ns, slba);
 
     if (!wrz) {
@@ -1069,6 +1498,433 @@ invalid:
     return status | NVME_DNR;
 }
 
+static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
+                                            uint64_t *slba, uint32_t *zone_idx)
+{
+    uint32_t dw10 = le32_to_cpu(c->cdw10);
+    uint32_t dw11 = le32_to_cpu(c->cdw11);
+
+    if (!ns->params.zoned) {
+        trace_pci_nvme_err_invalid_opc(c->opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    *slba = ((uint64_t)dw11) << 32 | dw10;
+    if (unlikely(*slba >= ns->id_ns.nsze)) {
+        trace_pci_nvme_err_invalid_lba_range(*slba, 0, ns->id_ns.nsze);
+        *slba = 0;
+        return NVME_LBA_RANGE | NVME_DNR;
+    }
+
+    *zone_idx = nvme_zone_idx(ns, *slba);
+    assert(*zone_idx < ns->num_zones);
+
+    return NVME_SUCCESS;
+}
+
+typedef uint16_t (*op_handler_t)(NvmeNamespace *, NvmeZone *,
+                                 uint8_t);
+
+enum NvmeZoneProcessingMask {
+    NVME_PROC_CURRENT_ZONE    = 0,
+    NVME_PROC_IMP_OPEN_ZONES  = 1 << 0,
+    NVME_PROC_EXP_OPEN_ZONES  = 1 << 1,
+    NVME_PROC_CLOSED_ZONES    = 1 << 2,
+    NVME_PROC_READ_ONLY_ZONES = 1 << 3,
+    NVME_PROC_FULL_ZONES      = 1 << 4,
+};
+
+static uint16_t nvme_open_zone(NvmeNamespace *ns, NvmeZone *zone,
+                               uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
+        /* fall through */
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static uint16_t nvme_close_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
+        /* fall through */
+    case NVME_ZONE_STATE_CLOSED:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                 uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_EMPTY:
+        zone->w_ptr = nvme_zone_wr_boundary(zone);
+        zone->d.wp = zone->w_ptr;
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
+        /* fall through */
+    case NVME_ZONE_STATE_FULL:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static uint16_t nvme_reset_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_FULL:
+        zone->w_ptr = zone->d.zslba;
+        zone->d.wp = zone->w_ptr;
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EMPTY);
+        /* fall through */
+    case NVME_ZONE_STATE_EMPTY:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                  uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_READ_ONLY:
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
+        /* fall through */
+    case NVME_ZONE_STATE_OFFLINE:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static uint16_t nvme_bulk_proc_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                    enum NvmeZoneProcessingMask proc_mask,
+                                    op_handler_t op_hndlr)
+{
+    uint16_t status = NVME_SUCCESS;
+    uint8_t zs = nvme_get_zone_state(zone);
+    bool proc_zone = false;
+
+    switch (zs) {
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        proc_zone = proc_mask & NVME_PROC_IMP_OPEN_ZONES;
+        break;
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        proc_zone = proc_mask & NVME_PROC_EXP_OPEN_ZONES;
+        break;
+    case NVME_ZONE_STATE_CLOSED:
+        proc_zone = proc_mask & NVME_PROC_CLOSED_ZONES;
+        break;
+    case NVME_ZONE_STATE_READ_ONLY:
+        proc_zone = proc_mask & NVME_PROC_READ_ONLY_ZONES;
+        break;
+    case NVME_ZONE_STATE_FULL:
+        proc_zone = proc_mask & NVME_PROC_FULL_ZONES;
+    }
+
+    if (proc_zone) {
+        status = op_hndlr(ns, zone, zs);
+    }
+
+    return status;
+}
+
+static uint16_t nvme_do_zone_op(NvmeNamespace *ns, NvmeZone *zone,
+                                enum NvmeZoneProcessingMask proc_mask,
+                                op_handler_t op_hndlr)
+{
+    NvmeZone *next;
+    uint16_t status = NVME_SUCCESS;
+    int i;
+
+    if (!proc_mask) {
+        status = op_hndlr(ns, zone, nvme_get_zone_state(zone));
+    } else {
+        if (proc_mask & NVME_PROC_CLOSED_ZONES) {
+            QTAILQ_FOREACH_SAFE(zone, &ns->closed_zones, entry, next) {
+                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr);
+                if (status != NVME_SUCCESS) {
+                    goto out;
+                }
+            }
+        }
+        if (proc_mask & NVME_PROC_IMP_OPEN_ZONES) {
+            QTAILQ_FOREACH_SAFE(zone, &ns->imp_open_zones, entry, next) {
+                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr);
+                if (status != NVME_SUCCESS) {
+                    goto out;
+                }
+            }
+        }
+        if (proc_mask & NVME_PROC_EXP_OPEN_ZONES) {
+            QTAILQ_FOREACH_SAFE(zone, &ns->exp_open_zones, entry, next) {
+                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr);
+                if (status != NVME_SUCCESS) {
+                    goto out;
+                }
+            }
+        }
+        if (proc_mask & NVME_PROC_FULL_ZONES) {
+            QTAILQ_FOREACH_SAFE(zone, &ns->full_zones, entry, next) {
+                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr);
+                if (status != NVME_SUCCESS) {
+                    goto out;
+                }
+            }
+        }
+
+        if (proc_mask & NVME_PROC_READ_ONLY_ZONES) {
+            for (i = 0; i < ns->num_zones; i++, zone++) {
+                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr);
+                if (status != NVME_SUCCESS) {
+                    goto out;
+                }
+            }
+        }
+    }
+
+out:
+    return status;
+}
+
+static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint64_t slba = 0;
+    uint32_t zone_idx = 0;
+    uint16_t status;
+    uint8_t action;
+    bool all;
+    enum NvmeZoneProcessingMask proc_mask = NVME_PROC_CURRENT_ZONE;
+
+    action = dw13 & 0xff;
+    all = dw13 & 0x100;
+
+    req->status = NVME_SUCCESS;
+
+    if (!all) {
+        status = nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
+        if (status) {
+            return status;
+        }
+    }
+
+    zone = &ns->zone_array[zone_idx];
+    if (slba != zone->d.zslba) {
+        trace_pci_nvme_err_unaligned_zone_cmd(action, slba, zone->d.zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (action) {
+
+    case NVME_ZONE_ACTION_OPEN:
+        if (all) {
+            proc_mask = NVME_PROC_CLOSED_ZONES;
+        }
+        trace_pci_nvme_open_zone(slba, zone_idx, all);
+        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_open_zone);
+        break;
+
+    case NVME_ZONE_ACTION_CLOSE:
+        if (all) {
+            proc_mask = NVME_PROC_IMP_OPEN_ZONES | NVME_PROC_EXP_OPEN_ZONES;
+        }
+        trace_pci_nvme_close_zone(slba, zone_idx, all);
+        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_close_zone);
+        break;
+
+    case NVME_ZONE_ACTION_FINISH:
+        if (all) {
+            proc_mask = NVME_PROC_IMP_OPEN_ZONES | NVME_PROC_EXP_OPEN_ZONES |
+                        NVME_PROC_CLOSED_ZONES;
+        }
+        trace_pci_nvme_finish_zone(slba, zone_idx, all);
+        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_finish_zone);
+        break;
+
+    case NVME_ZONE_ACTION_RESET:
+        if (all) {
+            proc_mask = NVME_PROC_IMP_OPEN_ZONES | NVME_PROC_EXP_OPEN_ZONES |
+                        NVME_PROC_CLOSED_ZONES | NVME_PROC_FULL_ZONES;
+        }
+        trace_pci_nvme_reset_zone(slba, zone_idx, all);
+        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_reset_zone);
+        break;
+
+    case NVME_ZONE_ACTION_OFFLINE:
+        if (all) {
+            proc_mask = NVME_PROC_READ_ONLY_ZONES;
+        }
+        trace_pci_nvme_offline_zone(slba, zone_idx, all);
+        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_offline_zone);
+        break;
+
+    case NVME_ZONE_ACTION_SET_ZD_EXT:
+        trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
+        return NVME_INVALID_FIELD | NVME_DNR;
+        break;
+
+    default:
+        trace_pci_nvme_err_invalid_mgmt_action(action);
+        status = NVME_INVALID_FIELD;
+    }
+
+    if (status == NVME_ZONE_INVAL_TRANSITION) {
+        trace_pci_nvme_err_invalid_zone_state_transition(action, slba,
+                                                         zone->d.za);
+    }
+    if (status) {
+        status |= NVME_DNR;
+    }
+
+    return status;
+}
+
+static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
+{
+    int zs = nvme_get_zone_state(zl);
+
+    switch (zafs) {
+    case NVME_ZONE_REPORT_ALL:
+        return true;
+    case NVME_ZONE_REPORT_EMPTY:
+        return zs == NVME_ZONE_STATE_EMPTY;
+    case NVME_ZONE_REPORT_IMPLICITLY_OPEN:
+        return zs == NVME_ZONE_STATE_IMPLICITLY_OPEN;
+    case NVME_ZONE_REPORT_EXPLICITLY_OPEN:
+        return zs == NVME_ZONE_STATE_EXPLICITLY_OPEN;
+    case NVME_ZONE_REPORT_CLOSED:
+        return zs == NVME_ZONE_STATE_CLOSED;
+    case NVME_ZONE_REPORT_FULL:
+        return zs == NVME_ZONE_STATE_FULL;
+    case NVME_ZONE_REPORT_READ_ONLY:
+        return zs == NVME_ZONE_STATE_READ_ONLY;
+    case NVME_ZONE_REPORT_OFFLINE:
+        return zs == NVME_ZONE_STATE_OFFLINE;
+    default:
+        return false;
+    }
+}
+
+static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    /* cdw12 is zero-based number of dwords to return. Convert to bytes */
+    uint32_t len = (le32_to_cpu(cmd->cdw12) + 1) << 2;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint32_t zone_idx, zra, zrasf, partial;
+    uint64_t max_zones, nr_zones = 0;
+    uint16_t ret;
+    uint64_t slba;
+    NvmeZoneDescr *z;
+    NvmeZone *zs;
+    NvmeZoneReportHeader *header;
+    void *buf, *buf_p;
+    size_t zone_entry_sz;
+
+    req->status = NVME_SUCCESS;
+
+    ret = nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
+    if (ret) {
+        return ret;
+    }
+
+    if (len < sizeof(NvmeZoneReportHeader)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zra = dw13 & 0xff;
+    if (!(zra == NVME_ZONE_REPORT || zra == NVME_ZONE_REPORT_EXTENDED)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zrasf = (dw13 >> 8) & 0xff;
+    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    partial = (dw13 >> 16) & 0x01;
+
+    zone_entry_sz = sizeof(NvmeZoneDescr);
+
+    max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
+    buf = g_malloc0(len);
+
+    header = (NvmeZoneReportHeader *)buf;
+    buf_p = buf + sizeof(NvmeZoneReportHeader);
+
+    while (zone_idx < ns->num_zones && nr_zones < max_zones) {
+        zs = &ns->zone_array[zone_idx];
+
+        if (!nvme_zone_matches_filter(zrasf, zs)) {
+            zone_idx++;
+            continue;
+        }
+
+        z = (NvmeZoneDescr *)buf_p;
+        buf_p += sizeof(NvmeZoneDescr);
+        nr_zones++;
+
+        z->zt = zs->d.zt;
+        z->zs = zs->d.zs;
+        z->zcap = cpu_to_le64(zs->d.zcap);
+        z->zslba = cpu_to_le64(zs->d.zslba);
+        z->za = zs->d.za;
+
+        if (nvme_wp_is_valid(zs)) {
+            z->wp = cpu_to_le64(zs->d.wp);
+        } else {
+            z->wp = cpu_to_le64(~0ULL);
+        }
+
+        zone_idx++;
+    }
+
+    if (!partial) {
+        for (; zone_idx < ns->num_zones; zone_idx++) {
+            zs = &ns->zone_array[zone_idx];
+            if (nvme_zone_matches_filter(zrasf, zs)) {
+                nr_zones++;
+            }
+        }
+    }
+    header->nr_zones = cpu_to_le64(nr_zones);
+
+    ret = nvme_dma(n, (uint8_t *)buf, len, DMA_DIRECTION_FROM_DEVICE, req);
+
+    g_free(buf);
+
+    return ret;
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
@@ -1097,11 +1953,17 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write(n, req, true);
+        return nvme_write(n, req, false, true);
+    case NVME_CMD_ZONE_APPEND:
+        return nvme_write(n, req, true, false);
     case NVME_CMD_WRITE:
-        return nvme_write(n, req, false);
+        return nvme_write(n, req, false, false);
     case NVME_CMD_READ:
         return nvme_read(n, req);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
     default:
         assert(false);
     }
@@ -1366,6 +2228,9 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
         case NVME_CSI_NVM:
             src_iocs = nvme_cse_iocs_nvm;
             break;
+        case NVME_CSI_ZONED:
+            src_iocs = nvme_cse_iocs_zoned;
+            break;
         }
     }
 
@@ -1546,6 +2411,16 @@ static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
     return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static inline bool nvme_csi_has_nvm_support(NvmeNamespace *ns)
+{
+    switch (ns->csi) {
+    case NVME_CSI_NVM:
+    case NVME_CSI_ZONED:
+        return true;
+    }
+    return false;
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_pci_nvme_identify_ctrl();
@@ -1557,11 +2432,16 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeIdCtrlZoned id = {};
 
     trace_pci_nvme_identify_ctrl_csi(c->csi);
 
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, req);
+    } else if (c->csi == NVME_CSI_ZONED) {
+        id.zasl = n->zasl;
+        return nvme_dma(n, (uint8_t *)&id, sizeof(id),
+                        DMA_DIRECTION_FROM_DEVICE, req);
     }
 
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -1589,8 +2469,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
         return nvme_rpt_empty_id_struct(n, req);
     }
 
-    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
-                    DMA_DIRECTION_FROM_DEVICE, req);
+    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
+        return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
+                        DMA_DIRECTION_FROM_DEVICE, req);
+    }
+
+    return NVME_INVALID_CMD_SET | NVME_DNR;
 }
 
 static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
@@ -1615,8 +2499,11 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
         return nvme_rpt_empty_id_struct(n, req);
     }
 
-    if (c->csi == NVME_CSI_NVM) {
+    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
         return nvme_rpt_empty_id_struct(n, req);
+    } else if (c->csi == NVME_CSI_ZONED && ns->csi == NVME_CSI_ZONED) {
+        return nvme_dma(n, (uint8_t *)ns->id_ns_zoned, sizeof(NvmeIdNsZoned),
+                        DMA_DIRECTION_FROM_DEVICE, req);
     }
 
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -1685,7 +2572,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (c->csi != NVME_CSI_NVM) {
+    if (c->csi != NVME_CSI_NVM && c->csi != NVME_CSI_ZONED) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1694,7 +2581,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
         if (!ns) {
             continue;
         }
-        if (ns->params.nsid <= min_nsid) {
+        if (ns->params.nsid <= min_nsid || c->csi != ns->csi) {
             continue;
         }
         if (only_active && !ns->attached) {
@@ -1764,6 +2651,8 @@ static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_identify_cmd_set();
 
     NVME_SET_CSI(*list, NVME_CSI_NVM);
+    NVME_SET_CSI(*list, NVME_CSI_ZONED);
+
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
@@ -1806,7 +2695,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.result32 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1991,7 +2880,7 @@ defaults:
     }
 
 out:
-    req->cqe.result = cpu_to_le32(result);
+    req->cqe.result32 = cpu_to_le32(result);
     return NVME_SUCCESS;
 }
 
@@ -2122,8 +3011,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                     ((dw11 >> 16) & 0xFFFF) + 1,
                                     n->params.max_ioqpairs,
                                     n->params.max_ioqpairs);
-        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                                      ((n->params.max_ioqpairs - 1) << 16));
+        req->cqe.result32 = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                        ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config = dw11;
@@ -2234,7 +3123,7 @@ static void nvme_process_sq(void *opaque)
     }
 }
 
-static void nvme_clear_ctrl(NvmeCtrl *n)
+static void nvme_clear_ctrl(NvmeCtrl *n, bool shutdown)
 {
     NvmeNamespace *ns;
     int i;
@@ -2278,6 +3167,17 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         nvme_ns_flush(ns);
     }
 
+    if (shutdown) {
+        for (i = 1; i <= n->num_namespaces; i++) {
+            ns = nvme_ns(n, i);
+            if (!ns) {
+                continue;
+            }
+
+            nvme_ns_shutdown(ns);
+        }
+    }
+
     n->bar.cc = 0;
 }
 
@@ -2298,6 +3198,13 @@ static void nvme_select_ns_iocs(NvmeCtrl *n)
                 ns->iocs = nvme_cse_iocs_nvm;
             }
             break;
+        case NVME_CSI_ZONED:
+            if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_CSI) {
+                ns->iocs = nvme_cse_iocs_zoned;
+            } else if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_NVM) {
+                ns->iocs = nvme_cse_iocs_nvm;
+            }
+            break;
         }
     }
 }
@@ -2396,6 +3303,17 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
                  NVME_AQA_ASQS(n->bar.aqa) + 1);
 
+    if (!n->params.zasl_bs) {
+        n->zasl = n->params.mdts;
+    } else {
+        if (n->params.zasl_bs < n->page_size) {
+            trace_pci_nvme_err_startfail_zasl_too_small(n->params.zasl_bs,
+                                                        n->page_size);
+            return -1;
+        }
+        n->zasl = 31 - clz32(n->params.zasl_bs / n->page_size);
+    }
+
     nvme_set_timestamp(n, 0ULL);
 
     QTAILQ_INIT(&n->aer_queue);
@@ -2468,12 +3386,12 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
             }
         } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
             trace_pci_nvme_mmio_stopped();
-            nvme_clear_ctrl(n);
+            nvme_clear_ctrl(n, false);
             n->bar.csts &= ~NVME_CSTS_READY;
         }
         if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
             trace_pci_nvme_mmio_shutdown_set();
-            nvme_clear_ctrl(n);
+            nvme_clear_ctrl(n, true);
             n->bar.cc = data;
             n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
         } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
@@ -2820,6 +3738,13 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
 
         host_memory_backend_set_mapped(n->pmrdev, true);
     }
+
+    if (n->params.zasl_bs) {
+        if (!is_power_of_2(n->params.zasl_bs)) {
+            error_setg(errp, "zone append size limit has to be a power of 2");
+            return;
+        }
+    }
 }
 
 static void nvme_init_state(NvmeCtrl *n)
@@ -3085,9 +4010,21 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 static void nvme_exit(PCIDevice *pci_dev)
 {
     NvmeCtrl *n = NVME(pci_dev);
+    NvmeNamespace *ns;
+    int i;
 
-    nvme_clear_ctrl(n);
+    nvme_clear_ctrl(n, true);
+
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nvme_ns_cleanup(ns);
+    }
     g_free(n->namespaces);
+
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
@@ -3115,6 +4052,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
+    DEFINE_PROP_SIZE32("zoned.append_size_limit", NvmeCtrl, params.zasl_bs,
+                       NVME_DEFAULT_MAX_ZA_SIZE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e080a2318a..4cb0615128 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,6 +6,9 @@
 
 #define NVME_MAX_NAMESPACES 256
 
+#define NVME_DEFAULT_ZONE_SIZE   (128 * MiB)
+#define NVME_DEFAULT_MAX_ZA_SIZE (128 * KiB)
+
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues; /* deprecated since 5.1 */
@@ -16,6 +19,7 @@ typedef struct NvmeParams {
     uint32_t aer_max_queued;
     uint8_t  mdts;
     bool     use_intel_id;
+    uint32_t zasl_bs;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -28,6 +32,8 @@ typedef struct NvmeRequest {
     struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
+    uint64_t                fill_off;
+    uint32_t                fill_len;
     NvmeCqe                 cqe;
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
@@ -147,6 +153,8 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
 
+    uint8_t     zasl;
+
     NvmeNamespace   namespace;
     NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 051e115f47..8f221ba73c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -89,6 +89,14 @@ pci_nvme_mmio_start_success(void) "setting controller enable bit succeeded"
 pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+pci_nvme_open_zone(uint64_t slba, uint32_t zone_idx, int all) "open zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_close_zone(uint64_t slba, uint32_t zone_idx, int all) "close zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_finish_zone(uint64_t slba, uint32_t zone_idx, int all) "finish zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_reset_zone(uint64_t slba, uint32_t zone_idx, int all) "reset zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_offline_zone(uint64_t slba, uint32_t zone_idx, int all) "offline zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_set_descriptor_extension(uint64_t slba, uint32_t zone_idx) "set zone descriptor extension, slba=%"PRIu64", idx=%"PRIu32""
+pci_nvme_clear_ns_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
+pci_nvme_clear_ns_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
@@ -109,7 +117,13 @@ pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
 pci_nvme_err_invalid_log_page_offset(uint64_t ofs, uint64_t size) "must be <= %"PRIu64", got %"PRIu64""
-pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_unaligned_zone_cmd(uint8_t action, uint64_t slba, uint64_t zslba) "unaligned zone op 0x%"PRIx32", got slba=%"PRIu64", zslba=%"PRIu64""
+pci_nvme_err_invalid_zone_state_transition(uint8_t action, uint64_t slba, uint8_t attrs) "action=0x%"PRIx8", slba=%"PRIu64", attrs=0x%"PRIx32""
+pci_nvme_err_write_not_at_wp(uint64_t slba, uint64_t zone, uint64_t wp) "writing at slba=%"PRIu64", zone=%"PRIu64", but wp=%"PRIu64""
+pci_nvme_err_append_not_at_start(uint64_t slba, uint64_t zone) "appending at slba=%"PRIu64", but zone=%"PRIu64""
+pci_nvme_err_zone_write_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
+pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
+pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zasl) "slba=%"PRIu64", nlb=%"PRIu32", zasl=%"PRIu8""
 pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
@@ -143,7 +157,9 @@ pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_
 pci_nvme_err_startfail_css(uint8_t css) "nvme_start_ctrl failed because invalid command set selected:%u"
 pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
 pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
+pci_nvme_err_startfail_zasl_too_small(uint32_t zasl, uint32_t pagesz) "nvme_start_ctrl failed because zone append size limit %"PRIu32" is too small, needs to be >= %"PRIu32""
 pci_nvme_err_startfail(void) "setting controller enable bit failed"
+pci_nvme_err_invalid_mgmt_action(int action) "action=0x%"PRIx8""
 
 # Traces for undefined behavior
 pci_nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 3653b4aefc..ba8a45edf5 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -489,6 +489,9 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
+    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
+    NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -649,8 +652,10 @@ typedef struct QEMU_PACKED NvmeAerResult {
 } NvmeAerResult;
 
 typedef struct QEMU_PACKED NvmeCqe {
-    uint32_t    result;
-    uint32_t    rsvd;
+    union {
+        uint64_t     result64;
+        uint32_t     result32;
+    };
     uint16_t    sq_head;
     uint16_t    sq_id;
     uint16_t    cid;
@@ -678,6 +683,7 @@ enum NvmeStatusCodes {
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
     NVME_CMD_SET_CMB_REJECTED   = 0x002b,
+    NVME_INVALID_CMD_SET        = 0x002c,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -702,6 +708,14 @@ enum NvmeStatusCodes {
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
+    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
+    NVME_ZONE_FULL              = 0x01b9,
+    NVME_ZONE_READ_ONLY         = 0x01ba,
+    NVME_ZONE_OFFLINE           = 0x01bb,
+    NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_ZONE_TOO_MANY_ACTIVE   = 0x01bd,
+    NVME_ZONE_TOO_MANY_OPEN     = 0x01be,
+    NVME_ZONE_INVAL_TRANSITION  = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -886,6 +900,11 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
     uint8_t     vs[1024];
 } NvmeIdCtrl;
 
+typedef struct NvmeIdCtrlZoned {
+    uint8_t     zasl;
+    uint8_t     rsvd1[4095];
+} NvmeIdCtrlZoned;
+
 enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
@@ -1011,6 +1030,12 @@ typedef struct QEMU_PACKED NvmeLBAF {
     uint8_t     rp;
 } NvmeLBAF;
 
+typedef struct QEMU_PACKED NvmeLBAFE {
+    uint64_t    zsze;
+    uint8_t     zdes;
+    uint8_t     rsvd9[7];
+} NvmeLBAFE;
+
 #define NVME_NSID_BROADCAST 0xffffffff
 
 typedef struct QEMU_PACKED NvmeIdNs {
@@ -1065,10 +1090,24 @@ enum NvmeNsIdentifierType {
 
 enum NvmeCsi {
     NVME_CSI_NVM                = 0x00,
+    NVME_CSI_ZONED              = 0x02,
 };
 
 #define NVME_SET_CSI(vec, csi) (vec |= (uint8_t)(1 << (csi)))
 
+typedef struct QEMU_PACKED NvmeIdNsZoned {
+    uint16_t    zoc;
+    uint16_t    ozcs;
+    uint32_t    mar;
+    uint32_t    mor;
+    uint32_t    rrl;
+    uint32_t    frl;
+    uint8_t     rsvd20[2796];
+    NvmeLBAFE   lbafe[16];
+    uint8_t     rsvd3072[768];
+    uint8_t     vs[256];
+} NvmeIdNsZoned;
+
 /*Deallocate Logical Block Features*/
 #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
 #define NVME_ID_NS_DLFEAT_WRITE_ZEROES(dlfeat)    ((dlfeat) & 0x08)
@@ -1100,6 +1139,71 @@ enum NvmeIdNsDps {
     DPS_FIRST_EIGHT = 8,
 };
 
+enum NvmeZoneAttr {
+    NVME_ZA_FINISHED_BY_CTLR         = 1 << 0,
+    NVME_ZA_FINISH_RECOMMENDED       = 1 << 1,
+    NVME_ZA_RESET_RECOMMENDED        = 1 << 2,
+    NVME_ZA_ZD_EXT_VALID             = 1 << 7,
+};
+
+typedef struct QEMU_PACKED NvmeZoneReportHeader {
+    uint64_t    nr_zones;
+    uint8_t     rsvd[56];
+} NvmeZoneReportHeader;
+
+enum NvmeZoneReceiveAction {
+    NVME_ZONE_REPORT                 = 0,
+    NVME_ZONE_REPORT_EXTENDED        = 1,
+};
+
+enum NvmeZoneReportType {
+    NVME_ZONE_REPORT_ALL             = 0,
+    NVME_ZONE_REPORT_EMPTY           = 1,
+    NVME_ZONE_REPORT_IMPLICITLY_OPEN = 2,
+    NVME_ZONE_REPORT_EXPLICITLY_OPEN = 3,
+    NVME_ZONE_REPORT_CLOSED          = 4,
+    NVME_ZONE_REPORT_FULL            = 5,
+    NVME_ZONE_REPORT_READ_ONLY       = 6,
+    NVME_ZONE_REPORT_OFFLINE         = 7,
+};
+
+enum NvmeZoneType {
+    NVME_ZONE_TYPE_RESERVED          = 0x00,
+    NVME_ZONE_TYPE_SEQ_WRITE         = 0x02,
+};
+
+enum NvmeZoneSendAction {
+    NVME_ZONE_ACTION_RSD             = 0x00,
+    NVME_ZONE_ACTION_CLOSE           = 0x01,
+    NVME_ZONE_ACTION_FINISH          = 0x02,
+    NVME_ZONE_ACTION_OPEN            = 0x03,
+    NVME_ZONE_ACTION_RESET           = 0x04,
+    NVME_ZONE_ACTION_OFFLINE         = 0x05,
+    NVME_ZONE_ACTION_SET_ZD_EXT      = 0x10,
+};
+
+typedef struct QEMU_PACKED NvmeZoneDescr {
+    uint8_t     zt;
+    uint8_t     zs;
+    uint8_t     za;
+    uint8_t     rsvd3[5];
+    uint64_t    zcap;
+    uint64_t    zslba;
+    uint64_t    wp;
+    uint8_t     rsvd32[32];
+} NvmeZoneDescr;
+
+enum NvmeZoneState {
+    NVME_ZONE_STATE_RESERVED         = 0x00,
+    NVME_ZONE_STATE_EMPTY            = 0x01,
+    NVME_ZONE_STATE_IMPLICITLY_OPEN  = 0x02,
+    NVME_ZONE_STATE_EXPLICITLY_OPEN  = 0x03,
+    NVME_ZONE_STATE_CLOSED           = 0x04,
+    NVME_ZONE_STATE_READ_ONLY        = 0x0D,
+    NVME_ZONE_STATE_FULL             = 0x0E,
+    NVME_ZONE_STATE_OFFLINE          = 0x0F,
+};
+
 static inline void _nvme_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
@@ -1119,8 +1223,13 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescr) != 64);
 }
 #endif
-- 
2.21.0


