Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C117C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824272080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="eQ3yaqkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824272080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsND-00065N-DO
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kRsMH-0005bg-TH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:35:01 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:55250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kRsMF-0001DE-Hv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:35:01 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 8268EC60159;
 Mon, 12 Oct 2020 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602488093;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzyYmC+xd/GFQse4jFVniyC9pD9uXu6rOvGHFpleeas=;
 b=eQ3yaqkHR9BzIMjunVd3ml8vkOjAxbV2Z7KD7L61HJ/LBJuQq6hVywujXmFkxSi9Uwhud6
 jKFato+pQilpPkVM0x1iBdIQb6Ybwid4VbPLQ78q28/7/MtlpSeezE/erYyDiukm5Lr7g5
 SOsBeXfD1/Owf2KbffIdHY3hWSqu9KA9gObyGSqjD6tF7EyA5NleHIA7BcPAOS/H+mHM3h
 pZuBsQVpbgryvHc7MQOUjbLALku8HOfsUj1Wgtn9OQWSTI2Bk3JIxlfJSi8O6U/Q4H7NLn
 D6M5zZADb0Bp6ekcgGwUry+Gf4oLSUz2Qq+o0WWHhZlcW+RntWeNwqXo1fdKww==
Date: Mon, 12 Oct 2020 09:35:55 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 05/20] target/mips: Move cpu_mips_get_random() with
 CP0 helpers
Message-ID: <20201012073555.iitiqbpqrgo4xscd@sekoia-pc.home.lmichel.fr>
References: <20201010204319.3119239-1-f4bug@amsat.org>
 <20201010204319.3119239-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201010204319.3119239-6-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602488093;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzyYmC+xd/GFQse4jFVniyC9pD9uXu6rOvGHFpleeas=;
 b=LOJZDSfpUV/i88L8MxH7ZDia397DToWYKQUQ5oyimNfd/Hh28ONiZlteNO3c1kduWNuSIo
 gh1HIqrUADabjrpDl9b5v704lViX+iFFhZ49oizC+aY7iJgdpeJF6nN9RjLh6orKhskUWj
 LCMc5x5bBWsdAeyx4Wb3qiGNM9MngvY77uzQJlHWSZOmSvzCqt6vXTrJNeN8OyeALrM0JU
 ef7JUOZ2NGWjUA7/DxkgXD+ukMxeWjTpRLav5G+oivQocuHUEjBFj9a4DFn+pEWLlCVdJY
 ksWdUm7FqfxvLa//SEJcqlpyFzqoBr3o7rUYpv679SWvFG7cWCVdWuU1OhuxbA==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602488093; a=rsa-sha256; cv=none;
 b=RZqCdQQCtihOPOjlYRCwGzyDAmig4fhEWZV5ITxKSwtWmbAVBReDL/Mci4OirP0dVkJG7qorGLtAj2AcR+dwGtrt6Gk4WvZiI6odk87J02zqiBFY3SvhmsHTIEdaGk1eXwxoC/QWsazmPopva3uK+mT95GkvqVmkiU8xSDvl2kUEcX/Gv3KSHeYMP+vU7c5Ip7B3uI6Zdk+LrkCgHYqqfFc9BsdU6FNxGaL1Cvnm7v9vak6XpXQDiTE4bqiuCZ4lE83NVW9mQf7JTLjhR82E8i7qkt0C3YRKR/ItE9t+//bsTO1tz6xm+O8MczTNjTT1qhYXbKBWJIs7w8a8xi3Uvw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 03:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22:43 Sat 10 Oct     , Philippe Mathieu-Daudé wrote:
> The get_random() helper uses the CP0_Wired register, which is
> unrelated to the CP0_Count register use as timer.
typo: used
> Commit e16fe40c872 ("Move the MIPS CPU timer in a separate file")
> incorrectly moved this get_random() helper with timer specific
> code. Move it back to generic CP0 helpers.
> 
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  target/mips/internal.h   |  2 +-
>  target/mips/cp0_helper.c | 25 +++++++++++++++++++++++++
>  target/mips/cp0_timer.c  | 25 -------------------------
>  3 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 7f159a9230c..087cabaa6d4 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -144,6 +144,7 @@ void r4k_helper_tlbr(CPUMIPSState *env);
>  void r4k_helper_tlbinv(CPUMIPSState *env);
>  void r4k_helper_tlbinvf(CPUMIPSState *env);
>  void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
> +uint32_t cpu_mips_get_random(CPUMIPSState *env);
>  
>  void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                      vaddr addr, unsigned size,
> @@ -209,7 +210,6 @@ void cpu_state_reset(CPUMIPSState *s);
>  void cpu_mips_realize_env(CPUMIPSState *env);
>  
>  /* cp0_timer.c */
> -uint32_t cpu_mips_get_random(CPUMIPSState *env);
>  uint32_t cpu_mips_get_count(CPUMIPSState *env);
>  void cpu_mips_store_count(CPUMIPSState *env, uint32_t value);
>  void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value);
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index de64add038b..12143ac55b9 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -203,6 +203,31 @@ static void sync_c0_entryhi(CPUMIPSState *cpu, int tc)
>      *tcst |= asid;
>  }
>  
> +/* XXX: do not use a global */
> +uint32_t cpu_mips_get_random(CPUMIPSState *env)
> +{
> +    static uint32_t seed = 1;
> +    static uint32_t prev_idx;
> +    uint32_t idx;
> +    uint32_t nb_rand_tlb = env->tlb->nb_tlb - env->CP0_Wired;
> +
> +    if (nb_rand_tlb == 1) {
> +        return env->tlb->nb_tlb - 1;
> +    }
> +
> +    /* Don't return same value twice, so get another value */
> +    do {
> +        /*
> +         * Use a simple algorithm of Linear Congruential Generator
> +         * from ISO/IEC 9899 standard.
> +         */
> +        seed = 1103515245 * seed + 12345;
> +        idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
> +    } while (idx == prev_idx);
> +    prev_idx = idx;
> +    return idx;
> +}
> +
>  /* CP0 helpers */
>  target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
>  {
> diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
> index bd7efb152dd..9c38e9da1c8 100644
> --- a/target/mips/cp0_timer.c
> +++ b/target/mips/cp0_timer.c
> @@ -29,31 +29,6 @@
>  
>  #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
>  
> -/* XXX: do not use a global */
> -uint32_t cpu_mips_get_random(CPUMIPSState *env)
> -{
> -    static uint32_t seed = 1;
> -    static uint32_t prev_idx = 0;
> -    uint32_t idx;
> -    uint32_t nb_rand_tlb = env->tlb->nb_tlb - env->CP0_Wired;
> -
> -    if (nb_rand_tlb == 1) {
> -        return env->tlb->nb_tlb - 1;
> -    }
> -
> -    /* Don't return same value twice, so get another value */
> -    do {
> -        /*
> -         * Use a simple algorithm of Linear Congruential Generator
> -         * from ISO/IEC 9899 standard.
> -         */
> -        seed = 1103515245 * seed + 12345;
> -        idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
> -    } while (idx == prev_idx);
> -    prev_idx = idx;
> -    return idx;
> -}
> -
>  /* MIPS R4K timer */
>  static void cpu_mips_timer_update(CPUMIPSState *env)
>  {
> -- 
> 2.26.2
> 

-- 

