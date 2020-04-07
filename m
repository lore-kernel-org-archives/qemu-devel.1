Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68DC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 03:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841FD2072F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 03:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpHLtRBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841FD2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLeoR-0003MX-Oa
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 23:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLenX-0002WU-5Y
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLenV-0003uJ-Hi
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:21:10 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLenV-0003tU-8f
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:21:09 -0400
Received: by mail-pl1-x641.google.com with SMTP id c12so712033plz.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 20:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YchAy/C08LIfmnaBsXOS1Gb/JPzjItmG64oZ+9K4gkc=;
 b=fpHLtRBGWLQhwD3c+0T36AomptYB3jYsV5J3xY8MehX7THGWw+YTH5qugwZPlnjTiB
 W1hGrseVUlcRNE94eupvhkz2GK0XcYH5JAs8hKzAzZ4QXBBCcBx9rgHgGE9You8RCvbw
 cxNDKQnJiDUwvQTdwm6cMPT5KDL/JdezPpv9wexSiAkr0nLZjLT7i0qOj+3SYsvTpiZO
 P5UnGlTh6Jq6RHvpqSLGCOvTrNbnBAXrOrwABhN76S7KBrN7XjPUw7s9p/KoBZ9BpxJN
 LoPzV+8UYvBBKBgugBA3D8IJprAxd43Z6SsTFSqBpSFXz91/m01Ri+EfDhNNLImetlih
 KijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YchAy/C08LIfmnaBsXOS1Gb/JPzjItmG64oZ+9K4gkc=;
 b=JHejCIdALPUN1qzU+4VkRUJBKEypI9G+ySljasuXTZugNE1gOrizdwmfnnQ9OaWi5f
 BD1g7zVhK0iBZIJ9osNmvgtfyBmgnKvlJSX8gJx2uMoPPA6OGpnXwmFddhdokCsaTyh1
 1jJ7T7dHsdhR1LFr0nnltUiu7F4j/cl426lR9L+awpdsmzwVYI9Yqxx4xBRs/jvj69Wq
 u8nb4KTb3eCNnXy5hRF8TUtDH1gPnidDcduOZWP52gZefKDN408BNGpA3JJANmGPt+/v
 a4MTKjmI4ENDMTnKfCzSYJObFaYmFGci59wu6aUqqrMVj4iESHgt8b92eLSlgNEKaDvz
 6qww==
X-Gm-Message-State: AGi0PuYi8jS3gmnK0SAHwbtTreH9q3Fup2p2z4UXcbD4CaTNXuK1uGFf
 TCdAYhQvI8pWCCuUsIv943If3yz0pTc=
X-Google-Smtp-Source: APiQypLUB0D3Kw4arujSzGchZye2Boh5umWWckq0QnGysXamVoKOAKBlxrVfeMeWJ4C+Woe4xyZKsA==
X-Received: by 2002:a17:90a:368f:: with SMTP id
 t15mr171412pjb.23.1586229667546; 
 Mon, 06 Apr 2020 20:21:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id lj14sm245565pjb.25.2020.04.06.20.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 20:21:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] linux-user/ppc: Fix padding in mcontext_t for ppc64
Date: Mon,  6 Apr 2020 20:21:05 -0700
Message-Id: <20200407032105.26711-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: alex.bennee@linaro.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The padding that was added in 95cda4c44ee was added to a union,
and so it had no effect.  This fixes misalignment errors detected
by clang sanitizers for ppc64 and ppc64le.

In addition, only ppc64 allocates space for VSX registers, so do
not save them for ppc32.  The kernel only has references to
CONFIG_SPE in signal_32.c, so do not attempt to save them for ppc64.

Fixes: 95cda4c44ee
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Note that ppc64abi32 is *not* fixed by this patch.  It looks to
me that all of the defined(TARGET_PPC64) tests in this file are
incorrect, and that we should instead be testing TARGET_ABI_BITS
vs 32/64.  In addition, virtually all of the target_ulong structure
members would need to be abi_ulong.

Should we in fact disable ppc64abi32?
I can't see how it could work enough to be useful as-is.


r~

---
 linux-user/ppc/signal.c | 69 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index ecd99736b7..20a02c197c 100644
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
+        /*
+         * Altivec vector registers.  One extra for VRSAVE.
+         * On ppc32, we are already aligned to 16 bytes.  We could
+         * use ppc_avr_t, but choose to share the same type as ppc64.
          */
-        target_ulong pad;
-#else
-        /* On ppc32, we are already aligned to 16 bytes */
-#define QEMU_NVRREG 33
-#endif
-        /* We cannot use ppc_avr_t here as we do *not* want the implied
-         * 16-bytes alignment that would result from it. This would have
-         * the effect of making the whole struct target_mcontext aligned
-         * which breaks the layout of struct target_ucontext on ppc64.
-         */
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


