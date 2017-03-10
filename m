Received: from eggs.gnu.org ([2001:4830:134:3::10]:40789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cmAa2-0004lj-1l
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 21:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cmAZy-0004vo-5e
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 21:46:58 -0500
Date: Fri, 10 Mar 2017 13:38:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170310023833.GX19967@umbus.fritz.box>
References: <20170310014113.37988-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FYmwbMCTM+aCvPj+"
Content-Disposition: inline
In-Reply-To: <20170310014113.37988-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] target-ppc: kvm: make use of
 KVM_CREATE_SPAPR_TCE_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--FYmwbMCTM+aCvPj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 12:41:13PM +1100, Alexey Kardashevskiy wrote:
> KVM_CAP_SPAPR_TCE capability allows creating TCE tables in KVM which
> allows having in-kernel acceleration for H_PUT_TCE_xxx hypercalls.
> However it only supports 32bit DMA windows at zero bus offset.
>=20
> There is a new KVM_CAP_SPAPR_TCE_64 capability which supports 64bit
> window size, variable page size and bus offset.
>=20
> This makes use of the new capability. The kernel headers are already
> updated as the kernel support went in to v4.6.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> * rebased on recent dwg/ppc-for-2.10

Applied to ppc-for-2.10, thanks.

>=20
>=20
> ---
>  target/ppc/kvm_ppc.h | 12 +++++++-----
>  hw/ppc/spapr_iommu.c |  8 +++++---
>  target/ppc/kvm.c     | 48 +++++++++++++++++++++++++++++++++++++---------=
--
>  3 files changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 8e9f42d0c6..08ecf75a46 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -36,8 +36,9 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  #ifndef CONFIG_USER_ONLY
>  off_t kvmppc_alloc_rma(void **rma);
>  bool kvmppc_spapr_use_multitce(void);
> -void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int =
*pfd,
> -                              bool need_vfio);
> +void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
> +                              uint64_t bus_offset, uint32_t nb_table,
> +                              int *pfd, bool need_vfio);
>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>  int kvmppc_reset_htab(int shift_hint);
>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
> @@ -167,9 +168,10 @@ static inline bool kvmppc_spapr_use_multitce(void)
>      return false;
>  }
> =20
> -static inline void *kvmppc_create_spapr_tce(uint32_t liobn,
> -                                            uint32_t window_size, int *f=
d,
> -                                            bool need_vfio)
> +static inline void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t pag=
e_shift,
> +                                            uint64_t bus_offset,
> +                                            uint32_t nb_table,
> +                                            int *pfd, bool need_vfio)
>  {
>      return NULL;
>  }
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index ae30bbe30f..29c80bb3c8 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -79,15 +79,16 @@ static IOMMUAccessFlags spapr_tce_iommu_access_flags(=
uint64_t tce)
> =20
>  static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
>                                         uint32_t page_shift,
> +                                       uint64_t bus_offset,
>                                         uint32_t nb_table,
>                                         int *fd,
>                                         bool need_vfio)
>  {
>      uint64_t *table =3D NULL;
> -    uint64_t window_size =3D (uint64_t)nb_table << page_shift;
> =20
> -    if (kvm_enabled() && !(window_size >> 32)) {
> -        table =3D kvmppc_create_spapr_tce(liobn, window_size, fd, need_v=
fio);
> +    if (kvm_enabled()) {
> +        table =3D kvmppc_create_spapr_tce(liobn, page_shift, bus_offset,=
 nb_table,
> +                                        fd, need_vfio);
>      }
> =20
>      if (!table) {
> @@ -342,6 +343,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
>      tcet->nb_table =3D nb_table;
>      tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
>                                          tcet->page_shift,
> +                                        tcet->bus_offset,
>                                          tcet->nb_table,
>                                          &tcet->fd,
>                                          tcet->need_vfio);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9f1f132cef..031d31f87e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -73,6 +73,7 @@ static int cap_booke_sregs;
>  static int cap_ppc_smt;
>  static int cap_ppc_rma;
>  static int cap_spapr_tce;
> +static int cap_spapr_tce_64;
>  static int cap_spapr_multitce;
>  static int cap_spapr_vfio;
>  static int cap_hior;
> @@ -125,6 +126,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
> +    cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE=
);
>      cap_spapr_vfio =3D false;
>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
> @@ -2132,13 +2134,10 @@ bool kvmppc_spapr_use_multitce(void)
>      return cap_spapr_multitce;
>  }
> =20
> -void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int =
*pfd,
> -                              bool need_vfio)
> +void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
> +                              uint64_t bus_offset, uint32_t nb_table,
> +                              int *pfd, bool need_vfio)
>  {
> -    struct kvm_create_spapr_tce args =3D {
> -        .liobn =3D liobn,
> -        .window_size =3D window_size,
> -    };
>      long len;
>      int fd;
>      void *table;
> @@ -2151,14 +2150,41 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uin=
t32_t window_size, int *pfd,
>          return NULL;
>      }
> =20
> -    fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
> -    if (fd < 0) {
> -        fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x%x\=
n",
> -                liobn);
> +    if (cap_spapr_tce_64) {
> +        struct kvm_create_spapr_tce_64 args =3D {
> +            .liobn =3D liobn,
> +            .page_shift =3D page_shift,
> +            .offset =3D bus_offset >> page_shift,
> +            .size =3D nb_table,
> +            .flags =3D 0
> +        };
> +        fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE_64, &args);
> +        if (fd < 0) {
> +            fprintf(stderr,
> +                    "KVM: Failed to create TCE64 table for liobn 0x%x\n",
> +                    liobn);
> +            return NULL;
> +        }
> +    } else if (cap_spapr_tce) {
> +        uint64_t window_size =3D (uint64_t) nb_table << page_shift;
> +        struct kvm_create_spapr_tce args =3D {
> +            .liobn =3D liobn,
> +            .window_size =3D window_size,
> +        };
> +        if ((window_size !=3D args.window_size) || bus_offset) {
> +            return NULL;
> +        }
> +        fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
> +        if (fd < 0) {
> +            fprintf(stderr, "KVM: Failed to create TCE table for liobn 0=
x%x\n",
> +                    liobn);
> +            return NULL;
> +        }
> +    } else {
>          return NULL;
>      }
> =20
> -    len =3D (window_size / SPAPR_TCE_PAGE_SIZE) * sizeof(uint64_t);
> +    len =3D nb_table * sizeof(uint64_t);
>      /* FIXME: round this up to page size */
> =20
>      table =3D mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FYmwbMCTM+aCvPj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwhGmAAoJEGw4ysog2bOS+mAQAOBTqNIGzn1d1mGxPX2omom2
x3pZjCGpo7Tu0q0ZQv+jj1qydS+gOkNU7VCs4gmieGZhAKBUjO3IYa3kLYq68sMb
OgqPTv+0VELiDmxHZTIZ52XX3ogwvTRppD9jyDHsKH+2cQ5AeE/O78YFQey7/nCo
TkOY9YXVkLZxdTzKjGPyNNVxRuC1Hk3Y1COk9pJgRT9IplI8a76eroWKbrZ3JKgx
xVGVIMsiUuy5RIa8Xckap3wRZaaA+4VYJIa53P05AXbtLQgmkwPZur2wGoiIGlrB
aiPpGkEuASN55LeM6q1YMOai+DjT3zrA430uO2vIJyFLq20NBgGYAMRBAsYaQbWF
BazqSkU7uWhX6nr/mw9/VNspEtGt+Ho0PgXTmL867YP4k/miKPnG8XAZaKE3QRCX
rSlnEXtIxgk2EdZysmdkPO8pITb71/1lrcVWPDak78AIV0EZ3UGfDy4R86EKDP2X
RoTbY3UWEJXgG7NEkkzAtuc0VhMeh28bCs9D1dKnOsHWosDCtxnSFaJ9D/iheF78
8htkqF3NEABMcg9uqJENqTM3skSaH0WTjA1h6hC9jVggIQL/WDg7xdO4u5uSV2qJ
UdWeK2ukzSX2F+hFaWyuDUcegLMlAPwUDNkY9jTosGpj9PhtVd2HokZStWyQRZC1
yrTEWPaEflx5tbKfghZJ
=kP3u
-----END PGP SIGNATURE-----

--FYmwbMCTM+aCvPj+--
