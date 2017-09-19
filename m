Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duMUy-0004ZD-Rk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duMUu-0003Bd-Nd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duMUu-0003Ay-Ey
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:39:48 -0400
References: <20170918104624.14743-1-laurent@vivier.eu>
	<a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
Date: Tue, 19 Sep 2017 12:39:44 -0500
MIME-Version: 1.0
In-Reply-To: <a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BJPr2T6htcdGVwtldF0V3M2vAuL17HbsE"
Subject: Re: [Qemu-devel] [PATCH] softfloat: rename make_float[x80|128]_init
 to const_float[x80|128]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJPr2T6htcdGVwtldF0V3M2vAuL17HbsE
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] softfloat: rename make_float[x80|128]_init
 to const_float[x80|128]
References: <20170918104624.14743-1-laurent@vivier.eu>
 <a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
In-Reply-To: <a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 11:30 AM, Richard Henderson wrote:
> On 09/18/2017 05:46 AM, Laurent Vivier wrote:
>> Redefine make_floatx80() and make_float128() as make_float16(),
>> make_float32() and make_float64() using a variable and not only
>> a cast.

>> -#define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>> -#define make_floatx80_init(exp, mant) { .low =3D mant, .high =3D exp =
}
>> +#define make_floatx80(exp, mant) __extension__ \
>> +    ({ floatx80 f80_val =3D { .low =3D mant, .high =3D exp }; f80_val=
; })
>> +#define const_floatx80(exp, mant) { .low =3D mant, .high =3D exp }

>=20
> I don't like this part -- (type){ init } is a standard C99 compound lit=
eral.
> There's no point using a gcc extension instead.

The C99 compound literal is not a const initializer in all situations,
though :(  Here's another thread where we had a similar discussion, but
there, the solution was to just make the macro behave as an initializer
(which is C99 compliant, but loses some type safety) instead of relying
on a gcc extension:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html

I suspect you're running into the same issues that Laszlo already helped
us understand regarding QLit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BJPr2T6htcdGVwtldF0V3M2vAuL17HbsE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBVmAACgkQp6FrSiUn
Q2oAJwf/bxKW6Myd4T3asjVT/hZjNGUauAPjWDiaJQZMiguWrrzWCp/T3WrO7H5r
sXoCS4jF58pnV/pQFC7tqfo2Od79MFEcrd5KReTamw12t71GgoR2rNsaImRhd/7g
N5xuFcOiX8sN//2TeE7Kt6OpOPd59R62zhQmUgvilTPoYSE7Kxmg58S22rE9rPDd
wSFxv0CgHW4cVl+BM/FmIxuUE47kz0YJHk8WPCnp28O4Yiw++XKGc6eeenD4Shrc
/z+qRNNFOZv68CVl6I7Ctf7KXTXOhqG/mid/egeq7Dm363NaDnzGGCUdwFPGN0Ga
vowhdSYK/32B6NKmYeAC21xsVgfRSw==
=MN4d
-----END PGP SIGNATURE-----

--BJPr2T6htcdGVwtldF0V3M2vAuL17HbsE--
