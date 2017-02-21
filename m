Received: from eggs.gnu.org ([2001:4830:134:3::10]:49342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cg17w-000498-Bm
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cg17t-0006ve-7h
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:28:32 -0500
Date: Tue, 21 Feb 2017 14:17:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170221031727.GC27524@umbus>
References: <20170221025211.30007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20170221025211.30007-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix serious bug in HPTE
 writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org
Cc: lvivier@redhat.com, thuth@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, agraf@suse.de


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 01:52:11PM +1100, David Gibson wrote:
> ppc_hash64_store_hpte() is used to update HPTEs in the hashed page table
> (HPT) for 64-bit machines.  This is used when the (emulated) CPU needs to
> update the referenced (R) or changed (C) bits in the HPTE.
>=20
> Some time ago this was converted to take an HPTE index, instead of a
> raw offset to the HPTE within the HPT (similar functions for 32-bit still
> take an offset).  In the process a serious bug was introduced: we're
> still using the index parameter as though it was an offset, failing to
> multiply by the size of an HPTE, so it will update bits in the wrong part
> of the HPT.  This can corrupt the guests's HPT, causing crashes or data
> loss.
>=20
> AFAICT the reason we haven't noticed this error earlier is that for 64-bit
> machines we've been testing almost exclusively with Linux guests.  Linux
> on ppc does not make use of the hardware R & C bits, so this writeback
> will never be triggered.  It also occurs only on TCG, not KVM, guests.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Self NACK.  Sorry.  In my panic, I managed to miss the multiply a few
lines above.  There isn't actually a bug here, just some confusing
variable naming.

> ---
>  target/ppc/mmu-hash64.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index bb78fb5..dc3b5f7 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -894,12 +894,15 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
> =20
>      pte_index *=3D HASH_PTE_SIZE_64;
>      if (env->external_htab) {
> -        stq_p(env->external_htab + pte_index, pte0);
> -        stq_p(env->external_htab + pte_index + HASH_PTE_SIZE_64 / 2, pte=
1);
> +        stq_p(env->external_htab + pte_index * HASH_PTE_SIZE_64, pte0);
> +        stq_p(env->external_htab + pte_index * HASH_PTE_SIZE_64
> +              + HASH_PTE_SIZE_64 / 2, pte1);
>      } else {
> -        stq_phys(CPU(cpu)->as, env->htab_base + pte_index, pte0);
>          stq_phys(CPU(cpu)->as,
> -                 env->htab_base + pte_index + HASH_PTE_SIZE_64 / 2, pte1=
);
> +                 env->htab_base + pte_index * HASH_PTE_SIZE_64, pte0);
> +        stq_phys(CPU(cpu)->as,
> +                 env->htab_base + pte_index * HASH_PTE_SIZE_64
> +                 + HASH_PTE_SIZE_64 / 2, pte1);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYq7FEAAoJEGw4ysog2bOSuk8P/2z4PcZu1LDmQIrab03NrvG+
FH4gYifLTaizfQucALmHDR/M0vZvLfuFBr3GkypjCquGqjjb7vpVjluu1ZD/6nmd
V2BZNEbqzbCKZdsd6wkMYY1M1fp+f+y27NKRHFXZE61T4tCLvbHvysRX7NXuHRdC
uwQZyQEMExO5aCgyYudy6Pz2uNqF5M7KIolTpwmD3hT7IGT4uLNm6ALqsCtKmKI7
KmwydfV0nnl3AfZHDkBr1cmyiDOcgSDzEmgcIqmhOel3ViwpGxNg2il+HHRhOl/R
WN1qL3H+wvGAGrVYFCe1gzNEsog1EweHjnwRoTYxTb+1+Y8D1Kci7aZVaQYDnivH
Z9kglF3Zc10NVjSQAD0pTMIwBBkrQICt/yFAXNGTLTixBCEEiHcTI+7CZ68lhjcr
bTDwuBi4nwGLnXGEUwqLj4qODBekBWJ+LCT/YegvPYo5k3qxsl5T2tLRBRgbnwil
ZMWEhOqOHya7G18hnDAvVAq4X5nsydFl29VR6fAih6jtG40IQ3l7/64r87V6DqBq
0FxsvxQuxDJ+YS8tGi3LWrmpmL8onoaNusvFgXYqz1EzSGnhkhXBUVZZ2lqEga5M
IlAkFGGIML2bnx8mBIrPljQEc54MdGglxFkkGdCLvHU3iYtFYz6Ip6b8hI40Lsr9
frzEbW3ouDFijgCrQDBw
=x7ZE
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
