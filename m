Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daNMi-0000zd-Mv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daNMe-0006k7-OH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:32:44 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daNMe-0006hw-HQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:32:40 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0D5DB11429D
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:32:39 +0200 (CEST)
Date: Wed, 26 Jul 2017 16:32:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726163227.3d6647a4@bahia.lan>
In-Reply-To: <0d1e2a57-14cb-4c4d-d8f7-915cd94c2eba@ozlabs.ru>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100568549.27487.11903027800624299907.stgit@bahia>
	<0d1e2a57-14cb-4c4d-d8f7-915cd94c2eba@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/24=f+/HdKt1.lLfHO5uqrtA";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 16/26] spapr: enable
 PHB hotplug for pseries-2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/24=f+/HdKt1.lLfHO5uqrtA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 14:42:23 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 26/07/17 04:01, Greg Kurz wrote:
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > The 'dr_phb_enabled' field of that class can be set as
> > part of machine-specific init code, and is then propagated
> > to sPAPREnvironment to conditionally enable creation of DRC
> > objects and device-tree description to facilitate hotplug
> > of PHBs.
> >=20
> > Since we can't migrate this state to older machine types,
> > default the option to true and disable it for older machine
> > types.
> >=20
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > Changes since RFC:
> > - rebased against ppc-for-2.10
> > - updated changelog and title
> > - set default to true and disable for 2.10 and older
> > ---
> >  hw/ppc/spapr.c         |    6 ++++++
> >  include/hw/ppc/spapr.h |    3 +++
> >  2 files changed, 9 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 277daa4f9645..8dc505343c0f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2382,6 +2382,8 @@ static void ppc_spapr_init(MachineState *machine)
> >      /* We always have at least the nvram device on VIO */
> >      spapr_create_nvram(spapr);
> > =20
> > +    spapr->dr_phb_enabled =3D smc->dr_phb_enabled;
> > +
> >      /* Set up PCI */
> >      spapr_pci_rtas_init();
> > =20
> > @@ -3482,6 +3484,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >       * in which LMBs are represented and hot-added
> >       */
> >      mc->numa_mem_align_shift =3D 28;
> > +    smc->dr_phb_enabled =3D true;
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -3558,8 +3561,11 @@ static void spapr_machine_2_10_instance_options(=
MachineState *machine)
> > =20
> >  static void spapr_machine_2_10_class_options(MachineClass *mc)
> >  {
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_2_11_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
> > +    smc->dr_phb_enabled =3D false;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 2a303a705c17..8004d9c2ab2c 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -59,6 +59,7 @@ struct sPAPRMachineClass {
> > =20
> >      /*< public >*/
> >      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of L=
MBs */
> > +    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of P=
HBs */
> >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by def=
ault */
> >      bool pre_2_10_has_unused_icps;
> > @@ -122,6 +123,8 @@ struct sPAPRMachineState {
> >       * occurs during the unplug process. */
> >      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> > =20
> > +    bool dr_phb_enabled; /* hotplug / dynamic-reconfiguration of PHBs =
*/ =20
>=20
> The one in the class seems sufficient unless we are going to allow
> disabling this via the command line.
>=20

I kept the original patch but you're right indeed. I don't see why
someone would want to disable this from the cmdline, so I guess I
should just drop the per-instance flag.

Mike, any thoughts ?

>=20
>=20
> > +
> >      /*< public >*/
> >      char *kvm_type;
> >      MemoryHotplugState hotplug_memory;
> >=20
> >  =20
>=20
>=20


--Sig_/24=f+/HdKt1.lLfHO5uqrtA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4p/wACgkQAvw66wEB28ISGgCggJ2v3zgWkYgqj6yU0lM1EUZb
zl0AoIMvbGlyCRlCEPcNyd/bwjIaZORz
=FT6A
-----END PGP SIGNATURE-----

--Sig_/24=f+/HdKt1.lLfHO5uqrtA--
