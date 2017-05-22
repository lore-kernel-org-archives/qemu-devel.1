Received: from eggs.gnu.org ([2001:4830:134:3::10]:53786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCday-0006Ty-Gu
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdaw-0005XQ-LQ
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:20 -0400
Date: Mon, 22 May 2017 12:48:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522024825.GM30246@umbus.fritz.box>
References: <20170518215416.5613-1-danielhb@linux.vnet.ibm.com>
	<20170518215416.5613-2-danielhb@linux.vnet.ibm.com>
	<20170519042611.GE12284@umbus.fritz.box>
	<a229357e-d42a-28e3-b118-cc0f4b702e95@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Content-Disposition: inline
In-Reply-To: <a229357e-d42a-28e3-b118-cc0f4b702e95@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RESEND PATCH v10 1/5] hw/ppc/spapr.c:
 adding pending_dimm_unplugs to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 08:19:41AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/19/2017 01:26 AM, David Gibson wrote:
> > On Thu, May 18, 2017 at 06:54:12PM -0300, Daniel Henrique Barboza wrote:
> > > The LMB DRC release callback, spapr_lmb_release(), uses an opaque
> > > parameter, a sPAPRDIMMState struct that stores the current LMBs that
> > > are allocated to a DIMM (nr_lmbs). After each call to this callback,
> > > the nr_lmbs is decremented by one and, when it reaches zero, the call=
back
> > > proceeds with the qdev calls to hot unplug the LMB.
> > >=20
> > > Using drc->detach_cb_opaque is problematic because it can't be migrat=
ed in
> > > the future DRC migration work. This patch makes the following changes=
 to
> > > eliminate the usage of this opaque callback inside spapr_lmb_release:
> > >=20
> > > - sPAPRDIMMState was moved from spapr.c and added to spapr.h. A new
> > > attribute called 'addr' was added to it. This is used as an unique
> > > identifier to associate a sPAPRDIMMState to a PCDIMM element.
> > >=20
> > > - sPAPRMachineState now hosts a new QTAILQ called 'pending_dimm_unplu=
gs'.
> > > This queue of sPAPRDIMMState elements will store the DIMM state of DI=
MMs
> > > that are currently going under an unplug process.
> > >=20
> > > - spapr_lmb_release() will now retrieve the nr_lmbs value by getting =
the
> > > correspondent sPAPRDIMMState. A helper function called spapr_dimm_get=
_address
> > > was created to fetch the address of a PCDIMM device inside spapr_lmb_=
release.
> > > When nr_lmbs reaches zero and the callback proceeds with the qdev hot=
 unplug
> > > calls, the sPAPRDIMMState struct is removed from spapr->pending_dimm_=
unplugs.
> > >=20
> > > After these changes, the opaque argument for spapr_lmb_release is now
> > > unused and is passed as NULL inside spapr_del_lmbs. This and the other
> > > opaque arguments can now be safely removed from the code.
> > >=20
> > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > ---
> > >   hw/ppc/spapr.c         | 57 +++++++++++++++++++++++++++++++++++++++=
++++++-----
> > >   include/hw/ppc/spapr.h |  4 ++++
> > >   2 files changed, 56 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 0980d73..b05abe5 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2050,6 +2050,7 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > >       msi_nonbroken =3D true;
> > >       QLIST_INIT(&spapr->phbs);
> > > +    QTAILQ_INIT(&spapr->pending_dimm_unplugs);
> > >       /* Allocate RMA if necessary */
> > >       rma_alloc_size =3D kvmppc_alloc_rma(&rma);
> > > @@ -2603,20 +2604,63 @@ out:
> > >       error_propagate(errp, local_err);
> > >   }
> > > -typedef struct sPAPRDIMMState {
> > > +struct sPAPRDIMMState {
> > > +    uint64_t addr;
> > Since you're not trying to migrate this any more, you can index the
> > list by an actual PCDIMMDevice *, rather than the base address.
> > You're already passing the DeviceState * for the DIMM around, so this
> > will actually remove the address parameter from some functions.
> Good idea.
>=20
> >=20
> > I think that could actually be done as a preliminary cleanup.  It also
> > probably makes sense to merge spapr_del_lmbs() with
> > spapr_memory_unplug_request(), they're both very small.
>=20
> Ok.
>=20
> >=20
> >=20
> > >       uint32_t nr_lmbs;
> > > -} sPAPRDIMMState;
> > > +    QTAILQ_ENTRY(sPAPRDIMMState) next;
> > > +};
> > > +
> > > +static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineS=
tate *s,
> > > +                                                       uint64_t addr)
> > > +{
> > > +    sPAPRDIMMState *dimm_state =3D NULL;
> > > +    QTAILQ_FOREACH(dimm_state, &s->pending_dimm_unplugs, next) {
> > > +        if (dimm_state->addr =3D=3D addr) {
> > > +            break;
> > > +        }
> > > +    }
> > > +    return dimm_state;
> > > +}
> > > +
> > > +static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
> > > +                                           sPAPRDIMMState *dimm_stat=
e)
> > > +{
> > > +    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->add=
r));
> > > +    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, nex=
t);
> > > +}
> > > +
> > > +static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spa=
pr,
> > > +                                              sPAPRDIMMState *dimm_s=
tate)
> > > +{
> > > +    QTAILQ_REMOVE(&spapr->pending_dimm_unplugs, dimm_state, next);
> > > +    g_free(dimm_state);
> > > +}
> > > +
> > > +static uint64_t spapr_dimm_get_address(PCDIMMDevice *dimm)
> > > +{
> > > +    Error *local_err =3D NULL;
> > > +    uint64_t addr;
> > > +    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> > > +                                   &local_err);
> > > +    if (local_err) {
> > > +        error_propagate(&error_abort, local_err);
> > > +        return 0;
> > > +    }
> > > +    return addr;
> > > +}
> > >   static void spapr_lmb_release(DeviceState *dev, void *opaque)
> > >   {
> > > -    sPAPRDIMMState *ds =3D (sPAPRDIMMState *)opaque;
> > >       HotplugHandler *hotplug_ctrl;
> > > +    uint64_t addr =3D spapr_dimm_get_address(PC_DIMM(dev));
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > I prefer not to access the machine as a global when possible.  I think
> > it's preferable to pass down the spapr object from above -
> > unplug_request() itself can get it from hotplug_dev.
>=20
> I see that we have access to the hotplug_dev (HotplugHandler) in the end =
of
> spapr_lmb_release:
>=20
>     hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
>=20
> One alternative would be to move this call up in the function and then
> retrieve the machine as unplug_request() does:
>=20
>     hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
>     sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_ctrl);

