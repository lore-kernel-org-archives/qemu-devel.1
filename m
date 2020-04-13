Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB591C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3E620737
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3E620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNska-00049c-Q1
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 02:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsjr-0003IR-VI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jNsjq-0006gv-5A
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:38:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:33140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jNsjo-0006gb-EC
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:38:33 -0400
IronPort-SDR: dVctFnm20N05LAnKRfkIcVak6KWnLKo3h/P/sEwloeSXs8FxUGq8MlpHT2OhEZL/MWqukp8qVc
 G5LhJv19djmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 23:38:30 -0700
IronPort-SDR: v7W8ERY5H+032SlrriuMM451Js3srNohW6xGJMlTsDrjMZ5mJqCfllAj/R+Or27QyDHfB9nPLM
 hSWDDawfO5SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="453062288"
Received: from dpdk-zhirun.sh.intel.com ([10.67.119.121])
 by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2020 23:38:28 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] memory: drop guest writes to read-only ram device
 regions
Date: Mon, 13 Apr 2020 06:37:13 +0000
Message-Id: <20200413063713.84659-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413063627.84608-1-yan.y.zhao@intel.com>
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, Xin Zeng <xin.zeng@intel.com>,
 alex.williamson@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

for ram device regions, drop guest writes if the regions is read-only.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
---
 memory.c     | 6 +++++-
 trace-events | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 601b749906..a380b59980 100644
--- a/memory.c
+++ b/memory.c
@@ -1312,7 +1312,11 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 {
     MemoryRegion *mr = opaque;
 
-    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
+    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data,
+                                         size, mr->readonly);
+    if (mr->readonly) {
+        return;
+    }
 
     switch (size) {
     case 1:
diff --git a/trace-events b/trace-events
index 42107ebc69..e1de662973 100644
--- a/trace-events
+++ b/trace-events
@@ -61,7 +61,7 @@ memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value,
 memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, bool readonly) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u" " is_readonly_region=%d"
 flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
-- 
2.17.1


