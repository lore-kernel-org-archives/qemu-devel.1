Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DEBC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431BD2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwEgRnDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431BD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3Zh-0006Er-6q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hj3ZE-0005hz-3C
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hj3ZC-00056j-UQ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:22:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hj3ZC-00056N-KW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:22:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so6107143wms.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RWy1HrnzggJ6ITpUopTZ0QRnXVP0aQetgKt0IeZ9I+s=;
 b=MwEgRnDPCzGUu4L8WlyTm0yeoRAyRsY3IembGD3ycF1ihtBG2D3pllQSZPLiagu67I
 ghA8hq3bCp1Q5ZiyR2DMWsauzH9Ei+vmx5otF8a4vryMrSBegGvtdHIeU928G+eqGS+7
 pXjV/P4CuGwN4tOe1KUhdGIhifTuGN035acFIAEz6UFzkcpo8sFnS8+gDmpF1HPpqtGI
 0BEHt4V9jgaepNrzq+x3FPifdNPA0rI3UuwsD0BT3rkZb1YQn9gxPwgEL3CjnbmVGfTj
 Jj0uBQO1+9aN8S12EZMcZ9sF7JyL1qzMsjRvUapHx/IR3MFCR2bio4BLweGR+kgUi6nN
 TFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RWy1HrnzggJ6ITpUopTZ0QRnXVP0aQetgKt0IeZ9I+s=;
 b=NjKDj07oxogv44vd5UQ5tOclWqY/nHQqVnm1megWAsRRx6hZX4IIukQ1RsNG+Fd/vw
 cwTrWqTEjfERoz2udYDKC0F6IJR1X2zeKJeccKN6fh3UDVUu3cO8beTsUrjunuCBvava
 NNTDZredmQaDTWPG8xe8WX5B4GCEMX0MEF/f6lZ0Gcv/367yft3HYDEJmY5QIdy4RJ1H
 eOHE7Pjot+a3kfaO4Up2o1zaIiyO2hVhB4e0/f02VkUYdIOncy0OHJ/k3IMwIJ/0vxMd
 GUJOSrPivLfKxiAi0Y6lSaNpBhuLe+iDLrdEQRn/yALu58EW75GDXDUqflmBrrvhuJ5N
 medQ==
X-Gm-Message-State: APjAAAUM4EA+1CzytiRl6Z2J5SW/wJ8ErPXYeFwVOpKRXYPQ4f0CEh0w
 IwyoRsWt+dCHpcH684/VjO3wbg==
X-Google-Smtp-Source: APXvYqz+wA+LoJRBdWdR4HJPUdmr57gUJrY/kXRFIYCBGcR+ANtICUgk5SYAJBy49loDE5eHHPyVrQ==
X-Received: by 2002:a1c:7ec7:: with SMTP id z190mr81049wmc.17.1562253752542;
 Thu, 04 Jul 2019 08:22:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 5sm3714111wmg.42.2019.07.04.08.22.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 08:22:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 96C981FF87;
 Thu,  4 Jul 2019 16:22:31 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-2-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190702210017.4275-2-vandersonmr2@gmail.com>
Date: Thu, 04 Jul 2019 16:22:31 +0100
Message-ID: <878stdx1s8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 2/6] accel/tcg: Adding an optional tb
 execution counter
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

> We add the option to instrument each TB to
> count the number of times it is executed and
> store this in the its TBStatistics struct.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tcg-runtime.c   | 7 +++++++
>  accel/tcg/tcg-runtime.h   | 2 ++
>  accel/tcg/translator.c    | 1 +
>  include/exec/gen-icount.h | 9 +++++++++
>  4 files changed, 19 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..f332eae334 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(env_cpu(env), GETPC());
>  }
> +
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TBStatistics *stats =3D (TBStatistics *) ptr;
> +    g_assert(stats);
> +    atomic_inc(&stats->executions.total);
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
> index f7669b6841..6701ab70c0 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -7,6 +7,15 @@
>
>  static TCGOp *icount_start_insn;
>
> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && tb->tb_stats) {

so with the changes suggested in 1/6 it would become:

 if (tb->tb_stats && tb->tb_stats.stats_enabled & TB_EXEC_STATS) {

 }

which would eventually make the granularity controllable on a per-TB
basis. You could even hide the above check in a inline helper in the
headers (tb-stats.h?).

> +        TCGv_ptr ptr =3D tcg_const_ptr(tb->tb_stats);
> +        gen_helper_inc_exec_freq(ptr);
> +        tcg_temp_free_ptr(ptr);
> +    }
> +}
> +
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;


--
Alex Benn=C3=A9e

