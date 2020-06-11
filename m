Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C442C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D08206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e36lzvTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D08206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPvl-0005sI-Ee
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrX-0000dF-6D
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrT-00041Z-Pq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kd60isijc7N93R5SBt36LCkpor0G13KGJpP9vjfXfyA=;
 b=e36lzvTXY8iGaiJ5ABIk7/rXLhGCel/Z9mykEsu6HexzcjsuXGu8qQVpV44Hdi5jERMoTa
 M+nGvrEN4hN4R5RB2DAGyDfPsjMwjT70/W4XVhC/ycpccIPepzq/ot5hEOtEL3YJPPp00U
 M5E2yb/2cELS4/1o9fU6yhn38xIrsH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-DOl39GhVPiqHzONUoNlOvw-1; Thu, 11 Jun 2020 12:15:23 -0400
X-MC-Unique: DOl39GhVPiqHzONUoNlOvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A0E11054F91;
 Thu, 11 Jun 2020 16:15:21 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7105C10013C2;
 Thu, 11 Jun 2020 16:15:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 1/9] hw/arm/smmu-common: Factorize some code in
 smmu_ptw_64()
Date: Thu, 11 Jun 2020 18:14:52 +0200
Message-Id: <20200611161500.23580-2-eric.auger@redhat.com>
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

Page and block PTE decoding can share some code. Let's
first handle table PTE and factorize some code shared by
page and block PTEs.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c | 51 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e13a5f4a7c..f2de2be527 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -186,12 +186,12 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
         uint64_t mask = subpage_size - 1;
         uint32_t offset = iova_level_offset(iova, inputsize, level, granule_sz);
-        uint64_t pte;
+        uint64_t pte, gpa;
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t ap;
 
         if (get_pte(baseaddr, offset, &pte, info)) {
-                goto error;
+            break;
         }
         trace_smmu_ptw_level(level, iova, subpage_size,
                              baseaddr, offset, pte);
@@ -199,58 +199,43 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
         if (is_invalid_pte(pte) || is_reserved_pte(pte, level)) {
             trace_smmu_ptw_invalid_pte(stage, level, baseaddr,
                                        pte_addr, offset, pte);
-            info->type = SMMU_PTW_ERR_TRANSLATION;
-            goto error;
+            break;
         }
 
-        if (is_page_pte(pte, level)) {
-            uint64_t gpa = get_page_pte_address(pte, granule_sz);
+        if (is_table_pte(pte, level)) {
+            ap = PTE_APTABLE(pte);
 
-            ap = PTE_AP(pte);
             if (is_permission_fault(ap, perm)) {
                 info->type = SMMU_PTW_ERR_PERMISSION;
                 goto error;
             }
-
-            tlbe->translated_addr = gpa + (iova & mask);
-            tlbe->perm = PTE_AP_TO_PERM(ap);
+            baseaddr = get_table_pte_address(pte, granule_sz);
+            level++;
+            continue;
+        } else if (is_page_pte(pte, level)) {
+            gpa = get_page_pte_address(pte, granule_sz);
             trace_smmu_ptw_page_pte(stage, level, iova,
                                     baseaddr, pte_addr, pte, gpa);
-            return 0;
-        }
-        if (is_block_pte(pte, level)) {
+        } else {
             uint64_t block_size;
-            hwaddr gpa = get_block_pte_address(pte, level, granule_sz,
-                                               &block_size);
-
-            ap = PTE_AP(pte);
-            if (is_permission_fault(ap, perm)) {
-                info->type = SMMU_PTW_ERR_PERMISSION;
-                goto error;
-            }
 
+            gpa = get_block_pte_address(pte, level, granule_sz,
+                                        &block_size);
             trace_smmu_ptw_block_pte(stage, level, baseaddr,
                                      pte_addr, pte, iova, gpa,
                                      block_size >> 20);
-
-            tlbe->translated_addr = gpa + (iova & mask);
-            tlbe->perm = PTE_AP_TO_PERM(ap);
-            return 0;
         }
-
-        /* table pte */
-        ap = PTE_APTABLE(pte);
-
+        ap = PTE_AP(pte);
         if (is_permission_fault(ap, perm)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
             goto error;
         }
-        baseaddr = get_table_pte_address(pte, granule_sz);
-        level++;
+
+        tlbe->translated_addr = gpa + (iova & mask);
+        tlbe->perm = PTE_AP_TO_PERM(ap);
+        return 0;
     }
-
     info->type = SMMU_PTW_ERR_TRANSLATION;
-
 error:
     tlbe->perm = IOMMU_NONE;
     return -EINVAL;
-- 
2.20.1


