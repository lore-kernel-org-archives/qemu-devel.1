Received: from eggs.gnu.org ([2001:4830:134:3::10]:60147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uvh-0003XA-NK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uve-0001CM-KQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:43:21 -0400
Date: Thu, 11 May 2017 16:43:15 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511204315.GT24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/16] block: Protect AIO
 context change with perm API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:40PM +0800, Fam Zheng wrote:
> v2: Address Stefan's comments:
>=20
>     - Clean up redundancy in bdrv_format_default_perms change.
>     - Add a test case to check both success/failure cases.
>       A failure case is not possible at user interface level because of o=
ther
>       checks we have, so write a unit test in tests/test-blk-perm.c.
>=20
> Eject / change of scsi-cd on a virtio-scsi dataplane bus causes abort() b=
ecause
> the new BDS doesn't get proper bdrv_set_aio_context().
>=20
> Store the AioContext in BB and do it in blk_insert_bs. That is done by
> Vladimir's patch.
>=20
> Other patches are to make sure such a bdrv_set_aio_context() doesn't inte=
rfere
> with other BBs using other nodes from this graph.

Looks pretty good.  I had two comments that apply across all patches:

First, it is not safe to enable the new permission without registering
an aio notifier.  Another user could look up the BDS and call
bdrv_set_aio_context() on it.  I believe this bug is present for block
jobs that have additional BDSes like base/target/etc.

Second, patches that post-pone bdrv_set_aio_context() must take care to
acquire the AioContext for BDS accesses that happen before the next
bdrv_set_aio_context() call.

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMzjAAoJEJykq7OBq3PImPgH/2kzv7mwGMOfeJox5vCs5aHK
I9+MI2snPYGSKhcD365hE3pVYYkCBkajaj23J/fMeqOOr4qS0Z3/7DvkC7rNeEsU
CyoRy+OvqnMEEWwmPyX+Z9a+BdyBLvzBxzkcqSIOQO9UZdE4ydkZUNVd33R5fK44
Cis8bOL1g4EfvnLb41Mu8VpdPP5echA7A9CQSFxVuTmx2xoMUZ1JLZbypYB+t+ik
EGdLhE6UnZOHxRLnmm0Ldqz9+kCoLu+V/j/ljzHzoa7fVZbAbeyq/yJouI29EVPT
qt2lFLE/a80bUNQ/G1A4YJnSzog5Y1bXGxcIYjWbMkw5x07+K/acTLXv1+4fSOw=
=2VVL
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--
