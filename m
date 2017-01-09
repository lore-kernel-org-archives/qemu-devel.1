Received: from eggs.gnu.org ([2001:4830:134:3::10]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cQPLj-0000VN-1K
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cQPLf-0000Ti-Q1
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:06:14 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cQPLf-0000TE-Jd
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:06:11 -0500
Received: by mail-pg0-x242.google.com with SMTP id 194so5667288pgd.0
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 18:06:09 -0800 (PST)
References: <20161222052212.49006-1-aik@ozlabs.ru>
	<20161222052212.49006-3-aik@ozlabs.ru>
	<20170102234128.GI12761@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <61109e6f-434a-303e-f0fc-bf1dab1ed63f@ozlabs.ru>
Date: Mon, 9 Jan 2017 13:06:03 +1100
MIME-Version: 1.0
In-Reply-To: <20170102234128.GI12761@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Pr8BiHaBVHEkmL4C1uoLbwuwCqbBx863"
Subject: Re: [Qemu-devel] [PATCH qemu 2/2] spapr_pci: Advertise 16M IOMMU
 pages when available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Pr8BiHaBVHEkmL4C1uoLbwuwCqbBx863
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <61109e6f-434a-303e-f0fc-bf1dab1ed63f@ozlabs.ru>
Subject: Re: [PATCH qemu 2/2] spapr_pci: Advertise 16M IOMMU pages when
 available
References: <20161222052212.49006-1-aik@ozlabs.ru>
 <20161222052212.49006-3-aik@ozlabs.ru>
 <20170102234128.GI12761@umbus.fritz.box>
In-Reply-To: <20170102234128.GI12761@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 03/01/17 10:41, David Gibson wrote:
> On Thu, Dec 22, 2016 at 04:22:12PM +1100, Alexey Kardashevskiy wrote:
>> On sPAPR, IOMMU page size varies and if QEMU is running with RAM
>> backed with hugepages, we can advertise this to the guest so does
>> this patch.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/ppc/spapr_pci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index fd6fc1d953..09244056fc 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1505,6 +1505,9 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
>>      }
>> =20
>>      /* DMA setup */
>> +    /* This allows huge pages for IOMMU when guest is backed with hug=
e pages */
>> +    sphb->page_size_mask |=3D qemu_getrampagesize();
>=20
> This doesn't look right - you're unconditionally enabling the host ram
> page size, regardless of anything else.  Instead the backing page size
> should be used to filter out those sizes which are possible from the
> list of those supported by the guest hardware.  This patch will give
> particularly odd results if you ran it on x86 with hugepages for
> example: it would advertise a 2M IOMMU page size, which could never
> exist on native POWER.

Ok, I'll filter 16M out if passed to PHB and not supported by the host.


> Except... come to think of it, why is the backing RAM page size
> relevant at all?=20

Because this is just an optimization/acceleration and I'd think the user
wants to know if it is actually accelerated or not. If I always allow 16M=

pages, and QEMU is not backed with hugepages, then all H_PUT_TCE will go
via slow path and consume as much memory for TCE as without hugepages, an=
d
it will only be visible to the user if TCE-tracepoints are enabled.

> Or rather.. I think VFIO should be able to cope with
> any guest IOMMU page size which is larger than the host ram page size

It could, I just do not see much benefit in it. pseries guest can negotia=
te
4k, 64k, 16m pages and this seems to cover everything we want, why would =
we
want to emulate IOMMU page size?

> (although if it's much larger it could get expensive in the host
> tables).  This case would already be routine for ppc64 on x86, where
> the guest IOMMU page size is 64kiB, but the host page size is 4 kiB.




--=20
Alexey


--3Pr8BiHaBVHEkmL4C1uoLbwuwCqbBx863
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYcvALDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC57NQQAKmt
ExVk/5JdK5jpWGjc7O08MAGSgq2X3fuTifMqaeioQ0ZSwDHZFUDQYWUCqImtgHYl
J0jdf8FLh0N/ExuXz7ZkM1P+9+J/whNoRVWxIVC1ZRiQfavnwLTucjJlOjAqXKlI
yg67O1U4VYY0MhRGGsh3EWli09v7Dnlj585GQ0rKgG0kb8e14mhmKO4vFxvgSOK2
MOyCuk4L4WD6X+8Ga3DwUSZMKYeczZEMaGrUiHOqDWeTnXgZVlAPMBRgGm+EAkMf
78wCEogNOXHL8yy4NAE1OY/FoN5SttWRDQbxMmRHnoKYMZyXSX7CHlw5OwYvz+Tc
DCdovkGSMPZXodGMbVvA8F5/EB1pf3tdyhypPV/SAH9drkbarl75mA89P2WGHAvW
0+LoJjbaf6KhcQh7b+8dQ3lEHyysv04sZ+Psx4ZpBH5fDbwW2npe9Bp+NdfsO9aD
izBss4ykx3RQGUQug+TxPfMbRNzmClzSLMB5Vbkpq/YRbIszUuMKU02DrPPbCFhk
/ZgXdm1Zodl9xfdsDi0UdXqN0YTFv6Nv/aurdH2QJs4Lzc1yhZj95hQ47H14Cep+
DBlTFzum+uutrhKNPcSaUX8/1cNURalFZQCGYjjfeEQBgVgbq9Sfw49bDalto1b6
Zhy56kVsKaIxtAUG3QjGvKhorkTDGUqaeA0KbJ0j
=hl1S
-----END PGP SIGNATURE-----

--3Pr8BiHaBVHEkmL4C1uoLbwuwCqbBx863--
