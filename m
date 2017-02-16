Received: from eggs.gnu.org ([2001:4830:134:3::10]:49625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ceCLG-0002Ts-Ex
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ceCLC-0002fC-Fr
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:02:46 -0500
Date: Thu, 16 Feb 2017 13:28:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170216022823.GP12369@umbus.fritz.box>
References: <1487150504-30335-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zfao1/4IORAeFOVj"
Content-Disposition: inline
In-Reply-To: <1487150504-30335-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Check for valid page size
 when hot plugging memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--Zfao1/4IORAeFOVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 10:21:44AM +0100, Thomas Huth wrote:
> On POWER, the valid page sizes that the guest can use are bound
> to the CPU and not to the memory region. QEMU already has some
> fancy logic to find out the right maximum memory size to tell
> it to the guest during boot (see getrampagesize() in the file
> target/ppc/kvm.c for more information).
> However, once we're booted and the guest is using huge pages
> already, it is currently still possible to hot-plug memory regions
> that does not support huge pages - which of course does not work
> on POWER, since the guest thinks that it is possible to use huge
> pages everywhere. The KVM_RUN ioctl will then abort with -EFAULT,
> QEMU spills out a not very helpful error message together with
> a register dump and the user is annoyed that the VM unexpectedly
> died.
> To avoid this situation, we should check the page size of hot-plugged
> DIMMs to see whether it is possible to use it in the current VM.
> If it does not fit, we can print out a better error message and
> refuse to add it, so that the VM does not die unexpectely and the
> user has a second chance to plug a DIMM with a matching memory
> backend instead.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1419466
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Using the global is a bit yucky, but I can't see an easy way to remove
it, and it's not like there aren't already some ugly globals in the
KVM code.  In the meantime this fixes a real bug, so I've merged this
to ppc-for-2.9.

Thanks.

> ---
>  hw/ppc/spapr.c       |  8 ++++++++
>  target/ppc/kvm.c     | 32 ++++++++++++++++++++++++++++----
>  target/ppc/kvm_ppc.h |  7 +++++++
>  3 files changed, 43 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e465d7a..1a90aae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2357,6 +2357,7 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      uint64_t align =3D memory_region_get_alignment(mr);
>      uint64_t size =3D memory_region_size(mr);
>      uint64_t addr;
> +    char *mem_dev;
> =20
>      if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(&local_err, "Hotplugged memory size must be a multipl=
e of "
> @@ -2364,6 +2365,13 @@ static void spapr_memory_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> +    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P, NULL);
> +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> +        error_setg(&local_err, "Memory backend has bad page size. "
> +                   "Use 'memory-backend-file' with correct mem-path.");
> +        goto out;
> +    }
> +
>      pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
>      if (local_err) {
>          goto out;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 663d2e7..584546b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -438,12 +438,13 @@ static bool kvm_valid_page_size(uint32_t flags, lon=
g rampgsize, uint32_t shift)
>      return (1ul << shift) <=3D rampgsize;
>  }
> =20
> +static long max_cpu_page_size;
> +
>  static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>  {
>      static struct kvm_ppc_smmu_info smmu_info;
>      static bool has_smmu_info;
>      CPUPPCState *env =3D &cpu->env;
> -    long rampagesize;
>      int iq, ik, jq, jk;
>      bool has_64k_pages =3D false;
> =20
> @@ -458,7 +459,9 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>          has_smmu_info =3D true;
>      }
> =20
> -    rampagesize =3D getrampagesize();
> +    if (!max_cpu_page_size) {
> +        max_cpu_page_size =3D getrampagesize();
> +    }
> =20
>      /* Convert to QEMU form */
>      memset(&env->sps, 0, sizeof(env->sps));
> @@ -478,14 +481,14 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>          struct ppc_one_seg_page_size *qsps =3D &env->sps.sps[iq];
>          struct kvm_ppc_one_seg_page_size *ksps =3D &smmu_info.sps[ik];
> =20
> -        if (!kvm_valid_page_size(smmu_info.flags, rampagesize,
> +        if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
>                                   ksps->page_shift)) {
>              continue;
>          }
>          qsps->page_shift =3D ksps->page_shift;
>          qsps->slb_enc =3D ksps->slb_enc;
>          for (jk =3D jq =3D 0; jk < KVM_PPC_PAGE_SIZES_MAX_SZ; jk++) {
> -            if (!kvm_valid_page_size(smmu_info.flags, rampagesize,
> +            if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
>                                       ksps->enc[jk].page_shift)) {
>                  continue;
>              }
> @@ -510,12 +513,33 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>          env->mmu_model &=3D ~POWERPC_MMU_64K;
>      }
>  }
> +
> +bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +{
> +    Object *mem_obj =3D object_resolve_path(obj_path, NULL);
> +    char *mempath =3D object_property_get_str(mem_obj, "mem-path", NULL);
> +    long pagesize;
> +
> +    if (mempath) {
> +        pagesize =3D gethugepagesize(mempath);
> +    } else {
> +        pagesize =3D getpagesize();
> +    }
> +
> +    return pagesize >=3D max_cpu_page_size;
> +}
> +
>  #else /* defined (TARGET_PPC64) */
> =20
>  static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>  {
>  }
> =20
> +int kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +{
> +    return true;
> +}
> +
>  #endif /* !defined (TARGET_PPC64) */
> =20
>  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 151c00b..8da2ee4 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -60,6 +60,8 @@ int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> =20
> +bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
> +
>  #else
> =20
>  static inline uint32_t kvmppc_get_tbfreq(void)
> @@ -192,6 +194,11 @@ static inline uint64_t kvmppc_rma_size(uint64_t curr=
ent_size,
>      return ram_size;
>  }
> =20
> +static inline bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +{
> +    return true;
> +}
> +
>  #endif /* !CONFIG_USER_ONLY */
> =20
>  static inline bool kvmppc_has_cap_epr(void)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zfao1/4IORAeFOVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYpQ5FAAoJEGw4ysog2bOSnW4P/jZ+vJl2gphFNipQPCo5qZZf
HnsgO7mX7Vz51ME9CIjbhJsQ6uvxo8JpfJwvtrm5ozrVrxX7OH1DX+q6KJk8VJ+M
PYOYja4/ilk9OOJJE37KBri35JrjCUcDBvGd9W1p+Cl93o7szbrs4r76IxcgUAEx
YG/8GjuCCq5cmqxoDH6tcbW+wwIwjiM2CvzFanmY4tlxgzXehDZg6nfvJA0oC1e9
tZTB1tryoHNxSRFyaTRgV6wIMca9sOgfaq66CsH4KVAQSxih83v0u7jbe+gps1BS
7/PoBztMDNb/+ZmI2qvmlBsEpIQuHiav9wFFtBlEkTPUr1l3YhcGoTQhguMvrpBq
1mvt4nyi4bKwuvKZvGpcEMoiJiZVbu/MvqlqyeeC22l7V9gDV3zJ/0KHhJmh+0KG
oOp37C6pPuQVmzbs8XlZvRdcWXlFG/OxL8E0xesjkP0MORLthqlaT+aZu2s4TU+R
4Gq4jVpY5nUDIlhwLGSuFhzenWLDvjKw96NqXQXr2WMkJKBK4Z6rnlTDxy1Yxw3N
c3jFKP7xAcUjGU8jxEUn2kQ9WMk+lBNLcesbKQQbdOyLH8WukOVzLuChhcCCApaA
zZaLgrzSqz9yS1v9dthsKCXHv+srrbd3Uvkn9Tuw9KuWC0oGZtm1Zd16jk2YJJQg
3JX3/X7s/GWJHlG3/6o3
=Jk5I
-----END PGP SIGNATURE-----

--Zfao1/4IORAeFOVj--
