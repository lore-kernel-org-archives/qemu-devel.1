Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47ACC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDC920838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2qn5DIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDC920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLUi-0007xq-9V
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGL-0005vI-57
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGJ-0001A3-4s
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:48 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLGI-000163-QQ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:47 -0500
Received: by mail-pl1-x641.google.com with SMTP id x17so13209601pln.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=urRb0uR9O/6+SJM1ppmaD8oGu/FOyRk842uyqGR7Ev0=;
 b=f2qn5DIYdgooPOi9Qkb1YAco3Mc5/CxypjNZiaSOaQEIFUXSlyLFpw5nhtZw1TkCFy
 i8bPo01usKnObeXsIKh3jHx39IC0y1351l2JYipgzl16gbG5ySyJ+3UJ52k6X17DUW8X
 W2OILLkRdFkb/XknAkWUAKEb+mAj1od8VOKlm84uJkKgJYSDOYOft6O/RMklDKYabk6x
 Yy8sPo+Po1aLJJVOvc1ro9iIJrgWKyruFvkda7SX0XoRy05/xhb9S32YHuaGJ5YHB6FD
 kHdOlEBMwyuxGXaZoeyLsPOkNlYFjS0Sm0cxCZq4Ijhpor2D5kczGJsp9vp3d3WdX3LM
 vIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=urRb0uR9O/6+SJM1ppmaD8oGu/FOyRk842uyqGR7Ev0=;
 b=ZW8Ctnw3+ERsOfL5k38DGaOsqV3gYZPWc8E3hOk/+evucdoEUHto2HzgpukOCtGafA
 ZZ+BrcGGFrR1k0R6FCWil/dT9iDXD/r3yvDCaP/Jo6LyJaMPfGI9LhP4/gvoXtkxVcyi
 jgpPE8hqGw5+IJra8zZOmnl7eCrXgmzP1YzRCuyTbN0fMPgAnkyci5IZzcjGXzb5AK3n
 e6SZxhlJ+dbtgYPbmEITZgDrgmwaaZD//7zshIdg5Tk0zh4dpPh4ZqQluO40HL64XYgj
 BBsNWzSeOdukG14SXLVjilieGjQyTkSfOPUvJnvYyEH7dDqe/O8UHxaCk1soHD3y8yJL
 i5PQ==
X-Gm-Message-State: APjAAAX663k4IQW8XcbOFBOUJXoZbnkqQt2sjc+X4gQUI4JmZh5PJfzY
 Fk0QO+OHvNjdBpVDyYLyTpWt/v4txCk=
X-Google-Smtp-Source: APXvYqzDLB0Cdc6haliHp39GwLXxJ8NSLhx5Hz5myqZtm7u0mMFvaoNnOlp7708Gc5dUCOPGnGqWLg==
X-Received: by 2002:a17:90a:f314:: with SMTP id
 ca20mr34091890pjb.112.1577574765446; 
 Sat, 28 Dec 2019 15:12:45 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/29] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Sun, 29 Dec 2019 10:11:20 +1100
Message-Id: <20191228231124.18307-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The separate suffixed functions were used to construct
some do_##insn function switched on mmu_idx.  The interface
is exactly identical to the *_mmuidx_ra functions.  Replace
them directly and remove the constructions.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.h       |   4 -
 target/mips/op_helper.c | 182 +++++++++++++---------------------------
 2 files changed, 60 insertions(+), 126 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ca00f41daf..c218ccc4a8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1147,10 +1147,6 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
  * MMU modes definitions. We carefully match the indices with our
  * hflags layout.
  */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _super
-#define MMU_MODE2_SUFFIX _user
-#define MMU_MODE3_SUFFIX _error
 #define MMU_USER_IDX 2
 
 static inline int hflags_mmu_index(uint32_t hflags)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 18fcee4a78..79d44da6fa 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -52,69 +52,6 @@ static void raise_exception(CPUMIPSState *env, uint32_t exception)
     do_raise_exception(env, exception, 0);
 }
 
