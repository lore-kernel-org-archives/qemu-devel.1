Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1436C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7DF206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/j5XiAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7DF206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPv3-0004xX-P2
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrq-0001Iu-St
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPro-0004Al-MM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1czAJ1x/IV6ed1bEr1v7sbxUSM/1M7JNSIvpPOu9AnM=;
 b=N/j5XiAMA66Z6+vSPqImH2sAZWR7MDLijYKV5pEgH5Paef7VAjD8XeZG7urY98NlsV0fac
 Zhhzz9vNAksk5HI1O0skEEWLXgNqXYzkjm8P9rFL/nWK5GMU0FTm/mO+5C4BS9vyUBKSPn
 S92mPMVkaIyziyCHHgevGea8RAC4djg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-fYOquu_DMnuCUDlNzzT8ag-1; Thu, 11 Jun 2020 12:15:43 -0400
X-MC-Unique: fYOquu_DMnuCUDlNzzT8ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B224F107ACCA;
 Thu, 11 Jun 2020 16:15:41 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D180210013C2;
 Thu, 11 Jun 2020 16:15:37 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 4/9] hw/arm/smmu: Introduce SMMUTLBEntry for PTW and
 IOTLB value
Date: Thu, 11 Jun 2020 18:14:55 +0200
Message-Id: <20200611161500.23580-5-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-1-eric.auger@redhat.com>
References: <20200611161500.23580-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Introduce a specialized SMMUTLBEntry to store the result of
the PTW and cache in the IOTLB. This structure extends the
generic IOMMUTLBEntry struct with the level of the entry and
the granule size.

Those latter will be useful when implementing range invalidation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/arm/smmu-common.h | 14 +++++++++++---
 hw/arm/smmu-common.c         | 30 ++++++++++++++++--------------
 hw/arm/smmuv3.c              | 10 +++++-----
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 7b9d2f0eb7..f6ee78e16c 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -52,6 +52,14 @@ typedef struct SMMUTransTableInfo {
     uint8_t granule_sz;        /* granule page shift */
 } SMMUTransTableInfo;
 
+struct SMMUTLBEntry {
+    IOMMUTLBEntry entry;
+    uint8_t level;
+    uint8_t granule;
+};
+
+typedef struct SMMUTLBEntry SMMUTLBEntry;
+
 /*
  * Generic structure populated by derived SMMU devices
  * after decoding the configuration information and used as
@@ -135,7 +143,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * pair, according to @cfg translation config
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
 
 /**
  * select_tt - compute which translation table shall be used according to
@@ -148,8 +156,8 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
-IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry);
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3101043540..aa88b62efb 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -47,11 +47,11 @@ uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
     return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
 }
 
-IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                  hwaddr iova)
 {
     uint64_t key = smmu_get_iotlb_key(cfg->asid, iova);
-    IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
+    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -69,7 +69,7 @@ IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
     return entry;
 }
 
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
 {
     uint64_t *key = g_new0(uint64_t, 1);
 
@@ -77,9 +77,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
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
@@ -199,7 +199,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  * @cfg: translation config
  * @iova: iova to translate
  * @perm: access type
- * @tlbe: IOMMUTLBEntry (out)
+ * @tlbe: SMMUTLBEntry (out)
  * @info: handle to an error info
  *
  * Return 0 on success, < 0 on error. In case of error, @info is filled
@@ -209,7 +209,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  */
 static int smmu_ptw_64(SMMUTransCfg *cfg,
                        dma_addr_t iova, IOMMUAccessFlags perm,
-                       IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                       SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     dma_addr_t baseaddr, indexmask;
     int stage = cfg->stage;
@@ -229,8 +229,8 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
     baseaddr = extract64(tt->ttb, 0, 48);
     baseaddr &= ~indexmask;
 
-    tlbe->iova = iova;
-    tlbe->addr_mask = (1 << granule_sz) - 1;
+    tlbe->entry.iova = iova;
+    tlbe->entry.addr_mask = (1 << granule_sz) - 1;
 
     while (level <= 3) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
@@ -281,13 +281,15 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
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
 
@@ -303,7 +305,7 @@ error:
  * return 0 on success
  */
 inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
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
2.20.1


