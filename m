Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C3CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2CA20663
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNGJfU4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2CA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSW9-000615-SY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iLSUi-0004ZQ-2W
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iLSUg-0001LX-J7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:40:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iLSUf-0001Kq-BP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:40:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id w18so5769473wrt.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=53TtsGG7IhXjDLWo3cikgXeBDnqObvWgWLlY5tbLp9Q=;
 b=LNGJfU4BDnAPp+NYQ29p4MxyiRdkDZQQFpbqb9kNFqqha79YeoX4FPVbZJvwTMS6tF
 z9Cn9r4A7iIhsIWuc5HQ3J6Ji8jHlqQYRfabEUtRkmaL4iDkNr8eYdRZx4WU1VGpClaN
 QkZcYHOSDaoBf4fEC7vYkr7uyMtMC7fgtB5osg7iiZENxbJHoVJarHhe7FfRrrJfsW5N
 KIdJSIodkcYcmQnCYFuQ3OSlPsoBnj+GNwf85Crk3tSHukyU2O1KwdOQwsGmxdMZVbIP
 IU/uT1V0o2jH+sZ33+djSHwa0VeGpvIH5xDYwVNqgVRMjRYOYnHKUwmHX4hR6kBrV40Y
 f+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=53TtsGG7IhXjDLWo3cikgXeBDnqObvWgWLlY5tbLp9Q=;
 b=qT7dIs+55vRc6OL82+WxKMx2ollf6eQwKIHkNwlBwQzQiHHR7cwZBosmbCQaBuCPCS
 V7xtS385KNOKEjSsXhx+jvn1piQJbJGEFct/z8FK3/ZXKwAr3s9AfiIfcaDHEjVfWgP2
 8njnMzxM3KJQX2jLnX5YDlEws2Wf8skXb8soydIrXK7ldUmOkIZLAUOzMbXYhVP+bpLw
 ryEW+a5ysbF4sweMGdHyACP+ll637lD5UAOlaO9VH8CPVRfj2pbMyPUMf4ZnkLQ1m8PX
 s9DKUXNSZrGycCkMd76G+PYLSm7qEH3RtvXEV/Cw5VHjcIQzmZRxx9kHBVNGu8kUmEZL
 wwJA==
X-Gm-Message-State: APjAAAVhk5xopJwDOYu13VRDoWgL1s7S2g9wuy6HpwNY313iWMFTU7JO
 O4qVeqjq8A9CKOUP0YvHzMYIMw==
X-Google-Smtp-Source: APXvYqz3nAf0+RmyprKS1AZ47oBOtb9IVT+CWxuj/h+amZ1XadpKh7W3FFnkzNpGjaw+q1sW0wv3ZA==
X-Received: by 2002:adf:f192:: with SMTP id h18mr8444084wro.148.1571406035963; 
 Fri, 18 Oct 2019 06:40:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm6438163wmg.2.2019.10.18.06.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 06:40:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 869D21FF87;
 Fri, 18 Oct 2019 14:40:34 +0100 (BST)
References: <20191017044232.27601-1-richard.henderson@linaro.org>
 <20191017044232.27601-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] target/arm: Convert PMUL.8 to gvec
