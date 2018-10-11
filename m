Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAado-0004qB-5P
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAadk-0002FF-4R
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:04:35 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:50852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gAade-00025q-0q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:04:29 -0400
Received: from player737.ha.ovh.net (unknown [10.109.146.32])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 708702F075
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 15:04:14 +0200 (CEST)
Date: Thu, 11 Oct 2018 15:04:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181011150408.56213443@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <3b91d4bf-58b2-55b6-d41d-348865b7542a@redhat.com>
References: <153924123502.3669683.1365591120394690822.stgit@bahia.lan>
	<3b91d4bf-58b2-55b6-d41d-348865b7542a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: rename some structured types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 11 Oct 2018 13:02:50 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Greg,
>=20
> On 11/10/2018 09:00, Greg Kurz wrote:
> > According to CODING_STYLE, structured types names are expected to be
> > in CamelCase. PCI is dropped from the name for better readability.
> >=20
> > While here, this also converts a call to g_malloc(n * sizeofi(foo)) to =
=20
>=20

Oops finger slipped on its way to the left parenthesis :)

> sizeof(foo)
>=20
> > g_new(n, foo), which is a recommended good practice. =20
>=20
> Clearly 2 different patches...
>=20

You're right in theory. I added the g_new conversion in the same patch
for simplicity mostly. I'll let David decide :)

> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_pci.c          |   22 +++++++++++-----------
> >  include/hw/pci-host/spapr.h |   12 ++++++------
> >  2 files changed, 17 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index c2271e6ed462..bfb959f2b065 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -277,7 +277,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
> >      unsigned int irq, max_irqs =3D 0;
> >      sPAPRPHBState *phb =3D NULL;
> >      PCIDevice *pdev =3D NULL;
> > -    spapr_pci_msi *msi;
> > +    sPAPRMSI *msi; =20
>=20
> In CamelCase this should be "SpaprMsi"...
> I however agree sPAPRMSI is nicer, the code is also easier to review.
>=20
> >      int *config_addr_key;
> >      Error *err =3D NULL;
> >      int i;
> > @@ -325,7 +325,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
> >          return;
> >      }
> > =20
> > -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_ad=
dr);
> > +    msi =3D (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_addr);
> > =20
> >      /* Releasing MSIs */
> >      if (!req_num) {
> > @@ -414,7 +414,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
> >                       irq, req_num);
> > =20
> >      /* Add MSI device to cache */
> > -    msi =3D g_new(spapr_pci_msi, 1);
> > +    msi =3D g_new(sPAPRMSI, 1);
> >      msi->first_irq =3D irq;
> >      msi->num =3D req_num;
> >      config_addr_key =3D g_new(int, 1);
> > @@ -445,7 +445,7 @@ static void rtas_ibm_query_interrupt_source_number(=
PowerPCCPU *cpu,
> >      unsigned int intr_src_num =3D -1, ioa_intr_num =3D rtas_ld(args, 3=
);
> >      sPAPRPHBState *phb =3D NULL;
> >      PCIDevice *pdev =3D NULL;
> > -    spapr_pci_msi *msi;
> > +    sPAPRMSI *msi;
> > =20
> >      /* Find sPAPRPHBState */
> >      phb =3D spapr_pci_find_phb(spapr, buid);
> > @@ -458,7 +458,7 @@ static void rtas_ibm_query_interrupt_source_number(=
PowerPCCPU *cpu,
> >      }
> > =20
> >      /* Find device descriptor and start IRQ */
> > -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_ad=
dr);
> > +    msi =3D (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_addr);
> >      if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >=3D msi=
->num)) {
> >          trace_spapr_pci_msi("Failed to return vector", config_addr);
> >          rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > @@ -1849,9 +1849,9 @@ static const VMStateDescription vmstate_spapr_pci=
_msi =3D {
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> >      .fields =3D (VMStateField []) {
> > -        VMSTATE_UINT32(key, spapr_pci_msi_mig),
> > -        VMSTATE_UINT32(value.first_irq, spapr_pci_msi_mig),
> > -        VMSTATE_UINT32(value.num, spapr_pci_msi_mig),
> > +        VMSTATE_UINT32(key, sPAPRMSIMig),
> > +        VMSTATE_UINT32(value.first_irq, sPAPRMSIMig),
> > +        VMSTATE_UINT32(value.num, sPAPRMSIMig),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > @@ -1883,12 +1883,12 @@ static int spapr_pci_pre_save(void *opaque)
> >      if (!sphb->msi_devs_num) {
> >          return 0;
> >      }
> > -    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_=
msi_mig));
> > +    sphb->msi_devs =3D g_new(sPAPRMSIMig, sphb->msi_devs_num);
> > =20
> >      g_hash_table_iter_init(&iter, sphb->msi);
> >      for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
> >          sphb->msi_devs[i].key =3D *(uint32_t *) key;
> > -        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
> > +        sphb->msi_devs[i].value =3D *(sPAPRMSI *) value;
> >      }
> > =20
> >      return 0;
> > @@ -1938,7 +1938,7 @@ static const VMStateDescription vmstate_spapr_pci=
 =3D {
> >                               vmstate_spapr_pci_lsi, struct spapr_pci_l=
si),
> >          VMSTATE_INT32(msi_devs_num, sPAPRPHBState),
> >          VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, sPAPRPHBState, msi_devs_=
num, 0,
> > -                                    vmstate_spapr_pci_msi, spapr_pci_m=
si_mig),
> > +                                    vmstate_spapr_pci_msi, sPAPRMSIMig=
),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > index 7c66c3872f96..041126da573d 100644
> > --- a/include/hw/pci-host/spapr.h
> > +++ b/include/hw/pci-host/spapr.h
> > @@ -34,15 +34,15 @@
> > =20
> >  typedef struct sPAPRPHBState sPAPRPHBState;
> > =20
> > -typedef struct spapr_pci_msi {
> > +typedef struct sPAPRMSI {
> >      uint32_t first_irq;
> >      uint32_t num;
> > -} spapr_pci_msi;
> > +} sPAPRMSI;
> > =20
> > -typedef struct spapr_pci_msi_mig {
> > +typedef struct sPAPRMSIMig {
> >      uint32_t key;
> > -    spapr_pci_msi value;
> > -} spapr_pci_msi_mig;
> > +    sPAPRMSI value;
> > +} sPAPRMSIMig;
> > =20
> >  struct sPAPRPHBState {
> >      PCIHostState parent_obj;
> > @@ -70,7 +70,7 @@ struct sPAPRPHBState {
> >      GHashTable *msi;
> >      /* Temporary cache for migration purposes */
> >      int32_t msi_devs_num;
> > -    spapr_pci_msi_mig *msi_devs;
> > +    sPAPRMSIMig *msi_devs;
> > =20
> >      QLIST_ENTRY(sPAPRPHBState) list;
> > =20
> >=20
> >  =20
