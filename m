Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73FECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CAE206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUTJCWBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CAE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5eT-0001j4-K0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5dQ-0000Pz-3H
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5dO-0004bX-V0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:04:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5dO-0004aI-PO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:03:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id o18so20892459wrv.13
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aSYqkGoX+o4p7b7Vv2xEx6aku0erFvJHi2mSr0H6lLE=;
 b=kUTJCWBN6dHbCc6dBxiXH8yp69o6CXlu4LuIJE2GsFCTxDphFP2TDFWEAS+hvLf3vG
 sorgpAEbdwqlA3S7Zk2IgoEWr8+sOts6hsYqttHhFcZSWUsOTWzFflGjoil3U55Jg8Aa
 N6N2ghlkFXR7o38YVKD9RZVYK1AUuONBjadpHQyOwXLkqV8Z8jVXXiyHbYbf+nDoAgzg
 OxtMiIj4HQ4aAJQnS1Vwx8cTjmgNsXmINZjwzDZrskcb0RkwEkizN6ksJjP+Zh9lJ8Ed
 gXXx6shvVX49uly2PRvtuEjRLLCXMhiSzlFAGJylSoVWC3FpQ6uj4L1UeEpzD6PhVCqT
 nXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aSYqkGoX+o4p7b7Vv2xEx6aku0erFvJHi2mSr0H6lLE=;
 b=fsyqK8Izj9CyrYPWkPCWhQQL+Fq7jYmLzVdyEfyfGvm9MHtnOPqfkZ5WphLQrVT+Qt
 U1MLXuBAkz/Ikc0iNZlTTzASb8PycB3TKaMiZ7hC+Uf2B8a8KWUTrAqaQYBy6d2L+Y7u
 B3lJPobSZ9x3MHe+8h3NDtQGFzLpWX8XmQxWzNQaQ68x/TF+UXMQ/E7zoquZcsYrYSlb
 TpTbROa0USNsqzxTK5zWSoAdRSgYtVsFBwhAQ/Ab8TqXAxpnmPQY33pQ5mwqVUH7yHqc
 3Gtx/4RXvCi2IOnp0WNYp7S7qx4Aqd9L8ehqal6rpeZi4hfDLutGV3zqwRAPqszAT+LX
 66vw==
X-Gm-Message-State: APjAAAVyaF0lOwpkE2Z5R8eLRUJKiGvG6BaJus/6IfJdy7j/yFvDKDrg
 wFIALIDuvyo7VoHpSVXUAzrWpA==
X-Google-Smtp-Source: APXvYqwZV4f0GGqTkMYJBoCBN1Xs5HbMe0gWLOE68PoUI9tBlTirqX7VGENznG30VjsurMW16FkCIw==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr27145288wrn.254.1571079836677; 
 Mon, 14 Oct 2019 12:03:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm33888954wrd.39.2019.10.14.12.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 12:03:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FEEC1FF87;
 Mon, 14 Oct 2019 20:03:55 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-18-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 17/20] target/arm: Rebuild hflags at MSR writes
In-reply-to: <20191011155546.14342-18-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 20:03:55 +0100
Message-ID: <877e57m9no.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Continue setting, but not relying upon, env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 13 +++++++++++--
>  target/arm/translate.c     | 28 +++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2d6cd09634..d4bebbe629 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1789,8 +1789,17 @@ static void handle_sys(DisasContext *s, uint32_t i=
nsn, bool isread,
>      if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO=
)) {
>          /* I/O operations must end the TB here (whether read or write) */
>          s->base.is_jmp =3D DISAS_UPDATE;
> -    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> -        /* We default to ending the TB on a coprocessor register write,
> +    }
> +    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +        /*
> +         * A write to any coprocessor regiser that ends a TB
> +         * must rebuild the hflags for the next TB.
> +         */
> +        TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
> +        tcg_temp_free_i32(tcg_el);
> +        /*
> +         * We default to ending the TB on a coprocessor register write,
>           * but allow this to be suppressed by the register definition
>           * (usually only necessary to work around guest bugs).
>           */
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 698c594e8c..cb47cd9744 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6890,6 +6890,8 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
>      ri =3D get_arm_cp_reginfo(s->cp_regs,
>              ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
>      if (ri) {
> +        bool need_exit_tb;
> +
>          /* Check access permissions */
>          if (!cp_access_ok(s->current_el, ri, isread)) {
>              return 1;
> @@ -7068,14 +7070,30 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
>              }
>          }
>
> -        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_C=
P_IO)) {
> -            /* I/O operations must end the TB here (whether read or writ=
e) */
> -            gen_lookup_tb(s);
> -        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> -            /* We default to ending the TB on a coprocessor register wri=
te,
> +        /* I/O operations must end the TB here (whether read or write) */
> +        need_exit_tb =3D ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) &&
> +                        (ri->type & ARM_CP_IO));
> +
> +        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +            /*
> +             * A write to any coprocessor regiser that ends a TB
> +             * must rebuild the hflags for the next TB.
> +             */
> +            TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +            if (arm_dc_feature(s, ARM_FEATURE_M)) {
> +                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
> +            } else {
> +                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +            }
> +            tcg_temp_free_i32(tcg_el);
> +            /*
> +             * We default to ending the TB on a coprocessor register wri=
te,
>               * but allow this to be suppressed by the register definition
>               * (usually only necessary to work around guest bugs).
>               */
> +            need_exit_tb =3D true;
> +        }
> +        if (need_exit_tb) {
>              gen_lookup_tb(s);
>          }


--
Alex Benn=C3=A9e

