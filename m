Received: from eggs.gnu.org ([2001:4830:134:3::10]:38303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfNZM-0002ZY-Cb
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfNZI-0002YA-A4
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:46:28 -0400
Date: Wed, 9 Aug 2017 10:46:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809094620.GG18003@stefanha-x1.localdomain>
References: <20170807161529.3779-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <20170807161529.3779-1-berto@igalia.com>
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
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 07:15:29PM +0300, Alberto Garcia wrote:
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

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZitnsAAoJEJykq7OBq3PIF2QH/2oBYA2Sj5yI2jXK3p854eBn
3nZeKIl7E8j/3bXdNQWUcJMHDlhPme5FBxx+/rcxFzbY1RK1AJlr4WdrRPBPRR2a
TvAwLdH1INvVq387wTDAyMdHL6KgqDqH6IM4rRqX8K6Fch2Lc3begTepTD9ffTOz
/HMMGvGQH01ZoETvpi6AtzkdeXe7DXsjGlVOjSHLHunVnDAfBKNAWBflqxPWy2V0
gFxN2d7xdQYLaPMW223V96FAgtf6/xlEyLcFc+GdePK9G+jjjJV1KQ3B5HJ//oIB
Hq9ryLMyfwkshbBR1YrTqQOPDzNhoHE/Z6XlRopqZSstIaL+6wj+Iq0Vyly92Yk=
=FxHS
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
