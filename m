Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D82C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86550206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7BCqQq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86550206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORwc-0000ns-Op
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpU-000617-Kp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpT-0005wW-6u
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpT-0005wK-0U
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id y24so15737876wma.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=en3XxeI0kUhj1g+8oDCU8qm2/eo411eCLElDQvibSv4=;
 b=A7BCqQq3N+Wg72bkKjkAjNpf8sRBALo3rR1DHkl0MeO1HpWECTMdvIR4BgVqeLVY2M
 S9/ZFG2WHFHiaQ+rBEUzzd/H4jjOboS5wq/nAgDZSNXzeAziS/Cd/PMq+LQMd/mJVh9u
 vk1LBwC20ovfwekRoiMuYt85RGZ9tlsbo2x/zu/NbnMIvFy3Bb3GbFPw8O+oWuKfyjLY
 JpqAH2gv2efRDNNvdTa4C/dSyJ8auSM3qhFSdZC3qeXQLGs/WkIh4lJsrobSENQvB0uG
 ZQDuHxL5CJdCT5pSddpvx1I4UJlCUiWC1RHIfM9TKPvnaP03E2pW/AKIPfUy/FyVuyf0
 Hxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=en3XxeI0kUhj1g+8oDCU8qm2/eo411eCLElDQvibSv4=;
 b=WruGjUiYP/De4EYNKY+Z8CVLfm/r3dDmE6VMxMUyOXGIIy1L/f4pCMVI1dHRiVosEI
 Z2hWuXcKx2D2A+JOUaVZZRrrwFPO5AkUBQOZqCJTxMeZTvr/+tdbxIcNQKT+hzEb2D02
 yM4k4idjqa8VPBTyDHaipv0cCsRU8awwVbyzlqtRnjSzhQ25Or54rd2Lpwyy8t6BToxT
 35iVQD4vTseJ2mshUqFBMHsB8lYg0Ax2uhYHgyGEo6DaI0ruP616ikjFU5nkbnQFUZZh
 HDGlSSdmLG9ImCq3IJdJ5Z5gqQkM9gRmhmzn2yFRdNvSZlS0qeqyFft4pFEpKy5Tk9Ot
 FBzA==
X-Gm-Message-State: AGi0PuZNWgRfNlr7Qg8Y1s2I4x8GDBs7GC2uhoqLLYwD2O0URkbs65Ew
 f+vgT0WMmwyqkf2rjtASylG+mA==
X-Google-Smtp-Source: APiQypIf2fpYW3p8BiEg/hksgpPmsBtHSHfY3BnneXKQaCTzZpVI6QADBnnw7z0f+9XSfnmd6Q5Rtg==
X-Received: by 2002:a1c:e187:: with SMTP id y129mr1574429wmg.133.1586894802006; 
 Tue, 14 Apr 2020 13:06:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y9sm19405924wmm.26.2020.04.14.13.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3AD241FF91;
 Tue, 14 Apr 2020 21:06:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] linux-user/ppc: Fix padding in mcontext_t for ppc64
Date: Tue, 14 Apr 2020 21:06:19 +0100
Message-Id: <20200414200631.12799-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The padding that was added in 95cda4c44ee was added to a union,
and so it had no effect.  This fixes misalignment errors detected
by clang sanitizers for ppc64 and ppc64le.

In addition, only ppc64 allocates space for VSX registers, so do
not save them for ppc32.  The kernel only has references to
CONFIG_SPE in signal_32.c, so do not attempt to save them for ppc64.

