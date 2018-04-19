Received: from eggs.gnu.org ([2001:4830:134:3::10]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9C8M-0007BD-Rz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9C8I-0002d9-Ml
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:10:06 -0400
References: <20180419075232.31407-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
Date: Thu, 19 Apr 2018 11:09:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180419075232.31407-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3C6ENh6ovRgNjP7GqZLoZsECuKdUOZ2fG"
Subject: Re: [Qemu-devel] [RFC 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3C6ENh6ovRgNjP7GqZLoZsECuKdUOZ2fG
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6d37b435-bc05-a776-3e7f-c73adec4ee74@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
References: <20180419075232.31407-1-stefanha@redhat.com>
In-Reply-To: <20180419075232.31407-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 02:52 AM, Stefan Hajnoczi wrote:
> file-posix.c only supports shared storage live migration with -drive
> cache.direct=3Doff due to cache consistency issues.  There are two main=
 shared
> storage configurations: files on NFS and host block devices on SAN LUNs=
=2E
>=20
> The problem is that QEMU starts on the destination host before the sour=
ce host
> has written everything out to the disk.  The page cache on the destinat=
ion host
> may contain stale data read when QEMU opened the image file (before mig=
ration
> handover).  Using O_DIRECT avoids this problem but prevents users from =
taking
> advantage of the host page cache.
>=20
> Although cache=3Dnone is the recommended setting for virtualization use=
 cases,
> there are scenarios where cache=3Dwriteback makes sense.  If the guest =
has much
> less RAM than the host or many guests share the same backing file, then=
 the
> host page cache can significantly improve disk I/O performance.
>=20
> This patch series implements .bdrv_co_invalidate_cache() for block/file=
-posix.c
> on Linux so that shared storage live migration works.  I have sent it a=
s an RFC
> because cache consistency is not binary, there are corner cases which I=
've
> described in the actual patch, and this may require more discussion.

Interesting, in that the NBD list is also discussing the possible
standardization of a NBD_CMD_CACHE command (based on existing practice
in the xNBD implementation), and covering whether that MIGHT be worth
doing as a thin wrapper that corresponds to posix_fadvise() semantics.
Thus, if NBD_CMD_CACHE learns flags, we could support
=2Ebdrv_co_invalidate_cache() through the NBD protocol driver, in additio=
n
to the POSIX file driver.  Obviously, your usage invalidates the cache
of the entire file; but does it also make sense to expose a start/length
subset invalidation, for better exposure to posix_fadvise() semantics?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3C6ENh6ovRgNjP7GqZLoZsECuKdUOZ2fG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYv1EACgkQp6FrSiUn
Q2rvEAgAr7A3Sw7GXCZsFXOsIkm5Pkc622NsbUHr0lPl6/Q+irl8XJz+7yuJOHzt
NjhoEK7LJQkgA93TZaJ/BXtWzvLpffEV7h4i5QIx5LY5m+RZaChbkSeoUGwFgR1h
6TVQhTalIId/WG/Rsm1A/TetDgURVd3bQj4lNOvHNdMkYdniSVVaSSADkNhYGw2X
Abhp6OcCtR/DdU7egXVt6IIHj2vRN5Ws5B2VwhbH6M5IbNn2aAknXTip/wXTULk7
Y0+Ptq/JHrVPSeFfTEboxTiba6LGbu4BrnhpzjQa+Ts2phKMrWBmL92cEsL+h35U
KJHDjWnC2YzW7zLVOwwrjL1+X2JpSw==
=0sZQ
-----END PGP SIGNATURE-----

--3C6ENh6ovRgNjP7GqZLoZsECuKdUOZ2fG--
