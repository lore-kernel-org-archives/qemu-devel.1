Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm99g-0007kr-Ge
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm99c-0004Pl-E3
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:15:40 -0500
Date: Fri, 10 Mar 2017 12:15:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170310011527.GW19967@umbus.fritz.box>
References: <20170310011328.30719-1-david@gibson.dropbear.id.au>
	<20170310011328.30719-6-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L+ytD9kXoSFEJYhc"
Content-Disposition: inline
In-Reply-To: <20170310011328.30719-6-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/5] pseries: Allow HPT resizing
 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com


--L+ytD9kXoSFEJYhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 12:13:28PM +1100, David Gibson wrote:
> So far, qemu implements the PAPR Hash Page Table (HPT) resizing extension
> with TCG.  The same implementation will work with KVM PR, but we don't
> currently allow that.  For KVM HV we can only implement resizing with the
> assistance of the host kernel, which needs a new capability and ioctl()s.
>=20
> This patch adds support for testing the new KVM capability and implementi=
ng
> the resize in terms of KVM facilities when necessary.  If we're running on
> a kernel which doesn't have the new capability flag at all, we fall back =
to
> testing for PR vs. HV KVM using the same hack that we already use in a
> number of places for older kernels.
>=20
> NOTE: This patch updates the linux-headers tree with the define for the
> new capability and ioctl()s.  Since the corresponding kernel changes aren=
't
> yet upstream this is a temporary hack to be replaced by a proper headers
> update before merge.

The paragraph above is no longer accurate - the defines are in the
mainline kernel, and have even already been pulled into the qemu
tree.  I'll drop this chunk when I commit.

>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_hcall.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++=
+---
>  target/ppc/kvm.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  target/ppc/kvm_ppc.h | 21 ++++++++++++++++
>  3 files changed, 148 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ee1b7fa..f66bc4f 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -457,6 +457,44 @@ static ram_addr_t get_current_ram_size(void)
>      return size;
>  }
> =20
> +/* Convert a return code from the KVM ioctl()s implementing resize HPT
> + * into a PAPR hypercall return code */
> +static target_ulong resize_hpt_convert_rc(int ret)
> +{
> +    if (ret >=3D 100000) {
> +        return H_LONG_BUSY_ORDER_100_SEC;
> +    } else if (ret >=3D 10000) {
> +        return H_LONG_BUSY_ORDER_10_SEC;
> +    } else if (ret >=3D 1000) {
> +        return H_LONG_BUSY_ORDER_1_SEC;
> +    } else if (ret >=3D 100) {
> +        return H_LONG_BUSY_ORDER_100_MSEC;
> +    } else if (ret >=3D 10) {
> +        return H_LONG_BUSY_ORDER_10_MSEC;
> +    } else if (ret > 0) {
> +        return H_LONG_BUSY_ORDER_1_MSEC;
> +    }
> +
> +    switch (ret) {
> +    case 0:
> +        return H_SUCCESS;
> +    case -EPERM:
> +        return H_AUTHORITY;
> +    case -EINVAL:
> +        return H_PARAMETER;
> +    case -ENXIO:
> +        return H_CLOSED;
> +    case -ENOSPC:
> +        return H_PTEG_FULL;
> +    case -EBUSY:
> +        return H_BUSY;
> +    case -ENOMEM:
> +        return H_NO_MEM;
> +    default:
> +        return H_HARDWARE;
> +    }
> +}
> +
>  static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>                                           sPAPRMachineState *spapr,
>                                           target_ulong opcode,
> @@ -465,6 +503,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *=
cpu,
>      target_ulong flags =3D args[0];
>      int shift =3D args[1];
>      sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> +    int rc;
> =20
>      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
>          return H_AUTHORITY;
> @@ -487,6 +526,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU =
*cpu,
>          return H_RESOURCE;
>      }
> =20
> +    rc =3D kvmppc_resize_hpt_prepare(cpu, flags, shift);
> +    if (rc !=3D -ENOSYS) {
> +        return resize_hpt_convert_rc(rc);
> +    }
> +
>      if (pending) {
>          /* something already in progress */
>          if (pending->shift =3D=3D shift) {
> @@ -682,6 +726,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *=
cpu,
> =20
>      trace_spapr_h_resize_hpt_commit(flags, shift);
> =20
> +    rc =3D kvmppc_resize_hpt_commit(cpu, flags, shift);
> +    if (rc !=3D -ENOSYS) {
> +        return resize_hpt_convert_rc(rc);
> +    }
> +
>      if (flags !=3D 0) {
>          return H_PARAMETER;
>      }
> @@ -700,12 +749,17 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU =
*cpu,
>      rc =3D rehash_hpt(cpu, spapr->htab, HTAB_SIZE(spapr),
>                      pending->hpt, newsize);
>      if (rc =3D=3D H_SUCCESS) {
> -        CPUState *cs;
> -
>          qemu_vfree(spapr->htab);
>          spapr->htab =3D pending->hpt;
>          spapr->htab_shift =3D pending->shift;
> =20
> +        if (kvm_enabled()) {
> +            /* For KVM PR, update the HPT pointer */
> +            target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->htab
> +                | (spapr->htab_shift - 18);
> +            kvmppc_update_sdr1(sdr1);
> +        }
> +
>          pending->hpt =3D NULL; /* so it's not free()d */
>      }
> =20
> @@ -1373,7 +1427,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>               * entered into the existing HPT */
>              spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
>              CPU_FOREACH(cs) {
> -                run_on_cpu(cs, pivot_hpt, RUN_ON_CPU_HOST_PTR(spapr));
> +                if (kvm_enabled()) {
> +                    /* For KVM PR, update the HPT pointer */
> +                    target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr=
->htab
> +                        | (spapr->htab_shift - 18);
> +                    kvmppc_update_sdr1(sdr1);
> +                }
>              }
>          }
>      }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 97591d2..bff04ff 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -84,6 +84,7 @@ static int cap_papr;
>  static int cap_htab_fd;
>  static int cap_fixup_hcalls;
>  static int cap_htm;             /* Hardware transactional memory support=
 */
