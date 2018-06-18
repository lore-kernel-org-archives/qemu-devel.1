Received: from eggs.gnu.org ([2001:4830:134:3::10]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUq2f-00033R-Mg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUq2b-0005EN-5i
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:01:41 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:42940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUq2a-0005Dx-OA
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:01:37 -0400
Received: from player778.ha.ovh.net (unknown [10.109.122.9])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id EE0FBB6BFE
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:01:34 +0200 (CEST)
Date: Mon, 18 Jun 2018 11:01:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180618110127.01e7c059@bahia.lan>
In-Reply-To: <20180618034237.GR25461@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-2-david@gibson.dropbear.id.au>
	<20180419154823.0e937610@bahia.lan>
	<20180420063437.GM2434@umbus.fritz.box>
	<20180420111501.5fb192bf@bahia.lan>
	<20180420173942.641ed698@bahia.lan>
	<20180618034237.GR25461@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/lPDj6HeYS785Z_hRbwVJfgn";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

--Sig_/lPDj6HeYS785Z_hRbwVJfgn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Jun 2018 13:42:37 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Apr 20, 2018 at 05:39:42PM +0200, Greg Kurz wrote:
> > On Fri, 20 Apr 2018 11:15:01 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >  =20
> > > On Fri, 20 Apr 2018 16:34:37 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Thu, Apr 19, 2018 at 03:48:23PM +0200, Greg Kurz wrote:   =20
> > > > > On Tue, 17 Apr 2018 17:17:13 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >      =20
> > > > > > af81cf323c1 "spapr: CPU hotplug support" added a direct call to
> > > > > > spapr_cpu_reset() in spapr_cpu_init(), as well as registering i=
t as a
> > > > > > reset callback.  That was in order to make sure that the reset =
function
> > > > > > got called for a newly hotplugged cpu, which would miss the glo=
bal machine
> > > > > > reset.
> > > > > >=20
> > > > > > However, this change means that spapr_cpu_reset() gets called t=
wice for
> > > > > > normal cold-plugged cpus: once from spapr_cpu_init(), then agai=
n during
> > > > > > the system reset.  As well as being ugly in its redundancy, the=
 first call
> > > > > > happens before the machine reset calls have happened, which wil=
l cause
> > > > > > problems for some things we're going to want to add.
> > > > > >=20
> > > > > > So, we remove the reset call from spapr_cpu_init().  We instead=
 put an
> > > > > > explicit reset call in the hotplug specific path.
> > > > > >=20
> > > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > ---     =20
> > > > >=20
> > > > > I had sent a tentative patch to do something similar earlier this=
 year:
> > > > >=20
> > > > > https://patchwork.ozlabs.org/patch/862116/
> > > > >=20
> > > > > but it got nacked for several reasons, one of them being you were
> > > > > "always wary of using the hotplugged parameter, because what qemu
> > > > > means by it often doesn't line up with what PAPR means by it."   =
  =20
> > > >=20
> > > > Yeah, I was and am wary of that, but convinced myself it was correct
> > > > in this case (which doesn't really interact with the PAPR meaning of
> > > > hotplug).
> > > >    =20
> > > > > >  hw/ppc/spapr.c                  |  6 ++++--
> > > > > >  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
> > > > > >  include/hw/ppc/spapr_cpu_core.h |  2 ++
> > > > > >  3 files changed, 18 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > > index 7b2bc4e25d..81b50af3b5 100644
> > > > > > --- a/hw/ppc/spapr.c
> > > > > > +++ b/hw/ppc/spapr.c
> > > > > > @@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandl=
er *hotplug_dev, DeviceState *dev,
> > > > > > =20
> > > > > >          if (hotplugged) {     =20
> > > > >=20
> > > > > ... but you rely on it here. Can you explain why it is
> > > > > okay now ?     =20
> > > >=20
> > > > So the value I actually need here is "wasn't present at the last
> > > > system reset" (with false positives being mostly harmless, but not
> > > > false negatives).
> > > >    =20
> > >=20
> > > Hmm... It is rather the other way around, sth like "will be caught
> > > by the initial machine reset".
> > >  =20
> > > > > Also, if QEMU is started with -incoming and the CPU core
> > > > > is hotplugged before migration begins, the following will
> > > > > return false:
> > > > >=20
> > > > > static inline bool spapr_drc_hotplugged(DeviceState *dev)
> > > > > {
> > > > >     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE=
);
> > > > > }
> > > > >=20
> > > > > and the CPU core won't be reset.     =20
> > > >=20
> > > > Uh... spapr_dtc_hotplugged() would definitely be wrong here, which =
is
> > > > why I'm not using it.
> > > >    =20
> > >=20
> > > This is how hotplugged is set in spapr_core_plug():
> > >=20
> > >     bool hotplugged =3D spapr_drc_hotplugged(dev);
> > >=20
> > > but to detect the "will be caught by the initial machine reset" condi=
tion,
> > > we only need to check dev->hotplugged actually.
> > >  =20
> > > > >      =20
> > > > > >              /*
> > > > > > -             * Send hotplug notification interrupt to the gues=
t only
> > > > > > -             * in case of hotplugged CPUs.
> > > > > > +             * For hotplugged CPUs, we need to reset them (the=
y missed
> > > > > > +             * out on the system reset), and send the guest a
> > > > > > +             * notification
> > > > > >               */
> > > > > > +            spapr_cpu_core_reset(core);     =20
> > > > >=20
> > > > > spapr_cpu_reset() also sets the compat mode, which is used
> > > > > to set some properties in the DT, ie, this should be called
> > > > > before spapr_populate_hotplug_cpu_dt().     =20
> > > >=20
> > > > Good point.  I've moved the reset to fix that.
> > > >    =20
> >=20
> > Thinking of it again: since cold-plugged devices reach this before mach=
ine
> > reset, we would then attach to the DRC a DT blob based on a non-reset C=
PU :-\
> >=20
> > Instead of registering a reset handler for each individual CPUs, maybe
> > we should rather register it a the CPU core level. The handler would
> > first reset all CPUs in the core and then setup the DRC for new cores o=
nly,
> > like it is done currently in spapr_core_plug().
> >=20
> > spapr_core_plug() would then just need to register the reset handler,
> > and call it only for hotplugged cores. =20
>=20
> Handling the resets via the core level might be a good idea anyway,
> but I don't think it can address the problem we're hitting here.
>=20
> I've investigated further and I'm pretty sure we can't fix this
> without generic code changes.  cpu_common_realizefn() (which is called
> by our ppc cpu realize hook via the parent_realize chain) contains
> this:
>=20
>     if (dev->hotplugged) {
>         cpu_synchronize_post_init(cpu);
>         cpu_resume(cpu);
>     }
>=20

