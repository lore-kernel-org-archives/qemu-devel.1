Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9CC54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEC7208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVb6Ve9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQT1j-00036R-MM
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47542 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQT0s-0002Xs-PW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:46:51 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQT0r-0003Vr-QN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:46:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33020)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQT0r-0003QT-9a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:46:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id v8so10339281wma.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qLkuo+yG9LGH78ikgI3A72oNvkE3ZZdqCjMu9DZmzc8=;
 b=ZVb6Ve9v5gSo8Q20lH+6CIPVI3NC6QeMV6DyzHUiwKjQh+XQwoxoK6+97N9rZycOQD
 a5V5cvZLenBa2QDJ+QE0SWfl8BwVhxstGNuGFkoLZrMkUA3OY6oKAlf5IDfFoS1GKvHE
 goBXFPa2lsk43+8OOrB7opbEo6jpN+oAj9dFVt3HtjRI7XGb0Li748FXa6D2V7718WBq
 PGkhE2ir235fnkGVGywJ81/mS3pEelegPErm1RZEIIOcuYx0JSHTpODZW+RLI/k81Ood
 35IVWgk1ewW90zj1CxcUs4C66WOqDM8jWmsNCtFCDl26nMUu38jqU/oxl6L1bbJkFyYe
 vbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qLkuo+yG9LGH78ikgI3A72oNvkE3ZZdqCjMu9DZmzc8=;
 b=MHZYZ/sRa86WWpusez6uJg00Gs1CrgEyaLsjlgKtYD8gdIBV9Y9YH+du/bCcISJMZT
 O0nZD9ZyycUdHEALt/MBZyt/1VUiQqNTw0M+1ahaMrOf14Rj8XMfqWvJBxhTezzQef9M
 qUplCxqwQX9R5P42Jr55URLTzDMN2ADjHclswHslLO8ORjQrXbO+EKBi5mv1TFt/3zXA
 a8+xzNutV7kAF6SFnmeJdjaSRKqHPph0wyox5tZs0pAepdpW9FSTvvQbrgifXEOA5J2R
 NHfDpRxFjV+DBN5I7ft/RI8kK2g8HZWmtnHQdTcPSb65Z6UwnQZ57xsTUa8Nw6T6cxQG
 +8jw==
X-Gm-Message-State: AGi0PuZtSuYoeYMnly9QGCd+MrkzbdGeIgo+5oDsN+X762JloRLPd10K
 Z2oA+2Q48sTYYRsdh/n5GntHIQ==
X-Google-Smtp-Source: APiQypJNyVxOaaPPe+IFU4HYo4OqGVnLyvGDpdQecWYOv52KJMSTVXiWBCzKA4cLnOJyrF4FR9UFlg==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr16858699wmi.103.1587376007013; 
 Mon, 20 Apr 2020 02:46:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e2sm426448wrv.89.2020.04.20.02.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 02:46:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C700E1FF7E;
 Mon, 20 Apr 2020 10:46:41 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-3-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/7] target/s390x: Use tcg_gen_gvec_dup_imm
In-reply-to: <20200418150411.1831-3-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 10:46:41 +0100
Message-ID: <878siqfq0u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

