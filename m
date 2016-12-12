Received: from eggs.gnu.org ([2001:4830:134:3::10]:39561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRWm-0002nE-FP
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRWj-00045V-Be
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:24:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGRWj-00045H-5D
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:24:25 -0500
Date: Mon, 12 Dec 2016 14:24:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212142422.GJ4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/11] virtio: add MemoryListener to cache
 ring translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:55PM +0100, Paolo Bonzini wrote:
> @@ -103,6 +111,46 @@ struct VirtQueue
>      QLIST_ENTRY(VirtQueue) node;
>  };
> =20
> +static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
> +{
> +    address_space_cache_destroy(&caches->desc);
> +    address_space_cache_destroy(&caches->avail);
> +    address_space_cache_destroy(&caches->used);
> +    g_free(caches);
> +}
> +
> +static void virtio_init_region_cache(VirtIODevice *vdev, int i)

s/int i/int n/ - it seems to be the convention for virtqueue numbers.

> +{
> +    VirtQueue *vq =3D &vdev->vq[i];
> +    VRingMemoryRegionCaches *old =3D vq->vring.caches;
> +    VRingMemoryRegionCaches *new =3D g_new0(VRingMemoryRegionCaches, 1);
> +    hwaddr addr, size;
> +    int event_size;
> +
> +    event_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT=
_IDX) ? 2 : 0;
> +
> +    addr =3D vq->vring.desc;
> +    if (!addr) {
> +        return;
> +    }
> +    size =3D virtio_queue_get_desc_size(vdev, i);
> +    address_space_cache_init(&new->desc, &address_space_memory,
> +                             addr, size, false);

Missing error handling in case address_space_cache_init() fails.

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTrMWAAoJEJykq7OBq3PICnkH/3RprbASqV/HL7Gdv/wryEHK
aXFIenY3eJ5qNXFtqsTChC1j7QdGYz8IodBUARCtY6V5VAlcFukru8giFg1Gk+3g
r4dK5wCFbJ0dje+OuZuLlBghBZnW9j/XBMWVt2lmcXOaaMzuikY/PXQW2/XuHjjF
pUVCY61kzTU5uviJZujMs1tdlBujVRlOczzhSTnGdc2Ol5Z/o14w5JqbPp78I6J7
gZHExETaQpikPKUjOZO0A7U5QZ3iZBZcQP3VgyjRaFgKDayzJtDerNdzCXea6P17
wVOZS3mqZ553JNomLVO6OVsPMAoFCw1JVNsZWCNnqk/uxADekfkcuxJfQU19Xh8=
=JCYe
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
