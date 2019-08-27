Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CFC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F4E2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Y34-0000CH-8f
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1i2XzU-0005XP-BH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1i2XzT-0005lx-DD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:42:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2256 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1i2XzP-0005gF-Tz; Tue, 27 Aug 2019 05:42:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B140040871412A3A6220;
 Tue, 27 Aug 2019 17:42:03 +0800 (CST)
Received: from localhost.localdomain (10.151.151.249) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 17:41:56 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <gengdongjiu@huawei.com>, <linuxarm@huawei.com>
Date: Tue, 27 Aug 2019 17:41:55 +0800
Message-ID: <1566898915-3129-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH] hw/arm/boot: Load the Non Linux initrd to the
 memory
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Except support linux operation system, qemu also supports other
operation system which is non linux, such as microkernel system.

But now Qemu only load linux initrd, so change it to load both
linux and Non-linux initrd Image.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com> 
---
 hw/arm/boot.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a830655e1a..2e6c17975a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1056,30 +1056,31 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         exit(1);
     }
     info->entry = entry;
-    if (is_linux) {
-        uint32_t fixupcontext[FIXUP_MAX];
 
-        if (info->initrd_filename) {
-            initrd_size = load_ramdisk_as(info->initrd_filename,
-                                          info->initrd_start,
-                                          info->ram_size - info->initrd_start,
-                                          as);
-            if (initrd_size < 0) {
-                initrd_size = load_image_targphys_as(info->initrd_filename,
-                                                     info->initrd_start,
-                                                     info->ram_size -
-                                                     info->initrd_start,
-                                                     as);
-            }
-            if (initrd_size < 0) {
-                error_report("could not load initrd '%s'",
-                             info->initrd_filename);
-                exit(1);
-            }
-        } else {
-            initrd_size = 0;
+    if (info->initrd_filename) {
+        initrd_size = load_ramdisk_as(info->initrd_filename,
+                                      info->initrd_start,
+                                      info->ram_size - info->initrd_start,
+                                      as);
+        if (initrd_size < 0) {
+            initrd_size = load_image_targphys_as(info->initrd_filename,
+                                                 info->initrd_start,
+                                                 info->ram_size -
+                                                 info->initrd_start,
+                                                 as);
         }
-        info->initrd_size = initrd_size;
+        if (initrd_size < 0) {
+            error_report("could not load initrd '%s'",
+                         info->initrd_filename);
+            exit(1);
+        }
+    } else {
+        initrd_size = 0;
+    }
+    info->initrd_size = initrd_size;
+
+    if (is_linux) {
+        uint32_t fixupcontext[FIXUP_MAX];
 
         fixupcontext[FIXUP_BOARDID] = info->board_id;
         fixupcontext[FIXUP_BOARD_SETUP] = info->board_setup_addr;
-- 
2.17.1