True.  That sounds like a good idea.

>=20
>=20
>=20
> >=20
> > > +    sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, ad=
dr);
> > >       if (--ds->nr_lmbs) {
> > >           return;
> > >       }
> > > -    g_free(ds);
> > > +    spapr_pending_dimm_unplugs_remove(spapr, ds);
> > >       /*
> > >        * Now that all the LMBs have been removed by the guest, call t=
he
> > > @@ -2633,17 +2677,20 @@ static void spapr_del_lmbs(DeviceState *dev, =
uint64_t addr_start, uint64_t size,
> > >       sPAPRDRConnectorClass *drck;
> > >       uint32_t nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
> > >       int i;
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > >       sPAPRDIMMState *ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> > >       uint64_t addr =3D addr_start;
> > >       ds->nr_lmbs =3D nr_lmbs;
> > > +    ds->addr =3D addr_start;
> > > +    spapr_pending_dimm_unplugs_add(spapr, ds);
> > >       for (i =3D 0; i < nr_lmbs; i++) {
> > >           drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LM=
B,
> > >                   addr / SPAPR_MEMORY_BLOCK_SIZE);
> > >           g_assert(drc);
> > >           drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > -        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
> > > +        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
> > >           addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> > >       }
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 5802f88..9823296 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -32,6 +32,7 @@ struct sPAPRRTCState {
> > >       int64_t ns_offset;
> > >   };
> > > +typedef struct sPAPRDIMMState sPAPRDIMMState;
> > >   typedef struct sPAPRMachineClass sPAPRMachineClass;
> > >   #define TYPE_SPAPR_MACHINE      "spapr-machine"
> > > @@ -104,6 +105,9 @@ struct sPAPRMachineState {
> > >       /* RTAS state */
> > >       QTAILQ_HEAD(, sPAPRConfigureConnectorState) ccs_list;
> > > +    /* pending DIMM unplug queue */
> > Perhaps update this to mention that it's a cache which can be
> > regenerated when necessary.
> Ok.
> >=20
> > > +    QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> > > +
> > >       /*< public >*/
> > >       char *kvm_type;
> > >       MemoryHotplugState hotplug_memory;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIlF5AAoJEGw4ysog2bOSfpwP/3c+PrkUDDAC6k9Bvhl0yEjg
JZxccMxkCFpsf4krTP7okLu/s6dbH6f0Ww5hzzykDSlbeOF6BHyfos4+P46LYyEw
FYH02BJIWCHP/Gx4pqPrpySBrp3BllmMHW7ZPIXYV1uqzECUzCFbOLpSeUjwlW4l
PSez72u3aPjjtQHK0Yxevkb2XlmJPnoX+f7C808SHVDmCWAisrv4G5y9ee2HZuoZ
o2WDwxBH4JDF9ckK0DMsbv6gz2ioPGBvWUjwTfa0v+K42Cwnrfjb9dZSClLdOQYA
8SBW2VsGQKo3/w0yORjW70PWDpZIo+diQJK1cY2GuiWC64DFhf5j89G6k2d4Xi5b
PKoUhw6G1HftStm0xX8CokGDCpVtkFVZsH6dmjiZ2e0nJHDBWYR9Q8RuD6GKPJIy
BEYbNCXogYLNIhT6PNnEM+2mm3cCp/JNx1yRq1EusPIFlrQCaCWigakSXycDJmHn
fs1sR6h7qd6WCv6iEy/ZXyr3OpwMOVzc1LWc/hifvQPtTKtxKl8iw7FwiaLBMxLu
+sPi3wUp+tgass7l/d485VhCI/x6Zm9yigw48ttY3PsuAVT4Yp2GAnBfhwmTZdB4
BKp2hQozeSHelyrJrAPI0tQ18L/wv1DxCvpOYv/ZgMMeE3x2RfpI+cglpGf0oeXO
DscvPhFyKLcIuERYeiTI
=DPga
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--
