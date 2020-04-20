Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BDC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B39206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1QihZer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B39206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYR9-00021L-Ih
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35058 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYPD-0000yA-3Z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:32:32 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYPC-0006tj-6R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:32:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42944)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQYPB-0006tc-KA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:32:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so12701721wrs.9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V6CkytLXtaK/zpdm6da/X9dXbFBOf6zpw63lSP2hing=;
 b=h1QihZerJUkxZ06yi9wYA91ClW29EdwYqZf3VQId7PX5mP4813CPQlME73qFShtV/n
 MeVZP04wORnWnYqOMlvwxvOOOXGKUUZ6yvfrM/mWAmqSpfaxuBF0nQjVz/gQqxKEAREK
 ZV8KD0wQnBbjKIggahXkYFaBywC7OARwJEgyHuyhXrhVPYSiCpIc2lnU61UfiTQ0dcRe
 DhrR48i27mwHjWjV7bu6b4gO4Ge9OFUUp43UQBLSQrNbob8CgE/OLfVD7lqkwAY4Jy8F
 WigtJBQgUrU+ZOwGtXvhn0HF3LoEY3/3eDrl5PJc8d4UavZJAKFeJ6sUB6dfwNKaH5fF
 zAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V6CkytLXtaK/zpdm6da/X9dXbFBOf6zpw63lSP2hing=;
 b=M3qZXiL5ZhlLxWgPJ0ffxXpgda+9EYdSCQqLaglGYV7/xzxNrvl+mSV7847Rf7Nj3c
 1lnJuVY/fvmE+qAApHIzJLCcFWbbxmCIIs1I1zaAks7PQ2WPx4YCu1Vlc5LUpU475RWv
 AA+nEcCRbMQsPTrrbaiLWmJnNefUQHCzvFIpWjHF9Wyxi0TY+xCgBzQR7kUQpCvVLtuv
 HCzF2hjq2aAOJw9q5ve0O6KmduZ6yPhr/Hv7YyELafmlo2HEXwsonbBAPfi5JuQ1Df5z
 Q8BFKAVpscNfuXS2tGbNbaBG1tRqPY5NIsHxT+n83ChWt71UesgcfPrMnu3lkZWU+5ZR
 lgtg==
X-Gm-Message-State: AGi0Puaav2kmcm9bA92j+pi/CWfvjp4rVk2+/mAurj9Cbyt3um0ibtPJ
 rytWT8o1sEVQyHQGilOCNaxxjg==
X-Google-Smtp-Source: APiQypJidgy7qfmuLmHdVe4qSh/x0W4HMCWeAUw2wDz8D27BQCc1FXSRv1UDMZhR9BIYXLBSrF3hQA==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr12791258wrn.296.1587396735924; 
 Mon, 20 Apr 2020 08:32:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 145sm1871610wma.1.2020.04.20.08.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 08:32:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 29A8B1FF7E;
 Mon, 20 Apr 2020 16:32:14 +0100 (BST)
References: <20200418155651.3901-1-richard.henderson@linaro.org>
 <20200418155651.3901-4-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/3] target/arm: Use clear_vec_high more effectively
