Received: from eggs.gnu.org ([209.51.188.92]:40086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0hS5-0007aY-Qe
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0hIN-00045V-Ck
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:41:53 -0500
Date: Mon, 4 Mar 2019 16:56:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304055637.GO7792@umbus.fritz.box>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
	<20190228225759.21328-5-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nljfjKcp9HDtPSOP"
Content-Disposition: inline
In-Reply-To: <20190228225759.21328-5-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 4/5] target/ppc: Refactor
 kvm_handle_debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexey Kardashevskiy <aik@ozlabs.ru>


--nljfjKcp9HDtPSOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 07:57:58PM -0300, Fabiano Rosas wrote:
> There are four scenarios being handled in this function:
>=20
> - single stepping
> - hardware breakpoints
> - software breakpoints
> - fallback (no debug supported)
>=20
> A future patch will add code to handle specific single step and
> software breakpoints cases so let's split each scenario into its own
> function now to avoid hurting readability.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Again, a nice cleanup regardless of anything else.  Applied.

> ---
>  target/ppc/kvm.c | 86 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 36 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 941c4e7523..9392fba192 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1620,52 +1620,66 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>      return handle;
>  }
> =20
> +static int kvm_handle_singlestep(void)
> +{
> +    return 1;
> +}
> +
> +static int kvm_handle_sw_breakpoint(void)
> +{
> +    return 1;
> +}
> +
>  static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      struct kvm_debug_exit_arch *arch_info =3D &run->debug.arch;
> -    int handle =3D 0;
> =20
>      if (cs->singlestep_enabled) {
> -        handle =3D 1;
> -    } else if (arch_info->status) {
> -        handle =3D kvm_handle_hw_breakpoint(cs, arch_info);
> -    } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> -        handle =3D 1;
> -    } else {
> -        /* QEMU is not able to handle debug exception, so inject
> -         * program exception to guest;
> -         * Yes program exception NOT debug exception !!
> -         * When QEMU is using debug resources then debug exception must
> -         * be always set. To achieve this we set MSR_DE and also set
> -         * MSRP_DEP so guest cannot change MSR_DE.
> -         * When emulating debug resource for guest we want guest
> -         * to control MSR_DE (enable/disable debug interrupt on need).
> -         * Supporting both configurations are NOT possible.
> -         * So the result is that we cannot share debug resources
> -         * between QEMU and Guest on BOOKE architecture.
> -         * In the current design QEMU gets the priority over guest,
> -         * this means that if QEMU is using debug resources then guest
> -         * cannot use them;
> -         * For software breakpoint QEMU uses a privileged instruction;
> -         * So there cannot be any reason that we are here for guest
> -         * set debug exception, only possibility is guest executed a
> -         * privileged / illegal instruction and that's why we are
> -         * injecting a program interrupt.
> -         */
> +        return kvm_handle_singlestep();
> +    }
> +
> +    if (arch_info->status) {
> +        return kvm_handle_hw_breakpoint(cs, arch_info);
> +    }
> =20
> -        cpu_synchronize_state(cs);
> -        /* env->nip is PC, so increment this by 4 to use
> -         * ppc_cpu_do_interrupt(), which set srr0 =3D env->nip - 4.
> -         */
> -        env->nip +=3D 4;
> -        cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> -        env->error_code =3D POWERPC_EXCP_INVAL;
> -        ppc_cpu_do_interrupt(cs);
> +    if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> +        return kvm_handle_sw_breakpoint();
>      }
> =20
> -    return handle;
> +    /*
> +     * QEMU is not able to handle debug exception, so inject
> +     * program exception to guest;
> +     * Yes program exception NOT debug exception !!
> +     * When QEMU is using debug resources then debug exception must
> +     * be always set. To achieve this we set MSR_DE and also set
> +     * MSRP_DEP so guest cannot change MSR_DE.
> +     * When emulating debug resource for guest we want guest
> +     * to control MSR_DE (enable/disable debug interrupt on need).
> +     * Supporting both configurations are NOT possible.
> +     * So the result is that we cannot share debug resources
> +     * between QEMU and Guest on BOOKE architecture.
> +     * In the current design QEMU gets the priority over guest,
> +     * this means that if QEMU is using debug resources then guest
> +     * cannot use them;
> +     * For software breakpoint QEMU uses a privileged instruction;
> +     * So there cannot be any reason that we are here for guest
> +     * set debug exception, only possibility is guest executed a
> +     * privileged / illegal instruction and that's why we are
> +     * injecting a program interrupt.
> +     */
> +    cpu_synchronize_state(cs);
> +    /*
> +     * env->nip is PC, so increment this by 4 to use
> +     * ppc_cpu_do_interrupt(), which set srr0 =3D env->nip - 4.
> +     */
> +    env->nip +=3D 4;
> +    cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> +    env->error_code =3D POWERPC_EXCP_INVAL;
> +    ppc_cpu_do_interrupt(cs);
> +
> +    return 0;
>  }
> =20
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nljfjKcp9HDtPSOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8vhUACgkQbDjKyiDZ
s5L8ZA/+PSBxKZ8tZBskUmcdvTZznmhQBA00AWKqAURxRUBOJMQA2JUpYb3JWNZq
kHVeQX8g3tKNXQ/C3ZfljmNRnt9dhUl3aq2nMxK0EAnU5oOyo+C88myy+ltJmmfC
hq+0Pny6yjErfAMv9gIhlRPra44Eki/LlDfiK6WHhhO1ph05WIfdf0EtSetid3Ht
KoeLz2afFMjuWffMjmle0POSnj0NeCg9oC5lsXMMHVO/mdDUvaNfGp8wTxjtx4a9
Rg0QmccjJJHbCeIfwovUI5zArXoF3T16GcezVzxLCX1vY8XFH1/FZd3qUCq7huQc
2bIYy4SmEfdLQ0rJRXALcxDJDWf0IkcgrLRvAiSRfb8PHOLiMjXmG8HFi/ruCzFP
2drpEntqa0CBoMb+BvHw1YA+6TpS1kNSSbbKqixqyAduV5iWeWxaIjwCX6WduevS
S78j++WaInxPuurs8iCXmJyFiXuXPzE5f/qxL10mC/hAwGZop+kCkVlsCnkMolen
ChzE3obRfPH7hktqQJalMGC43vvHY9I++oS6kEwPeW/Nc+g0utD+9MyZoonMBYvR
PE5n5nAA0yYvbmTVicxc3SFdjXw7ZJMowLhfrappnhlxx1CY16y0sWcXnZJuR6Yw
/EYm9bIcE2S/OeInmSLQqQAksPQ1VnjFLWcNZo72tAEt8zLkXFg=
=5Mxh
-----END PGP SIGNATURE-----

--nljfjKcp9HDtPSOP--
