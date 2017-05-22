Received: from eggs.gnu.org ([2001:4830:134:3::10]:36322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCswi-0002Go-CN
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCswe-0004b2-Ei
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCswe-0004as-5T
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:24:44 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb751647-3473-76e2-bc49-bf2c9734a027@redhat.com>
Date: Mon, 22 May 2017 14:24:39 -0500
MIME-Version: 1.0
In-Reply-To: <1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0F98DdVCwcHkJsIE1WjWUVWN45E8N4lXf"
Subject: Re: [Qemu-devel] [PATCH v1 03/13] qcow2: do not COW the empty areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V . Lunev" <den@openvz.org>, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0F98DdVCwcHkJsIE1WjWUVWN45E8N4lXf
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V . Lunev" <den@openvz.org>, den@virtuozzo.com,
 mreitz@redhat.com
Message-ID: <fb751647-3473-76e2-bc49-bf2c9734a027@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 03/13] qcow2: do not COW the empty areas
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 04:34 AM, Anton Nefedov wrote:
> If COW area of the newly allocated cluster is zeroes, there is no reaso=
n
> to write zero sectors in perform_cow() again now as whole clusters are
> zeroed out in single chunks by handle_alloc_space().

But that's only true if you can guarantee that handle_alloc_space()
succeeded at ensuring the cluster reads as zeroes.  If you silently
ignore errors (which is what patch 1/13 does), you risk assuming that
the cluster reads as zeroes when in reality it does not, and then you
have corrupted data.

The idea of avoiding a COW of areas that read as zero at the source when
the destination also already reads as zeroes makes sense, but I'm not
convinced that this patch is safe as written.

>=20
> Introduce QCowL2Meta field "reduced", since the existing fields
> (offset and nb_bytes) still has to keep other write requests from
> simultaneous writing in the area
>=20
> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> so, break on write_aio event instead, will work for the test
> (but write won't fail anymore, so update reference output)
>=20
> iotest 066:
> cluster-alignment areas that were not really COWed are now detected
> as zeroes, hence the initial write has to be exactly the same size for
> the maps to match
>=20
> performance tests: =3D=3D=3D
>=20
> qemu-io,
>   results in seconds to complete (less is better)
>   random write 4k to empty image, no backing
>     HDD
>       64k cluster
>         128M over 128M image:   160 -> 160 ( x1  )
>         128M over   2G image:    86 ->  84 ( x1  )
>         128M over   8G image:    40 ->  29 ( x1.4 )
>       1M cluster
>          32M over   8G image:    58 ->  23 ( x2.5 )
>=20
>     SSD
>       64k cluster
>           2G over   2G image:    71 ->  38 (  x1.9 )
>         512M over   8G image:    85 ->   8 ( x10.6 )
>       1M cluster
>         128M over  32G image:   314 ->   2 ( x157  )

At any rate, the benchmark numbers show that there is merit to pursuing
the idea of reducing I/O when partial cluster writes can avoid writing
COW'd zeroes on either side of the data.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0F98DdVCwcHkJsIE1WjWUVWN45E8N4lXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIzr3AAoJEKeha0olJ0NqDQQH/jWWvm8FpGu5edo9Z1YW9jY4
sp+5/bFnszioYnnilRAj2Rthe+/hOgAwsB0HkdCslAJfd29A1jWmWi7jIAyDRJ8L
iQZbMT/0d1mQWdVOUotCXVEqV6d3tS/digWEEdGfjQZrBQPfzvBzYu/THbAJNlQA
FdglH4pHrjW9SsNrGeq5pg0s2c18TYYj8OdkvGjJH9aV5jU0SqWp4JhpW7DhifUT
uf2E8/DU93MgKrQSDmsmxUff5rDgkgpHdYjMis4Xxha2kbZapIXt24O05vHWFKXu
flKMyTbrI+miU1NVa9whd7AsH4we+evGOqqi7eq5bZzcD+UrbnHvk21GszFlUtk=
=Vn5n
-----END PGP SIGNATURE-----

--0F98DdVCwcHkJsIE1WjWUVWN45E8N4lXf--
