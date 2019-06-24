Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE05C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21B120645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21B120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sing.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTbp-0005lg-Sp
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel@sing.id.au>) id 1hfTPm-0007kS-2u
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel@sing.id.au>) id 1hfTPk-0002Lq-0s
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:10:01 -0400
Received: from stingray.exigere.com.au ([162.217.113.74]:23701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joel@sing.id.au>)
 id 1hfTPb-0000UC-AS; Mon, 24 Jun 2019 14:09:52 -0400
Received: from hippo.sing.id.au (exi2311632.lnk.telstra.net [144.139.233.124])
 by stingray.exigere.com.au (OpenSMTPD) with ESMTPSA id a7f122bb
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Tue, 25 Jun 2019 04:34:49 +1000 (AEST)
Received: from localhost (hippo.sing.id.au [local])
 by hippo.sing.id.au (OpenSMTPD) with ESMTPA id c019513a;
 Tue, 25 Jun 2019 04:08:38 +1000 (AEST)
Date: Tue, 25 Jun 2019 04:08:38 +1000
From: Joel Sing <joel@sing.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190624180837.GM61734@hippo.sing.id.au>
References: <20190616191900.GH61734@hippo.sing.id.au>
 <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 162.217.113.74
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, palmer@sifive.com,
 qemu-devel@nongnu.org, Alistair.Francis@wdc.com, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19-06-17 16:52:44, Richard Henderson wrote:
> On 6/16/19 12:19 PM, Joel Sing wrote:
> > +    /*
> > +     * Clear the load reservation, since an SC must fail if there is
> > +     * an SC to any address, in between an LR and SC pair.
> > +     */
> > +    tcg_gen_movi_tl(load_res, 0);
> > +
> >      gen_set_label(l2);
> 
> This clear needs to be moved down below label l2.
> Otherwise, with lr / sc / sc, the second sc could succeed in error.

Indeed, thanks.

> FWIW, other targets have used -1 as the "invalid" load reservation, since the
> architecture does not require address 0 to be unmapped.  This should be quite
> visible in M-mode with paging disabled and ram at offset 0.  Often, other
> targets require alignment for the lr/sc address, though I don't see that for riscv.

I've switched to -1 as suggested. Regarding the alignment for reservations, the
specification does require this, although I do not recall seeing any enforcement
of this by qemu itself.

New diff follows.

From 8ef31a2ce8ef1cbeee92995a0b2994f480e9bb6d Mon Sep 17 00:00:00 2001
From: Joel Sing <joel@sing.id.au>
Date: Tue, 25 Jun 2019 02:44:24 +1000
Subject: [PATCH] Clear load reservations on qemu riscv target

This prevents a load reservation from being placed in one context/process,
then being used in another, resulting in an SC succeeding incorrectly and
breaking atomics.

Signed-off-by: Joel Sing <joel@sing.id.au>
---
 target/riscv/cpu.c                      | 1 +
 target/riscv/cpu_helper.c               | 9 +++++++++
 target/riscv/insn_trans/trans_rva.inc.c | 8 +++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d61bce6d55..e7c8bf48fc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -281,6 +281,7 @@ static void riscv_cpu_reset(CPUState *cs)
     env->pc = env->resetvec;
 #endif
     cs->exception_index = EXCP_NONE;
+    env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
 }
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b17f169681..6a07b12e65 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -113,6 +113,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
     }
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
+
+    /* Clear the load reservation - otherwise a reservation placed in one
+     * context/process can be used by another, resulting in an SC succeeding
+     * incorrectly. Version 2.2 of the ISA specification explicitly requires
+     * this behaviour, while later revisions say that the kernel "should" use
+     * an SC instruction to force the yielding of a load reservation on a
+     * preemptive context switch. As a result, do both.
+     */
+    env->load_res = -1;
 }
 
 /* get_physical_address - get the physical address for this virtual address
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
index f6dbbc065e..fadd88849e 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -61,7 +61,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
 
     gen_set_label(l1);
     /*
-     * Address comparion failure.  However, we still need to
+     * Address comparison failure.  However, we still need to
      * provide the memory barrier implied by AQ/RL.
      */
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
@@ -69,6 +69,12 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
     gen_set_gpr(a->rd, dat);
 
     gen_set_label(l2);
+    /*
+     * Clear the load reservation, since an SC must fail if there is
+     * an SC to any address, in between an LR and SC pair.
+     */
+    tcg_gen_movi_tl(load_res, -1);
+
     tcg_temp_free(dat);
     tcg_temp_free(src1);
     tcg_temp_free(src2);
-- 
2.21.0


