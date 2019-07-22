Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F2C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E572721901
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7zphFpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E572721901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZVc-0007me-7J
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hpZVP-0007Le-RH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hpZVO-0006Kn-MT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:41:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hpZVO-0006K8-7q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:41:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id a127so29728839oii.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=L2VpvMMWw/6wCugSR9VS1MDpnxBouyMXDeuaOtH7Fhw=;
 b=L7zphFppXrOe6OPq28NontilXT6rH8HFF41Ekz1Bfou5uEKmsVSa6/M+JyhYpwXCfL
 NlK14EhRmj/d5UBxzn3HTNMSTh8xogLSaTnypWbEbhgxth9Vts9Up6eJPiT+2Zt2Q40T
 MEB/FNNQWkBZfnRLKuEvMTn/bGTHl01w5AA8NJrH26jwBv+/b5prnVnXZ8MCy133F1Dm
 ouQS2jyj+oAVUzRFa8mun6A5igxRY0IuPRSIsOCBT+64IUHDgoUjQqwYVkwrn0f/EXDA
 A6ihtZ8+1tIqxfOjjvpIthqNIknTdaVdTN+D5Lmo4vjn8mdLYBtdGKluNsdbI66kl+ln
 itqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=L2VpvMMWw/6wCugSR9VS1MDpnxBouyMXDeuaOtH7Fhw=;
 b=AMOZfPHXDukrEQ7Ip7O53y5j6UG+Kx5ASdyT84LF6nKdloLf7a00yFXwrWoRnPu3x+
 QR+6zBmcTj2ug5/NJnpPffL575GEoOoyX43Ib9bIOZGP526UtLnLzlPHfF6goHWGqcYK
 3lL2cJeIjx85Grc+9eOFwi9rRQ0Ffri/gk8IdKLfh0aMdyIQdiF86ffM6jIfJ8ZSGuEb
 yenx09eZExMXzfBwn9oWryjVMOjHfY2kHmo94i1z5lsuWrjajrGjjrgpgdXeF6DwIdND
 A1MvYof/SapEg0kijbcS0RqD2D18R+YDse2IGr3DQb3GgtAco1zC5I6q0hV69n+Z1Z19
 S/kQ==
X-Gm-Message-State: APjAAAUY0RCSu0CPYsaNq76ynXo3A/VGRrY3tI7/8fF+krOLRrUcJGDR
 Wt8/vzp2H9Pr98tvTici5a0=
X-Google-Smtp-Source: APXvYqwIizO2BTKIWmDI2pRohXBcSAG4UGCcbd8CxpyCjgJejkjb/JCzvP332IsT5/GUFujAiY0tig==
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr31321466oib.146.1563806493186; 
 Mon, 22 Jul 2019 07:41:33 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id g73sm14406336otg.30.2019.07.22.07.41.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 07:41:32 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-19-jan.bobek@gmail.com>
 <06613847-8f5c-7b49-f074-31c8292900f1@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <957d9621-d4ed-ff99-fceb-f6d90f0f1398@gmail.com>
Date: Mon, 22 Jul 2019 10:41:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <06613847-8f5c-7b49-f074-31c8292900f1@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mM7LTOfoRPCIsrCnmfN3dDV2YOhi3W8u7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [RISU PATCH v3 18/18] x86.risu: add AVX2
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
--mM7LTOfoRPCIsrCnmfN3dDV2YOhi3W8u7
Content-Type: multipart/mixed; boundary="5XiFBLPAPKTfWfV94C8kdbyGgMW1CcaIn";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <957d9621-d4ed-ff99-fceb-f6d90f0f1398@gmail.com>
Subject: Re: [RISU PATCH v3 18/18] x86.risu: add AVX2 instructions
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-19-jan.bobek@gmail.com>
 <06613847-8f5c-7b49-f074-31c8292900f1@linaro.org>
In-Reply-To: <06613847-8f5c-7b49-f074-31c8292900f1@linaro.org>

