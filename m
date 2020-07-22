Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF2BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D875720787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSH7/WKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D875720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAKi-0005Rs-2E
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJA-0003mb-Gp
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:41:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJ7-0000OO-Od
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595407256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AZwKAol2zP3kx72+lN4dzMd1pf+gShLnzFfE9RuXQ4=;
 b=eSH7/WKorpJV+plB1DueSWien6uLUf4Qc4AFgdUcnzXS35WijiaYxZpVfPM+Syx4tsefT3
 aPJ34mf277tdPL2rkH7GAXW2laxa02EpZIOtY5vWfi/H69cKJUSmV14EHOw2bwZKSaduZA
 skwmpN1LaluGi7+90ErcGGHLVRaaXZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-KySZH7oPODG1FiKe3zZ_WA-1; Wed, 22 Jul 2020 04:40:54 -0400
X-MC-Unique: KySZH7oPODG1FiKe3zZ_WA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3419800C64;
 Wed, 22 Jul 2020 08:40:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA7B519C4F;
 Wed, 22 Jul 2020 08:40:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07C8F107F757; Wed, 22 Jul 2020 10:40:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] error: Strip trailing '\n' from error string arguments
 (again)
Date: Wed, 22 Jul 2020 10:40:46 +0200
Message-Id: <20200722084048.1726105-3-armbru@redhat.com>
In-Reply-To: <20200722084048.1726105-1-armbru@redhat.com>
References: <20200722084048.1726105-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Xu <peterx@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tracked down with scripts/coccinelle/err-bad-newline.cocci.

Cc: Peter Xu <peterx@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/intel_iommu.c   | 6 +++---
 target/ppc/mmu-hash64.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c56398e991..8cd9ed8d3b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2356,7 +2356,7 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
         (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
         error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                          ", lo=0x%"PRIx64" (reserved bits unzero)\n",
+                          ", lo=0x%"PRIx64" (reserved bits unzero)",
                           __func__, inv_desc->hi, inv_desc->lo);
         return false;
     }
@@ -2377,7 +2377,7 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         am = VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
         if (am > VTD_MAMV) {
             error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)\n",
+                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)",
                               __func__, inv_desc->hi, inv_desc->lo,
                               am, (unsigned)VTD_MAMV);
             return false;
@@ -2387,7 +2387,7 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 
     default:
         error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)\n",
+                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
                           __func__, inv_desc->hi, inv_desc->lo,
                           inv_desc->lo & VTD_INV_DESC_IOTLB_G);
         return false;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index e5baabf0e1..c31d21e6a9 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -859,7 +859,7 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
     }
 
     error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
-                 TARGET_FMT_lx"\n", lpcr);
+                 TARGET_FMT_lx, lpcr);
 
     return -1;
 }
-- 
2.26.2


