Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ECAC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1234721D94
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g4+htptk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1234721D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPJES-0003mw-8P
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 01:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBz-0000gk-40
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBx-0007S7-IZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54563 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPJBv-0007RD-Mr; Fri, 17 Apr 2020 01:05:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493PDM5S39z9sSv; Fri, 17 Apr 2020 15:05:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587099923;
 bh=sukPRN7kqfCsG8KffgiHN7+nZU28w250zeniJlzFCFw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g4+htptkfIzbWFMJvzAnJr70psXB3ZFPVnay7lpAPjggVuqIuzJd4RW93kVTD4yGn
 t9WAXPgFgA5Ib3pzIp1KqolMO/ezlGzGDj2wJuO6FJOg44BBBwJK2zLqgXiqWDQW00
 0qKn+kxY3ZqU7qCXBQjpFoqCxuvDpKWR1n9xzvCg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 3/3] target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts
Date: Fri, 17 Apr 2020 15:05:14 +1000
Message-Id: <20200417050514.235060-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417050514.235060-1-david@gibson.dropbear.id.au>
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-stable@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Anton Blanchard <anton@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

If mtmsr L=3D1 sets MSR[EE] while there is a maskable exception pending,
it does not cause an interrupt. This causes the test case to hang:

https://lists.gnu.org/archive/html/qemu-ppc/2019-10/msg00826.html

More recently, Linux reduced the occurance of operations (e.g., rfi)
which stop translation and allow pending interrupts to be processed.
This started causing hangs in Linux boot in long-running kernel tests,
running with '-d int' shows the decrementer stops firing despite DEC
wrapping and MSR[EE]=3D1.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208301.html

The cause is the broken mtmsr L=3D1 behaviour, which is contrary to the
architecture. From Power ISA v3.0B, p.977, Move To Machine State Register=
,
Programming Note states:

    If MSR[EE]=3D0 and an External, Decrementer, or Performance Monitor
    exception is pending, executing an mtmsrd instruction that sets
    MSR[EE] to 1 will cause the interrupt to occur before the next
    instruction is executed, if no higher priority exception exists

Fix this by handling L=3D1 exactly the same way as L=3D0, modulo the MSR
bits altered.

The confusion arises from L=3D0 being "context synchronizing" whereas L=3D=
1
is "execution synchronizing", which is a weaker semantic. However this
is not a relaxation of the requirement that these exceptions cause
interrupts when MSR[EE]=3D1 (e.g., when mtmsr executes to completion as
TCG is doing here), rather it specifies how a pipelined processor can
have multiple instructions in flight where one may influence how another
behaves.

Cc: qemu-stable@nongnu.org
Reported-by: Anton Blanchard <anton@ozlabs.org>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200414111131.465560-1-npiggin@gmail.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b207fb5386..9959259dba 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4361,30 +4361,34 @@ static void gen_mtmsrd(DisasContext *ctx)
     CHK_SV;
=20
 #if !defined(CONFIG_USER_ONLY)
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     if (ctx->opcode & 0x00010000) {
-        /* Special form that does not need any synchronisation */
+        /* L=3D1 form only updates EE and RI */
         TCGv t0 =3D tcg_temp_new();
+        TCGv t1 =3D tcg_temp_new();
         tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
                         (1 << MSR_RI) | (1 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+        tcg_gen_andi_tl(t1, cpu_msr,
                         ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
-        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
+        tcg_gen_or_tl(t1, t1, t0);
+
+        gen_helper_store_msr(cpu_env, t1);
         tcg_temp_free(t0);
+        tcg_temp_free(t1);
+
     } else {
         /*
          * XXX: we need to update nip before the store if we enter
          *      power saving mode, we will exit the loop directly from
          *      ppc_store_msr
          */
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
         gen_update_nip(ctx, ctx->base.pc_next);
         gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
-        /* Must stop the translation as machine state (may have) changed=
 */
-        /* Note that mtmsr is not always defined as context-synchronizin=
g */
-        gen_stop_exception(ctx);
     }
+    /* Must stop the translation as machine state (may have) changed */
+    gen_stop_exception(ctx);
 #endif /* !defined(CONFIG_USER_ONLY) */
 }
 #endif /* defined(TARGET_PPC64) */
@@ -4394,15 +4398,23 @@ static void gen_mtmsr(DisasContext *ctx)
     CHK_SV;
=20
 #if !defined(CONFIG_USER_ONLY)
-   if (ctx->opcode & 0x00010000) {
-        /* Special form that does not need any synchronisation */
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    if (ctx->opcode & 0x00010000) {
+        /* L=3D1 form only updates EE and RI */
         TCGv t0 =3D tcg_temp_new();
+        TCGv t1 =3D tcg_temp_new();
         tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
                         (1 << MSR_RI) | (1 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+        tcg_gen_andi_tl(t1, cpu_msr,
                         ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
-        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
+        tcg_gen_or_tl(t1, t1, t0);
+
+        gen_helper_store_msr(cpu_env, t1);
         tcg_temp_free(t0);
+        tcg_temp_free(t1);
+
     } else {
         TCGv msr =3D tcg_temp_new();
=20
@@ -4411,9 +4423,6 @@ static void gen_mtmsr(DisasContext *ctx)
          *      power saving mode, we will exit the loop directly from
          *      ppc_store_msr
          */
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
         gen_update_nip(ctx, ctx->base.pc_next);
 #if defined(TARGET_PPC64)
         tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32=
);
@@ -4422,10 +4431,9 @@ static void gen_mtmsr(DisasContext *ctx)
 #endif
         gen_helper_store_msr(cpu_env, msr);
         tcg_temp_free(msr);
-        /* Must stop the translation as machine state (may have) changed=
 */
-        /* Note that mtmsr is not always defined as context-synchronizin=
g */
-        gen_stop_exception(ctx);
     }
+    /* Must stop the translation as machine state (may have) changed */
+    gen_stop_exception(ctx);
 #endif
 }
=20
--=20
2.25.2


