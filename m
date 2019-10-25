Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163BB2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1l7sRS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163BB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxyj-00028h-MP
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwO-0006gL-Vf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwK-0006dL-FR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:34 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwJ-0006bH-Ej
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:31 -0400
Received: by mail-qt1-x843.google.com with SMTP id t8so2716641qtc.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sAjHl90QxJmdMfN37RnYdKMoSO6lq1wA1h9GjJJcTfo=;
 b=u1l7sRS4g3EMkqrK54XJ+/4NVBFCzVGt2T7AO/qeTJGQ5smVtgv/3vgTUDUj+rSuV+
 ysl6JWWDh6XjpvfJchE52uBHzfG5Tgas/A53OPOI/GmBzLuO5XoEiJpnWrSNpF9iPb8G
 +RDvgQOgz9nIndqlfV6zTM0l+PsLWOSqJ4qctZuhjFMMMCtn8wHE82jp3s6AGuLEhiB0
 g7kEIr31HTKa1aO10BaN2kwoRGKCFiHDLLFV1RscGDJ5hMTbGfyPdTEF9Foafk+cLCxt
 iOmcFdCrFK5usIL7W+RJZ4fwoR+IYATqXVqTytZdSsGytGy8Sw/hM7PRXqTk2cLto6O2
 CyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sAjHl90QxJmdMfN37RnYdKMoSO6lq1wA1h9GjJJcTfo=;
 b=N+l+X3t8Qd4pBJ29GUPD0f8OLwO5FNlwttLyKUkIPe7U7NbKIzuxib0vjG1x/AQtRL
 pA9ZaOhuyg9BXHaN1l+mxHbCzkTiSCRLPAIna2yxjqIqhyDAJt+qNz33KJTBrIDHk7Qk
 JrLCZNsH3v4DEq9/Eah8oIZwWJUhwkN75axlDGEnUuJuLRLDc3keAv9k2Iud8844G78r
 QgnmO7EhS4PU+z7xICHXrOA2GNAlq1wVWvnQyLj7mYX+xWGzQXYuG0ZkUDMjcVYnPO1w
 IITIrsF2CrxD7EAua9ep4R53N5OEUlbmz7ry0sTDJj7niO+pTeoxJQokaAyu52D6j8Kx
 +8ng==
X-Gm-Message-State: APjAAAWDeIQ+KVErpxeWDp2tC2HyksPflKNkgtP3VwPMarCafsDYseT9
 TUFusVNH72Xy+13LHDBkgkCO7FBakKw=
X-Google-Smtp-Source: APXvYqwVNR5YQphJlyAfKx1Sh2mZa0AmPJ32MqozMymkj2+8g/pFkTl2y2JgLY6YJ1QGbeihw1pyGg==
X-Received: by 2002:aed:3c67:: with SMTP id u36mr2504489qte.142.1572003568137; 
 Fri, 25 Oct 2019 04:39:28 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] linux-user/sparc: Begin using WREG constants in
 sparc/signal.c
Date: Fri, 25 Oct 2019 07:39:14 -0400
Message-Id: <20191025113921.9412-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is non-obvious because the UREG constants are in fact wrong.

s/UREG_I/WREG_O/g
s/UREG_O/WREG_I/g
s/UREG_L/WREG_L/g

These substitutions have identical integer values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/signal.c | 93 ++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 61 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index ead169fbaa..a967e2db73 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -104,19 +104,8 @@ struct target_rt_signal_frame {
     qemu_siginfo_fpu_t  fpu_state;
 };
 
-#define UREG_O0        16
-#define UREG_O6        22
-#define UREG_I0        0
-#define UREG_I1        1
-#define UREG_I2        2
-#define UREG_I3        3
-#define UREG_I4        4
-#define UREG_I5        5
-#define UREG_I6        6
-#define UREG_I7        7
-#define UREG_L0        8
-#define UREG_FP        UREG_I6
-#define UREG_SP        UREG_O6
+#define UREG_FP        WREG_O6
+#define UREG_SP        WREG_I6
 
 static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
                                      CPUSPARCState *env,
