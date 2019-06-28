Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701A6205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjbe8ICU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701A6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsxa-0002zt-Nk
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hgsWb-0007N7-1C
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hgsWT-0001zl-92
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:10:47 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:42976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hgsWS-0001hz-Ii
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:10:44 -0400
Received: by mail-yb1-xb42.google.com with SMTP id f195so628838ybg.9
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=yzRGjp/x4MzEadYPBN3aUUOI1+xaVbfRSl++m8TgyT4=;
 b=Fjbe8ICUGdbIypDDT3dBEfX67lVjCPR1pYbs1bPccJIh1pw8+aQeIKDj+2uoDG95Kb
 un5wGY/Ux9OYDSFL44W44LiKJEhDphueVrEYgYLLzStiRCJYkBalDCgRWre9pHEtyAcP
 2zFqQ2Bt4Y3aXDzQbmNrhxxF+cCNDkI53SF1/19iFD+EmVeWh8+dmkPpV/OSU6SI+czr
 Ao6G+nvkA1kmro3swYLujCRoyQR62QbzBVGthNWOejYBcVweEoiGAfwTSmBlilvShp5L
 eEdVvYvzWwKnpTNyJ6MRotxMWMfPXfftfTMUZrsjdNsC2bxMmFmHDNvxQHGlxJuDs34R
 B1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=yzRGjp/x4MzEadYPBN3aUUOI1+xaVbfRSl++m8TgyT4=;
 b=VHH2vY6u/ckqkzlIe5U4lJydCYKjIatChyF6xnZIAwk3X9OLAOt54phaaD1WZ9PSWa
 /Q80ydS0KauYgdl5hUEOAhsdyg1XouFkZjqWBlsKEpRooncG0STkASZWTotR4XqcprTn
 hUgvpHQoFOzPeKYJAv60oJhIaLFOlhpIFm8EXqChZO4Qii1K5dS650Szn2NtURYs+BR5
 uWrwFstzuSE16LBo5vPEqNIGfKTdr95LVJCvwwP//iXf15zbMD+Hr3UYTW0mkUcwkTpR
 At3lrz4U3l6jHy+iw3WSmwO83YmaaWz+Fgg5E3QMcBUW+E8sunPracQxi821jQiuPq/o
 FIkA==
X-Gm-Message-State: APjAAAXZkZfQ3+ZpyvwYVIaZWMRVehlHfrBGYT5YBxCJgdncyrRCECRT
 qRUKNOz8w1T3X+yBQRq+q/4=
X-Google-Smtp-Source: APXvYqw/Yvm5pEO7tvdqbIaH6GhzzzBFbcUVd+FBH41SEBRphr5B/qE7uA7WriUPjkP8Qyfya90UWg==
X-Received: by 2002:a25:d244:: with SMTP id j65mr7170687ybg.172.1561734632428; 
 Fri, 28 Jun 2019 08:10:32 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id a201sm535865ywa.19.2019.06.28.08.10.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 08:10:31 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-2-jan.bobek@gmail.com>
 <ba5161d6-5c31-fe9e-5079-04550333776d@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <29d1496f-5688-0bbb-812e-088b04018159@gmail.com>
Date: Fri, 28 Jun 2019 11:10:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ba5161d6-5c31-fe9e-5079-04550333776d@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KHauQneNF14DUqZLllDylAunE8WZA14OJ"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 1/7] risugen_common: add insnv,
 randint_constr, rand_fill
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
--KHauQneNF14DUqZLllDylAunE8WZA14OJ
Content-Type: multipart/mixed; boundary="GTtskzxrAtP2RGW4bEdH8ylEVEfNVG1lI";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <29d1496f-5688-0bbb-812e-088b04018159@gmail.com>
Subject: Re: [RISU RFC PATCH v1 1/7] risugen_common: add insnv,
 randint_constr, rand_fill
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-2-jan.bobek@gmail.com>
 <ba5161d6-5c31-fe9e-5079-04550333776d@linaro.org>
In-Reply-To: <ba5161d6-5c31-fe9e-5079-04550333776d@linaro.org>

