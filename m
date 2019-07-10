Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2FC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEECE2087F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOF7SWt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEECE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlHFg-0008AA-5s
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 14:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlHE1-0007Di-FO
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlHDz-0007Nz-NE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:21:53 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:42413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlHDx-00073J-HD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:21:50 -0400
Received: by mail-yw1-xc42.google.com with SMTP id z63so1117185ywz.9
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=+LCa7+GAIStpkto14rVMizm4jH0+UBARe5ZhsUTnCIA=;
 b=KOF7SWt4olRglV6dAKmN8xKFl6IC8H/6wbUXvNHWWA+Ra2TEBS8EMMIJGeW1EJV9Qb
 0CU4F7VTiJBJgEAuIlMBbbFaoGstfr2HiCZWMxqH52Pz4wJdFsusQq39yq5jKZxstOJX
 SMqFqePOCw3QyIMme1Dkm+rtoq5ytXhsa0JJxJcnykK5gsla9+l+Lxvy9xec6i7O1eJS
 DUpLrD+S4Wni5RM3wFx/if5ap5M7FG/8j2ftzUh4zKvTvFU1ixIcWeMHXOv3p1LaUp/u
 isrI8EB0MP7faJdKuzvJRiMYcQV7TzFKa7AXrLFnxwM6Nzk2BJvA0UOomaDXcdY1T7zR
 gVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=+LCa7+GAIStpkto14rVMizm4jH0+UBARe5ZhsUTnCIA=;
 b=Na/yEUnSQAUj8DEWbZZaqrUkeKyYEGUVtvWf5nJjVXnE1PwPNwfqLy1NkXGWNOpfkc
 1UFKN7OFz3+XqUtW09FtQcaPkR9b+FU1B3ctSJ3v99ntyrc5G2F3NuIxhS6zXhD5gq42
 QUByE+FUtnmU3JAE/gimVZ1Vc5u8wxrQz0XjW5AT2SQdE+mLvi8MAIoez4P1tkhY+JsB
 m9Qg3bsGBz/DEcYe1h37SvWAIAytn7IleyvL2KwhrTq14NCgn2sgfYg4+Aev22J9H/Zy
 jhH7XXJdiRPSWCCecVwBZBEfCRVTt+2FMtbSMRhwBgrP74yg7b//WNQNElc/PhB/MXAe
 SZGg==
X-Gm-Message-State: APjAAAU6IgPO3DnmooAzUqUzxRwQDHZ6V4tYubBdEucY8nC2UrwcP9WT
 VaRarTR4BFJvSKaZeHEONoI=
X-Google-Smtp-Source: APXvYqyMTft9nG/BU8ND+HCkRylI5mtfR5UNhdVmyb52olSs4O46thea2FiHi74019WP96yl98Uetg==
X-Received: by 2002:a81:92d1:: with SMTP id
 j200mr19940558ywg.497.1562782893303; 
 Wed, 10 Jul 2019 11:21:33 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id 200sm740660ywq.102.2019.07.10.11.21.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 11:21:32 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-5-jan.bobek@gmail.com>
 <67fbe51c-ab7c-11e9-ecbc-aa72ff430911@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5260d896-37e3-e6f0-1ed4-b5d09bf9fbcd@gmail.com>
Date: Wed, 10 Jul 2019 14:21:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <67fbe51c-ab7c-11e9-ecbc-aa72ff430911@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rIRX2k0kxhmz2gCo0RJ0YrNbjqHDWYd7w"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 04/14] risugen_x86: add module
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
--rIRX2k0kxhmz2gCo0RJ0YrNbjqHDWYd7w
Content-Type: multipart/mixed; boundary="hNMYSFAknIMTKxyOANuUS461wRwp9KDoX";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <5260d896-37e3-e6f0-1ed4-b5d09bf9fbcd@gmail.com>
Subject: Re: [RISU RFC PATCH v2 04/14] risugen_x86: add module
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-5-jan.bobek@gmail.com>
 <67fbe51c-ab7c-11e9-ecbc-aa72ff430911@linaro.org>
In-Reply-To: <67fbe51c-ab7c-11e9-ecbc-aa72ff430911@linaro.org>

