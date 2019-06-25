Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8FFC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F026A20883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsTiaWqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F026A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfi7q-0000VF-5r
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfi73-0008FH-Pm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfi72-0007sw-9x
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:51:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfi72-0007pM-0K
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:51:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id v14so17110489wrr.4
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1lAHR5oTFCXo0fFe3w4Ev+BS0Wj3LkqFFKPjN9hbCz8=;
 b=tsTiaWqLampQDtz360gJofpuzkwiB+8heZ3n87zUa2Ha8WR9nHSjl84NV073RzWxHl
 H/j6CucXnCZRiVi/rPcgIipk+H1OptQySbWYHN5bWC7e6prVITJT21M3gjt+CU3rHyf/
 5ac+o/J31n73IkgqoBbgOrrQZyZuzWWV0lluWZPtqMjxdWTHDo5O5o+nuH53a4xZPRmY
 26Wzq9bJUWzOFdKqEc6g3ni/6gJrY1sTTB0OLChi9UuLJeLHl8RH/0TlEqVMjaJtrIKa
 KPFaNsprtOtPULiHwzZMNDBddyA9ul/4jLhIver2NfcHBiJEvbKl6Jop1Ck/R8JNVa1m
 4w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1lAHR5oTFCXo0fFe3w4Ev+BS0Wj3LkqFFKPjN9hbCz8=;
 b=dqAX+P2G/fmfgEH+xaBGS/ukPhPpAD5kF33xcAHMP3jOlloLd+bCQSUin78DYluUfG
 lB52oGMll9hUo0CBEKiz074tiMcapymLQMWBwfyZqvXaUJ5LF9L8jPWJBtPNwgsWl+5E
 A6YEaeVyJPVAfnJrU8mYYhvv+GMcLg+XaQnKw/0PtJP3G3rCUITGArYuqGm7KW5QM4vr
 Ab5msyMAkoQUUn2SGaWn3T1Aj2s4XgZNUyTPwEn2888DblJYmlq8U7BOURY53XiHlgGS
 VzDFKGPyYbrpHsu+QlA40MQPkxGWIbtjO2PVVfR0bUt1JfAv/Tf/xjBMYUrRGqH6E92N
 cdWw==
X-Gm-Message-State: APjAAAUyYPlIsn76z+mpnpsFoGfJsnUmovQtayYFxQcgje/rUcF+S4Xe
 YG49AgbJwJA6S+3Wsz1iYr06TA==
X-Google-Smtp-Source: APXvYqwGXA98clcSJw3u4FmR6qjIjlWwzAWeuvVxOsidiIg+zU8ZjpgCqQ+pPxyAQJ2OhebToeW6qw==
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr21089176wrn.342.1561456297387; 
 Tue, 25 Jun 2019 02:51:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o4sm1826720wmh.35.2019.06.25.02.51.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 02:51:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 63EAD1FF87;
 Tue, 25 Jun 2019 10:51:36 +0100 (BST)
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
 <20190624055442.2973-3-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190624055442.2973-3-vandersonmr2@gmail.com>
Date: Tue, 25 Jun 2019 10:51:36 +0100
Message-ID: <87k1da0z87.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 2/4] Adding an optional tb execution
 counter.
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> We collect the number of times each TB is executed
> and store it in the its TBStatistics.
> We also count the number of times the execution counter overflows.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tcg-runtime.c   | 10 ++++++++++
>  accel/tcg/tcg-runtime.h   |  2 ++
>  accel/tcg/translator.c    |  1 +
>  include/exec/gen-icount.h |  9 +++++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..9888a7fce8 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -167,3 +167,13 @@ void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(env_cpu(env), GETPC());
>  }
> +
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TranslationBlock *tb =3D (TranslationBlock*) ptr;

To make things clearer:

  TBStatistics *stats =3D tb->tb_stats;

> +    // if overflows, then reset the execution counter and increment the =
overflow counter
> +    if (atomic_cmpxchg(&tb->tb_stats->exec_count, 0xFFFFFFFF, 0) =3D=3D =
0xFFFFFFFF) {
> +        atomic_inc(&tb->tb_stats->exec_count_overflows);
> +    }

This is all very nice but how often do you actually see overflows?
You'll see them even less on 32 bit hosts as they have much less memory
for translations so will flush them out more often. I'd suggest making
the counter "unsigned long" and just living with the fact the 32 bit
might get the execution stats wrong if a block executes more than 4
billion times.

> +    atomic_inc(&tb->tb_stats->exec_count);
> +}
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 4fa61b49b4..bf0b75dbe8 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, pt=
r, env)
>
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
> +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
> +
>  #ifdef CONFIG_SOFTMMU
>
>  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 9226a348a3..cc06070e7e 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -54,6 +54,7 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
>      gen_tb_start(db->tb);
>      ops->tb_start(db, cpu);
>      tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
> +    gen_tb_exec_count(tb);
>
>      while (true) {
>          db->num_insns++;
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index f7669b6841..6d38b6e1fb 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -7,6 +7,15 @@
>
>  static TCGOp *icount_start_insn;
>
> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +  if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> +    TCGv_ptr tb_ptr =3D tcg_const_ptr(tb);

Why not pass the address of the counter itself to save the cost of the
indirection calculation at runtime?

> +    gen_helper_inc_exec_freq(tb_ptr);
> +    tcg_temp_free_ptr(tb_ptr);
> +  }
> +}
> +
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;


--
Alex Benn=C3=A9e

