Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AFCC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FC92083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY8nMoPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FC92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguOB-0006bP-Hi
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hguL8-0004g8-6a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hguL4-0005rG-2k
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:07:10 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:32837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hguL3-0005o9-M1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:07:06 -0400
Received: by mail-yb1-xb43.google.com with SMTP id n3so4194486ybn.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=r3HPUv8T3E0JI1jq16cK8/xUXNkcLDspC3lKV3Q3xkg=;
 b=hY8nMoPaBfrCYkQ5BKoC6zzf8f4V5qmNFthmvlM1tRRSUi6h7uZ5ShTd44MzIC3CjA
 aR9QrbKMRPxL3kNE859I/bxA2dJjaW4Q+rw8wGj71iKp5cqKLNMw1EuR72cjdAKwC9K4
 3eZl92nUnid2cScs6DKsJ6lSaHiPez1G9zt54v4fSfuBDflE8xLuRKV1ekQWufQazos8
 UfT0zYo4lln3xgaOG63kyipPVPlNhqhDR7crR6CJRVby2LMbCduX8sB30JVoHuneSWNJ
 bPKcLAmElvRCBPNWy+SIcoKNn2nMIOa5/L0b48KeLLqRYlJhoWBkUgpBF8JPoCVdY/ox
 yGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=r3HPUv8T3E0JI1jq16cK8/xUXNkcLDspC3lKV3Q3xkg=;
 b=n3zUexTkIjz7K4gPcTRoUDAfvhVvtBNzfOlp7bo5u/4hDwsVkPjTAKLhYpUXM11fV5
 6ObcnhbkEgLrJRYM+RUAFv2ryUn1WFJ3/REY8yLa1pYy0TocDxgxxIOYB1zYSRJutYBC
 MYs9PrpAdri5OLYJhISz8k+FAj8DvE4952Jh83myPyLbHwJ40ZlHyKLFXh4/mx/zMzbG
 RSvL7z84twLANy3SbnawEj22N35KPvHm/os6yps8oo4V2TC+lhWiHk1XzUETu6b+oyJ+
 v6uXEuGPxzRJSDuFhJ4qdNiD5U0tRI1sjRCJJ7UJ1I0gH/Hd75wigc/Jk/o1az4nNCq6
 pKPQ==
X-Gm-Message-State: APjAAAXAim/kf8AoOxlMOcQxavqGcsj03Xe0e6+SuBQqzlubE1EGoybT
 gWgRooWPZRLcBQt6Mwvt5z7DR1yn
X-Google-Smtp-Source: APXvYqwNLvQfvYfX9fM4apn4h5MObVjHx9z0RRYqCDEzPyb+eakP0HMQuH0UzqlxWEhSRhCukqhp4w==
X-Received: by 2002:a5b:c4c:: with SMTP id d12mr6743727ybr.250.1561741624850; 
 Fri, 28 Jun 2019 10:07:04 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id g189sm630672ywa.20.2019.06.28.10.07.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 10:07:04 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-5-jan.bobek@gmail.com>
 <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <58987aa3-7b8b-0ef7-741a-2c0b79943fe7@gmail.com>
Date: Fri, 28 Jun 2019 13:06:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GId72CIIiHeQQ7rIFVv6QTwYZjDgvSWz1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 4/7] risugen_x86: add module
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
--GId72CIIiHeQQ7rIFVv6QTwYZjDgvSWz1
Content-Type: multipart/mixed; boundary="SUIahnYMtyLkqltckQBFxtydR7OH6tHaY";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <58987aa3-7b8b-0ef7-741a-2c0b79943fe7@gmail.com>
Subject: Re: [RISU RFC PATCH v1 4/7] risugen_x86: add module
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-5-jan.bobek@gmail.com>
 <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
In-Reply-To: <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>

--SUIahnYMtyLkqltckQBFxtydR7OH6tHaY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/27/19 6:29 AM, Richard Henderson wrote:
> On 6/19/19 7:04 AM, Jan Bobek wrote:
>> +sub write_mov_reg_imm($$)
>> +{
>> +    my ($reg, $imm) =3D @_;
>> +
>> +    my %insn =3D (opcode =3D> {value =3D> 0xB8 | ($reg & 0x7), len =3D=
> 1},
>> +                imm =3D> {value =3D> $imm, len =3D> $is_x86_64 ? 8 : =
4});
>> +
>> +    $insn{rex}{w} =3D 1 if $is_x86_64;
>> +    $insn{rex}{b} =3D 1 if $reg >=3D 8;
>> +
>> +    write_insn(%insn);
>> +}
>=20
> There are 3 different insns that x86_64 can use for different ranges of=

> immediates; you are always using the full 10 byte version.
>=20
> Using 0xb8 without REX.W may be used for any unsigned 32-bit value.
> Using 0xc7 with REX.W may be used for any signed 32-bit value.
> Using 0xb8 with REX.W of course allows any 64-bit value.
>=20
> It's not terribly important, but the code size does get large.

Funnily enough, the very first version of this function did try to
save bytes by using different instructions, but when I started writing
write_mem_getoffset, I ran into trouble with signedness. In response,
I hard-coded the 10 byte version for debugging and then never switched
it back.

I'll try to do something about this in v2.

