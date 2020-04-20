Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA48C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40B820722
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3siudei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40B820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWR5-0005Vq-Uc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWPx-0004Fw-Ay
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:24:57 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWPw-0008KS-8B
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:24:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35114)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQWPv-0008HG-NI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:24:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id x18so12174924wrq.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mXbSj7s2q/QByhI2UM3nBVwGjxKGwzbjTUSzQEVxZXM=;
 b=q3siudeiHJFPi9lGgx/qBCmn6oMunhKe7rAKdc0bfTzfLGTW2tA5rMmBZrzM3fkkiC
 D/DypHOhvVgG8hXl7MudRxl1ehsGvezhS0o5nIMIv74+sziybQ6KP9Xr2Fpy1nHiNx5D
 tTVlarjj3ZYOpn9EmlDNOy6K3vXE2YBqVK22+E/tVtHcNwN61MIssK9VJCQfBmyo6+cT
 7KkCVYLrTk2RGBP9zZz+zF2qiIRVXD9y32Po3it+6rRafLEFouWAJGUVlVnNoUKObXrM
 2nsOt6wlWU1c0K8oNyL7NT9Mrk148d8NghnscTSoCiT7B1LcIw/5AOTj/or+l3ho9Qnb
 849A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mXbSj7s2q/QByhI2UM3nBVwGjxKGwzbjTUSzQEVxZXM=;
 b=ZGqv1BbUHxN7ZIn4qjB1wMcEuhvrmbqZ9Z5zH87J2/voGVurX0d/B6NbOewQjn2Jiz
 BjvYPqWBOajAtS3NPWiEZfz8AMNmcY1oZtbyzjJKBPb649gpowU6v3W1+IQxlPunXZnm
 8fYgpv9/Du6yqWRzb0CrZmWonEBcFIAm+ra7YWwQVtVQWNOHun8NE5bKfnw/tSfDPyDi
 iDAHqKs7TETAsGo04nybuswV+N8Kx6T8Bb3vHci3v9WwyOpXYPpVBPwXDDsHDhkDWY8C
 71HcGEhi76SdWdsd/BSmC/8KAnxhaRG/RPTr1CJo+BX76hMGILsJUOkObb501E14hCe8
 MdjA==
X-Gm-Message-State: AGi0PuZzm+yuhdJTOzlKcZMAUCpfiIXcPyWnxNztuk1zV5UW6xzov5hX
 Mu81ewBARLQnwo1gCyOd3BCtng==
X-Google-Smtp-Source: APiQypIfEcQ1wdDYUtTAKMJ0zoujJ9mfBs0yL+UJWrsAnUlSJZApD9hwham+JeU6mI7okdwVR6FEgw==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr18340957wrv.75.1587389094256; 
 Mon, 20 Apr 2020 06:24:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm1403995wmi.27.2020.04.20.06.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 06:24:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C0CA1FF7E;
 Mon, 20 Apr 2020 14:24:52 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-5-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/7] target/arm: Use tcg_gen_gvec_dup_imm
