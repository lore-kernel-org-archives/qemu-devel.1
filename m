Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2932206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRSFfAEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2932206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPyR-0001Rf-0X
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPsC-0001lF-Mn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:16:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPs9-0004CQ-BT
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARv8qSDziPHTJvaLmyQIW8b8LLLtOfE1f3+HLmQbobU=;
 b=SRSFfAEUIsfHCvLWhpsLL6VgIPzGbPLdVfiZrT/4s+J6CU+MHmdFsPu50qBajdrvilc3Ng
 +YUlgclt71A9R7Y6I43b2Uo+mw2W/0fdYhad859ubmqXJ4KWjTNkJ6lknpC//1fQf3R7zY
 Ey/hgz5FU4x/QwrSkyogRoWbiXrEh9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-VKWpJVvWNk2aJSXFxx2vcw-1; Thu, 11 Jun 2020 12:16:03 -0400
X-MC-Unique: VKWpJVvWNk2aJSXFxx2vcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFF5EC1A4;
 Thu, 11 Jun 2020 16:16:01 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32FCE10013C2;
 Thu, 11 Jun 2020 16:15:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 7/9] hw/arm/smmuv3: Introduce smmuv3_s1_range_inval()
 helper
Date: Thu, 11 Jun 2020 18:14:58 +0200
Message-Id: <20200611161500.23580-8-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-1-eric.auger@redhat.com>
References: <20200611161500.23580-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
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

Let's introduce an helper for S1 IOVA range invalidation.
This will be used for NH_VA and NH_VAA commands. It decodes
the same fields, trace, calls the UNMAP notifiers and
invalidate the corresponding IOTLB entries.

At the moment, we do not support 3.2 range invalidation yet.
So it reduces to a single IOVA invalidation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c     | 36 +++++++++++++++++-------------------
 hw/arm/trace-events |  3 +--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 931a2b6872..4eda16be7b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -840,6 +840,22 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
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
@@ -970,27 +986,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
index 2d445c99b7..b366973739 100644
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
2.20.1


