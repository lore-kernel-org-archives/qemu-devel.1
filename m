Received: from eggs.gnu.org ([2001:4830:134:3::10]:40941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcjZF-0004j9-49
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcjZD-0005lW-Oa
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:39:25 -0400
Date: Wed, 2 Aug 2017 12:39:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170802023912.GD2838@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150105840463.12000.9666180368681199673.stgit@bahia>
	<ac479056-e370-7083-bd9e-60d873baf2b4@ozlabs.ru>
	<20170727190955.2792d785@bahia.lan>
	<20170728042403.GK3098@umbus.fritz.box>
	<20170801173046.3805979d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20170801173046.3805979d@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 05:30:46PM +0200, Greg Kurz wrote:
> On Fri, 28 Jul 2017 14:24:03 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jul 27, 2017 at 07:09:55PM +0200, Greg Kurz wrote:
> > > On Thu, 27 Jul 2017 14:41:31 +1000
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >  =20
> > > > On 26/07/17 18:40, Greg Kurz wrote: =20
> > > > > Hotplugging PHBs is a machine-level operation, but PHBs reside on=
 the
> > > > > main system bus, so we register spapr machine as the handler for =
the
> > > > > main system bus.
> > > > >=20
> > > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > ---
> > > > > - rebased against ppc-for-2.10
> > > > > - converted to unplug_request
> > > > > - handle drc_id at pre-plug
> > > > > - reset hotplugged PHB at plug
> > > > > - compatibility with older machine types
> > > > > ---
> > > > >  hw/ppc/spapr.c              |  114 +++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  hw/ppc/spapr_drc.c          |    1=20
> > > > >  hw/ppc/spapr_pci.c          |    2 -
> > > > >  include/hw/pci-host/spapr.h |    2 +
> > > > >  include/hw/ppc/spapr.h      |    1=20
> > > > >  5 files changed, 118 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > index 90485054c2e7..589f76ef9fb8 100644
> > > > > --- a/hw/ppc/spapr.c
> > > > > +++ b/hw/ppc/spapr.c
> > > > > @@ -2540,6 +2540,10 @@ static void ppc_spapr_init(MachineState *m=
achine)
> > > > >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> > > > >                           &savevm_htab_handlers, spapr);
> > > > > =20
> > > > > +    if (spapr->dr_phb_enabled) {
> > > > > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(ma=
chine), NULL);
> > > > > +    }
> > > > > +
> > > > >      qemu_register_boot_set(spapr_boot_set, spapr);
> > > > > =20
> > > > >      if (kvm_enabled()) {
> > > > > @@ -3238,6 +3242,103 @@ out:
> > > > >      error_propagate(errp, local_err);
> > > > >  }
> > > > > =20
> > > > > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, Devi=
ceState *dev,
> > > > > +                               Error **errp)
> > > > > +{
> > > > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > > > +
> > > > > +    if (sphb->drc_id =3D=3D (uint32_t)-1) {
> > > > > +        sphb->drc_id =3D sphb->index;
> > > > > +    }
> > > > > +
> > > > > +    if (sphb->drc_id >=3D SPAPR_DRC_MAX_PHB) {
> > > > > +        error_setg(errp, "PHB id %d out of range", sphb->drc_id);
> > > > > +    }   =20
> > > >=20
> > > >=20
> > > > sphb->index in considered 16bits in the existing code (even though =
it is
> > > > defined as 32bit) and SPAPR_DRC_MAX_PHB is just 256. I'd suggest us=
ing the
> > > > same limit for both, either 256 or 65536 is fine for me.
> > > >=20
> > > > It is actually a bit weird - it is possible to completely configure=
 few
> > > > PHBs in the command line so they will have index=3D=3D-1 but PCI ho=
tplug code -
> > > > spapr_phb_get_pci_func_drc() and spapr_phb_realize() - does not che=
ck for
> > > > this and just does (sphb->index << 16). =20
> > >=20
> > > You're right and this looks like a bug... I'll try to come up with a =
fix.
> > >  =20
> > > > May be just ditch drc_id, enforce index not to be -1 and use it as =
drc_id?
> > > >  =20
> > >=20
> > > This was how Mike did it in the original patchset but David suggested
> > > to introduce drc_id (to preserve existing setups I guess):
> > >=20
> > > http://patchwork.ozlabs.org/patch/466262/ =20
> >=20
> > Huh.  So I did.  But.. sorry, I've changed my mind.
> >=20
> > The fact that needing a DRC forces us to have a reasonable small id
> > for each PHB seems like a good excuse to make index mandatory - I'm
> > not convinced anyone was actually creating PHBs without index, and
> > this does allow us to simplify a bunch of things.
> >=20
> > I'd like to see that done as a preliminary cleanup patch, though.
> >=20
>=20
> Just to be sure. I could verify that the weirdness reported by Alexey
> causes QEMU to misbehave. Only the first "index-less" PHB has realized
> DRCs:
>=20
> =3D> subsequent "index-less" PHBs silently ignore hotplugging of PCI devi=
ces
>=20
> =3D> QEMU won't even start with coldplugged devices in these "index-less"
>    PHBs
>=20
> This preliminary cleanup for hotpluggable PHBs is hence also a bug fix
> for current PHBs.

Ok.

> Do we want to fix this long-standing bug in 2.10 ?

No, not worth pushing in this late.

> Do we want to preserve the current buggy behavior for older machine
> types ?

No, I don't think so.  I think the reasonable course here is to push
the new behaviour out.  Only if someone complains that they were
actually relying on the old behaviour in the wild do we try to
preserve it for the older machine types.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmBO08ACgkQbDjKyiDZ
s5LasQ/+I0ivnJ3fQlFc1OR0Yyr0syFIjpUMb58ZFLSWQNQDExHxPp/cnu2WpFPY
Cc/rA2m7VYf4o7ilDebKyXbWjIqeJrrhN4JC+JmAUyAadoxcM3lfZOnmw+vVEjLj
9yyEtDFbFL9UDgkq5JM7yAbYMS+yVnKIm0VqDjLFHOXTxehTlmc9QTts/f+i+QLr
48fXiUqT7WGNeH/Ju5Me8Iiz3vVUDFsGgFkQSMl2VKVjVpMVKT4K13EvqvI9Y4oA
CkaaYuKuB0yPO2/H2JHp1FuSec11C4fA5s/C+mTVVi0xlS9z4wb+6vRVBljNnkCm
NkmCU6pKw6pHADLPcqqmHXSMs6cLPwoU19I6OuKUzS8zbr05BgqDxefJ8isYADvy
Tk5DzZjgCq0/Nl50Dfinwo62h1v79HdYqRHSeE+bmdbUigNhjTdVukIxGORaWI4J
t2uW7JdTMZw+/wJxJYEljJk9F1lh8+NbfuMntoO3ZhxyMKd8vRRWxvufz73kjvLf
q6ohTLhNdhc/PbmdksJ13UGsaPTMISYZ5kOUU75cjduTEKkhEYwaMBexb7heOd7p
KoIpEEhmCK7nt3ajrG6PWehAF7G7dAX9hO3LPueN5qfoe2sPfIJtz4FiMU0OkI9v
4cOnp91ThMWCCxqnRXgz4aqw8+U+ZEidqjR5G3g+qEAPYifXUwM=
=Mbxx
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
