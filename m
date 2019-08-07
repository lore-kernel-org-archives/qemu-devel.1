Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A1EC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D488021BE6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckh+7chE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D488021BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvI6C-0003Xr-5v
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvI4U-0001fI-Pc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvI4S-0006gI-Rm
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:17:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvI4M-0006ce-DL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:17:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so81057137wml.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e9nIq4XSnTqnIAYkxq1EbcBvHYOwWQkZUzEZJ0aaXBI=;
 b=ckh+7chE+9uDH0bz6zltGZcjV8fIo0rLItwGE/520MpUXgd9YzimZfMyQ3vl3eF5z5
 Yj5HP3sNO1F+g8po5vvHKRRDUQxdyUzzDPGow2KGiyggu/TI8GucMqy6CTnfuieAfJXa
 2ZQvwtv6xnTMaPhWH1Mxt5ebUIg1jsDNge4NdV0nozAQQ2vWKInz6jNbiX/121aoLVy/
 9GWwBWW4q5iK4zqz2RdrUXsCCUxl9S4cju6QYijbqLzqK2wXeawxzBeGK7gXqf+es0Sq
 NLad6npFyQK7iZFLHVK2DD8NMc52a9UqDVH+Mxg1EecKn6qX9uD45HUJzOQ7s33DDeIA
 woEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e9nIq4XSnTqnIAYkxq1EbcBvHYOwWQkZUzEZJ0aaXBI=;
 b=SvRGrDyR3+l9g09HN0doiOD0Ffd3dDsjL3t21skE0lMfPINsaiDvYRO41R6T9pTpDJ
 +zKJthtj6WTVTssCficY5Z+r34mKsYtFls321r0DcMMMrNtSYnk2w3lxMrgrMlOHzlx5
 e5lZLi3exE/x8iDTSjsqD/8g1qAPqAmSTv8w/URZr1efQXpAJfd5jlAvUUB7VNgl1VMM
 PSnvTvrgymRsi+kq/rNaiLpIyUMTA7JhoXQZ3VZ1Pp5+9y7AqfxIjuF8BFHaAURqQAZe
 yb5oRI/kLjI8s36ZZ5UGAO5J3m9IFo4nxrEn9Lrhsng/gID3u1m7QEPDD7PA6e6ZFuVh
 pSNQ==
X-Gm-Message-State: APjAAAWEfZluqTU6nGKauYdkZlx3RJHA2+PBrOw1mH+w8fsa7/1Eeuo2
 gh4SgsVvixdQ6dNepMWasIKBjqlyNF4=
X-Google-Smtp-Source: APXvYqzwfPEXcDpu3NIHFBcUUS075GG84S9l828uezR5FmI5zQE6HgJQXbI6SItoi4wEyywd93ANyQ==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr9638675wmi.38.1565169435340; 
 Wed, 07 Aug 2019 02:17:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h133sm96782343wme.28.2019.08.07.02.17.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 02:17:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F5201FF87;
 Wed,  7 Aug 2019 10:17:14 +0100 (BST)
References: <20190805130952.4415-1-peter.maydell@linaro.org>
 <20190805130952.4415-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190805130952.4415-2-peter.maydell@linaro.org>
