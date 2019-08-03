Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28924C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDED421726
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNY3Sw+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDED421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu1HD-0003Jp-7i
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 17:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GJ-0000zI-St
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GH-0005SZ-U3
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:23 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hu1GD-0005NI-Ls
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:21 -0400
Received: by mail-pf1-x441.google.com with SMTP id b13so37706398pfo.1
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+dg5JIkpSzmoy0afkqhKVUwUedH22oFzTp8ibzMq0SE=;
 b=qNY3Sw+XDQzjoWT4PxBw52H0kfB9SJ0QGxQmeR2rPEBDqbj14D4oTAb49uvqILtuwf
 WxrOCfI64/HwQNLD90HNO3IbbMw4vy9Q1t5WVSr8bmezdG4SuNpu0It8P+BcaLWHNWOV
 LYfFJsyMA8qzml31pvKrvohZuWzgGf4mhemtCZSC7/aqvrnJMvF6saYOXiE05GGL5UlL
 iloojqiMDAkHhY8VHGgVZfvtssPRdrgOWS8YllKif4xeo7fJ2PZ3Xl5HL6oLuZXIUorh
 O2LjuUrL1BX8y28tlurMMo0u/eQXrm8dQDBAWF+S85gtwrIp7tlIA4b6+o21k3VUdCxy
 F0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+dg5JIkpSzmoy0afkqhKVUwUedH22oFzTp8ibzMq0SE=;
 b=kKyCgtj7p+n6hkFk8rNoouB7l+OhLynC2IIqd9CrcigVmUWlprMBqvmIFfSs2pAJ8q
 Ik6cOLdE/eYqZZYHFYUKCCmRZ04X8t78qlSvj8u37nROQKDLS5GqQJSnwO5Evuy6qOpr
 PoAfZIV0k8T5k39lCpx9T68uaKGQB+umst4aPIisDEKZ3Kn8IYxgG1B0JxvGUmSi1qYG
 C3+lorZwRFoCHMEfGAbPbPFJaijJXoZiTLoGXQrcn44ixPOHXBK0+3ErGcKJoGYasmmQ
 vjJH4AV8qOkcH9kCj5k2HhIvaSuFsjIP0y0V6h23P3sy8QUQIgD4037r00An2LSdVj7/
 XFfg==
X-Gm-Message-State: APjAAAVPFGAaifF72tw4utCB09doxeCSvh/Wb3XYOM0PqvvIRxmh95Hl
 ribPoS3DIoeHM5WyN7w9VZgGWXFxJIE=
X-Google-Smtp-Source: APXvYqz7uW/ymngdVOZhS7j5IKDPvn/wXBmQASOXDEnJ/pwL8kLBDpvi+mpG9C7XmBI2I5bs6yi/YA==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr88114498pgr.156.1564866490564; 
 Sat, 03 Aug 2019 14:08:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x25sm110129644pfa.90.2019.08.03.14.08.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 14:08:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 14:08:00 -0700
Message-Id: <20190803210803.5701-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803210803.5701-1-richard.henderson@linaro.org>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 3/6] linux-user: Set PAGE_TARGET_1 for
 TARGET_PROT_BTI
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Transform the prot bit to a qemu internal page bit, and save
it in the page tables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h     |  2 ++
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/mmap.c          | 16 ++++++++++++++++
 target/arm/translate-a64.c |  6 +++---
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 40b140cbba..27470b73f7 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -248,6 +248,8 @@ extern intptr_t qemu_host_page_mask;
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
 #endif
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0080
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0662270300..a59a81e4b6 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1124,6 +1124,10 @@ struct target_winsize {
 #define TARGET_PROT_SEM         0x08
 #endif
 
+#ifdef TARGET_AARCH64
+#define TARGET_PROT_BTI         0x10
+#endif
+
 /* Common */
 #define TARGET_MAP_SHARED	0x01		/* Share changes */
 #define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c1a188ec0b..c1bed290f6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -83,6 +83,22 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
      */
     *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
 
+#ifdef TARGET_AARCH64
+    /*
+     * The PROT_BTI bit is only accepted if the cpu supports the feature.
+     * Since this is the unusual case, don't bother checking unless
+     * the bit has been requested.  If set and valid, record the bit
+     * within QEMU's page_flags as PAGE_TARGET_1.
+     */
+    if (prot & TARGET_PROT_BTI) {
+        ARMCPU *cpu = ARM_CPU(thread_cpu);
+        if (cpu_isar_feature(aa64_bti, cpu)) {
+            valid |= TARGET_PROT_BTI;
+            page_flags |= PAGE_TARGET_1;
+        }
+    }
+#endif
+
     return prot & ~valid ? 0 : page_flags;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 06ff3a7f2e..395e498acf 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13963,10 +13963,10 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
  */
 static bool is_guarded_page(CPUARMState *env, DisasContext *s)
 {
-#ifdef CONFIG_USER_ONLY
-    return false;  /* FIXME */
-#else
     uint64_t addr = s->base.pc_first;
+#ifdef CONFIG_USER_ONLY
+    return page_get_flags(addr) & PAGE_TARGET_1;
+#else
     int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
     unsigned int index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-- 
2.17.1


