Received: from eggs.gnu.org ([209.51.188.92]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gguDz-0000MQ-3s
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gguDu-0005cW-VH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:27:30 -0500
Date: Tue, 8 Jan 2019 16:27:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190108162706.GI32358@stefanha-x1.localdomain>
References: <20190107120248.19491-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <20190107120248.19491-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix hangs in synchronous APIs with
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 01:02:48PM +0100, Kevin Wolf wrote:
> In the block layer, synchronous APIs are often implemented by creating a
> coroutine that calls the asynchronous coroutine-based implementation and
> then waiting for completion with BDRV_POLL_WHILE().
>=20
> For this to work with iothreads (more specifically, when the synchronous
> API is called in a thread that is not the home thread of the block
> device, so that the coroutine will run in a different thread), we must
> make sure to call aio_wait_kick() at the end of the operation. Many
> places are missing this, so that BDRV_POLL_WHILE() keeps hanging even if
> the condition has long become false.
>=20
> Note that bdrv_dec_in_flight() involves an aio_wait_kick() call. This
> corresponds to the BDRV_POLL_WHILE() in the drain functions, but it is
> generally not enough for most other operations because they haven't set
> the return value in the coroutine entry stub yet. To avoid race
> conditions there, we need to kick after setting the return value.
>=20
> The race window is small enough that the problem doesn't usually surface
> in the common path. However, it does surface and causes easily
> reproducible hangs if the operation can return early before even calling
> bdrv_inc/dec_in_flight, which many of them do (trivial error or no-op
> success paths).
>=20
> The bug in bdrv_truncate(), bdrv_check() and bdrv_invalidate_cache() is
> slightly different: These functions even neglected to schedule the
> coroutine in the home thread of the node. This avoids the hang, but is
> obviously wrong, too. Fix those to schedule the coroutine in the right
> AioContext in addition to adding aio_wait_kick() calls.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                     |   6 +-
>  block/block-backend.c       |   5 +
>  block/io.c                  |   8 +-
>  block/nbd-client.c          |   1 +
>  block/nvme.c                |   1 +
>  block/qcow2.c               |   1 +
>  block/qed.c                 |   1 +
>  tests/test-block-iothread.c | 372 ++++++++++++++++++++++++++++++++++++
>  tests/Makefile.include      |   2 +
>  9 files changed, 394 insertions(+), 3 deletions(-)
>  create mode 100644 tests/test-block-iothread.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNM9aAAoJEJykq7OBq3PIOY8IALau0JFpAYVcvJwhaKaa/TbS
TIlOFX6s4ykmxTVwWoWFbLXLSeuYQ7mw7t37ugWFDu/NQ4L6M2oEAomkjNVcrWrY
uf0WSQKHqfpFF07CixUd2prMQoM77XOdVbG9fYx03xOj+/auN81Gl2RBvwc2064l
d3TfcHstUnRdVfcNpd/pNdWD9tQyRoJ4Pk7Frvc1G+g5OimDk8Ccbz0jIAWnCeig
+VxyMOYVA1LoGi4VkesjYBBc0XlosPn15lCM+plpH5RzvN5Gpl4ubHi7In3eurkm
MqQ8EjQCZLkGaaplFlaVIpmhIIo0YD4u3sdh1FYIG8uievqMwtwsS+n3OSoZzUA=
=jpRS
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--
