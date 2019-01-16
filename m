Received: from eggs.gnu.org ([209.51.188.92]:48223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjmTA-0002bL-B2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjmT8-0005sI-Vk
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:47:03 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-5-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c7cfe1c-16c6-fe1b-0e9f-796502e75652@redhat.com>
Date: Wed, 16 Jan 2019 08:46:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190116113523.9213-5-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yew53mLNKnEItfU40UPOWxQnTBMluVs7W"
Subject: Re: [Qemu-devel] [PATCH RFC 04/10] virtio-pmem: Prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yew53mLNKnEItfU40UPOWxQnTBMluVs7W
From: Eric Blake <eblake@redhat.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pankaj Gupta <pagupta@redhat.com>
Message-ID: <7c7cfe1c-16c6-fe1b-0e9f-796502e75652@redhat.com>
Subject: Re: [PATCH RFC 04/10] virtio-pmem: Prototype
References: <20190116113523.9213-1-david@redhat.com>
 <20190116113523.9213-5-david@redhat.com>
In-Reply-To: <20190116113523.9213-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 5:35 AM, David Hildenbrand wrote:
> From: Pankaj Gupta <pagupta@redhat.com>
>=20
> This is the current protoype of virtio-pmem. Support will require
> machine changes for the architectures that will support it, so it will
> not yet be compiled.
>=20
> TODO:
> - Use separate struct for tracking requests internally
> - Move request/response structs to linux headers
> - Factor out linux header sync
> - Drop debug printfs
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",=

>   split up patches, unplug handler ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

> +++ b/qapi/misc.json
> @@ -2949,6 +2949,29 @@
>            }
>  }
> =20
> +##
> +# @VirtioPMEMDeviceInfo:
> +#
> +# VirtioPMEM state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 3.1

Now 4.0

> +##
> +{ 'struct': 'VirtioPMEMDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',
> +            'size': 'size',
> +            'memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
> @@ -2958,7 +2981,8 @@
>  ##
>  { 'union': 'MemoryDeviceInfo',

Does this union need a documentation update that virtio-pmem was added
in 4.0?

>    'data': { 'dimm': 'PCDIMMDeviceInfo',
> -            'nvdimm': 'PCDIMMDeviceInfo'
> +            'nvdimm': 'PCDIMMDeviceInfo',
> +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
>            }
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yew53mLNKnEItfU40UPOWxQnTBMluVs7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/Q90ACgkQp6FrSiUn
Q2pDrggAofH1RvgSodXgwWsunId0RUHbhIoySPgGB9+7u1R7vaSzLwO7Y5MQ+Ljd
UqD/ay9eoGxnGKXUqcrcjikI1+7Q+Dmi0a9bD4oyR/huOpZ4I/P85g9YIi2NL7RT
X+2WUltLX35MdCRSlyzXos0awzXwwdH4VfFw/IJW8b709egvWR3Boo2ELh80pkRN
bLyR5RDxJm4hBrUbV/9/SOMFrLXDjt9akR95Ef+LzsIZ8/IpRsGnMtObgT2CrwI4
xIrNDxTpQ79lzD+AESLBX3Zf23mIFay0D7yiKsHQIXt6bAE6DdIIOdA5m+NnYf0W
CKTwUxzpdIN1Su2WjHpKapTGUqav/A==
=+dqa
-----END PGP SIGNATURE-----

--yew53mLNKnEItfU40UPOWxQnTBMluVs7W--