In-reply-to: <20191017044232.27601-3-richard.henderson@linaro.org>
Date: Fri, 18 Oct 2019 14:40:34 +0100
Message-ID: <87y2xinpd9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The gvec form will be needed for implementing SVE2.
>
> Extend the implementation to operate on uint64_t instead of uint32_t.
> Use a counted inner loop instead of terminating when op1 goes to zero,
> looking toward the required implementation for ARMv8.4-DIT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.h        |  3 ++-
>  target/arm/neon_helper.c   | 22 ----------------------
>  target/arm/translate-a64.c | 10 +++-------
>  target/arm/translate.c     | 11 ++++-------
>  target/arm/vec_helper.c    | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 39 insertions(+), 37 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index fc0d594a14..800446e537 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -335,7 +335,6 @@ DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
>  DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
>  DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
>  DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
> -DEF_HELPER_2(neon_mul_p8, i32, i32, i32)
>  DEF_HELPER_2(neon_mull_p8, i64, i32, i32)
>
>  DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
> @@ -689,6 +688,8 @@ DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void=
, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
>  DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
>
> +DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
>  #include "helper-sve.h"
> diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
> index c581ffb7d3..9e7a9a1ac5 100644
> --- a/target/arm/neon_helper.c
> +++ b/target/arm/neon_helper.c
> @@ -1131,28 +1131,6 @@ NEON_VOP(mul_u16, neon_u16, 2)
>
>  /* Polynomial multiplication is like integer multiplication except the
>     partial products are XORed, not added.  */
> -uint32_t HELPER(neon_mul_p8)(uint32_t op1, uint32_t op2)
> -{
> -    uint32_t mask;
> -    uint32_t result;
> -    result =3D 0;
> -    while (op1) {
> -        mask =3D 0;
> -        if (op1 & 1)
> -            mask |=3D 0xff;
> -        if (op1 & (1 << 8))
> -            mask |=3D (0xff << 8);
> -        if (op1 & (1 << 16))
> -            mask |=3D (0xff << 16);
> -        if (op1 & (1 << 24))
> -            mask |=3D (0xff << 24);
> -        result ^=3D op2 & mask;
> -        op1 =3D (op1 >> 1) & 0x7f7f7f7f;
> -        op2 =3D (op2 << 1) & 0xfefefefe;
> -    }
> -    return result;
> -}
> -
>  uint64_t HELPER(neon_mull_p8)(uint32_t op1, uint32_t op2)
>  {
>      uint64_t result =3D 0;
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 255a168df6..04e25cfe06 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11110,9 +11110,10 @@ static void disas_simd_3same_int(DisasContext *s=
, uint32_t insn)
>      case 0x13: /* MUL, PMUL */
>          if (!u) { /* MUL */
>              gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
> -            return;
> +        } else {  /* PMUL */
> +            gen_gvec_op3_ool(s, is_q, rd, rn, rm, 0, gen_helper_gvec_pmu=
l_b);
>          }
> -        break;
> +        return;
>      case 0x12: /* MLA, MLS */
>          if (u) {
>              gen_gvec_op3(s, is_q, rd, rn, rm, &mls_op[size]);
> @@ -11242,11 +11243,6 @@ static void disas_simd_3same_int(DisasContext *s=
, uint32_t insn)
>                  genfn =3D fns[size][u];
>                  break;
>              }
> -            case 0x13: /* MUL, PMUL */
> -                assert(u); /* PMUL */
> -                assert(size =3D=3D 0);
> -                genfn =3D gen_helper_neon_mul_p8;
> -                break;
>              case 0x16: /* SQDMULH, SQRDMULH */
>              {
>                  static NeonGenTwoOpEnvFn * const fns[2][2] =3D {
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 598bb1cc00..b66a2f6b71 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5014,16 +5014,17 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>
>          case NEON_3R_VMUL: /* VMUL */
>              if (u) {
> -                /* Polynomial case allows only P8 and is handled below. =
 */
> +                /* Polynomial case allows only P8.  */
>                  if (size !=3D 0) {
>                      return 1;
>                  }
> +                tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, vec_size, vec=
_size,
> +                                   0, gen_helper_gvec_pmul_b);
>              } else {
>                  tcg_gen_gvec_mul(size, rd_ofs, rn_ofs, rm_ofs,
>                                   vec_size, vec_size);
> -                return 0;
>              }
> -            break;
> +            return 0;
>
>          case NEON_3R_VML: /* VMLA, VMLS */
>              tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
> @@ -5213,10 +5214,6 @@ static int disas_neon_data_insn(DisasContext *s, u=
int32_t insn)
>              tmp2 =3D neon_load_reg(rd, pass);
>              gen_neon_add(size, tmp, tmp2);
>              break;
> -        case NEON_3R_VMUL:
> -            /* VMUL.P8; other cases already eliminated.  */
> -            gen_helper_neon_mul_p8(tmp, tmp, tmp2);
> -            break;
>          case NEON_3R_VPMAX:
>              GEN_NEON_INTEGER_OP(pmax);
>              break;
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index fcb3663903..d401282c6f 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -1134,3 +1134,33 @@ void HELPER(gvec_ushl_h)(void *vd, void *vn, void =
*vm, uint32_t desc)
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> +
> +/*
> + * 8x8->8 polynomial multiply.
> + *
> + * Polynomial multiplication is like integer multiplication except the
> + * partial products are XORed, not added.
> + *
> + * TODO: expose this as a generic vector operation, as it is a common
> + * crypto building block.
> + */
> +void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, j, opr_sz =3D simd_oprsz(desc);
> +    uint64_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz / 8; ++i) {
> +        uint64_t nn =3D n[i];
> +        uint64_t mm =3D m[i];
> +        uint64_t rr =3D 0;
> +
> +        for (j =3D 0; j < 8; ++j) {
> +            uint64_t mask =3D (nn & 0x0101010101010101ull) * 0xff;
> +            rr ^=3D mm & mask;
> +            mm =3D (mm << 1) & 0xfefefefefefefefeull;
> +            nn =3D (nn >> 1) & 0x7f7f7f7f7f7f7f7full;
> +        }
> +        d[i] =3D rr;
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}


--
Alex Benn=C3=A9e

