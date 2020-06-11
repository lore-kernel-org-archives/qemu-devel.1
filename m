Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51883C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E928206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6JrGm1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E928206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ0Y-0006E7-9O
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPu9-0004vU-N6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:18:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPu6-0004Ov-1k
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28JeEQFaQKpR65Fvr4h2OzB54px8vEV5aJWYpQDbyYY=;
 b=A6JrGm1Aim3ODIY0dbvZAfhak+d63vkxUxKbdCsVj/Q3+sdVXAi/U5WRI5hKEcoQTMmw4F
 c0C5fw/TU9rkzzj34XAZfgrLE1AyYKv0+HEIRMvhHgRBKBExToN8Olpx1IU3Hq/r4YME3B
 AknH2/ja77eFGEaH+vtwv0LlR3yN86A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-j1qPeplNO-WOBUzKwyxE3A-1; Thu, 11 Jun 2020 12:16:08 -0400
X-MC-Unique: j1qPeplNO-WOBUzKwyxE3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6228A107ACCA;
 Thu, 11 Jun 2020 16:16:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 067B010013C2;
 Thu, 11 Jun 2020 16:16:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 8/9] hw/arm/smmuv3: Get prepared for range invalidation
Date: Thu, 11 Jun 2020 18:14:59 +0200
Message-Id: <20200611161500.23580-9-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-1-eric.auger@redhat.com>
References: <20200611161500.23580-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jean-philippe@linaro.org, robh@kernel.org, robin.murphy@arm.com,
 mst@redhat.com, zhangfei.gao@foxmail.com, shameerali.kolothum.thodi@huawei.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enhance the smmu_iotlb_inv_iova() helper with range invalidation.
This uses the new fields passed in the NH_VA and NH_VAA commands:
the size of the range, the level and the granule.

As NH_VA and NH_VAA both use those fields, their decoding and
handling is factorized in a new smmuv3_s1_range_inval() helper.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h     |  4 +++
 include/hw/arm/smmu-common.h |  3 +-
 hw/arm/smmu-common.c         | 28 ++++++++++++----
 hw/arm/smmuv3.c              | 64 +++++++++++++++++++++++-------------
 hw/arm/trace-events          |  4 +--
 5 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 4112394129..5babf72f7d 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -298,6 +298,8 @@ enum { /* Command completion notification */
 };
 
 #define CMD_TYPE(x)         extract32((x)->word[0], 0 , 8)
+#define CMD_NUM(x)          extract32((x)->word[0], 12 , 5)
+#define CMD_SCALE(x)        extract32((x)->word[0], 20 , 5)
 #define CMD_SSEC(x)         extract32((x)->word[0], 10, 1)
 #define CMD_SSV(x)          extract32((x)->word[0], 11, 1)
 #define CMD_RESUME_AC(x)    extract32((x)->word[0], 12, 1)
@@ -310,6 +312,8 @@ enum { /* Command completion notification */
 #define CMD_RESUME_STAG(x)  extract32((x)->word[2], 0 , 16)
 #define CMD_RESP(x)         extract32((x)->word[2], 11, 2)
 #define CMD_LEAF(x)         extract32((x)->word[2], 0 , 1)
+#define CMD_TTL(x)          extract32((x)->word[2], 8 , 2)
+#define CMD_TG(x)           extract32((x)->word[2], 10, 2)
 #define CMD_STE_RANGE(x)    extract32((x)->word[2], 0 , 5)
 #define CMD_ADDR(x) ({                                        \
             uint64_t high = (uint64_t)(x)->word[3];           \
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 34a13c7cd6..6dd638a485 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -164,7 +164,8 @@ uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
                             uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova);
+void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
 
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 27804fbb2d..0a86afe69d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -125,18 +125,34 @@ static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
 
     if (info->asid >= 0) {
         return (info->asid == SMMU_IOTLB_ASID(*iotlb_key)) &&
-                ((info->iova & ~entry->addr_mask) == entry->iova);
+               (((entry->iova & ~info->mask) == info->iova) ||
+               ((info->iova & ~entry->addr_mask) ==  entry->iova));
     } else {
-        return (info->iova & ~entry->addr_mask) == entry->iova;
+        return (((entry->iova & ~info->mask) == info->iova) ||
+               ((info->iova & ~entry->addr_mask) ==  entry->iova));
     }
 }
 
