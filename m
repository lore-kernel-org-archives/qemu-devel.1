Received: from eggs.gnu.org ([208.118.235.92]:47818)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dot5l-00049i-Sv
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dot51-0005nq-C5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:15:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:63374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dot51-0005n4-1E
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:14:27 -0400
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
	<CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8b848df7-8eb2-b2b4-a4e9-660bc017a74d@gmx.com>
Date: Mon, 4 Sep 2017 17:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8ppGXIqxgMdti1Gv2gmesg7XupaXMRRtr"
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
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ppGXIqxgMdti1Gv2gmesg7XupaXMRRtr
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <8b848df7-8eb2-b2b4-a4e9-660bc017a74d@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
References: <20170903163130.14288-1-n54@gmx.com>
 <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
 <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
 <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
 <c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
 <CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
In-Reply-To: <CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 17:02, Peter Maydell wrote:
> On 4 September 2017 at 15:09, Laurent Vivier <laurent@vivier.eu> wrote:=

>> You can:
>>
>> either replace the "#define floatx80_pi make_floatx80(...)" by a "cons=
t
>> floatx80 floatx80_pi =3D make_floatx80_init(...)"
>>
>> or replace all the macros in the m68k/fpu_helper.c array by
>> make_floatx80_init(...)
>=20
> Taking a step back, what's different about floatx80 and float12
> that means they need separate _init and non-init versions of
> the macros, when for float16/float32/float64 we instead have
> #define make_float32(x) __extension__ ({ float32 f32_val =3D {x}; f32_v=
al; })
> #define const_float32(x) { x }
>=20
> ? Could we move to consistency for the macro naming we're using?
>=20
> thanks
> -- PMM
>=20

I don't have insight on the reasoning, but float128 suffers from the
same reason as float80.

static const float128 fpu_rom123[128] =3D {
    [0] =3D make_float128(0, 12)
};

target/m68k/fpu_helper.c:58:1: error: initializer element is not constant=

target/m68k/fpu_helper.c:58:1: error: (near initialization for
'fpu_rom123[0]')
rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
make[1]: *** [target/m68k/fpu_helper.o] Error 1


On the other hand, something like this builds:

static const float16 fpu_rom123[128] =3D {
    [0] =3D make_float16(0)
};


--8ppGXIqxgMdti1Gv2gmesg7XupaXMRRtr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrW5gAAoJEEuzCOmwLnZsBLwP/3BG/GSNxWAezntrSFWrIzNX
wUpPNiZio+juw3M4tipTcPe15TTkEWL9ZUTgoqPNupGrDSMjMS/UK3FIB42Kr4GE
sscPEBV++jozgDoWtDlPplXjvRScEhQy5GAdAMclU6XwGGCdHoMmchBINHDsI2sP
DaEImeZDPh6ij8f5rJVKEeBVUZ5bX7he09qXb7QbgSeWN+ey7K6BxDsEVbMsrCgy
StRGLOmJjv5d1Luuu74jeXK0t/bKR15tYv4NEHPimZi2kcqKDcXezfAJ4MbK2bP6
mPS9ec9iPQt+MYNT48klKuGgYIarVUVy+EysTnsHQ1qHLjSaV2DY42GrWznihe2N
2QBmflddlpDvDc6C9udkjkbzkfluASBm+apZ4laeLvViHx+CpbrW1hLkQCW0dwFa
o3pQ3tYw6blf/4idbYuiDeCD3w4Q7HwUzvRAkOWyZAHGdM7jimHaY915JHqACGX6
dwhZSrWO+05caM07LljAv+FX+ndwh976mTN7ZmaDHhBVGK6weMQzuiiekswMEsha
ri9CcwlDEyf7Dm4gpoDWC6AKFBYVJGf8kQXmt6qHYk+S2eqk7Q4sm2y04w/bECml
C0W1Rvm2nQlJkmmntLPLvNI7zHrkNk1RwlKG6Wpzwx6kz9mf4MCwn4j3MEgvgOBm
1dTYdctUQH1mnNwoqoM/
=Xg3u
-----END PGP SIGNATURE-----

--8ppGXIqxgMdti1Gv2gmesg7XupaXMRRtr--
