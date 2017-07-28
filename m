Received: from eggs.gnu.org ([2001:4830:134:3::10]:36360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawrD-0003FC-1D
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr9-0007sT-9t
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:32 -0400
Date: Fri, 28 Jul 2017 14:24:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728042403.GK3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150105840463.12000.9666180368681199673.stgit@bahia>
	<ac479056-e370-7083-bd9e-60d873baf2b4@ozlabs.ru>
	<20170727190955.2792d785@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Content-Disposition: inline
In-Reply-To: <20170727190955.2792d785@bahia.lan>
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


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 07:09:55PM +0200, Greg Kurz wrote:
> On Thu, 27 Jul 2017 14:41:31 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 26/07/17 18:40, Greg Kurz wrote:
> > > Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> > > main system bus, so we register spapr machine as the handler for the
> > > main system bus.
> > >=20
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > - rebased against ppc-for-2.10
> > > - converted to unplug_request
> > > - handle drc_id at pre-plug
> > > - reset hotplugged PHB at plug
> > > - compatibility with older machine types
> > > ---
> > >  hw/ppc/spapr.c              |  114 +++++++++++++++++++++++++++++++++=
++++++++++
> > >  hw/ppc/spapr_drc.c          |    1=20
> > >  hw/ppc/spapr_pci.c          |    2 -
> > >  include/hw/pci-host/spapr.h |    2 +
> > >  include/hw/ppc/spapr.h      |    1=20
> > >  5 files changed, 118 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 90485054c2e7..589f76ef9fb8 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2540,6 +2540,10 @@ static void ppc_spapr_init(MachineState *machi=
ne)
> > >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> > >                           &savevm_htab_handlers, spapr);
> > > =20
> > > +    if (spapr->dr_phb_enabled) {
> > > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machin=
e), NULL);
> > > +    }
> > > +
> > >      qemu_register_boot_set(spapr_boot_set, spapr);
> > > =20
> > >      if (kvm_enabled()) {
> > > @@ -3238,6 +3242,103 @@ out:
> > >      error_propagate(errp, local_err);
> > >  }
> > > =20
> > > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev,
> > > +                               Error **errp)
> > > +{
> > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > +
> > > +    if (sphb->drc_id =3D=3D (uint32_t)-1) {
> > > +        sphb->drc_id =3D sphb->index;
> > > +    }
> > > +
> > > +    if (sphb->drc_id >=3D SPAPR_DRC_MAX_PHB) {
> > > +        error_setg(errp, "PHB id %d out of range", sphb->drc_id);
> > > +    } =20
> >=20
> >=20
> > sphb->index in considered 16bits in the existing code (even though it is
> > defined as 32bit) and SPAPR_DRC_MAX_PHB is just 256. I'd suggest using =
the
> > same limit for both, either 256 or 65536 is fine for me.
> >=20
> > It is actually a bit weird - it is possible to completely configure few
> > PHBs in the command line so they will have index=3D=3D-1 but PCI hotplu=
g code -
> > spapr_phb_get_pci_func_drc() and spapr_phb_realize() - does not check f=
or
> > this and just does (sphb->index << 16).
>=20
> You're right and this looks like a bug... I'll try to come up with a fix.
>=20
> > May be just ditch drc_id, enforce index not to be -1 and use it as drc_=
id?
> >=20
>=20
> This was how Mike did it in the original patchset but David suggested
> to introduce drc_id (to preserve existing setups I guess):
>=20
> http://patchwork.ozlabs.org/patch/466262/

Huh.  So I did.  But.. sorry, I've changed my mind.

The fact that needing a DRC forces us to have a reasonable small id
for each PHB seems like a good excuse to make index mandatory - I'm
not convinced anyone was actually creating PHBs without index, and
this does allow us to simplify a bunch of things.

I'd like to see that done as a preliminary cleanup patch, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6vGAACgkQbDjKyiDZ
s5LQAQ/9EPrHlZ5yIHpQIAoPEl5WLcpy4s1LL2Soo8oXe5HCZGtgRwMIlDc/I9m3
tAT7AVcWNdNo6/p0X+gS9zjXDoVgdeex/U7UEi2NsUW4lmgUSC5h/gOPA2vtbJQO
jQmh8esepr/OCj22pN8k7/T8mJjQRY9/klj71KQX4MOQXaE8vtARSUsGu3G6dCG1
e28kzV8es8pktjM7GqFyVWwvT6ycOu+oXjkR6X1IfqOIQU0qVbX17uKIMGUNiCXI
B4CGQHxe9onvs78dL+rNvWCnpDppn+LTBn96BxyBmg5HqImcbNvknByf1IQcDu/E
CeRXZizM4XzD+/sZd0wcFPFlURPttkRvSUy0jX5AUBvV3F1EBDvOaxLAmIX7tzf/
07+YdDdkL2fANQIw65rFmwnC4Gc9SDtB7tMk3nl53NhvRphjfAVl9FPQgwOP5JOe
uqjH3aBZ2e5JfYA69UPRlHCd9D3RAtrCqqvsEXxixJXE+K9iOlB4C64FU2pMPwCp
9dmyIUBp/r5Gf7zVX3cb/EH5tr2hDjnCFZDfV/9UajWqqLM4pEpUpN8l7bKBsqwG
x8zo/33pEHZhZD04EAdLgTUksh/ZAj1+KbtIMxJgiaF0BjDgg5egSNYSjJonYU1h
goyMR06DOa+wL56A/0mWzjx+4Z+uYYWkLK6Dvi07TqzIq3CFUmE=
=pHIA
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
