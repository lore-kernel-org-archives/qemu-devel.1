Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F7C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C3D20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJl3EWlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlHRy-0008Q6-5R
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 14:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlHLm-0001Ia-P5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlHLk-0008OF-T9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:29:54 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:34818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlHLk-0008JA-88
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:29:52 -0400
Received: by mail-yw1-xc42.google.com with SMTP id g19so509632ywe.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=fBjvpYZGNbPKygli6Lf6Pnl/DrEp9p519Jo0EJHWGFI=;
 b=mJl3EWlMFBWU3IgzoPmqg7Li76zvMQaMY7qy6LXnd3qO97T90YJF0GolLjkQqiUMQ2
 7Z6j+OeAFKhs5E6KEMDJeKYTeO8jrCJK2JKf8MNpHVTWi1WoJIsI3uL74JmlWXerPdhm
 RmS3JwQDeGNDRZkLyHG/3LfPYXYS8gMhh8TLi3cL9l0vRqTNlYIumd/qNRoJH117BLu3
 vHDBj8orywnk66WH5HMNSc2V5TzDvuACJdznc7BRE/mQ0LvxI2iAg994pmMJZTTKA0xi
 nMv2oscbz/2BwImLMgVsR993RDlrOxSJS4Nm57qmAM2fdBSEpcYlir6uwBdFio0SWjVA
 ZQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=fBjvpYZGNbPKygli6Lf6Pnl/DrEp9p519Jo0EJHWGFI=;
 b=fAaoAfcK4HY4u/MDRDqZN62Zgu/PZOfweoUaaiSBjYNmhQXrKbaYI5B/PZookdsAER
 lN5ZyN4Y/tIL8G9mgQH7G07qGeZp9+BG/y2hEhY8jfJplpQWo9eQ/YEaAjaA31kh8dJ0
 6pJBYwfb8GZfUhH72BW8IfEOz+6+PJssDdzXP4RFOC1+WC5paxRnrt81zxFsmUTlEp8D
 1YgtnwfeFFr/bSGXrFa1gr/rX7W43i/ladhv740p6/vdJ8t9rAyTTm1QSby9uj+sEAu/
 4X8MXvz7gArrJTevw4IUxldkMsGhBOS/wbIIcCLXMexQVz5KOuJXvEe+f3RlEgQHVru2
 a2BA==
X-Gm-Message-State: APjAAAUonaxvO4Q2sVXundSqZCP3b/aXPq6Ky6vai6fecPobyWUqYc3n
 4nRBz09BgRR3qlB3OO8k9KoyQu0x
X-Google-Smtp-Source: APXvYqwly12XSPmwZogMW77MA6o3ttv1w6ZciW2q0g5Zsr5aE2nblKva9mYzdRaX5moUuO3BL8SuqA==
X-Received: by 2002:a81:98f:: with SMTP id 137mr2555880ywj.293.1562783387633; 
 Wed, 10 Jul 2019 11:29:47 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id j207sm732093ywj.35.2019.07.10.11.29.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 11:29:46 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
Date: Wed, 10 Jul 2019 14:29:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Qm1Rvmi8GMqFkYkVgzA9iNPytYfrfbe31"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
--Qm1Rvmi8GMqFkYkVgzA9iNPytYfrfbe31
Content-Type: multipart/mixed; boundary="JgRVLrAwuk0XBb227GqgkRM5ZIegTPwuf";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
Subject: Re: [RISU RFC PATCH v2 06/14] x86.risu: add MMX instructions
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
In-Reply-To: <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>

--JgRVLrAwuk0XBb227GqgkRM5ZIegTPwuf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 5:35 PM, Richard Henderson wrote:
> On 7/1/19 6:35 AM, Jan Bobek wrote:
>> Add an x86 configuration file with all MMX instructions.
>>
>> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
>> ---
>>  x86.risu | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 96 insertions(+)
>>  create mode 100644 x86.risu
>=20
> Note that most of these MMX instructions affect the FPU, not the vector=
 unit.
> We would want to extend risu again to handle this.  You'd also need to =
seed the
> FPU with random data.
>=20
> I was thinking for a moment that this is really beyond what you've sign=
ed up
> for, but on second thoughts it's not.  Decoding SSE is really tangled w=
ith
> decoding MMX, via the 0x66 prefix, and you'll want to be able to verify=
 that
> you don't regress.

Honestly, I added MMX instructions just for completeness; I figured it ca=
n't
hurt, and you can always filter them out via command-line switches. You h=
ave
a point with the regression testing, though...

>> +# State Management Instructions
>> +EMMS            MMX     00001111 01110111 !emit { }
>=20
> I'm not sure this is really testable, because of the state change.  But=
 we'll
> see what happens with the aforementioned dumping.
>=20
>> +# Arithmetic Instructions
>> +PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size =3D=
> 8); }
>> +PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size =3D=
> 8); }
>> +PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size =3D=
> 8); }
>> +PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size =3D=
> 8); }

Not this one, at least according to the Intel docs:

NP 0F D4 /r: PADDQ mm, mm/m64          (MMX)
66 0F D4 /r: PADDQ xmm1, xmm2/m128     (SSE2)

The SSE2 version is added in a later patch.

-Jan


--JgRVLrAwuk0XBb227GqgkRM5ZIegTPwuf--

--Qm1Rvmi8GMqFkYkVgzA9iNPytYfrfbe31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0mLpkACgkQZeg2ldrj
Ns8boxAAl34YFZWb8N4kJsigV+CKIDb4VjqUqvNVpOu/AsU1s/i8TzMyWqCy6LJA
FfaZQNRv6LJp86HWLAcMyIgFG4CkurfBvnP8ztrBSIVILDoX2RfLE9SKm++FIaBd
zhp8olGX4X5Re+gDUqS8lVsctekpJ11Sbha1Minw9bwt+gqmIJIR+vlLnzc/GqMx
vFENxZYJxYgluI2gUpR+rmhzbfwtyRYVgA2mCCQBZMx/MYSPQEIc66igZyl2BgQV
Um+c0UcODLhxTjhG5HL05/5NsjV+MvuS170vZWwpvRkplFUqw8Rw/5HX3z220FS3
skN3CBkCEYX9kv1AVSTgxWEf6yWXM0MtMqzJN2Y69GEQJsLXRCyZWewBBlnCiZMf
Wtzhotqif6xaz4koQEUk1P60pjtA6cVRLbNRqA/ahX/xyc+td9AfkRu6BaiNkR1K
i846+T9iEfMXxq2fP2U3e1LIdRV/U+ZdlCc7xSc63SMAR2ZG6NJNo/7nOgbFEwB3
jswfGmvpCW6lhevmmwXaXH91UPE5psSdRAZ+ZY2UWyCznbxFJiNurkhlD63gbXlX
fZUyRXGSQK4ZCcTtk5Ht/s5CjAKGAN/ugGg4iYS5TAg3shs/eeDvHmFgRa47nOK4
ifipA7LCJ2KNsoD2iW52zhD94WRXvujZ5eVNwyiznhEZIOz9Rmg=
=m1Gf
-----END PGP SIGNATURE-----

--Qm1Rvmi8GMqFkYkVgzA9iNPytYfrfbe31--

