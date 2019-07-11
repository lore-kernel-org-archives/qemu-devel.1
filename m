Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA28C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 21:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818BC208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 21:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiRPWwQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818BC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlgdQ-0006D2-J7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 17:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlgdF-0005m6-7Z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 17:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlgdE-0001tJ-6W
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 17:29:37 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:41523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlgdE-0001sH-01
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 17:29:36 -0400
Received: by mail-yw1-xc43.google.com with SMTP id i138so4410888ywg.8
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=hJPypxBRe1MuiqtjJbBKOtZRI5kJ2qqzQZLpQXbM7dU=;
 b=ZiRPWwQpzVGmSRX8knBULQUJwMG9MKWHKmOg7msxzhMNZdTGDCCCND2ubQkmMCM4dc
 OKj7KQyEIt8ipp1XEeb2l47yKSuNJCL2kTVQB+m/auWKgWQBcSH8EetOMOA5lwB6o5gp
 2bm5qUiDE7cJE3gPkQjggkVHhqTxQw1KNabIlQgiFH3RBJRU5Q8HBBQnwluq7fQG2k0m
 gHE04rkLQn2cTlSlLl36SzUzkZ3tCrbJCzufkdcGhOkCrhL4JqmL04zJszpRHvx+pd66
 KvxhSOTvLyR/ET6NEWO/KbI/KmRz8eA4jU9HrdFpH49Fatr0oDgheVZGWsoBVhFaDH5A
 P3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=hJPypxBRe1MuiqtjJbBKOtZRI5kJ2qqzQZLpQXbM7dU=;
 b=EM7EozHUyvnhs0AuHBcSVWlbKavKuxBwI8v0yQg7g/Uw5Aw5xKEm52nAh7ki0bZ/+a
 P0vdgjSCG+ah/Ftm0PL3gwkAkirp/QiLrK0eGu0hV/QscXQpXjVP3EuEyFNyBGdYdisF
 sKFF2o4zM0d44pINzGrEsKy8NyuzbgXU1GRsR4pXI2Vd7HpFtkfQzW/FBIpDJvhZjbZw
 3udGtQnHjpMyw85bOK+yaIZDyK8TUrOd/r9Y5JhcgVKp/+6r7H8Q8GlFiBcBOFrffUp0
 f8+qiB0eld65vjqBM44RtwSUtpGd33jc9+pGJwGjlTfhOpIpIRBLMwUceKYWRaVVh+TM
 3XNw==
X-Gm-Message-State: APjAAAVEI57izH/jCWYccoWB8wa1XonJ/zbNTL0SCnT1oFQIgBQZhSoS
 9RB614AFrmABAQAEuMmzqb8L2dES
X-Google-Smtp-Source: APXvYqwZ+/izMfR8c1o0IvvKwrFbxVQCteQzc5xVR8sXdtquD81igLvAU3xULJCVWwKnjzu+WTK+zg==
X-Received: by 2002:a81:a007:: with SMTP id x7mr3501736ywg.415.1562880574496; 
 Thu, 11 Jul 2019 14:29:34 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id d7sm1740037ywh.14.2019.07.11.14.29.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 14:29:33 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
 <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
 <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>
 <68048912-a5f6-7885-4a5d-17957e3cb890@gmail.com>
 <c1afbb8a-3ece-e521-fdb3-1936cfc4e729@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8d0c72ae-47bd-506f-eada-d8faf20bf534@gmail.com>
Date: Thu, 11 Jul 2019 17:29:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1afbb8a-3ece-e521-fdb3-1936cfc4e729@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kiz2XC1he1YDHg7veROjwAoAnEIXO0AHb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
--kiz2XC1he1YDHg7veROjwAoAnEIXO0AHb
Content-Type: multipart/mixed; boundary="rrPHcoBtBmhMbBQ8MhVZDOgxJHbB5pBa0";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <8d0c72ae-47bd-506f-eada-d8faf20bf534@gmail.com>
Subject: Re: [RISU RFC PATCH v2 06/14] x86.risu: add MMX instructions
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
 <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
 <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>
 <68048912-a5f6-7885-4a5d-17957e3cb890@gmail.com>
 <c1afbb8a-3ece-e521-fdb3-1936cfc4e729@linaro.org>
In-Reply-To: <c1afbb8a-3ece-e521-fdb3-1936cfc4e729@linaro.org>

