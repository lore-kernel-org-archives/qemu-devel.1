Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBDA20781
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDrJineX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBDA20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Bf-0006rB-2W
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jr17r-0001Md-R9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jr17q-0006QX-8U
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593703665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4qLqUFnjHc7wzCPN/LQ1XBPh1dVzrlm59KIf9UKpNI=;
 b=SDrJineXFohaQ+QDJKOmPCqatbLBhI1sOIjZR0s6geUTq8Pnkp8s83Wg1Ld+o34+yBiY+M
 CLBz1cMj1C3Qj42KV0BScTJTFokS/PXlot+PVHV6D4UoC5/O7guK/GJPfsXbB3TsgulBJ2
 3q907M7XPZS/5BX4pFXDJBg1+NmWljw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-SOYhJYvxPsO4tZsivXU2sw-1; Thu, 02 Jul 2020 11:27:42 -0400
X-MC-Unique: SOYhJYvxPsO4tZsivXU2sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2127A8CA88B;
 Thu,  2 Jul 2020 15:27:40 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 394B15DC1E;
 Thu,  2 Jul 2020 15:27:37 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH v2 4/9] hw/arm/smmu: Simplify the IOTLB key format
Date: Thu,  2 Jul 2020 17:26:54 +0200
Message-Id: <20200702152659.8522-5-eric.auger@redhat.com>
In-Reply-To: <20200702152659.8522-1-eric.auger@redhat.com>
References: <20200702152659.8522-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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

Instead of using a Jenkins hash function to generate
the key let's just use a 64 bit unsigned integer that
contains the asid and the 40 upper bits of the iova.
A maximum of 52-bit IOVA is supported. This change in the
key format also prepares for the addition of new fields
in subsequent patches (granule and level).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- split the inital patch into 2 patches and keep SMMUIOTLBKey type
---
 hw/arm/smmu-internal.h       |  5 ++++-
 include/hw/arm/smmu-common.h |  5 +----
 hw/arm/smmu-common.c         | 23 +++--------------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 3104f768cd..2ecb6f1dc6 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -96,5 +96,8 @@ uint64_t iova_level_offset(uint64_t iova, int inputsize,
             MAKE_64BIT_MASK(0, gsz - 3);
 }
 
-#define SMMU_IOTLB_ASID(key) ((key).asid)
+#define SMMU_IOTLB_ASID_SHIFT  40
+
+#define SMMU_IOTLB_ASID(key) (((key) >> SMMU_IOTLB_ASID_SHIFT) & 0xFFFF)
+#define SMMU_IOTLB_IOVA(key) (((key) & MAKE_64BIT_MASK(0, 40)) << 12)
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5f9f3535d2..455d7855b2 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -88,10 +88,7 @@ typedef struct SMMUPciBus {
     SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically alloc */
 } SMMUPciBus;
 
-typedef struct SMMUIOTLBKey {
-    uint64_t iova;
-    uint16_t asid;
-} SMMUIOTLBKey;
+ typedef uint64_t SMMUIOTLBKey;
 
 typedef struct SMMUState {
     /* <private> */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7dc8541e8b..5e85e30bdf 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -34,34 +34,17 @@
 
 static guint smmu_iotlb_key_hash(gconstpointer v)
 {
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
+    return (guint)*(const uint64_t *)v;
 }
 
 static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 {
-    const SMMUIOTLBKey *k1 = v1;
-    const SMMUIOTLBKey *k2 = v2;
-
-    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
+    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
 }
 
 SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
 {
-    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
-
-    return key;
+    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
 }
 
 IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-- 
2.21.3


