Received: from eggs.gnu.org ([2001:4830:134:3::10]:32869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh45-0007aA-Hg
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh44-0007u7-3R
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:41 -0400
Date: Tue, 13 Jun 2017 16:06:31 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613080631.GB30171@umbus>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
	<20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 09:33:59AM +0200, Greg Kurz wrote:
> On Mon, 12 Jun 2017 22:24:56 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 08, 2017 at 11:54:10AM +0200, Greg Kurz wrote:
> > > On Thu, 8 Jun 2017 14:08:57 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Wed, Jun 07, 2017 at 07:17:26PM +0200, Greg Kurz wrote: =20
> > > > > Commit 5bc8d26de20c ("spapr: allocate the ICPState object from un=
der
> > > > > sPAPRCPUCore") moved ICPState objects from the machine to CPU cor=
es.
> > > > > This is an improvement since we no longer allocate ICPState objec=
ts
> > > > > that will never be used. But it has the side-effect of breaking
> > > > > migration of older machine types from older QEMU versions.
> > > > >=20
> > > > > This patch allows spapr to register dummy "icp/server" entries to=
 vmstate.
> > > > > These entries use a dedicated VMStateDescription that can swallow=
 and
> > > > > discard state of an incoming migration stream, and that don't sen=
d anything
> > > > > on outgoing migration.
> > > > >=20
> > > > > As for real ICPState objects, the instance_id is the cpu_index of=
 the
> > > > > corresponding vCPU, which happens to be equal to the generated in=
stance_id
> > > > > of older machine types.
> > > > >=20
> > > > > The machine can unregister/register these entries when CPUs are d=
ynamically
> > > > > plugged/unplugged.
> > > > >=20
> > > > > This is only available for pseries-2.9 and older machines, thanks=
 to a
> > > > > compat property.
> > > > >=20
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > ---
> > > > > v3: - new logic entirely implemented in hw/ppc/spapr.c
> > > > > ---
> > > > >  hw/ppc/spapr.c         |   88 ++++++++++++++++++++++++++++++++++=
+++++++++++++-
> > > > >  include/hw/ppc/spapr.h |    2 +
> > > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > index 9b7ae28939a8..c15b604978f0 100644
> > > > > --- a/hw/ppc/spapr.c
> > > > > +++ b/hw/ppc/spapr.c
> > > > > @@ -124,9 +124,52 @@ error:
> > > > >      return NULL;
> > > > >  }
> > > > > =20
> > > > > +static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
> > > > > +{
> > > > > +    return false;
> > > > > +}   =20
> > > >=20
> > > > Uh.. the needed function always returns false, how can that work?
> > > >  =20
> > >=20
> > > The needed function is used for outgoing migration only:
> > >=20
> > > bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
> > > {
> > >     if (vmsd->needed && !vmsd->needed(opaque)) {
> > >         /* optional section not needed */
> > >         return false;
> > >     }
> > >     return true;
> > > }
> > >=20
> > > The idea is that all ICPState objects that were created but not assoc=
iated
> > > to a vCPU by pre-2.10 machine types don't need to be migrated at all,=
 as
> > > their state hasn't changed.
> > >=20
> > > We don't even create these unneeded ICPState objects here, but simply
> > > register their ids to vmstate.
> > >  =20
> > > > > +
> > > > > +static const VMStateDescription pre_2_10_vmstate_dummy_icp =3D {
> > > > > +    .name =3D "icp/server",
> > > > > +    .version_id =3D 1,
> > > > > +    .minimum_version_id =3D 1,
> > > > > +    .needed =3D pre_2_10_vmstate_dummy_icp_needed, =20
> > >=20
> > > Outgoing migration:
> > > - machine in older QEMU have unused ICPState objects (default state)
> > > - machine in QEMU 2.10 doesn't even have extra ICPState objects
> > >  =20
> > > =3D> don't send anything =20
> > >  =20
> > > > > +    .fields =3D (VMStateField[]) {
> > > > > +        VMSTATE_UNUSED(4), /* uint32_t xirr */
> > > > > +        VMSTATE_UNUSED(1), /* uint8_t pending_priority */
> > > > > +        VMSTATE_UNUSED(1), /* uint8_t mfrr */ =20
> > >=20
> > > Incoming migration from older QEMU: we don't have the extra ICPState =
objects.
> > >  =20
> > > =3D> accept the state and discard it =20
> > >  =20
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    },
> > > > > +};
> > > > > +
> > > > > +static void pre_2_10_vmstate_register_dummy_icp(sPAPRMachineStat=
e *spapr, int i)
> > > > > +{
> > > > > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > > > > +
> > > > > +    g_assert(!*flag);   =20
> > > >=20
> > > > Apart from this assert(), you never seem to test the values in the
> > > > pre_2_10_ignore_icp() array, so it seems a bit pointless.
> > > >  =20
> > >=20
> > > There's the opposite check in pre_2_10_vmstate_unregister_dummy_icp().
> > > But I agree it isn't really useful... but more because of paranoia :)=
 =20
> >=20
> > I'm all for paranoid assert()s if they can be made using data readily
> > to hand.  Adding a data structure just for the purpose of making an
> > assert() later, not so much.
> >=20
>=20
> It is also passed as opaque argument to vmstate_register(), where it is
> used as a key when calling vmstate_unregister(). I could possibly pass
> (void *) i instead, but I'm not a big fan of hijacking pointer arguments
> to pass numbers.

Ah, I see your point.  Creating an array, purely to generate arbitrary
pointers is also kind of ugly, though.  Really the cpu_index / XICS
server number makes sense to identify the vmstate, but it looks like
vmstate_unregister() doesn't take that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP50EAAoJEGw4ysog2bOSpRYP/2gM11jT4yg5AgdXUkqsFlaw
DPraFvjtRskmgvX2bjAGhb5PgmkDzvAUwURYJjhDPkifY3jmlBsszwnir26zYzr8
HPFGKdnRtO9+naq1+2mhTaTbS2f+94otfgYD/9zzl+ciJlze2fIbYeeekjlUuqo6
zK1K2Vyrr09rUKaKj/l84pBC8+QXRUqDqbeYaQqxMCO+dCZ3fShJiyHkLsuKEnRL
PNlhZTB28c8G9cDno0kPMfpVemShQZ49DDQhn77xLXyC7YgWfqLI+EC1ijfp3CJz
5JUcC7uuc3Nwb1VdfYGvu/HVa0y13PaIjp3DAZRidanaIiDKkb+2LHAq5tKbtkDr
oPc1Fe95T2NA8GtYnny1c9x8cZiVd0Yp38i4w1C0aVURfhQlb+iI59RQD/ZJXOFe
mrsU9JcDhGyzH2+10cpGDhBPYf/9TH+flXzDgmvmr1iKhkF1Pm1dtLFL4+MKD3vr
v3a5xjQNH6LqOXA9iFukwafBrKvdo/KV4LoH5DKNFb0gu27MQUcs9P/9pEUHbF1/
Jq0+VqHfBHIpp4afbIJPUk98meLAcGqTz3XauNI8agvlGUpoAXEoBioYegWH7SaL
PCUe9dLBL89t/Q2wgGTSQE8ICFoJJasa2/4JZbgNTSt7fd+eXaiJuQYzMp8Yct74
ChOV7CfoQW+sTVTlc1vu
=qDE1
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
