Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E99C215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99C215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inNLA-00019z-Dp
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 08:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1inNIX-0007Jf-Iy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1inNIV-0001Vk-6H
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:47:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:21927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1inNIT-0001Nv-Jy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:47:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Jan 2020 05:47:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; d="scan'208";a="221640112"
Received: from iov2.bj.intel.com ([10.238.145.72])
 by orsmga006.jf.intel.com with ESMTP; 03 Jan 2020 05:47:13 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
Subject: [PATCH v1 1/2] intel_iommu: a fix to vtd_find_as_from_bus_num()
Date: Fri,  3 Jan 2020 21:28:05 +0800
Message-Id: <1578058086-4288-2-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578058086-4288-1-git-send-email-yi.l.liu@intel.com>
References: <1578058086-4288-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, jun.j.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.co
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ensure the return value of vtd_find_as_from_bus_num() is NULL by
enforcing vtd_bus=NULL. This would help caller of vtd_find_as_from_bus_num()
to decide if any further operation on the returned vtd_bus.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43c94b9..00ebae4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -948,6 +948,7 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
                 return vtd_bus;
             }
         }
+        vtd_bus = NULL;
     }
     return vtd_bus;
 }
-- 
2.7.4


