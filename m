Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECC6C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B71F2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7xM7Rkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B71F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWZF-0006Iz-KF
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60792 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWXW-0004J6-Vo
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:48 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWXS-0004Ug-Io
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40296)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQWXR-0004Rq-GV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id k13so10978668wrw.7
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DZuVaspm+kLFDv4mHFJO2RkTNx/ATyUVE5tqXvqvUy8=;
 b=g7xM7RknAXTwDq4Hg7uyyTHBiH3ClvhuvalBscCa5PzWWfKIYxmzDUQYGJDAPs2lze
 fLeMkjjfPzzflnC0PetAyDosp6j38EGmkn1tVUuIBrzDbxkQa1H9ZDuN0caQ8T2BIqZY
 28vFsRco83MSK9iLmmCqHjZzHitGs0CoKDmlj+k+dA8zJuaeHQOUY78TGwNEhLN7Atq7
 BT1UbUgNWUSHy26iyzDSWbU7OMaY/JeXDE5PmW9YEV5JO9RjcxmySnXX8CFtjXrChGiP
 Zg0sPFPFlI3kj/IMdBVvlrfgHI6RTbcz/AB9KDQY5B4sixkzuclWPzuJFY5vII90Ny1A
 IiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DZuVaspm+kLFDv4mHFJO2RkTNx/ATyUVE5tqXvqvUy8=;
 b=OTChBmULmMqqnbR/YRS/lRtTGt60z2/JOKfHOejqKl77O/dL5yD47bmz4bDMIew/O1
 inBxqGy1gT0Cv9mn127fY/TBUzbcB9qJeEImEiD+//uvGGR95J48u4bxWu9LvDXycD/6
 AdkBHYFsk7VrDUIbbYpiMN8dXA1EahPMRlaiKWwkJDvlKsC9kZCdC3DVBRzbTTUA+epA
 CKj4l8SioyI6bOtC1rVjyLZE46YZNq6K9zPTUgyMALyLuzprwnlsvJ9ef5pMV6GVyt8s
 9pAyunX3XNYpu1nV0UMIH24rajYsj+4KIka314WTVDVKz8ATbeKmRKBwEbvhhpcu7qCN
 fjOg==
X-Gm-Message-State: AGi0PuZiY4z35xhWvdlxhQmYa1I++zehUUGbyxRL+MJ1Sb5p4YJcj8vO
 I0us1p+ai+ZP+HwKgfapykGEmw==
X-Google-Smtp-Source: APiQypIGcH8VJ5xPC18T1RPbVWEjxJ7xV9DLiLAmBydtFPB5pRQc5ZW4Ny8I3dW1N0T0+XqSQSt6nw==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr18443400wrr.160.1587389560086; 
 Mon, 20 Apr 2020 06:32:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm1431030wmi.27.2020.04.20.06.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 06:32:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B6A31FF7E;
 Mon, 20 Apr 2020 14:32:38 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-7-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/7] tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
In-reply-to: <20200418150411.1831-7-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 14:32:38 +0100
Message-ID: <87tv1ee0zt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 david@gibson.dropbear.id.au, zhiwei_liu@c-sky.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> These interfaces are now unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op-gvec.h |  5 -----
>  tcg/tcg-op-gvec.c         | 28 ----------------------------
>  2 files changed, 33 deletions(-)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index eb0d47a42b..fa8a0c8d03 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -320,11 +320,6 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t do=
fs, uint32_t s,
>  void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
>                            uint32_t m, TCGv_i64);
>=20=20
> -void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t s, uint32_t m, uint8_t x=
);
> -void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t=
 x);
> -void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t=
 x);
> -void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t=
 x);
> -
>  void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz);
>  void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index de16c027b3..5a6cc19812 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1541,34 +1541,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t =
dofs, uint32_t aofs,
>      }
>  }
>=20=20
> -void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint64_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_64, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
> -void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint32_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_32, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
> -void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint16_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_16, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
> -void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint8_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
>  void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
>                            uint32_t maxsz, uint64_t x)
>  {


--=20
Alex Benn=C3=A9e

