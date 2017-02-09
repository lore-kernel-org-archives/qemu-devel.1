Received: from eggs.gnu.org ([2001:4830:134:3::10]:46713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepo-0007cO-Jv
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0006xt-5k
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:48 -0500
Date: Thu, 9 Feb 2017 13:32:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209023219.GT17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<fe7cb0c915e6c88f090e7167410165bf0e7d14bc.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BVQ1RKc6+nLPB5pT"
Content-Disposition: inline
In-Reply-To: <fe7cb0c915e6c88f090e7167410165bf0e7d14bc.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 6/9] spapr: Add
 h_register_process_table() hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--BVQ1RKc6+nLPB5pT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:49PM +1100, Sam Bobroff wrote:
> Both radix and hash modes require guests to use
> h_register_process_table() to set up the MMU. Implement it using the
> new KVM ioctl KVM_PPC_CONFIGURE_V3_MMU.
>=20
> This hypercall is also necessary for fully emulated guests, so it will
> need to be reworked to integrate with Suraj's TCG patchset.
> ---
>  hw/ppc/spapr_hcall.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++=
++++
>  include/hw/ppc/spapr.h |  3 ++-
>  target/ppc/kvm.c       | 12 ++++++++++++
>  target/ppc/kvm_ppc.h   |  1 +
>  4 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c9bb6624c4..4de511c386 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1049,6 +1049,50 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu_,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_register_process_table(PowerPCCPU *cpu,
> +                                             sPAPRMachineState *spapr,
> +                                             target_ulong opcode,
> +                                             target_ulong *args)
> +{
> +    static target_ulong last_process_table;

Ewwww.. a static local?  Store this info in sPAPRMachineState instead;
chances are you'll want it in other places eventually anyway (even if
only for debugging).


> +    target_ulong flags =3D args[0];
> +    target_ulong proc_tbl =3D args[1];
> +    target_ulong page_size =3D args[2];
> +    target_ulong table_size =3D args[3];
> +    uint64_t cflags, cproc;
> +
> +    cflags =3D (flags & 4) ? KVM_PPC_MMUV3_RADIX : 0;

No #defines for the bits in the hcall arguments?

> +    cflags |=3D (flags & 1) ? KVM_PPC_MMUV3_GTSE : 0;
> +    cproc =3D (flags & 4) ? (1ul << 63) : 0;
> +    if (!(flags & 0x10)) {
> +        if ((last_process_table & (1ul << 63)) !=3D cproc) {
> +            return H_PARAMETER;
> +        }
> +        cproc =3D last_process_table;
> +    } else if (!(flags & 0x8)) {
> +        ; /* do nothing */
> +    } else if (flags & 4) {
> +        /* radix */
> +        if (table_size > 24 || (proc_tbl & 0xfff) || (proc_tbl >> 60)) {
> +            return H_PARAMETER;
> +        }
> +        cproc |=3D proc_tbl | table_size;
> +    } else {
> +        /* hash, possibly with process table */
> +        if (table_size > 24 || (proc_tbl >> 38) || page_size > 7) {
> +            return H_PARAMETER;
> +        }
> +        cproc =3D (proc_tbl << 25) | (page_size << 5) | table_size;
> +    }
> +    last_process_table =3D cproc;
> +    fprintf(stderr, "calling config mmu flags=3D%lx proctbl=3D%lx\n",
> +            cflags, cproc);
> +    if  (!kvmppc_configure_v3_mmu(cpu, cflags, cproc)) {
> +        return H_HARDWARE;
> +    }
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1136,6 +1180,10 @@ static void hypercall_register_types(void)
> =20
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> +
> +    /* Power9 MMU support */
> +    spapr_register_hypercall(H_REGISTER_PROCESS_TABLE,
> +                             h_register_process_table);
>  }
> =20
>  type_init(hypercall_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index bd5bcf70de..92bda0f36d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -347,7 +347,8 @@ struct sPAPRMachineState {
>  #define H_XIRR_X                0x2FC
>  #define H_RANDOM                0x300
>  #define H_SET_MODE              0x31C
> -#define MAX_HCALL_OPCODE        H_SET_MODE
> +#define H_REGISTER_PROCESS_TABLE 0x37C
> +#define MAX_HCALL_OPCODE        H_REGISTER_PROCESS_TABLE
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8d6fd1b067..0d1443616c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -344,6 +344,18 @@ static bool kvm_get_rmmu_info(PowerPCCPU *cpu, struc=
t kvm_ppc_rmmu_info *info)
>      return false;
>  }
> =20
> +bool kvmppc_configure_v3_mmu(PowerPCCPU *cpu, uint64_t flags, uint64_t p=
roc_tbl)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    int ret;
> +    struct kvm_ppc_mmuv3_cfg cfg;
> +
> +    cfg.flags =3D flags;
> +    cfg.process_table =3D proc_tbl;
> +    ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_CONFIGURE_V3_MMU, &cfg);
> +    return ret =3D=3D 0;
> +}
> +
>  static long gethugepagesize(const char *mem_path)
>  {
>      struct statfs fs;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 1c1b94847c..0b8b77583a 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -33,6 +33,7 @@ int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr=
_bits);
>  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_set_tcr(PowerPCCPU *cpu);
>  int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
> +bool kvmppc_configure_v3_mmu(PowerPCCPU *cpu, uint64_t flags, uint64_t p=
roctbl);
>  #ifndef CONFIG_USER_ONLY
>  off_t kvmppc_alloc_rma(void **rma);
>  bool kvmppc_spapr_use_multitce(void);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BVQ1RKc6+nLPB5pT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9SzAAoJEGw4ysog2bOSvNkP/3fLVHbZ5vxBJVYHyUBn2oQS
6/Hba3TjK/420RiyttaUniKU1Auyc6EspvOtvEG94CcC9FRkI1TgxW+JNekQRfJE
5AF7699geMmlBPAWXcKEi/wmikTvZBfi0nAkt68nwXeSStmkWKCqXRuo4XUS51+T
HtqxZWvVag7pkzKPtmY4eQNmQZ3Ps7SEeAtsV22BWr82/zNy7vmr8N4N2BqxKvCm
BDnYNi1w2LixLKAoZK79t7EmAeBMMwM2dZWN0ulpPxs2sHSd+1pZCQd6GlETZZUf
nWndOaLDh3cC7mCWHHNYYc+mZiHbKwqdOTImQTwV8BSwnxrGRuULjnhbmDQvTMfh
J1moXjEI7vxsNe1P+BscNTTUd0Dx3VHiGRCG/hbxVppD9IdN++9V+JOynDgnzSFK
HKr3MSLnAxHxsWvflJf89GaZxKrX6vqsbuFAHuWe7qgaHByOMiJLABob4O1HjpOL
pToOB0nkdPe+EUIjerBOfsDmktR2TIczOS1hHDQBrvH4DiaZSEU88NrnSmRGh708
ZjCiVErPSA20brsHpfJhA65+zvhI9mUVAYW4OhchpokluDPXZ8yhnwLC+2a1wxgI
47hfpxTORbFE6UjfoLFtQhJM3V20fcLhnR/8jSHCHSajBQzoFSmsJrfvNIHMBRSP
YT9+snBUmlEuTlswUjYH
=4cxQ
-----END PGP SIGNATURE-----

--BVQ1RKc6+nLPB5pT--
