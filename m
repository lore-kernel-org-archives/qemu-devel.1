Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRPYb-0005Le-Tz
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRPWw-0004yr-CU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:39:03 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:41119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gRPWu-0004yF-DA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:39:02 -0500
Date: Mon, 26 Nov 2018 18:41:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181126074100.GJ2251@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-4-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline
In-Reply-To: <20181121181347.24035-4-farosas@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 04:13:47PM -0200, Fabiano Rosas wrote:
> The hardware singlestep mechanism in POWER works via a Trace Interrupt
> (0xd00) that happens after any instruction executes, whenever MSR_SE =3D
> 1 (PowerISA Section 6.5.15 - Trace Interrupt).
>=20
> However, with kvm_hv, the Trace Interrupt happens inside the guest and
> KVM has no visibility of it. Therefore, when the gdbstub uses the
> KVM_SET_GUEST_DEBUG ioctl to enable singlestep, KVM simply ignores it.
>=20
> This patch takes advantage of the Trace Interrupt to perform the step
> inside the guest, but uses a breakpoint at the Trace Interrupt handler
> to return control to KVM. The exit is treated by KVM as a regular
> breakpoint and it returns to the host (and QEMU eventually).
>=20
> Before signalling GDB, QEMU sets the Next Instruction Pointer to the
> instruction following the one being stepped, effectively skipping the
> interrupt handler execution and hiding the trace interrupt breakpoint
> from GDB.
>=20
> This approach works with both of GDB's 'scheduler-locking' options
> (off, step).
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/kvm.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9d0b4f1f3f..93c20099e6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -94,6 +94,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_nested_kvm_hv;
> =20
>  static uint32_t debug_inst_opcode;
> +static target_ulong trace_handler_addr;
> =20
>  /* XXX We have a race condition where we actually have a level triggered
>   *     interrupt, but the infrastructure can't expose that yet, so the g=
uest
> @@ -509,6 +510,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      kvm_get_one_reg(cs, KVM_REG_PPC_DEBUG_INST, &debug_inst_opcode);
>      kvmppc_hw_debug_points_init(cenv);
> =20
> +    trace_handler_addr =3D (cenv->excp_vectors[POWERPC_EXCP_TRACE] |
> +                          AIL_C000_0000_0000_4000_OFFSET);

Effectively caching this as a global variable is pretty horrible.  A
function to make the above calculation when you need it would be
better.

Also, won't the calculation above be wrong if the guest is using the
low AIL value?

> +
>      return ret;
>  }
> =20
> @@ -1553,6 +1557,24 @@ void kvm_arch_remove_all_hw_breakpoints(void)
> =20
>  void kvm_arch_set_singlestep(CPUState *cs, int enabled)
>  {
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (kvmppc_is_pr(kvm_state)) {

Explicitly testing for KVM PR is generally wrong (except as a
fallback).  Instead you should add a capability flag to KVM which you
use to test the feature's presence in qemu.  That capability can then
be set in HV, but not PR.

> +            return;
> +    }
> +
> +    if (enabled) {
> +        /* MSR_SE =3D 1 will cause a Trace Interrupt in the guest after
> +         * the next instruction executes. */
> +        env->msr |=3D (1ULL << MSR_SE);
> +
> +        /* We set a breakpoint at the interrupt handler address so
> +         * that the singlestep will be seen by KVM (this is treated by
> +         * KVM like an ordinary breakpoint) and control is returned to
> +         * QEMU. */
> +        kvm_insert_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_=
SW);
> +    }
>  }
> =20
>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *d=
bg)
> @@ -1594,6 +1616,43 @@ void kvm_arch_update_guest_debug(CPUState *cs, str=
uct kvm_guest_debug *dbg)
>      }
>  }
> =20
> +static int kvm_handle_singlestep(CPUState *cs,
> +                                 struct kvm_debug_exit_arch *arch_info)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong msr =3D env->msr;
> +    uint32_t insn;
> +    int ret =3D 1;

You never set this to anything other than 1...

> +    int reg;
> +
> +    if (kvmppc_is_pr(kvm_state)) {
> +        return ret;
> +    }
> +
> +    if (arch_info->address =3D=3D trace_handler_addr) {
> +        cpu_synchronize_state(cs);
> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_=
SW);
> +
> +        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *)&insn,
> +                            sizeof(insn), 0);
> +
> +        /* If the last instruction was a mfmsr, make sure that the
> +         * MSR_SE bit is not set to avoid the guest kernel knowing
> +         * that it is being single-stepped */
> +        if (extract32(insn, 26, 6) =3D=3D 31 && extract32(insn, 1, 10) =
=3D=3D 83) {
> +            reg =3D extract32(insn, 21, 5);
> +            env->gpr[reg] &=3D ~(1ULL << MSR_SE);
> +        }

Hm.  What happens if both qemu and the guest itself attempt to single
step at the same time?  How do you distinguish between the cases?

> +
> +        env->nip =3D env->spr[SPR_SRR0];
> +        env->msr =3D msr &=3D ~(1ULL << MSR_SE);

You clear SE after tracing one instruction; is that intentional?

> +        cpu_synchronize_state(cs);

You're effectively aborting the entry to the single step exception
vector; don't you need to set MSR to SRR1, not to the current MSR
value which will have been modified for the singlestep exception entry?

You only need the first call to sync_state.  It sets a flag causing
the state to be written back before returning to the guest.

> +    }
> +
> +    return ret;
> +}
> +
>  static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>  {
>      CPUState *cs =3D CPU(cpu);
> @@ -1604,7 +1663,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct=
 kvm_run *run)
>      int flag =3D 0;
> =20
>      if (cs->singlestep_enabled) {
> -        handle =3D 1;
> +        handle =3D kvm_handle_singlestep(cs, arch_info);
>      } else if (arch_info->status) {
>          if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
>              if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv7o4oACgkQbDjKyiDZ
s5LXyg/+K8y1Tn41/FMf1oZFSKQHgKyRZ9tphV8v3NLw8xbX5k2SE7287O81UcCA
2srYSvTdVWTYcBTy48lJ/XbrhasLJa9yx0ZEHqGBmywQKLEONHbIlKA0khDcAYcJ
xdq4nEY7IVO6k3owJfj9/G9ar7NsddL8gwAqpwaFUHmHut6kpahG/rSzbMZrX2Ki
pSSos8/DEP7saIODaxEp617ZIR0ksyXacJV1RGULbPxhLPGXljxX42GjFFoXXy2O
i+a9E46Jz3dT4t/anE0G8WUsQsW8TElzayQV+nbewd+JA59BdkaNqo6EBKBLfG1e
33MRLChmd4UwW6c8vZpjwo9QUe3JNSKn6fm5UBY/SDjyT6qmeXN3jefyHmqsl0Dj
9//8Zjc1Gl+pBoHQQh8bdPTmoCGninqWq6EllM7jmRyxOyJblQ7IGuEbFe27SpHh
IBAtCs0Sdoo41a75+gv5tp1pOq3HG9YEIz4HG5rCqsra9CsuWIDLI2vksymITcIA
CqCB3BXqPuZDHyjOYZGBjpL1FHUXz9Cw07cT0PwMfecPofRLdjQg34PTlY29G1AD
4/PMopZgqBbv3hcg/sDHvB+2kiDfXQ1p/N3SZnyKrLvNpXHnFQSIJbvS+JpgMj39
hUQD8hB8DO4by5de5H8GqkL+KqMqy/ZWRs3I9JdcEMKO2r46xpU=
=Z4ou
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
