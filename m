Received: from eggs.gnu.org ([2001:4830:134:3::10]:36381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQP-00009k-O1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQO-0004Vi-LK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:13 -0400
Date: Tue, 14 Mar 2017 16:38:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314053856.GH12564@umbus.fritz.box>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-2-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline
In-Reply-To: <1488970371-8865-2-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/8] ppc/xics: add a
 xics_get_cpu_index_by_pir() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 11:52:44AM +0100, C=E9dric Le Goater wrote:
> This helper will be used to translate the server number of the XIVE
> (which is a PIR) into an ICPState index number (which is a cpu index).
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This seems a slightly roundabout way of doing things.  Why not just
have the vcpu_by_pir() interface, then have the XICSFabric implementor
go directly from PIR to xics server state.

> ---
>  hw/intc/xics.c        | 11 +++++++++++
>  hw/ppc/ppc.c          | 16 ++++++++++++++++
>  include/hw/ppc/xics.h |  1 +
>  target/ppc/cpu.h      | 10 ++++++++++
>  4 files changed, 38 insertions(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e740989a1162..209e1a75ecb9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -49,6 +49,17 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
>      return -1;
>  }
> =20
> +int xics_get_cpu_index_by_pir(int pir)
> +{
> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> +
> +    if (cpu) {
> +        return cpu->parent_obj.cpu_index;
> +    }
> +
> +    return -1;
> +}
> +
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 5f93083d4a16..94bbe382a73a 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1379,6 +1379,22 @@ PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id)
>      return NULL;
>  }
> =20
> +PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *env =3D &cpu->env;
> +
> +        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  void ppc_cpu_parse_features(const char *cpu_model)
>  {
>      CPUClass *cc;
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 9a5e715fe553..42bd24e975cb 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -173,6 +173,7 @@ void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu=
);
> =20
>  /* Internal XICS interfaces */
>  int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
> +int xics_get_cpu_index_by_pir(int pir);
> =20
>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
>  void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7c4a1f50b38b..24a5af95cb45 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2518,5 +2518,15 @@ int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
>   */
>  PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
> =20
> +/**
> + * ppc_get_vcpu_by_pir_id:
> + * @pir: Processor Identifier Register (SPR_PIR)
> + *
> + * Searches for a CPU by @pir.
> + *
> + * Returns: a PowerPCCPU struct
> + */
> +PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
> +
>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
>  #endif /* PPC_CPU_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx4HtAAoJEGw4ysog2bOSpcsP+wT2uQ0fYeplPEWY89mY2+8Q
CetWb664Q7IvsOvFxCEVMqxkTebQaDYgcFgT1sXsYUsIfbH86Tq7nyvDkEw66bfm
44sIxLL8EdaK9nvj2frk53U74VNO+feNlu6Zlj6BpNxEuVuoFXBybDR5bee4gDgQ
94raVl19eYiZDu9zgO4Z8uHGmkMOpBkQgQYNkCPZecLq6atHj8umb/cUkPSvYB55
+Woymj4nT/lXn85vd5u4k+wr8m1dUEv2u4ygkDg1t5/j6x78IKt2vniFNSOPkaDR
QhIgvE+6XdERBbxoMFTLk29A6BRaxQXmUv61J9gQk+2Bb/wSAkPsDcjw1Il0yCu2
GlDXhHqqgbb4Xnm036aFj9y7cgDWSZRUYStPQJmIcKvjf2BFzCxL0nOgXgtDJD4l
t0Q0tPUB6BeUQuRFPXmCSJBu2YkoBNp0104jVM5eqYKYSajy1eYhAM6et8AIT0sb
a1Wdv5gmhqcE1d2mTY1CDdKtKNaCqAQAebjzVV7flK7Osbf7A7WbQscI7BgYZIX6
3BJ61fDw0R3UMd32qjmcW3/OsF7Dqkr2p5dhba7kXM+BcM8ylM2GotX9oX8RiIgq
nStfEVuxPc2c7OLyhFfb6Dm0N6+O5x2E5+gPB6A9aGjsjcOh2hxoP4nmqyesP4I/
9wcubKa+foG6bSsGuvRD
=e5u8
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--
