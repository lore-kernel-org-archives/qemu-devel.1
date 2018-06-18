Received: from eggs.gnu.org ([2001:4830:134:3::10]:48416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUl47-0001aU-Cb
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUl45-0006la-OK
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:42:51 -0400
Date: Mon, 18 Jun 2018 13:42:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618034237.GR25461@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-2-david@gibson.dropbear.id.au>
	<20180419154823.0e937610@bahia.lan>
	<20180420063437.GM2434@umbus.fritz.box>
	<20180420111501.5fb192bf@bahia.lan>
	<20180420173942.641ed698@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYG5ZC/RuVsIq1ir"
Content-Disposition: inline
In-Reply-To: <20180420173942.641ed698@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 01/10] spapr: Avoid
 redundant calls to spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--cYG5ZC/RuVsIq1ir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 05:39:42PM +0200, Greg Kurz wrote:
> On Fri, 20 Apr 2018 11:15:01 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Fri, 20 Apr 2018 16:34:37 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Thu, Apr 19, 2018 at 03:48:23PM +0200, Greg Kurz wrote: =20
> > > > On Tue, 17 Apr 2018 17:17:13 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > af81cf323c1 "spapr: CPU hotplug support" added a direct call to
> > > > > spapr_cpu_reset() in spapr_cpu_init(), as well as registering it =
as a
> > > > > reset callback.  That was in order to make sure that the reset fu=
nction
> > > > > got called for a newly hotplugged cpu, which would miss the globa=
l machine
> > > > > reset.
> > > > >=20
> > > > > However, this change means that spapr_cpu_reset() gets called twi=
ce for
> > > > > normal cold-plugged cpus: once from spapr_cpu_init(), then again =
during
> > > > > the system reset.  As well as being ugly in its redundancy, the f=
irst call
> > > > > happens before the machine reset calls have happened, which will =
cause
> > > > > problems for some things we're going to want to add.
> > > > >=20
> > > > > So, we remove the reset call from spapr_cpu_init().  We instead p=
ut an
> > > > > explicit reset call in the hotplug specific path.
> > > > >=20
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > ---   =20
> > > >=20
> > > > I had sent a tentative patch to do something similar earlier this y=
ear:
> > > >=20
> > > > https://patchwork.ozlabs.org/patch/862116/
> > > >=20
> > > > but it got nacked for several reasons, one of them being you were
> > > > "always wary of using the hotplugged parameter, because what qemu
> > > > means by it often doesn't line up with what PAPR means by it."   =
=20
> > >=20
> > > Yeah, I was and am wary of that, but convinced myself it was correct
> > > in this case (which doesn't really interact with the PAPR meaning of
> > > hotplug).
> > >  =20
> > > > >  hw/ppc/spapr.c                  |  6 ++++--
> > > > >  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
> > > > >  include/hw/ppc/spapr_cpu_core.h |  2 ++
> > > > >  3 files changed, 18 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > index 7b2bc4e25d..81b50af3b5 100644
> > > > > --- a/hw/ppc/spapr.c
> > > > > +++ b/hw/ppc/spapr.c
> > > > > @@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandler=
 *hotplug_dev, DeviceState *dev,
> > > > > =20
> > > > >          if (hotplugged) {   =20
> > > >=20
> > > > ... but you rely on it here. Can you explain why it is
> > > > okay now ?   =20
> > >=20
> > > So the value I actually need here is "wasn't present at the last
> > > system reset" (with false positives being mostly harmless, but not
> > > false negatives).
> > >  =20
> >=20
> > Hmm... It is rather the other way around, sth like "will be caught
> > by the initial machine reset".
> >=20
> > > > Also, if QEMU is started with -incoming and the CPU core
> > > > is hotplugged before migration begins, the following will
> > > > return false:
> > > >=20
> > > > static inline bool spapr_drc_hotplugged(DeviceState *dev)
> > > > {
> > > >     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
> > > > }
> > > >=20
> > > > and the CPU core won't be reset.   =20
> > >=20
> > > Uh... spapr_dtc_hotplugged() would definitely be wrong here, which is
> > > why I'm not using it.
> > >  =20
> >=20
> > This is how hotplugged is set in spapr_core_plug():
> >=20
> >     bool hotplugged =3D spapr_drc_hotplugged(dev);
> >=20
> > but to detect the "will be caught by the initial machine reset" conditi=
on,
> > we only need to check dev->hotplugged actually.
> >=20
> > > >    =20
> > > > >              /*
> > > > > -             * Send hotplug notification interrupt to the guest =
only
> > > > > -             * in case of hotplugged CPUs.
> > > > > +             * For hotplugged CPUs, we need to reset them (they =
missed
> > > > > +             * out on the system reset), and send the guest a
> > > > > +             * notification
> > > > >               */
> > > > > +            spapr_cpu_core_reset(core);   =20
> > > >=20
> > > > spapr_cpu_reset() also sets the compat mode, which is used
> > > > to set some properties in the DT, ie, this should be called
> > > > before spapr_populate_hotplug_cpu_dt().   =20
> > >=20
> > > Good point.  I've moved the reset to fix that.
> > >  =20
>=20
> Thinking of it again: since cold-plugged devices reach this before machine
> reset, we would then attach to the DRC a DT blob based on a non-reset CPU=
 :-\
