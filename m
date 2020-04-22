Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E578C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F2220776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5WZKjUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F2220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ2P-0003e4-2b
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJ1O-0002uh-6w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJ1N-0006aK-D6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:18:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRJ1M-0006V3-OZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:18:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id b11so3384148wrs.6
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KjfUcKAu5MJaAOBUufPb+3StkezbjQxTmGeikHkgi/A=;
 b=E5WZKjUl02g/fTi8o1//TSzQmcNVITW5+NWdlJmB/Ib0XOiOZOHnWiwF23p8AEhS5V
 Lb/sJFOTGxuf4Rh5mazlIwQkLZPB8pHMr2xV7KbILgzfAk5FKOQ650DbRjHuZDmpIfF7
 kcFQGk4uHuRT15Ba1q1S1RrE8M/DK2d9AIj58NMaYjYcjrlMHzvh/IBh5oZReQsAdCnb
 js+U0IXoyV26ZP9F30nrPGarO+wFn59mGVw2oXK0tc8iAXqF1CuGvJD3OZBUE25GNXsw
 a0ppxm/fCADCWDg0df5K+jE5UZrO+jTv4STUMNKpluZ9CrkwWHH63BgipkUIhazXXCks
 EmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KjfUcKAu5MJaAOBUufPb+3StkezbjQxTmGeikHkgi/A=;
 b=PPzLkynodz2iJjLn+5mlkKnpkXPzylGirsJNSWf2iB2IdLQjAgksd9xibUg+11PsKK
 a2BKPaMjXtMZh0U/vpd6nc8xGAfSGZbnUw8fw7PfFPg0jQNrPoUEdQZNf8+vfnLJHmi7
 i0+seu3LDjm+dq3x7GLylw7K1HVHdX9ETC7Y2uYjyBT+K1kl8kq3dB2HpsJ7TBto0e7N
 Zl70Kidhaew2r/ttGsQW2WaC6NSZrYzzYHecXIFE4mBmfRBYk2ZUf3+ScQLtju063Z43
 TOaGqVbVpOisGGi46NrQJX+vrOY9rVXoCvXAP2E9+YfZYcGiJb8jiZPpOKH+7E64einK
 HqWA==
X-Gm-Message-State: AGi0PuYKLwfezYzb8sIEvkQT5Mv55SpqicCWyhSDC/wKeykubHg1pXkH
 QgOU+NubTfG33P2w26D6B3XMxA==
X-Google-Smtp-Source: APiQypJrh6UNtAYd+6MJVfDZsO1PzJiEFErFm1BLntiyUXBUX+H/eVLrr/dIcqIxTcVj76Lu+5w1+w==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr35057wrm.375.1587575926656;
 Wed, 22 Apr 2020 10:18:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm9159041wrb.75.2020.04.22.10.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 10:18:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D516E1FF7E;
 Wed, 22 Apr 2020 18:18:43 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-16-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 15/36] tcg: Use tcg_constant_{i32, i64} with tcg plugins
In-reply-to: <20200422011722.13287-16-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 18:18:43 +0100
Message-ID: <87eesfcubw.fsf@linaro.org>
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/plugin-gen.c | 49 +++++++++++++++++++-----------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 51580d51a0..e5dc9d0ca9 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -284,8 +284,8 @@ static TCGOp *copy_extu_i32_i64(TCGOp **begin_op, TCG=
Op *op)
>      if (TCG_TARGET_REG_BITS =3D=3D 32) {
>          /* mov_i32 */
>          op =3D copy_op(begin_op, op, INDEX_op_mov_i32);
> -        /* movi_i32 */
> -        op =3D copy_op(begin_op, op, INDEX_op_movi_i32);
> +        /* mov_i32 w/ $0 */
> +        op =3D copy_op(begin_op, op, INDEX_op_mov_i32);
>      } else {
>          /* extu_i32_i64 */
>          op =3D copy_op(begin_op, op, INDEX_op_extu_i32_i64);
> @@ -306,39 +306,34 @@ static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp =
*op)
>      return op;
>  }
>=20=20
> -static TCGOp *copy_movi_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
> -{
> -    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> -        /* 2x movi_i32 */
> -        op =3D copy_op(begin_op, op, INDEX_op_movi_i32);
> -        op->args[1] =3D v;
> -
> -        op =3D copy_op(begin_op, op, INDEX_op_movi_i32);
> -        op->args[1] =3D v >> 32;
> -    } else {
> -        /* movi_i64 */
> -        op =3D copy_op(begin_op, op, INDEX_op_movi_i64);
> -        op->args[1] =3D v;
> -    }
> -    return op;
> -}
> -
>  static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
>  {
>      if (UINTPTR_MAX =3D=3D UINT32_MAX) {
> -        /* movi_i32 */
> -        op =3D copy_op(begin_op, op, INDEX_op_movi_i32);
> -        op->args[1] =3D (uintptr_t)ptr;
> +        /* mov_i32 */
> +        op =3D copy_op(begin_op, op, INDEX_op_mov_i32);
> +        op->args[1] =3D tcgv_i32_arg(tcg_constant_i32((uintptr_t)ptr));
>      } else {
> -        /* movi_i64 */
> -        op =3D copy_movi_i64(begin_op, op, (uint64_t)(uintptr_t)ptr);
> +        /* mov_i64 */
> +        op =3D copy_op(begin_op, op, INDEX_op_mov_i64);
> +        op->args[1] =3D tcgv_i64_arg(tcg_constant_i64((uintptr_t)ptr));
>      }
>      return op;
>  }
>=20=20
>  static TCGOp *copy_const_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
>  {
> -    return copy_movi_i64(begin_op, op, v);
> +    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> +        /* 2x mov_i32 */
> +        op =3D copy_op(begin_op, op, INDEX_op_mov_i32);
> +        op->args[1] =3D tcgv_i32_arg(tcg_constant_i32(v));
> +        op =3D copy_op(begin_op, op, INDEX_op_mov_i32);
> +        op->args[1] =3D tcgv_i32_arg(tcg_constant_i32(v >> 32));
> +    } else {
> +        /* mov_i64 */
> +        op =3D copy_op(begin_op, op, INDEX_op_mov_i64);
> +        op->args[1] =3D tcgv_i64_arg(tcg_constant_i64(v));
> +    }
> +    return op;
>  }
>=20=20
>  static TCGOp *copy_extu_tl_i64(TCGOp **begin_op, TCGOp *op)
> @@ -486,8 +481,8 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_=
dyn_cb *cb,
>=20=20
>      tcg_debug_assert(type =3D=3D PLUGIN_GEN_CB_MEM);
>=20=20
> -    /* const_i32 =3D=3D movi_i32 ("info", so it remains as is) */
> -    op =3D copy_op(&begin_op, op, INDEX_op_movi_i32);
> +    /* const_i32 =3D=3D mov_i32 ("info", so it remains as is) */
> +    op =3D copy_op(&begin_op, op, INDEX_op_mov_i32);
>=20=20
>      /* const_ptr */
>      op =3D copy_const_ptr(&begin_op, op, cb->userp);


--=20
Alex Benn=C3=A9e

