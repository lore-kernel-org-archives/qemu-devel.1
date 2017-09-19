Received: from eggs.gnu.org ([2001:4830:134:3::10]:51444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtd-0001M1-8h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtZ-00031w-5b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:53 -0400
Date: Tue, 19 Sep 2017 18:36:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919083630.GV27153@umbus>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170913071249.GI7550@umbus.fritz.box>
	<03027eb0-6528-22c6-dcc1-d20323399ec9@ilande.co.uk>
	<ccacf611-c2e2-9cad-d927-67c0fcaa3ad6@redhat.com>
	<20170914035259.GK3972@umbus.fritz.box>
	<56298dd2-eabe-5075-61b3-c27a0eaf4579@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3jK+0sHr6j/jwA0V"
Content-Disposition: inline
In-Reply-To: <56298dd2-eabe-5075-61b3-c27a0eaf4579@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: ensure we update the decrementer
 value during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <lvivier@redhat.com>, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--3jK+0sHr6j/jwA0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 01:45:11PM +0100, Mark Cave-Ayland wrote:
> On 14/09/17 04:52, David Gibson wrote:
>=20
> > On Wed, Sep 13, 2017 at 07:58:23PM +0200, Laurent Vivier wrote:
> >> On 13/09/2017 19:11, Mark Cave-Ayland wrote:
> >>> On 13/09/17 08:12, David Gibson wrote:
> >>>
> >>>> This is subtly incorrect.  It sets the DECR on load to exactly the
> >>>> value that was saved.  That effectively means that the DECR is frozen
> >>>> for the migration downtime, which probably isn't what we want.
> >>>>
> >>>> Instead we need to save the DECR as an offset from the timebase, and
> >>>> restore it relative to the (downtime adjusted) timebase on the
> >>>> destination.
> >>>>
> >>>> The complication with that is that the timebase is generally migrated
> >>>> at the machine level, not the cpu level: the timebase is generally
> >>>> synchronized between cpus in the machine, and migrating it at the
> >>>> individual cpu could break that.  Which means we probably need a
> >>>> machine level hook to handle the decrementer too, even though it
> >>>> logically *is* per-cpu, because otherwise we'll be trying to restore
> >>>> it before the timebase is restored.
> >>>
> >>> I know that we discussed this in-depth last year, however I was worki=
ng
> >>> along the lines that Laurent's patch fixed this along the lines of our
> >>> previous discussion:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00338.html (=
and
> >>> indeed Laurent's analysis at
> >>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01489.html).
> >>>
> >>> However looking again at the this patch in the context you mentioned
> >>> above, I'm starting to wonder if the right solution now is for the
> >>> machine init function for g3beige/mac99 to do the same as spapr, e.g.
> >>> add cpu_ppc_clock_vm_state_change() as a vm_change_state_handler and
> >>> then add VMSTATE_PPC_TIMEBASE_V from the machine PPCTimeBase into my =
new
> >>> subsection?
> >>>
> >>> Laurent, do you think that your state change handler would work
> >>> correctly in this way?
> >>
> >> I think all is explained in the second link you have mentioned, it see=
ms=20
> >> we don't need a state handler as KVM DECR will no be updated by the mi=
grated value:
> >>
> >> hw/ppc/ppc.c
> >>
> >>     736 static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *ne=
xtp,
> >>     737                                  QEMUTimer *timer,
> >>     738                                  void (*raise_excp)(void *),
> >>     739                                  void (*lower_excp)(PowerPCCPU=
 *),
> >>     740                                  uint32_t decr, uint32_t value)
> >>     741 {
> >> ...
> >>     749     if (kvm_enabled()) {
> >>     750         /* KVM handles decrementer exceptions, we don't need o=
ur own timer */
> >>     751         return;
> >>     752     }
> >> ...
> >>
> >> But this allows to migrate it for TCG. And it should be correct becaus=
e in case of TCG I think [need to check] timebase is stopped too (so offset=
 is 0)
> >>
> >> David, do you agree with that?
> >=20
> > Yes, I think so.  Some details might be different, but the basic idea
> > of migrating the timebase and decrementers at machine level should be
> > the same for pseries and g3beige/whatever.
>=20
> >From my perspective, I'd really like to bury all of the timebase
> migration logic into timebase_load()/timebase_save() so then as you
> suggest above, everything will work regardless of the machine type and ho=
st.

That would certainly be ideal if we can manage it.

> Playing around with these functions I can see that they are very
> PPC-specific - for example cpu_get_host_ticks() can only ever work
> correctly migrating between 2 PPC hosts because here on Intel the value
> returned is the TSC register which is completely unrelated to the
> timebase frequency. Hence the calculated values are nonsense and the
> guest inevitably ends up freezing.

Ugh.  That sounds like it needs fixing.

>=20
> I've had a go at converting this back to using the host clock to
> calculate the required adjustment to tb_offset (see
> https://github.com/mcayland/qemu/commit/68e31f0455a79d41b2ab703364c74ceb4=
d513154)
> but then even that struck me as incorrect since unless there are other
> host CPUs with an equivalent of tb_offset, this whole section of code
> should only ever run if the host CPU is PPC, and maybe even only under KV=
M.

Hm, maybe.  It certainly should be possible to do something
equivalent, recalculating guest TB as necessary from guest generic
clock, frequency and offsets in real time units.  It might end up
being desirable to have a special KVM path which works with raw TB
offsets for simplicity, though.

> My current thoughts are now as follows:
>=20
> - The existing timebase_load() should never adjust tb_offset unless the
> host CPU is also PPC (how do we actually determine this?). Otherwise it
> should always be 0.

That doesn't sound right.  But to work out what does makes sense, we
need to figure out what "tb_offset" means in the non-KVM case, which
isn't immediately obvious to me.

> - The per-CPU decrementer values should be *stored* in the normal
> vmstate SPR array as per my latest patch at
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02346.html.

Uh.. maybe.  It kind of makes sense, but the lack of symmetry with the
load path is a bit messy, and may not play well with the way vmstate
descriptions work.

> BUT:
>=20
> - The per-CPU decrementer values should be *restored* in timebase_load()
> but again should not be adjusted by tb_offset unless the host CPU is
> also PPC.

That doesn't seem right.  Regardless of whether we're KVM or TCG, we
should recalculate the DECR values based on the stored value adjusted
by how many guest timebase ticks have passed since then (which we'll
need to calculate based on qemu_clock_ns() combined with various other
bits of info (basically the same stuff we already need to compute the
correct timebase on load).

Or to put it another way timebase_load() should calculate (and/or
load) both the guest TB at save time and the guest TB at load time,
then adjust all the DECRs based on the delta between them.

For extra fun, to cover some of the embedded cpus, we'll need to
consider how to handle the PIT, which is sort-of-but-not-quite like
the DECR.

> The real question is whether tb_offset is used for a TCG PPC guest on a
> PPC host or whether it also remains at 0 as it does here on an Intel
> host? If it does remain at 0 for a TCG PPC guest on a PPC host then we
> don't need to work out whether we are running on a PPC host at all: we
> can just skip the timebase adjustments made by timebase_load() if
> !kvm_enabled() and everything should just work.

It kind of sounds like we need to rework that value entirely - or at
least rename it to something less misleading.  Basically to represent
the guest TB we want a tuple of a snapshot TB value with the qemu
clock time at which that snapshot was taken.  Based on that, plus the
tb frequency we can calculate a future TB value - and it's a
migratable quantity, which raw tb_offset is not (even between ppc
hosts).

Obviously there are several equivalent ways of representing that.

> If this all seems reasonable then what I need to do for the PPC
> g3beige/mac99 machines is add the relevant machine state, include the
> existing vmstate_change_handler and then add the code to timebase_load()
> to set the decrementer. I'm happy to do this as long as everyone agrees
> this is a sensible approach?
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3jK+0sHr6j/jwA0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnA1wsACgkQbDjKyiDZ
s5IbUg/8CO1SAYe8cysXc5PvlEe5XojEgd9lSY2Y3LeTgRsRa+pdKSfLIH1PFNTP
IoJGusH51yYRq9UPHjJyMjLPBhT0A1WnlGhO1EQ3z2qmYoTfi8Qy/bvSA9FNnUcD
Nisxd/9tEZ3HFikLfjaIYXyquSBEjs9TyhqTGZM7QtzlDc62aC9vHnyL9gR0i5HM
iwmOhrdBXa8khoAWUMKRvMsTmujFRsc6OH/lTrg837cLscBl+zq7Rc5aILz3ruE1
Oyu/+ZuIGIH0/VcnZuxr2iF6PmCw4g9JOJCkur5LAdu8AlMCaV4hiZiO6tVmQYm6
Mmv6YxiJo10gXj2VuIL88DfrlKRnGSSIC8apQ1PfKUbkyqcCYljiQVeoCguNGHVj
yBKv6OZI5JS2Orsol4rpvVaHaxfqAUZ8aHgZY3QdAnS+YWB0ael48MM2IzQNMx1U
k7+Nq2608f9y2MO66z3SSFku64Kaoo/TiznpQOY8ikY0Sx+bi7yTqI9bwOORnY/2
q5RAQWC4RYfgYRXnDM2JEnR2u5RbhftiGHe8+CmbyCg28xZCMpk3uBf49Nq5gEJH
StPd7ON//gbEcVYh0ZZLEYJYOhf5Q0pFwsmi4Pgk9Y1/3Uof/Jws8+gxLtsrmwOr
6lGTgaXk8LecnjK2TReBh1vXRljTkIS01oPC7cUdRNhKhg2PCak=
=KGf1
-----END PGP SIGNATURE-----

--3jK+0sHr6j/jwA0V--
