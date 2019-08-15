Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21363C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 07:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CDA2063F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwBJ87Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CDA2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyAEH-0005UI-RL
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 03:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyAD4-0004y3-6R
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyAD0-0008Cd-3P
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:30:08 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyACy-00086h-3g
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:30:05 -0400
Received: by mail-ot1-x344.google.com with SMTP id j7so3986089ota.9
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=w62FAUJy4Ws7NyT3wzhR+Um/0l/YYVKx+kYI6mePGdQ=;
 b=mwBJ87Rt38lKcXGHs3pINkBu9GfDH5R1G/nund2U6uGxPSayN9p3FzCc5qKa9bdILf
 jBYhje2WZavR2OKh5HK2hp6BnP5P8zrNhw8WGf0VNOkHO7gVYNZH6AkucsqhXp34y0Do
 DgphLY8yLRlHwOLlHwoNLlsDlykxVhOd6vk/Ox5BwmcvSQHO/8PwhO5HTY6fMbS8lbxf
 WVyLOifhbIkg0x8wH2qNbvHy0svuYq+SqMYW5H3hQ5RjQ0Mk2PGDJNJvPZWJSru45kL+
 cWYULJLWAzM2az1xPTsQCWRzPemfCxGF8G0a6yTImFcFM8XCz4GYJt2v6/kMg4NwSYaU
 aKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=w62FAUJy4Ws7NyT3wzhR+Um/0l/YYVKx+kYI6mePGdQ=;
 b=HYlKHGcvTYCAH56dZHE7InSDKgYuZQAOX3PWBDZIHEZuV4KtKf+WOx3TQ84ZcdSa4E
 loNV8B9kS14/RMeLxwkJaKHOfJB2WuC5Xh3Cn1sXyopvlqnTutIGnPXZTljEqrrVWPOA
 D9EmPTMz0DrMcuUa/I0UwbLli4fQZAzVd82rGRhlUS/49luCUNBS2LWafjIuzLjS/CoN
 LRpZ9ZzkJeWCpfL+O/+p5hXwGqYtruU2r1FX8zeq+nmU9n5fK2dDsnvs2VWJ2y3gTvEA
 HtK9YV9y+t6GljKMWh7opABqRgOlgpyv8I61CPve+jdJfks01k1XUaYcR1GKj78dvPXG
 9Onw==
X-Gm-Message-State: APjAAAUI3GgOn5Hz8Aauk0waX25rLaXcrd/b2MP1kEb7VifNFKAb9SZq
 jLDsNfhEyn/amsvMth4WL0t/b1Lb9Su6vS58DTg=
X-Google-Smtp-Source: APXvYqz25znI/n9Z1sK1K/VcZwd44MGldTAwXgFtOJ1+ECKu3DFMqiJIyBLxT31Bj6XnwdVJHwtgEPS30KJxcSrelQo=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr2232035oti.121.1565854201766; 
 Thu, 15 Aug 2019 00:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 00:30:01
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 00:30:01
 -0700 (PDT)
In-Reply-To: <20190815020928.9679-3-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-3-jan.bobek@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 09:30:01 +0200
Message-ID: <CAL1e-=j9eDuFSspcUx3oac3UFvY7-N4rYOwVvQ2eSvc9DnbC=A@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v3 02/46] target/i386: Push rex_w into
 DisasContext
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.08.2019. 04.13, "Jan Bobek" <jan.bobek@gmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Richard Henderson <rth@twiddle.net>
>
> Treat this the same as we already do for other rex bits.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/i386/translate.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index d74dbfd585..c0866c2797 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -44,11 +44,13 @@
>  #define REX_X(s) ((s)->rex_x)
>  #define REX_B(s) ((s)->rex_b)
>  #define REX_R(s) ((s)->rex_r)
> +#define REX_W(s) ((s)->rex_w)
>  #else
>  #define CODE64(s) 0
>  #define REX_X(s) 0
>  #define REX_B(s) 0
>  #define REX_R(s) 0
> +#define REX_W(s) -1

