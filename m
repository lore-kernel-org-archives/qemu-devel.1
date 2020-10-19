Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B964122268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="msJms2Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B964122268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKqO-0007oE-Ed
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKkE-0008On-7h; Sun, 18 Oct 2020 22:17:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKkC-0004J9-3M; Sun, 18 Oct 2020 22:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603073871; x=1634609871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HYiq0JK4dRwQV6ig2IjA1t2BEXwoUc+F9PcNVyweUws=;
 b=msJms2Izm925U7bqSu+3Lazb8y7xDCW2VCnlTurd6D7p1dZNUAWafPd5
 U227NkQWoIq+jSVuQQCeDlQQMolwS9aB/YrHhVNygJp2lh5LMdVIStCqE
 N9ezna07gwLchrsLFLrlt8getAJX3nTbO9kGKFpTjiFgv5E/0yD+sQo7w
 XIuttrPm/g/jwNsD2a+5UUjtuHwf1DAKdTiHHF8rHGv9bm0Q81jJ+f/Tv
 YxwCGl+JmFfuMH/g4qoAU6KkZLgfkjLdoQDV8Vd4C471Xhljn5sQ7rvoK
 9LjLsDuiE64nPubMxoB/WD/WwkKmU4GnaDlD5+B3+I7tusxgaTmfnvOTA w==;
IronPort-SDR: FsmNeb69ZFxZYKL3Z2Z9yzuLuTsDrv+JvN+zJs1gpZijrRPlspDrZcar8bmkorGZujH9/OkbWE
 8QjquNVmiFwvscs5RD1m8uHclUHQ97Yu2yAwLmlEz+dQy1blUlfynL2WNlurF45UnJhwJL+hQ+
 ZR267oCGd/aR+wL6Fri/RGe0asVu5pm57qAnl+R/cSgXvMPjn7e6Vsoq/+omlR3yQRQ231cq6c
 7nSxDZfmpPIKa7a7OBGnQmUep3ShUt2hFFpD4C4zAu+f3rRBHz2kaagtsI6GVPOLmC+YfE4Do7
 1ao=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="150207976"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:17:50 +0800
IronPort-SDR: wav4xIBMmHyvArpl5pgdNYHT/kL3nCPO4ECZgNev8AEbFyRAnmyy3xABCrABqAZkp0xaXTgATj
 55gjhQ+y1PksQABjnSaj/xTkpigVEmOLcntKUiMALHDeDRjI9vRoyzWxNESp73jqrC7i4bLdFq
 zAs6x84mdvfos1c2cv42DZJUIyniQ9et7ZLahVEAmCAcElvmERlrTNa4Y6Cq3M6VQjr03A6w1k
 1JKI3/0RYHNDSgPQPqUeiy4J7PsLp1N0GNixGpq7jWFRQ0oXyiw1l/E1peDHxfs9WgNpDbdeeA
 otq9j0dnbVGHvOluUg01E+Ib
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2020 19:03:26 -0700
IronPort-SDR: atd1TVTUxlUIzz5o8ef3FqSty+xO3GodPySPuxgeHyFfFgVR4Ro5o1wZPaf5smfhydpT1/UnB0
 Ha34WpkhpNOJJIRS26vwlE0dvW12/Xb6CiaAvlDRANjZWWNlkfCpj8kBmk/Ub9AFiQub2OSkSz
 0lgBdqUVhcmB/ikinJruQzcwln0yd86JHbUkTJb76WWBnOvuStDonkMraItTRPw27YxkLYG90C
 mleirg659U+cXe3D9JOVqXfX043l6DOGNpKo0OoyuUefey4vZTq2hI0lmwz5YXQrFeKSfnFmLj
 PS0=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Oct 2020 19:17:48 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v7 08/11] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Mon, 19 Oct 2020 11:17:23 +0900
Message-Id: <20201019021726.12048-9-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5541069a6=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:17:33
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

ZNS specification defines two zone conditions for the zones that no
longer can function properly, possibly because of flash wear or other
internal fault. It is useful to be able to "inject" a small number of
such zones for testing purposes.

This commit defines two optional device properties, "offline_zones"
and "rdonly_zones". Users can assign non-zero values to these variables
to specify the number of zones to be initialized as Offline or
Read-Only. The actual number of injected zones may be smaller than the
requested amount - Read-Only and Offline counts are expected to be much
smaller than the total number of zones on a drive.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme-ns.h |  2 ++
 2 files changed, 66 insertions(+)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 255ded2b43..d050f97909 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -21,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "crypto/random.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
@@ -132,6 +133,32 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    if (ns->params.zd_extension_size) {
+        if (ns->params.zd_extension_size & 0x3f) {
+            error_setg(errp,
+                "zone descriptor extension size must be a multiple of 64B");
+            return -1;
+        }
+        if ((ns->params.zd_extension_size >> 6) > 0xff) {
+            error_setg(errp, "zone descriptor extension size is too large");
+            return -1;
+        }
+    }
+
+    if (ns->params.max_open_zones < nz) {
+        if (ns->params.nr_offline_zones > nz - ns->params.max_open_zones) {
+            error_setg(errp, "offline_zones value %u is too large",
+                ns->params.nr_offline_zones);
+            return -1;
+        }
+        if (ns->params.nr_rdonly_zones >
+            nz - ns->params.max_open_zones - ns->params.nr_offline_zones) {
+            error_setg(errp, "rdonly_zones value %u is too large",
+                ns->params.nr_rdonly_zones);
+            return -1;
+        }
+    }
+
     return 0;
 }
 
@@ -140,7 +167,9 @@ static void nvme_init_zone_state(NvmeNamespace *ns)
     uint64_t start = 0, zone_size = ns->zone_size;
     uint64_t capacity = ns->num_zones * zone_size;
     NvmeZone *zone;
+    uint32_t rnd;
     int i;
+    uint16_t zs;
 
     ns->zone_array = g_malloc0(ns->zone_array_size);
     if (ns->params.zd_extension_size) {
@@ -167,6 +196,37 @@ static void nvme_init_zone_state(NvmeNamespace *ns)
         zone->w_ptr = start;
         start += zone_size;
     }
+
+    /* If required, make some zones Offline or Read Only */
+
+    for (i = 0; i < ns->params.nr_offline_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), NULL);
+            rnd %= ns->num_zones;
+        } while (rnd < ns->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_OFFLINE);
+        } else {
+            i--;
+        }
+    }
+
+    for (i = 0; i < ns->params.nr_rdonly_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), NULL);
+            rnd %= ns->num_zones;
+        } while (rnd < ns->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE &&
+            zs != NVME_ZONE_STATE_READ_ONLY) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_READ_ONLY);
+        } else {
+            i--;
+        }
+    }
 }
 
 static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
@@ -360,6 +420,10 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("max_open", NvmeNamespace, params.max_open_zones, 0),
     DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeNamespace,
                        params.zd_extension_size, 0),
+    DEFINE_PROP_UINT32("offline_zones", NvmeNamespace,
+                       params.nr_offline_zones, 0),
+    DEFINE_PROP_UINT32("rdonly_zones", NvmeNamespace,
+                       params.nr_rdonly_zones, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 2d70a13701..d65d8b0930 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -37,6 +37,8 @@ typedef struct NvmeNamespaceParams {
     uint32_t max_active_zones;
     uint32_t max_open_zones;
     uint32_t zd_extension_size;
+    uint32_t nr_offline_zones;
+    uint32_t nr_rdonly_zones;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
-- 
2.21.0


