Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15685C433F7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF01B207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF01B207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYNu-0001Zh-TC
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jxYJN-0006cB-DK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:06:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:37267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jxYJL-0002on-4C
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:06:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0C2640547;
 Mon, 20 Jul 2020 19:06:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with SMTP id 1544DA4;
 Mon, 20 Jul 2020 19:06:35 +0300 (MSK)
Received: (nullmailer pid 15538 invoked by uid 1000);
 Mon, 20 Jul 2020 16:06:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH for-5.1] acpi: accept byte and word access to core ACPI
 registers
Date: Mon, 20 Jul 2020 19:06:27 +0300
Message-Id: <20200720160627.15491-1-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 10:57:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Simon John <git@the-jedi.co.uk>, Michael Tokarev <mjt@tls.msk.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All ISA registers should be accessible as bytes, words or dwords
(if wide enough).  Fix the access constraints for acpi-pm-evt,
acpi-pm-tmr & acpi-cnt registers.

Fixes: 5d971f9e67 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
Fixes: afafe4bbe0 (apci: switch cnt to memory api)
Fixes: 77d58b1e47 (apci: switch timer to memory api)
Fixes: b5a7c024d2 (apci: switch evt to memory api)
Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
Buglink: https://bugs.debian.org/964793
BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
BugLink: https://bugs.launchpad.net/bugs/1886318
Reported-By: Simon John <git@the-jedi.co.uk>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/acpi/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index f6d9ec4f13..ac06db3450 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -458,7 +458,8 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_evt_ops = {
     .read = acpi_pm_evt_read,
     .write = acpi_pm_evt_write,
-    .valid.min_access_size = 2,
+    .impl.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -527,7 +528,8 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_tmr_ops = {
     .read = acpi_pm_tmr_read,
     .write = acpi_pm_tmr_write,
-    .valid.min_access_size = 4,
+    .impl.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -599,7 +601,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_cnt_ops = {
     .read = acpi_pm_cnt_read,
     .write = acpi_pm_cnt_write,
-    .valid.min_access_size = 2,
+    .impl.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
-- 
2.20.1


