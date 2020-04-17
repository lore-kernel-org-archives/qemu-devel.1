Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C58C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A6021D94
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hpcAaddH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A6021D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPJER-0003mT-L4
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 01:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBz-0000gj-5r
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBx-0007Rz-ED
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:30 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44107 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPJBv-0007RS-K7; Fri, 17 Apr 2020 01:05:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493PDM3Y3bz9sQx; Fri, 17 Apr 2020 15:05:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587099923;
 bh=4XGPYHVoUfRb7ZLjjBorBfA3SzHrRVUtdj2ETvavjJM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hpcAaddHXuUExNc2G8gy3USfLUDFX3F96DNbQ8KQPYItzN71YZb6IC+wF9pZo6sRz
 Qe44e62iO14oKoNeF4hPzv0VLsj6Mmg2B7dW3rxzZRQrRfr3c+nJDd9/YECqkqL54W
 lZCS1B1Hx+tIpkTkZIaSNo9dKVivb2EAe8ND3aPY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 1/3] linux-user/ppc: Fix padding in mcontext_t for ppc64
Date: Fri, 17 Apr 2020 15:05:12 +1000
Message-Id: <20200417050514.235060-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417050514.235060-1-david@gibson.dropbear.id.au>
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
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
Message-Id: <20200407032105.26711-1-richard.henderson@linaro.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
+    /* VSCR and VRSAVE are saved separately.  Also reserve space for VSX=
. */
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
=20
 /* See arch/powerpc/include/asm/sigcontext.h.  */
@@ -278,6 +274,7 @@ static void save_user_regs(CPUPPCState *env, struct t=
arget_mcontext *frame)
         __put_user((uint32_t)env->spr[SPR_VRSAVE], vrsave);
     }
=20
+#if defined(TARGET_PPC64)
     /* Save VSX second halves */
     if (env->insns_flags2 & PPC2_VSX) {
         uint64_t *vsregs =3D (uint64_t *)&frame->mc_vregs.altivec[34];
@@ -286,6 +283,7 @@ static void save_user_regs(CPUPPCState *env, struct t=
arget_mcontext *frame)
             __put_user(*vsrl, &vsregs[i]);
         }
     }
+#endif
=20
     /* Save floating point registers.  */
     if (env->insns_flags & PPC_FLOAT) {
@@ -296,22 +294,18 @@ static void save_user_regs(CPUPPCState *env, struct=
 target_mcontext *frame)
         __put_user((uint64_t) env->fpscr, &frame->mc_fregs[32]);
     }
=20
+#if !defined(TARGET_PPC64)
     /* Save SPE registers.  The kernel only saves the high half.  */
     if (env->insns_flags & PPC_SPE) {
-#if defined(TARGET_PPC64)
-        for (i =3D 0; i < ARRAY_SIZE(env->gpr); i++) {
-            __put_user(env->gpr[i] >> 32, &frame->mc_vregs.spe[i]);
-        }
-#else
         for (i =3D 0; i < ARRAY_SIZE(env->gprh); i++) {
             __put_user(env->gprh[i], &frame->mc_vregs.spe[i]);
         }
-#endif
         /* Set MSR_SPE in the saved MSR value to indicate that
            frame->mc_vregs contains valid data.  */
         msr |=3D MSR_SPE;
         __put_user(env->spe_fscr, &frame->mc_vregs.spe[32]);
     }
+#endif
=20
     /* Store MSR.  */
     __put_user(msr, &frame->mc_gregs[TARGET_PT_MSR]);
@@ -392,6 +386,7 @@ static void restore_user_regs(CPUPPCState *env,
         __get_user(env->spr[SPR_VRSAVE], vrsave);
     }
=20
+#if defined(TARGET_PPC64)
     /* Restore VSX second halves */
     if (env->insns_flags2 & PPC2_VSX) {
         uint64_t *vsregs =3D (uint64_t *)&frame->mc_vregs.altivec[34];
@@ -400,6 +395,7 @@ static void restore_user_regs(CPUPPCState *env,
             __get_user(*vsrl, &vsregs[i]);
         }
     }
+#endif
=20
     /* Restore floating point registers.  */
     if (env->insns_flags & PPC_FLOAT) {
@@ -412,22 +408,15 @@ static void restore_user_regs(CPUPPCState *env,
         env->fpscr =3D (uint32_t) fpscr;
     }
=20
+#if !defined(TARGET_PPC64)
     /* Save SPE registers.  The kernel only saves the high half.  */
     if (env->insns_flags & PPC_SPE) {
-#if defined(TARGET_PPC64)
-        for (i =3D 0; i < ARRAY_SIZE(env->gpr); i++) {
-            uint32_t hi;
-
-            __get_user(hi, &frame->mc_vregs.spe[i]);
-            env->gpr[i] =3D ((uint64_t)hi << 32) | ((uint32_t) env->gpr[=
i]);
-        }
-#else
         for (i =3D 0; i < ARRAY_SIZE(env->gprh); i++) {
             __get_user(env->gprh[i], &frame->mc_vregs.spe[i]);
         }
-#endif
         __get_user(env->spe_fscr, &frame->mc_vregs.spe[32]);
     }
+#endif
 }
=20
 #if !defined(TARGET_PPC64)
--=20
2.25.2


