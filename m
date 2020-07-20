Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9C4C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FAF20773
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FAF20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXwx-0006bo-KN
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jxXsw-0005hr-7Y
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:39:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:45077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jxXsu-0007k9-3y
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:39:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 37FA440547;
 Mon, 20 Jul 2020 18:39:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with SMTP id C412DA4;
 Mon, 20 Jul 2020 18:39:17 +0300 (MSK)
Received: (nullmailer pid 12314 invoked by uid 1000);
 Mon, 20 Jul 2020 15:39:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH for-5.1] acpi: allow accessing acpi-cnt register by byte
Date: Mon, 20 Jul 2020 18:39:15 +0300
Message-Id: <20200720153915.12267-1-mjt@msgid.tls.msk.ru>
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
Cc: Michael Tokarev <mjt@tls.msk.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From the ACPI spec (4.8.3.2.1 PM1 Control Registers):

Register Location: <PM1a_CNT_BLK / PM1b_CNT_BLK> System I/O or Memory Space
Default Value:     00h
Attribute:         Read/Write
Size:              PM1_CNT_LEN (2 bytes)
The PM1 control registers contain the fixed hardware feature control bits.
These bits can be split between two registers: PM1a_CNT or PM1b_CNT.
Each register grouping can be at a different 32-bit aligned address
and is pointed to by the PM1a_CNT_BLK or PM1b_CNT_BLK. The values
for these pointers to the register space are found in the FADT.
Accesses to PM1 control registers are accessed through byte
and word accesses.

So allow 1-byte access too, not only 2-byte.

Fixes: afafe4bbe0cf7d3318e1ac7b40925561f86a6bd4
Fixes: 5d971f9e672507210e77d020d89e0e89165c8fc9
Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
Buglink: https://bugs.debian.org/964793
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/acpi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index f6d9ec4f13..2c1199d9dc 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -599,7 +599,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
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


