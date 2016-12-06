Received: from eggs.gnu.org ([2001:4830:134:3::10]:39955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECMa-0001zm-FY
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECMX-0006UW-EL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:48:40 -0500
Date: Tue, 6 Dec 2016 09:47:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206094733.GF12630@stefanha-x1.localdomain>
References: <20161205154934.24999-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20161205154934.24999-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.8 v2] qcow2: Don't
 strand clusters near 2G intervals during commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 09:49:34AM -0600, Eric Blake wrote:
> The qcow2_make_empty() function is reached during 'qemu-img commit',
> in order to clear out ALL clusters of an image.  However, if the
> image cannot use the fast code path (true if the image is format
> 0.10, or if the image contains a snapshot), the cluster size is
> larger than 512, and the image is larger than 2G in size, then our
> choice of sector_step causes problems.  Since it is not cluster
> aligned, but qcow2_discard_clusters() silently ignores an unaligned
> head or tail, we are leaving clusters allocated.
>=20
> Enhance the testsuite to expose the flaw, and patch the problem by
> ensuring our step size is aligned.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: perform rounding correctly
> ---
>  block/qcow2.c              |   3 +-
>  tests/qemu-iotests/097     |  41 +++++---
>  tests/qemu-iotests/097.out | 249 +++++++++++++++++++++++++++++++++------=
------
>  3 files changed, 210 insertions(+), 83 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRok1AAoJEJykq7OBq3PI2g0IAKc9fZcnRNA70Vw1GqvXf5wH
jNvpaNl/hsjnv7L1/wB54Ez+6ZYmOTDoU6wlD5CAlKzQM0EkeDpcclFDIl5gsRRJ
aUr7JAEWbHNaa7ArDnTfE6CihpLYuVC/5+IbBPDfOpAB1s/ztyBm1LOGE0InYnfG
V6JfjKl1dbmAiEICaDtV4VcWU2MFIi5GcnxEygI8XeNRuuAVnT1uvh3ERTDWhQJj
Mb1ADYN6QXDet4xLMl2Yv2YLFiV2VliPKuuwjaRNuRLATyxuBln8tPV0jFoQtJDL
vPABKaGFkFLvzqn3rpbtWVERjvU3Hllhe8aCP0k4RF0YKIIAFhoPkwhq2HpkpcE=
=s42z
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
