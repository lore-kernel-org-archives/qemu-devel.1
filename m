Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8186D2072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJLRWK8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8186D2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igykw-0000cu-9j
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybZ-0005fA-Kl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybX-0007kN-O4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:41 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybX-0007jN-GJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:39 -0500
Received: by mail-pl1-x643.google.com with SMTP id k20so5103112pll.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XtJdqyLi6EEA8LSZvbXqiDPHZfLt+fS53VoCcJ6uOsI=;
 b=XJLRWK8q8cz2kAvYvSD9kiDQmkNpb/poR4cPgyikNKbHjtfwYPxe8gF0OhTN9K412F
 p0A63UmWwZ0Hxptb28DJH97qCJpZFtl4SXgPK6BFsK8UTeGV8POetaiddUaoANovwv2T
 dJ594RQqGL/iCsbRgspWGxQZid+OaADt6nma8WQcYVnQZsqEw7LkC6d65BlN8dOwbKah
 PLhZ5VvDiHl9nejMso+Fk1i0bt/MeWvhrB2PdV0Uz5wvVTUajwVyrgIkVgVSi+QoCDsj
 S3ILxwsf+lEv9HBHHOMU2WhAcaNi8GSZkIetoKPYypXEe6FGNX30Gdfd3oBQBXirpC3E
 /yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XtJdqyLi6EEA8LSZvbXqiDPHZfLt+fS53VoCcJ6uOsI=;
 b=oknD8zCUyn8Mfh3HAOPM+r2ZIRMcK5OfqMv1AZWkxGtbpXsU9aqPQE45mEoGOC/w7t
 hnHHjIhKiZJX8dMcJ97BagCSyGaePMdTzL+euIYXUwGKYCVJJDE+fCTUR9zVWa3DpW5I
 I98QwNGuZGY1JehrFeDQz/SST1N5eMmBP40RG5H2g8XHHDbBYnpQBwUBteVWapTVt7TR
 ptduDhPH+vKK1AxG6+Xm4yWcw6WVRWE+O7Z6wGY+Jg4WbmlfvtMMcDmcnuzDucv/D1YC
 GUVkwmltrOCder7y1Ik1Q+cj/psM8ggMjXnqOmcNS3UXGPKLmbkkhCxb/cTKgEo6mJ8P
 oaHA==
X-Gm-Message-State: APjAAAWEOrTdGzm949xo+D/TLmk2HK22JR4nl+kxDExZdFis/TkSKOrV
 i02xgT6sbgg1C+hL/CRr1++mxm/ntGg=
X-Google-Smtp-Source: APXvYqyklEVUajXRAKFRcpQjCtuYTHvljH8eek+mM/ZU55n7flJLJ0WP+VdgZzZTqGqGzHhXsgkUWw==
X-Received: by 2002:a17:902:8c91:: with SMTP id
 t17mr18368521plo.225.1576534358128; 
 Mon, 16 Dec 2019 14:12:38 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 24/28] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Mon, 16 Dec 2019 12:11:54 -1000
Message-Id: <20191216221158.29572-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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