In-reply-to: <20200418155651.3901-4-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 16:32:14 +0100
Message-ID: <87d082dvgh.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Do not explicitly store zero to the NEON high part
> when we can pass !is_q to clear_vec_high.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 59 +++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d57aa54d6a..bf82a2e115 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -948,11 +948,10 @@ static void do_fp_ld(DisasContext *s, int destidx, =
TCGv_i64 tcg_addr, int size)
>  {
>      /* This always zero-extends and writes to a full 128 bit wide vector=
 */
>      TCGv_i64 tmplo =3D tcg_temp_new_i64();
> -    TCGv_i64 tmphi;
> +    TCGv_i64 tmphi =3D NULL;
>=20=20
>      if (size < 4) {
>          MemOp memop =3D s->be_data + size;
> -        tmphi =3D tcg_const_i64(0);
>          tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);
>      } else {
>          bool be =3D s->be_data =3D=3D MO_BE;
> @@ -970,12 +969,13 @@ static void do_fp_ld(DisasContext *s, int destidx, =
TCGv_i64 tcg_addr, int size)
>      }
>=20=20
>      tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
> -    tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
> -
>      tcg_temp_free_i64(tmplo);
> -    tcg_temp_free_i64(tmphi);
>=20=20
> -    clear_vec_high(s, true, destidx);
> +    if (tmphi) {
> +        tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
> +        tcg_temp_free_i64(tmphi);
> +    }
> +    clear_vec_high(s, tmphi !=3D NULL, destidx);
>  }
>=20=20
>  /*
> @@ -6969,8 +6969,8 @@ static void disas_simd_ext(DisasContext *s, uint32_=
t insn)
>          return;
>      }
>=20=20
> -    tcg_resh =3D tcg_temp_new_i64();
>      tcg_resl =3D tcg_temp_new_i64();
> +    tcg_resh =3D NULL;
>=20=20
>      /* Vd gets bits starting at pos bits into Vm:Vn. This is
>       * either extracting 128 bits from a 128:128 concatenation, or
> @@ -6982,7 +6982,6 @@ static void disas_simd_ext(DisasContext *s, uint32_=
t insn)
>              read_vec_element(s, tcg_resh, rm, 0, MO_64);
>              do_ext64(s, tcg_resh, tcg_resl, pos);
>          }
> -        tcg_gen_movi_i64(tcg_resh, 0);
>      } else {
>          TCGv_i64 tcg_hh;
>          typedef struct {
> @@ -6997,6 +6996,7 @@ static void disas_simd_ext(DisasContext *s, uint32_=
t insn)
>              pos -=3D 64;
>          }
>=20=20
> +        tcg_resh =3D tcg_temp_new_i64();
>          read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_64);
>          elt++;
>          read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
> @@ -7012,9 +7012,12 @@ static void disas_simd_ext(DisasContext *s, uint32=
_t insn)
>=20=20
>      write_vec_element(s, tcg_resl, rd, 0, MO_64);
>      tcg_temp_free_i64(tcg_resl);
> -    write_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    tcg_temp_free_i64(tcg_resh);
> -    clear_vec_high(s, true, rd);
> +
> +    if (is_q) {
> +        write_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        tcg_temp_free_i64(tcg_resh);
> +    }
> +    clear_vec_high(s, is_q, rd);
>  }
>=20=20
>  /* TBL/TBX
> @@ -7051,17 +7054,21 @@ static void disas_simd_tb(DisasContext *s, uint32=
_t insn)
>       * the input.
>       */
>      tcg_resl =3D tcg_temp_new_i64();
> -    tcg_resh =3D tcg_temp_new_i64();
> +    tcg_resh =3D NULL;
>=20=20
>      if (is_tblx) {
>          read_vec_element(s, tcg_resl, rd, 0, MO_64);
>      } else {
>          tcg_gen_movi_i64(tcg_resl, 0);
>      }
> -    if (is_tblx && is_q) {
> -        read_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    } else {
> -        tcg_gen_movi_i64(tcg_resh, 0);
> +
> +    if (is_q) {
> +        tcg_resh =3D tcg_temp_new_i64();
> +        if (is_tblx) {
> +            read_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        } else {
> +            tcg_gen_movi_i64(tcg_resh, 0);
> +        }
>      }
>=20=20
>      tcg_idx =3D tcg_temp_new_i64();
> @@ -7081,9 +7088,12 @@ static void disas_simd_tb(DisasContext *s, uint32_=
t insn)
>=20=20
>      write_vec_element(s, tcg_resl, rd, 0, MO_64);
>      tcg_temp_free_i64(tcg_resl);
> -    write_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    tcg_temp_free_i64(tcg_resh);
> -    clear_vec_high(s, true, rd);
> +
> +    if (is_q) {
> +        write_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        tcg_temp_free_i64(tcg_resh);
> +    }
> +    clear_vec_high(s, is_q, rd);
>  }
>=20=20
>  /* ZIP/UZP/TRN
> @@ -7120,7 +7130,7 @@ static void disas_simd_zip_trn(DisasContext *s, uin=
t32_t insn)
>      }
>=20=20
>      tcg_resl =3D tcg_const_i64(0);
> -    tcg_resh =3D tcg_const_i64(0);
> +    tcg_resh =3D is_q ? tcg_const_i64(0) : NULL;
>      tcg_res =3D tcg_temp_new_i64();
>=20=20
>      for (i =3D 0; i < elements; i++) {
> @@ -7171,9 +7181,12 @@ static void disas_simd_zip_trn(DisasContext *s, ui=
nt32_t insn)
>=20=20
>      write_vec_element(s, tcg_resl, rd, 0, MO_64);
>      tcg_temp_free_i64(tcg_resl);
> -    write_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    tcg_temp_free_i64(tcg_resh);
> -    clear_vec_high(s, true, rd);
> +
> +    if (is_q) {
> +        write_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        tcg_temp_free_i64(tcg_resh);
> +    }
> +    clear_vec_high(s, is_q, rd);
>  }
>=20=20
>  /*


--=20
Alex Benn=C3=A9e

