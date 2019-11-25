Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C91FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 21:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C8620706
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 21:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="topCAGdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C8620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZLXt-00053i-Cr
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 16:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iZLRy-0001ie-7F
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iZLRw-0001aq-Jw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:59:14 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iZLRw-0001a9-ER
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:59:12 -0500
Received: by mail-pg1-x544.google.com with SMTP id e17so7780925pgd.7
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=dRr8B4D0QfpZhllEEeSHxPEqmvzQu8jn4FWTzqm+6a8=;
 b=topCAGdbEvh4ucg69c3OK+cglJdPGo3AXNHzyU1QtAmNrUH4mq3SBP+rBL/Z2ALhfE
 ryrvt1ue1yvPGyAE2HqKD0yMcoIYEb6NJLlFCAu74T3+cdZ46FPuoLOntQWl/LHceKmW
 TJLO0IOUvdR/300VuiVz2IGC4iY9dcosg5UYRinN2iqRlfMGLqP87026ZNe3pIDQDdME
 6pkK99UULaFSe7A3pagx11DMrKGAtHEL7Lg0dzzZj64bGWpBUvj9+IZgmCV1BqT9K7Hz
 n1Adm57af1WmbMGxBMJqLP9T1kJjJdpKWV3RbPWs6D1iY5XRI7IahwAkrKp97W01VOYk
 c2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dRr8B4D0QfpZhllEEeSHxPEqmvzQu8jn4FWTzqm+6a8=;
 b=ouxnmQbEKjV8b4q4dAfYe6JfsEbrAYV+h4fSf9AdlJOQIxq23iBkUGYMcM+Meav4sG
 I3ToxoVPMUgCTHes5IQtbN7mmJ8MZc6kE8/kxZh4Qk+PCH2DcPLWRcag1hFvPV0C6ycZ
 gBL6R9jsVRzA8rQEzO0rBQWTyX1sD+qsM+vqTvtyAPVa4K4rFLvRCKzueViMBWBLXkOm
 umrA00ZmdmPQuEXS1jG6BVLhbHYPAvtbjFQsHy/m+Nh4uDB62uCJ3rQ24xr0HUMxypYU
 ZRIG3ikOnKdYvzFQt2+0dFvjtpFN4PuzTkQjxqkHCzL8t+1Df9VS6uW0C3EeD6DlvWic
 cjmA==
X-Gm-Message-State: APjAAAWJ0rKLDBxsE2a3ugkWg84Nv4xRNRmtABgN40D8r+g86ELBJJ5l
 bP3wqyVgkyWU03hF8kzVK0wPQZptAvo=
X-Google-Smtp-Source: APXvYqzl69ZgHfQ83bZoDrdJU75P3uhyzIK8ONf7tpzMD0njOBv4vQylsylqOiB8j8k/rW/6tCaaxg==
X-Received: by 2002:aa7:9301:: with SMTP id 1mr17907254pfj.65.1574715550951;
 Mon, 25 Nov 2019 12:59:10 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
 by smtp.gmail.com with ESMTPSA id q20sm9369044pff.134.2019.11.25.12.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 12:59:10 -0800 (PST)
Subject: [PULL 2/2] hw/riscv: Add optional symbol callback ptr to
 riscv_load_kernel()
Date: Mon, 25 Nov 2019 12:58:54 -0800
Message-Id: <20191125205854.226672-3-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191125205854.226672-1-palmerdabbelt@google.com>
References: <20191125205854.226672-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 "Zhuang, Siwei (Data61, Kensington NSW)" <Siwei.Zhuang@data61.csiro.au>,
 Siwei Zhuang <siwei.zhuang@data61.csiro.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

From: "Zhuang, Siwei (Data61, Kensington NSW)" <Siwei.Zhuang@data61.csiro.au>

This patch adds an optional function pointer, "sym_cb", to
riscv_load_kernel() which provides the possibility to access the symbol
table during kernel loading.

The pointer is ignored, if supplied with Image or uImage file.

The Spike board requires the access to locate the HTIF symbols.

Fixes: 0ac24d56c5e7 ("hw/riscv: Split out the boot functions")
Buglink: https://bugs.launchpad.net/qemu/+bug/1835827
Signed-off-by: Siwei Zhuang <siwei.zhuang@data61.csiro.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/boot.c         | 7 ++++---
 hw/riscv/sifive_e.c     | 2 +-
 hw/riscv/sifive_u.c     | 3 ++-
 hw/riscv/spike.c        | 6 +++---
 hw/riscv/virt.c         | 3 ++-
 include/hw/riscv/boot.h | 3 ++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 7fee98d2f8..027303d2a3 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -114,12 +114,13 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-target_ulong riscv_load_kernel(const char *kernel_filename)
+target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
+    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
+                         &kernel_entry, NULL, &kernel_high, 0,
+                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return kernel_entry;
     }
 
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0f9d641a0e..8a6b0348df 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -111,7 +111,7 @@ static void riscv_sifive_e_init(MachineState *machine)
                           memmap[SIFIVE_E_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, NULL);
     }
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9552abf4dd..0140e95732 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -344,7 +344,8 @@ static void riscv_sifive_u_init(MachineState *machine)
                                  memmap[SIFIVE_U_DRAM].base);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                                  NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8bbffbcd0f..8823681783 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -184,7 +184,7 @@ static void spike_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
     }
 
     /* reset vector */
@@ -273,7 +273,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
     }
 
     /* reset vector */
@@ -359,7 +359,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
     }
 
     /* reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 74f2dce81c..c44b865959 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -479,7 +479,8 @@ static void riscv_virt_board_init(MachineState *machine)
                                  memmap[VIRT_DRAM].base);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                                  NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 66075d0e57..df80051fbc 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -28,7 +28,8 @@ void riscv_find_and_load_firmware(MachineState *machine,
 char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr);
-target_ulong riscv_load_kernel(const char *kernel_filename);
+target_ulong riscv_load_kernel(const char *kernel_filename,
+                               symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
 
-- 
2.24.0.432.g9d3f5f5b63-goog


