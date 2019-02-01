Received: from eggs.gnu.org ([209.51.188.92]:47129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gpRlG-0001wV-F4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gpRlF-0003RO-ER
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:53:10 -0500
Date: Fri, 1 Feb 2019 13:53:02 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190201055302.GJ23131@stefanha-x1.localdomain>
References: <20190131143151.6146-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Content-Disposition: inline
In-Reply-To: <20190131143151.6146-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Fix invalidate_cache
 error path for parent activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com, dgilbert@redhat.com


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 03:31:51PM +0100, Kevin Wolf wrote:
> bdrv_co_invalidate_cache() clears the BDRV_O_INACTIVE flag before
> actually activating a node so that the correct permissions etc. are
> taken. In case of errors, the flag must be restored so that the next
> call to bdrv_co_invalidate_cache() retries activation.
>=20
> Restoring the flag was missing in the error path for a failed
> parent->role->activate() call. The consequence is that this attempt to
> activate all images correctly fails because we still set errp, however
> on the next attempt BDRV_O_INACTIVE is already clear, so we return
> success without actually retrying the failed action.
>=20
> An example where this is observable in practice is migration to a QEMU
> instance that has a raw format block node attached to a guest device
> with share-rw=3Doff (the default) while another process holds
> BLK_PERM_WRITE for the same image. In this case, all activation steps
> before parent->role->activate() succeed because raw can tolerate other
> writers to the image. Only the parent callback (in particular
> blk_root_activate()) tries to implement the share-rw=3Don property and
> requests exclusive write permissions. This fails when the migration
> completes and correctly displays an error. However, a manual 'cont' will
> incorrectly resume the VM without calling blk_root_activate() again.
>=20
> This case is described in more detail in the following bug report:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1531888
>=20
> Fix this by correctly restoring the BDRV_O_INACTIVE flag in the error
> path.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU96+AAoJEJykq7OBq3PIY9AH/j3imQFkxRhAdocTpLeWN6Ku
l330lmzRLuPWObGbvjwx809hHYOsrCesO+8Yhjh3TlGEyPDEtMWrA9iwxLe8iiQq
DfJ7Cnvu16jnjz/G6GHzZwBKOZVtQVU9sk7ATm7zPuJKuPli6e/vst+6+11vkkDC
t1XZDEmUOz8wuQpwbXWdp7Lh4Hu2nsfWSbtNsqHs2twjMu5pirBlOg2YnoWx9xRx
29Cltn3HR5UsuhxmFJ5TwDAQcuorsiT3XdrId/w8PSCMUBAKbOt1VFzCmUKOytXp
ZkhOt7L4uoFAyZ6pBfy+mj7ygRn3x7Bewf4iQ5tWkVlesRvENzN9GEhsd2vH4Vc=
=MTao
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
