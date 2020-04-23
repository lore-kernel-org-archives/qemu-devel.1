Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63124C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9C62173E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6Hpe0X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9C62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYK6-0000GI-BZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRYJT-0008II-Ib
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRYJS-0007Ux-V6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:38:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRYJS-0007Uj-Ho
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:38:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id b11so6022299wrs.6
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tLpiF/kRbmt692yWga/EqmPtEDUZ3PdJqiGvhhnMz88=;
 b=N6Hpe0X6Xi2TVtAqu24ZP8z0eOPCR3gD8EoOKNijNvuPe8pwQXxp3M1IKnHk14DJT9
 3qH7OxVTVY9WDpreQmgRgoTify6dCv804eb0h2aMri2JWiYKAHugDXSc1CftZEDNVdcJ
 xlZF6FnBdsP7e/mVXwPlxfPeTj7ptbuybscP6wOxQyYT6ux0rXNQbZkwkqpL0O3P+EIM
 PBxyPUmRYyCXSHhjO0vFBacS+jlCe6eA5x6lCypVbpw/s2PKtdffdjORFWv2b8Z4I7zC
 k95BApRsOj803UyBIgFLWEO2ppJtRjX2EMvW6o003Vya48vLO9QKSWykll8B5Hgbtb8T
 SZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tLpiF/kRbmt692yWga/EqmPtEDUZ3PdJqiGvhhnMz88=;
 b=nNEBcP5LbV2ZL+Ouy9vD82Df8ImUT0nOOE/RAFtEwDAm7rnsQ7bJ2/ygjKTeHKzDbv
 iMQ+rsWfQmno3aUIDeCBLuEv6V2UA2BUdpAPa+JX7mt+wZP2LRoMavEV8rAv96AECq83
 KCwX+C9zx2OiPzlmdRvMP6qG75J4CyLZOI7nl/o4Uqzei0YDX5Ql8H06eLLiVXDZ/GP8
 iU4/waEmxk2MD4Avkc0vn20GMH+sf3q9CFL2BhgK5NaBPa0elshksTB1X6XiH5sDrG0o
 gL9bb5hcciQxzgorJiExjCEyx5qgtQz0bhhbsxg31wA+KpjyzTh+/J5Qvrb+0ixypTXK
 GaPQ==
X-Gm-Message-State: AGi0Puag7haqmQN8/uJsuVq4+typkmQyiXw7jgUhrB0aVzyaIlzpiMD1
 oRcdFfU8jyY29zLqgk4tRDR0lQ==
X-Google-Smtp-Source: APiQypKZFKwGDqk4qF741xcHpAqnJ6mxMMo4927DC97uWqAeWrnth7IDGmiNUNI4gl78o2X1IABTLg==
X-Received: by 2002:adf:f350:: with SMTP id e16mr3754019wrp.332.1587634708825; 
 Thu, 23 Apr 2020 02:38:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c10sm2679544wru.48.2020.04.23.02.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 02:38:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 249B21FF7E;
 Thu, 23 Apr 2020 10:38:27 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-28-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 27/36] tcg: Fix integral argument type to
 tcg_gen_rot[rl]i_i{32,64}
In-reply-to: <20200422011722.13287-28-richard.henderson@linaro.org>
Date: Thu, 23 Apr 2020 10:38:27 +0100
Message-ID: <877dy6bkz0.fsf@linaro.org>
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

> For the benefit of compatibility of function pointer types,
> we have standardized on int32_t and int64_t as the integral
> argument to tcg expanders.
>
> We converted most of them in 474b2e8f0f7, but missed the rotates.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op.h |  8 ++++----
>  tcg/tcg-op.c         | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index a39eb13ff0..b07bf7b524 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -298,9 +298,9 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, ui=
nt32_t arg2);
>  void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
>  void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> -void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
> +void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> -void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
> +void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
>                           unsigned int ofs, unsigned int len);
>  void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
> @@ -490,9 +490,9 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, ui=
nt64_t arg2);
>  void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
>  void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> -void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
> +void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> -void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
> +void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
>                           unsigned int ofs, unsigned int len);
>  void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 07eb661a07..202d8057c5 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -516,9 +516,9 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TC=
Gv_i32 arg2)
>      }
>  }
>=20=20
> -void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
> +void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 32);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
> @@ -554,9 +554,9 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TC=
Gv_i32 arg2)
>      }
>  }
>=20=20
> -void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
> +void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 32);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
> @@ -1949,9 +1949,9 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, =
TCGv_i64 arg2)
>      }
>  }
>=20=20
> -void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
> +void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 64);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
> @@ -1986,9 +1986,9 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, =
TCGv_i64 arg2)
>      }
>  }
>=20=20
> -void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
> +void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 64);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);


--=20
Alex Benn=C3=A9e

