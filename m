Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971DC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 23:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4447C2063F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 23:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx0OAMn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4447C2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmnbZ-0001ko-4P
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 19:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57377)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hmnbN-0001Ma-Er
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 19:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hmnbM-0000Pq-1y
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 19:08:17 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:40297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hmnbL-0000PZ-Re
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 19:08:15 -0400
Received: by mail-yw1-xc42.google.com with SMTP id b143so6781514ywb.7
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=1rwGxMv3Uy1a23u5aB89aSw0kGSZ2JwR20qoI8tj9bw=;
 b=Rx0OAMn+zTLoiAb5Ezssi3a+s11j4B6giGCPQR/bRlmV0XNXsD6x9IYqVj4NgDEUUf
 JXf9N7cSEjOPjT1/GtlaybYZxcqFYaS0Yo+wXSihuhzPI3L0ozWbmmzMgaQQWNJAVY6u
 HYInzs2nQgdTjmkTV/ozR7eAqxVFigeCIoOBlVGlqqlCkzct2/Q6sFAp7tuOYSDCcD9e
 39cemAHax9cWvpLYGwIGFsajz7IxuCT2r94LQ9TRrIVCu9UD4PrhiQibvWuGAgwu+yzV
 Qcj0Aw7oM3lhujw+Sfj0lGUqiknZdKuSjKNBj5AOBOcxjhS/61HV6mQ83i/M13w2rCse
 VI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=1rwGxMv3Uy1a23u5aB89aSw0kGSZ2JwR20qoI8tj9bw=;
 b=s2d/O1Cka6XTAt4b+K2lk1wac81jUlXM9weZ3+mtrL3C/FPCT/Os4huRkWYMdOTkW8
 4ruhklsa99kOl8yof0jB2VE49bvy7arPNj2wJxPWo5ZkbE0RPmfjJB0f4nw8nQGaSOtI
 e2QktNF/yz+7lh/mjgtEqno3YDZCbMsqZNgvUF4NhrKmDTzuxwlBYIbYmIlpqd6n+NaA
 9uI/iqI4KDBZRpyzSlmoZlmpvpeywb3rwslPji5gfo5//TlTR3NH2u8rQkvkfmRPIg4L
 tQbHWpItFQvTMpEhyV44RpCcc3hAlpmEHWScwT9WAA3Zxkgr6hPwtlFVHSC8Pyf83NkT
 OayQ==
X-Gm-Message-State: APjAAAX4vxdP3/E8LUek66Tj21dOLBq9WXd1nj44N+L5KjBc0rbdGX+/
 DgqxbW+G0cIGhIR8Bjp4S4A=
X-Google-Smtp-Source: APXvYqxFU1evU1A68/+TuWuMs91C2N/zECHeHkZJNk8m+0OGmJM2On5zZDMAltX58ZuNC1dPU8XuhQ==
X-Received: by 2002:a81:6dd6:: with SMTP id
 i205mr13581868ywc.180.1563145695163; 
 Sun, 14 Jul 2019 16:08:15 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id p17sm4012786ywp.96.2019.07.14.16.08.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 16:08:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <87zhljcr6c.fsf@zen.linaroharston>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <71f1ca40-9457-62c1-f585-6b3d6c523e3c@gmail.com>
Date: Sun, 14 Jul 2019 19:08:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87zhljcr6c.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0PrpGAL7MZYSmX4YK2J4W2xapL7SExsNw"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: Re: [Qemu-devel] [RISU PATCH v3 00/18] Support for generating x86
 SIMD test images
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0PrpGAL7MZYSmX4YK2J4W2xapL7SExsNw
Content-Type: multipart/mixed; boundary="jRX551ZtVzohgh9zonSQAbqdElnmYwR0P";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Message-ID: <71f1ca40-9457-62c1-f585-6b3d6c523e3c@gmail.com>
Subject: Re: [RISU PATCH v3 00/18] Support for generating x86 SIMD test images
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <87zhljcr6c.fsf@zen.linaroharston>
In-Reply-To: <87zhljcr6c.fsf@zen.linaroharston>

--jRX551ZtVzohgh9zonSQAbqdElnmYwR0P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/12/19 9:34 AM, Alex Benn=C3=A9e wrote:
>=20
> Jan Bobek <jan.bobek@gmail.com> writes:
>=20
>> This is v3 of the patch series posted in [1] and [2]. Note that this
>> is the first fully-featured patch series implementing all desired
>> functionality, including (V)LDMXCSR and VSIB-based instructions like
>> VGATHER*.
>>
>> While implementing the last bits required in order to support VGATHERx=

>> instructions, I ran into problems which required a larger redesign;
>> namely, there are no more !emit blocks as their functionality is now
>> implemented in regular !constraints blocks. Also, memory constraints
>> are specified in !memory blocks, similarly to other architectures.
>>
>> I tested these changes on my machine; both master and slave modes work=

>> in both 32-bit and 64-bit modes.
>=20
> Two things I've noticed:
>=20
>   ./contrib/generate_all.sh -n 1 x86.risu testcases.x86
>=20
> takes a very long time. I wonder if this is a consequence of constantly=

> needing to re-query the random number generator?

