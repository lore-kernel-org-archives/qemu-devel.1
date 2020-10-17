Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D5C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93E120658
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKUc/F0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93E120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnGK-00073Q-26
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmq6-0004pA-Hy
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:56097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmq4-00045W-Qk
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id a72so6128172wme.5
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AHKgFTwyonlJMqUSo/VQEjDBt8yNtjw9Fbnqm+Zig2A=;
 b=JKUc/F0ME2xaE+SsbpW6aq8Xb+cFkNBz4zNuxePa3VgSfgTvGOtbB0gYRaqFxY0JxT
 dFPWcXYNCNAo1kc/iH+W58i2WF86sYEZxrYCnus9T2SW9ii/YdAAzzp9eipL3Hpv++lY
 uW2M0hx2IekSLiWSOhoapNFdJ6pcvdBBaqr3HO65sQKULRjwNoP4ahcoQGVaOL+Eq3sm
 ZP0UztDTu/4WT7QEYCJM7iBmosYxBRFo/o8BCdfLjDVD8WlfpxHJYuN4uE1VXxQzB+ru
 tAtNESc+MxzsTcHSPFzLhCZQb4asPUF5z+cS4U5x5fwUGcuQZ/Xw4p8lHdOWqX7GNMqx
 kZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AHKgFTwyonlJMqUSo/VQEjDBt8yNtjw9Fbnqm+Zig2A=;
 b=glJNZJS7VoFV8Gv3Io6XNS1FzMDDTAZ0maDCgr6+tK7DNCfeJcS3oda5RVM1udVFGn
 MCLrw7GAicE8GhoZf47UiY21As96i9qx1we3pXL9oZdAED1jLK4HmiTEnAEK9kCRPQtR
 mgI/mtY5Hwg1u+qyeOGHzjGY91t7QK5dbHbMaGtPYohhWr2Suw7F3cL8oGQ9j3PQjBmq
 DHyUcrucVPb03RbUoyF8t8fKtTfVij4213a6asJlrqM+9X0IKBwmIMbJVutKOVoK63Fn
 QF5N5ZLofiqKIAz0ny7HibLfpK809x0rMu75qOwsR8VOS1ux8YvdBYqDpLZB+rL98kJP
 4lpg==
X-Gm-Message-State: AOAM532oSnh7KyC9gRNRM29VT4ZnTV5M1CF+X2VF2WJIIX8sD7j/k8nY
 i1hPBKBvagcv2JUnTWZNmRVLldw6Y3M=
X-Google-Smtp-Source: ABdhPJziIqazOQvmXQvGUIrrm0X3L/uh1C92KlG2t5MI5XxWjIevMoNtG4CJvuHoiZ9Cf7pBWDT73Q==
X-Received: by 2002:a1c:bc03:: with SMTP id m3mr8929428wmf.171.1602943539165; 
 Sat, 17 Oct 2020 07:05:39 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id r1sm9098034wro.18.2020.10.17.07.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/44] hw/mips: Remove exit(1) in case of missing ROM
Date: Sat, 17 Oct 2020 16:02:36 +0200
Message-Id: <20201017140243.1078718-38-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

This patch updates MIPS-based machines to allow starting them without ROM.
In this case CPU starts to execute instructions from the empty memory,
but QEMU allows introspecting the machine configuration.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <159531210571.24117.231100997794891819.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/fuloong2e.c |  8 +++-----
 hw/mips/jazz.c      |  8 +++-----
 hw/mips/malta.c     | 11 ++++-------
 hw/mips/mipssim.c   | 10 +++-------
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index de66215f95f..a9e0c2f8d30 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -337,10 +337,8 @@ static void mips_fuloong2e_init(MachineState *machine)
         kernel_entry = load_kernel(env);
         write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
-        if (bios_name == NULL) {
-                bios_name = FULOONG_BIOSNAME;
-        }
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                  bios_name ?: FULOONG_BIOSNAME);
         if (filename) {
             bios_size = load_image_targphys(filename, 0x1fc00000LL,
                                             BIOS_SIZE);
@@ -350,7 +348,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         }
 
         if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-            !kernel_filename && !qtest_enabled()) {
+            bios_name && !qtest_enabled()) {
             error_report("Could not load MIPS bios '%s'", bios_name);
             exit(1);
         }
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 8f1ad55ba34..71448f72ac9 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -218,10 +218,7 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
 
     /* load the BIOS image. */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name ?: BIOS_FILENAME);
     if (filename) {
         bios_size = load_image_targphys(filename, 0xfff00000LL,
                                         MAGNUM_BIOS_SIZE);
@@ -229,7 +226,8 @@ static void mips_jazz_init(MachineState *machine,
     } else {
         bios_size = -1;
     }
-    if ((bios_size < 0 || bios_size > MAGNUM_BIOS_SIZE) && !qtest_enabled()) {
+    if ((bios_size < 0 || bios_size > MAGNUM_BIOS_SIZE)
+        && bios_name && !qtest_enabled()) {
         error_report("Could not load MIPS bios '%s'", bios_name);
         exit(1);
     }
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index beb0f43941a..9d1a3b50b7a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1332,10 +1332,8 @@ void mips_malta_init(MachineState *machine)
         /* Load firmware from flash. */
         if (!dinfo) {
             /* Load a BIOS image. */
-            if (bios_name == NULL) {
-                bios_name = BIOS_FILENAME;
-            }
-            filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+            filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                      bios_name ?: BIOS_FILENAME);
             if (filename) {
                 bios_size = load_image_targphys(filename, FLASH_ADDRESS,
                                                 BIOS_SIZE);
@@ -1344,9 +1342,8 @@ void mips_malta_init(MachineState *machine)
                 bios_size = -1;
             }
             if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-                !kernel_filename && !qtest_enabled()) {
-                error_report("Could not load MIPS bios '%s', and no "
-                             "-kernel argument was specified", bios_name);
+                bios_name && !qtest_enabled()) {
+                error_report("Could not load MIPS bios '%s'", bios_name);
                 exit(1);
             }
         }
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 97dcc232476..aaa62a0f4b7 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -177,10 +177,7 @@ mips_mipssim_init(MachineState *machine)
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
     /* Load a BIOS / boot exception handler image. */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name ?: BIOS_FILENAME);
     if (filename) {
         bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
         g_free(filename);
@@ -188,10 +185,9 @@ mips_mipssim_init(MachineState *machine)
         bios_size = -1;
     }
     if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-        !kernel_filename && !qtest_enabled()) {
+        bios_name && !qtest_enabled()) {
         /* Bail out if we have neither a kernel image nor boot vector code. */
-        error_report("Could not load MIPS bios '%s', and no "
-                     "-kernel argument was specified", bios_name);
+        error_report("Could not load MIPS bios '%s'", bios_name);
         exit(1);
     } else {
         /* We have a boot vector start address. */
-- 
2.26.2


