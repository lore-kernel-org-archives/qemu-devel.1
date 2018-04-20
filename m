Received: from eggs.gnu.org ([2001:4830:134:3::10]:37842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9S8O-0002Pm-R0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9S8L-0005JL-Jg
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:15:12 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:40127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9S8L-0005IP-9n
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:15:09 -0400
Received: from player791.ha.ovh.net (unknown [10.109.122.48])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7A61A96C24
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 11:15:07 +0200 (CEST)
Date: Fri, 20 Apr 2018 11:15:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420111501.5fb192bf@bahia.lan>
In-Reply-To: <20180420063437.GM2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-2-david@gibson.dropbear.id.au>
	<20180419154823.0e937610@bahia.lan>
	<20180420063437.GM2434@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/QTWF_DNHN8Eac3WnPE5TK3H";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.13 01/10] spapr: Avoid redundant
 calls to spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/QTWF_DNHN8Eac3WnPE5TK3H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Apr 2018 16:34:37 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Apr 19, 2018 at 03:48:23PM +0200, Greg Kurz wrote:
> > On Tue, 17 Apr 2018 17:17:13 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > af81cf323c1 "spapr: CPU hotplug support" added a direct call to
> > > spapr_cpu_reset() in spapr_cpu_init(), as well as registering it as a
> > > reset callback.  That was in order to make sure that the reset functi=
on
> > > got called for a newly hotplugged cpu, which would miss the global ma=
chine
> > > reset.
> > >=20
> > > However, this change means that spapr_cpu_reset() gets called twice f=
or
> > > normal cold-plugged cpus: once from spapr_cpu_init(), then again duri=
ng
> > > the system reset.  As well as being ugly in its redundancy, the first=
 call
> > > happens before the machine reset calls have happened, which will cause
> > > problems for some things we're going to want to add.
> > >=20
> > > So, we remove the reset call from spapr_cpu_init().  We instead put an
> > > explicit reset call in the hotplug specific path.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > --- =20
> >=20
> > I had sent a tentative patch to do something similar earlier this year:
> >=20
> > https://patchwork.ozlabs.org/patch/862116/
> >=20
> > but it got nacked for several reasons, one of them being you were
> > "always wary of using the hotplugged parameter, because what qemu
> > means by it often doesn't line up with what PAPR means by it." =20
>=20
> Yeah, I was and am wary of that, but convinced myself it was correct
> in this case (which doesn't really interact with the PAPR meaning of
> hotplug).
>=20
> > >  hw/ppc/spapr.c                  |  6 ++++--
> > >  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
> > >  include/hw/ppc/spapr_cpu_core.h |  2 ++
> > >  3 files changed, 18 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 7b2bc4e25d..81b50af3b5 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
> > > =20
> > >          if (hotplugged) { =20
> >=20
> > ... but you rely on it here. Can you explain why it is
> > okay now ? =20
>=20
> So the value I actually need here is "wasn't present at the last
> system reset" (with false positives being mostly harmless, but not
> false negatives).
>=20

Hmm... It is rather the other way around, sth like "will be caught
by the initial machine reset".

> > Also, if QEMU is started with -incoming and the CPU core
> > is hotplugged before migration begins, the following will
> > return false:
> >=20
> > static inline bool spapr_drc_hotplugged(DeviceState *dev)
> > {
> >     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
> > }
> >=20
> > and the CPU core won't be reset. =20
>=20
> Uh... spapr_dtc_hotplugged() would definitely be wrong here, which is
> why I'm not using it.
>=20

This is how hotplugged is set in spapr_core_plug():

    bool hotplugged =3D spapr_drc_hotplugged(dev);

but to detect the "will be caught by the initial machine reset" condition,
we only need to check dev->hotplugged actually.

> >  =20
> > >              /*
> > > -             * Send hotplug notification interrupt to the guest only
> > > -             * in case of hotplugged CPUs.
> > > +             * For hotplugged CPUs, we need to reset them (they miss=
ed
> > > +             * out on the system reset), and send the guest a
> > > +             * notification
> > >               */
> > > +            spapr_cpu_core_reset(core); =20
> >=20
> > spapr_cpu_reset() also sets the compat mode, which is used
> > to set some properties in the DT, ie, this should be called
> > before spapr_populate_hotplug_cpu_dt(). =20
>=20
> Good point.  I've moved the reset to fix that.
>=20
> >  =20
> > >              spapr_hotplug_req_add_by_index(drc);
> > >          } else {
> > >              spapr_drc_reset(drc);
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 94afeb399e..aa17626cda 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -70,7 +70,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr=
, PowerPCCPU *cpu,
> > >      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> > > =20
> > >      qemu_register_reset(spapr_cpu_reset, cpu);
> > > -    spapr_cpu_reset(cpu); =20
> >=20
> > spapr_cpu_reset() also sets cs->halted to 1, to let the guest start
> > non-boot CPUs with an RTAS call. With this change, a hotplugged CPU
> > is started right away and may run in the guest before the hotplug
> > path could even reset it. =20
>=20
> Uh.. I was assuming the plug path (the qemu side, obviously, not the
> guest side) would be completed before the cpu could execute.  If
> that's not the case I'll definitely have to rethink this.
>=20

It isn't the case unless @halted is set.

> > Not sure how to handle that other than setting halted to 1 in
> > spapr_cpu_init() as well, but you already nacked that approach
> > because it would mean "poking specifics in a CPU that hasn't
> > already been set to a known state by a reset"... =20
>=20
> Yeah.. I may have been off base with that comment.  Bear in mind that
> at the time I didn't see a specific reason to avoid the double reset -
> now I do.
>=20

Fair enough :)

--Sig_/QTWF_DNHN8Eac3WnPE5TK3H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrZr5UACgkQcdTV5YIv
c9a6ww//cXfsZjEF1JSGEQxC9tbsGtXtzL43sZcZ3kycxYLQnwE05dBqC0Jytjaz
QKEo8zZjLiM4fp0LPsUISgJyq7CkfmOgX64s11g0sslZ269gUWfgS4d/V+qRmg8g
BVNh5fZBCEK7/RHRuRuyK7CpFKFNthpKWbSIJIF/VSZFecnNBH4xzESt6qFpx+RS
pVkHnW1J3C8KM0Jom9wfZFdGi3tiBfj2D/kqQi1/rj1uodqwIVTl3TtPr9pgDnj6
53uyE/t7Rme4kx6nQ8URtdQvHExX66wJs/OLQVOrvCDJOSD3nitz03Ru5Mbhm1IV
I+n4vhPgQf095wfrLJNNLRRBpuOo1Ec4WdT3wUumiyQCgJYF/z3CnLvxjsCZEp71
I80RLMOH2T32+C1PjDMBgWaQlkMBdXhH/RKAPuw16oZZeYwZzqlCiUE6rb358WFa
soAmXmd/Pi+UDJId9NZ8XQbPeL5PuCnz6nChQ3h4OVRD3GjykpSEv/2g/Ac0+/Aw
lZHPi2JAILowRgTIxLDFCsuqzAWSvRqFao/VqyTFIzAP4BCTr7WxEYCTBG8LEYgz
jDtC3pZMVyP9cmU/OJ9kKs/EhmZzW/cooEF51s2204YfbKU5bbR1v9WCCuL1tyTu
u5xlYuRymmuk/nJ8e/+fUOM/L++/nX3t+jwS8/XHwp9hd0my+TU=
=8BU/
-----END PGP SIGNATURE-----

--Sig_/QTWF_DNHN8Eac3WnPE5TK3H--