-inline void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova)
+inline void
+smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
+                    uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
-    SMMUIOTLBPageInvInfo info = {.asid = asid, .iova = iova};
+    if (ttl && (num_pages == 1)) {
+        uint64_t key = smmu_get_iotlb_key(asid, iova, tg, ttl);
 
-    trace_smmu_iotlb_inv_iova(asid, iova);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_iova, &info);
+        g_hash_table_remove(s->iotlb, &key);
+    } else {
+            /* if tg is not set we use 4KB range invalidation */
+            uint8_t granule = tg ? tg * 2 + 10 : 12;
+
+            SMMUIOTLBPageInvInfo info = {
+                 .asid = asid, .iova = iova,
+                 .mask = (num_pages * 1 << granule) - 1};
+
+            g_hash_table_foreach_remove(s->iotlb,
+                                        smmu_hash_remove_by_asid_iova,
+                                        &info);
+    }
 }
 
 inline void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4eda16be7b..4dff438809 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -789,42 +789,49 @@ epilogue:
  * @n: notifier to be called
  * @asid: address space ID or negative value if we don't care
  * @iova: iova
+ * @tg: translation granule (if communicated through range invalidation)
+ * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
-                               int asid,
-                               dma_addr_t iova)
+                               int asid, dma_addr_t iova,
+                               uint8_t tg, uint64_t num_pages)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
-    SMMUEventInfo event = {.inval_ste_allowed = true};
-    SMMUTransTableInfo *tt;
-    SMMUTransCfg *cfg;
     IOMMUTLBEntry entry;
+    uint8_t granule = tg;
 
-    cfg = smmuv3_get_config(sdev, &event);
-    if (!cfg) {
-        return;
-    }
+    if (!tg) {
+        SMMUEventInfo event = {.inval_ste_allowed = true};
+        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &event);
+        SMMUTransTableInfo *tt;
 
-    if (asid >= 0 && cfg->asid != asid) {
-        return;
-    }
+        if (!cfg) {
+            return;
+        }
 
-    tt = select_tt(cfg, iova);
-    if (!tt) {
-        return;
+        if (asid >= 0 && cfg->asid != asid) {
+            return;
+        }
+
+        tt = select_tt(cfg, iova);
+        if (!tt) {
+            return;
+        }
+        granule = tt->granule_sz;
     }
 
     entry.target_as = &address_space_memory;
     entry.iova = iova;
-    entry.addr_mask = (1 << tt->granule_sz) - 1;
+    entry.addr_mask = num_pages * (1 << granule) - 1;
     entry.perm = IOMMU_NONE;
 
     memory_region_notify_one(n, &entry);
 }
 
-/* invalidate an asid/iova tuple in all mr's */
-static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
+/* invalidate an asid/iova range tuple in all mr's */
+static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
+                                      uint8_t tg, uint64_t num_pages)
 {
     SMMUDevice *sdev;
 
@@ -832,28 +839,39 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
         IOMMUMemoryRegion *mr = &sdev->iommu;
         IOMMUNotifier *n;
 
-        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova);
+        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova,
+                                        tg, num_pages);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, iova);
+            smmuv3_notify_iova(mr, n, asid, iova, tg, num_pages);
         }
     }
 }
 
 static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
 {
+    uint8_t scale = 0, num = 0, ttl = 0;
     dma_addr_t addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
     uint16_t vmid = CMD_VMID(cmd);
     bool leaf = CMD_LEAF(cmd);
+    uint8_t tg = CMD_TG(cmd);
+    hwaddr num_pages = 1;
     int asid = -1;
 
+    if (tg) {
+        scale = CMD_SCALE(cmd);
+        num = CMD_NUM(cmd);
+        ttl = CMD_TTL(cmd);
+        num_pages = (num + 1) * (1 << (scale));
+    }
+
     if (type == SMMU_CMD_TLBI_NH_VA) {
         asid = CMD_ASID(cmd);
     }
-    trace_smmuv3_s1_range_inval(vmid, asid, addr, leaf);
-    smmuv3_inv_notifiers_iova(s, asid, addr);
-    smmu_iotlb_inv_iova(s, asid, addr);
+    trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
+    smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
+    smmu_iotlb_inv_iova(s, asid, addr, tg, num_pages, ttl);
 }
 
 static int smmuv3_cmdq_consume(SMMUv3State *s)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index b366973739..c47943f1c7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -45,11 +45,11 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
+smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova) "iommu mr=%s asid=%d iova=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
-- 
2.20.1


