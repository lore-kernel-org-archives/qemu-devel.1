Received: from eggs.gnu.org ([2001:4830:134:3::10]:56260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq6Vw-0007qv-NL
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq6Vv-00076t-Tk
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:51:48 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
Date: Thu, 16 Aug 2018 02:51:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kolCBRrqQleDsomBFV8eKjq1QdjRcJqmw"
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: async handling of fragmented io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kolCBRrqQleDsomBFV8eKjq1QdjRcJqmw
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
Subject: Re: [PATCH 0/7] qcow2: async handling of fragmented io
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-07 19:43, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> Here is an asynchronous scheme for handling fragmented qcow2
> reads and writes. Both qcow2 read and write functions loops through
> sequential portions of data. The series aim it to parallelize these
> loops iterations.
>=20
> It improves performance for fragmented qcow2 images, I've tested it
> as follows:
>=20
> I have four 4G qcow2 images (with default 64k block size) on my ssd dis=
k:
> t-seq.qcow2 - sequentially written qcow2 image
> t-reverse.qcow2 - filled by writing 64k portions from end to the start
> t-rand.qcow2 - filled by writing 64k portions (aligned) in random order=

> t-part-rand.qcow2 - filled by shuffling order of 64k writes in 1m clust=
ers
> (see source code of image generation in the end for details)
>=20
> and the test (sequential io by 1mb chunks):
>=20
> test write:
>     for t in /ssd/t-*; \
>         do sync; echo 1 > /proc/sys/vm/drop_caches; echo =3D=3D=3D  $t =
 =3D=3D=3D; \
>         ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none -w $t; =
\
>     done
>=20
> test read (same, just drop -w parameter):
>     for t in /ssd/t-*; \
>         do sync; echo 1 > /proc/sys/vm/drop_caches; echo =3D=3D=3D  $t =
 =3D=3D=3D; \
>         ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none $t; \
>     done
>=20
> short info about parameters:
>   -w - do writes (otherwise do reads)
>   -c - count of blocks
>   -s - block size
>   -t none - disable cache
>   -n - native aio
>   -d 1 - don't use parallel requests provided by qemu-img bench itself

Hm, actually, why not?  And how does a guest behave?

If parallel requests on an SSD perform better, wouldn't a guest issue
parallel requests to the virtual device and thus to qcow2 anyway?

(I suppose the global qcow2 lock could be an issue here, but then your
benchmark should work even without -d 1.)

Max


--kolCBRrqQleDsomBFV8eKjq1QdjRcJqmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt0ypcACgkQ9AfbAGHV
z0AxLwf8CE7AF5EFggagoF+E+ROcIjxFpcJIIbpJibyHAeD6x0JsjI2+G2aHY87Y
aEwUglvFKdBTV0vquqB7YNSwaRmycnve2Y/8V4lk5C6iFUozReHKml9xbQ2cm6pl
bzd2zlCPEqFhET5LzuD7KRn4o0etEVDQv+DuA16XKX+J/eVaj9WFODNssOrVE4CB
yTA0qfypgcXMBQLEMNsiYqyGDx8fEwUHhRCpOkR5t7vWv9yNqsyTCDt8nvsaYxyy
/vpJ6gTo718aA8isVU9nPBXUyH3V8lXb6auTdT4LBd4c1afnq2uUwkf5CvKTgY5B
wujneu88Ot/doJQQkXcQ5doZn2vK0w==
=GnOg
-----END PGP SIGNATURE-----

--kolCBRrqQleDsomBFV8eKjq1QdjRcJqmw--
