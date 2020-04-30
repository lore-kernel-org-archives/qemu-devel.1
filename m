Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938CC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18652073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18652073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4Tk-00082l-4r
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU4TC-0007c9-F8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU4TB-0001tx-RD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:22:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:53988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jU4TB-0001tn-AJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:22:57 -0400
IronPort-SDR: sK1H+wDbanb6v1xiQoo0pxh5unhS0bBmxQQUKVR7Y8ED6WdN4WsU8bydhMlq+OS9h1lrQPYJ7j
 08jipi0Nan1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 01:22:55 -0700
IronPort-SDR: BB/YkbjgCS7MSD/zRHMjwcdqejlAWPErR/rsiva5vycjiH3kFwmShaGEvYOvljy9LMl5qkPzEX
 2P7i24tcS4EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="282784801"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 30 Apr 2020 01:22:53 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: pbonzini@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v6 2/3] hw/vfio: drop guest writes to ro regions
Date: Thu, 30 Apr 2020 04:13:04 -0400
Message-Id: <20200430081304.31346-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430080744.31232-1-yan.y.zhao@intel.com>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=yan.y.zhao@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 04:22:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.43
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

for vfio regions that are without write permission,
drop guest writes to those regions.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
---
 hw/vfio/common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..2a4fedfeaa 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -38,6 +38,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -190,6 +191,16 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint64_t qword;
     } buf;
 
+    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
+    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid write to read only vfio region (%s:region%d"
+                      "+0x%"HWADDR_PRIx" size %d)\n", vbasedev->name,
+                      region->nr, addr, size);
+
+        return;
+    }
+
     switch (size) {
     case 1:
         buf.byte = data;
@@ -215,8 +226,6 @@ void vfio_region_write(void *opaque, hwaddr addr,
                      addr, data, size);
     }
 
-    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
-
     /*
      * A read or write to a BAR always signals an INTx EOI.  This will
      * do nothing if not pending (including not in INTx mode).  We assume
-- 
2.17.1