>> +sub rand_insn_modrm($$)
>> +{
>> +    my ($opts, $insn) =3D @_;
>> +    my $modrm;
>> +
>> +    while (1) {
>> +        $modrm =3D rand_fill({mod =3D> {bitlen =3D> 2},
>> +                            reg =3D> {bitlen =3D> 3},
>> +                            rm =3D> {bitlen =3D> 3}},
>> +                           $opts);
>> +
>> +        if ($modrm->{mod} !=3D MOD_DIRECT) {
>> +            # Displacement only; we cannot use this since we
>> +            # don't know absolute address of the memblock.
>> +            next if $modrm->{mod} =3D=3D MOD_INDIRECT && $modrm->{rm}=
 =3D=3D REG_EBP;
> ...
>> +sub rand_insn_rex($$)
>> +{
>> +    my ($opts, $insn) =3D @_;
>> +
>> +    $opts->{w} =3D 0 unless defined $opts->{w};
>> +    $opts->{x} =3D 0 unless defined $opts->{x} || defined $insn->{sib=
};
>> +
>> +    my $rex =3D rand_fill({w =3D> {bitlen =3D> 1},
>> +                         r =3D> {bitlen =3D> 1},
>> +                         b =3D> {bitlen =3D> 1},
>> +                         x =3D> {bitlen =3D> 1}},
>> +                        $opts);
>=20
> I don't think it's a good idea to generate reg/rm/sib.index separate fr=
om
> rex.r/b/x.  In particular, all of your tests vs EBP and ESP are not qui=
te
> right, since the final insn may be referencing R12 or R13.

That's true. (Although not in all cases; see Table 2-5 in the Intel Manua=
l,
Volume 2, Chapter 2, Section 2.2.1 "REX Prefixes" for some cases when REX=
=2EB
is not decoded.) This is a compromise that I've accepted, at least for v1=

of the patch series. Note that this problem is also present in config ent=
ries
such as

PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod =3D> MOD_DIRE=
CT, reg =3D> ~REG_ESP); }

Here, we force MODRM.REG !=3D 4, but this avoids not only ESP/RSP, but
also R12.

Hmmm... I suppose I have some ideas on how to do it better. I'll try
to fix this, though I suspect getting it 100 % right might be
difficult and time-consuming.

> What is your plan for handling the unary insns for which modrm.r is opc=
ode and
> not a register?  This doesn't seem to allow for those.  How about insns=
 for
> which modrm.mod must be 3 (register) or must be !=3D 3 (memory/address)=
?

Both of these translate to forcing or avoiding a certain value in a field=
,
which is handled by the $opts argument to rand_fill; I mention this in my=

email about the first patch in this series.

> Is this
> simply going to fall into "testing of illegal encodings"?

Speaking of testing of illegal encodings, it occurred to me that it
might be quite hard: since x86 uses variable-length encoding, you
cannot tell how many bytes should be skipped if an invalid instruction
is encountered.

Perhaps we could use a multi-byte NOP with the length embedded in some
of the ignored fields? We could then teach RISU to look at the
preceding instruction and skip the correct number of bytes when
appropriate. Do you think it would be worth the effort? RISU currently
doesn't seem to support this use-case, but it should be
straightforward to implement: just add a record to the trace file
that the instruction generates a SIGILL.

-Jan


--SUIahnYMtyLkqltckQBFxtydR7OH6tHaY--

--GId72CIIiHeQQ7rIFVv6QTwYZjDgvSWz1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0WSTIACgkQZeg2ldrj
Ns+X9xAArqiYVm6LvCsC1eaD/LshCtUowUWJKDSiBOsCZmjc1D9iOOUpzxTzDfOJ
nR1ZUmRLtqVyc/B7TSjNNWfhAYFtXGnVwhtz63iClm7X0tQSWzY0pYh9V4E6+yj2
rGL3MXKrs0rembHTXzPD9doaQr4USHMX4jHoTzTtDb+7PmDzp33roH/IK4UpKhM8
q6zJP5cNRQso56cOBaDKj5Qz23Hq5I2OQiamRebG+16QKb6E8I0PoLOb5Ez7GKJR
mC4zEQWir5pXAHt0UhWwzwT5CTYDnt8pY1tNmtzF8j6snreadJSFY40D6c9RDqEv
q7m+5Dh9GuyZSrQSEa+eeCny3V3RQKPs/jU0vFsTOzo19lB1hWBidRIm+EHRjAek
of+n+yjco46xoK/BCSy2TOPercF4MjOBXEyBGyRIyV6KcBWgMMOinGSxO959+SNp
MGc1W42kL2QY6reU/IO2+rIKns6kK54feF9oCpcH45coGyZIVAyIhulTxYmhPw7n
RPFGmNvl4WPPUKyuOxuXfXCBNyVf5r8YmlTcLiggzchhPY0NurmlU3Z7AZmlMAH1
euiZ7cW+xim0FYQNmkNzdatXdIap66JshL/+471xy7DP+yCEpA5I6OGV+Eivhpf3
Gb9S2HDC7F8Npmo9z2H/ErV+JjD65dCPHK0+zUUT2guSyF/8AIw=
=yi0W
-----END PGP SIGNATURE-----

--GId72CIIiHeQQ7rIFVv6QTwYZjDgvSWz1--

