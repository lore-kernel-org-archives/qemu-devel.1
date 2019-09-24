Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E20C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7D1207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZFXZoqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7D1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCpf4-0005vW-Ns
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 14:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCpde-0005Ks-PF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 14:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCpdd-0003vO-5A
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 14:34:14 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCpdZ-0003rz-83; Tue, 24 Sep 2019 14:34:09 -0400
Received: by mail-lf1-x143.google.com with SMTP id u28so2185428lfc.5;
 Tue, 24 Sep 2019 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0WUBUDYYD97l0YxSlbW+BjQJFD96jFL3ws7Jj4OI5sk=;
 b=pZFXZoqu0jfCEhU1stE6pwtYTO6G9jOox2HWoDh6axguhL253iag/okyo1tNYYoa/A
 qbqTHIZqfnMelxrkLJejiawGug0/ACEI7wcuoIfsBLKQcxWKnvkcZSu5uRx80pqod0pf
 jaNZ6ZXwyCEx2oMTfCtRc2jO5ylZw/EEjB1yb/n8boaaGCIqIOvXMVBPDzjGecqiL/3h
 QPpB2Y6XFZQTFGfhuR1bXu4r6VUoOTKlbfpxAKbdh3K8PhJgBzDjn/yDkHmv38nLCLlo
 q9wW1xA2iVh2BOfnWDjB68LKWPxShlcYTrAB92ixKxOqWYXp1IR2TtJ/ZxIkNXue6Dg/
 JXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0WUBUDYYD97l0YxSlbW+BjQJFD96jFL3ws7Jj4OI5sk=;
 b=GpCeTtDXIeG5khajlXBl+N5+Tamcr7xrF+jILKqeqGhnN2rbZUoFiwyZ6iGX+Voq7V
 Y4NrjjVS1ov21lO2lt2uF5F2ytmkaByOIj5ejTlyaVzOmBX8Uqn1KgnAG5YjBNFYrgg9
 C6WKAL+0ZhuMYOVmaP0jucOo6u0yKmBA6jVVf9b6yZMbRp2WtcnzoESulwQMj5oIhK3H
 Deg4VYpCdGN3rQaSYXEatKOQfGNRtwoLINCzIqt39KZokleM3ByPvp3RBV6S7+tpnBAZ
 UTla05RirK/MgH+Nz8otB/5gMfAEqBfXKBtWKsqlzTpBvBF1Fkaat92ll95fNTe/WTzS
 3S8g==
X-Gm-Message-State: APjAAAWNqY2zL8X4pDjJf4LYP3IVKt+moACLGhJJ6juvQXhaymjTzQHX
 9va4XscQ1bUWWInYLriZrxWnM46ZGCfH+p973yI=
X-Google-Smtp-Source: APXvYqzu6P4fzmY0JdHTcPV4gJ36sp387IwuhqIEJOXC7ekEjKBwNLqlQX40exKW60huJ/EuB0MoZbqkgr16m9WqUwk=
X-Received: by 2002:a19:4912:: with SMTP id w18mr2687562lfa.93.1569350047032; 
 Tue, 24 Sep 2019 11:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190616191900.GH61734@hippo.sing.id.au>
 <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
 <20190624180837.GM61734@hippo.sing.id.au>
In-Reply-To: <20190624180837.GM61734@hippo.sing.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Sep 2019 11:29:25 -0700
Message-ID: <CAKmqyKP+HNfzh5kCKkGDtfr=pDRwcjL+dUQ79NZEk+jMZ3q=_Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
To: Joel Sing <joel@sing.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: me@carlosedp.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 11:21 AM Joel Sing <joel@sing.id.au> wrote:
>
> On 19-06-17 16:52:44, Richard Henderson wrote:
> > On 6/16/19 12:19 PM, Joel Sing wrote:
> > > +    /*
> > > +     * Clear the load reservation, since an SC must fail if there is
> > > +     * an SC to any address, in between an LR and SC pair.
> > > +     */
> > > +    tcg_gen_movi_tl(load_res, 0);
> > > +
> > >      gen_set_label(l2);
> >
> > This clear needs to be moved down below label l2.
> > Otherwise, with lr / sc / sc, the second sc could succeed in error.
>
> Indeed, thanks.
>
> > FWIW, other targets have used -1 as the "invalid" load reservation, since the
> > architecture does not require address 0 to be unmapped.  This should be quite
> > visible in M-mode with paging disabled and ram at offset 0.  Often, other
> > targets require alignment for the lr/sc address, though I don't see that for riscv.
>
> I've switched to -1 as suggested. Regarding the alignment for reservations, the
> specification does require this, although I do not recall seeing any enforcement
> of this by qemu itself.
>
> New diff follows.
>
> From 8ef31a2ce8ef1cbeee92995a0b2994f480e9bb6d Mon Sep 17 00:00:00 2001
> From: Joel Sing <joel@sing.id.au>
> Date: Tue, 25 Jun 2019 02:44:24 +1000
> Subject: [PATCH] Clear load reservations on qemu riscv target
>
> This prevents a load reservation from being placed in one context/process,
> then being used in another, resulting in an SC succeeding incorrectly and
> breaking atomics.
>
> Signed-off-by: Joel Sing <joel@sing.id.au>
> ---
>  target/riscv/cpu.c                      | 1 +
>  target/riscv/cpu_helper.c               | 9 +++++++++
>  target/riscv/insn_trans/trans_rva.inc.c | 8 +++++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..e7c8bf48fc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -281,6 +281,7 @@ static void riscv_cpu_reset(CPUState *cs)
>      env->pc = env->resetvec;
>  #endif
>      cs->exception_index = EXCP_NONE;
> +    env->load_res = -1;
>      set_default_nan_mode(1, &env->fp_status);
>  }
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index b17f169681..6a07b12e65 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -113,6 +113,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>      }
>      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>      env->priv = newpriv;
> +
> +    /* Clear the load reservation - otherwise a reservation placed in one
> +     * context/process can be used by another, resulting in an SC succeeding
> +     * incorrectly. Version 2.2 of the ISA specification explicitly requires
> +     * this behaviour, while later revisions say that the kernel "should" use
> +     * an SC instruction to force the yielding of a load reservation on a
> +     * preemptive context switch. As a result, do both.
> +     */
> +    env->load_res = -1;
>  }
>
>  /* get_physical_address - get the physical address for this virtual address
> diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
> index f6dbbc065e..fadd88849e 100644
> --- a/target/riscv/insn_trans/trans_rva.inc.c
> +++ b/target/riscv/insn_trans/trans_rva.inc.c
> @@ -61,7 +61,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
>
>      gen_set_label(l1);
>      /*
> -     * Address comparion failure.  However, we still need to
> +     * Address comparison failure.  However, we still need to
>       * provide the memory barrier implied by AQ/RL.
>       */
>      tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
> @@ -69,6 +69,12 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
>      gen_set_gpr(a->rd, dat);
>
>      gen_set_label(l2);
> +    /*
> +     * Clear the load reservation, since an SC must fail if there is
> +     * an SC to any address, in between an LR and SC pair.
> +     */
> +    tcg_gen_movi_tl(load_res, -1);
> +
>      tcg_temp_free(dat);
>      tcg_temp_free(src1);
>      tcg_temp_free(src2);
> --

This patch causes boot failures when booting systemd built with musl on RV64.

It could possibly be a musl bug, but I wanted to throw that out here
first to see what people think.

Alistair

> 2.21.0
>
>

