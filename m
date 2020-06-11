Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECFFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF5520792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq7EVhgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF5520792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ5F-0005Cu-2t
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPs4-0001aL-IU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:16:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPs2-0004C3-CP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vYMi+kgVnD/ZFNncBOFCqHi5dc2slD8n10tuwHQGQo=;
 b=Mq7EVhgFpFGlg6iA8gpLd74TvAjmZIrnoznJ4Ni6aIJZzc1shRmUkJpnshxOlPf5RXTmBG
 LnnQMyCWKARhsb9UM/j787R6sbinbN+Avt87lfn1wl//+2XYLl/1uKQh+19cvvZdRBP5hf
 KsAtHlJ/tRj1/sWBAYhgGcpC+9W/yjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-uD1hzqgkMoWDrBk1ofPmtQ-1; Thu, 11 Jun 2020 12:15:59 -0400
X-MC-Unique: uD1hzqgkMoWDrBk1ofPmtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C31CD1005512;
 Thu, 11 Jun 2020 16:15:57 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD39710013C2;
 Thu, 11 Jun 2020 16:15:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 6/9] hw/arm/smmu-common: Manage IOTLB block entries
Date: Thu, 11 Jun 2020 18:14:57 +0200
Message-Id: <20200611161500.23580-7-eric.auger@redhat.com>
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

At the moment each entry in the IOTLB corresponds to a page sized
mapping (4K, 16K or 64K), even if the page belongs to a mapped
block. In case of block mapping this unefficiently consume IOTLB
entries.

Change the value of the entry so that it reflects the actual
mapping it belongs to (block or page start address and size).

Also the level/tg of the entry is encoded in the key. In subsequent
patches we will enable range invalidation. This latter is able
to provide the level/tg of the entry.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-internal.h       | 10 ++++++
 include/hw/arm/smmu-common.h |  8 +++--
 hw/arm/smmu-common.c         | 61 +++++++++++++++++++++++++++---------
 hw/arm/smmuv3.c              |  6 ++--
 hw/arm/trace-events          |  2 +-
 5 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 2ecb6f1dc6..f60b48dc9b 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -97,7 +97,17 @@ uint64_t iova_level_offset(uint64_t iova, int inputsize,
 }
 
 #define SMMU_IOTLB_ASID_SHIFT  40
+#define SMMU_IOTLB_LEVEL_SHIFT 56
+#define SMMU_IOTLB_TG_SHIFT    58
 
 #define SMMU_IOTLB_ASID(key) (((key) >> SMMU_IOTLB_ASID_SHIFT) & 0xFFFF)
 #define SMMU_IOTLB_IOVA(key) (((key) & MAKE_64BIT_MASK(0, 40)) << 12)
+
+struct SMMUIOTLBPageInvInfo {
+    int asid;
+    uint64_t iova;
+    uint64_t mask;
+};
+typedef struct SMMUIOTLBPageInvInfo SMMUIOTLBPageInvInfo;
+
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 676e53c086..34a13c7cd6 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -157,12 +157,14 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
-SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
-uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
+uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
+                            uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
+void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova);
 
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index c2ed8346fb..27804fbb2d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -42,16 +42,33 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
     return *((const uint64_t *)v1) == *((const uint64_t *)v2);
 }
 
-uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
+uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
+                            uint8_t tg, uint8_t level)
 {
-    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
+    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT |
+           (uint64_t)(level) << SMMU_IOTLB_LEVEL_SHIFT |
+           (uint64_t)(tg) << SMMU_IOTLB_TG_SHIFT;
 }
 
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                 hwaddr iova)
+                                SMMUTransTableInfo *tt, hwaddr iova)
 {
-    uint64_t key = smmu_get_iotlb_key(cfg->asid, iova);
-    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
+    uint8_t tg = (tt->granule_sz - 10) / 2;
+    int level = tt->starting_level;
+    SMMUTLBEntry *entry = NULL;
+
+    while (level <= 3) {
+        uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
+        uint64_t mask = subpage_size - 1;
+        uint64_t key;
+
+        key = smmu_get_iotlb_key(cfg->asid, iova & ~mask, tg, level);
+        entry = g_hash_table_lookup(bs->iotlb, &key);
+        if (entry) {
+            break;
+        }
+        level++;
+    }
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -72,13 +89,14 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
 {
     uint64_t *key = g_new0(uint64_t, 1);
+    uint8_t tg = (new->granule - 10) / 2;
 
     if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
         smmu_iotlb_inv_all(bs);
     }
 
-    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova);
-    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova);
+    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova, tg, new->level);
+    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova, tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
@@ -97,12 +115,28 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
     return SMMU_IOTLB_ASID(*iotlb_key) == asid;
 }
 
-inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
+static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
+                                         gpointer user_data)
 {
-    uint64_t key = smmu_get_iotlb_key(asid, iova);
+    SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
+    IOMMUTLBEntry *entry = &iter->entry;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
+    uint64_t *iotlb_key = (uint64_t *)key;
+
+    if (info->asid >= 0) {
+        return (info->asid == SMMU_IOTLB_ASID(*iotlb_key)) &&
+                ((info->iova & ~entry->addr_mask) == entry->iova);
+    } else {
+        return (info->iova & ~entry->addr_mask) == entry->iova;
+    }
+}
+
+inline void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova)
+{
+    SMMUIOTLBPageInvInfo info = {.asid = asid, .iova = iova};
 
     trace_smmu_iotlb_inv_iova(asid, iova);
-    g_hash_table_remove(s->iotlb, &key);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_iova, &info);
 }
 
 inline void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
@@ -229,9 +263,6 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
     baseaddr = extract64(tt->ttb, 0, 48);
     baseaddr &= ~indexmask;
 
-    tlbe->entry.iova = iova;
-    tlbe->entry.addr_mask = (1 << granule_sz) - 1;
-
     while (level <= 3) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
         uint64_t mask = subpage_size - 1;
@@ -281,7 +312,9 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
             goto error;
         }
 
-        tlbe->entry.translated_addr = gpa + (iova & mask);
+        tlbe->entry.translated_addr = gpa;
+        tlbe->entry.iova = iova & ~mask;
+        tlbe->entry.addr_mask = mask;
         tlbe->entry.perm = PTE_AP_TO_PERM(ap);
         tlbe->level = level;
         tlbe->granule = granule_sz;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 12d3e972d6..931a2b6872 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -678,7 +678,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     page_mask = (1ULL << (tt->granule_sz)) - 1;
     aligned_addr = addr & ~page_mask;
 
-    cached_entry = smmu_iotlb_lookup(bs, cfg, aligned_addr);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, tt, aligned_addr);
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
@@ -748,7 +748,7 @@ epilogue:
     case SMMU_TRANS_SUCCESS:
         entry.perm = flag;
         entry.translated_addr = cached_entry->entry.translated_addr +
-                                    (addr & page_mask);
+                                    (addr & cached_entry->entry.addr_mask);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm);
@@ -976,7 +976,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
             smmuv3_inv_notifiers_iova(bs, -1, addr);
-            smmu_iotlb_inv_all(bs);
+            smmu_iotlb_inv_iova(bs, -1, addr);
             break;
         }
         case SMMU_CMD_TLBI_NH_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7263b9c586..2d445c99b7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -16,7 +16,7 @@ smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(uint16_t asid, uint64_t addr) "IOTLB ++ asid=%d addr=0x%"PRIx64
+smmu_iotlb_insert(uint16_t asid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d addr=0x%"PRIx64" tg=%d level=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-- 
2.20.1