>=20
> Instead of registering a reset handler for each individual CPUs, maybe
> we should rather register it a the CPU core level. The handler would
> first reset all CPUs in the core and then setup the DRC for new cores onl=
y,
> like it is done currently in spapr_core_plug().
>=20
> spapr_core_plug() would then just need to register the reset handler,
> and call it only for hotplugged cores.

Handling the resets via the core level might be a good idea anyway,
but I don't think it can address the problem we're hitting here.

I've investigated further and I'm pretty sure we can't fix this
without generic code changes.  cpu_common_realizefn() (which is called
by our ppc cpu realize hook via the parent_realize chain) contains
this:

    if (dev->hotplugged) {
        cpu_synchronize_post_init(cpu);
        cpu_resume(cpu);
    }

So, as soon as the hotplugged cpu is realized, it's running, which
means by the time we call the plug() hotplug handler we're too late to
do any reset initialization.

I think there are two ways to look at this:

1) The reset handlers are specifically about *system* reset, not
device reset, and so we shoudln't really expect them to be called for
hotplugged devices.  If we want to share reset initialization with
"initial" initialization, we should explicitly call the reset handler
=66rom the (realize time) init code.. which is what we do now.

2) Common core realize should _not_ activate the cpu.  Instead that
should be the plug() handler's job.  This would require changing the
x86 cpu plug handler (and whatever else) to kick off the cpu after
realization.

For now I'm inclined to just let it stay at (1).

The problem I had which I thought required this, doesn't after all.  I
came up with a different solution that involves moving the spapr caps
initialization earlier, instead of the cpu reset later.  That turned
out to be substantially easier than I first thought, and regardless of
what we do above long term, I think it's a better way to handle the
caps.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYG5ZC/RuVsIq1ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnKisACgkQbDjKyiDZ
s5IQzBAAzfUpNJqCRAygWqkUFTQJchSKHThnRwISTl215zceMH5Wq7mQohamJgGI
Gj/v1UrPTtLcmSsH4gp+Q1rEjwd9Ml6k0MKQ195BeTanfbADPuFYSUSI632uJDnS
L8pAk2s4vAQcir3c+yKp+sk6gYdsA7u8qZ3a+TDYh92Txin7eIFpsHHrXvScHHkQ
6IGHqYrsVmyC0LRfIYXELtXTiKAMA+AsJ9Qyc/rXRBxwcbJGO4uy+ooKCoO6svIi
nJiPTR5FC0fMdStV34U65J0aVWhtZcKCvvJeR5AdHmSqN3U5V/AINI0a5T5aaK7v
9K7ce5xADMPH4bmNl0c/5x5s0PnRdYAO9HM7AsOfR6KiCiZRMSgkV5WVHNJQTm5B
182NiFjLTm7/aAZy8YJ7uOOKZOVBeecp6Yvc9SxOBm3IaDz9iL4RTPp8lnknbrIx
J59qwxfYb8qJF35YygmZ7vnw2rW0DbK817GROGZarbETm9jxbpDnttDdueCH3NKn
CUa8Tke4Mn+IdpbFvxGwPIWFFSFDurbaz2Jvi1f1Xb5snSHR+wowyoYr5jk67O8C
nuVCa5guxIr7w2lqlMFEvEmewGsLxgezNMAVGiEQzRlDpF65nJ+4tCzLkD6h/HxE
sS+CgwawBg6qL1I7i/oTuY1O0jF4Omjc7hEmsL8FetTUIK942IA=
=ZtJv
-----END PGP SIGNATURE-----

--cYG5ZC/RuVsIq1ir--