--5XiFBLPAPKTfWfV94C8kdbyGgMW1CcaIn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/20/19 8:46 PM, Richard Henderson wrote:
> On 7/11/19 3:33 PM, Jan Bobek wrote:
>> +# VEX.256.0F.WIG 28 /r: VMOVAPS ymm1, ymm2/m256
>> +# VEX.256.0F.WIG 29 /r: VMOVAPS ymm2/m256, ymm1
>> +VMOVAPS AVX2 0010100 d \
>> +  !constraints { vex($_, m =3D> 0x0F, l =3D> 256, v =3D> 0); modrm($_=
); 1 } \
>> +  !memory { $d ? store(size =3D> 32, align =3D> 32) : load(size =3D> =
32, align =3D> 32); }
>=20
> I believe all of the floating-point 256-bit operations are actually AVX=
1.
> Which, I see, would annoyingly require a renaming, since that would put=
 two
> VMOVAPS insns into the same group.

Yeah.... and it is not just VMOVAPS, obviously.

> I wonder if it's worth calling the two groups AVX128 and AVX256 and ign=
ore the
> actual cpuid to which the insn is assigned?  Which ever way, they're st=
ill tied
> to the same --xstate value to indicate ymmh.

We could do that, but I think I like your idea below even better.

> Or could we fold the two insns together:
>=20
> VMOVAPS AVX 0010100 d \
> !constraints { vex($_, m =3D> 0x0F, v =3D> 0); modrm($_); 1 } \
> !memory { my $len =3D $_->{vex}{l} / 8; \
>           $d ? store(size =3D> $len, align =3D> $len) \
>              : load(size =3D> $len, align =3D> $len); }

This is a really interesting idea. If inability to differentiate
between the two is acceptable for us, then I think this approach might
be cleaner, more concise, and remove some redundancy.

-Jan


--5XiFBLPAPKTfWfV94C8kdbyGgMW1CcaIn--

--mM7LTOfoRPCIsrCnmfN3dDV2YOhi3W8u7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl01yxsACgkQZeg2ldrj
Ns88sBAAhj59r3kwfxF+vnEeU3u1Zy2Sm45z8uy3AClLR2nQgGJhE6YhDiLolij4
f1kVKraOWwq+wPw1SfYo50wSAQewAwP0bJ/MsX7lXJpK3zfSc4U6JNFRut3vA5ez
LyohM7zVSbwZLUNGPKQiZWHVr4WT6Eg4T6QhbWHev9FI+LScJwynirvvWvUH7LUm
4dpU1JqR+VTSZ/QNh2mSn8oNaDqhGYih1/RyKDy7gvQjiK9LEzjIHCCBe2GpB1yT
VtDMTQX96GSe5QBe75OayTlgKZ24h5JIN/GaIh53qrayI0hhZxlXK59/aeCN4alI
lbvLOHiMy3d8kXsLlMtnZRhC52ylN30VeBO9LOf/LX6wJDMfdfEAzesOWsHr/2JX
g1VWaVEEYZDGlPUOkY+fpPxg46A03yhUwgV6BkMXFMITxck1vlrrQ0dLaM7Z5V2Z
/UisLx1b8e7D+R5aoGo0eBJCXX/TN/ekCBUhP8yLsUefnTT0o6dRIDZmesNjFHSO
wVJ7g/EoEkLUZP72ESTsao+8oACmS71msMdd+4XI8S+iugYkF9kG+7me1rc0vIar
qsdBaJfN2amOspqoegLzaBpPCwqtdUgeMTdKCo6IrxA86ChvngkCcRFeJyGSbr/n
FmDjWklA84J+EeOOgmTcIUo5wSEWitWxp8J+FcmEcL4Dlbre02E=
=Dg5q
-----END PGP SIGNATURE-----

--mM7LTOfoRPCIsrCnmfN3dDV2YOhi3W8u7--

