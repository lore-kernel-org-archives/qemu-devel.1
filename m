Received: from eggs.gnu.org ([2001:4830:134:3::10]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcZ8Q-0000Ez-Sy
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcZ8O-0006XD-2R
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:31:02 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:37323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcZ8N-0006W1-Ou
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:30:59 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7DBD166E26
	for <qemu-devel@nongnu.org>; Tue,  1 Aug 2017 17:30:57 +0200 (CEST)
Date: Tue, 1 Aug 2017 17:30:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170801173046.3805979d@bahia.lan>
In-Reply-To: <20170728042403.GK3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150105840463.12000.9666180368681199673.stgit@bahia>
	<ac479056-e370-7083-bd9e-60d873baf2b4@ozlabs.ru>
	<20170727190955.2792d785@bahia.lan>
	<20170728042403.GK3098@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/hjpCDu+srJeU+cWX3nTcxyc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 26/26] spapr: add hotplug hooks
 for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/hjpCDu+srJeU+cWX3nTcxyc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jul 2017 14:24:03 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jul 27, 2017 at 07:09:55PM +0200, Greg Kurz wrote:
> > On Thu, 27 Jul 2017 14:41:31 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >  =20
> > > On 26/07/17 18:40, Greg Kurz wrote: =20
> > > > Hotplugging PHBs is a machine-level operation, but PHBs reside on t=
he
> > > > main system bus, so we register spapr machine as the handler for the
> > > > main system bus.
> > > >=20
> > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > > - rebased against ppc-for-2.10
> > > > - converted to unplug_request
> > > > - handle drc_id at pre-plug
> > > > - reset hotplugged PHB at plug
> > > > - compatibility with older machine types
> > > > ---
> > > >  hw/ppc/spapr.c              |  114 +++++++++++++++++++++++++++++++=
++++++++++++
> > > >  hw/ppc/spapr_drc.c          |    1=20
> > > >  hw/ppc/spapr_pci.c          |    2 -
> > > >  include/hw/pci-host/spapr.h |    2 +
> > > >  include/hw/ppc/spapr.h      |    1=20
> > > >  5 files changed, 118 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 90485054c2e7..589f76ef9fb8 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -2540,6 +2540,10 @@ static void ppc_spapr_init(MachineState *mac=
hine)
> > > >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> > > >                           &savevm_htab_handlers, spapr);
> > > > =20
> > > > +    if (spapr->dr_phb_enabled) {
> > > > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(mach=
ine), NULL);
> > > > +    }
> > > > +
> > > >      qemu_register_boot_set(spapr_boot_set, spapr);
> > > > =20
> > > >      if (kvm_enabled()) {
> > > > @@ -3238,6 +3242,103 @@ out:
> > > >      error_propagate(errp, local_err);
> > > >  }
> > > > =20
> > > > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, Device=
State *dev,
> > > > +                               Error **errp)
> > > > +{
> > > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > > +
> > > > +    if (sphb->drc_id =3D=3D (uint32_t)-1) {
> > > > +        sphb->drc_id =3D sphb->index;
> > > > +    }
> > > > +
> > > > +    if (sphb->drc_id >=3D SPAPR_DRC_MAX_PHB) {
> > > > +        error_setg(errp, "PHB id %d out of range", sphb->drc_id);
> > > > +    }   =20
> > >=20
> > >=20
> > > sphb->index in considered 16bits in the existing code (even though it=
 is
> > > defined as 32bit) and SPAPR_DRC_MAX_PHB is just 256. I'd suggest usin=
g the
> > > same limit for both, either 256 or 65536 is fine for me.
> > >=20
> > > It is actually a bit weird - it is possible to completely configure f=
ew
> > > PHBs in the command line so they will have index=3D=3D-1 but PCI hotp=
lug code -
> > > spapr_phb_get_pci_func_drc() and spapr_phb_realize() - does not check=
 for
> > > this and just does (sphb->index << 16). =20
> >=20
> > You're right and this looks like a bug... I'll try to come up with a fi=
x.
> >  =20
> > > May be just ditch drc_id, enforce index not to be -1 and use it as dr=
c_id?
> > >  =20
> >=20
> > This was how Mike did it in the original patchset but David suggested
> > to introduce drc_id (to preserve existing setups I guess):
> >=20
> > http://patchwork.ozlabs.org/patch/466262/ =20
>=20
> Huh.  So I did.  But.. sorry, I've changed my mind.
>=20
> The fact that needing a DRC forces us to have a reasonable small id
> for each PHB seems like a good excuse to make index mandatory - I'm
> not convinced anyone was actually creating PHBs without index, and
> this does allow us to simplify a bunch of things.
>=20
> I'd like to see that done as a preliminary cleanup patch, though.
>=20

Just to be sure. I could verify that the weirdness reported by Alexey
causes QEMU to misbehave. Only the first "index-less" PHB has realized
DRCs:

=3D> subsequent "index-less" PHBs silently ignore hotplugging of PCI devices

=3D> QEMU won't even start with coldplugged devices in these "index-less"
   PHBs

This preliminary cleanup for hotpluggable PHBs is hence also a bug fix
for current PHBs.

Do we want to fix this long-standing bug in 2.10 ?

Do we want to preserve the current buggy behavior for older machine types ?

--Sig_/hjpCDu+srJeU+cWX3nTcxyc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmAnqYACgkQAvw66wEB28LhrQCdGXGn0qNH1wcxU3kEY1lyVZr8
TskAn3/Ea1DxCryYltbxIFe5C9npnlUm
=2sWJ
-----END PGP SIGNATURE-----

--Sig_/hjpCDu+srJeU+cWX3nTcxyc--
