Received: from eggs.gnu.org ([2001:4830:134:3::10]:47958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfRYY-0002PK-Et
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfRYS-00027p-Hj
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:01:54 -0400
Date: Wed, 9 Aug 2017 17:33:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170809073346.GR13670@umbus.fritz.box>
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-2-aik@ozlabs.ru>
	<20170724055316.GJ17228@umbus.fritz.box>
	<81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b0op/nKJ9CeIhp9z"
Content-Disposition: inline
In-Reply-To: <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
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


--b0op/nKJ9CeIhp9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 08:48:45PM +1000, Alexey Kardashevskiy wrote:
> On 24/07/17 15:53, David Gibson wrote:
> > On Thu, Jul 20, 2017 at 05:22:29PM +1000, Alexey Kardashevskiy wrote:
> >> This replaces g_malloc() with spapr_tce_alloc_table() as this is
> >> the standard way of allocating tables and this allows moving the table
> >> back to KVM when unplugging a VFIO PCI device and VFIO TCE acceleration
> >> support is not present in the KVM.
> >=20
> > So, I like the idea here, and I think it will work for now, but one
> > thing concerns me.
> >=20
> > AIUI, your future plans include allowing in-kernel accelerated TCE
> > tables even with VFIO devices.  When that happens, we might have an
> > in-kernel table both before and after a change in the "need_vfio"
> > state.
>=20
> The in-kernel table just stays there, mappings will be replayed but in the
> end of the replay only the hardware table will change.
>=20
> >=20
> > But you won't be able to have two in-kernel tables allocated at once,
> > whereas this code relies on having both the old and new tables at once
> > so it can copy the contents over.
> >=20
> > How do you intend to handle that?
>=20
> I intend to make this function no-op when cap_spapr_vfio is present.
>=20
>=20
> >=20
> >> Although spapr_tce_alloc_table() is expected to fail with EBUSY
> >> if called when previous fd is not closed yet, in practice we will not
> >> see it because cap_spapr_vfio is false at the moment.
> >=20
> > I don't follow this.  How would cap_spapr_vfio be changing at any
> > point?
>=20
> It depends on the version of the host kernel.

Ok.  I'm still a bit dubious about the line of reasoning here, but the
patch is correct for now, so we just have to make sure subsequent
changes work with it.

Applied to ppc-for-2.11.

>=20
> >=20
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  hw/ppc/spapr_iommu.c | 35 ++++++++++++++---------------------
> >>  1 file changed, 14 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> >> index e614621a83..307dc3021e 100644
> >> --- a/hw/ppc/spapr_iommu.c
> >> +++ b/hw/ppc/spapr_iommu.c
> >> @@ -275,33 +275,26 @@ static int spapr_tce_table_realize(DeviceState *=
dev)
> >>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
> >>  {
> >>      size_t table_size =3D tcet->nb_table * sizeof(uint64_t);
> >> -    void *newtable;
> >> +    uint64_t *oldtable;
> >> +    int newfd =3D -1;
> >> =20
> >> -    if (need_vfio =3D=3D tcet->need_vfio) {
> >> -        /* Nothing to do */
> >> -        return;
> >> -    }
> >> +    g_assert(need_vfio !=3D tcet->need_vfio);
> >> =20
> >> -    if (!need_vfio) {
> >> -        /* FIXME: We don't support transition back to KVM accelerated
> >> -         * TCEs yet */
> >> -        return;
> >> -    }
> >> +    tcet->need_vfio =3D need_vfio;
> >> =20
> >> -    tcet->need_vfio =3D true;
> >> +    oldtable =3D tcet->table;
> >> =20
> >> -    if (tcet->fd < 0) {
> >> -        /* Table is already in userspace, nothing to be do */
> >> -        return;
> >> -    }
> >> +    tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
> >> +                                        tcet->page_shift,
> >> +                                        tcet->bus_offset,
> >> +                                        tcet->nb_table,
> >> +                                        &newfd,
> >> +                                        need_vfio);
> >> +    memcpy(tcet->table, oldtable, table_size);
> >> =20
> >> -    newtable =3D g_malloc(table_size);
> >> -    memcpy(newtable, tcet->table, table_size);
> >> +    spapr_tce_free_table(oldtable, tcet->fd, tcet->nb_table);
> >> =20
> >> -    kvmppc_remove_spapr_tce(tcet->table, tcet->fd, tcet->nb_table);
> >> -
> >> -    tcet->fd =3D -1;
> >> -    tcet->table =3D newtable;
> >> +    tcet->fd =3D newfd;
> >>  }
> >> =20
> >>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b0op/nKJ9CeIhp9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKutoACgkQbDjKyiDZ
s5Ix5BAAw1RVW9SyC/hcEqPQCOcTzE1Cty5Hxiye/4mGxgCsXJzqxebCwptK63Wv
w+BwxSaayzluSyGvvorD5G7gqtq4LPHkm+1MgY9yvE/Pb7iwdLBKvNun4cASEtM4
1XRjdc9jtjbwlarccybaPcoCeehTJ/uqkN+OGD0kubK8mHRiOXWkQQe8wGEOdm+1
QU1tBlnWfmiYk0nzuvMA03RAEEgypbTm5FbkkHZKOkb+sPVujQKRdSAWt6R5ThQi
2Us3N2nCOnkwPDsf0u6OubNu0G3DU4TzMSTp4oi/8KeERYfXooLLNPW8p3zM30Ii
3hwWWTpOD9cXdR+CEIzga8HiuV5aOA05eyq4NqbBkkHsgsyfDygKPAvttHm+FEuD
dVsuKgx0OAmsVZ9TbiqazAvdu1qu+gdD2ze9yrV+OqMm1sAlQhSLW9H4NDY3As50
jXOTO5r0L9I9DdfAbPlhHfxv+JAsJoz8invWhhdmGKJ0RdnbZ9uvxva8IaOZPf2P
Vhk5ufl4VP3VY8jy7htr5BuKSBm89IAu6U01wWUKF6K76CdV8HaejVBLAtoqhgxW
AQlWcCZJXufdr9+PXQrbGdG7zcGudkP/2TViKlBjZ9IJiolYAxj+BugA4cvuPMmN
zUxywv06UiU866Tz3H89eTsJyCwoCL69ZWxexxFvK27fpLwS1O8=
=nk8A
-----END PGP SIGNATURE-----

--b0op/nKJ9CeIhp9z--
