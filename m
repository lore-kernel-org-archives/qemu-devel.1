Received: from eggs.gnu.org ([2001:4830:134:3::10]:35344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWOC2-0001mA-Or
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWOC1-00035M-W3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:04:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWOC1-000354-NU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:04:57 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E84E37FB6B
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 14:04:57 +0000 (UTC)
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-4-pbonzini@redhat.com>
	<20170125132252.GD10664@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f336403-087e-7d54-342d-67d7e7ed0f67@redhat.com>
Date: Wed, 25 Jan 2017 15:04:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170125132252.GD10664@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l61r9v1ffM6176JM20F6aE5tNlVNQCF73"
Subject: Re: [Qemu-devel] [PATCH 3/8] virtio: use address_space_map/unmap to
 access descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l61r9v1ffM6176JM20F6aE5tNlVNQCF73
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Message-ID: <8f336403-087e-7d54-342d-67d7e7ed0f67@redhat.com>
Subject: Re: [PATCH 3/8] virtio: use address_space_map/unmap to access
 descriptors
References: <20170124180420.12430-1-pbonzini@redhat.com>
 <20170124180420.12430-4-pbonzini@redhat.com>
 <20170125132252.GD10664@stefanha-x1.localdomain>
In-Reply-To: <20170125132252.GD10664@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/01/2017 14:22, Stefan Hajnoczi wrote:
> On Tue, Jan 24, 2017 at 07:04:15PM +0100, Paolo Bonzini wrote:
>> @@ -689,18 +714,34 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>>      }
>> =20
>>      i =3D head;
>> -    vring_desc_read(vdev, &desc, desc_pa, i);
>> +
>> +    len =3D max * sizeof(VRingDesc);
>> +    vring_desc_ptr =3D address_space_map(vdev->dma_as, vq->vring.desc=
, &len, false);
>> +    if (len < max * sizeof(VRingDesc)) {
>> +        virtio_error(vdev, "Cannot map descriptor ring");
>> +        return NULL;
>=20
> Missing address_space_unmap() if vring_desc_ptr is non-NULL.
>=20

Will send v3 with just

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1b421cb..7517f7c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -719,7 +719,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     vring_desc_ptr =3D address_space_map(vdev->dma_as, vq->vring.desc, &=
len, false);
     if (len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
-        return NULL;
+        goto done;
     }
=20
     desc_ptr =3D vring_desc_ptr;

Paolo


--l61r9v1ffM6176JM20F6aE5tNlVNQCF73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYiLCBAAoJEL/70l94x66Dzh8H/jrU8Xrq56mvrI2tO5bGHl+R
GA4dLhPprffKQIHjdcTso5hWrCC3IF5ZjgS5ox4b6fRThU5jYUpOlHPG4IygFLcw
kPJv/6715/5qqZFT+piJFIT5yJKUqQI0xEAp9xYI82vC4vgz/3Qd3c8OnDN+eKEB
JFLYql/NAG9oXASeQcfEuNNu0xLM43MbUdbmR1geWrwuHCd6Ilbf0u5T9y2UMQse
tEMufoLETTDYQ5vD2pkpRQD/RIAhUupXiKqmciZDnfQ0hMjvl6ujsASwtuQDEgr2
HonowzyWN+4mRihk35zSFeuUqUr60jMFuXraBnxY0odC6dfIqyCJ6uJqUkfwEbU=
=sl/o
-----END PGP SIGNATURE-----

--l61r9v1ffM6176JM20F6aE5tNlVNQCF73--
