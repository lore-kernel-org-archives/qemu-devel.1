Received: from eggs.gnu.org ([2001:4830:134:3::10]:58324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTNv6-0004rq-B9
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTNv3-0004qM-EE
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:08 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gTNv1-0004mM-TZ
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:05 -0500
Date: Sun, 2 Dec 2018 20:13:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181202091317.GM30479@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-4-farosas@linux.ibm.com>
	<20181126074100.GJ2251@umbus.fritz.box>
	<87h8fymgyq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline
In-Reply-To: <87h8fymgyq.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/3] target/ppc: support single
 stepping with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, James Hogan <jhogan@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 06:46:21PM -0200, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -94,6 +94,7 @@ static int cap_ppc_safe_indirect_branch;
> >>  static int cap_ppc_nested_kvm_hv;
> >> =20
> >>  static uint32_t debug_inst_opcode;
> >> +static target_ulong trace_handler_addr;
> >> =20
> >>  /* XXX We have a race condition where we actually have a level trigge=
red
> >>   *     interrupt, but the infrastructure can't expose that yet, so th=
e guest
> >> @@ -509,6 +510,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >>      kvm_get_one_reg(cs, KVM_REG_PPC_DEBUG_INST, &debug_inst_opcode);
> >>      kvmppc_hw_debug_points_init(cenv);
> >> =20
> >> +    trace_handler_addr =3D (cenv->excp_vectors[POWERPC_EXCP_TRACE] |
> >> +                          AIL_C000_0000_0000_4000_OFFSET);
> >
> > Effectively caching this as a global variable is pretty horrible.  A
> > function to make the above calculation when you need it would be
> > better.
> >
> > Also, won't the calculation above be wrong if the guest is using the
> > low AIL value?
>=20
> Yes. As you suggested, I'll change this to calculate the offset based on =
AIL.
>=20
> >>  void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> >>  {
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +
> >> +    if (kvmppc_is_pr(kvm_state)) {
> >
> > Explicitly testing for KVM PR is generally wrong (except as a
> > fallback).  Instead you should add a capability flag to KVM which you
> > use to test the feature's presence in qemu.  That capability can then
> > be set in HV, but not PR.
>=20
> My apologies, I did read the notice on the code about it. I was trying
> to keep things simple for this RFC and forgot to mention that in the
> cover letter.

Just put a comment on it explaining that you expect to replace this
before the final version.

> >> +    if (arch_info->address =3D=3D trace_handler_addr) {
> >> +        cpu_synchronize_state(cs);
> >> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOI=
NT_SW);
> >> +
> >> +        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *)&i=
nsn,
> >> +                            sizeof(insn), 0);
> >> +
> >> +        /* If the last instruction was a mfmsr, make sure that the
> >> +         * MSR_SE bit is not set to avoid the guest kernel knowing
> >> +         * that it is being single-stepped */
> >> +        if (extract32(insn, 26, 6) =3D=3D 31 && extract32(insn, 1, 10=
) =3D=3D 83) {
> >> +            reg =3D extract32(insn, 21, 5);
> >> +            env->gpr[reg] &=3D ~(1ULL << MSR_SE);
> >> +        }
> >
> > Hm.  What happens if both qemu and the guest itself attempt to single
> > step at the same time?  How do you distinguish between the cases?
>=20
> There is currently no distinction being made.

This seems incorrect to me.  Basically you're restoring !MSR_SE
unconditionaly when you finish the hypervisor side step, which might
not be correct if the guest is also attempting to single step itself.
AFAICT it should be possible to track what the guest thinks is the
value of MSR_SE and restore that.  If both hypervisor and guest
attempt to single step, I'd expect to have the hypervisor trap first,
then return to the guest's single step vector.

