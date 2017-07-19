Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgfX-0003uu-SI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgfW-0008Rg-DS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:33:03 -0400
Date: Wed, 19 Jul 2017 14:32:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719043250.GW3140@umbus.fritz.box>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
	<20170718044619.GC3140@umbus.fritz.box>
	<877ez6e2tm.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170718065055.GG3140@umbus.fritz.box>
	<87o9shm6eb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+1d8mk/W7pQzMfc7"
Content-Disposition: inline
In-Reply-To: <87o9shm6eb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--+1d8mk/W7pQzMfc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 09:20:52AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Tue, Jul 18, 2017 at 10:53:01AM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Mon, Jul 17, 2017 at 09:46:39AM +0530, Nikunj A Dadhania wrote:
> >> >> Rebooting a SMP TCG guest is broken for both single/multi threaded =
TCG.
> >> >>=20
> >> >> When reset happens, all the CPUs are in halted state. First CPU is =
brought out
> >> >> of reset and secondary CPUs would be initialized by the guest kerne=
l using a
> >> >> rtas call start-cpu.
> >> >>=20
> >> >> However, in case of TCG, decrementer interrupts keep on coming and =
waking the
> >> >> secondary CPUs up.
> >> >>=20
> >> >> These secondary CPUs would see the decrementer interrupt pending, w=
hich makes
> >> >> cpu::has_work() to bring them out of wait loop and start executing
> >> >> tcg_exec_cpu().
> >> >>=20
> >> >> The problem with this is all the CPUs wake up and start booting SLO=
F image,
> >> >> causing the following exception(4 CPUs TCG VM):
> >> >
> >> > Ok, I'm still trying to understand why the behaviour on reboot is
> >> > different from the first boot.
> >>=20
> >> During first boot, the cpu is in the stopped state, so
> >> cpus.c:cpu_thread_is_idle returns true and CPU remains in halted state
> >> until rtas start-cpu. Therefore, we never check the cpu_has_work()
> >>=20
> >> In case of reboot, all CPUs are resumed after reboot. So we check the
> >> next condition cpu_has_work() in cpu_thread_is_idle(), where we see a
> >> DECR interrupt and remove the CPU from halted state as the CPU has
> >> work.
> >
> > Ok, so it sounds like we should set stopped on all the secondary CPUs
> > on reset as well.  What's causing them to be resumed after the reset
> > at the moment?
>=20
> That is part of the main loop in vl.c, when reset is requested. All the
> vcpus are paused (stopped =3D=3D true) then system reset is issued, and a=
ll
> cpus are resumed (stopped =3D=3D false). Which is correct.

is it?  Seems we have a different value of 'stopped' on the first boot
compared to reoboots, which doesn't seem right.

> static bool main_loop_should_exit(void)
> {
> [...]
>     request =3D qemu_reset_requested();
>     if (request) {
>         pause_all_vcpus();
>         qemu_system_reset(request);
>         resume_all_vcpus();
>         if (!runstate_check(RUN_STATE_RUNNING) &&
>                 !runstate_check(RUN_STATE_INMIGRATE)) {
>             runstate_set(RUN_STATE_PRELAUNCH);
>         }
>     }
> [...]
> }
>=20
> The CPUs are in halted state, i.e. cpu::halted =3D 1. We have set
> cpu::halted =3D 0 for the primary CPU, aka first_cpu, in
> spapr.c::ppc_spapr_reset()
>=20
> In case of TCG, we have a decr callback (per CPU) scheduled once the
> machine is started which keeps on running and interrupting irrespective
> of the state of the machine.

Right.  The thing is "halted" means waiting-for-interrupt; it's mostly
used for things like x86 hlt instruction, H_CEDE, short-term nap modes
and so forth.  We're abusing it a little for keeping the secondary
CPUs offline until they're explicitly started.

Trouble is, there isn't a clearly better option - stopped is
automatically turned off after reset as above, so it can't be used for
"stopped under firmware / hypervisor authority".

> tb_env->decr_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_ppc_decr_cb,=
 cpu);
>=20
> Which keeps on queueing the interrupt to the CPUs. All the other CPUs
> are in a tight loop checking cpu_thread_is_idle(), which returns false
> when it sees the decrementer interrupt, the cpu starts executing:
>=20
> cpu_exec()
>   -> cpu_handle_halt()
>      -> sees cpu_has_work() and sets cpu->halted =3D 0
>=20
> And the execution resumes, when it shouldnt have. Ideally, for secondary
> CPUs, cpu::halted flag is cleared in rtas start-cpu call.
>=20
> Initially, I thought we should not have interrupt during reset state.
> That was the reason of ignoring decr interrupt when msr_ee was disabled
> in my previous patch. BenH suggested that it is wrong from HW
> perspective.
>=20
> Regards,
> Nikunj
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+1d8mk/W7pQzMfc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllu4PEACgkQbDjKyiDZ
s5LFrQ/+JhklBPHrB9aygZ0+D+7IItcgaVEYeeuKBEJSF1Q13Vr7qp3HitOx7Z/9
LOxHyNNJPzp8HQRY5I/S8CtS2r952BEUcvu86zZ4z0B2ybfzNDkLHPDLFE2+EoGw
xUU7k8++Jod/+xty31JsPG69WgUXStPn6pmik+kXSuxTwZJF2FtAguC9fOLPPTdo
8eQeJDUcd58ldliSSvKCq55ljmdBItxtMhEz19Cj0yYpcn+H5LDCWbbKaA2/r4dA
bbEKD3XE6LcAUgSFLvzDOu1ksj9KXm919kZDq8ARmDoRECm3Sq/y6ThX8aUYibPT
/Wv0Nw+GJFBQ3p/qtZuho3wg+Can8G92o1EImwKCuTeOZO5TilejxyQPppr3Y6/o
2xcRlsqWskl2UFMYdMgPSEJZUoraI6nDcYdQuEpPnpeG+wwslGTDp1jZXnS/oUCF
OtgNRFhJzNn8FUO/xwwhFK2jFmR9IxeRBWBiTuNHhMvq/SChqo7hWJvrrGTH41RG
WZkQFdOXDE9aEov2FR0Xf7bTQv+DlSRG0eEvYxtuZ0/5VV09cT9GWSVruBAIZJlx
E1ZuCptpWclF2A6y8wsUF9GKOt+smgeQCRWzKOYktMwi1bMcpMCWAjjUcXiPsT7Z
Lo9M1+1ryAukQDoqgHouwElNyUYi9Ex/ngriJl2/6ldLzX+vEKU=
=pET7
-----END PGP SIGNATURE-----

--+1d8mk/W7pQzMfc7--
