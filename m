Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72A1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728E4206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpfBWfDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728E4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPz8-0002w6-L6
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrm-00019H-2F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60688
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrk-00047a-1r
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xhpy5/KHWu7f7iBNn50umu1Z55N8FKEPXHzp1efxKzw=;
 b=dpfBWfDScX+C8peYycV23NhET1jJftZo8MevUS6BOPnW59WDXNipn1HibCgV13pbrmKvPT
 eLkmKllPKPlrNKUbZmpmC1KRo5L8SuKnF8g/OZSWoVg+hnwFUBT8v7Zd87SO1uiiQnfP0R
 N6gwqrjTh5NCZ+lCcLPFsKZR/pWbR2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-sO1Vp0BfO3-C3zENJobzOg-1; Thu, 11 Jun 2020 12:15:41 -0400
X-MC-Unique: sO1Vp0BfO3-C3zENJobzOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741AC801503;
 Thu, 11 Jun 2020 16:15:37 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89F3710013C2;
 Thu, 11 Jun 2020 16:15:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 3/9] hw/arm/smmu: Simplify the IOTLB key format
Date: Thu, 11 Jun 2020 18:14:54 +0200
Message-Id: <20200611161500.23580-4-eric.auger@redhat.com>
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

Instead of using a Jenkins hash function to generate
the key let's just use a 64 bit unsigned integer that
contains the asid and the 40 upper bits of the iova.
A maximum of 52-bit IOVA is supported. This change in the
key format also prepares for the addition of new fields
in subsequent patches (granule and level).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-internal.h       |  4 +++
 include/hw/arm/smmu-common.h |  6 +---
 hw/arm/smmu-common.c         | 53 ++++++++++++++----------------------
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 7794d6d394..2ecb6f1dc6 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -96,4 +96,8 @@ uint64_t iova_level_offset(uint64_t iova, int inputsize,
             MAKE_64BIT_MASK(0, gsz - 3);
 }
 
+#define SMMU_IOTLB_ASID_SHIFT  40
+
+#define SMMU_IOTLB_ASID(key) (((key) >> SMMU_IOTLB_ASID_SHIFT) & 0xFFFF)
+#define SMMU_IOTLB_IOVA(key) (((key) & MAKE_64BIT_MASK(0, 40)) << 12)
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 1dceec5cb1..7b9d2f0eb7 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -88,11 +88,6 @@ typedef struct SMMUPciBus {
     SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically alloc */
 } SMMUPciBus;
 
-typedef struct SMMUIOTLBKey {
-    uint64_t iova;
-    uint16_t asid;
-} SMMUIOTLBKey;
-
 typedef struct SMMUState {
     /* <private> */
     SysBusDevice  dev;
@@ -155,6 +150,7 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry);
+uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
 void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8409de052d..3101043540 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -32,10 +32,25 @@
 
 /* IOTLB Management */
 
+static guint smmu_iotlb_key_hash(gconstpointer v)
+{
+    return (guint)*(const uint64_t *)v;
+}
+
+static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
+}
+
+uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
+{
+    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
+}
+
 IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                  hwaddr iova)
 {
-    SMMUIOTLBKey key = {.asid = cfg->asid, .iova = iova};
+    uint64_t key = smmu_get_iotlb_key(cfg->asid, iova);
     IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
 
     if (entry) {
@@ -56,14 +71,13 @@ IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
 {
-    SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
+    uint64_t *key = g_new0(uint64_t, 1);
 
     if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
         smmu_iotlb_inv_all(bs);
     }
 
-    key->asid = cfg->asid;
-    key->iova = entry->iova;
+    *key = smmu_get_iotlb_key(cfg->asid, entry->iova);
     trace_smmu_iotlb_insert(cfg->asid, entry->iova);
     g_hash_table_insert(bs->iotlb, key, entry);
 }
@@ -78,14 +92,14 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
     uint16_t asid = *(uint16_t *)user_data;
-    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
+    uint64_t *iotlb_key = (uint64_t *)key;
 
-    return iotlb_key->asid == asid;
+    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
 }
 
 inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
 {
-    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
+    uint64_t key = smmu_get_iotlb_key(asid, iova);
 
     trace_smmu_iotlb_inv_iova(asid, iova);
     g_hash_table_remove(s->iotlb, &key);
@@ -382,31 +396,6 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
     return NULL;
 }
 
-static guint smmu_iotlb_key_hash(gconstpointer v)
-{
-    SMMUIOTLBKey *key = (SMMUIOTLBKey *)v;
-    uint32_t a, b, c;
-
-    /* Jenkins hash */
-    a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid;
-    b += extract64(key->iova, 0, 32);
-    c += extract64(key->iova, 32, 32);
-
-    __jhash_mix(a, b, c);
-    __jhash_final(a, b, c);
-
-    return c;
-}
-
-static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
-{
-    const SMMUIOTLBKey *k1 = v1;
-    const SMMUIOTLBKey *k2 = v2;
-
-    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
-}
-
 /* Unmap the whole notifier's range */
 static void smmu_unmap_notifier_range(IOMMUNotifier *n)
 {
-- 
2.20.1


