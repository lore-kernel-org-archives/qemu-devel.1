Received: from eggs.gnu.org ([2001:4830:134:3::10]:51122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dos3t-0000l3-Ec
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dos3o-0000xg-LR
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:09:13 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dos3o-0000wq-9v
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:09:08 -0400
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
Date: Mon, 4 Sep 2017 16:09:01 +0200
MIME-Version: 1.0
In-Reply-To: <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6TtRvucrTNgLNTjbqF5Hh2jdtrIQsN6dX"
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6TtRvucrTNgLNTjbqF5Hh2jdtrIQsN6dX
From: Laurent Vivier <laurent@vivier.eu>
To: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Message-ID: <c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
References: <20170903163130.14288-1-n54@gmx.com>
 <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
 <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
 <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
In-Reply-To: <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 04/09/2017 =C3=A0 15:54, Kamil Rytarowski a =C3=A9crit=C2=A0:
> On 04.09.2017 02:27, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 09/03/2017 02:05 PM, Laurent Vivier wrote:
>>> Le 03/09/2017 =C3=A0 18:31, Kamil Rytarowski a =C3=A9crit :
>>>> GCC 4.7.2 on SunOS reports that the values assigned to array members=

>>>> are not
>>>> real constants:
>>>>
>>>> target/m68k/fpu_helper.c:32:5: error: initializer element is not
>>>> constant
>>>> target/m68k/fpu_helper.c:32:5: error: (near initialization for
>>>> 'fpu_rom[0]')
>>>> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>>>
>>>> Convert the array to switch() to workaround the issue.
>>>
>>> I don't like the idea. It's really an array and should be managed as =
an
>>> array.
>>
>> I agree with Laurent.
>>
>>>
>>> Could you try to use make_floatx80_init() instead of make_floatx80() =
?
>>
>> I guess the problem comes from the macro which cast as not const:
>>
>> #define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>>
>=20
> Adding const to make_floatx80 - ((const floatx80) { mant, exp }) - does=

> not fix the problem.
>=20
>> make_floatx80_init() doesn't cast so it might work,
>> else we could add a macro such const_floatx80():
>>
>> #define const_floatx80(exp, mant) ((const floatx80) { mant, exp })
>=20
> Switching make_floatx80() to make_floatx80_init() in works.
>=20
> How about floatx80_zero, floatx80_one etc? We cannot translate them to
> make_floatx80_init() as this breaks in other parts of the code in
> functions like:
>=20
> void helper_fldpi_ST0(CPUX86State *env)
> {
>     ST0 =3D floatx80_pi;
> }
>=20
> -- target/i386/fpu_helper.c
>=20

You can:

either replace the "#define floatx80_pi make_floatx80(...)" by a "const
floatx80 floatx80_pi =3D make_floatx80_init(...)"

or replace all the macros in the m68k/fpu_helper.c array by
make_floatx80_init(...)

Thanks,
Laurent


--6TtRvucrTNgLNTjbqF5Hh2jdtrIQsN6dX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlmtXn0ACgkQ8ww4vT8v
vjwm1w//TY+82aGpRv4nqFUtLbVeLZqRXm4MhnTmp2eSrhSbvz5fw5xVPkoM3TM2
XUXkPfA6IGcGmx6rVIMfJtCei/Njsuwz5xyFzVZR4PVsIC+6NPqSoacjyDSiln1G
HLXY87brxWhmWi9gwUKg4LlfZlmS0Otv6xdamyHDZFKjaFSo0o4eIg1Y1dek/PyJ
laIi7jgmKrVVFjatgIRs4MmgguGBuu78HgKhy+T4kvDmYn2+8/s1rLzRaqwTssZ1
DM2/ojUIUwgyYbmadZsKFx/l42tQ2YoqELjAhQIstI2IJPvsJZ46sLMKY06HueDC
0FHeeHwgsC1sKgpt06yGrDuHR63rsHyiAP/Bzf4UMaZnp2kWiHlNh7dvk38VQ/EP
SvlbgJYfK/N+kQm6DRbiB4/bKebal2jPczEMDJEBLWDO3IQ7EPzlzj9Dam/edMZb
LvUj86bl8iDt21dK7qSdkK8GtdHzdM8NGqsuw7/cg0ET59YZBTnsOif0phjU7Mg9
OMDNbzjnIkyO1P5OMrCb4OMd81GjLuaXz6kmbgnofra0GxgEq189XikfkQRqrFGW
Dz2k4ds3F0aL2KiM4STqQlPIVj0e8iDbKQwMIxl4lgqFknadm5E0qGEQlmW8/Ivh
nd0vXlgfyqX/DXa3r53SD9dwgvkGY5zCqmIbp7aFVV71vKEIcxo=
=uSRy
-----END PGP SIGNATURE-----

--6TtRvucrTNgLNTjbqF5Hh2jdtrIQsN6dX--
