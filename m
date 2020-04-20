Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A442C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EC920857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0RkSS5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EC920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWfr-0000jG-2D
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60968 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWXq-0004Qy-Js
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:33:09 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWXl-00050c-M3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:33:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51783)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQWXl-0004wD-7r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:33:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id x4so11049285wmj.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CnmGxvqyofCLNwcE6yzgxFTycI2OVyxcsRxoEz4dbC8=;
 b=K0RkSS5F+4GH1/x9f4xpPe9k3CJ/zI+vljCSe0p9BaqMwLg4SYsvo2H4YfIUnmio4o
 VBG/d2Z+NWrDwurT+MDEomCobqEbgGGQL3tOV2EoPvCZXGChRXKkLuCe4yp7ye78lCxT
 x3suqHuSK1XDq/0Ef+GXcIknDva0WAFg0CNRAUQmW86G3p7gWV6WDNS1vjAdqsMNhv8+
 EQI5thqHoDlWQa0ufgMb0V7TJKukvgrHpkm1SRrywYN2gYBay1sO1qPJaQ1UG9wlgY3g
 vUkZtKhKjnA6uOANSrbBxhh1/JN7HUvNT8jjRrK/SaKECJX1NaGNWGFvQ+x6DE9CpgZV
 uDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CnmGxvqyofCLNwcE6yzgxFTycI2OVyxcsRxoEz4dbC8=;
 b=oV/7OBTAFbblav4grtgw7yIjW0t4ChYkg0RnupF0l0mPPAGlMHMJG6Kn2ry2487yR+
 NlWCD8P2/c/T8mOGb3oYwAJnZ/3EBD1fiYr14pJPsDl5wPP0nCkLrV+NZlhK+x01DL4u
 YPPD8r5pKLTCxEP+u2UuBihGDQgwsKY3BWTLA4/J091X5s5pTNrGZRNtusge/KHwxYf0
 ksDJZ4vAmUjyAubQY9XNWL713ahEC2CFZqhHtxiW+Vz/RwMzr4EI9/anQZrNBTuMPiHN
 ANA0u4j/BE27jtY0ZhWbQH8ghLk0jNA4HIGB/uHCB1MK8qOo/1/hLUNcx2wXaEiOVRXY
 aUNw==
X-Gm-Message-State: AGi0Pub/BMmIkjynSMBcjUJry1ONy854/uQSTvWwZRnhoepAc3utw5sv
 L66gN/Y0XuLiAbXJRX2owxNiS4yf+h0=
X-Google-Smtp-Source: APiQypJde1Pd53IGnXVDvzDefUt/Z1pz2zqvVlh7yAl9CIsBkYzeXw7P5tap0bRkIZ0+/a5q0SNl4g==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr8770880wme.71.1587389579513; 
 Mon, 20 Apr 2020 06:32:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v19sm1307936wra.57.2020.04.20.06.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 06:32:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C551B1FF7E;
 Mon, 20 Apr 2020 14:32:57 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-8-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 7/7] tcg: Add tcg_gen_gvec_dup_tl
In-reply-to: <20200418150411.1831-8-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 14:32:57 +0100
Message-ID: <87r1wie0za.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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

> For use when a target needs to pass a configure-specific
> target_ulong value to duplicate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op-gvec.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index fa8a0c8d03..d89f91f40e 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -320,6 +320,12 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t do=
fs, uint32_t s,
>  void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
>                            uint32_t m, TCGv_i64);
>=20=20
> +#if TARGET_LONG_BITS =3D=3D 64
> +# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
> +#else
> +# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
> +#endif
> +
>  void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz);
>  void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,


--=20
Alex Benn=C3=A9e