@@ -159,30 +148,12 @@ setup___siginfo(__siginfo_t *si, CPUSPARCState *env, abi_ulong mask)
         __put_user(env->gregs[i], &si->si_regs.u_regs[i]);
     }
     for (i=0; i < 8; i++) {
-        __put_user(env->regwptr[UREG_I0 + i], &si->si_regs.u_regs[i+8]);
+        __put_user(env->regwptr[WREG_O0 + i], &si->si_regs.u_regs[i+8]);
     }
     __put_user(mask, &si->si_mask);
     return err;
 }
 
-#if 0
-static int
-setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
-                 CPUSPARCState *env, unsigned long mask)
-{
-    int err = 0;
-
-    __put_user(mask, &sc->sigc_mask);
-    __put_user(env->regwptr[UREG_SP], &sc->sigc_sp);
-    __put_user(env->pc, &sc->sigc_pc);
-    __put_user(env->npc, &sc->sigc_npc);
-    __put_user(env->psr, &sc->sigc_psr);
-    __put_user(env->gregs[1], &sc->sigc_g1);
-    __put_user(env->regwptr[UREG_O0], &sc->sigc_o0);
-
-    return err;
-}
-#endif
 #define NF_ALIGNEDSZ  (((sizeof(struct target_signal_frame) + 7) & (~7)))
 
 void setup_frame(int sig, struct target_sigaction *ka,
@@ -221,20 +192,20 @@ void setup_frame(int sig, struct target_sigaction *ka,
     }
 
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + UREG_L0], &sf->ss.locals[i]);
+        __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
     }
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + UREG_I0], &sf->ss.ins[i]);
+        __put_user(env->regwptr[i + WREG_O0], &sf->ss.ins[i]);
     }
     if (err)
         goto sigsegv;
 
     /* 3. signal handler back-trampoline and parameters */
     env->regwptr[UREG_FP] = sf_addr;
-    env->regwptr[UREG_I0] = sig;
-    env->regwptr[UREG_I1] = sf_addr +
+    env->regwptr[WREG_O0] = sig;
+    env->regwptr[WREG_O1] = sf_addr +
             offsetof(struct target_signal_frame, info);
-    env->regwptr[UREG_I2] = sf_addr +
+    env->regwptr[WREG_O2] = sf_addr +
             offsetof(struct target_signal_frame, info);
 
     /* 4. signal handler */