I believe so. While other architectures can be as cheap as a single rand(=
)
call per instruction, x86 does more like 5-10.

Even worse, there are some instructions which cannot be generated in
32-bit mode (those requiring REX.W prefix, e.g. MMX MOVQ). When I let
the script run for a little bit, risugen would get stuck in an
infinite loop, because it could only choose from a single instruction
which wasn't valid for 32-bit....

> The other is:
>=20
>   set -x RISU ./build/i686-linux-gnu/risu
>   ./contrib/record_traces.sh testcases.x86/*.risu.bin
>=20
> fails on the first trace when validating the playback. Might want to
> check why that is.

The SIMD registers aren't getting initialized; both master and
apprentice need an --xfeatures=3DXXX parameter for that. Right now the
default is 'none'; unless the instructions are filtered, you'd need
--xfeatures=3Davx (or --xfeatures=3Dsse, and that only works because on m=
y
laptop, the upper part of ymm registers seems to be always zeroed when
risu starts).

>>
>> Cheers,
>>  -Jan
>>
>> Changes since v2:
>>   Too many to be listed individually; this patch series might be
>>   better reviewed on its own.
>>
>> References:
>>   1. https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg04123=
=2Ehtml
>>   2. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00001=
=2Ehtml
>>
>> Jan Bobek (18):
>>   risugen_common: add helper functions insnv, randint
>>   risugen_common: split eval_with_fields into extract_fields and
>>     eval_block
>>   risugen_x86_asm: add module
>>   risugen_x86_constraints: add module
>>   risugen_x86_memory: add module
>>   risugen_x86: add module
>>   risugen: allow all byte-aligned instructions
>>   risugen: add command-line flag --x86_64
>>   risugen: add --xfeatures option for x86
>>   x86.risu: add MMX instructions
>>   x86.risu: add SSE instructions
>>   x86.risu: add SSE2 instructions
>>   x86.risu: add SSE3 instructions
>>   x86.risu: add SSSE3 instructions
>>   x86.risu: add SSE4.1 and SSE4.2 instructions
>>   x86.risu: add AES and PCLMULQDQ instructions
>>   x86.risu: add AVX instructions
>>   x86.risu: add AVX2 instructions
>>
>>  risugen                    |   27 +-
>>  risugen_arm.pm             |    6 +-
>>  risugen_common.pm          |  117 +-
>>  risugen_m68k.pm            |    3 +-
>>  risugen_ppc64.pm           |    6 +-
>>  risugen_x86.pm             |  518 +++++
>>  risugen_x86_asm.pm         |  918 ++++++++
>>  risugen_x86_constraints.pm |  154 ++
>>  risugen_x86_memory.pm      |   87 +
>>  x86.risu                   | 4499 +++++++++++++++++++++++++++++++++++=
+
>>  10 files changed, 6293 insertions(+), 42 deletions(-)
>>  create mode 100644 risugen_x86.pm
>>  create mode 100644 risugen_x86_asm.pm
>>  create mode 100644 risugen_x86_constraints.pm
>>  create mode 100644 risugen_x86_memory.pm
>>  create mode 100644 x86.risu
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


--jRX551ZtVzohgh9zonSQAbqdElnmYwR0P--

--0PrpGAL7MZYSmX4YK2J4W2xapL7SExsNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0rtdoACgkQZeg2ldrj
Ns9dXQ//fb1KhCiLm/fZ7khtddkzyEg9hf8DHkwPTCnqMV60SeFnEc/UWVbrDSfc
6667gMTQxF4HdQKYJQG54VeMd6dccJPD74CeUVy43u1NnItISEElLFGrEQzrzhdz
eJxxPod3LHHFKyl3Ch2TeDKrbRcWHBU841qyv4J+SxY4+gLVSN4hAnXKg/ALIJvb
TDJoXDV+/UqnrKnLBdTgLqMD5VDFvrZ0rLB1OZwwYHIgXQVyxGWvhd0r8eoslN5H
cyw1cXcAtjPjYgE8VBRe9HU1YMrPP8Bfhxcd9pJ+O4Cc/NTibvJXtAiZu/G0o7Ky
tl++mqBqwhj66/7NJDVlBH12wKMdtgxWeUkqDwnsX4pcTyio4DXd8hzWqC9NCPLe
4f2R5VQTqB2WleOxpHT2gxp0sPS39MtfnAhutyIf6hheH8kCC4WVjVyuAUkWSJIz
fWt8G0zaz0a8ac/mYCyggHhoQ19c2CjvgLl49j4EihC4c4LB9hMjmESVgevnrDu4
88dnGhpmBgb2ebpwj+Fwz6jWl4g3wTAyaGB970bcrqs19lnZMgzlZpRF7q8nEzI3
6NneoK+XaEph51P5vf2gqCE+46KEapwJa6NFi9w56r47oG/mRODRJDqciDRNhlOh
HIe+2COMPgKqCwgeYfbGrpt18yhpAqX1JkHWzgEqRTsYHoTIMkU=
=0Cu0
-----END PGP SIGNATURE-----

--0PrpGAL7MZYSmX4YK2J4W2xapL7SExsNw--

