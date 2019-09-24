Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD2C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FE5207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FE5207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCr4Q-0005HV-5A
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iCr3M-0004em-2K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iCr3K-0000WO-CH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:04:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iCr3K-0000V0-3V
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:04:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so1427374plp.6
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=/rSgQcrRsIlsdxJKOZJom9LnTWOg9fHERF3t38GzndI=;
 b=RxivST4S1nMRD9We4Hj/ihbjkT/xqGK54vIAyG2/wh/OIJnr73FYnQikgJlPHt1Mej
 4qqYd/CkkxowaO55I6ftvU7WEd+14zkeIZ0ZXz1IZNxh+Ra0zNMozjwGE2KhQ8J43CBT
 O6koiQKctruS/0s3JiPDOdHqxD5sb2ROH4GZzylHsCYrl6QfpDx8sdKtSnT5hW7AGac/
 T+rZTciPfR/nhRs5JPsCmopGc6qvTRwOgS1QnTueLA4ATqXOFr2Ag/p0DPf4azVaocgq
 LU3l6MqikNhSVsShFBN1yWJZC8cn89Q9ALcGYMzEACvDnJlJM/HaqI67bSmcEj+Cl5KM
 RcDQ==
X-Gm-Message-State: APjAAAUKqKFk45N0porjU0OEroLb2cEyz9SCtiPbcyJJg38H4IJqR+DA
 IWu46/7vyP6zmFaV9a0DmZovFA==
X-Google-Smtp-Source: APXvYqzTWzT+/VxpflvcKQyYMNSWEXgmaY0QX0hoFv/RVz1Xb4cfn0PcA7n6tv9c06XRoqwRZip8QA==
X-Received: by 2002:a17:902:56e:: with SMTP id
 101mr4973233plf.90.1569355487301; 
 Tue, 24 Sep 2019 13:04:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id v44sm3533668pgn.17.2019.09.24.13.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 13:04:46 -0700 (PDT)
Date: Tue, 24 Sep 2019 13:04:46 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Sep 2019 13:04:44 PDT (-0700)
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
In-Reply-To: <CAKmqyKP+HNfzh5kCKkGDtfr=pDRwcjL+dUQ79NZEk+jMZ3q=_Q@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-a172dfe8-dd34-427f-89dd-ca65da3145fb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, joel@sing.id.au,
 Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 11:29:25 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Jun 24, 2019 at 11:21 AM Joel Sing <joel@sing.id.au> wrote:
