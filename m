Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E44C4CECE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5088214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWbcG7D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5088214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWnj-0002Qj-DX
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAWjs-0000Bo-Ug
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAWjr-00030d-Aw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:59:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAWjr-0002zh-1M
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:59:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so6190674wrw.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mP5VpQ0WyZTLovTFPfOeLZ/O9elbfNGNPa/4uBLqy74=;
 b=hWbcG7D1aW1rE+kM5pUV3KlDOgFQ5ALc/efycE/Cp8fGJFM2lIToIPavdG7p2GlzaW
 0TBvdCCcrvqjwTCa1uPiRSol3CGEh10aBXAYUPDyRA/6V1kp97dAHXtoNLuEtbDgiay0
 bTztFf0LFs4H6ua2aZxqaQvLPoWGle/jmc/csZJglXO0Fzf2Ia0fJYSRF3m8YjhTd9Vb
 8tMT8H7rw2Zv3h6+kA+vz4IVxlAfMwx4OTjydaaAo9mfs37jw0qGuN6ZtIuNEX6hGNzv
 Y320fNLok6x6KGj98x448Hf6q/3beC68eYahjoVS10rnDaBYk0qWaG9N/IB3MfRIoFgK
 ZrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mP5VpQ0WyZTLovTFPfOeLZ/O9elbfNGNPa/4uBLqy74=;
 b=e4320Mj5QzCR7Vi7JojkIfeV2zxdg5d0l5PUipvFujrqSon1Q82zI12SQaKC84cnUk
 V0x1oZTUqRiT8KRg6S12FFYeMexiM3/OqNYlJDB54bfeSdH1irTm5+fNQkZDdNDsqZ9y
 FOQ5VqpXxQhAnnuxyEagTfxpBAHB5UpuF7fumx5DGFz6QSPJlh7rJlZXr/cc4NW0gKMn
 oEepeLhRq+yy5K5mIUqmBDt2q77BQTjhVB9phC2Vht367w/UGk6LJx/i91TxRmB+/RdJ
 KldEovvm0VkMvMQcpFxwSHvyRqMCE7Asn6MBXwp2+fz1fS+n8cfbphQoaZ109hy3L67S
 ZDWg==
X-Gm-Message-State: APjAAAX766MYH+J41z059riCu9OnYFZFxzWk3kzB+sN8t/rtFxeSTrwK
 FHKrnthMkBVp7lV6BLOKTYhaYg==
X-Google-Smtp-Source: APXvYqxvtt9rHY95EX1/u/cKSzikOBOBE1zUIoim3RyI0TZ7KL8pp1Kllk/Frl4eAoJ1FTUl6NwpHQ==
X-Received: by 2002:adf:e603:: with SMTP id p3mr2263484wrm.102.1568800744165; 
 Wed, 18 Sep 2019 02:59:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm10325850wrg.55.2019.09.18.02.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:59:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF0EE1FF87;
 Wed, 18 Sep 2019 10:59:02 +0100 (BST)
References: <1615bbe5-3033-3b76-5cfb-52e343dc4d67@freepascal.org>
 <ae7415a9-54be-14de-9590-f9ff6ef025c4@redhat.com>
 <ddb842e7-dd48-1e74-20db-dea75de0552d@freepascal.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierre Muller <pierre@freepascal.org>
In-reply-to: <ddb842e7-dd48-1e74-20db-dea75de0552d@freepascal.org>
Date: Wed, 18 Sep 2019 10:59:02 +0100
Message-ID: <874l1a0vtl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] * include/fpu/softfloat.h
 (floatx80_invalid_encoding): Handle m68k specific infinity pattern.
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pierre Muller <pierre@freepascal.org> writes:

>   Hi Thomas,
>
>   I tried to use git format-patch -s below,
> and change the commit message that appears below:
>
>
> muller@gcc123:~/gnu/qemu/qemu$ git format-patch -s a017dc6d43aaa4ffc7be40=
ae3adee4086be9cec2^
> 0001-Fix-floatx80_invalid_encoding-function-for-m68k-cpu.patch
> muller@gcc123:~/gnu/qemu/qemu$ cat
> 0001-Fix-floatx80_invalid_encoding-function-for-m68k-cpu.patch

It's best to send the patches directly (i.e. don't include them in a
larger email). This is because when maintainers apply the email they end
up with a bunch of additional stuff and the corrupting of subject line.

> From a017dc6d43aaa4ffc7be40ae3adee4086be9cec2 Mon Sep 17 00:00:00 2001
> From: Pierre Muller <pierre@freepascal.org>
> Date: Wed, 18 Sep 2019 08:04:19 +0000
> Subject: [PATCH]    Fix floatx80_invalid_encoding function for m68k cpu
>
>     As m68k accepts different patterns for infinity,
>     and additional test for valid infinity must be added
>     for m68k cpu target.
>
> Signed-off-by: Pierre Muller <pierre@freepascal.org>
> ---
>  include/fpu/softfloat.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index ecb8ba0114..dea24384e9 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -685,10 +685,17 @@ static inline int floatx80_is_any_nan(floatx80 a)
>  | pseudo-infinities and un-normal numbers. It does not include
>  | pseudo-denormals, which must still be correctly handled as inputs even
>  | if they are never generated as outputs.
> +| As m68k accepts different patterns for infinity, thus an additional te=
st
> +| for valid infinity value must be added for m68k CPU.
>  *-----------------------------------------------------------------------=
-----*/
>  static inline bool floatx80_invalid_encoding(floatx80 a)
>  {
> +#if defined (TARGET_M68K)
> +    return ((a.low & (1ULL << 63)) =3D=3D 0 && (a.high & 0x7FFF) !=3D 0)
> +           && (! floatx80_is_infinity(a));
> +#else
>      return (a.low & (1ULL << 63)) =3D=3D 0 && (a.high & 0x7FFF) !=3D 0;
> +#endif
>  }

As most of the test is the same we could rewrite this to:

 bool invalid =3D (a.low & (1ULL << 63)) =3D=3D 0 && (a.high & 0x7FFF) !=3D=
 0;
 #if defined (TARGET_M68K)
 invalid &=3D !floatx80_is_infinity(a)
 #endif
 return invalid;

The compiler should be able to simplify the logic from there.

Do we have any test cases that we could add to tests/tcg/m68k?

>
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)


--
Alex Benn=C3=A9e

