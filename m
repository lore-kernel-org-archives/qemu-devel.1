Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F164C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4402206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4402206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtWK-0001cK-Rd
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hang.yuan@linux.intel.com>) id 1hhtV2-0000sz-Ct
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hang.yuan@linux.intel.com>) id 1hhtV1-0006Ow-AM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:25:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:65182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hang.yuan@linux.intel.com>)
 id 1hhtUx-0006JA-LQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:25:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jul 2019 03:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; d="scan'208";a="184222137"
Received: from henry-optiplex-7050.bj.intel.com ([10.238.156.132])
 by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2019 03:25:16 -0700
From: hang.yuan@linux.intel.com
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 18:15:29 +0800
Message-Id: <1561976129-31086-1-git-send-email-hang.yuan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH v2] target/i386: HAX: Enable ROM/ROM device
 memory region support
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
Cc: Hang Yuan <hang.yuan@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hang Yuan <hang.yuan@linux.intel.com>

Add ROM and ROM device memory region support in HAX. Their memory region is
read only and write access will generate EPT violation. The violation will be
handled in the HAX kernel with the following patch.

https://github.com/intel/haxm/commit/33ceea09a1655fca12c47f1e112b1d269357ff28

v2: fix coding style problems

Signed-off-by: Hang Yuan <hang.yuan@linux.intel.com>
---
 target/i386/hax-mem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 6bb5a24917..a8bfd37977 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -175,13 +175,10 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
     uint64_t host_va;
     uint32_t max_mapping_size;
 
-    /* We only care about RAM and ROM regions */
-    if (!memory_region_is_ram(mr)) {
-        if (memory_region_is_romd(mr)) {
-            /* HAXM kernel module does not support ROMD yet  */
-            warn_report("Ignoring ROMD region 0x%016" PRIx64 "->0x%016" PRIx64,
-                        start_pa, start_pa + size);
-        }
+    /* We only care about RAM/ROM regions and ROM device */
+    if (memory_region_is_rom(mr) || (memory_region_is_romd(mr))) {
+        flags |= HAX_RAM_INFO_ROM;
+    } else if (!memory_region_is_ram(mr)) {
         return;
     }
 
-- 
2.21.0


