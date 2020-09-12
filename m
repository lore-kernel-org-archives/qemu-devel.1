Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE67C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE9C20770
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nE/jjvSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE9C20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEYl-0005Bd-Mp
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQc-0004vi-Op; Sat, 12 Sep 2020 18:55:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQa-0005f4-2F; Sat, 12 Sep 2020 18:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599951327; x=1631487327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fe7FRRGcF+PM1kLw/MifPE71wdqaWcMDdZBdLsZIvO8=;
 b=nE/jjvSS4FOY4Yei+0n63+qpqRoqWDnkeFnmTHMfDd277LlIrlB8z6MI
 9gO/0vM1kY76TJXDyfKOVedfY+vHxzDpS6jRtoPyYhJ+x2aTxV6MppdyM
 0LNAQyGz7sKbj6rePBrJSn2anBJPgTQSx5XNIc3tVYBMAEac05BKrgw2O
 cuUaBur3rrc82AB3fMYOKtv/rV9EKdp6RFAEPGSu+7qtMjcRZNmV0QnvW
 DTAZB1/NiTHFbfjk8Vv/F34dhlbzpffZmv/5L2NLctGbAQCVTPWcCAWjI
 ZXxpJK9ZZy8cU9MhtrkVqjlAPxoFxtL4pY/YFSpUP+ZdGMAcxmBglKfNG Q==;
IronPort-SDR: rTXXkeh80pabVRHjnD1UrdfaQ91w7SnpsTRgpNjX/bySrXbkYCZBFP+Gxuzd58pt/indNTRVLd
 dwIdx6KKl/w4k0k/VC3Fe+iqO0XFPENqXse9S020ErHEanU+7xQNAOd0ijKFPpL1DDjzgBjByj
 zF45CYBQ9Kfg6Khg4tWoBh8TT3YyLdzuxKo76o18vB6t1s/mRAfPK6NqQQ1J3JNYQXm2VPc/gy
 H0JnLY+fLqxc4iIrVTxuPxM56yg/0YnyyNgb2Pn2YtUH0F9q0KQ3G2fQfIdmo4zusvMW5pHpP+
 X8I=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; d="scan'208";a="256834867"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2020 06:55:05 +0800
IronPort-SDR: APIhFRTGdaEbsiiJhWEmzkDR4z57dsCVFg8Am78Po5FvO3lc0/VQooUwWjgl8/3+0ky/asNGwV
 n/gOfP6S/OTg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 15:41:26 -0700
IronPort-SDR: Wur8w/eGWIuuW6RHucMXkh8Fyue5XoqJvOmWCWoyKK4XGOHG7nmHVqsTfdkVs16Lmx5Wdxvgr0
 dM34yty1Pj8Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2020 15:55:05 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 13/15] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Sun, 13 Sep 2020 07:54:28 +0900
Message-Id: <20200912225430.1772-14-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=517336518=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 18:54:38
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
 hw/block/nvme.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ec7fade674..f0a03bea75 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -3361,8 +3361,11 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
                                uint64_t capacity)
 {
     NvmeZone *zone;
+    Error *err;
     uint64_t start = 0, zone_size = n->zone_size;
+    uint32_t rnd;
     int i;
+    uint16_t zs;
 
     ns->zone_array = g_malloc0(n->zone_array_size);
     ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
@@ -3392,6 +3395,37 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
         start += zone_size;
     }
 
+    /* If required, make some zones Offline or Read Only */
+
+    for (i = 0; i < n->params.nr_offline_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), &err);
+            rnd %= n->num_zones;
+        } while (rnd < n->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_OFFLINE);
+        } else {
+            i--;
+        }
+    }
+
+    for (i = 0; i < n->params.nr_rdonly_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), &err);
+            rnd %= n->num_zones;
+        } while (rnd < n->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE &&
+            zs != NVME_ZONE_STATE_READ_ONLY) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_READ_ONLY);
+        } else {
+            i--;
+        }
+    }
+
     return 0;
 }
 
@@ -3440,6 +3474,16 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
                     " adjusting", n->params.max_active_zones, nz);
         n->params.max_active_zones = nz;
     }
+    if (n->params.max_open_zones < nz) {
+        if (n->params.nr_offline_zones > nz - n->params.max_open_zones) {
+            n->params.nr_offline_zones = nz - n->params.max_open_zones;
+        }
+        if (n->params.nr_rdonly_zones >
+            nz - n->params.max_open_zones - n->params.nr_offline_zones) {
+            n->params.nr_rdonly_zones =
+                nz - n->params.max_open_zones - n->params.nr_offline_zones;
+        }
+    }
     if (n->params.zd_extension_size) {
         if (n->params.zd_extension_size & 0x3f) {
             error_setg(errp,
@@ -3872,6 +3916,8 @@ static Property nvme_props[] = {
                        params.zd_extension_size, 0),
     DEFINE_PROP_UINT32("max_active", NvmeCtrl, params.max_active_zones, 0),
     DEFINE_PROP_UINT32("max_open", NvmeCtrl, params.max_open_zones, 0),
+    DEFINE_PROP_UINT32("offline_zones", NvmeCtrl, params.nr_offline_zones, 0),
+    DEFINE_PROP_UINT32("rdonly_zones", NvmeCtrl, params.nr_rdonly_zones, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
     DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e53388ba66..9a5f4787b7 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -25,6 +25,8 @@ typedef struct NvmeParams {
     uint32_t    max_active_zones;
     uint32_t    max_open_zones;
     uint32_t    zd_extension_size;
+    uint32_t    nr_offline_zones;
+    uint32_t    nr_rdonly_zones;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
-- 
2.21.0


