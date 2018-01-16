Received: from eggs.gnu.org ([2001:4830:134:3::10]:55874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJbz-0007gO-RK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJbw-0008DI-Lu
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:16:39 -0500
Date: Tue, 16 Jan 2018 15:58:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116045849.GG30352@umbus.fritz.box>
References: <20180115093220.9154-1-luc.michel@git.antfield.fr>
	<20180115093220.9154-2-luc.michel@git.antfield.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <20180115093220.9154-2-luc.michel@git.antfield.fr>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target-ppc: Fix booke206 tlbwe TLB
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc MICHEL <luc.michel@git.antfield.fr>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 10:32:20AM +0100, Luc MICHEL wrote:
> When overwritting a valid TLB entry with a new one, the previous page
> were not flushed in QEMU TLB, leading to incoherent mapping. This commit
> fixes this.
>=20
> Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>

Applied to ppc-for-2.12.

> ---
>  target/ppc/mmu_helper.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 2a1f9902c9..298c15e961 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -2570,6 +2570,17 @@ void helper_booke_setpid(CPUPPCState *env, uint32_=
t pidn, target_ulong pid)
>      tlb_flush(CPU(cpu));
>  }
> =20
> +static inline void flush_page(CPUPPCState *env, ppcmas_tlb_t *tlb)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +
> +    if (booke206_tlb_to_page_size(env, tlb) =3D=3D TARGET_PAGE_SIZE) {
> +        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
> +    } else {
> +        tlb_flush(CPU(cpu));
> +    }
> +}
> +
>  void helper_booke206_tlbwe(CPUPPCState *env)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> @@ -2628,6 +2639,21 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>      if (msr_gs) {
>          cpu_abort(CPU(cpu), "missing HV implementation\n");
>      }
> +
> +    if (tlb->mas1 & MAS1_VALID) {
> +        /* Invalidate the page in QEMU TLB if it was a valid entry.
> +         *
> +         * In "PowerPC e500 Core Family Reference Manual, Rev. 1",
> +         * Section "12.4.2 TLB Write Entry (tlbwe) Instruction":
> +         * (https://www.nxp.com/docs/en/reference-manual/E500CORERM.pdf)
> +         *
> +         * "Note that when an L2 TLB entry is written, it may be displac=
ing an
> +         * already valid entry in the same L2 TLB location (a victim). I=
f a
> +         * valid L1 TLB entry corresponds to the L2 MMU victim entry, th=
at L1
> +         * TLB entry is automatically invalidated." */
> +        flush_page(env, tlb);
> +    }
> +
>      tlb->mas7_3 =3D ((uint64_t)env->spr[SPR_BOOKE_MAS7] << 32) |
>          env->spr[SPR_BOOKE_MAS3];
>      tlb->mas1 =3D env->spr[SPR_BOOKE_MAS1];
> @@ -2663,11 +2689,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>          tlb->mas1 &=3D ~MAS1_IPROT;
>      }
> =20
> -    if (booke206_tlb_to_page_size(env, tlb) =3D=3D TARGET_PAGE_SIZE) {
> -        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
> -    } else {
> -        tlb_flush(CPU(cpu));
> -    }
> +    flush_page(env, tlb);
>  }
> =20
>  static inline void booke206_tlb_to_mas(CPUPPCState *env, ppcmas_tlb_t *t=
lb)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdhokACgkQbDjKyiDZ
s5KVpQ//SWVlqJmVi1GS4oau6JdjP6myE1FYJpc31amcZPLWly/WXdDZ7LQaBAFB
VnLwlUpd9i3q6ZRVNRbcIBglxIMlj4IyMuzJeBGvMSC+knDLDL8ERW9XNIdRxd23
UWGYpmdm1uR8jW9ehs4OhFxfqod+h+mF+FXkJj1D61pueFdnWmCr45FdIGy1KMc1
ooSQyG0y8BTfTmxaTQPpLn2Kom/YQnQRwBgQAseVtGR6+dicFN74EgBkqwkzC/Yv
1y6yLPxql9JDhwTmPf+qk8shjPQJ5A25MzY0EZLzTJkrWDXdpTF53bRl+G/FHM4N
0UKUqaH195wKuAH7lAIJn7gXEL1kgT4xDpDuizNLlwX35DHkoYvakKKk20SdYkV+
XZa2l+DJjztGhylitZoR3DLNH5eoR8TbMO4zr3Zb7x3TIG3+cUAxsC3JGTLXGliJ
oZolRQ2IabbA5WbIXN93Nzwp4AElWZK38FXzijbiVGIMhRhd5lPd8GeBsTQxvcws
/8LJxebVYuMfAGOkQNXeNfZd5T6QPTe+p8tNXRg9Xm6TxTxOefIwmrYVtJ31tO6f
WrgFchsBPJdkh97Zcu3bdGk4xrzEYLCL/rpAXLkAosbL/uqdomzyIn1FQyL5A5/1
CJf9yjJ9yloWHYIHriMTlQOcwaekbs15H7rdWAnBaVYkEvWpaZY=
=C5T5
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