Yes, these come from:

commit 13eed94ed5617b98e657163490584dc2a0cc4b32
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Tue Apr 23 10:29:36 2013 +0200

    cpu: Call cpu_synchronize_post_init() from DeviceClass::realize()
   =20
    If hotplugged, synchronize CPU state to KVM.
   =20
    Signed-off-by: Igor Mammedov <imammedo@redhat.com>
    Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
    Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

and

commit 6afb4721f3e45da727110470a61aafcd6682395e
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Tue Apr 23 10:29:38 2013 +0200

    cpu: Resume CPU from DeviceClass::realize() if hot-plugged
   =20
    Signed-off-by: Igor Mammedov <imammedo@redhat.com>
    Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

> So, as soon as the hotplugged cpu is realized, it's running, which
> means by the time we call the plug() hotplug handler we're too late to
> do any reset initialization.
>=20
> I think there are two ways to look at this:
>=20
> 1) The reset handlers are specifically about *system* reset, not
> device reset, and so we shoudln't really expect them to be called for
> hotplugged devices.  If we want to share reset initialization with
> "initial" initialization, we should explicitly call the reset handler
> from the (realize time) init code.. which is what we do now.
>=20
> 2) Common core realize should _not_ activate the cpu.  Instead that
> should be the plug() handler's job.  This would require changing the
> x86 cpu plug handler (and whatever else) to kick off the cpu after
> realization.
>=20
> For now I'm inclined to just let it stay at (1).
>=20

Maybe Igor and Eduardo (now Cc'd) can provide a hint about 2) ?

> The problem I had which I thought required this, doesn't after all.  I
> came up with a different solution that involves moving the spapr caps
> initialization earlier, instead of the cpu reset later.  That turned
> out to be substantially easier than I first thought, and regardless of
> what we do above long term, I think it's a better way to handle the
> caps.
>=20


--Sig_/lPDj6HeYS785Z_hRbwVJfgn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsndOcACgkQcdTV5YIv
c9YIaxAAg26aLMXwEX7j4+liHDU7khnIxc77RqiBEwyheAic8g53aFT+p7Idn8EF
XlBWVH15b+ZtFoaiR8zhXCvklAZvKIEUFwjABsqVf1W3rydMKvX8O0vw+zaXL2eH
zG1xUwWdG9d5XyYrtelAebXDkggfS/7zlIgc0kmc7MjG/sBeVvyveBWa/FLf4RgS
c0k9HGzOw0PI6riM0UMESaiPxKbV/FvLc0M3w6UPIdpUr5oryghfnKrUaVdK+K9E
IXbMjhyY0er/WTfvbc6kmCd09Be/ggyaB8sTkx3LfSxG4BVlAPgzQvubfjmOp9NO
i2Wau7t4wbim4O3qJsW1n2NtSkI9TvRep4UHDonSxWa+J3xLTsn/XieghjAdErPE
4OrcOvhnOV0g+X1IVSXbJBWEjW2bUEfiILJHUUXCu3w6HngO1J/zf+gC4fqS/6b+
ugkh5JM+LqYe+1GEHJmbv2WY1k98PTQnbIgYTN2+PhGOOFODm5YFuxn+Izc7eS9B
kpbFyJ9d/XIHfVfYs5p7myR8mNx7qXu/ytN29s6KHfNFB9ViSLrCFeFFSakCMW70
GYe4UfW7NdaNVrkVFtuU6pUohv4JWctVjl9ekqYWer8Js7BX0EkZ9moJreN1TUog
dvVoCiW0qTUcNhdHK4J40zNhsoyyLRw7Q0ibcOl9uLDgpu6w5LE=
=toRu
-----END PGP SIGNATURE-----

--Sig_/lPDj6HeYS785Z_hRbwVJfgn--
