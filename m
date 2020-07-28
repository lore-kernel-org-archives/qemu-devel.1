Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36FF2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4ibei+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36FF2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RMa-0004pi-V6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k0RFv-0000iy-DI
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:11:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k0RFs-00083c-6c
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595949058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN2Tg6cktWjfVh/Lr05cfnKD1TEiS0BORvWfwZryVgo=;
 b=O4ibei+8Mpo2h3FWgBgk1geCSeB57gj61jV2Uq+t/qb5VENbIeQ043SCZoISSWttiTPqvl
 QXg2dz9s4txZdcQnu5/C9pWi8jzGtsFdmCL3RnwVYf+bb/YgQ7RLEJieTYKTjQLt6bdOaf
 UTkzT2D28HKpARZEMxHiDSWXFJnVABw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-zeuOkTPtNA6nTjSDK_bwcA-1; Tue, 28 Jul 2020 11:10:44 -0400
X-MC-Unique: zeuOkTPtNA6nTjSDK_bwcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D74718C63C5;
 Tue, 28 Jul 2020 15:09:57 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-203.ams2.redhat.com [10.36.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEE75C1BD;
 Tue, 28 Jul 2020 15:09:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH for-5.2 v4 06/11] hw/arm/smmuv3: Introduce
 smmuv3_s1_range_inval() helper
Date: Tue, 28 Jul 2020 17:08:10 +0200
Message-Id: <20200728150815.11446-7-eric.auger@redhat.com>
In-Reply-To: <20200728150815.11446-1-eric.auger@redhat.com>
References: <20200728150815.11446-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Let's introduce an helper for S1 IOVA range invalidation.
This will be used for NH_VA and NH_VAA commands. It decodes
the same fields, trace, calls the UNMAP notifiers and
invalidate the corresponding IOTLB entries.

At the moment, we do not support 3.2 range invalidation yet.
So it reduces to a single IOVA invalidation.

Note the leaf bit now is also decoded for the CMD_TLBI_NH_VAA
command. At the moment it is only used for tracing.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v1 -> v2:
- added comment about leaf bit and added Peter's R-b
---
 hw/arm/smmuv3.c     | 36 +++++++++++++++++-------------------
 hw/arm/trace-events |  3 +--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b717bde832..e4a2cea7ad 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -836,6 +836,22 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
     }
 }
 
+static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
+{
+    dma_addr_t addr = CMD_ADDR(cmd);
+    uint8_t type = CMD_TYPE(cmd);
+    uint16_t vmid = CMD_VMID(cmd);
+    bool leaf = CMD_LEAF(cmd);
+    int asid = -1;
+
+    if (type == SMMU_CMD_TLBI_NH_VA) {
+        asid = CMD_ASID(cmd);
+    }
+    trace_smmuv3_s1_range_inval(vmid, asid, addr, leaf);
+    smmuv3_inv_notifiers_iova(s, asid, addr);
+    smmu_iotlb_inv_iova(s, asid, addr);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -966,27 +982,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             smmu_iotlb_inv_all(bs);
             break;
         case SMMU_CMD_TLBI_NH_VAA:
-        {
-            dma_addr_t addr = CMD_ADDR(&cmd);
-            uint16_t vmid = CMD_VMID(&cmd);
-
-            trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
-            smmuv3_inv_notifiers_iova(bs, -1, addr);
-            smmu_iotlb_inv_iova(bs, -1, addr);
-            break;
-        }
         case SMMU_CMD_TLBI_NH_VA:
-        {
-            uint16_t asid = CMD_ASID(&cmd);
-            uint16_t vmid = CMD_VMID(&cmd);
-            dma_addr_t addr = CMD_ADDR(&cmd);
-            bool leaf = CMD_LEAF(&cmd);
-
-            trace_smmuv3_cmdq_tlbi_nh_va(vmid, asid, addr, leaf);
-            smmuv3_inv_notifiers_iova(bs, asid, addr);
-            smmu_iotlb_inv_iova(bs, asid, addr);
+            smmuv3_s1_range_inval(bs, &cmd);
             break;
-        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f74d3e920f..c219fe9e82 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -45,8 +45,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
-smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =%d addr=0x%"PRIx64
+smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
-- 
2.21.3


