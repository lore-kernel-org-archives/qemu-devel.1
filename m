Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6066FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4095B255D8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4095B255D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpyYW-0005ii-G2
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 14:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpyUi-0008Oo-Ez; Mon, 29 Jun 2020 14:27:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:45920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpyUe-0000cG-Jd; Mon, 29 Jun 2020 14:27:04 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 0329EBF804;
 Mon, 29 Jun 2020 18:26:55 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 08/17] hw/block/nvme: move NvmeFeatureVal into hw/block/nvme.h
Date: Mon, 29 Jun 2020 20:26:33 +0200
Message-Id: <20200629182642.1170387-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629182642.1170387-1-its@irrelevant.dk>
References: <20200629182642.1170387-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The NvmeFeatureVal does not belong with the spec-related data structures
in include/block/nvme.h that is shared between the block-level nvme
driver and the emulated nvme device.

Move it into the nvme device specific header file as it is the only
user of the structure. Also, remove the unused members.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h      | 11 +++++++++++
 include/block/nvme.h | 20 --------------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1f64a0e94035..16a254d30b4e 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -79,6 +79,17 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
 
+typedef struct NvmeFeatureVal {
+    union {
+        struct {
+            uint16_t temp_thresh_hi;
+            uint16_t temp_thresh_low;
+        };
+        uint32_t temp_thresh;
+    };
+    uint32_t    async_config;
+} NvmeFeatureVal;
+
 typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
     MemoryRegion iomem;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index e98584e38134..c9f232a70e98 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -865,26 +865,6 @@ enum NvmeIdCtrlLpa {
 #define NVME_CTRL_SGLS_MPTR_SGL                  (0x1 << 19)
 #define NVME_CTRL_SGLS_ADDR_OFFSET               (0x1 << 20)
 
-typedef struct NvmeFeatureVal {
-    uint32_t    arbitration;
-    uint32_t    power_mgmt;
-    union {
-        struct {
-            uint16_t temp_thresh_hi;
-            uint16_t temp_thresh_low;
-        };
-        uint32_t temp_thresh;
-    };
-    uint32_t    err_rec;
-    uint32_t    volatile_wc;
-    uint32_t    num_queues;
-    uint32_t    int_coalescing;
-    uint32_t    *int_vector_config;
-    uint32_t    write_atomicity;
-    uint32_t    async_config;
-    uint32_t    sw_prog_marker;
-} NvmeFeatureVal;
-
 #define NVME_ARB_AB(arb)    (arb & 0x7)
 #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
 #define NVME_ARB_MPW(arb)   ((arb >> 16) & 0xff)
-- 
2.27.0


