Received: from eggs.gnu.org ([209.51.188.92]:46359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzJU-00030Q-Jc
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzJS-0004Km-VD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:40 -0500
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
	<2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
	<5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b400545-d3e4-0143-c341-34d6807da095@redhat.com>
Date: Fri, 11 Jan 2019 10:05:17 -0600
MIME-Version: 1.0
In-Reply-To: <5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p9WxoZ1CzcDx0PG0vP2yRruPnEsoT38fc"
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p9WxoZ1CzcDx0PG0vP2yRruPnEsoT38fc
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <4b400545-d3e4-0143-c341-34d6807da095@redhat.com>
Subject: Re: [PATCH] block: don't probe zeroes in bs->file by default on
 block_status
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
 <acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
 <2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
 <5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
In-Reply-To: <5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 10:02 AM, Eric Blake wrote:

> Even a dumb most-recent use cache will speed this up: both the second
> and third queries above can be avoided because we know that both 0x4000=
0
> and 0x30000 the second query at 0x40000 can be skipped (0x40000 is
> between our most recent lseek at 0x20000 and hole at 0x10000)
>=20
> Make the cache slightly larger, or use a bitmap with 2 bits per cluster=

> (tracking unknown, known-data, known-hole), with proper flushing of the=

> cache as we write to the image, or whatever, and we should automaticall=
y
> get some performance improvements by using fewer lseek() anywhere that
> we remember what previous lseek() already told us, with no knobs needed=
=2E

In fact, block/iscsi.c has such a cache; look at iscsi_allocmap_update()
and friends; maybe we should generalize that code in order to reuse the
same concepts in file-posix.c.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--p9WxoZ1CzcDx0PG0vP2yRruPnEsoT38fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4vr0ACgkQp6FrSiUn
Q2rpzAf3bbY7w64+3VExe+Eq91MIC05papN+xDWlRBDDQ3qsyzz/twPI9rxpCW1Y
jDsLOxU4vEzOU2N1Ns0k7eluQbveYorvkoobRcSs4yaiQDHmo+KH8w4cSuwCDnc8
gkgUHBsEBt8QtVbZ321KC1scRxfbOvUt6FuW/zLycpw4njRckpRAOyHA1uQTdIep
GRG5hY5WydBTmnp0a3c6dDa5W3ex19rrmu/hkgBuq6Wh1KeXQAL8i4bxX32T1B3x
FD5Deg8Iut7zhe2LJjd1eOuedM9Vs5IAqh+qog3QnoW03UvM7SP8NpHH10+I1HGF
Y0cjzkByQVB/SCV+S891G6ZF+Idm
=PfzZ
-----END PGP SIGNATURE-----

--p9WxoZ1CzcDx0PG0vP2yRruPnEsoT38fc--
