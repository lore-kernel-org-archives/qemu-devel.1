Received: from eggs.gnu.org ([209.51.188.92]:54780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hFt0V-0005KZ-Hx
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 00:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hFt0U-00023c-Bo
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 00:14:11 -0400
Date: Mon, 15 Apr 2019 14:13:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190415041359.GE32705@umbus.fritz.box>
References: <20190412093603.18232-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <20190412093603.18232-1-npiggin@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 07:36:03PM +1000, Nicholas Piggin wrote:
> These implementations have a few deficiencies that are noted, but are
> good enough for Linux to use.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>=20
> Cleaned up checkpatch warnings, sorry I didn't realise that exists.
>=20
>  hw/ppc/spapr_hcall.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8a736797b9..e985bb694d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1065,6 +1065,90 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (env->msr & (1ULL << MSR_EE)) {
> +        return H_BAD_MODE;
> +    }
> +
> +    /*
> +     * This should check for single-threaded mode. In practice, Linux
> +     * does not try to H_JOIN all CPUs.
> +     */
> +
> +    cs->halted =3D 1;
> +    cs->exception_index =3D EXCP_HALTED;
> +    cs->exit_request =3D 1;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs =3D CPU(cpu);
> +
> +    /*
> +     * This does not do a targeted yield or confer, but check the parame=
ter
> +     * anyway. -1 means confer to all/any other CPUs.
> +     */
> +    if (target !=3D -1 && !CPU(spapr_find_cpu(target))) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_CONFER with target =3D=3D this is not exactly the same as H_JOIN
> +     * according to PAPR (e.g., MSR[EE] check and single threaded check
> +     * is not done in this case), but unlikely to matter.
> +     */
> +    if (cpu =3D=3D spapr_find_cpu(target)) {
> +        return h_join(cpu, spapr, opcode, args);
> +    }
> +
> +    /*
> +     * This does not implement the dispatch sequence check that PAPR cal=
ls for,
> +     * but PAPR also specifies a stronger implementation where the targe=
t must
> +     * be run (or EE, or H_PROD) before H_CONFER returns. Without such a=
 hard
> +     * scheduling requirement implemented, there is no correctness reaso=
n to
> +     * implement the dispatch sequence check.
> +     */
> +    cs->exception_index =3D EXCP_YIELD;
> +    cpu_loop_exit(cs);
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * H_PROD and H_CONFER are specified to only modify GPR r3, which is not
> + * achievable running under KVM,

Uh.. why not?

> although KVM already implements H_CONFER
> + * this way.

And this seems to contradict the above.

> + */
> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs;
> +
> +    /*
> +     * Should set the prod flag in the VPA.

So.. why doesn't it?

> +     */
> +
> +    cs =3D CPU(spapr_find_cpu(target));
> +    if (!cs) {
> +        return H_PARAMETER;
> +    }
> +
> +    cs->halted =3D 0;
> +    qemu_cpu_kick(cs);
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1860,6 +1944,10 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_CONFER, h_confer);
> +    spapr_register_hypercall(H_JOIN, h_join);

I don't see any sign that H_JOIN is implemented in KVM, although
H_CONFER and H_PROD certainly are.

> +    spapr_register_hypercall(H_PROD, h_prod);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> =20
>      /* processor register resource access h-calls */

Don't we also need to add something to hypertas-calls to advertise the
availability of these calls to the guest?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly0BQMACgkQbDjKyiDZ
s5LSYA/6A2RJn+ThokJI4xLTuTWeVay1YdMnw7wru+gCxxLKG/lqgMNv/AJejEn+
9a1+wE9TWsCCIJFAULO66+YF1nIZMzVDWK2KbnZI+8m2U9a9ug9c829BXlhVZmf7
kutapUNIZm5pcnffUBfhtSui0hQIa328npM4isqLYPDmUfYz/V2YrXLzOIybeXbT
mPddod57axJXElt1UJcocPWApKfY0o5w1GmW5R7De93zkEhPwBJ6CyfeaKpZqJiq
7b3OmwdESdHbztZxefwPszKxC7HejmJ4kUkKHNzprFSn7MzKpwRHgyAnjRxlBX7t
/BM2C8lWfvz54uZr3jW3BgF2oP/VUKM//86mqwZvFenjoPvhL2WcuH15ZskA5DDT
HDVosxvgDDec3RVHnWWW5Jgpur3mjzZ8HFwBfOiVy37vEzRFWCCfzadzOhM6e/j9
ldjpFQpxKcVpjwQ4I299xJ9bjSr2kRJQ3YD3DRpJw0ZQWf4catG5H8oGz7EWxqbl
AVwveWbbskeH7+BU4607He7f5VsSNQYU9wTyoYtqv7rKmablDeYrj4etTkR5c3j3
bCRmrKGk5A+p4p6FAPT4Rq62ZK8MKhe3zyXFNPMEH9qR7Uga6hgvTCQYGgdGB92b
s9AGntg8aPW1UdBJrR/123OOrGKZFDU7UKr+P7B7/TrVJIYRNBk=
=3W+S
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
