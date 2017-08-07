Received: from eggs.gnu.org ([2001:4830:134:3::10]:39028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1decTt-0006Yz-2T
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1decTq-0003tI-0R
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:29:41 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1decTp-0003sh-OH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:29:37 -0400
Received: by mail-pf0-x243.google.com with SMTP id t83so8262655pfj.3
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 00:29:36 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-2-aik@ozlabs.ru>
	<20170724055316.GJ17228@umbus.fritz.box>
	<81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
Message-ID: <3f0ca192-488d-73fe-83c1-8ced9757a470@ozlabs.ru>
Date: Mon, 7 Aug 2017 17:29:29 +1000
MIME-Version: 1.0
In-Reply-To: <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wlABdXILIwD2RL5HJooDrCNaq12Ev7dsT"
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
--wlABdXILIwD2RL5HJooDrCNaq12Ev7dsT
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <3f0ca192-488d-73fe-83c1-8ced9757a470@ozlabs.ru>
Subject: Re: [PATCH qemu v4 1/3] spapr_iommu: Realloc guest visible TCE table
 when hot(un)plugging vfio-pci
References: <20170720072231.35054-1-aik@ozlabs.ru>
 <20170720072231.35054-2-aik@ozlabs.ru>
 <20170724055316.GJ17228@umbus.fritz.box>
 <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
In-Reply-To: <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/07/17 20:48, Alexey Kardashevskiy wrote:
> On 24/07/17 15:53, David Gibson wrote:
>> On Thu, Jul 20, 2017 at 05:22:29PM +1000, Alexey Kardashevskiy wrote:
>>> This replaces g_malloc() with spapr_tce_alloc_table() as this is
>>> the standard way of allocating tables and this allows moving the tabl=
e
>>> back to KVM when unplugging a VFIO PCI device and VFIO TCE accelerati=
on
>>> support is not present in the KVM.
>>
>> So, I like the idea here, and I think it will work for now, but one
>> thing concerns me.
>>
>> AIUI, your future plans include allowing in-kernel accelerated TCE
>> tables even with VFIO devices.  When that happens, we might have an
>> in-kernel table both before and after a change in the "need_vfio"
>> state.
>=20
> The in-kernel table just stays there, mappings will be replayed but in =
the
> end of the replay only the hardware table will change.
>=20
>>
>> But you won't be able to have two in-kernel tables allocated at once,
>> whereas this code relies on having both the old and new tables at once=

>> so it can copy the contents over.
>>
>> How do you intend to handle that?
>=20
> I intend to make this function no-op when cap_spapr_vfio is present.
>=20
>=20
>>
>>> Although spapr_tce_alloc_table() is expected to fail with EBUSY
>>> if called when previous fd is not closed yet, in practice we will not=

>>> see it because cap_spapr_vfio is false at the moment.
>>
>> I don't follow this.  How would cap_spapr_vfio be changing at any
>> point?
>=20
> It depends on the version of the host kernel.


Ping?


>=20
>>
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  hw/ppc/spapr_iommu.c | 35 ++++++++++++++---------------------
>>>  1 file changed, 14 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>>> index e614621a83..307dc3021e 100644
>>> --- a/hw/ppc/spapr_iommu.c
>>> +++ b/hw/ppc/spapr_iommu.c
>>> @@ -275,33 +275,26 @@ static int spapr_tce_table_realize(DeviceState =
*dev)
>>>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
>>>  {
>>>      size_t table_size =3D tcet->nb_table * sizeof(uint64_t);
>>> -    void *newtable;
>>> +    uint64_t *oldtable;
>>> +    int newfd =3D -1;
>>> =20
>>> -    if (need_vfio =3D=3D tcet->need_vfio) {
>>> -        /* Nothing to do */
>>> -        return;
>>> -    }
>>> +    g_assert(need_vfio !=3D tcet->need_vfio);
>>> =20
>>> -    if (!need_vfio) {
>>> -        /* FIXME: We don't support transition back to KVM accelerate=
d
>>> -         * TCEs yet */
>>> -        return;
>>> -    }
>>> +    tcet->need_vfio =3D need_vfio;
>>> =20
>>> -    tcet->need_vfio =3D true;
>>> +    oldtable =3D tcet->table;
>>> =20
>>> -    if (tcet->fd < 0) {
>>> -        /* Table is already in userspace, nothing to be do */
>>> -        return;
>>> -    }
>>> +    tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
>>> +                                        tcet->page_shift,
>>> +                                        tcet->bus_offset,
>>> +                                        tcet->nb_table,
>>> +                                        &newfd,
>>> +                                        need_vfio);
>>> +    memcpy(tcet->table, oldtable, table_size);
>>> =20
>>> -    newtable =3D g_malloc(table_size);
>>> -    memcpy(newtable, tcet->table, table_size);
>>> +    spapr_tce_free_table(oldtable, tcet->fd, tcet->nb_table);
>>> =20
>>> -    kvmppc_remove_spapr_tce(tcet->table, tcet->fd, tcet->nb_table);
>>> -
>>> -    tcet->fd =3D -1;
>>> -    tcet->table =3D newtable;
>>> +    tcet->fd =3D newfd;
>>>  }
>>> =20
>>>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liob=
n)
>>
>=20
>=20


--=20
Alexey


--wlABdXILIwD2RL5HJooDrCNaq12Ev7dsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZiBbZDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5LosQAIHF
xUz/C6IEsXmFrPZMepTJgTu0kSSTCpNKicQTgqMSWXDTtKzhoAMhwi8/izeYgrcg
K0Ncuc+Xu0QtrxaluTCu432OCAs9sARXxzqDGGfUmK2KkGrNQ6tQxyRtVzFg/SEF
dCVW+3rHWVtVr274u9fFn34dn5IEdMHlKlREQAMm+T8fK66UdBiJfsczPcBwltVE
N2NdM4PJkdlxnp92778A2vYwSkJlbbsoK+NSuyDbIpkyvz5ocyqAPRO7rgXXSftn
RRodVc6cUwT0DOWO0BDmThmjnuvufPafOkwpzESKa6fzQdyZs58fT9N1KeWW4Vw2
dSBl5V2z0jF1x5QuHIB1wSCIQzPoc+dvVN4iIRdcPXjHHEF0xnpdoPTStymR3kYs
tfpps9/uO4pfTkDejLb6N2A8r+xs9MHIlGRaqYDFhy1MUmD0OpHQ/sp3wkhhNFDj
05kUfNGTMlsVg2bV+EHh/6XKXUd6Yy6tWO1w8D9R90AnI9HBYpYXpFWDzIBJ2VL3
QLdFNiUi+MDU4Ui4pgm4exa945R5reIZY45VkqwH2DwV4WImPKyHpcX23IYiZpzc
bJF+6ouFBbOmcX7FbJhyL8b9k5cAOXtlqWxBfYaj5HN2jeAH6d8nZRydolY7A12N
LHwRM/Naxm2z5PMKK+rIUH461taATudxIXEgY21A
=oxcF
-----END PGP SIGNATURE-----

--wlABdXILIwD2RL5HJooDrCNaq12Ev7dsT--
