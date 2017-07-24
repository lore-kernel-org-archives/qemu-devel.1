Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZav2-0007ys-By
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZauz-0001Bg-8p
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:48:56 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:32925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZauz-0001BR-2N
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:48:53 -0400
Received: by mail-it0-x241.google.com with SMTP id t6so7348558itb.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 03:48:52 -0700 (PDT)
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-2-aik@ozlabs.ru>
	<20170724055316.GJ17228@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
Date: Mon, 24 Jul 2017 20:48:45 +1000
MIME-Version: 1.0
In-Reply-To: <20170724055316.GJ17228@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j5bDNOA18HFO4JV3DbTsCgkccKB2XjKeb"
Subject: Re: [Qemu-devel] [PATCH qemu v4 1/3] spapr_iommu: Realloc guest
 visible TCE table when hot(un)plugging vfio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5bDNOA18HFO4JV3DbTsCgkccKB2XjKeb
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
Subject: Re: [PATCH qemu v4 1/3] spapr_iommu: Realloc guest visible TCE table
 when hot(un)plugging vfio-pci
References: <20170720072231.35054-1-aik@ozlabs.ru>
 <20170720072231.35054-2-aik@ozlabs.ru>
 <20170724055316.GJ17228@umbus.fritz.box>
In-Reply-To: <20170724055316.GJ17228@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 24/07/17 15:53, David Gibson wrote:
> On Thu, Jul 20, 2017 at 05:22:29PM +1000, Alexey Kardashevskiy wrote:
>> This replaces g_malloc() with spapr_tce_alloc_table() as this is
>> the standard way of allocating tables and this allows moving the table=

>> back to KVM when unplugging a VFIO PCI device and VFIO TCE acceleratio=
n
>> support is not present in the KVM.
>=20
> So, I like the idea here, and I think it will work for now, but one
> thing concerns me.
>=20
> AIUI, your future plans include allowing in-kernel accelerated TCE
> tables even with VFIO devices.  When that happens, we might have an
> in-kernel table both before and after a change in the "need_vfio"
> state.

The in-kernel table just stays there, mappings will be replayed but in th=
e
end of the replay only the hardware table will change.

>=20
> But you won't be able to have two in-kernel tables allocated at once,
> whereas this code relies on having both the old and new tables at once
> so it can copy the contents over.
>=20
> How do you intend to handle that?

I intend to make this function no-op when cap_spapr_vfio is present.


>=20
>> Although spapr_tce_alloc_table() is expected to fail with EBUSY
>> if called when previous fd is not closed yet, in practice we will not
>> see it because cap_spapr_vfio is false at the moment.
>=20
> I don't follow this.  How would cap_spapr_vfio be changing at any
> point?

It depends on the version of the host kernel.

>=20
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/ppc/spapr_iommu.c | 35 ++++++++++++++---------------------
>>  1 file changed, 14 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index e614621a83..307dc3021e 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -275,33 +275,26 @@ static int spapr_tce_table_realize(DeviceState *=
dev)
>>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
>>  {
>>      size_t table_size =3D tcet->nb_table * sizeof(uint64_t);
>> -    void *newtable;
>> +    uint64_t *oldtable;
>> +    int newfd =3D -1;
>> =20
>> -    if (need_vfio =3D=3D tcet->need_vfio) {
>> -        /* Nothing to do */
>> -        return;
>> -    }
>> +    g_assert(need_vfio !=3D tcet->need_vfio);
>> =20
>> -    if (!need_vfio) {
>> -        /* FIXME: We don't support transition back to KVM accelerated=

>> -         * TCEs yet */
>> -        return;
>> -    }
>> +    tcet->need_vfio =3D need_vfio;
>> =20
>> -    tcet->need_vfio =3D true;
>> +    oldtable =3D tcet->table;
>> =20
>> -    if (tcet->fd < 0) {
>> -        /* Table is already in userspace, nothing to be do */
>> -        return;
>> -    }
>> +    tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
>> +                                        tcet->page_shift,
>> +                                        tcet->bus_offset,
>> +                                        tcet->nb_table,
>> +                                        &newfd,
>> +                                        need_vfio);
>> +    memcpy(tcet->table, oldtable, table_size);
>> =20
>> -    newtable =3D g_malloc(table_size);
>> -    memcpy(newtable, tcet->table, table_size);
>> +    spapr_tce_free_table(oldtable, tcet->fd, tcet->nb_table);
>> =20
>> -    kvmppc_remove_spapr_tce(tcet->table, tcet->fd, tcet->nb_table);
>> -
>> -    tcet->fd =3D -1;
>> -    tcet->table =3D newtable;
>> +    tcet->fd =3D newfd;
>>  }
>> =20
>>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn=
)
>=20


--=20
Alexey


--j5bDNOA18HFO4JV3DbTsCgkccKB2XjKeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZddCODhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5/QEP/2Nx
hYG9Ow3L7QvjpdQVGsTi/jt4uJirta02hIVuMMq13PFCnU3xSkWORT8yTMldwjIp
2YYwUf5psfx4TJgB4q4SPEgn/lijJdYHjg9ibSzguYGi02LGOSqhAtTv2B7i8Erb
fIaSqMPq3QNMS+v6xqRz0HYD7MSjPY9+8udl+8m+GXkq15JqEKRysQ2+CgBdXEsv
EoWOvtUM5HN17FYsGPBs0tmRX+yQrROsj2AyZ3ALItz1PQ5c9d9tuENthNYysqi6
krSSdGZ8OqjUj3tPdBFgM5lF1ETKvzOmo2MF9tlrp/Af/ncsu/NLqYLMl+g6togU
lzKRSlsUNy/5EmshlAu62PN3WN9jU2Otpr071tDqmVS3c774aYLyv2z4ENh0DEAa
14naa5+FceWd/pU6JWWmCXcidYbfFFxUiVViEHC9ygFbR6sBS395ti4xaaWVRVkM
D3zuWse+eNb1vGDs/HQNq8K+Sl8CeHXpaHbBvh7VFQdi8tEte9qI3ihSLvOk6IVq
4dCU4DCqQTwrsb4P7gzvBxoxShWJ63f0A37us3pUt3lRiuRWxMfgWZFvY5XMqfDs
1Dv5ZPiKXNeYhSBnaJmBdltNvWzTk6snJFLRTWSXfJO/YZsCHd2zem3kHQ3UAFHd
td63E/9JOmPV9l3bDdWXGNNSHLkXc3xSApDtAwkB
=ZZjb
-----END PGP SIGNATURE-----

--j5bDNOA18HFO4JV3DbTsCgkccKB2XjKeb--