--rrPHcoBtBmhMbBQ8MhVZDOgxJHbB5pBa0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/11/19 9:57 AM, Richard Henderson wrote:
> On 7/11/19 3:29 PM, Jan Bobek wrote:
>> However, I downloaded a fresh copy of Intel SDM off the Intel website
>> this morning (just to make sure) and in Volume 2B, Section "4.3
>> Instructions (M-U)," page 4-208 titled "PADDB/PADDW/PADDD/PADDQ=E2=80=94=
Add
>> Packed Integers," there's the NP 0F D4 /r PADDQ mm, mm/m64 instruction=

>> in the 4th row, and the CPUID column says MMX. On the other hand, I
>> can't find it in the Volume 1, Section 5.4 "MMX(tm) Instructions," or
>> in Vol. 1, Chapter 9 "Programming with Intel(R) MMX(tm) Technology,"
>> so it's a bit confusing.
>>
>> If you know for a fact that it didn't come until SSE2 and the manual
>> is wrong, I will change it.
>=20
> Interesting.  I see what you see in
>=20
>   253665-069US January 2019
>=20
> but I first looked at
>=20
>   325462-058US April 2016
>=20
> which definitely has this marked as SSE2.
>=20
> In the 2019 version, "5.6.3 SSE2 128-Bit SIMD Integer Instructions" is =
the
> first mention of PADDQ.  Whereas "5.4.3 MMX Packed Arithmetic Instructi=
ons"
> mentions PADD{B,W,D} but not Q.
>=20
> I tend to think that this is a bug in the current manual.
>=20
> Checking in binutils I see
>=20
>> paddq, 2, 0x660fd4, None, 2, CpuSSE2, Modrm|No_bSuf|No_wSuf|No_lSuf|No=
_sSuf|No_qSuf|No_ldSuf, { RegXMM|Unspecified|BaseIndex, RegXMM }
>> paddq, 2, 0xfd4, None, 2, CpuSSE2, Modrm|IgnoreSize|No_bSuf|No_wSuf|No=
_lSuf|No_sSuf|No_qSuf|No_ldSuf|NoAVX, { Qword|Unspecified|BaseIndex|RegMM=
X, RegMMX }
>=20
> and both contain CpuSSE2. If you like, I could run this by one of the I=
ntel GCC
> folk to be sure.

I think this is convincing enough for me; it was a good idea to check
binutils! I find it interesting that they'd get it wrong in a more
recent version of the manual, though.

-Jan


--rrPHcoBtBmhMbBQ8MhVZDOgxJHbB5pBa0--

--kiz2XC1he1YDHg7veROjwAoAnEIXO0AHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0nqjgACgkQZeg2ldrj
Ns8r1Q/8DQs+7JAeps0DbahL0G1L9uclxi7I8PRoWzuUb/hJKPLwWDgh2NC9oORL
JJugnyF8iLC6NNNMczK7iWr5hOOPM5l7UzNBnpIS5sFWeVjiKUs3dzNn+ZT7GEP5
VV80C8FJlELQ1f+ReJN5tW1DhOQLQpnojZfTfU+NK+Tst0mML2/ho7qcVkpiLFxm
oHm31scppa4mQhPPEtzIyO2/yRwXgU8aNeNUHCeRhy8e4pn1Le7gagFnY3j43XMU
pNogv2peU8F9gKJeusnWG2KerrWZeBOGG9RCKaeg4s6gHbJZdtePpamgV5VSAkU1
Xlv2zWAhPA2CAkjoUud1mCya7LyV5+gZliEnirQyYHZI8L2kxdHKxI7tZPRX+6iY
XwRBXCtswVjipeCM/Ug/hcm2WHxjl+waAQQ8+NfKU9ZaaVlwwqrr0q0IWI6+sX5T
0hWS1gGdDdq9j2iB3PjBe5vUhW59rTVzNyDZbwVq1DHWXaWLtQrh6A/7voJf+g0V
+uvVmvYm3FMu/EvHYHeg1xvJ/0Z4N2LeCcZka0sd8/Cp63ScuQi7forr+oaFMQA0
21oYPjHphVE7St7WTCe58z4NR8vQAJcMSgbEfogETr/vBvArezcvCsN5u6Yolppb
EcDyoZzGwWkSCwa+1sg0a2y7u6NsChB6AXvFEUYY8zDrohwtmG8=
=2oxt
-----END PGP SIGNATURE-----

--kiz2XC1he1YDHg7veROjwAoAnEIXO0AHb--

