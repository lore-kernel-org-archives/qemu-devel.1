Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1doro4-0000Px-K0
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dornz-0005R9-Ly
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:52:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:56796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dornz-0005O2-Ad
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:52:47 -0400
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
Date: Mon, 4 Sep 2017 15:54:56 +0200
MIME-Version: 1.0
In-Reply-To: <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q3HnPTFspblfRg0crjkppB5re7F8cQNO1"
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
--q3HnPTFspblfRg0crjkppB5re7F8cQNO1
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Message-ID: <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
References: <20170903163130.14288-1-n54@gmx.com>
 <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
 <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
In-Reply-To: <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 02:27, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/03/2017 02:05 PM, Laurent Vivier wrote:
>> Le 03/09/2017 =C3=A0 18:31, Kamil Rytarowski a =C3=A9crit :
>>> GCC 4.7.2 on SunOS reports that the values assigned to array members
>>> are not
>>> real constants:
>>>
>>> target/m68k/fpu_helper.c:32:5: error: initializer element is not
>>> constant
>>> target/m68k/fpu_helper.c:32:5: error: (near initialization for
>>> 'fpu_rom[0]')
>>> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>>
>>> Convert the array to switch() to workaround the issue.
>>
>> I don't like the idea. It's really an array and should be managed as a=
n
>> array.
>=20
> I agree with Laurent.
>=20
>>
>> Could you try to use make_floatx80_init() instead of make_floatx80() ?=

>=20
> I guess the problem comes from the macro which cast as not const:
>=20
> #define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>=20

Adding const to make_floatx80 - ((const floatx80) { mant, exp }) - does
not fix the problem.

> make_floatx80_init() doesn't cast so it might work,
> else we could add a macro such const_floatx80():
>=20
> #define const_floatx80(exp, mant) ((const floatx80) { mant, exp })

Switching make_floatx80() to make_floatx80_init() in works.

How about floatx80_zero, floatx80_one etc? We cannot translate them to
make_floatx80_init() as this breaks in other parts of the code in
functions like:

void helper_fldpi_ST0(CPUX86State *env)
{
    ST0 =3D floatx80_pi;
}

-- target/i386/fpu_helper.c


--q3HnPTFspblfRg0crjkppB5re7F8cQNO1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrVs+AAoJEEuzCOmwLnZsPiwQALLPj2Sz7zZX+mNygTk69G62
1eAUWEXRBaMB3NTpwg9w4ObLS2HsuwBVpHApsHUeFYfujinXffuyrUjcc54dCQ9t
0G2+yC8ZS7dV41I/I5YyPWW55YvB05wCOjex5vAYzfONx7lDCTEZRREIqECem8/A
BbVvZvitf7BkdbROxpQMlrBeSI5Ze/sF/gYuO7WM3/t61q+GTAiz76+bi8YhYRQM
BUz6IIiHAek5ZyFkcAQrLwTtBndcm7A4R818pfAAH7hiZR7OI5N55jm6TO9Kuvcy
gvc1ngqCyFoXhI4HwKu5R/qYLM1GDC+C9xyVii5ttA+k6A2ziLDek1ALGFf7GUu6
Pz4KeIu0fJEQlDHgDWi9McFF+6fYd3nxU0eBMM6vnHimqDD4q+XzFEwTyXmKijFG
FRJz03dWKLVoBHiuh4+1LMkyPtnZKSRS0oe/t4YMPSViIspl8Q57bnCGnAJ8RFws
aJQ7k0t1ciPRJEN5qFEu0V80V0DdufMTC9UuqIogpktbyiZGEec3NRwfmNO+4uiZ
DDwkJ1nUNMnwUVFYMQePp6iKYWemzqqhmzBXyuAMjXoMUVvdPmjVDuaBw8CMMXON
8g2Erat1wUHlwQQGRFB5TidS/7NYSqsfJFI9/VLd0a0qM+tCJWRmA32JuLa+SpRZ
QdrkCa649vplS6W4qgDs
=/PtW
-----END PGP SIGNATURE-----

--q3HnPTFspblfRg0crjkppB5re7F8cQNO1--
