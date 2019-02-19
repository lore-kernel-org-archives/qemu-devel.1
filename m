Received: from eggs.gnu.org ([209.51.188.92]:32875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdT-0003wS-Rb
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdS-0002Rw-HA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:59 -0500
Date: Tue, 19 Feb 2019 14:52:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219035228.GT9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 06/12] target/ppc: Fix ordering of hash MMU
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--vru7fAags9pVPvn5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:23PM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> With mttcg, we can have MMU lookups happening at the same time
> as the guest modifying the page tables.
>=20
> Since the HPTEs of the hash table MMU contains two words (or
> double worlds on 64-bit), we need to make sure we read them
> in the right order, with the correct memory barrier.
>=20
> Additionally, when using emulated SPAPR mode, the hypercalls
> writing to the hash table must also perform the udpates in
> the right order.
>=20
> Note: This part is still not entirely correct
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Yeah, this stuff was written under the assumption it was protected by
the BQL, which is getting less true all the time.

Applied.

> ---
>  hw/ppc/spapr.c          | 21 +++++++++++++++++++--
>  target/ppc/mmu-hash32.c |  6 ++++++
>  target/ppc/mmu-hash64.c |  6 ++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 60572eb59275..1afe31ee6163 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1507,8 +1507,25 @@ static void spapr_store_hpte(PPCVirtualHypervisor =
*vhyp, hwaddr ptex,
>      if (!spapr->htab) {
>          kvmppc_write_hpte(ptex, pte0, pte1);
>      } else {
> -        stq_p(spapr->htab + offset, pte0);
> -        stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
> +        if (pte0 & HPTE64_V_VALID) {
> +            stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
> +            /*
> +             * When setting valid, we write PTE1 first. This ensures
> +             * proper synchronization with the reading code in
> +             * ppc_hash64_pteg_search()
> +             */
> +            smp_wmb();
> +            stq_p(spapr->htab + offset, pte0);
> +        } else {
> +            stq_p(spapr->htab + offset, pte0);
> +            /*
> +             * When clearing it we set PTE0 first. This ensures proper
> +             * synchronization with the reading code in
> +             * ppc_hash64_pteg_search()
> +             */
> +            smp_wmb();
> +            stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
> +        }
>      }
>  }
> =20
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 03ae3c127985..e8562a7c8780 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -319,6 +319,12 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu=
, hwaddr pteg_off,
> =20
>      for (i =3D 0; i < HPTES_PER_GROUP; i++) {
>          pte0 =3D ppc_hash32_load_hpte0(cpu, pte_offset);
> +        /*
> +         * pte0 contains the valid bit and must be read before pte1,
> +         * otherwise we might see an old pte1 with a new valid bit and
> +         * thus an inconsistent hpte value
> +         */
> +        smp_rmb();
>          pte1 =3D ppc_hash32_load_hpte1(cpu, pte_offset);
> =20
>          if ((pte0 & HPTE32_V_VALID)
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index f6c822ef917b..b3c4d33faa55 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -506,6 +506,12 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu=
, hwaddr hash,
>      }
>      for (i =3D 0; i < HPTES_PER_GROUP; i++) {
>          pte0 =3D ppc_hash64_hpte0(cpu, pteg, i);
> +        /*
> +         * pte0 contains the valid bit and must be read before pte1,
> +         * otherwise we might see an old pte1 with a new valid bit and
> +         * thus an inconsistent hpte value
> +         */
> +        smp_rmb();
>          pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
> =20
>          /* This compares V, B, H (secondary) and the AVPN */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrfXwACgkQbDjKyiDZ
s5KFyBAA3Bk6HAPNACm1ipqmddVRq1e8ozCKHpU71KyLOddu0JPAC0oViin/6dyi
jbUKYB6PPIA8XUEpOI5vWtMV3KIyfVhkhrcBMGKmasUlY3km/WD6wy0Pnx6aAFkU
kLkUOg77/G9r8qfe44B6Gyo3g1lRvg/QpuK1BHArljHbE5wdAHwlHu/6+huvFqPS
H2eASdQLAEmWMnO9SjyOnUEjxikDsv6dW3OvbagpA2LvkgcIcHkgH+obYoZI58rL
9OBO/gmS4zTluVT8XU6/4eADljvzPVgxKHu05vD+8sJcKfLnarEUPQLnjkOO3x7g
hte7C2cHbP5B0+QFWf7iiEWgKKafFXfiy5Gu25+EODg4Gph66Zowjsk5Tp649Lh0
eXNsBNSaJu9lGEy8qid8irR2y+Yo7rUE23gdi52xxxp624RmIYw7dU3A4dNB45ps
rgUZOxoR7Pl3TkEgR+ieksE1lkjqUxUoFsp2VESeaO7dNOxo3ctRWLmBzGAZxhqU
jDyfXk4ZAOpeS/voYXVWPxCMYV791ds4LMxiyO83Mm1fkl5Z7I5edW+VXqGA74BN
zxFnIzEMOaPOXFad0/GTUWCE02NLhIlsV6OLEBDIyCMXFMRP9pSByEYOP5FpHeLW
Xs6apZzZk0e0OwXCZFI6+3GCW3jd+jslggYW1oaBxHmz2/T5a4o=
=fkoY
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--
