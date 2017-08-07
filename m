Received: from eggs.gnu.org ([2001:4830:134:3::10]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1depi8-0003d8-Vo
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1depi4-0004PV-0v
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:37:17 -0400
References: <20170807161529.3779-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3bebf07f-0505-8236-b3f7-c8ee74a2ee2d@redhat.com>
Date: Mon, 7 Aug 2017 16:36:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170807161529.3779-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lOvCMLhTqWck3Egv3aWKRdhg3HR3xJoDF"
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg
 and LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lOvCMLhTqWck3Egv3aWKRdhg3HR3xJoDF
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Message-ID: <3bebf07f-0505-8236-b3f7-c8ee74a2ee2d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg and
 LeakyBucket.max integer types
References: <20170807161529.3779-1-berto@igalia.com>
In-Reply-To: <20170807161529.3779-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 11:15 AM, Alberto Garcia wrote:
> Both the throttling limits set with the throttling.iops-* and
> throttling.bps-* options and their QMP equivalents defined in the
> BlockIOThrottle struct are integer values.
>=20
> Those limits are also reported in the BlockDeviceInfo struct and they
> are integers there as well.
>=20
> Therefore there's no reason to store them internally as double and do
> the conversion everytime we're setting or querying them, so this patch
> uses int64_t for those types.
>=20
> LeakyBucket.level and LeakyBucket.burst_level do however remain double
> because their value changes depending on the fraction of time elapsed
> since the previous I/O operation.
>=20
> There's one particular instance of the previous code where bkt->max
> could have a non-integer value: that's in throttle_fix_bucket() when
> bkt->max is initialized to bkt->avg / 10. This is now an integer
> division and the result is rounded. We don't need to worry about this
> because:
>=20
>    a) with the magnitudes we're dealing with (bytes per second, I/O
>       operations per second) the limits are likely to be always
>       multiples of 10.
>=20
>    b) even if they weren't this doesn't affect the actual limits, only
>       the algorithm that makes the throttling smoother.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/qemu/throttle.h | 4 ++--
>  util/throttle.c         | 7 ++-----
>  2 files changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lOvCMLhTqWck3Egv3aWKRdhg3HR3xJoDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmI3XkACgkQp6FrSiUn
Q2qBHQf/aQwc/RSWTES86aYfQOTr+0IQBDeikMbD75Sgbv0nLP+MPhH7ZgQo5s3C
CvHDZvAmThMTqZKsfAKKh+mP7CT9+fF02ky8CKfFDOj9CWzi/ldLUFJaGxScfwW5
0wq8V9grAXVdBbdOl2VYAv8XM61HHZk4LBjZhV91ys3bn3yUMp53s9ahE+2FN2Z/
yX6yy3i+aHo1lckg98DOVudIx9LetFGcVTM1iRmoDQDspyMdRx8vH/jLnUvj5TUL
ohAMGIHMb/LypbUqoVK2ZWI8vnucVWW4qmsduf+cFWpHcgPlA0ZktiucCb3kXXge
ex9yrawv0N2lQ4cV2jRZwQff3S52Yg==
=WeA8
-----END PGP SIGNATURE-----

--lOvCMLhTqWck3Egv3aWKRdhg3HR3xJoDF--
