Received: from eggs.gnu.org ([2001:4830:134:3::10]:56915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg7Iy-0003lD-LR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg7It-0002G2-Mh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:08:52 -0500
Date: Mon, 29 Jan 2018 11:08:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129110844.GB20446@stefanha-x1.localdomain>
References: <20180126193439.20219-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20180126193439.20219-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Simplify
 bdrv_can_write_zeroes_with_unmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, pbonzini@redhat.com


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 01:34:39PM -0600, Eric Blake wrote:
> We don't need the can_write_zeroes_with_unmap field in
> BlockDriverInfo, because it is redundant information with
> supported_zero_flags & BDRV_REQ_MAY_UNMAP.  Note that
> BlockDriverInfo and supported_zero_flags are both per-device
> settings, rather than global state about the driver as a
> whole, which means one or both of these bits of information
> can already be conditional.  Let's audit how they were set:
>=20
> crypto: always setting can_write_ to false is pointless (the
> struct starts life zero-initialized), no use of supported_
>=20
> nbd: just recently fixed to set can_write_ if supported_
> includes MAY_UNMAP (thus this commit effectively reverts
> bca80059e and solves the problem mentioned there in a more
> global way)
>=20
> file-posix, iscsi, qcow2: can_write_ is conditional, while
> supported_ was unconditional; but passing MAY_UNMAP would
> fail with ENOTSUP if the condition wasn't met
>=20
> qed: can_write_ is unconditional, but pwrite_zeroes lacks
> support for MAY_UNMAP and supported_ is not set. Perhaps
> support can be added later (since it would be similar to
> qcow2), but for now claiming false is no real loss
>=20
> all other drivers: can_write_ is not set, and supported_ is
> either unset or a passthrough
>=20
> Simplify the code by moving the conditional into
> supported_zero_flags for all drivers, then dropping the
> now-unused BDI field.  For callers that relied on
> bdrv_can_write_zeroes_with_unmap(), we return the same
> per-device settings for drivers that had conditions (no
> observable change in behavior there); and can now return
> true (instead of false) for drivers that support passthrough
> (for example, the commit driver) which gives those drivers
> the same fix as nbd just got in bca80059e.  For callers that
> relied on supported_zero_flags, we now have a few more places
> that can avoid a wasted call to pwrite_zeroes() that will
> just fail with ENOTSUP.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> The commit id mentioned above is dependent on me not having to respin
> my latest NBD pull request:
>=20
> Based-on: <20180126160411.4033-1-eblake@redhat.com>
> ([PULL 0/8] NBD patches through 26 Jan)
> ---
>  include/block/block.h | 11 -----------
>  block.c               |  8 +-------
>  block/crypto.c        |  1 -
>  block/file-posix.c    |  3 +--
>  block/iscsi.c         |  6 ++++--
>  block/nbd.c           | 11 -----------
>  block/qcow2.c         |  3 +--
>  block/qed.c           |  1 -
>  8 files changed, 7 insertions(+), 37 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabwC8AAoJEJykq7OBq3PIZxYH/3QB9bJZWgq7Jj8ZDf4TvYi8
3C5hK71bbTa1Jm7NIolug3Cq4vBnV3RLs/te1Yf+9XE1N4cVKM2NtjaDmHYAjWyB
MsIFhYwNwbx9hBsl2dSs57ybb1Od5QUb5PC3pXlsRw5CJ0QDben/5pum/uI5jf3j
mL/OAIMpU1+Yc9uM9E6rhsEcAfSWaIor9hVZpAwlXD9Y//zw37hoPcZYmjDMju9r
RRj5QIEqYEBTxMa9UP1u5GX2ELSl74BH6wlYFUkG+J09eSYVk/uFAhO/I7dj2Pj6
VI+Kyjpi6+x+se99AJWr/nCd934Ax0XqjerS2JRgYrVX69VfCox3BE2sM6JYO5s=
=at6D
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
