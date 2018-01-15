Received: from eggs.gnu.org ([2001:4830:134:3::10]:60844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eaycs-0004FZ-OE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eaycp-0003yx-Kq
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:52:10 -0500
Date: Mon, 15 Jan 2018 16:49:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180115054919.GF2027@umbus.fritz.box>
References: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
	<20180114192349.22212-3-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <20180114192349.22212-3-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ppc: spapr: Check if thread
 argument is supported by host KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, lvivier@redhat.com


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2018 at 05:23:49PM -0200, Jose Ricardo Ziviani wrote:
> QEMU currently checks whether SMT passed is valid or not. However, it
> doesn't check if KVM supports such mode when kvm is enabled.

That's not really true - the attempt to actually set the vsmt mode in
KVM later on in spapr_set_vsmt_mode() will fail if KVM can't support
the number of threads.

The error added here might be a bit easier to understand, since it
doesn't refer to vsmt modes, which might just confuse the issue.

The change isn't urgent, though.

> This patch relies on KVM_CAP_PPC_SMT_POSSIBLE to make it sure that QEMU
> will either set a valid SMT mode or warn an error message and quit.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c       | 10 ++++++++++
>  target/ppc/kvm.c     |  5 +++++
>  target/ppc/kvm_ppc.h |  6 ++++++
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d1acfe8858..aed4d25fc4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2261,12 +2261,22 @@ static void spapr_set_vsmt_mode(sPAPRMachineState=
 *spapr, Error **errp)
>                       "on a pseries machine");
>          goto out;
>      }
> +
>      if (!is_power_of_2(smp_threads)) {
>          error_setg(&local_err, "Cannot support %d threads/core on a pser=
ies "
>                       "machine because it must be a power of 2", smp_thre=
ads);
>          goto out;
>      }
> =20
> +    if (kvm_enabled() && kvmppc_cap_smt_possible() > 0) {
> +        if ((kvmppc_cap_smt_possible() & smp_threads) !=3D smp_threads) {
> +            error_setg(&local_err, "KVM does not support %d threads/core=
=2E",
> +                    smp_threads);
> +            kvmppc_hint_smt_possible(&local_err);
> +            goto out;
> +        }
> +    }

I'd like to see a fallback for kernels that don't support the
smt_possible cap and vsmt mode setting (for those, we must have
smp_threads <=3D kvm_smt).

> +
>      /* Detemine the VSMT mode to use: */
>      if (vsmt_user) {
>          if (spapr->vsmt < smp_threads) {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 914be687e7..4a8ff4d63c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2456,6 +2456,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +int kvmppc_cap_smt_possible(void)
> +{
> +    return cap_ppc_smt_possible;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr =3D mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index ecb55493cc..2221850723 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -59,6 +59,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
> +int kvmppc_cap_smt_possible(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -290,6 +291,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
>      return false;
>  }
> =20
> +static inline int kvmppc_cap_smt_possible(void)
> +{
> +    return 0;
> +}
> +
>  static inline int kvmppc_enable_hwrng(void)
>  {
>      return -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpcQN0ACgkQbDjKyiDZ
s5KzrBAAk5k1Nf1NsOmVAfzER5eVN1SNrVr6P1t5TN5SxoarlpjQD9ebFNp7Wf0b
cLrKB4yLF8Jtxtn/xsrfSjYewNGrvcqFZZDhxN/W+UWbSzAGC193HHNFNHxHkXmI
OJ9ic9INeDaGawqn0JNiMhGlAS9WTuSIHDM4Sd083Mlud8oA1Z3q+j5FzjZ8yqqg
S92din3hIq/0DSHVoL030ARmiw74PDJvkGwx3m+sSI/7TzkRcf/ZDKk59SgDVIxL
wM6hTXukgJAVR5SfFMd938wMTsSSbcom58Efsn1JjVJh/HIVIbrWi//pSEApy289
kYk4Ni7XlBQk/w8x4XlnHqFbQlVi2bqPD0UWrkYO74B3+x6FAWoOYeyIyvTCbByk
hYA6qgBp2h99JJ47NQ8bnGxsK0kRlPG3opxzDKaAp2bEpwZvoSWVT4CD1owhlWV+
+ti6usi7fWyfY6pQcnSVA3pJu55mi53XBpPyWAeshIr5+qAFiA7MNPK1Fas4Z65V
YmWBdtwg3+pWRUd3tTMIrD6ZM1TTdHWZ+o/zn62GOAb8v5XA73ZReSwmhCqyJU48
L3RgNC4HBasDgp/S1Cq3shnuhMUkOXs5T1wJzXPpW9Zqxa92QyPrN6CPnEnaviHJ
yusq5RAitwD80gnO3HE7tmQbirRwHu5qROJ53vlpJLJpynIqsRU=
=Jb4e
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
