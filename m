Received: from eggs.gnu.org ([2001:4830:134:3::10]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMxS2-0005HN-NW
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMxRx-0002HN-2W
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:47:02 -0500
Date: Thu, 7 Dec 2017 14:46:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171207144632.GC7830@stefanha-x1.localdomain>
References: <20171206175414.27666-1-stefanha@redhat.com>
	<20171206184028.GD4207@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20171206184028.GD4207@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: avoid recursive
 AioContext acquire in bdrv_inactivate_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 07:40:28PM +0100, Kevin Wolf wrote:
> Am 06.12.2017 um 18:54 hat Stefan Hajnoczi geschrieben:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> >=20
> > BDRV_POLL_WHILE() does not support recursive AioContext locking.  It
> > only releases the AioContext lock once regardless of how many times the
> > caller has acquired it.  This results in a hang since the IOThread does
> > not make progress while the AioContext is still locked.
> >=20
> > The following steps trigger the hang:
> >=20
> >   $ qemu-system-x86_64 -M accel=3Dkvm -m 1G -cpu host \
> >                        -object iothread,id=3Diothread0 \
> >                        -device virtio-scsi-pci,iothread=3Diothread0 \
> >                        -drive if=3Dnone,id=3Ddrive0,file=3Dtest.img,for=
mat=3Draw \
> >                        -device scsi-hd,drive=3Ddrive0 \
> >                        -drive if=3Dnone,id=3Ddrive1,file=3Dtest.img,for=
mat=3Draw \
> >                        -device scsi-hd,drive=3Ddrive1
> >   $ qemu-system-x86_64 ...same options... \
> >                        -incoming tcp::1234
> >   (qemu) migrate tcp:127.0.0.1:1234
> >   ...hang...
>=20
> Please turn this into a test case.
>=20
> We should probably also update docs/devel/multiple-iothreads.txt.
> Currently it says:
>=20
>     aio_context_acquire()/aio_context_release() calls may be nested.
>     This means you can call them if you're not sure whether #2 applies.
>=20
> While technically that's still correct as far as the lock is concerned,
> the limitations of BDRV_POLL_WHILE() mean that in practice this is not a
> viable option any more at least in the context of the block layer.

Good point, will fix both things in v2.

Stefan

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKVRIAAoJEJykq7OBq3PIF+gIALKHTeXYDnHLD1A0hZUSLlf7
Zc0Tg4KW7aRl97BakYSXQmRsm2C4u1bbrV02NkmPSh5HtB7A7sokyI1D0dvFfbKy
b1Gr4kPl7mviwY1et7Q/lm/y+jcnXYAILkIE1hMVk+5s91r+zRJn7NLI1nh2tp2Z
7KKxI6gsrVF4J/9542yvmF6d+rI5X2xpOLMXbyylkRL4LkU4cPxwiBdky/o1KMpe
08dYPpZh8yKtQ4cgok13ZguTQdK0YPDjLY1u6WDw6Vy7kPnNXWtVHGBilNm/fBMM
RJJ6l7FnCzBhx8QKZkMWckaECQFuKCcAVmiPq07bYTyBoAU7vr2h63xeWXEdgA4=
=ZcOM
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
