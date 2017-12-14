Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTtT-0007vb-V2
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTtQ-0001uz-0z
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:49:47 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171213051736.17755-1-f4bug@amsat.org>
	<20171213051736.17755-4-f4bug@amsat.org>
	<CAAYMZQuQv-yQA2keiq=9p95jQCSz3c=Dzjaygh=co=Q25ZKdxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6568e8bf-0d20-0a4d-f799-684a2b89fc6d@amsat.org>
Date: Thu, 14 Dec 2017 10:49:35 -0300
MIME-Version: 1.0
In-Reply-To: <CAAYMZQuQv-yQA2keiq=9p95jQCSz3c=Dzjaygh=co=Q25ZKdxw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="lv9aTc2WDMkDP0hdIaqG5MTxWjlnNb0rw"
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/registerfields: add 64-bit
 extract/deposit macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: francisco iglesias <frasse.iglesias@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-trivial@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lv9aTc2WDMkDP0hdIaqG5MTxWjlnNb0rw
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: francisco iglesias <frasse.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-trivial@nongnu.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Message-ID: <6568e8bf-0d20-0a4d-f799-684a2b89fc6d@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/registerfields: add 64-bit
 extract/deposit macros
References: <20171213051736.17755-1-f4bug@amsat.org>
 <20171213051736.17755-4-f4bug@amsat.org>
 <CAAYMZQuQv-yQA2keiq=9p95jQCSz3c=Dzjaygh=co=Q25ZKdxw@mail.gmail.com>
In-Reply-To: <CAAYMZQuQv-yQA2keiq=9p95jQCSz3c=Dzjaygh=co=Q25ZKdxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Francisco,

On 12/13/2017 06:37 PM, francisco iglesias wrote:
> On 13 December 2017 at 06:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> wrote:
[...]
>>  /* Extract a field from an array of registers */
[...]
>> +#define FIELD_DP64(storage, reg, field, val) ({
>>  \
>> +    struct {
>> \
>> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;
>> \
>>
>=20
> I'm just wondering if 'v' above maybe should be uint64_t? The size of
> unsigned int seems to be 'implementation defined' but I would guess 32 =
bits
> is not unsual. Basically wouldn't a field length > 32 above be problema=
tic?

Good remark...

As per the standard bitfields access must be per 'unsigned'.
So with a LP64 data model we have sizeof(unsigned) =3D 32-bit, I wonder
how the compiler behaves.

I added the debian-win32 docker image to tests this kind of regressions,
but it seems the current toolchain used (mingw-w64) is now only a LLP64
model (I still need to verify).

I remember I somewhere have a Linux/X32 docker suite to test this
series. I'll give it a try (I doubt before this week-end).

Regards,

Phil.

>> +    } v =3D { .v =3D val };
>>  \
>> +    uint64_t d;
>>  \
>> +    d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,
>>  \
>> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);
>>  \
>> +    d; })
>>
>>  /* Deposit a field to array of registers.  */
>>  #define ARRAY_FIELD_DP32(regs, reg, field, val)
>>  \
>> --
>> 2.15.1



--lv9aTc2WDMkDP0hdIaqG5MTxWjlnNb0rw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAloygW8ACgkQ4+MsLN6t
wN4RQA//c339XM18QWIYerM/VwC9ckmYmqkSVSA66+U0fzjYziJw86G2QcCOw38T
wU7Re9iu8bFVVaJQhLWj9XYRlcdPAT1r+TTrw4suJpWjJ2eSP2vaRDkTGnSj5sWc
6D2LDnfLKPWWE7KjAqP89LomrFsmL7XhzuOx06Oh7faizRvhKimqkkwmlWSlHIWV
HLMlgOnSGZT6wh218TDD7kunE0062cqPpn+CO9AdVRqBVl1xujp+vEUXIOuw3clO
5ILw1/7wDz97MXZIfHI7XGB64BBi/xeu8hqYy4OCNFCs3AHSPTrh1ukXujdARu3p
Fw5ZMjxl3I74K/9ELx18lklxeydaC+A6m/yp4YOj52U+fcI8Vw8YBZPzTgF+3tUg
flK6Bh4I1hjK/hp7PZHXs1pda+DbmACfKrcIhmohIJOZ28R3T1x7CyS7ywjqsrzn
qQ3KpnqQj2nsOZWqzi5vsrz79fM/eXkNUvzTbUZqOdOdz5kfbQuaTspyHsUrOgjt
zY0s75VZvBeuRZUZ7RIoZmAeKT0vzF65l9Yb+zrASvLq4aahKZRmQFTAgUSJ8rML
XpdDsGXi5Jx9wzpNqKNegUTOQVPR+WUWGGa87MSYI9cjAZiRAII0m3vV371gWhFJ
X0H5f8Gv3344K+vxh0cb8RHtpxU7VCb4SKf4xl/XuuHsA2UD0vY=
=o6T4
-----END PGP SIGNATURE-----

--lv9aTc2WDMkDP0hdIaqG5MTxWjlnNb0rw--
