Received: from eggs.gnu.org ([2001:4830:134:3::10]:34881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZWLy-0001fd-DA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZWLv-0007IO-AX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:56:26 -0400
Date: Mon, 24 Jul 2017 15:53:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724055316.GJ17228@umbus.fritz.box>
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Content-Disposition: inline
In-Reply-To: <20170720072231.35054-2-aik@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 05:22:29PM +1000, Alexey Kardashevskiy wrote:
> This replaces g_malloc() with spapr_tce_alloc_table() as this is
> the standard way of allocating tables and this allows moving the table
> back to KVM when unplugging a VFIO PCI device and VFIO TCE acceleration
> support is not present in the KVM.

So, I like the idea here, and I think it will work for now, but one
thing concerns me.

AIUI, your future plans include allowing in-kernel accelerated TCE
tables even with VFIO devices.  When that happens, we might have an
in-kernel table both before and after a change in the "need_vfio"
state.

But you won't be able to have two in-kernel tables allocated at once,
whereas this code relies on having both the old and new tables at once
so it can copy the contents over.

How do you intend to handle that?

> Although spapr_tce_alloc_table() is expected to fail with EBUSY
> if called when previous fd is not closed yet, in practice we will not
> see it because cap_spapr_vfio is false at the moment.

I don't follow this.  How would cap_spapr_vfio be changing at any
point?

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/ppc/spapr_iommu.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index e614621a83..307dc3021e 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -275,33 +275,26 @@ static int spapr_tce_table_realize(DeviceState *dev)
>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
>  {
>      size_t table_size =3D tcet->nb_table * sizeof(uint64_t);
> -    void *newtable;
> +    uint64_t *oldtable;
> +    int newfd =3D -1;
> =20
> -    if (need_vfio =3D=3D tcet->need_vfio) {
> -        /* Nothing to do */
> -        return;
> -    }
> +    g_assert(need_vfio !=3D tcet->need_vfio);
> =20
> -    if (!need_vfio) {
> -        /* FIXME: We don't support transition back to KVM accelerated
> -         * TCEs yet */
> -        return;
> -    }
> +    tcet->need_vfio =3D need_vfio;
> =20
> -    tcet->need_vfio =3D true;
> +    oldtable =3D tcet->table;
> =20
> -    if (tcet->fd < 0) {
> -        /* Table is already in userspace, nothing to be do */
> -        return;
> -    }
> +    tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
> +                                        tcet->page_shift,
> +                                        tcet->bus_offset,
> +                                        tcet->nb_table,
> +                                        &newfd,
> +                                        need_vfio);
> +    memcpy(tcet->table, oldtable, table_size);
> =20
> -    newtable =3D g_malloc(table_size);
> -    memcpy(newtable, tcet->table, table_size);
> +    spapr_tce_free_table(oldtable, tcet->fd, tcet->nb_table);
> =20
> -    kvmppc_remove_spapr_tce(tcet->table, tcet->fd, tcet->nb_table);
> -
> -    tcet->fd =3D -1;
> -    tcet->table =3D newtable;
> +    tcet->fd =3D newfd;
>  }
> =20
>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1i0kACgkQbDjKyiDZ
s5JdHBAAxfdZBjQqOP8d/RJSMVqz968JTpX3GHg9YZh2MrQQefL7JSbGDneXvOFq
NlOmh8EFQ2QFOgveyW2dH3wEdMl2QrhmIziZ8YMAdfuYFckBuryNzkE/sdKN7vgU
NmY6eq+5f84pmy8vBNCBMMgky2lBf0GQijr/1J36BjCjWWL5O5BxzaXSc3Ydsc4A
4bB1cBioebULswFtTWFjSW8gG52Sq+gicyaUjCUADWJk/Aj+zROonLG1qnqI1ZYl
B46gnzjuUSmD82UBGuCI4awgjvEanTNDIvMcvV4INiD5yxB70zEVA0/fyB9+7db9
K9I2OlYfBir8mjcxZHA1U5jQO7GS+GmHZElxNkmrw1RqkjmTW7UEyn3k3VOnhXAo
SO9GKFI4zM2xysFi58iYt5c40TGZYrpk+apFm9TXTr/+oBJl/jM05e4uZ17VTWds
uTik1rV5QdSmKr2Lzu/jeJ5NPh/YvD5W9tjHdmRyeSx4nPVSgsTKao0/Fp7UI/Wk
pp4UW593Ug/W9/bY09XvxMX7EMbS7WIlUhnXQkvhB+97SjLXYnofshPthWEo40ly
9XxKTpFU5msLC0DRnxuOmaswR7huq3POyvWF6g8RFvlNffOCNhwlE+sHgQgvOgzc
Y+T4F1NMYxhWnt4Jg1T7X5TN3QW7fhIf6+gHD1WBGLD2y3Bi7bM=
=keJP
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--
