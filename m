Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA268C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8204D2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCwKLy5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8204D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYJ0-0007nn-Oa
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRYIJ-0007Nu-Fj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRYII-0006zN-Hn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:37:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRYII-0006yM-4R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:37:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id j1so6030951wrt.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2PpVUBsKJvJ7y6MktUChaPGxy0tRV4EddJAO+136xfA=;
 b=sCwKLy5Wj+eYTp1pFTbuzUOUbl0BDWPCxfwv9MX+BS+Gb8YmKVg4oZC0yO5o2+0tL/
 eLB1yYE5SDJLgU8m58wCxXmIKrKo/sBpo38KgQ2/of6kEczkkGZ+2lbg4QqjdqhJSjGN
 9xsm9FdNU2O/3O5fMjQ5gbiKRKjx5X+YaKgOLE0eLk+e56w1Cac7g8tW7vc8NsMDoiqR
 mAHIKYH4Saxi/xPwloSz4xJaqkrBqQAlBbhRi79aQ1XF2ANB5YtonX9Hnz9ipTFTrvdJ
 sBQs8z3gCHMQZPKGiGglvKCTq04CwpNXetLbsz+IgHWHhUu1gRXFsceNHswEne/gDkHC
 i1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2PpVUBsKJvJ7y6MktUChaPGxy0tRV4EddJAO+136xfA=;
 b=RybZIxnBHbf8Ef6n0Vc8z/iKmj/eLaYlsFepZ62fQgs/slj4YMn/OLVDuWqrCsUmFG
 QSFY3f44GtY/WUyf7WkyJlL+ge1StX/uXa/P5nkXPNVQa4fu/lOl73m/ueWDbzUqtOTr
 3OPtFdat2bQ1zKeYgTzjzUwG2wUIan01O7Y+yAVRWOLFG+qCJT7wyfL1haE9GPvGpf4w
 5H1hbNZQCHZdme8DkRE9VW2dr3wq7Unkqgzlx1MuE5zHF2C8cYSkstOKfai8v3F9kwjv
 vtHyk7HShjyQSMtmVfJp6kWIvbWueQmJRkf9/0YsIkYUvPFjRpYlINM7pLavR7jQsY1v
 gXVQ==
X-Gm-Message-State: AGi0PuYydfEzRW9RFdgmQ/llUK+E+flUiUWhM3NI2ht0WEFRDNKSm/iL
 E0J0XTLxQEZ7z1E7c9qcMVF4WA==
X-Google-Smtp-Source: APiQypJ2sueBM/SwEHCSkLdktK0WYu6EnAg3enfnUszImNjQIHBSzueUhSai0/U5b1PFyZqO63q7bw==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr3877921wrr.253.1587634635572; 
 Thu, 23 Apr 2020 02:37:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm2736080wrv.95.2020.04.23.02.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 02:37:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACB5D1FF7E;
 Thu, 23 Apr 2020 10:37:13 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-27-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 26/36] tcg: Add load_dest parameter to GVecGen2