--hNMYSFAknIMTKxyOANuUS461wRwp9KDoX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 12:11 PM, Richard Henderson wrote:
> On 7/1/19 6:35 AM, Jan Bobek wrote:
>> +sub write_mov_rr($$)
>> +{
>> +    my ($r1, $r2) =3D @_;
>> +
>> +    my %insn =3D (opcode =3D> X86OP_MOV,
>> +                modrm =3D> {mod =3D> MOD_DIRECT,
>> +                          reg =3D> ($r1 & 0x7),
>> +                          rm =3D> ($r2 & 0x7)});
>> +
>> +    $insn{rex}{w} =3D 1 if $is_x86_64;
>> +    $insn{rex}{r} =3D 1 if $r1 >=3D 8;
>> +    $insn{rex}{b} =3D 1 if $r2 >=3D 8;
>=20
> This is where maybe it's better to leave rex.[rb] to risugen_x86_asm, a=
nd just
> leave $modrm{reg} and $modrm{rm} as 4-bit quantities.

That's what I have in v3, stay tuned!

>> +sub write_mov_reg_imm($$)
>> +{
>> +    my ($reg, $imm) =3D @_;
>> +    my %insn;
>> +
>> +    if (0 <=3D $imm && $imm <=3D 0xffffffff) {
>=20
> Should include !$is_x86_64 here,
>=20
>> +        %insn =3D (opcode =3D> {value =3D> 0xB8 | ($reg & 0x7), len =3D=
> 1},
>> +                 imm =3D> {value =3D> $imm, len =3D> 4});
>> +    } elsif (-0x80000000 <=3D $imm && $imm <=3D 0x7fffffff) {
>> +        %insn =3D (opcode =3D> {value =3D> 0xC7, len =3D> 1},
>> +                 modrm =3D> {mod =3D> MOD_DIRECT,
>> +                           reg =3D> 0, rm =3D> ($reg & 0x7)},
>> +                 imm =3D> {value =3D> $imm, len =3D> 4});
>> +
>> +        $insn{rex}{w} =3D 1 if $is_x86_64;
>=20
> making this unconditional.

Doesn't B8 (without REX.W) work for x86_64, too? It zeroes the upper
part of the destination, so it's effectively zero-extending, and it's
one byte shorter than C7 (no ModR/M byte needed).

That being said, I moved most of this function to risugen_x86_asm and
included a bunch of comments regarding different cases, so it should
be easier to understand.

>> +sub write_random_ymmdata()
>> +{
>> +    my $ymm_cnt =3D $is_x86_64 ? 16 : 8;
>> +    my $ymm_len =3D 32;
>> +    my $datalen =3D $ymm_cnt * $ymm_len;
>> +
>> +    # Generate random data blob
>> +    write_random_datablock($datalen);
>> +
>> +    # Load the random data into YMM regs.
>> +    for (my $ymm_reg =3D 0; $ymm_reg < $ymm_cnt; $ymm_reg++) {
>> +        write_insn(vex =3D> {l =3D> VEX_L_256, p =3D> VEX_P_DATA16,
>> +                           r =3D> !($ymm_reg >=3D 8)},
>=20
> Again, vex.r should be handled in vex_encode.

As I said, there will be more high-level instruction-assembling
functions exported by risugen_x86_asm in v3, which take care of this.

>> +                   opcode =3D> X86OP_VMOVAPS,
>> +                   modrm =3D> {mod =3D> MOD_INDIRECT_DISP32,
>> +                             reg =3D> ($ymm_reg & 0x7),
>> +                             rm =3D> REG_EAX},
>> +                   disp =3D> {value =3D> $ymm_reg * $ymm_len,
>> +                            len =3D> 4});
>> +    }
>=20
> So... this now generates code that cannot run without AVX2.
>=20
> Which is probably fine for testing right now, since we do
> want to be able to notice effects of SSE/AVX insns on the
> high bits of the registers.
>=20
> But we'll probably need to have the same --xsave=3Dfoo
> command-line option that we have for risu itself.
>=20
> That would let you initialize only 16-bytes here, or
> for avx512 initialize 64-bytes, plus the k-registers.

Ah yes, indeed.

-Jan


--hNMYSFAknIMTKxyOANuUS461wRwp9KDoX--

--rIRX2k0kxhmz2gCo0RJ0YrNbjqHDWYd7w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0mLKsACgkQZeg2ldrj
Ns+4dg//VmVzK8vFWAxJcT6xHoUmMRQvPKDmO9h0uRqVnmQDM9AoPTc8Kk0fPKB5
gprFz1nmOAoOX3A2DHuh7o9KrCTZRM6RNCzXWI/9g+k2DswQpBxHmmDJZnXM9/45
CNRXv8RswzKLCqDgOEpEcZlQGXn5elOcmYb+O4otZyW/aHIt1x4baC/R/+mfnulG
OHJyA96K5YftYgX/k7YLAHAyBZKHM4PFUCNYkazo/dklZ68O62E9KSDJsst6q48p
BOdxlvhRCbsTntGWZU4ZBJJl2I48bfiJPoR/UWbDzg0vlTDvYnQr+xYKdQ31jHDf
j0xSLXaKo0V6y2VJyi8JBboUjzIbkLA2wTTEuGXcIPOEF8HGGK5kMx+iugWdMFEJ
4/Qg5SikJA5ljOGqfbKtgC6Xvbokbb+YmOYuFT0Qb82mQgj75R0HmHtYZf7O5vKM
2ab8NcprT4zL2UHaRiY9quIXV3IBDdIZoWvCbNdPv3zOzq1chJGHUjM98mqBKN+6
F+7/iLYFeYyBwgm2UJXOTnr4KsoN8imLtTICK7aBhFIh/0hfBcRNKNYvb8VciyvR
cQ9+d06cUU9us5XTbSzHbPH0FasK8Sa+RHsNoCRBE3dRVf7hHXrfucplWR849AlK
+1cgcTW6FfD2PpyMrPD+BrrmS/EQia8heutdlS5UTA07Kh1pKrM=
=x168
-----END PGP SIGNATURE-----

--rIRX2k0kxhmz2gCo0RJ0YrNbjqHDWYd7w--

