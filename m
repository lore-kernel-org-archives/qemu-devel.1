Received: from eggs.gnu.org ([2001:4830:134:3::10]:40781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHpEP-0000xm-AJ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHpEK-0007PI-D2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:59:45 -0500
Date: Thu, 23 Nov 2017 10:59:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171123105934.GC26022@stefanha-x1.localdomain>
References: <1511408266-4139-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <1511408266-4139-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.11] virtio-net: don't touch virtqueue
 if vm is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 11:37:46AM +0800, Jason Wang wrote:
> Guest state should not be touched if VM is stopped, unfortunately we
> didn't check running state and tried to drain tx queue unconditionally
> in virtio_net_set_status(). A crash was then noticed as a migration
> destination when user type quit after virtqueue state is loaded but
> before region cache is initialized. In this case,
> virtio_net_drop_tx_queue_data() tries to access the uninitialized
> region cache.
>=20
> Fix this by only dropping tx queue data when vm is running.

hw/virtio/virtio.c:virtio_load() does the following:

  for (i =3D 0; i < num; i++) {
      if (vdev->vq[i].vring.desc) {
          uint16_t nheads;

          /*
           * VIRTIO-1 devices migrate desc, used, and avail ring addresses =
so
           * only the region cache needs to be set up.  Legacy devices need
           * to calculate used and avail ring addresses based on the desc
           * address.
           */
          if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
              virtio_init_region_cache(vdev, i);
          } else {
              virtio_queue_update_rings(vdev, i);
          }

So the region caches should be initialized after virtqueue state is
loaded.

It's unclear to me which code path triggers this issue.  Can you add a
backtrace or an explanation?

Thanks,
Stefan

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFqoWAAoJEJykq7OBq3PIMdoH/R/jJ5yfEoF8Qrk/4Puy6MCG
ftskNIYxicL4otpefODolRlkwI+Xrt5USiD4OErzs6EgZ2iNCvzK0abMI1Euwzja
BdU5eDYVmb629rMowf/ToDCEXxASQlgoYmBOj/uQVgedrlhiDW7Sszio63Ar+dqM
95poahiLonWuOyuqwrIqZKgix4EvsjdZBEotQMJcyRQDXM9T/ljXhujGvCvLLEss
jzBoNFab3z8L8oY/8C8Yl6zmYuLujTAIKImSXOA1r2BMBAB1OnGYbd37IWSNNbtk
zFvuoE0X3/EFdJIB+BUXZ/++vDzZi4rP9Y3uD1TxPQX4HIYDBTSJgLahbodOSrE=
=AgBv
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
