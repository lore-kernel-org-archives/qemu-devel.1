Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB7C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA88E207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKjg5vD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA88E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haAHt-0006Yy-A5
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eR-0006yT-Fi
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eP-00025n-EM
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:11 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eL-00023j-Lt
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:07 -0400
Received: by mail-pl1-x643.google.com with SMTP id cl9so2977512plb.10
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8gZ72JCMlT8064Ktz+1j8wDvXoAY1RQH0DlIXahc3os=;
 b=vKjg5vD8yHfBnInz12k6i0FkjKxx4XKmqSZO28APi0A7MMidIQGQfPAKWWJIZFt+44
 xyx/TYagZ/qh3hswrpxdbp1iGeTT0hXzWqtkdsqijKj/c67DnqKjZUDerUl80qbuGLiR
 im27Nog4Fl3/iigTIQPZwdihNYN5vw1xuHUnlbDU6/rgVEb1FEWuxgF5tZSxOnId8zBb
 4+qwAHk74wzsrpvSMT9uAgJfhVIvPIi8UYcBfm/bRKbUGiNbs9fMfSbFzx4BDjBYjH/u
 e99YG9ftjpzk6PKGf/XbohGoqQl0xP8BKQJos9h/gthYmqoQMjlMmMCaxJoDO/FW2YQ0
 4Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8gZ72JCMlT8064Ktz+1j8wDvXoAY1RQH0DlIXahc3os=;
 b=ib9LZY90v9O5i7aMMv8fwd4Zjmakz+OSuU25c2a50u4tdgB2Cc8e6Wf1fvbzcBXEVe
 J/5DBPAHJkBXS3+7yH2vG1vaj6dRCZwI5Cnk9DzCn4U/e5nTWI3tR3O8DzJ9o8HVUu3A
 uxo4Pi6I6ZtrYQ/deVPBIYOnZMvLqe9T+sea9laU1wElEjV7e4Z9cHMvflZwCGbnQyvB
 KJB1Uw+qtedrR1yh7vcbr8VbIKV1Id6suNVV8OvVgHJ96/cUSBTB5fgD7roASx2rv5po
 32qUYvBUbEsnVdVqj3n7/LjsxwLZWN1AGi+RXFiExje6HlCLI/iAR1yiUGMVjWETWegX
 L1hQ==
X-Gm-Message-State: APjAAAUCGCZmLqiSPxsz9q39PjLixERTz7Pv64+LmpTqDY1WmBLzH1ni
 nASxjIR6/aov/I/5QOt9fY/Rpl+erwo=
X-Google-Smtp-Source: APXvYqzO6CBpcM2ufqtsHJWPPckJAQnukF9N7OI585iSBgvpviaZkTXynqJQXakd9nKgP8Bo4d59+g==
X-Received: by 2002:a17:902:7043:: with SMTP id
 h3mr7255866plt.10.1560132183593; 
 Sun, 09 Jun 2019 19:03:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.03.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:03:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:15 -0700
Message-Id: <20190610020218.9228-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PULL 36/39] cpu: Remove CPU_COMMON
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This macro is now always empty, so remove it.  This leaves the
entire contents of CPUArchState under the control of the guest
architecture.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 2 --
 target/alpha/cpu.h      | 3 ---
 target/arm/cpu.h        | 4 +---
 target/cris/cpu.h       | 2 --
 target/hppa/cpu.h       | 3 ---
 target/i386/cpu.h       | 4 +---
 target/lm32/cpu.h       | 2 --
 target/m68k/cpu.h       | 2 --
 target/microblaze/cpu.h | 2 --
 target/mips/cpu.h       | 2 --
 target/moxie/cpu.h      | 3 ---
 target/nios2/cpu.h      | 2 --
 target/openrisc/cpu.h   | 2 --
 target/ppc/cpu.h        | 2 --
 target/riscv/cpu.h      | 3 ---
 target/s390x/cpu.h      | 2 --
 target/sh4/cpu.h        | 2 --
 target/sparc/cpu.h      | 2 --
 target/tilegx/cpu.h     | 2 --
 target/tricore/cpu.h    | 2 --
 target/unicore32/cpu.h  | 2 --
 target/xtensa/cpu.h     | 2 --
 22 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 006f8db9cf..9bc713a70b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -231,8 +231,6 @@ typedef struct CPUTLB { } CPUTLB;
 
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
-#define CPU_COMMON  /* Nothing */
-
 /*
  * This structure must be placed in ArchCPU immedately
  * before CPUArchState, as a field named "neg".
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 94fbc00a3b..5d6fb222b5 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -251,9 +251,6 @@ struct CPUAlphaState {
     /* This alarm doesn't exist in real hardware; we wish it did.  */
     uint64_t alarm_expire;
 
