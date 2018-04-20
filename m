Received: from eggs.gnu.org ([2001:4830:134:3::10]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9PdA-0002yL-6K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9Pd8-00029S-Qd
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:34:48 -0400
Date: Fri, 20 Apr 2018 16:34:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420063437.GM2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-2-david@gibson.dropbear.id.au>
	<20180419154823.0e937610@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n1iI6MeELQa9IOaF"
Content-Disposition: inline
In-Reply-To: <20180419154823.0e937610@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--n1iI6MeELQa9IOaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 03:48:23PM +0200, Greg Kurz wrote:
> On Tue, 17 Apr 2018 17:17:13 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > af81cf323c1 "spapr: CPU hotplug support" added a direct call to
> > spapr_cpu_reset() in spapr_cpu_init(), as well as registering it as a
> > reset callback.  That was in order to make sure that the reset function
> > got called for a newly hotplugged cpu, which would miss the global mach=
ine
> > reset.
> >=20
> > However, this change means that spapr_cpu_reset() gets called twice for
> > normal cold-plugged cpus: once from spapr_cpu_init(), then again during
> > the system reset.  As well as being ugly in its redundancy, the first c=
all
> > happens before the machine reset calls have happened, which will cause
> > problems for some things we're going to want to add.
> >=20
> > So, we remove the reset call from spapr_cpu_init().  We instead put an
> > explicit reset call in the hotplug specific path.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> I had sent a tentative patch to do something similar earlier this year:
>=20
> https://patchwork.ozlabs.org/patch/862116/
>=20
> but it got nacked for several reasons, one of them being you were
> "always wary of using the hotplugged parameter, because what qemu
> means by it often doesn't line up with what PAPR means by it."

Yeah, I was and am wary of that, but convinced myself it was correct
in this case (which doesn't really interact with the PAPR meaning of
hotplug).

> >  hw/ppc/spapr.c                  |  6 ++++--
> >  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
> >  include/hw/ppc/spapr_cpu_core.h |  2 ++
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 7b2bc4e25d..81b50af3b5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> > =20
> >          if (hotplugged) {
>=20
> ... but you rely on it here. Can you explain why it is
> okay now ?

So the value I actually need here is "wasn't present at the last
system reset" (with false positives being mostly harmless, but not
false negatives).

> Also, if QEMU is started with -incoming and the CPU core
> is hotplugged before migration begins, the following will
> return false:
>=20
> static inline bool spapr_drc_hotplugged(DeviceState *dev)
> {
>     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
> }
>=20
> and the CPU core won't be reset.

Uh... spapr_dtc_hotplugged() would definitely be wrong here, which is
why I'm not using it.

>=20
> >              /*
> > -             * Send hotplug notification interrupt to the guest only
> > -             * in case of hotplugged CPUs.
> > +             * For hotplugged CPUs, we need to reset them (they missed
> > +             * out on the system reset), and send the guest a
> > +             * notification
> >               */
> > +            spapr_cpu_core_reset(core);
>=20
> spapr_cpu_reset() also sets the compat mode, which is used
> to set some properties in the DT, ie, this should be called
> before spapr_populate_hotplug_cpu_dt().

Good point.  I've moved the reset to fix that.

>=20
> >              spapr_hotplug_req_add_by_index(drc);
> >          } else {
> >              spapr_drc_reset(drc);
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 94afeb399e..aa17626cda 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -70,7 +70,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, =
PowerPCCPU *cpu,
> >      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> > =20
> >      qemu_register_reset(spapr_cpu_reset, cpu);
> > -    spapr_cpu_reset(cpu);
>=20
> spapr_cpu_reset() also sets cs->halted to 1, to let the guest start
> non-boot CPUs with an RTAS call. With this change, a hotplugged CPU
> is started right away and may run in the guest before the hotplug
> path could even reset it.

Uh.. I was assuming the plug path (the qemu side, obviously, not the
guest side) would be completed before the cpu could execute.  If
that's not the case I'll definitely have to rethink this.

> Not sure how to handle that other than setting halted to 1 in
> spapr_cpu_init() as well, but you already nacked that approach
> because it would mean "poking specifics in a CPU that hasn't
> already been set to a known state by a reset"...

Yeah.. I may have been off base with that comment.  Bear in mind that
at the time I didn't see a specific reason to avoid the double reset -
now I do.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n1iI6MeELQa9IOaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZifsACgkQbDjKyiDZ
s5JfrxAAym+zveqMdPjmG77HlPAEFZBf0b22OtvgQ65IOtXBavcxxHkjEQrjrFFz
U2LkYdkbH8aF3P5e+as0OYR2FWC89uWB7BhZHVa1kxovxm7B39goLT4IJWoaqz0v
ftuEY8FkDlwLToxWAdFvkyUBO9ze0qYc4sQhAHD+rizKxfxtKKotaj4Wb03wHb2B
qHCSFsJ9nnOaU5oLJE3WttLg+Lw7WNxKZQzGTYdwydtbu0EHhNb84bdi2nUvrc+0
3gaPIluygnQKMRGg8PHBxpJsX3QnR9XU2bQRx4yVatdjXshiGlOB0i1pHv1eWTjW
3PaKhbx01tHJGINPZWjfe9716hKbBLc53brDmgldPyv4EuNK9b1ic3lfV/z50nDD
Hh3+iMVrJhaakat92CtTeciG6NKfmsQGO4ejTAC8B4YEFtev9pAtKPeaJ6d4KRWo
sVDjtVGsFMdp8+sYb+FPxMsnUo/78NdGHP5KfJ/YSH+hENfxXpkivSM6a70UnTvX
kj4dlKrgHOv9kQiu0NCB9MaVDa8BaG/s9NwdkHDs2v8xpG1MwBbpX0ReUf+PqSRq
gP2VN2ZqsegU/nUKU/+xzTi2TZR6b4HCkOlldMuOnivcPUm2WfewLDu1jy/yRzd5
yck5EiLzYAm4al9bIXszzAxBBxzUWmuvw8To6VEKeYaxEhgk/44=
=V527
-----END PGP SIGNATURE-----

--n1iI6MeELQa9IOaF--
