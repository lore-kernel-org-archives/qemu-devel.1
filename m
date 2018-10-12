Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAl9I-0003UI-Rz
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAl9H-0006zL-QT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:17:48 -0400
Date: Fri, 12 Oct 2018 11:17:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181012001731.GO7004@umbus.fritz.box>
References: <153924123502.3669683.1365591120394690822.stgit@bahia.lan>
	<3b91d4bf-58b2-55b6-d41d-348865b7542a@redhat.com>
	<20181011150408.56213443@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MEtH+zcSjJxXgQVV"
Content-Disposition: inline
In-Reply-To: <20181011150408.56213443@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: rename some structured types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--MEtH+zcSjJxXgQVV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 03:04:08PM +0200, Greg Kurz wrote:
> On Thu, 11 Oct 2018 13:02:50 +0200
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
>=20
> > Hi Greg,
> >=20
> > On 11/10/2018 09:00, Greg Kurz wrote:
> > > According to CODING_STYLE, structured types names are expected to be
> > > in CamelCase. PCI is dropped from the name for better
> > readability.

I'd prefer you didn't drop PCI from the name.  These specifically
*are* PCI MSIs, whereas lots of PAPR documentation (particularly for
the interrupt controller) uses MSIs to indicate general message
interrupts, such as those from VIO and firmware event reporting.

> > >=20
> > > While here, this also converts a call to g_malloc(n * sizeofi(foo)) t=
o =20
> >=20
>=20
> Oops finger slipped on its way to the left parenthesis :)
>=20
> > sizeof(foo)
> >=20
> > > g_new(n, foo), which is a recommended good practice. =20
> >=20
> > Clearly 2 different patches...
> >=20
>=20
> You're right in theory. I added the g_new conversion in the same patch
> for simplicity mostly. I'll let David decide :)

I'd prefer them separate.

>=20
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr_pci.c          |   22 +++++++++++-----------
> > >  include/hw/pci-host/spapr.h |   12 ++++++------
> > >  2 files changed, 17 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index c2271e6ed462..bfb959f2b065 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -277,7 +277,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
> > >      unsigned int irq, max_irqs =3D 0;
> > >      sPAPRPHBState *phb =3D NULL;
> > >      PCIDevice *pdev =3D NULL;
> > > -    spapr_pci_msi *msi;
> > > +    sPAPRMSI *msi; =20
> >=20
> > In CamelCase this should be "SpaprMsi"...
> > I however agree sPAPRMSI is nicer, the code is also easier to
> > review.

Yeah.. it's kind of a mangled combination of CamelCase with what's
been done elsewhere in the spapr code.

