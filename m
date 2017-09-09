Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqZZQ-0002rc-7w
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 02:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqZZO-0006od-VJ
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 02:48:48 -0400
Date: Sat, 9 Sep 2017 13:54:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170909035410.GQ2735@umbus.fritz.box>
References: <20170906184305.2612-1-danielhb@linux.vnet.ibm.com>
	<20170907172123.6732c1ba@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z87VqPJ/HsYrR2WM"
Content-Disposition: inline
In-Reply-To: <20170907172123.6732c1ba@bahia>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr.c: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--z87VqPJ/HsYrR2WM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 05:21:23PM +0200, Greg Kurz wrote:
> On Wed,  6 Sep 2017 15:43:05 -0300
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
>=20
> > This patch removes the qdev_get_machine() calls that are made in
> > spapr.c in situations where we can get an existing pointer for
> > the MachineState by either passing it as an argument to the function
> > or by using other already available pointers.
> >=20
> > The following changes were made:
> >=20
> > - spapr_node0_size: static function that is called two times:
> > at spapr_setup_hpt_and_vrma and ppc_spapr_init. In both cases we can
> > pass an existing MachineState pointer to it.
> >=20
> > - spapr_build_fdt: MachineState pointer can be retrieved from
> > the existing sPAPRMachineState pointer.
> >=20
> > - spapr_boot_set: the opaque in the first arg is a sPAPRMachineState
> > pointer as we can see inside ppc_spapr_init:
> >=20
> >     qemu_register_boot_set(spapr_boot_set, spapr);
> >=20
> > We can get a MachineState pointer from it.
> >=20
> > - spapr_machine_device_plug and spapr_machine_device_unplug_request: the
> > MachineState, sPAPRMachineState, MachineClass and sPAPRMachineClass poi=
nters
> > can all be retrieved from the HotplugHandler pointer.
> >=20
> > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > ---
>=20
> It makes sense for me.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

>=20
> >  hw/ppc/spapr.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index cec441c..6ac3390 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -390,10 +390,8 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMach=
ineState *spapr)
> >      return ret;
> >  }
> > =20
> > -static hwaddr spapr_node0_size(void)
> > +static hwaddr spapr_node0_size(MachineState *machine)
> >  {
> > -    MachineState *machine =3D MACHINE(qdev_get_machine());
> > -
> >      if (nb_numa_nodes) {
> >          int i;
> >          for (i =3D 0; i < nb_numa_nodes; ++i) {
> > @@ -1027,7 +1025,7 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
> >                               hwaddr rtas_addr,
> >                               hwaddr rtas_size)
> >  {
> > -    MachineState *machine =3D MACHINE(qdev_get_machine());
> > +    MachineState *machine =3D MACHINE(spapr);
> >      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> >      int ret;
> > @@ -1347,7 +1345,7 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *=
spapr)
> >      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
> > =20
> >      if (spapr->vrma_adjust) {
> > -        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(),
> > +        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(MACHINE(s=
papr)),
> >                                            spapr->htab_shift);
> >      }
> >      /* We're setting up a hash table, so that means we're not radix */
> > @@ -2007,7 +2005,7 @@ static SaveVMHandlers savevm_htab_handlers =3D {
> >  static void spapr_boot_set(void *opaque, const char *boot_device,
> >                             Error **errp)
> >  {
> > -    MachineState *machine =3D MACHINE(qdev_get_machine());
> > +    MachineState *machine =3D MACHINE(opaque);
> >      machine->boot_order =3D g_strdup(boot_device);
> >  }
> > =20
> > @@ -2154,7 +2152,7 @@ static void ppc_spapr_init(MachineState *machine)
> >      MemoryRegion *rma_region;
> >      void *rma =3D NULL;
> >      hwaddr rma_alloc_size;
> > -    hwaddr node0_size =3D spapr_node0_size();
> > +    hwaddr node0_size =3D spapr_node0_size(machine);
> >      long load_limit, fw_size;
> >      char *filename;
> >      Error *resize_hpt_err =3D NULL;
> > @@ -3198,7 +3196,8 @@ out:
> >  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> >                                        DeviceState *dev, Error **errp)
> >  {
> > -    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machin=
e());
> > +    MachineState *ms =3D MACHINE(hotplug_dev);
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> > =20
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          int node;
> > @@ -3247,8 +3246,8 @@ static void spapr_machine_device_plug(HotplugHand=
ler *hotplug_dev,
> >  static void spapr_machine_device_unplug_request(HotplugHandler *hotplu=
g_dev,
> >                                                  DeviceState *dev, Erro=
r **errp)
> >  {
> > -    sPAPRMachineState *sms =3D SPAPR_MACHINE(qdev_get_machine());
> > -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> > +    sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> > =20
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z87VqPJ/HsYrR2WM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmzZeIACgkQbDjKyiDZ
s5Kl3BAAz1DYJg7l423aawp3qLQuerGRlGGDH9ItvbifdiT6nzNXwE6+rdSHnStO
313XMObER6EePNoe+DfCU7kBYqq43iDAlfjSCFq3gy6R6okMhiAn8xVdCElTqGrL
maNJHCFItzZaxptGY3FLt9csEc1HVO6T8//wGqv8P1mKU5BVaKyqbM1KJLJ3JHWW
/SE9pw/Hu+V3uZk5khNUrEpOpfv8G1Gs3GjtwC0HuNG+bvKXOxJFPCUsavh0Oaez
06CI4FiPf4LxKuVmVHb0o0sNORe6VbaooRRxj8KPTGlpXwZb7gP2oXSine6AyoMM
1XrYRjqNUUJSMWt6B4DbVruUfEbSz5/dkwGBdMd77he9QQYCLUU0cqZOhmb1FUyL
gPy9tjyEjDHvqchpz10UEXXis4FjHaiHvwHQ7s7OTSMCbB16s9UV41AfwBcvsrm3
ndc5PaMqolMBvK9MRLoaYjr8i9mDrBf4i16CKb0KB90iV7Uig/U16U/qx3ov1LOw
o3vk8LgsOkIkYYyprWcsbDFL70/uQYwkTeIvbV81IBLfSbOzh3+zlaqALLwc79o+
1dLWDsyXS5wewGOdKQ9kWqHdZmwdU/PeOgyHSob/8QmshtZGyZyKYRWSbDD6pNeZ
oTmRtyt4dTC3BIcpfrV1eYYZDHhJx2ZQJbRLqEqlcG+9ABaMObA=
=4CSI
-----END PGP SIGNATURE-----

--z87VqPJ/HsYrR2WM--
