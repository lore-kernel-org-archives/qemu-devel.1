Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1742C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBDF2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqMaJMlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBDF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhHm-0001Oo-Jk
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jbhF3-0004iQ-G1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jbhF2-0005Lf-Ln
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590052312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPtBcos55hsUQYrVViHHdkNlrTJev7hV9hkjAaBxS9A=;
 b=CqMaJMlhCBqcRMqflv8ke4n+Dbh6lDo46+hkYpSWf//2IsRogS1YZeE+ncbq3bIdnq4hr/
 ri+bMIwmeTLdNxBOwwaFwY3mgE/gJA+LPd/8qdqOqDNA3JpamVBTLh5XMqDE0xZUAjLK/w
 ZBoGUb3G9zij6nzmX1gSZSSFOfEGYxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-KA3lIE9BN8a6pRHpEHxq9w-1; Thu, 21 May 2020 05:11:50 -0400
X-MC-Unique: KA3lIE9BN8a6pRHpEHxq9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5463461;
 Thu, 21 May 2020 09:11:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5655D9C9;
 Thu, 21 May 2020 09:11:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH 5/9] hw/arm/smmuv3: Store the starting level in
 SMMUTransTableInfo
Date: Thu, 21 May 2020 11:10:55 +0200
Message-Id: <20200521091059.9453-6-eric.auger@redhat.com>
In-Reply-To: <20200521091059.9453-1-eric.auger@redhat.com>
References: <20200521091059.9453-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: jean-philippe@linaro.org, robh@kernel.org, robin.murphy@arm.com,
 mst@redhat.com, zhangfei.gao@foxmail.com, shameerali.kolothum.thodi@huawei.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Compute the starting level on CD decoding and store it
into SMMUTransTableInfo. We will need this information
on IOTLB lookup so let's avoid to recompute it each time.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/arm/smmu-common.h | 1 +
 hw/arm/smmu-common.c         | 2 +-
 hw/arm/smmuv3.c              | 8 ++++++--
 hw/arm/trace-events          | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index f6ee78e16c..676e53c086 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -50,6 +50,7 @@ typedef struct SMMUTransTableInfo {
     uint64_t ttb;              /* TT base address */
     uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
     uint8_t granule_sz;        /* granule page shift */
+    uint8_t starting_level;    /* starting level */
 } SMMUTransTableInfo;
 
 struct SMMUTLBEntry {
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index aa88b62efb..c2ed8346fb 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -224,7 +224,7 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
     granule_sz = tt->granule_sz;
     stride = granule_sz - 3;
     inputsize = 64 - tt->tsz;
-    level = 4 - (inputsize - 4) / stride;
+    level = tt->starting_level;
     indexmask = (1ULL << (inputsize - (stride * (4 - level)))) - 1;
     baseaddr = extract64(tt->ttb, 0, 48);
     baseaddr &= ~indexmask;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index db74d27add..12d3e972d6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -482,7 +482,7 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
     /* decode data dependent on TT */
     for (i = 0; i <= 1; i++) {
-        int tg, tsz;
+        int tg, tsz, input_size, stride;
         SMMUTransTableInfo *tt = &cfg->tt[i];
 
         cfg->tt[i].disabled = CD_EPD(cd, i);
@@ -502,11 +502,15 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
         }
 
         tt->tsz = tsz;
+        input_size = 64 - tt->tsz;
+        stride = tt->granule_sz - 3;
         tt->ttb = CD_TTB(cd, i);
         if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
             goto bad_cd;
         }
-        trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz);
+        tt->starting_level = 4 - (input_size - 4) / stride;
+        trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb,
+                                  tt->granule_sz, tt->starting_level);
     }
 
     event->record_trans_faults = CD_R(cd);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index b808a1bfc1..7263b9c586 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -39,7 +39,7 @@ smmuv3_translate_abort(const char *n, uint16_t sid, uint64_t addr, bool is_write
 smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
-smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d"
+smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, uint8_t starting_level) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d starting_level=%d"
 smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
 smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
-- 
2.20.1


