Received: from eggs.gnu.org ([2001:4830:134:3::10]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepp-0007cS-Gd
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0006yb-RW
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Date: Thu, 9 Feb 2017 13:14:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209021408.GQ17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<0de3d80bc7658aac7dc5f6b271045463b572c7ff.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
Content-Disposition: inline
In-Reply-To: <0de3d80bc7658aac7dc5f6b271045463b572c7ff.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/9] spapr: Add ibm,
 processor-radix-AP-encodings to the device tree
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


--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:46PM +1100, Sam Bobroff wrote:
> Use the new ioctl, KVM_PPC_GET_RMMU_INFO, to fetch radix MMU
> information from KVM and present the page encodings in the device tree
> under ibm,processor-radix-AP-encodings. This provides page size
> information to the guest which is necessary for it to use radix mode.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  hw/ppc/spapr.c   |  7 +++++++
>  target/ppc/cpu.h |  5 +++++
>  target/ppc/kvm.c | 32 +++++++++++++++++++++++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a642e663d4..d629e2630c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -496,6 +496,13 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
> =20
>      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu,
>                                  ppc_get_compat_smt_threads(cpu)));
> +
> +    if (env->radix_page_info.count) {
> +        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings=
",
> +                          env->radix_page_info.entries,
> +                          env->radix_page_info.count *
> +                          sizeof(env->radix_page_info.entries[0]))));
> +    }
>  }
> =20
>  static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *sp=
apr)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index afb7ddbdd0..5a96d98b6f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -914,6 +914,10 @@ struct ppc_segment_page_sizes {
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> =20
> +struct ppc_radix_page_info {
> +    uint32_t count;
> +    uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];

IIUC this info is ready for direct inclusion in the device tree:
i.e. it's big-endian.  That absolutely needs a comment in the
structure.  I'm also not sure it's a good idea, since I assume the TCG
POWER9 code will eventually need to access this information directly
to implement the radix MMU.

Might be clearer to make this data structure native and do the BE
conversion when generating the device tree.

> +};
> =20
>  /***********************************************************************=
******/
>  /* The whole PowerPC CPU context */
> @@ -1053,6 +1057,7 @@ struct CPUPPCState {
>      ppc_slb_t vrma_slb;
>      target_ulong rmls;
>      bool ci_large_pages;
> +    struct ppc_radix_page_info radix_page_info;

I'm not sure this belongs in CPUPPCState.  New fields should generally
be added to PowerPCCPU ("cpu") rather than to CPUPPCState ("env")
unless they need to be directly accessed from TCG generated code.

But even more, AFAICT this should vary only with the CPU type/model,
not with the individual CPU instance.  So this information could
probably go into the CPU class structure instead of the instance.

Yes, there are a lot of things that don't obey those rules already -
that's because a lot of stuff hasn't been converted since the new QOM
stuff was introduced.  But we shouldn't make it any worse with new
patches.

>  #endif
> =20
>  #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index ec92c64159..390d6342cc 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -328,6 +328,18 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, struc=
t kvm_ppc_smmu_info *info)
>      kvm_get_fallback_smmu_info(cpu, info);
>  }
> =20
> +static bool kvm_get_rmmu_info(PowerPCCPU *cpu, struct kvm_ppc_rmmu_info =
*info)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    int ret;
> +
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_MMU_RADIX)) {
> +        ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_RMMU_INFO, info);
> +        return (ret =3D=3D 0);
> +    }
> +    return false;
> +}
> +
>  static long gethugepagesize(const char *mem_path)
>  {
>      struct statfs fs;
> @@ -441,9 +453,11 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>  {
>      static struct kvm_ppc_smmu_info smmu_info;
>      static bool has_smmu_info;
> +    static struct kvm_ppc_rmmu_info rmmu_info;
> +    static bool has_rmmu_info;
>      CPUPPCState *env =3D &cpu->env;
>      long rampagesize;
> -    int iq, ik, jq, jk;
> +    int iq, ik, jq, jk, i;
>      bool has_64k_pages =3D false;
> =20
>      /* We only handle page sizes for 64-bit server guests for now */
> @@ -508,6 +522,22 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      if (!has_64k_pages) {
>          env->mmu_model &=3D ~POWERPC_MMU_64K;
>      }
> +
> +    /* Collect radix page info from kernel if not already */
> +    if (!has_rmmu_info) {

Putting the data in the class would avoid this ugly messing with a
static local, for one thing.

> +        env->radix_page_info.count =3D 0;
> +        if (kvm_get_rmmu_info(cpu, &rmmu_info)) {
> +            for (i =3D 0; i < 8; i++) {

s/8/PPC_PAGE_SIZES_MAX_SZ/ ?

> +                if (rmmu_info.ap_encodings[i]) {
> +                    env->radix_page_info.entries[i] =3D
> +                        cpu_to_be32(rmmu_info.ap_encodings[i]);
> +                    env->radix_page_info.count++;
> +                }
> +            }
> +        }
> +        has_rmmu_info =3D true;
> +    }
> +
>  }
>  #else /* defined (TARGET_PPC64) */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9BuAAoJEGw4ysog2bOSnRAQAMsckTH5Rq8Iudk6W3PqRvyz
iKG+vmTx7HoIvF+jXaiuBMSWrds/ijwmtoSIUSewNpIuhcsNN0EizTMafUv9XlBp
l93E0KHX70t/Kgjq8BdRCdm/n303Mg2DYBy25egdaR3DaxbveMmGr36X3tq3ibE2
QNWAHG+48j6yoX1jQKZiRyr013+4dS9JQtPkM1UGnQ1Qrrk31fJNM1U7xPAc4Dq8
gP++YOiG3cBtXq9eyiuo7fZS1KbIz/EZGmDc3HmKuT5UHGE+/Apt1Zsa1qNIROVm
n3wZhPe0Oq3L+wx+kGYTzGiT9C1LsN6n/+UJnup0eoTmulH5OKIdv/4UNQly9sEW
IagPkOWiWuyeF0NFAMpXvGJPkyFz+xsKeWvP86AYlSBI0/OVVIlBIzmIuGR3XR72
IPRlJt4xHLMZ334cav3/AeMoAm/qpDZAEqcY0QGX5NFcRY0W2ZvRQ/Y9RH5fRNKJ
UF7QGi/c3KhMbqPu0tbTsXKZE7iv4o39aa+JMgsIYNnbd+kwg4Nezae4fwtXMm/F
DHCGoRffOmDgaPZGgjtZoD6h9+hm9AOB3OSfDCKPaAFhSAW3DaINcX7Od8/TnxEZ
/G18MaZMYqOgZXnpHN6o1w4qJprfT6lO09QoStdR7y1kI12yGHG3M4QZzXJV66/v
Tl4fuh6wqOimgXTHgiwJ
=jOap
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--