> +static int cap_resize_hpt;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -137,6 +138,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>      cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
> +    cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
> =20
>      if (!cap_interrupt_level) {
>          fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
> @@ -2603,10 +2605,71 @@ int kvmppc_enable_hwrng(void)
>  void kvmppc_check_papr_resize_hpt(Error **errp)
>  {
>      if (!kvm_enabled()) {
> -        return;
> +        return; /* No KVM, we're good */
> +    }
> +
> +    if (cap_resize_hpt) {
> +        return; /* Kernel has explicit support, we're good */
>      }
> =20
> -    /* TODO: Check for resize-capable KVM implementations */
> +    /* Otherwise fallback on looking for PR KVM */
> +    if (kvmppc_is_pr(kvm_state)) {
> +        return;
> +    }
> =20
>      error_setg(errp, "Hash page table resizing not available with this K=
VM version");
>  }
> +
> +int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int s=
hift)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    struct kvm_ppc_resize_hpt rhpt =3D {
> +        .flags =3D flags,
> +        .shift =3D shift,
> +    };
> +
> +    if (!cap_resize_hpt) {
> +        return -ENOSYS;
> +    }
> +
> +    return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_PREPARE, &rhpt=
);
> +}
> +
> +int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int sh=
ift)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    struct kvm_ppc_resize_hpt rhpt =3D {
> +        .flags =3D flags,
> +        .shift =3D shift,
> +    };
> +
> +    if (!cap_resize_hpt) {
> +        return -ENOSYS;
> +    }
> +
> +    return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhpt);
> +}
> +
> +static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
> +{
> +    target_ulong sdr1 =3D arg.target_ptr;
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    /* This is just for the benefit of PR KVM */
> +    cpu_synchronize_state(cs);
> +    env->spr[SPR_SDR1] =3D sdr1;
> +    if (kvmppc_put_books_sregs(cpu) < 0) {
> +        error_report("Unable to update SDR1 in KVM");
> +        exit(1);
> +    }
> +}
> +
> +void kvmppc_update_sdr1(target_ulong sdr1)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr1)=
);
> +    }
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index cd3b234..493ff2e 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -57,6 +57,9 @@ int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
>  void kvmppc_check_papr_resize_hpt(Error **errp);
> +int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int s=
hift);
> +int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int sh=
ift);
> +void kvmppc_update_sdr1(target_ulong sdr1);
> =20
>  bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
> =20
> @@ -272,6 +275,24 @@ static inline void kvmppc_check_papr_resize_hpt(Erro=
r **errp)
>  {
>      return;
>  }
> +
> +static inline int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu,
> +                                            target_ulong flags, int shif=
t)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline int kvmppc_resize_hpt_commit(PowerPCCPU *cpu,
> +                                           target_ulong flags, int shift)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline void kvmppc_update_sdr1(target_ulong sdr1)
> +{
> +    abort();
> +}
> +
>  #endif
> =20
>  #ifndef CONFIG_KVM

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L+ytD9kXoSFEJYhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwf4tAAoJEGw4ysog2bOSj6sP+wbpeYbLGWAHIXmEjpzB1Yt+
VYGv0MGdjbgFCmYopG7z0DwusuHpL2S2/lJvXkBmDjukBlbkFav5AAwMXiaQzrlZ
DQMGoeEHurD0IWmABEHMliPO/UVyBdQ4BI7EehHJFSMAi7VIMQL0xJli8oKzSPgK
ErnVUo1dOQqB15BOk4gjVl4k3YSiOi924AaFTHl0+uel6xNz2Jdm+eir5n7mhVnb
GnRocVXnmvE6vFeN5QQAADLjgdPNDZa5X8JaylhyD7BgOkZCpcUGzCdiFbMD0x6x
KN1CUQ9ryTNqqzmxJD5G3/ib3442nRwp7lCOw5eSnXe8SxRLzPk5Bke8VxJcg5Uv
c7hrRSSDlw7ZVO/0a/SwozCKZU2aaul+1EKAkByVNMK0etewE80mtyGJbwXJkCcR
/Bhk0QCNfb6i4KpSg5q2/ZtM3ZGPC/oGxlGRdgZ5G/lz4K19nnSrDYQB64q70GBr
O7VNM7Iict2YjCY+nuXzigrQfWeQ5Ti7jhLSr54tE+++P41uDCBvoDaEXYLKyI0a
YckQfP+1qeLBoYDDgplUmW7/IJM75eDchI/AUn3uZQ243n0TX5NT5SRrBcV2uOJ2
uGiRZ2ET9J1q7dPStwjsMsapKDMUsXMYIWtTwbNSFu05v8AR9GDa7GIycTB2nD+z
tBDXgLMDwjfeL/j1z79M
=Pcpz
-----END PGP SIGNATURE-----

--L+ytD9kXoSFEJYhc--
