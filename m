Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eBaiO-0007Sq-IZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eBaiN-0001Sn-3q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:16:56 -0500
Date: Mon, 6 Nov 2017 17:16:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171106061639.GA7813@umbus.fritz.box>
References: <20171102103559.7382-1-luc.michel@git.antfield.fr>
	<20171102103559.7382-2-luc.michel@git.antfield.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20171102103559.7382-2-luc.michel@git.antfield.fr>
Subject: Re: [Qemu-devel] [PATCH 1/1] target-ppc: Fix booke206 tlbwe TLB
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


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 11:35:59AM +0100, Luc MICHEL wrote:
> When overwritting a valid TLB entry with a new one, the previous page
> were not flushed in QEMU TLB, leading to incoherent mapping. This commit
> fixes this.

I don't think this is right.  As a rule, overwriting a TLB entry
doesn't necessarily invalidate the previous entry, even on real
hardware.  I don't know exactly what the situation is on the various
FSL BookE chips, but I know various other models have other caches
ahead of the main TLB which can cache mappings that have been removed
=66rom it (e.g. the ERAT on server chips and the shadow TLBs on 4xx).

To invalidate those other caches requires something other than simply
a tlbwe (tlbie for the ERAT and an isync for the shadow TLBs).

The current behaviour won't exactly match what hardware does (and it's
probably not practical to do so), but it should be within what's
permitted by the architecture - and therefore good enough for correct
guests.

It's possible that we do need this for the BookE chips, but it'll need
a more detailed rationale.

>=20
> Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
> ---
>  target/ppc/mmu_helper.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 2a1f9902c9..c2c89239b4 100644
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
> @@ -2628,6 +2639,12 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>      if (msr_gs) {
>          cpu_abort(CPU(cpu), "missing HV implementation\n");
>      }
> +
> +    if (tlb->mas1 & MAS1_VALID) {
> +        /* Invalidate the page in QEMU TLB if it was a valid entry */
> +        flush_page(env, tlb);
> +    }
> +
>      tlb->mas7_3 =3D ((uint64_t)env->spr[SPR_BOOKE_MAS7] << 32) |
>          env->spr[SPR_BOOKE_MAS3];
>      tlb->mas1 =3D env->spr[SPR_BOOKE_MAS1];
> @@ -2663,11 +2680,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
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

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAln//kQACgkQbDjKyiDZ
s5IN/RAAjTU0Us/34TM16EqknUhQA27Cjl72/daSDnzYn7K0+gg9YLslVP/5uBBH
SpDOwzSMTptg/GRMCWH8ykriSIeejlfu+bB/aE1+zG+MEJ6QFraGSAjgYl2a0P1A
dBpDCy3qQS8icgt/D7Z+MN08k++tQMf8VJ5AeznekD6k9XZEVgrD9CTPWbeEFCqk
vHYdxuB1iisfQMRP/jwlkbV5ppNjLFIh6sw3Mc+RXRoxHaBfbQ9icC3IkWg+M8nA
A4NrhYgGpPo6PR/S560Xv4+MTR98JVqPmV9dLkRIKuI0/nOKEG843Mpu5SzGt60Q
4vNtzrURFGfyXELQdoHlEe9bdyKRXF8Gt0glS9rhfC71QJbWgA1H+3rJS125FTx/
9uyB6rj41BuXaA0jghDYPHXvrnj7MY/AQW0VrDvPa2BMaxuxzgvEToQ3Ut1Y9WzE
G0UEUVx5eH4zVgJAG8S094nT0Vg4kpQMgT6ohHPsmj1MdqgvOEM8j8Gi9tAvtvf8
hjiVWrV0Zoxxi3MlYiQNKNLvMRusBAyfV2v3oSKgqJIg+cHhjwx5bvd7tNqQlSdX
rhWKqk68DILssoJ8vrFPMk5uzcw54iW/WXFPJpMPITWCYGgQPco+W+K449T33ZY7
zczGu320a2MVuOWDcX5WZQHSy3s11devMwF7PkmAoqXtkizELDc=
=wY6U
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