The commit message says "treat rex_w the same as other rex bits". Why is
then REX_W() treated differently here?

Yours,
Aleksandar

>  #endif
>
>  #ifdef TARGET_X86_64
> @@ -100,7 +102,7 @@ typedef struct DisasContext {
>  #ifdef TARGET_X86_64
>      int lma;    /* long mode active */
>      int code64; /* 64 bit code segment */
> -    int rex_x, rex_b, rex_r;
> +    int rex_x, rex_b, rex_r, rex_w;
>  #endif
>      int vex_l;  /* vex vector length */
>      int vex_v;  /* vex vvvv register, without 1's complement.  */
> @@ -4495,7 +4497,6 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      int modrm, reg, rm, mod, op, opreg, val;
>      target_ulong next_eip, tval;
>      target_ulong pc_start =3D s->base.pc_next;
> -    int rex_w;
>
>      s->pc_start =3D s->pc =3D pc_start;
>      s->override =3D -1;
> @@ -4503,6 +4504,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      s->rex_x =3D 0;
>      s->rex_b =3D 0;
>      s->rex_r =3D 0;
> +    s->rex_w =3D -1;
>      s->x86_64_hregs =3D false;
>  #endif
>      s->rip_offset =3D 0; /* for relative ip address */
> @@ -4514,7 +4516,6 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      }
>
>      prefixes =3D 0;
> -    rex_w =3D -1;
>
>   next_byte:
>      b =3D x86_ldub_code(env, s);
> @@ -4557,7 +4558,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      case 0x40 ... 0x4f:
>          if (CODE64(s)) {
>              /* REX prefix */
> -            rex_w =3D (b >> 3) & 1;
> +            s->rex_w =3D (b >> 3) & 1;
>              s->rex_r =3D (b & 0x4) << 1;
>              s->rex_x =3D (b & 0x2) << 2;
>              s->rex_b =3D (b & 0x1) << 3;
> @@ -4606,7 +4607,9 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>                  s->rex_b =3D (~vex2 >> 2) & 8;
>  #endif
>                  vex3 =3D x86_ldub_code(env, s);
> -                rex_w =3D (vex3 >> 7) & 1;
> +#ifdef TARGET_X86_64
> +                s->rex_w =3D (vex3 >> 7) & 1;
> +#endif
>                  switch (vex2 & 0x1f) {
>                  case 0x01: /* Implied 0f leading opcode bytes.  */
>                      b =3D x86_ldub_code(env, s) | 0x100;
> @@ -4631,9 +4634,9 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      /* Post-process prefixes.  */
>      if (CODE64(s)) {
>          /* In 64-bit mode, the default data size is 32-bit.  Select
64-bit
> -           data with rex_w, and 16-bit data with 0x66; rex_w takes
precedence
> +           data with REX_W, and 16-bit data with 0x66; REX_W takes
precedence
>             over 0x66 if both are present.  */
> -        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16 :
MO_32);
> +        dflag =3D (REX_W(s) > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16=
 :
MO_32);
>          /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
>          aflag =3D (prefixes & PREFIX_ADR ? MO_32 : MO_64);
>      } else {
> @@ -5029,7 +5032,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>                  /* operand size for jumps is 64 bit */
>                  ot =3D MO_64;
>              } else if (op =3D=3D 3 || op =3D=3D 5) {
> -                ot =3D dflag !=3D MO_16 ? MO_32 + (rex_w =3D=3D 1) : MO_=
16;
> +                ot =3D dflag !=3D MO_16 ? MO_32 + (REX_W(s) =3D=3D 1) : =
MO_16;
>              } else if (op =3D=3D 6) {
>                  /* default push size is 64 bit */
>                  ot =3D mo_pushpop(s, dflag);
> --
> 2.20.1
>
>
