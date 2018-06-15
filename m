Received: from eggs.gnu.org ([2001:4830:134:3::10]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqY7-0000e8-TT
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqY6-0004Vj-Tp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:22:03 -0400
Date: Fri, 15 Jun 2018 16:21:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615152156.GC12972@stefanha-x1.localdomain>
References: <20180608060417.10170-1-famz@redhat.com>
	<20180608060417.10170-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20180608060417.10170-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] block-backend: Refactor AIO emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:04:14PM +0800, Fam Zheng wrote:
> BlkRwCo fields are multi-purposed. @offset is sometimes used to pass the
> 'req' number for blk_ioctl and blk_aio_ioctl; @iobuf is sometimes the
> pointer for QEMUIOVector @qiov sometimes the ioctl @buf. This is not as
> clean as it can be. As the coming copy range emulation wants to add
> more differentiation in parameters, refactor a bit.
>=20
> Move the per-request fields to a union and create one struct for each
> type. While at it also move the bytes parameter from BlkAioEmAIOCB to
> BlkRwCo.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 211 +++++++++++++++++++++++++++---------------
>  1 file changed, 134 insertions(+), 77 deletions(-)

I'm not sure about this patch.  It makes the code longer and adds more
types but still includes hacky cases for pdiscard and flush that only
partially use the union.

IMO either make the code really clean with proper types or stick with
the short but unsafe form.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI9mUAAoJEJykq7OBq3PIOXUIAIeIh6wHw8id1+Iy9I+s4TKd
BM82j+/cwHSKrIhSBr1SqJF2XnXCtu4JfpRUkKxLKwmvkR0gTiUoqOfeg7O+AVWM
PvU9ceUV3f0GOIGT2Tqa8WIAXZ1yZPXDpxOkFqHi99LHnQ5ebUnCrFxx2A5zgX5C
jGvHX4Y1W/BJ/f82uwgEXHWvSsqo7YcvLpZyGvdSu8B0kBD6UwsdDD4YOreP8Pvs
tep2MTfRaAxXUFhSROr8vJOp9YVxNwx3JiOWwifOKECPXHkMb7vRJbvCnl7vk5YW
qfyt+D1RWrLIp1w8AnK4QHSNAb52/WP7uuKuF6JExqAFxNZstUtn6+7ZWmXRVvQ=
=UMpd
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
