Received: from eggs.gnu.org ([2001:4830:134:3::10]:53596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX2es-0008Pi-OW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX2eo-0008GC-SP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:49:42 -0400
Date: Mon, 17 Jul 2017 10:49:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717094935.GF7163@stefanha-x1.localdomain>
References: <20170714100029.26288-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <20170714100029.26288-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ide: check BlockBackend object in
 ide_cancel_dma_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Chensongnian <chensongnian@huawei.com>, qemu-block@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 03:30:29PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> When cancelling pending DMA requests in ide_cancel_dma_sync,
> the s->blk object could be null, leading to a null dereference.
> Add check to avoid it.

Please include details on how to reproduce the bug and/or which code
path triggers this NULL dereference.

> Reported-by: Chensongnian <chensongnian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ide/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64..04474b3 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -681,8 +681,10 @@ void ide_cancel_dma_sync(IDEState *s)
>  #ifdef DEBUG_IDE
>          printf("%s: draining all remaining requests", __func__);
>  #endif
> -        blk_drain(s->blk);
> -        assert(s->bus->dma->aiocb =3D=3D NULL);
> +        if (s->blk) {
> +            blk_drain(s->blk);
> +            assert(s->bus->dma->aiocb =3D=3D NULL);
> +        }
>      }
>  }
> =20
> --=20
> 2.9.4
>=20
>=20

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbIgvAAoJEJykq7OBq3PIO4UIAJItq+Azz0IaKGFjHUuQt0rr
ttIb1hU7X5OzkNqpzxVfhmM0A/NrXIf33KC5F+etEm7xpDvsqExgQNEm54sHAo9r
5ImJf3yMU9E7bB/luT5nd3WCHQ22q2F5Fl9sSIx2jVleSzXA/rS6P4c7YE+CXwVC
U3eGe+LAFYx3neotgOvCg5OVMy0TaPy3hjEFX6uk2Aa34UqzVoPr0+lhB3qPgfvq
W+u2LKHyrgXLTZ9gjWMMciFEJSZwR5NQw5MacB8q2/mJL1XDsntmKOOy2CcQhaAq
spcwN1Fvffx+ue/kRTcpe53VUyfWjP8oCqFTIRTZEER9vfyUHOUIJ/DkYZyRc3Y=
=tuIe
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
