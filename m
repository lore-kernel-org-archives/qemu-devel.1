Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B111C38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C0A205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juC8Psjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C0A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTM3-0007Gu-GG
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQTK2-0005Rd-TR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:06:39 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQTK0-0001ph-QT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:06:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46714)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQTK0-0001oK-D4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:06:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id f13so11335333wrm.13
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qLkuo+yG9LGH78ikgI3A72oNvkE3ZZdqCjMu9DZmzc8=;
 b=juC8PsjmjmJiVOEwnhTdd8d+JQWQ77K8x2sADqRePLX6ThjYd2IFY2QC/Pyk50zslX
 yQfO38Ld3tQ/Zy5er739Qi9NWH0pRrfFeBLnciDgG8X+QMvi4wi7gEtj3BxNFPuRD223
 2Tg1qrwHfeoeg4QTSIhzedlmCt8fxFlOnyeTUDJYpRGvE64N7EbM+MoL9v2KJlg3CXK2
 rwiRwh/9cP5BmfK3lGiw3dUop9qbbX1FpEC951GX+MXl7cXg6x7ugkO2yrhfFkkWFRxA
 tczFSDILZ7ZjdzELig+Sxw/aLIq5uDgyw+zDba3BC3uIC0cJY+w3gPaDZIDHA1t6gN7x
 Yy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qLkuo+yG9LGH78ikgI3A72oNvkE3ZZdqCjMu9DZmzc8=;
 b=BzFgPR8Nz9N/T+JE89iQtpU0nbn+ba0eEU4S9y6pzp44aMOmClXwY8BVFF7VOdkkIM
 OCqkeO70qnLCE+Lrp5B8LmJxlVquTPWtzdOfaTYst2kSOrt4TfdPgbMC45ETuv+2LfNL
 tf3CW6z7CLWsVqgaGjGSC7/jE+IVwUQGL382hOKLzzoFg69I/Vwn1/9PxwyYMzwncXpH
 /n6raK+5hjhBZgI76MJkjC+9yIszWTpU0gGMlsGK1LANRcFmRZ/+kL6+wZUNeXZIqpAO
 oC5GfTPI3lHdliHW8wftipgXrmfXS9c8UTdvrK/oKSwmJNGcPrOn2tL759nP76gX9IBR
 /zAw==
X-Gm-Message-State: AGi0PuaxE0Wrgz9obphQipwzohlqal5Nq/cO0JfF+ykA+4xdk1EZlClF
 Cm53jbA9sKue66mZwzO1+ZJeKQ==
X-Google-Smtp-Source: APiQypIUFtKwKAaPZrxUTb7oxMQax5V6YckFwia3mvdGzc7p+4QN4zpmic2l6JB+X+kFvdovRcWdpw==
X-Received: by 2002:a05:6000:108e:: with SMTP id
 y14mr19340957wrw.292.1587377193535; 
 Mon, 20 Apr 2020 03:06:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v10sm555555wrq.45.2020.04.20.03.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 03:06:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 97C0B1FF7E;
 Mon, 20 Apr 2020 11:06:31 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-3-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/7] target/s390x: Use tcg_gen_gvec_dup_imm
In-reply-to: <20200418150411.1831-3-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 11:06:31 +0100
Message-ID: <875zdufp3s.fsf@linaro.org>
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

> The gen_gvec_dupi switch is unnecessarily with the new function.
> Replace it with a local gen_gvec_dup_imm that takes care of the
> register to offset conversion and length arguments.
>
> Drop zero_vec and use use gen_gvec_dup_imm with 0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/s390x/translate_vx.inc.c | 41 +++++++--------------------------
>  1 file changed, 8 insertions(+), 33 deletions(-)
>
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
> index 24558cce80..12347f8a03 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -231,8 +231,8 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
>  #define gen_gvec_mov(v1, v2) \
>      tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2)=
, 16, \
>                       16)
> -#define gen_gvec_dup64i(v1, c) \
> -    tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
> +#define gen_gvec_dup_imm(es, v1, c) \
> +    tcg_gen_gvec_dup_imm(es, vec_full_reg_offset(v1), 16, 16, c);
>  #define gen_gvec_fn_2(fn, es, v1, v2) \
>      tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
>                        16, 16)
> @@ -316,31 +316,6 @@ static void gen_gvec128_4_i64(gen_gvec128_4_i64_fn f=
n, uint8_t d, uint8_t a,
>          tcg_temp_free_i64(cl);
>  }
>=20=20
> -static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
> -{
> -    switch (es) {
> -    case ES_8:
> -        tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, c);
> -        break;
> -    case ES_16:
> -        tcg_gen_gvec_dup16i(vec_full_reg_offset(reg), 16, 16, c);
> -        break;
> -    case ES_32:
> -        tcg_gen_gvec_dup32i(vec_full_reg_offset(reg), 16, 16, c);
> -        break;
> -    case ES_64:
> -        gen_gvec_dup64i(reg, c);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
> -static void zero_vec(uint8_t reg)
> -{
> -    tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, 0);
> -}
> -
>  static void gen_addi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i6=
4 ah,
>                            uint64_t b)
>  {
> @@ -396,8 +371,8 @@ static DisasJumpType op_vgbm(DisasContext *s, DisasOp=
s *o)
>           * Masks for both 64 bit elements of the vector are the same.
>           * Trust tcg to produce a good constant loading.
>           */
> -        gen_gvec_dup64i(get_field(s, v1),
> -                        generate_byte_mask(i2 & 0xff));
> +        gen_gvec_dup_imm(ES_64, get_field(s, v1),
> +                         generate_byte_mask(i2 & 0xff));
>      } else {
>          TCGv_i64 t =3D tcg_temp_new_i64();
>=20=20
> @@ -432,7 +407,7 @@ static DisasJumpType op_vgm(DisasContext *s, DisasOps=
 *o)
>          }
>      }
>=20=20
> -    gen_gvec_dupi(es, get_field(s, v1), mask);
> +    gen_gvec_dup_imm(es, get_field(s, v1), mask);
>      return DISAS_NEXT;
>  }
>=20=20
> @@ -585,7 +560,7 @@ static DisasJumpType op_vllez(DisasContext *s, DisasO=
ps *o)
>=20=20
>      t =3D tcg_temp_new_i64();
>      tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
> -    zero_vec(get_field(s, v1));
> +    gen_gvec_dup_imm(es, get_field(s, v1), 0);
>      write_vec_element_i64(t, get_field(s, v1), enr, es);
>      tcg_temp_free_i64(t);
>      return DISAS_NEXT;
> @@ -892,7 +867,7 @@ static DisasJumpType op_vrepi(DisasContext *s, DisasO=
ps *o)
>          return DISAS_NORETURN;
>      }
>=20=20
> -    gen_gvec_dupi(es, get_field(s, v1), data);
> +    gen_gvec_dup_imm(es, get_field(s, v1), data);
>      return DISAS_NEXT;
>  }
>=20=20
> @@ -1372,7 +1347,7 @@ static DisasJumpType op_vcksm(DisasContext *s, Disa=
sOps *o)
>          read_vec_element_i32(tmp, get_field(s, v2), i, ES_32);
>          tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);
>      }
> -    zero_vec(get_field(s, v1));
> +    gen_gvec_dup_imm(ES_32, get_field(s, v1), 0);
>      write_vec_element_i32(sum, get_field(s, v1), 1, ES_32);
>=20=20
>      tcg_temp_free_i32(tmp);


--=20
Alex Benn=C3=A9e

