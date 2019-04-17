Received: from eggs.gnu.org ([209.51.188.92]:59581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGo62-000824-Tr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGo61-00080E-Q9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:42 -0400
References: <20190401145741.28322-1-eblake@redhat.com>
	<d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
	<39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <51b3fd92-4515-0288-9553-243e9619cde2@redhat.com>
Date: Wed, 17 Apr 2019 19:11:28 +0200
MIME-Version: 1.0
In-Reply-To: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <51b3fd92-4515-0288-9553-243e9619cde2@redhat.com>
Subject: Re: [PATCH for-4.1 v2] qemu-img: Saner printing of large file sizes
References: <20190401145741.28322-1-eblake@redhat.com>
 <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
 <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
In-Reply-To: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.19 18:58, Eric Blake wrote:
> On 4/10/19 2:28 PM, Max Reitz wrote:
>> On 01.04.19 16:57, Eric Blake wrote:
>>> Disk sizes close to INT64_MAX cause overflow, for some pretty
>>> ridiculous output:
>>>
>>>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info=
 $nbd'
>>>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>>>   file format: raw
>>>   virtual size: -8388607T (9223372036854775296 bytes)
>>>   disk size: unavailable
>>>
>=20
>>
>> There are more iotests this breaks.  First, there is 059 for vmdk, whi=
ch
>> looks just like the rest.
>=20
> Easy enough; I was able to reproduce.
>=20
>>
>> But for -m32, it gets a bit more difficult.  Every size above 999 GB
>> (1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
>> "inf [unit]":
>=20
> Ouch - pre-existing bug in size_to_str(); I'll have to fix that, then
> send a v3.
>=20
> Kevin, do you want to unqueue this from block-next until then?
>=20
>>
>> But regardless of the iotests, we shouldn=E2=80=99t show the size as i=
nfinite
>> just because of -m32.
>=20
> Is there an easy docker setup for building -m32?

I don=E2=80=99t know.  In theory it's as simple as (on Fedora):

$ export PKG_CONFIG_LIBDIR=3D/usr/lib/pkgconfig
$ ../configure --target-list=3Dx86_64-softmmu --extra-cflags=3D-m32
$ make

In practice, Fedora 29 has a broken glib2-devel.i686 package, which you
cannot install alongside the x86_64 version, so it doesn=E2=80=99t work
(https://bugzilla.redhat.com/show_bug.cgi?id=3D1651231).

I had hoped it was fixed by now... :-/

(In case you=E2=80=99re wondering, I=E2=80=99m building the 32-bit versio=
n on Arch.)

Max


--daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3XkAACgkQ9AfbAGHV
z0BQfAgAhWM99gCK8coLL1gL3BG1IITzdYbsMpY8bGyc8s4iwkw3MBpdDMmLNxhd
xv0a9YcDi0smUpMt4RjA7MmES7xOUSpVGxmKK9+L50FY+6t9ngL6DMOIrJUHcKCT
pHauirv8pTmpPYzJxZcfLt5dj63xEV3ygSG8QLwiJv2lSjq/HjLalatpEnNpOY9/
ELXaceLAZzqeKnfaAfPFIL1VC9hRI8dZmtyL7ADzv08sBQjbtSjOjSB1x5yHh7Uy
MVtIry9KChBQ2L5opVU1v0/x12IxIv7kj0XVeLB//5j1oeuLvLps1ifmBgFk03lT
ZR0E/cYVwrRrAB9UVcRIcLPsJ/Tf6w==
=Z0gE
-----END PGP SIGNATURE-----

--daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH--
