Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRg6e-0001KX-1g
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRg6Z-0006BH-9Q
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:11:56 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cRg6Z-0006Av-26
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:11:51 -0500
Received: by mail-wm0-x242.google.com with SMTP id l2so3989888wml.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:11:50 -0800 (PST)
Date: Thu, 12 Jan 2017 14:11:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170112141145.GA14042@stefanha-x1.localdomain>
References: <20170112105132.10394-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20170112105132.10394-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ide: avoid unbounded recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Peter Lieven <pl@kamp.de>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 11:51:32AM +0100, Paolo Bonzini wrote:
> The end_transfer_func can call ide_transfer_start immediately, before
> returning, and unbounded recursion can happen at least for
> ide_atapi_cmd_reply_end.  Use a bottom half to defer the call and
> limit stack usage.
>=20
> Cc: Peter Lieven <pl@kamp.de>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/core.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 43709e5..7b9831f 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -482,6 +482,13 @@ static void ide_clear_retry(IDEState *s)
>      s->bus->retry_nsector =3D 0;
>  }
> =20
> +static void ide_start_transfer_bh_cb(void *opaque)
> +{
> +    IDEDMA *dma =3D opaque;
> +
> +    dma->ops->start_transfer(dma);
> +}
> +
>  /* prepare data transfer and tell what to do after */
>  void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
>                          EndTransferFunc *end_transfer_func)
> @@ -494,7 +501,12 @@ void ide_transfer_start(IDEState *s, uint8_t *buf, i=
nt size,
>          s->status |=3D DRQ_STAT;
>      }
>      if (s->bus->dma->ops->start_transfer) {
> -        s->bus->dma->ops->start_transfer(s->bus->dma);
> +        /* There can be unbounded recursion between ops->start_transfer
> +         * and end_transfer_func, so defer to a bottom half.
> +         */
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                ide_start_transfer_bh_cb,
> +                                s->bus->dma);

Are you sure this is safe?

I wonder if there are races with device reset, vmsave, or vcpu hw
register accesses.

Stefan

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd46hAAoJEJykq7OBq3PIBAwIAI+tjPe4+cbr/RFLPi87kycg
YWV1wQe1mLgam3s7v3cvJRGWutr2zH2eItE8nf7eigywHL3cNMYqefvfZMnUNZ3n
Sas8cUllR1SJfSpeTP0JvzvUSvC/p6ccyM38GE8CuIGPKqxZR98e/EUO4fxiIXDg
mLOT8O/lopOSIbNaIWl5bckBfO8ueGRoeCNrj0nOMNyE2j1gIGdjLVEvzamsSOC9
/X7Es000k8i0n114oKw4GyboBKuv0cYdN4f+CKsktZPIuKvdR/I/RrSJOVElOFwz
yq1ThL0GT0eH7qO6w1RkQzrGTHGbEOUgf6pVWG2377IzdUpxl0VS9xtCh0J+lnU=
=lxGy
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
