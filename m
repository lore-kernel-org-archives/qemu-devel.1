Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D390C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 20:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB2820665
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 20:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB2820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sing.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcc5l-00030S-6r
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 16:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel@sing.id.au>) id 1hcahL-00027f-5J
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel@sing.id.au>) id 1hcahJ-0001uw-Mv
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:20:15 -0400
Received: from stingray.exigere.com.au ([162.217.113.74]:12247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joel@sing.id.au>)
 id 1hcahG-00013u-IH; Sun, 16 Jun 2019 15:20:10 -0400
Received: from hippo.sing.id.au (exi2311632.lnk.telstra.net [144.139.233.124])
 by stingray.exigere.com.au (OpenSMTPD) with ESMTPSA id e5bfd7b9
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Mon, 17 Jun 2019 05:42:25 +1000 (AEST)
Received: from localhost (hippo.sing.id.au [local])
 by hippo.sing.id.au (OpenSMTPD) with ESMTPA id 7e842b5a;
 Mon, 17 Jun 2019 05:19:01 +1000 (AEST)
Date: Mon, 17 Jun 2019 05:19:01 +1000
From: Joel Sing <joel@sing.id.au>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Message-ID: <20190616191900.GH61734@hippo.sing.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 162.217.113.74
X-Mailman-Approved-At: Sun, 16 Jun 2019 16:46:39 -0400
Subject: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, palmer@sifive.com, Alistair.Francis@wdc.com,
 marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While working on a Go (www.golang.org) port for riscv, I've run
into issues with atomics (namely LR/SC) on qemu-system-riscv64.
There are several reproducers for this problem including one
using gcc builtin atomics:

  https://gist.github.com/4a6f656c/8433032a3f70893a278259f8108aad90

And a version using inline assembly:

  https://gist.github.com/4a6f656c/d883091f5ca811822720213be343a75a

Depending on the qemu configuration the number of threads may
need increasing (to force context switching) and/or run in a
loop. Go's sync/atomic tests also fail regularly.

Having dug into the qemu code, what I believe is happening is
along the lines of the following while running the typical CAS
sequence:

1. Thread 1 runs and executes an LR - this assigns an address
   to load_res and a value to load_val (say 1). It performs a
   comparison, the value matches and decides to continue with
   its SC.

2. A context switch occurs and thread 2 is now run - it runs
   an LR and SC on the same address modifying the stored value.
   Another LR is executed loading load_val with the current
   value (say 3).

3. A context switch occurs and thread 1 is now run again, it
   continues on its LR/SC sequence and now runs the SC instruction.
   This is based on the assumption that it had a reservation
   and the SC will fail if the memory has changed. The underlying
   implementation of SC is a cmpxchg with the value in load_val
   - this no longer has the original value and hence successfully
   compares (as does the tcg_gen_setcond_tl() between the returned
   value and load_val) thus the SC succeeds when it should not.

The diff below clears load_res when the mode changes - with this
applied the reproducers work correctly, as do Go's atomic tests.
This is inline with v2.2 of the RISCV ISA specification:

"The SC must fail if there is an observable memory access from
another hart to the address, or if there is an intervening context
switch on this hart, or if in the meantime the hart executed a
privileged exception-return instruction."

However, it is worth noting that this language was changed in
later revisions of the specification and now states that an
LR/SC must fail if there is an SC to any address in between.
On its own this does not prevent the above context-switch
scenario and an additional note says that the kernel "should"
forcibly break a load reservation by running an SC instruction
on a preemptive context switch. The riscv linux kernel does not
currently do this, however a diff exists to change this:

  https://lore.kernel.org/linux-riscv/20190607222222.15300-1-palmer@sifive.com/

As such, the below diff clears the load reservation on both
mode changes and on execution of an SC instruction. This results
in correct behaviour on both a patched and unpatched kernel and
seems to be the safer approach.

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b17f169681..19029429a7 100644
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
+    env->load_res = 0;
 }
 
 /* get_physical_address - get the physical address for this virtual address
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
index f6dbbc065e..bb560a9d05 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -61,13 +61,19 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
 
     gen_set_label(l1);
     /*
-     * Address comparion failure.  However, we still need to
+     * Address comparison failure.  However, we still need to
      * provide the memory barrier implied by AQ/RL.
      */
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
     tcg_gen_movi_tl(dat, 1);
     gen_set_gpr(a->rd, dat);
 
+    /*
+     * Clear the load reservation, since an SC must fail if there is
+     * an SC to any address, in between an LR and SC pair.
+     */
+    tcg_gen_movi_tl(load_res, 0);
+
     gen_set_label(l2);
     tcg_temp_free(dat);
     tcg_temp_free(src1);