Date: Wed, 07 Aug 2019 10:17:14 +0100
Message-ID: <87tvatibc5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] target/arm: Factor out
 'generate singlestep exception' function
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Factor out code to 'generate a singlestep exception', which is
> currently repeated in four places.
>
> To do this we need to also pull the identical copies of the
> gen-exception() function out of translate-a64.c and translate.c
> into translate.h.
>
> (There is a bug in the code: we're taking the exception to the wrong
> target EL.  This will be simpler to fix if there's only one place to
> do it.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate.h     | 23 +++++++++++++++++++++++
>  target/arm/translate-a64.c | 19 ++-----------------
>  target/arm/translate.c     | 20 ++------------------
>  3 files changed, 27 insertions(+), 35 deletions(-)
>
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index a20f6e20568..45053190baa 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -2,6 +2,7 @@
>  #define TARGET_ARM_TRANSLATE_H
>
>  #include "exec/translator.h"
> +#include "internals.h"
>
>
>  /* internal defines */
> @@ -232,6 +233,28 @@ static inline void gen_ss_advance(DisasContext *s)
>      }
>  }
>
> +static inline void gen_exception(int excp, uint32_t syndrome,
> +                                 uint32_t target_el)
> +{
> +    TCGv_i32 tcg_excp =3D tcg_const_i32(excp);
> +    TCGv_i32 tcg_syn =3D tcg_const_i32(syndrome);
> +    TCGv_i32 tcg_el =3D tcg_const_i32(target_el);
> +
> +    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
> +                                       tcg_syn, tcg_el);
> +
> +    tcg_temp_free_i32(tcg_el);
> +    tcg_temp_free_i32(tcg_syn);
> +    tcg_temp_free_i32(tcg_excp);
> +}
> +
> +/* Generate an architectural singlestep exception */
> +static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
> +{
> +    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, isv, ex),
> +                  default_exception_el(s));
> +}
> +
>  /*
>   * Given a VFP floating point constant encoded into an 8 bit immediate i=
n an
>   * instruction, expand it to the actual constant value of the specified
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d3231477a27..f6729b96fd0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -253,19 +253,6 @@ static void gen_exception_internal(int excp)
>      tcg_temp_free_i32(tcg_excp);
>  }
>
> -static void gen_exception(int excp, uint32_t syndrome, uint32_t target_e=
l)
> -{
> -    TCGv_i32 tcg_excp =3D tcg_const_i32(excp);
> -    TCGv_i32 tcg_syn =3D tcg_const_i32(syndrome);
> -    TCGv_i32 tcg_el =3D tcg_const_i32(target_el);
> -
> -    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
> -                                       tcg_syn, tcg_el);
> -    tcg_temp_free_i32(tcg_el);
> -    tcg_temp_free_i32(tcg_syn);
> -    tcg_temp_free_i32(tcg_excp);
> -}
> -
>  static void gen_exception_internal_insn(DisasContext *s, int offset, int=
 excp)
>  {
>      gen_a64_set_pc_im(s->pc - offset);
> @@ -305,8 +292,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
>       * of the exception, and our syndrome information is always correct.
>       */
>      gen_ss_advance(s);
> -    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
> -                  default_exception_el(s));
> +    gen_swstep_exception(s, 1, s->is_ldex);
>      s->base.is_jmp =3D DISAS_NORETURN;
>  }
>
> @@ -14261,8 +14247,7 @@ static void aarch64_tr_translate_insn(DisasContex=
tBase *dcbase, CPUState *cpu)
>           * bits should be zero.
>           */
>          assert(dc->base.num_insns =3D=3D 1);
> -        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
> -                      default_exception_el(dc));
> +        gen_swstep_exception(dc, 0, 0);
>          dc->base.is_jmp =3D DISAS_NORETURN;
>      } else {
>          disas_a64_insn(env, dc);
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 7853462b21b..19b9d8f2725 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -282,20 +282,6 @@ static void gen_exception_internal(int excp)
>      tcg_temp_free_i32(tcg_excp);
>  }
>
> -static void gen_exception(int excp, uint32_t syndrome, uint32_t target_e=
l)
> -{
> -    TCGv_i32 tcg_excp =3D tcg_const_i32(excp);
> -    TCGv_i32 tcg_syn =3D tcg_const_i32(syndrome);
> -    TCGv_i32 tcg_el =3D tcg_const_i32(target_el);
> -
> -    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
> -                                       tcg_syn, tcg_el);
> -
> -    tcg_temp_free_i32(tcg_el);
> -    tcg_temp_free_i32(tcg_syn);
> -    tcg_temp_free_i32(tcg_excp);
> -}
> -
>  static void gen_step_complete_exception(DisasContext *s)
>  {
>      /* We just completed step of an insn. Move from Active-not-pending
> @@ -308,8 +294,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
>       * of the exception, and our syndrome information is always correct.
>       */
>      gen_ss_advance(s);
> -    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
> -                  default_exception_el(s));
> +    gen_swstep_exception(s, 1, s->is_ldex);
>      s->base.is_jmp =3D DISAS_NORETURN;
>  }
>
> @@ -12024,8 +12009,7 @@ static bool arm_pre_translate_insn(DisasContext *=
dc)
>           * bits should be zero.
>           */
>          assert(dc->base.num_insns =3D=3D 1);
> -        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
> -                      default_exception_el(dc));
> +        gen_swstep_exception(dc, 0, 0);
>          dc->base.is_jmp =3D DISAS_NORETURN;
>          return true;
>      }


--
Alex Benn=C3=A9e

