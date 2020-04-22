Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A27CC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD3320767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXgH8Gr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD3320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLAk-0007ls-W6
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRL7r-0004xP-4t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRL7i-0007ME-O8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:33:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRL7i-0007LC-A4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:33:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id d17so3912494wrg.11
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ix46X6VsbTVB8aqlYRtYQZbTZ1IngA52yGt34Fbxx0Q=;
 b=cXgH8Gr0PkKXD4m506f/mWwMxFxvEq/b/AsSOiSFxBbbRkiLeUbFNuudu1et9vyqVu
 CB9PCoISwejbDPl5XoP21JYBSDIZVSEhxH7Zer6TQaUTPSO58+PzldTKSRVlMPVRLYVQ
 9oOetLhuNETkfcBuIupjwl4B2HYKiy2CDklnM8/Begew0KfcQR2P0NjSMQf/3ZVfQ4us
 9xOD5242oDzIR2AUtvckcM2xT4qwKN7yusLijzoYRfTx69+eMzOlKF7wUgndUxkbOKfN
 POFXDSPLbdFvHmeWugGg2kwJWPNY8woLkCvcQGCHFpV1nsfZnfYsDbMEmTYXaWHzz5fi
 MStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ix46X6VsbTVB8aqlYRtYQZbTZ1IngA52yGt34Fbxx0Q=;
 b=dp9hmPpYcCc4k1rsDViREVC+qN/zmHPYv89LHdYoHv03aa9j4kvMpm8oFy52wGoELK
 2p57KTPTL0iIqMgOLuWKfXlM9E9ss1wF7DmNyi4ZQY9qmHVfBDhGguIcOxblc7U7mPRm
 tFAYtGnUY1Va1IiLojGABySpTH9URPVnnV0JqsX5tPnIne+ICQBoRADRh0Flc2EDnpaO
 rz7SR17hAZmoV4Hu1mBrm9L22++HhPyX96eQ9NwPclxgN43ErHV8zkhewDgnFvj0rbiT
 2UVdqMo0erfftnZe4As1+hrChzNqIeCAlvbFi48bI0ZcdgFvcyRRnfZSVwpPg/1qYQJl
 WINw==
X-Gm-Message-State: AGi0Pua9pQt4vaFHkK6bRC8gDrnvt390PjDgaf/ZUM6cl3QHU4s1XhbU
 jGP34oBh6vn/B4V23YvXocFkMQ==
X-Google-Smtp-Source: APiQypK0RHgx/hfeuZ15xIyH+NC92eJnO1uOYq3ByGN80pD3N+lLXCnkRp6mB7rlaFJyVL2R0tPbZA==
X-Received: by 2002:a5d:4301:: with SMTP id h1mr721347wrq.144.1587584008545;
 Wed, 22 Apr 2020 12:33:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm352892wmi.29.2020.04.22.12.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 12:33:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 462231FF7E;
 Wed, 22 Apr 2020 20:33:26 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-23-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 22/36] tcg: Increase tcg_out_dupi_vec immediate to
 int64_t
In-reply-to: <20200422011722.13287-23-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 20:33:26 +0100
Message-ID: <87o8rjb9ix.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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

