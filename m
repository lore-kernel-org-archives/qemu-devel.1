Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E012C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 23:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364B52072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 23:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2GWCkBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364B52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOV6O-0001w8-Ep
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 19:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <natechancellor@gmail.com>) id 1jOV5l-0001LB-0D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 19:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <natechancellor@gmail.com>) id 1jOV5j-0004vj-75
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 19:35:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <natechancellor@gmail.com>)
 id 1jOV5j-0004vL-1z; Tue, 14 Apr 2020 19:35:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id x11so1583568otp.6;
 Tue, 14 Apr 2020 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YORqZ9euCUdgELYPYpyBVAiDQUydnxiQ/4UiQLERnY0=;
 b=H2GWCkBadChNGNh1aiAajF4NueL1GJn7l3lksZ/cy0sBil/AVnbJNRSLlTa2R6rulF
 RNgmjNGf2UO/2FVlla/bl+Qs6qxufiL2NJo24ZuIpFVFNxEMyHJRzP8bStz9PBq8siwC
 8TUDOOjmBaZQyYUyBesgv0QbHlO/NStLZ0H4uksls873yyviJbvsrJ+CeIgSH3AB+U1B
 pYfymjMJEqw2O9BumDzs5S5gmfdVd5cD0sGV1MkjAv7q/yujDTS9LekwCHPQgvwLbUI1
 OZtQwYZfqFkIARnFm1xe7LmSqnaTH5/FXbHC9/1qTgWPTJ0fL34EEU0LZL3UkArKe9vo
 SwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YORqZ9euCUdgELYPYpyBVAiDQUydnxiQ/4UiQLERnY0=;
 b=nbwLKl+zjBNPQlvPjDMUSSsnGzKBztv1bGudBiTIvDBqRSBK7t4HC6TvFhO/VG67fC
 GpT9D65DBc24IiZocay38thu9Prz6Ayx4UScvrWqPQvImLTRQ4A2t6jnZXPcIsa46UGw
 6angYQc1maXItl6Do7x6noF4L/zWiGs01zwrEyRExMjMjdwx7zHb94hBiJxBtyDisQ/5
 Qm3SfndFL9jVA5FuzPkYCGU3rzJYMAIr9PwWS7Y70+pN8zF5XCTSHvnOqtR5dO2vw4n9
 vy5ihB2yGdSA0iSMzTeBUaYfL9/FRouLlnxTuC4nyBMemg1i8RhzH569lOf+6/nFgDpZ
 QOFg==
X-Gm-Message-State: AGi0PuawxuQw+2BitvXEXJtlzZllJwP+bcoh8fHQpB3nQUIKLGQnNnmb
 oKiESm8FQMJWsAeGnPZwsGw=
X-Google-Smtp-Source: APiQypKDqMcdQFeEqQ+eeg0NUDmM2AacSxrjDO2re3WAznHekEDbooPvni0RRNlXN1Kvi61i4Xfmlw==
X-Received: by 2002:a9d:12ce:: with SMTP id g72mr20515638otg.350.1586907341911; 
 Tue, 14 Apr 2020 16:35:41 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
 by smtp.gmail.com with ESMTPSA id i23sm5852272otp.74.2020.04.14.16.35.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 14 Apr 2020 16:35:41 -0700 (PDT)
Date: Tue, 14 Apr 2020 16:35:39 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts
Message-ID: <20200414233539.GA5002@ubuntu-s3-xlarge-x86>
References: <20200414111131.465560-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414111131.465560-1-npiggin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 09:11:31PM +1000, Nicholas Piggin wrote:
> If mtmsr L=1 sets MSR[EE] while there is a maskable exception pending,
> it does not cause an interrupt. This causes the test case to hang:
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2019-10/msg00826.html
> 
> More recently, Linux reduced the occurance of operations (e.g., rfi)
> which stop translation and allow pending interrupts to be processed.
> This started causing hangs in Linux boot in long-running kernel tests,
> running with '-d int' shows the decrementer stops firing despite DEC
> wrapping and MSR[EE]=1.
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208301.html
> 
> The cause is the broken mtmsr L=1 behaviour, which is contrary to the
> architecture. From Power ISA v3.0B, p.977, Move To Machine State Register,
> Programming Note states:
> 
>     If MSR[EE]=0 and an External, Decrementer, or Performance Monitor
>     exception is pending, executing an mtmsrd instruction that sets
>     MSR[EE] to 1 will cause the interrupt to occur before the next
>     instruction is executed, if no higher priority exception exists
> 
> Fix this by handling L=1 exactly the same way as L=0, modulo the MSR
> bits altered.
> 
> The confusion arises from L=0 being "context synchronizing" whereas L=1
> is "execution synchronizing", which is a weaker semantic. However this
> is not a relaxation of the requirement that these exceptions cause
> interrupts when MSR[EE]=1 (e.g., when mtmsr executes to completion as
> TCG is doing here), rather it specifies how a pipelined processor can
> have multiple instructions in flight where one may influence how another
> behaves.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Anton Blanchard <anton@ozlabs.org>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Thanks very much to Nathan for reporting and testing it, I added his
> Tested-by tag despite a more polished patch, as the the basics are 
> still the same (and still fixes his test case here).