Fixes: 95cda4c44ee
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/ppc/signal.c | 69 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index ecd99736b7e..20a02c197cb 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -35,12 +35,26 @@ struct target_mcontext {
     target_ulong mc_gregs[48];
     /* Includes fpscr.  */
     uint64_t mc_fregs[33];
+
 #if defined(TARGET_PPC64)
     /* Pointer to the vector regs */
     target_ulong v_regs;
+    /*
+     * On ppc64, this mcontext structure is naturally *unaligned*,
+     * or rather it is aligned on a 8 bytes boundary but not on
+     * a 16 byte boundary.  This pad fixes it up.  This is why we
+     * cannot use ppc_avr_t, which would force alignment.  This is
+     * also why the vector regs are referenced in the ABI by the
+     * v_regs pointer above so any amount of padding can be added here.
+     */
+    target_ulong pad;
+    /* VSCR and VRSAVE are saved separately.  Also reserve space for VSX. */
+    struct {
+        uint64_t altivec[34 + 16][2];
+    } mc_vregs;
 #else
     target_ulong mc_pad[2];
-#endif
+
     /* We need to handle Altivec and SPE at the same time, which no
        kernel needs to do.  Fortunately, the kernel defines this bit to
        be Altivec-register-large all the time, rather than trying to
@@ -48,32 +62,14 @@ struct target_mcontext {
     union {
         /* SPE vector registers.  One extra for SPEFSCR.  */
         uint32_t spe[33];
-        /* Altivec vector registers.  The packing of VSCR and VRSAVE
-           varies depending on whether we're PPC64 or not: PPC64 splits
-           them apart; PPC32 stuffs them together.
-           We also need to account for the VSX registers on PPC64
-        */
-#if defined(TARGET_PPC64)
-#define QEMU_NVRREG (34 + 16)
-        /* On ppc64, this mcontext structure is naturally *unaligned*,
-         * or rather it is aligned on a 8 bytes boundary but not on
-         * a 16 bytes one. This pad fixes it up. This is also why the
-         * vector regs are referenced by the v_regs pointer above so
-         * any amount of padding can be added here
-         */
-        target_ulong pad;
-#else
-        /* On ppc32, we are already aligned to 16 bytes */
-#define QEMU_NVRREG 33
-#endif
-        /* We cannot use ppc_avr_t here as we do *not* want the implied
-         * 16-bytes alignment that would result from it. This would have
-         * the effect of making the whole struct target_mcontext aligned
-         * which breaks the layout of struct target_ucontext on ppc64.
+        /*
+         * Altivec vector registers.  One extra for VRSAVE.
+         * On ppc32, we are already aligned to 16 bytes.  We could
+         * use ppc_avr_t, but choose to share the same type as ppc64.
          */
-        uint64_t altivec[QEMU_NVRREG][2];
-#undef QEMU_NVRREG
+        uint64_t altivec[33][2];
     } mc_vregs;
+#endif
 };
 
 /* See arch/powerpc/include/asm/sigcontext.h.  */
@@ -278,6 +274,7 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
         __put_user((uint32_t)env->spr[SPR_VRSAVE], vrsave);
     }
 
+#if defined(TARGET_PPC64)
     /* Save VSX second halves */
     if (env->insns_flags2 & PPC2_VSX) {
         uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];
@@ -286,6 +283,7 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
             __put_user(*vsrl, &vsregs[i]);
         }
     }
+#endif
 
     /* Save floating point registers.  */
     if (env->insns_flags & PPC_FLOAT) {
@@ -296,22 +294,18 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
         __put_user((uint64_t) env->fpscr, &frame->mc_fregs[32]);
     }
 
+#if !defined(TARGET_PPC64)
     /* Save SPE registers.  The kernel only saves the high half.  */
     if (env->insns_flags & PPC_SPE) {
-#if defined(TARGET_PPC64)
-        for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-            __put_user(env->gpr[i] >> 32, &frame->mc_vregs.spe[i]);
-        }
-#else
         for (i = 0; i < ARRAY_SIZE(env->gprh); i++) {
             __put_user(env->gprh[i], &frame->mc_vregs.spe[i]);
         }
-#endif
         /* Set MSR_SPE in the saved MSR value to indicate that
            frame->mc_vregs contains valid data.  */
         msr |= MSR_SPE;
         __put_user(env->spe_fscr, &frame->mc_vregs.spe[32]);
     }
+#endif
 
     /* Store MSR.  */
     __put_user(msr, &frame->mc_gregs[TARGET_PT_MSR]);
@@ -392,6 +386,7 @@ static void restore_user_regs(CPUPPCState *env,
         __get_user(env->spr[SPR_VRSAVE], vrsave);
     }
 
+#if defined(TARGET_PPC64)
     /* Restore VSX second halves */
     if (env->insns_flags2 & PPC2_VSX) {
         uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];
@@ -400,6 +395,7 @@ static void restore_user_regs(CPUPPCState *env,
             __get_user(*vsrl, &vsregs[i]);
         }
     }
+#endif
 
     /* Restore floating point registers.  */
     if (env->insns_flags & PPC_FLOAT) {
@@ -412,22 +408,15 @@ static void restore_user_regs(CPUPPCState *env,
         env->fpscr = (uint32_t) fpscr;
     }
 
+#if !defined(TARGET_PPC64)
     /* Save SPE registers.  The kernel only saves the high half.  */
     if (env->insns_flags & PPC_SPE) {
-#if defined(TARGET_PPC64)
-        for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-            uint32_t hi;
-
-            __get_user(hi, &frame->mc_vregs.spe[i]);
-            env->gpr[i] = ((uint64_t)hi << 32) | ((uint32_t) env->gpr[i]);
-        }
-#else
         for (i = 0; i < ARRAY_SIZE(env->gprh); i++) {
             __get_user(env->gprh[i], &frame->mc_vregs.spe[i]);
         }
-#endif
         __get_user(env->spe_fscr, &frame->mc_vregs.spe[32]);
     }
+#endif
 }
 
 #if !defined(TARGET_PPC64)
-- 
2.20.1


