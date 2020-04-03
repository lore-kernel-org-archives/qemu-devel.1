Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480EAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F20D20787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F20D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHWv-0004eR-91
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jKHOl-0001Oh-Bx
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jKHOk-0006Pv-D8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:09:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:21036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jKHOk-0006M1-4h
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:09:54 -0400
IronPort-SDR: J67euxDIgooOdVQMpjT2vjyhGfaX5kG+Z1DShFymZooq2PR/nrYIsJq+ujtV+myiZrl4VRIGLl
 SOqk/EGk3jJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 01:09:52 -0700
IronPort-SDR: 3HiTK+8pMLAJobZVQMYY/9qchoDW482vsxwJIG69EvW9CDvFwKtCBKhFhuHccKKbOMDOJM63Qr
 +LI1KKreJf+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="449944103"
Received: from dpdk-zhirun.sh.intel.com ([10.67.119.121])
 by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2020 01:09:50 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/vfio: let read-only flag take effect for mmap'd
 regions
Date: Fri,  3 Apr 2020 17:00:42 +0000
Message-Id: <20200403170042.20723-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403165657.20566-1-yan.y.zhao@intel.com>
References: <20200403165657.20566-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com, philmd@redhat.com, xin.zeng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

along side setting host page table to be read-only, the memory regions
are also required to be read-only, so that when guest writes to the
read-only & mmap'd regions, vmexits would happen and region write handlers
are called.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
---
 hw/vfio/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fd6ee1fe3e..fc7618e041 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -977,6 +977,10 @@ int vfio_region_mmap(VFIORegion *region)
                                           name, region->mmaps[i].size,
                                           region->mmaps[i].mmap);
         g_free(name);
+
+        if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+            memory_region_set_readonly(&region->mmaps[i].mem, true);
+        }
         memory_region_add_subregion(region->mem, region->mmaps[i].offset,
                                     &region->mmaps[i].mem);
 
-- 
2.17.1