-    /* Those resources are used only in QEMU core */
-    CPU_COMMON
-
     int error_code;
 
     uint32_t features;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5965c52f0c..8fa9772c9d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -645,9 +645,7 @@ typedef struct CPUARMState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
-    /* Fields after CPU_COMMON are preserved across CPU reset. */
+    /* Fields after this point are preserved across CPU reset. */
 
     /* Internal CPU feature flags.  */
     uint64_t features;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index ad93d1a9ee..9d2a80d995 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -163,8 +163,6 @@ typedef struct CPUCRISState {
         /* Fields up to this point are cleared by a CPU reset */
         struct {} end_reset_fields;
 
-        CPU_COMMON
-
         /* Members from load_info on are preserved across resets.  */
         void *load_info;
 } CPUCRISState;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f7c6205218..c7db2eca9a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -197,9 +197,6 @@ struct CPUHPPAState {
     target_ureg cr_back[2];  /* back of cr17/cr18 */
     target_ureg shadow[7];   /* shadow registers */
 
-    /* Those resources are used only in QEMU core */
-    CPU_COMMON
-
     /* ??? The number of entries isn't specified by the architecture.  */
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7580a86e5..edad6e1efb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1289,9 +1289,7 @@ typedef struct CPUX86State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
-    /* Fields after CPU_COMMON are preserved across CPU reset. */
+    /* Fields after this point are preserved across CPU reset. */
 
     /* processor features (e.g. for CPUID insn) */
     /* Minimum level/xlevel/xlevel2, based on CPU model + features */
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 324bc90f81..3e10a693a3 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -159,8 +159,6 @@ struct CPULM32State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     uint32_t eba;       /* exception base address */
     uint32_t deba;      /* debug exception base address */
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d92263b750..1ebd360afb 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -143,8 +143,6 @@ typedef struct CPUM68KState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     uint32_t features;
 } CPUM68KState;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d90c4fbcb5..98b4d915d7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -266,8 +266,6 @@ struct CPUMBState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* These fields are preserved on reset.  */
 
     struct {
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 62af24937d..bbf1aa8b0d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1041,8 +1041,6 @@ struct CPUMIPSState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index c6b681531d..2b596d5d45 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -45,9 +45,6 @@ typedef struct CPUMoxieState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
-
-    CPU_COMMON
-
 } CPUMoxieState;
 
 #include "qom/cpu.h"
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 8cc3d4971e..e40ee27e53 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -167,8 +167,6 @@ struct CPUNios2State {
 
     uint32_t irq_pending;
 #endif
-
-    CPU_COMMON
 };
 
 /**
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 51723e9312..9b80834d68 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -286,8 +286,6 @@ typedef struct CPUOpenRISCState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     uint32_t cpucfgr;         /* CPU configure register */
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e8962e4655..c93ebc4c10 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -999,8 +999,6 @@ struct CPUPPCState {
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
 
-    CPU_COMMON
-
     /* MMU context - only relevant for full system emulation */
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ed7031915..a935b17dbd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -171,9 +171,6 @@ struct CPURISCVState {
 
     float_status fp_status;
 
-    /* QEMU */
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     QEMUTimer *timer; /* Internal timer */
 };
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 21688b7c8c..cb103bc3e7 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -114,8 +114,6 @@ struct CPUS390XState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
 #if !defined(CONFIG_USER_ONLY)
     uint32_t core_id; /* PoP "CPU address", same as cpu_index */
     uint64_t cpuid;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index e266db411f..08cf275f79 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -179,8 +179,6 @@ typedef struct CPUSH4State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved over CPU reset. */
     int id;			/* CPU model */
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index a3c4f47d40..49e0349a81 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -446,8 +446,6 @@ struct CPUSPARCState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     target_ulong version;
     uint32_t nwindows;
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index deb3e836ea..c2acb43c2b 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -93,8 +93,6 @@ typedef struct CPUTLGState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
-
-    CPU_COMMON
 } CPUTLGState;
 
 #include "qom/cpu.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 03b293c1f6..52b07c73bf 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -184,8 +184,6 @@ struct CPUTriCoreState {
     int error_code;
     uint32_t hflags;    /* CPU State */
 
-    CPU_COMMON
-
     /* Internal CPU feature flags.  */
     uint64_t features;
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 39beb32366..6b459dacde 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -55,8 +55,6 @@ typedef struct CPUUniCore32State {
         float_status fp_status;
     } ucf64;
 
-    CPU_COMMON
-
     /* Internal CPU feature flags.  */
     uint32_t features;
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index e2d7e8371d..bfc6604b76 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -541,8 +541,6 @@ typedef struct CPUXtensaState {
 
     /* Watchpoints for DBREAK registers */
     struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
-
-    CPU_COMMON
 } CPUXtensaState;
 
 /**
-- 
2.17.1


