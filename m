Received: from eggs.gnu.org ([2001:4830:134:3::10]:42262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cFkS2-0006Ld-D3
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 11:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cFkRy-0007x0-E9
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 11:24:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cFkRy-0007wq-5W
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 11:24:38 -0500
References: <148127558476.2633.13433882390740185948.stgit@bahia>
	<148127568042.2633.5084932697061472826.stgit@bahia>
	<85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
	<20161210145708.7a1d7b93@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d3cb602-acd8-42d2-43d7-c67c3c933aeb@redhat.com>
Date: Sat, 10 Dec 2016 10:24:35 -0600
MIME-Version: 1.0
In-Reply-To: <20161210145708.7a1d7b93@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fH6150Srlu943LhHkMi1CF6RDQcsQbAXm"
Subject: Re: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fH6150Srlu943LhHkMi1CF6RDQcsQbAXm
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Message-ID: <4d3cb602-acd8-42d2-43d7-c67c3c933aeb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
References: <148127558476.2633.13433882390740185948.stgit@bahia>
 <148127568042.2633.5084932697061472826.stgit@bahia>
 <85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
 <20161210145708.7a1d7b93@bahia>
In-Reply-To: <20161210145708.7a1d7b93@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/10/2016 07:57 AM, Greg Kurz wrote:

>>> -#define P9_NOTAG    (u16)(~0)
>>> -#define P9_NOFID    (u32)(~0)
>>> +#define P9_NOTAG    (uint16_t)(~0)
>>> +#define P9_NOFID    (uint32_t)(~0) =20
>>
>> Don't you want to write ((uint16_t)(~0)), to ensure that this expressi=
on
>> can be used as a drop-in in any other syntactical situation?
>>
>=20
> These defines come from the linux kernel sources and I must admit it
> didn't cross my mind... can you share a case where this would cause
> troubles ?

Unlikely to occur in real code, but:

  int a[] =3D { -2, -3 };
  int *b =3D a + 1;
  printf("%d\n", (uint16_t)(~0)[b]); // prints 65534 - let's see why?

  // prints 65534, or the result of b[-1] cast to uint16_t
  printf("%d\n", (uint16_t)((~0)[b]));

  // probably dumps core, as b[65535] is out of bounds
  printf("%d\n", ((uint16_t)(~0))[b]);

that is, since [] has higher precedence than casts, failure to
parenthesize a cast will change the interpretation of P9_NOTAG[pointer].

And yes, if you copied from the kernel, that means the kernel has a bug
(even if it is unlikely to trip up normal code).


>=20
>> Or even write it as UINT16_C(~0) (using <stdint.h>), or as UINT16_MAX.=

>> (Be aware: the type of (uint16_t)(~0) is uint16_t, while the type of
>> UINT16_MAX is int, due to the rules of integer promotion, if that matt=
ers)
>>
>=20
> UINT16_C(~0) expands to ~0 and UINT16_MAX expands to (65535), at least =
on
> my laptop (glibc-headers-2.23.1-11.fc24.x86_64)... doesn't that mean th=
e
> type of UINT16_C(~0) is also int ? Please enlighten me.

Indeed, UINT16_C produces an int constant, not uint16_t (since there is
no such thing as a uint16_t constant).  So the cast is the only way to
force ~0 to be truncated to a 16-bit pattern.  But using UINT16_MAX is
probably just fine, as it is the all-ones value with the correct integer
promotion for use in any other arithmetic.

>=20
> The 9P spec at http://man.cat-v.org/plan_9/5/version says "(ushort)~0".=
 My
> understanding is 16 bits all ones. I guess I'd rather then go for
> ((uint16_t)(~0)).

Verbose, but works, as does UINT16_MAX.  But I stand corrected that
UINT16_C(~0) does not work.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fH6150Srlu943LhHkMi1CF6RDQcsQbAXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYTCxDAAoJEKeha0olJ0Nqf2kH/R+WzzLDhbjRutB9bl/WRcAb
WyoHr+zq5SutmzGiGwr3SXS8liHh9dpeco4QqZqVJA0Pum54gh7fwOjGvHnBV+4t
toK5OYAbyQzZEPigzYX+y5fQIwOpOaAqqBg3hCL/zO/AusLmfyaVAYbwCoIGLqX4
esztZ+Vdp0echoLGq7e0XAmqbxFixn8HchJDIFeb+ml6aF0eplIE3WYzSq++/bcz
d7IiA1NpythZv5i7LYaRhdNxIqn6wsDW+EULrkinWh5lbATfz6cqz1I8+s24bxhM
uChhHtmrpVOEMKSgTQU23X59iVq2tQQR9IUudFXEa5eK9xz6X+5HGbVk4Urq8Xw=
=LZ5W
-----END PGP SIGNATURE-----

--fH6150Srlu943LhHkMi1CF6RDQcsQbAXm--
