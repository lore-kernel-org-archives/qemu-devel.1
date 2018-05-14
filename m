Received: from eggs.gnu.org ([2001:4830:134:3::10]:44555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIE7C-0008DB-1H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIE77-0007JW-Rx
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:06:14 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fIE77-0007J0-Iw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:06:09 -0400
Received: by mail-wm0-x22d.google.com with SMTP id a137-v6so11942348wme.1
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:06:09 -0700 (PDT)
Date: Mon, 14 May 2018 15:06:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514140606.GF5182@stefanha-x1.localdomain>
References: <152625681679.27592.11833589256802380892.malonedeb@wampee.canonical.com>
	<152626684503.26828.16869042301439556281.malone@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <152626684503.26828.16869042301439556281.malone@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1771042] Re: dataplane interrupt handler
 doesn't support msi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1771042 <1771042@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 03:00:44AM -0000, eric hoffman wrote:
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
> index 101f32c..31d9eb8 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -73,7 +73,7 @@ static void notify_guest_bh(void *opaque)
>              unsigned i =3D j + ctzl(bits);
>              VirtQueue *vq =3D virtio_get_queue(s->vdev, i);
>=20
> -            virtio_notify_irqfd(s->vdev, vq);
> +            virtio_notify(s->vdev, vq);
>=20
>              bits &=3D bits - 1; /* clear right-most bit */
>          }

Please send patches to qemu-devel@nongnu.org.  Guidelines for submitting
patches are here:
https://wiki.qemu.org/Contribute/SubmitAPatch

The issue with this approach is that hw/pci/msi.c:msi_send_message()
invokes device emulation outside the QEMU global mutex (it calls into
the APIC to send MSIs).  I've CCed Paolo Bonzini to check whether doing
this is thread-safe.

Stefan

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZfOAAoJEJykq7OBq3PI+2cIAJ6aYNlLJ0X5ARnVh4zErJ56
d5WbV9oPhkopSqqXnaaP1LH6l78oGJJPgPpIwrNhoeNcfc6K4akPGdYgW3qv3R9S
nJpBpCUrVwZXYJPXgkVNV5vNYhd/ZQrkXrRuEGKOyebOrfNEkWtnNI+Nj/1PKYfs
8DwwxE0ehJ0gyacFzCyEKx2YcIXMGl5ycJy5TmO/qe1D0rEg54s/ZkU9Wz/2mqoh
aIBHt63FwlpCH0R32Q0uVAO2tjw1ynB7ZChjbvVj2PsQ6SapB8x1XfoByRkTgX1c
a52KU4hw/LbsyKZe9fB/oGjjAUrohYOAUN0MQDZ8ZzfJK+vBkado7n3ZKyzY0l8=
=ha6i
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