@@ -242,11 +213,11 @@ void setup_frame(int sig, struct target_sigaction *ka,
     env->npc = (env->pc + 4);
     /* 5. return to kernel instructions */
     if (ka->ka_restorer) {
-        env->regwptr[UREG_I7] = ka->ka_restorer;
+        env->regwptr[WREG_O7] = ka->ka_restorer;
     } else {
         uint32_t val32;
 
-        env->regwptr[UREG_I7] = sf_addr +
+        env->regwptr[WREG_O7] = sf_addr +
                 offsetof(struct target_signal_frame, insns) - 2 * 4;
 
         /* mov __NR_sigreturn, %g1 */
@@ -316,7 +287,7 @@ long do_sigreturn(CPUSPARCState *env)
         __get_user(env->gregs[i], &sf->info.si_regs.u_regs[i]);
     }
     for (i=0; i < 8; i++) {
-        __get_user(env->regwptr[i + UREG_I0], &sf->info.si_regs.u_regs[i+8]);
+        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[i+8]);
     }
 
     /* FIXME: implement FPU save/restore:
@@ -433,7 +404,7 @@ void sparc64_set_context(CPUSPARCState *env)
     abi_ulong fp, i7, w_addr;
     unsigned int i;
 
-    ucp_addr = env->regwptr[UREG_I0];
+    ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_READ, ucp, ucp_addr, 1)) {
         goto do_sigsegv;
     }
@@ -443,7 +414,7 @@ void sparc64_set_context(CPUSPARCState *env)
     if ((pc | npc) & 3) {
         goto do_sigsegv;
     }
-    if (env->regwptr[UREG_I1]) {
+    if (env->regwptr[WREG_O1]) {
         target_sigset_t target_set;
         sigset_t set;
 
@@ -474,19 +445,19 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->gregs[5], (&(*grp)[SPARC_MC_G5]));
     __get_user(env->gregs[6], (&(*grp)[SPARC_MC_G6]));
     __get_user(env->gregs[7], (&(*grp)[SPARC_MC_G7]));
-    __get_user(env->regwptr[UREG_I0], (&(*grp)[SPARC_MC_O0]));
-    __get_user(env->regwptr[UREG_I1], (&(*grp)[SPARC_MC_O1]));
-    __get_user(env->regwptr[UREG_I2], (&(*grp)[SPARC_MC_O2]));
-    __get_user(env->regwptr[UREG_I3], (&(*grp)[SPARC_MC_O3]));
-    __get_user(env->regwptr[UREG_I4], (&(*grp)[SPARC_MC_O4]));
-    __get_user(env->regwptr[UREG_I5], (&(*grp)[SPARC_MC_O5]));
-    __get_user(env->regwptr[UREG_I6], (&(*grp)[SPARC_MC_O6]));
-    __get_user(env->regwptr[UREG_I7], (&(*grp)[SPARC_MC_O7]));
+    __get_user(env->regwptr[WREG_O0], (&(*grp)[SPARC_MC_O0]));
+    __get_user(env->regwptr[WREG_O1], (&(*grp)[SPARC_MC_O1]));
+    __get_user(env->regwptr[WREG_O2], (&(*grp)[SPARC_MC_O2]));
+    __get_user(env->regwptr[WREG_O3], (&(*grp)[SPARC_MC_O3]));
+    __get_user(env->regwptr[WREG_O4], (&(*grp)[SPARC_MC_O4]));
+    __get_user(env->regwptr[WREG_O5], (&(*grp)[SPARC_MC_O5]));
+    __get_user(env->regwptr[WREG_O6], (&(*grp)[SPARC_MC_O6]));
+    __get_user(env->regwptr[WREG_O7], (&(*grp)[SPARC_MC_O7]));
 
     __get_user(fp, &(ucp->tuc_mcontext.mc_fp));
     __get_user(i7, &(ucp->tuc_mcontext.mc_i7));
 
-    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
+    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
     if (put_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
         goto do_sigsegv;
@@ -534,7 +505,7 @@ void sparc64_get_context(CPUSPARCState *env)
     target_sigset_t target_set;
     sigset_t set;
 
-    ucp_addr = env->regwptr[UREG_I0];
+    ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_WRITE, ucp, ucp_addr, 0)) {
         goto do_sigsegv;
     }
@@ -580,16 +551,16 @@ void sparc64_get_context(CPUSPARCState *env)
     __put_user(env->gregs[5], &((*grp)[SPARC_MC_G5]));
     __put_user(env->gregs[6], &((*grp)[SPARC_MC_G6]));
     __put_user(env->gregs[7], &((*grp)[SPARC_MC_G7]));
-    __put_user(env->regwptr[UREG_I0], &((*grp)[SPARC_MC_O0]));
-    __put_user(env->regwptr[UREG_I1], &((*grp)[SPARC_MC_O1]));
-    __put_user(env->regwptr[UREG_I2], &((*grp)[SPARC_MC_O2]));
-    __put_user(env->regwptr[UREG_I3], &((*grp)[SPARC_MC_O3]));
-    __put_user(env->regwptr[UREG_I4], &((*grp)[SPARC_MC_O4]));
-    __put_user(env->regwptr[UREG_I5], &((*grp)[SPARC_MC_O5]));
-    __put_user(env->regwptr[UREG_I6], &((*grp)[SPARC_MC_O6]));
-    __put_user(env->regwptr[UREG_I7], &((*grp)[SPARC_MC_O7]));
+    __put_user(env->regwptr[WREG_O0], &((*grp)[SPARC_MC_O0]));
+    __put_user(env->regwptr[WREG_O1], &((*grp)[SPARC_MC_O1]));
+    __put_user(env->regwptr[WREG_O2], &((*grp)[SPARC_MC_O2]));
+    __put_user(env->regwptr[WREG_O3], &((*grp)[SPARC_MC_O3]));
+    __put_user(env->regwptr[WREG_O4], &((*grp)[SPARC_MC_O4]));
+    __put_user(env->regwptr[WREG_O5], &((*grp)[SPARC_MC_O5]));
+    __put_user(env->regwptr[WREG_O6], &((*grp)[SPARC_MC_O6]));
+    __put_user(env->regwptr[WREG_O7], &((*grp)[SPARC_MC_O7]));
 
-    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
+    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
     fp = i7 = 0;
     if (get_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
-- 
2.17.1


