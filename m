Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dosjc-0005ms-CC
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dosiY-0008Vv-1b
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:52:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:60803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dosiX-0008SY-DJ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:51:13 -0400
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
	<047f9b63-2dcc-e8ba-90c1-965e253fcbf5@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <cfa07f00-a650-a08f-76c4-8412d8d44edf@gmx.com>
Date: Mon, 4 Sep 2017 16:53:30 +0200
MIME-Version: 1.0
In-Reply-To: <047f9b63-2dcc-e8ba-90c1-965e253fcbf5@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kf65S8wWP2Kw01brJ97i2ppmUiH7i1UxI"
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kf65S8wWP2Kw01brJ97i2ppmUiH7i1UxI
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Message-ID: <cfa07f00-a650-a08f-76c4-8412d8d44edf@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
References: <20170903163130.14288-1-n54@gmx.com>
 <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
 <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
 <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
 <c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
 <047f9b63-2dcc-e8ba-90c1-965e253fcbf5@amsat.org>
In-Reply-To: <047f9b63-2dcc-e8ba-90c1-965e253fcbf5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 16:41, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/04/2017 11:09 AM, Laurent Vivier wrote:
>> Le 04/09/2017 =C3=A0 15:54, Kamil Rytarowski a =C3=A9crit :
>>> On 04.09.2017 02:27, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 09/03/2017 02:05 PM, Laurent Vivier wrote:
>>>>> Le 03/09/2017 =C3=A0 18:31, Kamil Rytarowski a =C3=A9crit :
>>>>>> GCC 4.7.2 on SunOS reports that the values assigned to array membe=
rs
>>>>>> are not
>>>>>> real constants:
>>>>>>
>>>>>> target/m68k/fpu_helper.c:32:5: error: initializer element is not
>>>>>> constant
>>>>>> target/m68k/fpu_helper.c:32:5: error: (near initialization for
>>>>>> 'fpu_rom[0]')
>>>>>> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>>>>>
>>>>>> Convert the array to switch() to workaround the issue.
>>>>>
>>>>> I don't like the idea. It's really an array and should be managed
>>>>> as an
>>>>> array.
>>>>
>>>> I agree with Laurent.
>>>>
>>>>>
>>>>> Could you try to use make_floatx80_init() instead of make_floatx80(=
) ?
>>>>
>>>> I guess the problem comes from the macro which cast as not const:
>>>>
>>>> #define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>>>>
>>>
>>> Adding const to make_floatx80 - ((const floatx80) { mant, exp }) - do=
es
>>> not fix the problem.
>>>
>>>> make_floatx80_init() doesn't cast so it might work,
>>>> else we could add a macro such const_floatx80():
>>>>
>>>> #define const_floatx80(exp, mant) ((const floatx80) { mant, exp })
>>>
>>> Switching make_floatx80() to make_floatx80_init() in works.
>>>
>>> How about floatx80_zero, floatx80_one etc? We cannot translate them t=
o
>>> make_floatx80_init() as this breaks in other parts of the code in
>>> functions like:
>>>
>>> void helper_fldpi_ST0(CPUX86State *env)
>>> {
>>>      ST0 =3D floatx80_pi;
>>> }
>>>
>>> -- target/i386/fpu_helper.c
>>>
>>
>> You can:
>>
>> either replace the "#define floatx80_pi make_floatx80(...)" by a "cons=
t
>> floatx80 floatx80_pi =3D make_floatx80_init(...)"
>=20
> this won't work with:
>=20
> const floatx80 2pi =3D floatx80_mul(floatx80_pi, floatx80_pi, &s);
>=20
> however this should work fine:
>=20
> #define floatx80_pi make_floatx80_init(0x4000, 0xc90fdaa22168c235LL)
>=20

This breaks as mentioned above, in target/i386/fpu_helper.c.

>>
>> or replace all the macros in the m68k/fpu_helper.c array by
>> make_floatx80_init(...)
>>

I've copied the float_* numbers to target/m68k/fpu_helper.c and it
builds on SmartOS machine with GCC 4.7.2 (from Joyent shell) and on my
local NetBSD workstation with Clang 5.0.0

>> Thanks,
>> Laurent
>>

I'm going to submit the new patch soon.


--kf65S8wWP2Kw01brJ97i2ppmUiH7i1UxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrWjwAAoJEEuzCOmwLnZsK8IQALXyuOUfswZSMkGDW1AUwf6O
dt2qrpnEgK66Jw7e2AuqnUpZhBnn7hMQrB9I0yryo/AHbTik0F5/tnNNEcH2c+2O
QB3K+Rkrp5RElpr6aZsrjPILHdVLRoMSympb0ZjASDY1Be+asm1Qtqn4flNfRHti
/naFQuAbh1ZMaU/mdVQjSI7hBtwN6drhiBx/2ecLpglBLERl8IBunW4JHZG9kjah
mOwOovGXRl50c3tRbERQIZJj5HYTV00BvT/jHMGZqd8oP6gNJ1pHo2FAlu92jsV8
ZZvCX9ZkEgdBjDz7jZ1MyfVC+sMqoa4h6xqZFWaXy2PpDpzywQnCBAaQ4kAftztn
QU4/snnpWaalt+npkcEKWiLtvCZlpO6vHQQfcUg7VLTTQluV+oOcdRoYsQk/EXg0
iiAETt44qmFd4ZuMLiQ6rpkIAVCt5SYJWCf+Lt3g8jBV/W0HQrlk08JLAGcPjuwC
i0yU5CfnFYY7Gy29hvTWU4OM+INLEeY+IAiUJfFC104Q4NF8eHDhLI6AilJ09MSa
UixAg6st40C18NicndLzbGKcdOgXr4+Xqah6MsL2PTUGpHS7pQ46exQz7eMVWFDb
iMPt39g6BNSBmgrBKOm0iLIEiDvPfuo7cSPDS5+9ODd6TlouDJb14W9xV0r3jip9
j8453pEMQMD+CtQvw/AI
=/vP+
-----END PGP SIGNATURE-----

--kf65S8wWP2Kw01brJ97i2ppmUiH7i1UxI--