> Since MSR_SE is only set
> for the duration of the step (see my answer below) this mostly just
> works and it is possible to single step inside/outside the guest while
> the control changes from one debugger to the other as expected. However
> there is a race as follows:
>=20
> If the vcpu being stepped is preempted right after vm enter, with the
> breakpoint at 0xd00 already in place *and* the other debugger starts
> doing a step, it will cause a vm exit when it shouldn't:
>=20
>     outside guest                  inside guest
> set breakpoint at 0xd00     |
> msr_se =3D 1                  |
> vm enter                    |
>                             |  msr_se =3D 1
>                             |  exec next instruction
>                             |  trace interrupt
>                             |  jump to 0xd00
>                             |  --- wrong from now on ---
>                             |  emulation assist interrupt
>                             |  vm exit
>=20
> One way to avoid this race is by using GDB's `scheduler-locking step`
> option which effectively negates the issue by running only the vcpu
> being stepped.
>=20
> Regardless of that workaround, I am exploring the idea of sending the
> cpu back into the guest if we happen to break at the trace interrupt
> handler while there is no cpu being stepped by QEMU
> (cs->singlestep_enabled). That way, a step inside the guest would never
> happen before the outside step has finished.
>=20
> >
> >> +
> >> +        env->nip =3D env->spr[SPR_SRR0];
> >> +        env->msr =3D msr &=3D ~(1ULL << MSR_SE);
> >
> > You clear SE after tracing one instruction; is that intentional?
>=20
> Yes, both the kernel and KVM PR do the same:
>=20
> from arch/powerpc/kernel/traps.c
> void single_step_exception(struct pt_regs *regs)
> {
>         enum ctx_state prev_state =3D exception_enter();
>=20
> ->      clear_single_step(regs);
>         ...
> }
>=20
> from arch/powerpc/kvm/book3s_pr.c
> static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *v=
cpu)
> {
>         ...
>         ret =3D __kvmppc_vcpu_run(kvm_run, vcpu);
>=20
> ->      kvmppc_clear_debug(vcpu);
>         ...
> }
>=20
> >
> >> +        cpu_synchronize_state(cs);
> >
> > You're effectively aborting the entry to the single step exception
> > vector; don't you need to set MSR to SRR1, not to the current MSR
> > value which will have been modified for the singlestep exception entry?
>=20
> I'm using the old MSR value (before synchronizing) so the effect is the s=
ame:
>=20
> (gdb) p/x $msr
> $2 =3D 0x8000000002803033
> (gdb) si
> 1892            LOAD_REG_ADDR(r11, replay_interrupt_return)
> (gdb) p/x $msr
> $3 =3D 0x8000000002803033
>=20
> Using SRR1 would also work but it would require clearing the bits set by
> the interrupt (33:36, 44:47):
>=20
> (gdb) p/x env->spr[0x01b]
> $1 =3D 0x8000000042803433
>=20
> I could do the latter, if you prefer.

I think that's better - I don't think it's safe to assume that you're
*not* synchronized with KVM.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwDoioACgkQbDjKyiDZ
s5Ke/Q/8CXa5CoRPVZD0YhDFZPPS2fzfnVmVzD/1NpQLkzSEFv4ymH2+MZ1lw1fy
vXEADVNVk4ihO2/M5lDBBIKvxtVO+WnIepJZGpG9GcrbTk8cxii0pBMN+fUgHUP2
231RYUjxC6L0yIafmLm+RDzRyyczE6rUzs66ZWj5JSefH3XW5EpO78V48Wn38m1y
bkkeP6gr1uvx1EG8Q5n26l73J+w3AakNCYqFD7x/V4209h7TNw2ZwIWoN+JfpaSB
QmsL9YHLK7p6KKy0/FTw6CD1AOzXBiy9YZVgeXqa+v59kNpKVvT+m/IaJJTMy/rV
8QzjApJ8cbj5e6ZqBsWCy1/aygE1OYkDoC20YBAH76Nc4/kcyyFiRyQiNdpYq53J
GN2RP30wslxXftsXtdFah0eWez9quUYVBjcnnFjH0iWyGTESD5e9s7q1qjpoBEkp
t/VhzPIFcpFGi8mEPvNY3K8/tvn0HymRmLRSOGfjIqhydEOvqsXnh1tWnQfMej8H
te4h32W+5a0/roaR69fMWIjslm/wceVE9fVAk3fLT+m8KeT+o/o1S8JYRRWw971G
ULwfVqPdahq/lUqwu4EZTjW9Ny6cX2kZ2V/kWLp8WCeUJw46EXrNZ4obIUGrUmva
g4yv7QfUrZC4c1V6LH83cd5Sda5vPl9ONUNcS/Adoqr1/gU7xvE=
=1lNI
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