-#if defined(CONFIG_USER_ONLY)
-#define HELPER_LD(name, insn, type)                                     \
-static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
-                             int mem_idx, uintptr_t retaddr)            \
-{                                                                       \
-    return (type) cpu_##insn##_data_ra(env, addr, retaddr);             \
-}
-#else
-#define HELPER_LD(name, insn, type)                                     \
-static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
-                             int mem_idx, uintptr_t retaddr)            \
-{                                                                       \
-    switch (mem_idx) {                                                  \
-    case 0: return (type) cpu_##insn##_kernel_ra(env, addr, retaddr);   \
-    case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);    \
-    default:                                                            \
-    case 2: return (type) cpu_##insn##_user_ra(env, addr, retaddr);     \
-    case 3: return (type) cpu_##insn##_error_ra(env, addr, retaddr);    \
-    }                                                                   \
-}
-#endif
-HELPER_LD(lw, ldl, int32_t)
-#if defined(TARGET_MIPS64)
-HELPER_LD(ld, ldq, int64_t)
-#endif
-#undef HELPER_LD
-
-#if defined(CONFIG_USER_ONLY)
-#define HELPER_ST(name, insn, type)                                     \
-static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
-                             type val, int mem_idx, uintptr_t retaddr)  \
-{                                                                       \
-    cpu_##insn##_data_ra(env, addr, val, retaddr);                      \
-}
-#else
-#define HELPER_ST(name, insn, type)                                     \
-static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
-                             type val, int mem_idx, uintptr_t retaddr)  \
-{                                                                       \
-    switch (mem_idx) {                                                  \
-    case 0:                                                             \
-        cpu_##insn##_kernel_ra(env, addr, val, retaddr);                \
-        break;                                                          \
-    case 1:                                                             \
-        cpu_##insn##_super_ra(env, addr, val, retaddr);                 \
-        break;                                                          \
-    default:                                                            \
-    case 2:                                                             \
-        cpu_##insn##_user_ra(env, addr, val, retaddr);                  \
-        break;                                                          \
-    case 3:                                                             \
-        cpu_##insn##_error_ra(env, addr, val, retaddr);                 \
-        break;                                                          \
-    }                                                                   \
-}
-#endif
-HELPER_ST(sb, stb, uint8_t)
-HELPER_ST(sw, stl, uint32_t)
-#if defined(TARGET_MIPS64)
-HELPER_ST(sd, stq, uint64_t)
-#endif
-#undef HELPER_ST
-
 /* 64 bits arithmetic for 32 bits hosts */
 static inline uint64_t get_HILO(CPUMIPSState *env)
 {
@@ -379,12 +316,12 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
     }                                                                         \
     env->CP0_LLAddr = do_translate_address(env, arg, 0, GETPC());             \
     env->lladdr = arg;                                                        \
-    env->llval = do_##insn(env, arg, mem_idx, GETPC());                       \
+    env->llval = cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());          \
     return env->llval;                                                        \
 }
-HELPER_LD_ATOMIC(ll, lw, 0x3)
+HELPER_LD_ATOMIC(ll, ldl, 0x3)
 #ifdef TARGET_MIPS64
-HELPER_LD_ATOMIC(lld, ld, 0x7)
+HELPER_LD_ATOMIC(lld, ldq, 0x7)
 #endif
 #undef HELPER_LD_ATOMIC
 #endif
@@ -400,42 +337,42 @@ HELPER_LD_ATOMIC(lld, ld, 0x7)
 void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
-    do_sb(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
+    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
 
     if (GET_LMASK(arg2) <= 2) {
-        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK(arg2) <= 1) {
-        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK(arg2) == 0) {
-        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)arg1, mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)arg1,
+                          mem_idx, GETPC());
     }
 }
 
 void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
-    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
+    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
     if (GET_LMASK(arg2) >= 1) {
-        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK(arg2) >= 2) {
-        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK(arg2) == 3) {
-        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24),
+                          mem_idx, GETPC());
     }
 }
 
@@ -453,82 +390,82 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
-    do_sb(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
+    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
 
     if (GET_LMASK64(arg2) <= 6) {
-        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) <= 5) {
-        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) <= 4) {
-        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) <= 3) {
-        do_sb(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) <= 2) {
-        do_sb(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) <= 1) {
-        do_sb(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) <= 0) {
-        do_sb(env, GET_OFFSET(arg2, 7), (uint8_t)arg1, mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 7), (uint8_t)arg1,
+                          mem_idx, GETPC());
     }
 }
 
 void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
-    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
+    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
     if (GET_LMASK64(arg2) >= 1) {
-        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) >= 2) {
-        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) >= 3) {
-        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) >= 4) {
-        do_sb(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) >= 5) {
-        do_sb(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) >= 6) {
-        do_sb(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48),
+                          mem_idx, GETPC());
     }
 
     if (GET_LMASK64(arg2) == 7) {
-        do_sb(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56), mem_idx,
-              GETPC());
+        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56),
+                          mem_idx, GETPC());
     }
 }
 #endif /* TARGET_MIPS64 */
@@ -546,14 +483,14 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 
         for (i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
-                (target_long)do_lw(env, addr, mem_idx, GETPC());
+                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 4;
         }
     }
 
     if (do_r31) {
-        env->active_tc.gpr[31] = (target_long)do_lw(env, addr, mem_idx,
-                                                    GETPC());
+        env->active_tc.gpr[31] =
+            (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
     }
 }
 
@@ -567,14 +504,14 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
-            do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
-                  GETPC());
+            cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
+                              mem_idx, GETPC());
             addr += 4;
         }
     }
 
     if (do_r31) {
-        do_sw(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
+        cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
     }
 }
 
@@ -589,14 +526,15 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
-            env->active_tc.gpr[multiple_regs[i]] = do_ld(env, addr, mem_idx,
-                                                         GETPC());
+            env->active_tc.gpr[multiple_regs[i]] =
+                cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 8;
         }
     }
 
     if (do_r31) {
-        env->active_tc.gpr[31] = do_ld(env, addr, mem_idx, GETPC());
+        env->active_tc.gpr[31] =
+            cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
     }
 }
 
@@ -610,14 +548,14 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
-            do_sd(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
-                  GETPC());
+            cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
+                              mem_idx, GETPC());
             addr += 8;
         }
     }
 
     if (do_r31) {
-        do_sd(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
+        cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
     }
 }
 #endif
-- 
2.20.1