> While we don't store more than tcg_target_long in TCGTemp,
> we shouldn't be limited to that for code generation.  We will
> be able to use this for INDEX_op_dup2_vec with 2 constants.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c |  2 +-
>  tcg/i386/tcg-target.inc.c    | 20 ++++++++++++--------
>  tcg/ppc/tcg-target.inc.c     | 15 ++++++++-------
>  tcg/tcg.c                    |  4 ++--
>  4 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index e5c9ab70a9..3b5a5d78c7 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -856,7 +856,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64In=
sn insn, TCGType ext,
>  }
>=20=20
>  static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> -                             TCGReg rd, tcg_target_long v64)
> +                             TCGReg rd, int64_t v64)
>  {
>      bool q =3D type =3D=3D TCG_TYPE_V128;
>      int cmode, imm8, i;
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 07424f7ef9..9cb627d6eb 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -945,7 +945,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType t=
ype, unsigned vece,
>  }
>=20=20
>  static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> -                             TCGReg ret, tcg_target_long arg)
> +                             TCGReg ret, int64_t arg)
>  {
>      int vex_l =3D (type =3D=3D TCG_TYPE_V256 ? P_VEXL : 0);
>=20=20
> @@ -958,7 +958,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType =
type,
>          return;
>      }
>=20=20
> -    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +    if (TCG_TARGET_REG_BITS =3D=3D 32 && arg =3D=3D dup_const(MO_32, arg=
)) {
> +        if (have_avx2) {
> +            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
> +        } else {
> +            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
> +        }
> +        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
> +    } else {
>          if (type =3D=3D TCG_TYPE_V64) {
>              tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
>          } else if (have_avx2) {
> @@ -966,14 +973,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType=
 type,
>          } else {
>              tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
>          }
> -        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
> -    } else {
> -        if (have_avx2) {
> -            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
> +        if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +            new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
>          } else {
> -            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
> +            new_pool_l2(s, R_386_32, s->code_ptr - 4, 0, arg, arg >> 32);
>          }
> -        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
>      }
>  }
>=20=20
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 7ab1e32064..3333b55766 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -913,7 +913,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType t=
ype, TCGReg ret,
>  }
>=20=20
>  static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
> -                             tcg_target_long val)
> +                             int64_t val)
>  {
>      uint32_t load_insn;
>      int rel, low;
> @@ -921,20 +921,20 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType=
 type, TCGReg ret,
>=20=20
>      low =3D (int8_t)val;
>      if (low >=3D -16 && low < 16) {
> -        if (val =3D=3D (tcg_target_long)dup_const(MO_8, low)) {
> +        if (val =3D=3D dup_const(MO_8, low)) {
>              tcg_out32(s, VSPLTISB | VRT(ret) | ((val & 31) << 16));
>              return;
>          }
> -        if (val =3D=3D (tcg_target_long)dup_const(MO_16, low)) {
> +        if (val =3D=3D dup_const(MO_16, low)) {
>              tcg_out32(s, VSPLTISH | VRT(ret) | ((val & 31) << 16));
>              return;
>          }
> -        if (val =3D=3D (tcg_target_long)dup_const(MO_32, low)) {
> +        if (val =3D=3D dup_const(MO_32, low)) {
>              tcg_out32(s, VSPLTISW | VRT(ret) | ((val & 31) << 16));
>              return;
>          }
>      }
> -    if (have_isa_3_00 && val =3D=3D (tcg_target_long)dup_const(MO_8, val=
)) {
> +    if (have_isa_3_00 && val =3D=3D dup_const(MO_8, val)) {
>          tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
>          return;
>      }
> @@ -956,14 +956,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType=
 type, TCGReg ret,
>          if (TCG_TARGET_REG_BITS =3D=3D 64) {
>              new_pool_label(s, val, rel, s->code_ptr, add);
>          } else {
> -            new_pool_l2(s, rel, s->code_ptr, add, val, val);
> +            new_pool_l2(s, rel, s->code_ptr, add, val >> 32, val);
>          }
>      } else {
>          load_insn =3D LVX | VRT(ret) | RB(TCG_REG_TMP1);
>          if (TCG_TARGET_REG_BITS =3D=3D 64) {
>              new_pool_l2(s, rel, s->code_ptr, add, val, val);
>          } else {
> -            new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
> +            new_pool_l4(s, rel, s->code_ptr, add,
> +                        val >> 32, val, val >> 32, val);
>          }
>      }
>=20=20
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 4f1ed1d2fe..fc1c97d586 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -117,7 +117,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType ty=
pe, unsigned vece,
>  static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
>                               TCGReg dst, TCGReg base, intptr_t offset);
>  static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> -                             TCGReg dst, tcg_target_long arg);
> +                             TCGReg dst, int64_t arg);
>  static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
>                             unsigned vece, const TCGArg *args,
>                             const int *const_args);
> @@ -133,7 +133,7 @@ static inline bool tcg_out_dupm_vec(TCGContext *s, TC=
GType type, unsigned vece,
>      g_assert_not_reached();
>  }
>  static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> -                                    TCGReg dst, tcg_target_long arg)
> +                                    TCGReg dst, int64_t arg)
>  {
>      g_assert_not_reached();
>  }


--=20
Alex Benn=C3=A9e