In-reply-to: <20200422011722.13287-27-richard.henderson@linaro.org>
Date: Thu, 23 Apr 2020 10:37:13 +0100
Message-ID: <87a732bl12.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We have this same parameter for GVecGen2i, GVecGen3,
> and GVecGen3i.  This will make some SVE2 insns easier
> to parameterize.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op-gvec.h |  2 ++
>  tcg/tcg-op-gvec.c         | 45 ++++++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index d89f91f40e..cea6497341 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -109,6 +109,8 @@ typedef struct {
>      uint8_t vece;
>      /* Prefer i64 to v64.  */
>      bool prefer_i64;
> +    /* Load dest as a 2nd source operand.  */
> +    bool load_dest;
>  } GVecGen2;
>=20=20
>  typedef struct {
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 43cac1a0bf..049a55e700 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -663,17 +663,22 @@ static void expand_clr(uint32_t dofs, uint32_t maxs=
z)
>=20=20
>  /* Expand OPSZ bytes worth of two-operand operations using i32 elements.=
  */
>  static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
> -                         void (*fni)(TCGv_i32, TCGv_i32))
> +                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))
>  {
>      TCGv_i32 t0 =3D tcg_temp_new_i32();
> +    TCGv_i32 t1 =3D tcg_temp_new_i32();
>      uint32_t i;
>=20=20
>      for (i =3D 0; i < oprsz; i +=3D 4) {
>          tcg_gen_ld_i32(t0, cpu_env, aofs + i);
> -        fni(t0, t0);
> -        tcg_gen_st_i32(t0, cpu_env, dofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
> +        }
> +        fni(t1, t0);
> +        tcg_gen_st_i32(t1, cpu_env, dofs + i);
>      }
>      tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(t1);
>  }
>=20=20
>  static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
> @@ -793,17 +798,22 @@ static void expand_4_i32(uint32_t dofs, uint32_t ao=
fs, uint32_t bofs,
>=20=20
>  /* Expand OPSZ bytes worth of two-operand operations using i64 elements.=
  */
>  static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
> -                         void (*fni)(TCGv_i64, TCGv_i64))
> +                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))
>  {
>      TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
>      uint32_t i;
>=20=20
>      for (i =3D 0; i < oprsz; i +=3D 8) {
>          tcg_gen_ld_i64(t0, cpu_env, aofs + i);
> -        fni(t0, t0);
> -        tcg_gen_st_i64(t0, cpu_env, dofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
> +        }
> +        fni(t1, t0);
> +        tcg_gen_st_i64(t1, cpu_env, dofs + i);
>      }
>      tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
>=20=20
>  static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
> @@ -924,17 +934,23 @@ static void expand_4_i64(uint32_t dofs, uint32_t ao=
fs, uint32_t bofs,
>  /* Expand OPSZ bytes worth of two-operand operations using host vectors.=
  */
>  static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
>                           uint32_t oprsz, uint32_t tysz, TCGType type,
> +                         bool load_dest,
>                           void (*fni)(unsigned, TCGv_vec, TCGv_vec))
>  {
>      TCGv_vec t0 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t1 =3D tcg_temp_new_vec(type);
>      uint32_t i;
>=20=20
>      for (i =3D 0; i < oprsz; i +=3D tysz) {
>          tcg_gen_ld_vec(t0, cpu_env, aofs + i);
> -        fni(vece, t0, t0);
> -        tcg_gen_st_vec(t0, cpu_env, dofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
> +        }
> +        fni(vece, t1, t0);
> +        tcg_gen_st_vec(t1, cpu_env, dofs + i);
>      }
>      tcg_temp_free_vec(t0);
> +    tcg_temp_free_vec(t1);
>  }
>=20=20
>  /* Expand OPSZ bytes worth of two-vector operands and an immediate opera=
nd
> @@ -1088,7 +1104,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>           * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
>           */
>          some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> -        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fn=
iv);
> +        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
> +                     g->load_dest, g->fniv);
>          if (some =3D=3D oprsz) {
>              break;
>          }
> @@ -1098,17 +1115,19 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>          maxsz -=3D some;
>          /* fallthru */
>      case TCG_TYPE_V128:
> -        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->f=
niv);
> +        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
> +                     g->load_dest, g->fniv);
>          break;
>      case TCG_TYPE_V64:
> -        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fni=
v);
> +        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
> +                     g->load_dest, g->fniv);
>          break;
>=20=20
>      case 0:
>          if (g->fni8 && check_size_impl(oprsz, 8)) {
> -            expand_2_i64(dofs, aofs, oprsz, g->fni8);
> +            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);
>          } else if (g->fni4 && check_size_impl(oprsz, 4)) {
> -            expand_2_i32(dofs, aofs, oprsz, g->fni4);
> +            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);
>          } else {
>              assert(g->fno !=3D NULL);
>              tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno=
);


--=20
Alex Benn=C3=A9e