In-reply-to: <20200418150411.1831-5-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 14:24:52 +0100
Message-ID: <87zhb6e1cr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 david@gibson.dropbear.id.au, zhiwei_liu@c-sky.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> In a few cases, we're able to remove some manual replication.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 10 +++++-----
>  target/arm/translate-sve.c | 12 +++++-------
>  target/arm/translate.c     |  9 ++++++---
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 7580e46367..095638e09a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -519,7 +519,7 @@ static void clear_vec_high(DisasContext *s, bool is_q=
, int rd)
>          tcg_temp_free_i64(tcg_zero);
>      }
>      if (vsz > 16) {
> -        tcg_gen_gvec_dup8i(ofs + 16, vsz - 16, vsz - 16, 0);
> +        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
>      }
>  }
>=20=20
> @@ -7794,8 +7794,8 @@ static void disas_simd_mod_imm(DisasContext *s, uin=
t32_t insn)
>=20=20
>      if (!((cmode & 0x9) =3D=3D 0x1 || (cmode & 0xd) =3D=3D 0x9)) {
>          /* MOVI or MVNI, with MVNI negation handled above.  */
> -        tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
> -                            vec_full_reg_size(s), imm);
> +        tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), is_q ? 1=
6 : 8,
> +                             vec_full_reg_size(s), imm);
>      } else {
>          /* ORR or BIC, with BIC negation to AND handled above.  */
>          if (is_neg) {
> @@ -10223,8 +10223,8 @@ static void handle_vec_simd_shri(DisasContext *s,=
 bool is_q, bool is_u,
>          if (is_u) {
>              if (shift =3D=3D 8 << size) {
>                  /* Shift count the same size as element size produces ze=
ro.  */
> -                tcg_gen_gvec_dup8i(vec_full_reg_offset(s, rd),
> -                                   is_q ? 16 : 8, vec_full_reg_size(s), =
0);
> +                tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
> +                                     is_q ? 16 : 8, vec_full_reg_size(s)=
, 0);
>              } else {
>                  gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri,=
 size);
>              }
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index b35bad245e..6c8bda4e4c 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -177,7 +177,7 @@ static bool do_mov_z(DisasContext *s, int rd, int rn)
>  static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
>  {
>      unsigned vsz =3D vec_full_reg_size(s);
> -    tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), vsz, vsz, word);
> +    tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), vsz, vsz, wo=
rd);
>  }
>=20=20
>  /* Invoke a vector expander on two Pregs.  */
> @@ -1453,7 +1453,7 @@ static bool do_predset(DisasContext *s, int esz, in=
t rd, int pat, bool setflag)
>          unsigned oprsz =3D size_for_gvec(setsz / 8);
>=20=20
>          if (oprsz * 8 =3D=3D setsz) {
> -            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
> +            tcg_gen_gvec_dup_imm(MO_64, ofs, oprsz, maxsz, word);
>              goto done;
>          }
>      }
> @@ -2044,7 +2044,7 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x =
*a)
>              unsigned nofs =3D vec_reg_offset(s, a->rn, index, esz);
>              tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
>          } else {
> -            tcg_gen_gvec_dup64i(dofs, vsz, vsz, 0);
> +            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
>          }
>      }
>      return true;
> @@ -3260,9 +3260,7 @@ static bool trans_FDUP(DisasContext *s, arg_FDUP *a)
>=20=20
>          /* Decode the VFP immediate.  */
>          imm =3D vfp_expand_imm(a->esz, a->imm);
> -        imm =3D dup_const(a->esz, imm);
> -
> -        tcg_gen_gvec_dup64i(dofs, vsz, vsz, imm);
> +        tcg_gen_gvec_dup_imm(a->esz, dofs, vsz, vsz, imm);
>      }
>      return true;
>  }
> @@ -3276,7 +3274,7 @@ static bool trans_DUP_i(DisasContext *s, arg_DUP_i =
*a)
>          unsigned vsz =3D vec_full_reg_size(s);
>          int dofs =3D vec_full_reg_offset(s, a->rd);
>=20=20
> -        tcg_gen_gvec_dup64i(dofs, vsz, vsz, dup_const(a->esz, a->imm));
> +        tcg_gen_gvec_dup_imm(a->esz, dofs, vsz, vsz, a->imm);
>      }
>      return true;
>  }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 9f9f4e19e0..af4d3ff4c9 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5386,7 +5386,8 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                                            MIN(shift, (8 << size) - 1),
>                                            vec_size, vec_size);
>                      } else if (shift >=3D 8 << size) {
> -                        tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0=
);
> +                        tcg_gen_gvec_dup_imm(MO_8, rd_ofs, vec_size,
> +                                             vec_size, 0);
>                      } else {
>                          tcg_gen_gvec_shri(size, rd_ofs, rm_ofs, shift,
>                                            vec_size, vec_size);
> @@ -5437,7 +5438,8 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                           * architecturally valid and results in zero.
>                           */
>                          if (shift >=3D 8 << size) {
> -                            tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_siz=
e, 0);
> +                            tcg_gen_gvec_dup_imm(size, rd_ofs,
> +                                                 vec_size, vec_size, 0);
>                          } else {
>                              tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shif=
t,
>                                                vec_size, vec_size);
> @@ -5783,7 +5785,8 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                      }
>                      tcg_temp_free_i64(t64);
>                  } else {
> -                    tcg_gen_gvec_dup32i(reg_ofs, vec_size, vec_size, imm=
);
> +                    tcg_gen_gvec_dup_imm(MO_32, reg_ofs, vec_size,
> +                                         vec_size, imm);
>                  }
>              }
>          }


--=20
Alex Benn=C3=A9e

