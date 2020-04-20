Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49094C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0242078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9QWbiDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0242078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTm5-0002EQ-7u
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56610 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQTl5-0001EM-E5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:34:48 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQTkv-0000Ns-Du
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:34:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45155)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQTku-0000M3-TD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:34:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id t14so11420082wrw.12
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qODjT8LGS2xf0CckhwOI1H0DuXfWEICr2g7ZD0uov14=;
 b=Y9QWbiDREPNoq+ChAXR3O7FguxO3TCokhyCGezNdkIIWqVR7IKMfkMvwQcAGcDpMuT
 W+pKgAVkAVR3sfBH+g9KNXfod41SPqU1lS4WptkuXvgiFjD+Nt1dxmRYnBvLrPR7fUnL
 VjfBH7d+HyWARuX4csNLLdjL26HsBvyefQZInkaPGCHdc6Kwj9goTs6oai8dYtPZXEAs
 mMzU1mntX3jLjdPqKsmzKShSRPKdMaLJgVtXiDuY4ULcp/b7hgbsnLwX+mB0HqefJO+j
 K01Hds0q051lDs0I57gAcbZ0vpW++pY33sFGBumGBO/UWfqUtTjZs+yAqFYCvR0RZAGk
 IMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qODjT8LGS2xf0CckhwOI1H0DuXfWEICr2g7ZD0uov14=;
 b=GZUtAiKWoHyj58LNZQ0t4vV63ScGaUS1dEUuZv6fuSZL++1aWfqU9tUHRFCdiZYt/Z
 jLbNQs2Mel7AnlbWmElbkGKnSFm7t8nlqp2YJefPoDXCv+cFYiPSPzVVXM0RFMifOoDp
 q4v9yESSvnBrrnroufN9TYHiOtAUm1McQB8pGvx1EbD6bGa1aL8iRBsdqBZ3K4BbhpDs
 nyKsJ9kYVwX05k2KGh4kB3w2OP5fw6iy6UaFbZ5W0yDUcbrRt9sSiaN69d4naNcL9tzj
 W+3RdHmVgzwqHo/XaCBZy5xdxAUWgraoKrAsp26PLnpiFRY8CKDbd/pBimu4eO1yq3W5
 iCSg==
X-Gm-Message-State: AGi0PuYQ25fhw35sG10+2KfuSoGBAjeR6ilNJOjf0BS1A47as7Vdixpm
 KvgxZeN+qCtTcyMyQEYKb2dNlQ==
X-Google-Smtp-Source: APiQypKgemvGROc+mSkW6U3K9CinQuaKobipnJtidYA5NDFJEkctdH8BxwaNt3likgEcjVTKwDezbQ==
X-Received: by 2002:adf:afc6:: with SMTP id y6mr17368290wrd.74.1587378862875; 
 Mon, 20 Apr 2020 03:34:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f7sm644383wrt.10.2020.04.20.03.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 03:34:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F37D1FF7E;
 Mon, 20 Apr 2020 11:34:20 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-4-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/7] target/ppc: Use tcg_gen_gvec_dup_imm
In-reply-to: <20200418150411.1831-4-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 11:34:20 +0100
Message-ID: <87368yfntf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 david@gibson.dropbear.id.au, zhiwei_liu@c-sky.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We can now unify the implementation of the 3 VSPLTI instructions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++++++-------------
>  target/ppc/translate/vsx-impl.inc.c |  2 +-
>  2 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 81d5a7a341..403ed3a01c 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -1035,21 +1035,25 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
>  GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
>                   vcmpgtud, PPC_NONE, PPC2_ALTIVEC_207)
>=20=20
> -#define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
> -static void glue(gen_, name)(DisasContext *ctx)                         \
> -    {                                                                   \
> -        int simm;                                                       \
> -        if (unlikely(!ctx->altivec_enabled)) {                          \
> -            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
> -            return;                                                     \
> -        }                                                               \
> -        simm =3D SIMM5(ctx->opcode);                                    =
  \
> -        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         \
> +static void gen_vsplti(DisasContext *ctx, int vece)
> +{
> +    int simm;
> +
> +    if (unlikely(!ctx->altivec_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_VPU);
> +        return;
>      }
>=20=20
> -GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
> -GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13);
> -GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
> +    simm =3D SIMM5(ctx->opcode);
> +    tcg_gen_gvec_dup_imm(vece, avr_full_offset(rD(ctx->opcode)), 16, 16,=
 simm);
> +}
> +
> +#define GEN_VXFORM_VSPLTI(name, vece, opc2, opc3) \
> +static void glue(gen_, name)(DisasContext *ctx) { gen_vsplti(ctx, vece);=
 }
> +
> +GEN_VXFORM_VSPLTI(vspltisb, MO_8, 6, 12);
> +GEN_VXFORM_VSPLTI(vspltish, MO_16, 6, 13);
> +GEN_VXFORM_VSPLTI(vspltisw, MO_32, 6, 14);

There are unused parameters opc2/opc3 parameters here. Given that is it
really worth the glue obfuscation:

  static void gen_vspltisb(DisasContext *ctx)
  {
      gen_vsplti(ctx, MO_8);
  }

  static void gen_vspltish(DisasContext *ctx)
  {
      gen_vsplti(ctx, MO_8);
  }

  static void gen_vspltisw(DisasContext *ctx)
  {
      gen_vsplti(ctx, MO_8);
  }

Of course I tried grepping for their use and couldn't find them until I
realised the call to them was hidden inside another glue operation.

With the removed extra unused macro params:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>=20=20
>  #define GEN_VXFORM_NOA(name, opc2, opc3)                                \
>  static void glue(gen_, name)(DisasContext *ctx)                         \
> @@ -1559,7 +1563,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
>  #undef GEN_VXRFORM_DUAL
>  #undef GEN_VXRFORM1
>  #undef GEN_VXRFORM
> -#undef GEN_VXFORM_DUPI
> +#undef GEN_VXFORM_VSPLTI
>  #undef GEN_VXFORM_NOA
>  #undef GEN_VXFORM_UIMM
>  #undef GEN_VAFORM_PAIRED
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 8287e272f5..b518de46db 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1579,7 +1579,7 @@ static void gen_xxspltib(DisasContext *ctx)
>              return;
>          }
>      }
> -    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
> +    tcg_gen_gvec_dup_imm(MO_8, vsr_full_offset(rt), 16, 16, uim8);
>  }
>=20=20
>  static void gen_xxsldwi(DisasContext *ctx)


--=20
Alex Benn=C3=A9e

