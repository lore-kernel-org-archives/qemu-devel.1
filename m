Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E249C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 22:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0375F22201
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 22:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0375F22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPDQ3-0000oZ-3j
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 18:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jPDOP-00071G-L8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 18:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jPDOO-0000VZ-HR
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 18:53:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:18259)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jPDOO-0000VL-7q
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 18:53:56 -0400
IronPort-SDR: w73bE0b4ckGwLW16Fg18OZ6KrytEsDkcUIs/DTQ0LGmbab5zQhrPUE1hfaaeZtwQbhlYcMmaoO
 D4qbCJ0yRtDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 15:53:55 -0700
IronPort-SDR: 3TW7eSp7SQLZmXsX7nV7iMsZRJtGtoEfygQ4+XPKVScTldtCHM2ImoIIfOn/l1hCmQYu/EpuI/
 bFvSW9Dx+clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; d="scan'208";a="246130243"
Received: from dpdk-zhirun.sh.intel.com ([10.67.119.121])
 by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 15:53:53 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: pbonzini@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v4 2/3] hw/vfio: drop guest writes to ro regions
Date: Fri, 17 Apr 2020 07:44:46 +0000
Message-Id: <20200417074446.28573-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
---
 hw/vfio/common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..b6956a8098 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -38,6 +38,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -190,6 +191,15 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint64_t qword;
     } buf;
 
+    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
+    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid write to read only vfio region 0x%"
+                      HWADDR_PRIx" size %u\n", addr, size);
+
+        return;
+    }
+
     switch (size) {
     case 1:
         buf.byte = data;
@@ -215,8 +225,6 @@ void vfio_region_write(void *opaque, hwaddr addr,
                      addr, data, size);
     }
 
-    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
-
     /*
      * A read or write to a BAR always signals an INTx EOI.  This will
      * do nothing if not pending (including not in INTx mode).  We assume
-- 
2.17.1


