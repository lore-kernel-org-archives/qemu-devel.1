Received: from eggs.gnu.org ([2001:4830:134:3::10]:53329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gJFg0-0000wY-NK
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gJFfx-0002nY-2v
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:30:40 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gJFfu-0002b0-I0
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:30:35 -0500
References: <20181101173852.27257-1-laurent@vivier.eu>
	<CAFEAcA9+gSUHW++EKtuqWL4ofWAKqO0H5JUGUoyyAhY7h24o0Q@mail.gmail.com>
	<dcc24ea9-676f-8276-fe54-49bf67f20e56@vivier.eu>
	<20181103125713.GB24365@umbus.hotspot.internet-for-guests.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <218eb47d-01a2-5247-d6af-329dab76b8c3@vivier.eu>
Date: Sun, 4 Nov 2018 11:30:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181103125713.GB24365@umbus.hotspot.internet-for-guests.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r8cmQJgbFMP4IwFz96jFpNAVDwapiGoDB"
Subject: Re: [Qemu-devel] [PATCH] softfloat: don't execute ppc64 ISA 3.0B
 instruction if it is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r8cmQJgbFMP4IwFz96jFpNAVDwapiGoDB
From: Laurent Vivier <laurent@vivier.eu>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Message-ID: <218eb47d-01a2-5247-d6af-329dab76b8c3@vivier.eu>
Subject: Re: [PATCH] softfloat: don't execute ppc64 ISA 3.0B instruction if it
 is not supported
References: <20181101173852.27257-1-laurent@vivier.eu>
 <CAFEAcA9+gSUHW++EKtuqWL4ofWAKqO0H5JUGUoyyAhY7h24o0Q@mail.gmail.com>
 <dcc24ea9-676f-8276-fe54-49bf67f20e56@vivier.eu>
 <20181103125713.GB24365@umbus.hotspot.internet-for-guests.com>
In-Reply-To: <20181103125713.GB24365@umbus.hotspot.internet-for-guests.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2018 13:57, David Gibson wrote:
> On Thu, Nov 01, 2018 at 06:54:59PM +0100, Laurent Vivier wrote:
>> On 01/11/2018 18:49, Peter Maydell wrote:
>>> On 1 November 2018 at 17:38, Laurent Vivier <laurent@vivier.eu> wrote=
:
>>>> commit 27ae5109a2 has introduced an assembly instruction only suppor=
ted
>>>> by ISA 3.0B and it fails to execute on previous versions of the POWE=
R
>>>> CPU (like PowerPC G5).
>>>>
>>>> This patch fixes that by checking the ISA level, and falls back to
>>>> the default C function if the instruction is not supported.
>>>>
>>>> Fixes: 27ae5109a2ba8b6b679cce3e03e16570a34390a0
>>>>        (softfloat: Specialize udiv_qrnnd for ppc64)
>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>> ---
>>>>  include/fpu/softfloat-macros.h | 39 ++++++++++++++++++++-----------=
---
>>>>  1 file changed, 23 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-=
macros.h
>>>> index c86687fa5e..fe98b33df9 100644
>>>> --- a/include/fpu/softfloat-macros.h
>>>> +++ b/include/fpu/softfloat-macros.h
>>>> @@ -78,6 +78,9 @@ this code that are retained.
>>>>  /* Portions of this work are licensed under the terms of the GNU GP=
L,
>>>>   * version 2 or later. See the COPYING file in the top-level direct=
ory.
>>>>   */
>>>> +#if defined(_ARCH_PPC64)
>>>> +extern bool have_isa_3_00;
>>>> +#endif
>>>
>>> I was wondering where this bool came from. The answer is
>>> that it's defined in tcg/ppc/tcg-target.inc.c. It's ok to
>>> use it here because fpu/softfloat.c is only compiled if
>>> CONFIG_TCG is true, so the tcg code will be present. The
>>> other user of this include file is target/m68k/softfloat.c,
>>> which also will only be compiled for a ppc host if CONFIG_TCG.
>>>
>>> It's a little awkward to be borrowing this tcg/ppc internal
>>> flag into the softfloat code, though.
>>
>> I agree, I was hopping Richard can advice another way to do that.
>=20
> We already have ISA version flags in insns_flags & insns_flags2, so
> I'm hoping we can use those rather than introduce a new bool.
>=20

Richard has sent another patch using "defined(_ARCH_PWR7)"

Thanks,
Laurent


--r8cmQJgbFMP4IwFz96jFpNAVDwapiGoDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlveyjcACgkQ8ww4vT8v
vjzC+BAAqpLVkSkV2LYAAX8cf2MXFvmpQwRX5ODOcBOnZ6PzkG35WQ/kC1lo2jew
UqPVrN0k8BFdoKUQOHFG/z1UehHgDPXBkC52IiBdBdG/JXi4TTuF1tVqsnse3MDT
mYqHSthx7WbzEsP6BPPd6/aLF/BCecyJRbgRspuIxs7/i+CNGzwDcPJHaeK/FR1j
a/A9gcupxFAJdvWgaUGhvMnb/SDy3PKjk4wEwYvjl6zbf83tHGwbXj8vXFBmm2Jq
vN4QTHTTAyt2Lus3qXjFMDBfRIKlBR/HQIsBT24xjRLekegl2hCa4Yvp1KD6rutd
7NBrYwADxrRDUmVqRGqtaJTU5PGsDxeFIoU5TVpe2/1kL4Y5SMBwLWV/mutFqT1E
vac8d/P2I+acry0MaUDchlWHF/rXUksm7VOV7g0debUfeX2tDVSR61935Q0GC4MO
rR9btPZ7LRi9DVsMyxZZhcMPyno2DW8ahMaBgPhb6QRaBBvLVQG71B4SEl0x9mxt
7D/AZjG++R19Z7KujEFxTN+AsjzenUvFi6wCTteGmeW+tUjBpHUnv7I52NmoHIE4
w/1IP4muJGjX06R5oa34kotjMlY6uJs7uyjWl2K/V6gAxjya1BlV88oSjs9KMzQS
IZ1pRucetEifZ8k4TE70EBeUcZTlRp4TA7SeWLR0PTooIPiRnnc=
=Ge8n
-----END PGP SIGNATURE-----

--r8cmQJgbFMP4IwFz96jFpNAVDwapiGoDB--
