Received: from eggs.gnu.org ([2001:4830:134:3::10]:34437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dIyQb-0007Sh-KA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dIyQX-00072l-Df
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:28:49 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dIyQX-00071s-2q
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:28:45 -0400
Received: by mail-pf0-x241.google.com with SMTP id y7so5311940pfd.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 07:28:43 -0700 (PDT)
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
Date: Fri, 9 Jun 2017 00:28:35 +1000
MIME-Version: 1.0
In-Reply-To: <20170608074250.GE25805@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3dNJXppJptRLelVka8t5pxFHamF82esxN"
Subject: Re: [Qemu-devel] [PATCH qemu v7] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3dNJXppJptRLelVka8t5pxFHamF82esxN
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
Subject: Re: [PATCH qemu v7] memory/iommu: QOM'fy IOMMU MemoryRegion
References: <20170607083243.8983-1-aik@ozlabs.ru>
 <20170608074250.GE25805@umbus.fritz.box>
In-Reply-To: <20170608074250.GE25805@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 08/06/17 17:42, David Gibson wrote:
> On Wed, Jun 07, 2017 at 06:32:43PM +1000, Alexey Kardashevskiy wrote:
>> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
>> as a parent.
>>
>> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
>> dymanic QOM casting in fast path (address_space_translate, etc),
>> this adds an @is_iommu boolean flag to MR and provides new helper to
>> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
>> is set in the instance init callback. This defines
>> memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
>>
>> This switches MemoryRegion to IOMMUMemoryRegion in most places except
>> the ones where MemoryRegion may be an alias.
>>
>> This defines memory_region_init_iommu_type() to allow creating
>> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
>> this splits memory_region_init() to object_initialize() +
>> memory_region_do_init.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> So.. this seems like an only halfway QOMification.  The main init
> function still takes an ops structure, whereas the QOMish way to do
> this would be to have the base IOMMUMemoryRegion be an abstract class,
> and have the IOMMUOps pointers as part of the IOMMUMemoryRegionClass.

This would mean getting the class pointer from an IOMMUMR object every ti=
me
IOMMUOps::translate() is called and Paolo pointed out earlier that we do
not want that in the fast path.


>=20
> Maybe you can persuade me this is a useful interim step?
>=20
> [snip]
>> -void memory_region_init_iommu(MemoryRegion *mr,
>> -                              Object *owner,
>> -                              const MemoryRegionIOMMUOps *ops,
>> -                              const char *name,
>> -                              uint64_t size)
>> +void memory_region_init_iommu_type(const char *mrtypename,
>> +                                   IOMMUMemoryRegion *iommu_mr,
>> +                                   Object *owner,
>> +                                   const MemoryRegionIOMMUOps *ops,
>> +                                   const char *name,
>> +                                   uint64_t size)
>>  {
>> -    memory_region_init(mr, owner, name, size);
>> -    mr->iommu_ops =3D ops,
>> +    struct MemoryRegion *mr;
>> +    size_t instance_size =3D object_type_get_instance_size(mrtypename=
);
>> +
>> +    object_initialize(iommu_mr, instance_size, mrtypename);
>=20
> This looks exceedingly dangerous.  AIUI, the entire purpose of the
> size parameter to object_initialize() (which can certainly get the
> instance size from the type, just as you do) is to verify that the
> buffer you're initializing actually has space for the object type
> you're putting there.
>=20
> By looking up the instance size yourself and passing it to
> object_initialize(), you're disabling that check.
>=20
> If someone allocates an array of plain IOMMUMemoryRegion structures,
> then uses this to initialize a derived IOMMU MR type with more fields,
> the user will get no warning that something is wrong before the memory
> corruption starts.

Hm. How can I fix it then for a generic case? Pass the actual amount of
bytes occupied by *iommu_mr?


--=20
Alexey


--3dNJXppJptRLelVka8t5pxFHamF82esxN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZOV8TDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5XRgP/0rg
F2n3ot3jjjB/emFUJfcm2VnpLGWhpH9NvPC3N1yPepthtZTITdSUPKglVxzrzgTK
pHMVd3Yr45l9yrBFZLNlv2Z4F57vyRwUwMR/y6W2f6mc7sqW2ZyKjFQxMm1iY9wL
5k4r4tJv1960+VH5XYS4F/QtJ1D6jehRW8M1wb5Kmzr5nsxoAhbU4QsR1wO938NQ
ZMduz7a0PC/AG7hZFdu2fMMtRFKwpDPOcGhiYFJZh0HvFvVhlAPQGUilqZ3pszN3
e+xErimG3ajAbSANE5I3jJh+xiVVQ+Ro0/Wh1KBZZu5z/ShSUbnpGsuxormTUqPv
4S2MmQ3b8Yn6eMQ5gGbkZ4j1/XtFJth65F5ZlDem3DmAzwbFr5j23Frxe9Nk8nr7
BdTP9IG+IKTFxZ/oSkCK/L0mlPo6BND8fglF1C5TocPFcgAOyiQe9h7AHbrhO6f1
AtOqT9rxgZoRMwNhWNg3Yg/6JNrn/thLhugppyjbaeSUEqnmF/YCO2R7T/gpu5RR
8tCb38lLSc6E4Lp56dkOwo2bqNdYsvqGjMjY6Ly0XW6kRBa79KcxZiOsqlWMPbHa
bRxKcH7WYo7S6qRR2Yvj/sjwZBl51LrPJQHTkP/ufaii9QYMKKHAxs4ZpZBLQ1SN
ieWBAS88QImc6Y3HYgsa6jDtJiIPzlgUltN9/b6z
=zSqb
-----END PGP SIGNATURE-----

--3dNJXppJptRLelVka8t5pxFHamF82esxN--
