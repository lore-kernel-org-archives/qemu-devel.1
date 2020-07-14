Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AD92065D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AD92065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvL7H-0001NR-BS
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jvL6h-0000wu-Tq
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:36:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:38143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jvL6f-0000eg-Lm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:36:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6CA0404A8;
 Tue, 14 Jul 2020 16:36:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with SMTP id 05537B8;
 Tue, 14 Jul 2020 16:36:22 +0300 (MSK)
Received: (nullmailer pid 2143 invoked by uid 1000);
 Tue, 14 Jul 2020 13:36:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 for-5.1] acpi-pm-tmr: allow small-size reads
Date: Tue, 14 Jul 2020 16:27:26 +0300
Message-Id: <1594733782.723411.2142.nullmailer@msgid.tls.msk.ru>
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 09:36:23
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
Cc: Simon John <git@the-jedi.co.uk>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As found in LP#1886318, MacOS Catalina performs 2-byte reads
on the acpi timer address space while the spec says it should
be 4-byte. Allow any small reads.

Reported-By: Simon John <git@the-jedi.co.uk>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
BugLink: https://bugs.launchpad.net/bugs/1886318
Fixes: 77d58b1e47c8d1c661f98f12b47ab519d3561488 (apci: switch timer to memory api)
Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
---
 hw/acpi/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v2: fixed bug#, use the right form of S-o-b, and allow up to 1 byte reads.
v3: added BugLink & Fixes references, updated comment

I'm applying this to debian qemu package, need the fix
faster in order to release security updates for other
branches.

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -530,7 +530,10 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_tmr_ops = {
     .read = acpi_pm_tmr_read,
     .write = acpi_pm_tmr_write,
-    .valid.min_access_size = 4,
+    .impl.min_access_size = 4,
+     /* at least MacOS Catalina reads 2 bytes and fails if it doesn't work */
+     /* allow 1-byte reads too, memory API will do all the conversion needed */
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
-- 
2.20.1


