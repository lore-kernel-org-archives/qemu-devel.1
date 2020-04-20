Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED374C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F652070B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEvh4GK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F652070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWZ0-0005lm-Q3
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWXA-00041Y-U9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:25 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWXA-0003wv-46
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39723)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQWX9-0003sD-GO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id y24so11419613wma.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GgX1H+l76Fd5CRuKq+Af0tJ1JB4+gS0PXmfGndyLhHE=;
 b=YEvh4GK8aua5JJ+ow2ZWVXjNAl7It8umKxM5sKHcJDoXI7RF6aWqEV4FA3N5QewjQ6
 g5Xdp6Fps5OvFFuG/Majxt2xPxA9STCCU2DKeh58usO4CJ+F0JEarkBe2CGyvtyZsfPy
 dMQ4ZLjs9wMMLKy16BLhPbikeQeYAFNkEuR3bCRUgzFWZeWJ9NCddcLSFa4VTIWd2wX2
 uJ2O4delWGj4Q/U1xSRQ2zjuUjxpsqxRi3mVzyt016/O5HIELklE9x61IjprSAIoURaK
 Mp+Xqyz7CdDxjkeyHeryTPymo/19+kyT1gbf6Q830PbU58IhmRsJmQZec0DJaZv5RaLh
 /9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GgX1H+l76Fd5CRuKq+Af0tJ1JB4+gS0PXmfGndyLhHE=;
 b=IM/Ci/5FC7L2B42Co2zCrWK70kU7hDY73urLl8Cam9g41zKMCljH2BNaBw7HeBlQE3
 RfnynzDWfJcCnFLGRTjpe1gssqzeNFSgxhjCnvLl0DxIK/yB0Cs3b7AfisHNCtJGG4gE
 Ot/LkNu15Hlz1SMv0JV2kdqhNz1BEgoFp6pCJfqxQNOt2Z4Mbgv0rea/+P5aacClZAWs
 Y7lOh/+Z91UeVcu0lsAzJGKEb5FqAXizu7bfnTPo3kzoxL4Wqvdeq2nloI+FR+yZt7ga
 rH6hb9y0uVlm3SVDATYChFblOdzQTV/5adFryr87EG+bE49QLOymCvamjtf6vpeAYV0K
 5d9A==
X-Gm-Message-State: AGi0Pub2bPY7FN8FPBmIwS8DpYKmnIvtBWHnDJZ2LRzXMlYDzUREIYFu
 DkPnNxIgmCxxrzrd/CXUeCCWfA==
X-Google-Smtp-Source: APiQypLDhQS+choU8nh1wmRHXUzhQQ6fLVqvbVfvmw0rmqwzCNFmc4tQsEircJpyUknheGWS68neeQ==
X-Received: by 2002:a1c:1985:: with SMTP id 127mr7605288wmz.13.1587389541591; 
 Mon, 20 Apr 2020 06:32:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r17sm1189860wrn.43.2020.04.20.06.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 06:32:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 947D01FF7E;
 Mon, 20 Apr 2020 14:32:19 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-6-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 5/7] tcg: Use tcg_gen_gvec_dup_imm in logical
 simplifications
In-reply-to: <20200418150411.1831-6-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 14:32:19 +0100
Message-ID: <87wo6ae10c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

> Replace the outgoing interface.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op-gvec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 593bb4542e..de16c027b3 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -2326,7 +2326,7 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>      };
>=20=20
>      if (aofs =3D=3D bofs) {
> -        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
> +        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
>      } else {
>          tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
>      }
> @@ -2343,7 +2343,7 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>      };
>=20=20
>      if (aofs =3D=3D bofs) {
> -        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
> +        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
>      } else {
>          tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
>      }
> @@ -2360,7 +2360,7 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>      };
>=20=20
>      if (aofs =3D=3D bofs) {
> -        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
> +        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
>      } else {
>          tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
>      }
> @@ -2411,7 +2411,7 @@ void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>      };
>=20=20
>      if (aofs =3D=3D bofs) {
> -        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
> +        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
>      } else {
>          tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
>      }


--=20
Alex Benn=C3=A9e