--GTtskzxrAtP2RGW4bEdH8ylEVEfNVG1lI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/27/19 4:53 AM, Richard Henderson wrote:
> On 6/19/19 7:04 AM, Jan Bobek wrote:
>> +        my $value =3D ($args{bigendian}
>> +                     ? ($args{value} >> (8 * $args{len} - $bitlen))
>> +                     : $args{value});
> ...
>> +        $args{value} >>=3D $bitlen unless $args{bigendian};
>=20
> I think this could be clearer without modifying $args.
> I mis-read these the first time around.
>=20
> Perhaps
>=20
>     my $bitpos =3D 0;
>     my $bitend =3D 8 * $args{len};
>     while ($bitpos < $bitend) {
>         ...
>         my $value =3D $args{value} >> ($args{bigendian}
>                                      ? $bitend - $bitpos - $bitlen
>                                      : $bitpos);
>         ...
>         $bitpos +=3D $bitlen;
>     }

Looks good, I'll change it.

>> +sub randint_constr(%)
>> +{
>> +    my (%args) =3D @_;
>> +    my $bitlen =3D $args{bitlen};
>> +    my $halfrange =3D 1 << ($bitlen - 1);
>> +
>> +    while (1) {
>> +        my $value =3D int(rand(2 * $halfrange));
>> +        $value -=3D $halfrange if defined $args{signed} && $args{sign=
ed};
>> +        $value &=3D ~$args{fixedbitmask} if defined $args{fixedbitmas=
k};
>> +        $value |=3D $args{fixedbits} if defined $args{fixedbits};
>> +
>> +        if (defined $args{constraint}) {
>> +            if (!($args{constraint} >> 63)) {
>> +                $value =3D $args{constraint};
>> +            } elsif ($value =3D=3D ~$args{constraint}) {
>> +                next;
>> +            }
>> +        }
>=20
> I don't understand what you're doing here with {constraint}.
> Some additional commentary would help.

The idea is: if the most significant bit of $args{constraint} is zero,
$args{constraint} is the value we want to return; if the most
significant bit is one, ~$args{constraint} (its bit inversion) is the
value we want to *avoid*, so we try again. This is used to to
implement constraints on fields such as

MOVLPS          SSE     00001111 0001001 d !emit { modrm(mod =3D> ~MOD_DI=
RECT); mem(size =3D> 8); }
MOVLHPS         SSE     00001111 00010110  !emit { modrm(mod =3D> MOD_DIR=
ECT); }

The bitshift by 63 assumes 64-bit integers, but that assumption is
present in other places, too. I couldn't think of a better way to do
it: comparing it to zero doesn't work because the value is unsigned.
I will include a comment explaining this in v2, unless you have
other suggestions.

-Jan


--GTtskzxrAtP2RGW4bEdH8ylEVEfNVG1lI--

--KHauQneNF14DUqZLllDylAunE8WZA14OJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0WLeMACgkQZeg2ldrj
Ns/k9Q//awCvL0mmwAbILTEletbkty7GbIggEOPmmeZfdF7jBjRnga3l55xNP//n
5DdA1xPLvjDP6yGulyXQwJHOlWxfNTN/M/AO49HENIW5oZjLRnhB7V3lQNg3s02Z
F7s9y2j+rU+Iav0rZqEw82FNO+KbpvMKGs2HHekCmC0v3NinSYi2UQcPcuVHJYUK
MHuK03gqs/KL5CPhq8Y8COAzbKVR7X2L2WTYUGHGYhWId4TlYRew8zh+V7PqpvDV
4Knu8dIzzc1PuV0EviSSr65xYVdBQwDS5HPNiG7YbUF+m5rJyb9tE7taX/T9iFNA
zjrkoiKZMDj/h/I/FaHGR0uinXAVDhEWki2bnwJ4apUlze7wqfgfXldEbu0beIyX
qLydjk2t2c9DfyxVx71w428oHg8itQnu5qqQnWMwhoQ2weU9K3tFZlEm2eW9Azzs
Gzz2xacfk1aLI7zZ92VQT9v1tMB2ggwXRlBBmmNbfo1OiWRRzsUyCHHcykANjzXH
yn1lG7ayTl/CCTukA7TNrKK5zsP0hWhxdk79JfttpvWxs4mcRloBWq6ARSGPJbFK
T4WyDj0rhx3lzOwMerZO8aPdu5nHVsEMI5MvKd/N5coa7j5xDRhlHG2viUK/afx8
b3Q08SbIJ/pBl7EWamwrdvJxL1OWRgApq3ek+TCjL6uuR2Ntyws=
=7Shd
-----END PGP SIGNATURE-----

--KHauQneNF14DUqZLllDylAunE8WZA14OJ--