I did re-run the test with the updated version of your patch and it
passed still so that tag can still stand without any controversy :)

Thank you for the fix again!
Nathan

> This bug possibly goes back to early v2.04 / mtmsrd L=1 support around
> 2007, and the code has been changed several times since then so may
> require some backporting.
> 
> 32-bit / mtmsr untested at the moment, I don't have an environment
> handy.
> 
>  target/ppc/translate.c | 46 +++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b207fb5386..9959259dba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4361,30 +4361,34 @@ static void gen_mtmsrd(DisasContext *ctx)
>      CHK_SV;
>  
>  #if !defined(CONFIG_USER_ONLY)
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
>      if (ctx->opcode & 0x00010000) {
> -        /* Special form that does not need any synchronisation */
> +        /* L=1 form only updates EE and RI */
>          TCGv t0 = tcg_temp_new();
> +        TCGv t1 = tcg_temp_new();
>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>                          (1 << MSR_RI) | (1 << MSR_EE));
> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
> +        tcg_gen_andi_tl(t1, cpu_msr,
>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
> +        tcg_gen_or_tl(t1, t1, t0);
> +
> +        gen_helper_store_msr(cpu_env, t1);
>          tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +
>      } else {
>          /*
>           * XXX: we need to update nip before the store if we enter
>           *      power saving mode, we will exit the loop directly from
>           *      ppc_store_msr
>           */
> -        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> -        }
>          gen_update_nip(ctx, ctx->base.pc_next);
>          gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
> -        /* Must stop the translation as machine state (may have) changed */
> -        /* Note that mtmsr is not always defined as context-synchronizing */
> -        gen_stop_exception(ctx);
>      }
> +    /* Must stop the translation as machine state (may have) changed */
> +    gen_stop_exception(ctx);
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  }
>  #endif /* defined(TARGET_PPC64) */
> @@ -4394,15 +4398,23 @@ static void gen_mtmsr(DisasContext *ctx)
>      CHK_SV;
>  
>  #if !defined(CONFIG_USER_ONLY)
> -   if (ctx->opcode & 0x00010000) {
> -        /* Special form that does not need any synchronisation */
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
> +    if (ctx->opcode & 0x00010000) {
> +        /* L=1 form only updates EE and RI */
>          TCGv t0 = tcg_temp_new();
> +        TCGv t1 = tcg_temp_new();
>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>                          (1 << MSR_RI) | (1 << MSR_EE));
> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
> +        tcg_gen_andi_tl(t1, cpu_msr,
>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
> +        tcg_gen_or_tl(t1, t1, t0);
> +
> +        gen_helper_store_msr(cpu_env, t1);
>          tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +
>      } else {
>          TCGv msr = tcg_temp_new();
>  
> @@ -4411,9 +4423,6 @@ static void gen_mtmsr(DisasContext *ctx)
>           *      power saving mode, we will exit the loop directly from
>           *      ppc_store_msr
>           */
> -        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> -        }
>          gen_update_nip(ctx, ctx->base.pc_next);
>  #if defined(TARGET_PPC64)
>          tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32);
> @@ -4422,10 +4431,9 @@ static void gen_mtmsr(DisasContext *ctx)
>  #endif
>          gen_helper_store_msr(cpu_env, msr);
>          tcg_temp_free(msr);
> -        /* Must stop the translation as machine state (may have) changed */
> -        /* Note that mtmsr is not always defined as context-synchronizing */
> -        gen_stop_exception(ctx);
>      }
> +    /* Must stop the translation as machine state (may have) changed */
> +    gen_stop_exception(ctx);
>  #endif
>  }
>  
> -- 
> 2.23.0
> 