>>
>> On 19-06-17 16:52:44, Richard Henderson wrote:
>> > On 6/16/19 12:19 PM, Joel Sing wrote:
>> > > +    /*
>> > > +     * Clear the load reservation, since an SC must fail if there is
>> > > +     * an SC to any address, in between an LR and SC pair.
>> > > +     */
>> > > +    tcg_gen_movi_tl(load_res, 0);
>> > > +
>> > >      gen_set_label(l2);
>> >
>> > This clear needs to be moved down below label l2.
>> > Otherwise, with lr / sc / sc, the second sc could succeed in error.
>>
>> Indeed, thanks.
>>
>> > FWIW, other targets have used -1 as the "invalid" load reservation, since the
>> > architecture does not require address 0 to be unmapped.  This should be quite
>> > visible in M-mode with paging disabled and ram at offset 0.  Often, other
>> > targets require alignment for the lr/sc address, though I don't see that for riscv.
>>
>> I've switched to -1 as suggested. Regarding the alignment for reservations, the
>> specification does require this, although I do not recall seeing any enforcement
>> of this by qemu itself.
>>
>> New diff follows.
>>
>> From 8ef31a2ce8ef1cbeee92995a0b2994f480e9bb6d Mon Sep 17 00:00:00 2001
>> From: Joel Sing <joel@sing.id.au>
>> Date: Tue, 25 Jun 2019 02:44:24 +1000
>> Subject: [PATCH] Clear load reservations on qemu riscv target
>>
>> This prevents a load reservation from being placed in one context/process,
>> then being used in another, resulting in an SC succeeding incorrectly and
>> breaking atomics.
>>
>> Signed-off-by: Joel Sing <joel@sing.id.au>
>> ---
>>  target/riscv/cpu.c                      | 1 +
>>  target/riscv/cpu_helper.c               | 9 +++++++++
>>  target/riscv/insn_trans/trans_rva.inc.c | 8 +++++++-
>>  3 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index d61bce6d55..e7c8bf48fc 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -281,6 +281,7 @@ static void riscv_cpu_reset(CPUState *cs)
>>      env->pc = env->resetvec;
>>  #endif
>>      cs->exception_index = EXCP_NONE;
>> +    env->load_res = -1;
>>      set_default_nan_mode(1, &env->fp_status);
>>  }
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index b17f169681..6a07b12e65 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -113,6 +113,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>>      }
>>      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>>      env->priv = newpriv;
>> +
>> +    /* Clear the load reservation - otherwise a reservation placed in one
>> +     * context/process can be used by another, resulting in an SC succeeding
>> +     * incorrectly. Version 2.2 of the ISA specification explicitly requires
>> +     * this behaviour, while later revisions say that the kernel "should" use
>> +     * an SC instruction to force the yielding of a load reservation on a
>> +     * preemptive context switch. As a result, do both.
>> +     */
>> +    env->load_res = -1;
>>  }
>>
>>  /* get_physical_address - get the physical address for this virtual address
>> diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
>> index f6dbbc065e..fadd88849e 100644
>> --- a/target/riscv/insn_trans/trans_rva.inc.c
>> +++ b/target/riscv/insn_trans/trans_rva.inc.c
>> @@ -61,7 +61,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
>>
>>      gen_set_label(l1);
>>      /*
>> -     * Address comparion failure.  However, we still need to
>> +     * Address comparison failure.  However, we still need to
>>       * provide the memory barrier implied by AQ/RL.
>>       */
>>      tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
>> @@ -69,6 +69,12 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
>>      gen_set_gpr(a->rd, dat);
>>
>>      gen_set_label(l2);
>> +    /*
>> +     * Clear the load reservation, since an SC must fail if there is
>> +     * an SC to any address, in between an LR and SC pair.
>> +     */
>> +    tcg_gen_movi_tl(load_res, -1);
>> +
>>      tcg_temp_free(dat);
>>      tcg_temp_free(src1);
>>      tcg_temp_free(src2);
>> --
>
> This patch causes boot failures when booting systemd built with musl on RV64.
>
> It could possibly be a musl bug, but I wanted to throw that out here
> first to see what people think.

Looking at the musl port, I see at least one bug in their atomics jumping out 
at me:

diff --git a/arch/riscv64/atomic_arch.h b/arch/riscv64/atomic_arch.h
index c9765342..41ad4d04 100644
--- a/arch/riscv64/atomic_arch.h
+++ b/arch/riscv64/atomic_arch.h
@@ -14,7 +14,7 @@ static inline int a_cas(volatile int *p, int t, int s)
                "       sc.w.aqrl %1, %4, (%2)\n"
                "       bnez %1, 1b\n"
                "1:"
-               : "=&r"(old), "=r"(tmp)
+               : "=&r"(old), "=&r"(tmp)
                : "r"(p), "r"(t), "r"(s)
                : "memory");
        return old;
@@ -31,7 +31,7 @@ static inline void *a_cas_p(volatile void *p, void *t, void *s)
                "       sc.d.aqrl %1, %4, (%2)\n"
                "       bnez %1, 1b\n"
                "1:"
-               : "=&r"(old), "=r"(tmp)
+               : "=&r"(old), "=&r"(tmp)
                : "r"(p), "r"(t), "r"(s)
                : "memory");
        return old;

It's a shot in the dark as to whether that'll fix your bug, but I could at 
least see a mechanism for it: before we yielded load reservations on context 
switches then that backwards branch would never be taken, so we wouldn't notice 
if tmp was allocated into one of the same registers as the inputs.  Even if it 
doesn't fix your issue it's still a bug so I'll send the patch out, just LMK so 
I can indicate how important the issue is.

This should manifest on hardware, but it looks like we managed to drop that SC 
patch.  I'll go send the patch out now...

>
> Alistair
>
>> 2.21.0
>>
>>

