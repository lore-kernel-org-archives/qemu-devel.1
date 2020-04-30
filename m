Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D452BC83009
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBE42073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBE42073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4Xn-0002Aw-Se
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU4Wt-000104-Al
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU4U7-0002EG-MA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:26:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:10658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jU4U7-0002E0-4v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:23:55 -0400
IronPort-SDR: mQfk6FIm7S1rFrHx+3Y7yv1J7lCeilJQNrOIRw7yNOqAUk/9xF4zJdgJzKxqPaTVaiy+TLcYoJ
 N7+63h1de9Kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 01:23:53 -0700
IronPort-SDR: sor0dj/ImWEAu+nCB0L0H3+VmscKb5QjBSTKC71GyDWOCMdrdM0YZSw+DQ83sXrTWRZCdh14L6
 604yrLkklAGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="282785028"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 30 Apr 2020 01:23:50 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: pbonzini@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v6 3/3] hw/vfio: let read-only flag take effect for mmap'd
 regions
Date: Thu, 30 Apr 2020 04:13:53 -0400
Message-Id: <20200430081353.31400-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430080744.31232-1-yan.y.zhao@intel.com>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yan.y.zhao@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 03:10:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.115
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, xin.zeng@intel.com, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

along side setting host page table to be read-only, the memory regions
are also required to be read-only, so that when guest writes to the
read-only & mmap'd regions, vmexits would happen and region write handlers
are called.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
---
 hw/vfio/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2a4fedfeaa..bf510e66c0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -980,6 +980,10 @@ int vfio_region_mmap(VFIORegion *region)
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


