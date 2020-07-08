Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E71C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AD2206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWXytScK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AD2206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtItX-0001J4-BN
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jtIRW-0001bt-HJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:21:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jtIRU-00013F-Im
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORtXaORAZvQ0FiGFQY6UNSXnMhzRO3u0ST4KF1uT+ig=;
 b=DWXytScKbF+OYhJcxJg6p9tEY3oGBwT0eCDQLKdTm4HVc8NsGeoF7O0fxwOCFY1zyqhYQK
 qf73MZHZysT3qHXcMrNaU3o0gfrsfcSjxyLcLmwanCpUHkedtWMsyu8zx9HTYOdEGPd8L+
 ikZi2sRhvdh7HPQ1rIIVDnewlgmiVJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-tzR9GnK1M5ituDVEzAwFsA-1; Wed, 08 Jul 2020 10:19:36 -0400
X-MC-Unique: tzR9GnK1M5ituDVEzAwFsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 876C719057A0;
 Wed,  8 Jul 2020 14:19:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C5B75BAC3;
 Wed,  8 Jul 2020 14:19:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH v3 04/11] hw/arm/smmu: Introduce SMMUTLBEntry for PTW and
 IOTLB value
Date: Wed,  8 Jul 2020 16:18:49 +0200
Message-Id: <20200708141856.15776-5-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-1-eric.auger@redhat.com>
References: <20200708141856.15776-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: jean-philippe@linaro.org, robh@kernel.org, robin.murphy@arm.com,
 mst@redhat.com, zhangfei.gao@foxmail.com, shameerali.kolothum.thodi@huawei.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a specialized SMMUTLBEntry to store the result of
the PTW and cache in the IOTLB. This structure extends the
generic IOMMUTLBEntry struct with the level of the entry and
the granule size.

Those latter will be useful when implementing range invalidation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v1 -> v2:
- fix 2 indents and typdef
- added Peter's R-b
---
 include/hw/arm/smmu-common.h | 12 +++++++++---
 hw/arm/smmu-common.c         | 32 +++++++++++++++++---------------
 hw/arm/smmuv3.c              | 10 +++++-----
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5f9f3535d2..79c2c6486a 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -52,6 +52,12 @@ typedef struct SMMUTransTableInfo {
     uint8_t granule_sz;        /* granule page shift */
 } SMMUTransTableInfo;
 
+typedef struct SMMUTLBEntry {
+    IOMMUTLBEntry entry;
+    uint8_t level;
+    uint8_t granule;
+} SMMUTLBEntry;
+
 /*
  * Generic structure populated by derived SMMU devices
  * after decoding the configuration information and used as
@@ -140,7 +146,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * pair, according to @cfg translation config
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
 
 /**
  * select_tt - compute which translation table shall be used according to
@@ -153,8 +159,8 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
-IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry);
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7dc8541e8b..398e958bb4 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -64,11 +64,11 @@ SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
     return key;
 }
 
-IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                 hwaddr iova)
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                hwaddr iova)
 {
     SMMUIOTLBKey key = smmu_get_iotlb_key(cfg->asid, iova);
-    IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
+    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -86,7 +86,7 @@ IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
     return entry;
 }
 
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
 {
     SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
 
@@ -94,9 +94,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
         smmu_iotlb_inv_all(bs);
     }
 
-    *key = smmu_get_iotlb_key(cfg->asid, entry->iova);
-    trace_smmu_iotlb_insert(cfg->asid, entry->iova);
-    g_hash_table_insert(bs->iotlb, key, entry);
+    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova);
+    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova);
+    g_hash_table_insert(bs->iotlb, key, new);
 }
 
 inline void smmu_iotlb_inv_all(SMMUState *s)
@@ -216,7 +216,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  * @cfg: translation config
  * @iova: iova to translate
  * @perm: access type
- * @tlbe: IOMMUTLBEntry (out)
+ * @tlbe: SMMUTLBEntry (out)
  * @info: handle to an error info
  *
  * Return 0 on success, < 0 on error. In case of error, @info is filled
@@ -226,7 +226,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  */
 static int smmu_ptw_64(SMMUTransCfg *cfg,
                        dma_addr_t iova, IOMMUAccessFlags perm,
-                       IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                       SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     dma_addr_t baseaddr, indexmask;
     int stage = cfg->stage;
@@ -246,8 +246,8 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
     baseaddr = extract64(tt->ttb, 0, 48);
     baseaddr &= ~indexmask;
 
-    tlbe->iova = iova;
-    tlbe->addr_mask = (1 << granule_sz) - 1;
+    tlbe->entry.iova = iova;
+    tlbe->entry.addr_mask = (1 << granule_sz) - 1;
 
     while (level <= 3) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
@@ -298,14 +298,16 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
             goto error;
         }
 
-        tlbe->translated_addr = gpa + (iova & mask);
-        tlbe->perm = PTE_AP_TO_PERM(ap);
+        tlbe->entry.translated_addr = gpa + (iova & mask);
+        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
+        tlbe->level = level;
+        tlbe->granule = granule_sz;
         return 0;
     }
     info->type = SMMU_PTW_ERR_TRANSLATION;
 
 error:
-    tlbe->perm = IOMMU_NONE;
+    tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
 
@@ -321,7 +323,7 @@ error:
  * return 0 on success
  */
 inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                    SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     if (!cfg->aa64) {
         /*
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cd2a2e7e14..db74d27add 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -626,7 +626,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUTranslationStatus status;
     SMMUState *bs = ARM_SMMU(s);
     uint64_t page_mask, aligned_addr;
-    IOMMUTLBEntry *cached_entry = NULL;
+    SMMUTLBEntry *cached_entry = NULL;
     SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
@@ -676,7 +676,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     cached_entry = smmu_iotlb_lookup(bs, cfg, aligned_addr);
     if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->perm & IOMMU_WO)) {
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
             if (event.record_trans_faults) {
                 event.type = SMMU_EVT_F_PERMISSION;
@@ -689,7 +689,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    cached_entry = g_new0(IOMMUTLBEntry, 1);
+    cached_entry = g_new0(SMMUTLBEntry, 1);
 
     if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
         g_free(cached_entry);
@@ -743,9 +743,9 @@ epilogue:
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = flag;
-        entry.translated_addr = cached_entry->translated_addr +
+        entry.translated_addr = cached_entry->entry.translated_addr +
                                     (addr & page_mask);
-        entry.addr_mask = cached_entry->addr_mask;
+        entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm);
         break;
-- 
2.21.3


