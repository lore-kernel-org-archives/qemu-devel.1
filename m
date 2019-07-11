Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC616C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F7B21670
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIGfsNsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F7B21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZ9K-00061J-6M
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlZ8I-0005JE-G8
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlZ8H-00025v-B3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:29:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlZ8G-00023j-W3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:29:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id h59so1934427otb.10
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=IDXsJZcKnueQkzyypn4ajRfCGWYgkAiZizgsT/f8KAI=;
 b=MIGfsNshyQFbvvBSr36KpfonM1vzHWAG/Z3wFiDg3kkFlYbZ9ZE6GmBD56dF6J8ust
 O+L3urCotw/WKNFbYZo1nUPEORgf+P4t26Qlsqudr3qznIu0BmdWymWaSFHY4D2sm/PW
 3/6keL/EQfLDHZhh0jZ9gGZK5cBT3UnBSJqBWR6ZSwV933y60OM6k01tOQTsHNFPrM6k
 TlX4UFEGD/7bE0c8A25sRlSpxJHJJAF7IuHOXRmKwyKS6nYkvK2XcGX8zDfpp5NIXSJp
 c5HcAKc43/4qgrs8Ms1yrkssUQ8vLxUCtzQlbjzuOV8Q4eRZmM8OASNiAmBzsOsr70ww
 jjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=IDXsJZcKnueQkzyypn4ajRfCGWYgkAiZizgsT/f8KAI=;
 b=oIbpUuE63qEIuexBZanB249QnAtQI/RLmzUnqNwOkJi0WXH7LNyLJ2p+RnOVpMs31y
 4OOHK558rU1GTROmgsjAuRr3IeS83lKklrrG18ePPd3JRULjUudC9GS8b+bIsor4rl6z
 xLgYu/aC9+75DlwrEwd118pARyi/OBTmycI13FDgVTVtceFv9SHySjfEmQjYsXMXHzUe
 y2V01XzBHDQpkEu5G5T0baREIuWNeeKdRL4FHKhppTCI2ja66+FjAAyt+SN2dX0BRY0F
 Pzlpei3dhK6jO2J62CBiM7CfkzDulG0XJhEYZcGu+LvFrQaAXbJeY7YasaJ2h4qfazrb
 TuXg==
X-Gm-Message-State: APjAAAWpZml39+pfvUaSCA4XJMYtJFvtr5XsMWEb+D7edaC4vLH3RB/R
 eIelRzSbH7gzQ19NK8AOMFM=
X-Google-Smtp-Source: APXvYqwXB9fYs+Ls6tdX2YpTcGTDqFSSu19n98BoYVl4tAzCYBSDsAKBDcIQjMrnIejz3n9CJ+M+ZA==
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr3466669otq.262.1562851748018; 
 Thu, 11 Jul 2019 06:29:08 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id b2sm1919121otf.48.2019.07.11.06.29.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 06:29:07 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
 <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
 <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <68048912-a5f6-7885-4a5d-17957e3cb890@gmail.com>
Date: Thu, 11 Jul 2019 09:29:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="I6tuL5zHOBx4j7Yi19WsIXYkRx1cFXNq8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I6tuL5zHOBx4j7Yi19WsIXYkRx1cFXNq8
Content-Type: multipart/mixed; boundary="UucpWCVq541ViEbWaSTy5JJeO2sgj1qv1";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <68048912-a5f6-7885-4a5d-17957e3cb890@gmail.com>
Subject: Re: [RISU RFC PATCH v2 06/14] x86.risu: add MMX instructions
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
 <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
 <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>
In-Reply-To: <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>

--UucpWCVq541ViEbWaSTy5JJeO2sgj1qv1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/11/19 5:32 AM, Richard Henderson wrote:
> On 7/10/19 8:29 PM, Jan Bobek wrote:
>>>> +# Arithmetic Instructions
>>>> +PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size=
 =3D> 8); }
>>>> +PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size=
 =3D> 8); }
>>>> +PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size=
 =3D> 8); }
>>>> +PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size=
 =3D> 8); }
>>
>> Not this one, at least according to the Intel docs:
>>
>> NP 0F D4 /r: PADDQ mm, mm/m64          (MMX)
>> 66 0F D4 /r: PADDQ xmm1, xmm2/m128     (SSE2)
>>
>> The SSE2 version is added in a later patch.
>=20
> That's not how I read the Intel docs.
>=20
> In the CPUID feature flag column of the MMX PADDQ, I see SSE2.  While t=
he insn
> affects the mmx registers, it was not added with the original MMX instr=
uction set.

I know what you mean; for example, PSUBQ is like that. I know about
these kind of instructions because "{name}_{enc}" does not form a
unique key, and risugen would complain about that. That's why there is
PSUBQ_mm and PSUBQ in the final x86.risu file.

However, I downloaded a fresh copy of Intel SDM off the Intel website
this morning (just to make sure) and in Volume 2B, Section "4.3
Instructions (M-U)," page 4-208 titled "PADDB/PADDW/PADDD/PADDQ=E2=80=94A=
dd
Packed Integers," there's the NP 0F D4 /r PADDQ mm, mm/m64 instruction
in the 4th row, and the CPUID column says MMX. On the other hand, I
can't find it in the Volume 1, Section 5.4 "MMX(tm) Instructions," or
in Vol. 1, Chapter 9 "Programming with Intel(R) MMX(tm) Technology,"
so it's a bit confusing.

If you know for a fact that it didn't come until SSE2 and the manual
is wrong, I will change it.

-Jan


--UucpWCVq541ViEbWaSTy5JJeO2sgj1qv1--

--I6tuL5zHOBx4j7Yi19WsIXYkRx1cFXNq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0nOaEACgkQZeg2ldrj
Ns9ORw//Y/MBHlAdjHzAVMypDntbzGMM1WjJb8LHAxv4PSTB6yTrjfuAo9lrpHB+
Hiwts2PXqDKlRvWQPCNSScC85eeijyyh/wkHUpTXa28OG7fwe202miPvMWXAFqHg
47Kkd23pF4c9+Vk+NkdEGBG6uqDQiZp0JTcTZ9QPeKjEOREba2sJHuLIg1VhHDKk
2rtz+O8YjUxPftz66KFqoffLPRCPf3QIYvKeBBjrvxDFwjE68kMR2wbK08MJaaVA
GsS1+vFfhXE2nSxEvIwPC0La2NMQmevIcZ5yaDuuYal/xwJsPxW8hCoOWzHGtBph
XUSwrACa4N79aFb7u+sn8cit2pHuzZNK2oPwF8TDaOQ3tsDrtphu57DtfLDc5XMM
ftPnZBmjDhrASxv5i78Jzrk7fhglw4Qqx+8ccxTe1HUuW5sw3i10AWHm26qQ9DKC
lWmJaJU70han5rK/BbNrongFBKAdAJ+Ltn6iFPd9zUqSmFkeyNjzIyGzLycQ6vY1
MqUytPX2CaeOIIZdjMxSyNB0pR8aMAARfvYvrxnPkrEELNbg13ighzPlpUXy8A+l
HuRtlqC2fHGs10T3d5U2DJGKwL1HPzkTJfNya/m77LmsLPRZEI5Vu4DcFN5YP3I+
ZFPaTZ84DK/OyzIBtuMjLmjR7C6YH3uI+rhujRhmIFsb7mEJN+8=
=cSiF
-----END PGP SIGNATURE-----

--I6tuL5zHOBx4j7Yi19WsIXYkRx1cFXNq8--