> >=20
> > >      int *config_addr_key;
> > >      Error *err =3D NULL;
> > >      int i;
> > > @@ -325,7 +325,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
> > >          return;
> > >      }
> > > =20
> > > -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_=
addr);
> > > +    msi =3D (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_addr);
> > > =20
> > >      /* Releasing MSIs */
> > >      if (!req_num) {
> > > @@ -414,7 +414,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
> > >                       irq, req_num);
> > > =20
> > >      /* Add MSI device to cache */
> > > -    msi =3D g_new(spapr_pci_msi, 1);
> > > +    msi =3D g_new(sPAPRMSI, 1);
> > >      msi->first_irq =3D irq;
> > >      msi->num =3D req_num;
> > >      config_addr_key =3D g_new(int, 1);
> > > @@ -445,7 +445,7 @@ static void rtas_ibm_query_interrupt_source_numbe=
r(PowerPCCPU *cpu,
> > >      unsigned int intr_src_num =3D -1, ioa_intr_num =3D rtas_ld(args,=
 3);
> > >      sPAPRPHBState *phb =3D NULL;
> > >      PCIDevice *pdev =3D NULL;
> > > -    spapr_pci_msi *msi;
> > > +    sPAPRMSI *msi;
> > > =20
> > >      /* Find sPAPRPHBState */
> > >      phb =3D spapr_pci_find_phb(spapr, buid);
> > > @@ -458,7 +458,7 @@ static void rtas_ibm_query_interrupt_source_numbe=
r(PowerPCCPU *cpu,
> > >      }
> > > =20
> > >      /* Find device descriptor and start IRQ */
> > > -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_=
addr);
> > > +    msi =3D (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_addr);
> > >      if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >=3D m=
si->num)) {
> > >          trace_spapr_pci_msi("Failed to return vector", config_addr);
> > >          rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > @@ -1849,9 +1849,9 @@ static const VMStateDescription vmstate_spapr_p=
ci_msi =3D {
> > >      .version_id =3D 1,
> > >      .minimum_version_id =3D 1,
> > >      .fields =3D (VMStateField []) {
> > > -        VMSTATE_UINT32(key, spapr_pci_msi_mig),
> > > -        VMSTATE_UINT32(value.first_irq, spapr_pci_msi_mig),
> > > -        VMSTATE_UINT32(value.num, spapr_pci_msi_mig),
> > > +        VMSTATE_UINT32(key, sPAPRMSIMig),
> > > +        VMSTATE_UINT32(value.first_irq, sPAPRMSIMig),
> > > +        VMSTATE_UINT32(value.num, sPAPRMSIMig),
> > >          VMSTATE_END_OF_LIST()
> > >      },
> > >  };
> > > @@ -1883,12 +1883,12 @@ static int spapr_pci_pre_save(void *opaque)
> > >      if (!sphb->msi_devs_num) {
> > >          return 0;
> > >      }
> > > -    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pc=
i_msi_mig));
> > > +    sphb->msi_devs =3D g_new(sPAPRMSIMig, sphb->msi_devs_num);
> > > =20
> > >      g_hash_table_iter_init(&iter, sphb->msi);
> > >      for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
> > >          sphb->msi_devs[i].key =3D *(uint32_t *) key;
> > > -        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
> > > +        sphb->msi_devs[i].value =3D *(sPAPRMSI *) value;
> > >      }
> > > =20
> > >      return 0;
> > > @@ -1938,7 +1938,7 @@ static const VMStateDescription vmstate_spapr_p=
ci =3D {
> > >                               vmstate_spapr_pci_lsi, struct spapr_pci=
_lsi),
> > >          VMSTATE_INT32(msi_devs_num, sPAPRPHBState),
> > >          VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, sPAPRPHBState, msi_dev=
s_num, 0,
> > > -                                    vmstate_spapr_pci_msi, spapr_pci=
_msi_mig),
> > > +                                    vmstate_spapr_pci_msi, sPAPRMSIM=
ig),
> > >          VMSTATE_END_OF_LIST()
> > >      },
> > >  };
> > > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > > index 7c66c3872f96..041126da573d 100644
> > > --- a/include/hw/pci-host/spapr.h
> > > +++ b/include/hw/pci-host/spapr.h
> > > @@ -34,15 +34,15 @@
> > > =20
> > >  typedef struct sPAPRPHBState sPAPRPHBState;
> > > =20
> > > -typedef struct spapr_pci_msi {
> > > +typedef struct sPAPRMSI {
> > >      uint32_t first_irq;
> > >      uint32_t num;
> > > -} spapr_pci_msi;
> > > +} sPAPRMSI;
> > > =20
> > > -typedef struct spapr_pci_msi_mig {
> > > +typedef struct sPAPRMSIMig {
> > >      uint32_t key;
> > > -    spapr_pci_msi value;
> > > -} spapr_pci_msi_mig;
> > > +    sPAPRMSI value;
> > > +} sPAPRMSIMig;
> > > =20
> > >  struct sPAPRPHBState {
> > >      PCIHostState parent_obj;
> > > @@ -70,7 +70,7 @@ struct sPAPRPHBState {
> > >      GHashTable *msi;
> > >      /* Temporary cache for migration purposes */
> > >      int32_t msi_devs_num;
> > > -    spapr_pci_msi_mig *msi_devs;
> > > +    sPAPRMSIMig *msi_devs;
> > > =20
> > >      QLIST_ENTRY(sPAPRPHBState) list;
> > > =20
> > >=20
> > >  =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MEtH+zcSjJxXgQVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu/6BsACgkQbDjKyiDZ
s5JxeQ//ayi/ySCcovyp+xvNbhYhYTM2coDXXzqSdtEwaCp5+SPzwSy68BWAosnC
fIthYj8E10H4timyaUzxgffbAKWLWNWKRXg6UmTuHkBNNK+1Skpovt7629WOPsWS
KYJVW/Hatr8hWzGoEpZrrimUu2FKrgs39J9XcKE9jOsciKoN8C0DtxxTngHM7rs3
sEThsYRJ6WgVPcw07Oj0CJmcokmti1Ifld5DnEiBntlA2KozEKMijanR7Lc+uCBZ
vFC9Y56xOOXlpdyLRjUsNrpTccxd563gsttWXKwwq6w8IjmB78Y0GwIK9FYNVnmI
WR0m5WP6/FhgNulqWe91GzBXP34fA7dXAJAOUW8jGxUhZHMpM4TaFuYpzsyb5dnq
T7mwC7ssDfNYu2tRAlNn2+CkmPYp29MN6V0oxhIqb4Vq3hGExuaZhy24gOEJFUsN
BaKOBBSx12ixHUER+nGDtv56YeN8WHjFxGOPZLeTuVy3Q1OKkvJJGHWRce9JZuwJ
U1rKcgsQGWxlx62rHEIUe3xvsk11u8Lncu8jutLVQAbYR4J6icvzTliq1EiBRD3Z
5oyKKnKaJFmNxn41EHiBt/y3cHtzIfi4mZBqlaCi01tntybcyM5JGxyeHhQhP8up
39e8f2A4Ej/YLeNWEhqSsNOzqgno9qAY+jxZwcZIo1nlot3jPG4=
=rSDB
-----END PGP SIGNATURE-----

--MEtH+zcSjJxXgQVV--
