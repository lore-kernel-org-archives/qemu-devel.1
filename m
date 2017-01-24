Received: from eggs.gnu.org ([2001:4830:134:3::10]:56392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0NQ-0006DS-8e
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0NK-0002xO-OF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:39:08 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0NK-0002ws-HH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:39:02 -0500
Received: by mail-lf0-x242.google.com with SMTP id q89so17123985lfi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:39:02 -0800 (PST)
Date: Tue, 24 Jan 2017 12:38:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124123857.GF17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] virtio: use VRingMemoryRegionCaches
 for descriptor ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 06:07:56PM +0100, Paolo Bonzini wrote:
> @@ -762,15 +761,14 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
> =20
>      i =3D head;
> =20
> -    len =3D address_space_cache_init(&vring_desc_cache, vdev->dma_as,
> -                                   vq->vring.desc, max * sizeof(VRingDes=
c),
> -                                   false);
> -    desc_cache =3D &vring_desc_cache;
> -    if (len < max * sizeof(VRingDesc)) {
> +    rcu_read_lock();
> +    caches =3D atomic_rcu_read(&vq->vring.caches);
> +    if (caches->desc.len < max * sizeof(VRingDesc)) {
>          virtio_error(vdev, "Cannot map descriptor ring");
>          return NULL;

Missing rcu_read_unlock() in all return cases.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0rhAAoJEJykq7OBq3PIClYH/34fXne0Uzb7z0hIYkD/lqSB
79jNzTwjGPgXHSVZjsesfqUsvxmtg7sZ7cwmOBpAqnjT4Vw5fRKjGIqrBcUcSU7m
hH6XP+rkloumhd9+akHF+ADRQqT+2IU2udt6LqGpBIoNrFgPKmEAEdrZWGFlXV8y
Xo16Bon9lmbFUCQFbtm2bPgW+z6bucjQyktHd5ahTeQgHW+8jekXZ7nXX0IsFYVQ
shCveH7mG0ZMVPZkRYqhR8IYwaxA1Zp7cJdulW3kk9zKj14U2+IdsTTI3JhWQSqj
gpC1bOMSiXZfoNvp1VqXKKROr/sts+cENtAXQIDOWre79nehxNbH+WQobhbxkUo=
=c6om
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
