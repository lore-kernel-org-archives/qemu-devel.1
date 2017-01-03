Received: from eggs.gnu.org ([2001:4830:134:3::10]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOEqN-0006RM-Aj
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOEqK-0001bl-3M
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:28:55 -0500
Date: Tue, 3 Jan 2017 13:26:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170103022644.GL12761@umbus.fritz.box>
References: <20161222011312.12778-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
Content-Disposition: inline
In-Reply-To: <20161222011312.12778-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] target-ppc: kvm: make use of
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


--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2016 at 12:13:12PM +1100, Alexey Kardashevskiy wrote:
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
>  target-ppc/kvm_ppc.h | 12 +++++++-----
>  hw/ppc/spapr_iommu.c |  8 +++++---
>  target-ppc/kvm.c     | 48 +++++++++++++++++++++++++++++++++++++---------=
--
>  3 files changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
> index bd1d78bfbe..14320c2378 100644
> --- a/target-ppc/kvm_ppc.h
> +++ b/target-ppc/kvm_ppc.h
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
> @@ -168,9 +169,10 @@ static inline bool kvmppc_spapr_use_multitce(void)
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

This is broken.  Previously, if we had a >4GiB window, we'd fall back
to managing it in userspace, which would work, albeit slowly.  Now, if
you have an older kernel which doesn't support KVM_CAP_SPAPR_TCE_64 it
will attempt to allocate it in the kernel, and fail completely.

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
> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> index 9c4834c4fc..6e91a4d8bb 100644
> --- a/target-ppc/kvm.c
> +++ b/target-ppc/kvm.c
> @@ -71,6 +71,7 @@ static int cap_booke_sregs;
>  static int cap_ppc_smt;
>  static int cap_ppc_rma;
>  static int cap_spapr_tce;
> +static int cap_spapr_tce_64;
>  static int cap_spapr_multitce;
>  static int cap_spapr_vfio;
>  static int cap_hior;
> @@ -123,6 +124,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
> +    cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE=
);
>      cap_spapr_vfio =3D false;
>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
> @@ -2201,13 +2203,10 @@ bool kvmppc_spapr_use_multitce(void)
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
> @@ -2220,14 +2219,41 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uin=
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

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYawvhAAoJEGw4ysog2bOS6+AQAJWH+ydyBnUS0DJnVT4L1tbq
ypnFLsdbkIVa2ALcL7UAaDlniUwtgE+UAv5XUfpv27iYE6zGSJuOrtCWDJ4AbT6w
yPTdlyf8XBUvlc0vgpTIvQ6at3qrzTLoWk9ki/ADTi2RTEw6yG28uv47nbY5/7+M
/pTe956aMackhdM3AERqItHNBOlT0/yus6IOgycYSPg6vZmPMSrEqoiItXQ8qiY3
1i1xcVIqyP5BFOFaXcS9Rmk/HhkqLPD3xwTsC2VwIqGrU5JGsbT/zwRgaqd3t+KK
UmSXjN7muc5FaKLwMYnQUYHu7lgf3BG4AojcYYvU1Zbhr2YzGsKz1+FGXPReeHK5
eBaAXzoKlaWIHM2UwbPkRIhghYlUiffoOjU9IhwqPEdSSjzDAHqKmNzpiLI4SwO+
whNBhq8jI8x0ApwQmQA8f69aZSG8WGz2xDua0FrPiVRpY1Y29r+7A9GTICah1vm5
4QCoYFK7gu6fzdAOyi5+enpNrrnwkgF08ARTn96jid3hLQcAyIYdaqhJX45h/598
Ckg/+LILKpcZSUwI8PKz0gIktlFmhW2FxNHyQDEP2Ugmw444bdRIS88TXjMfYjZK
KPnkeZpsPgB4jRelNAxK/6n5c2p77as5Kj8t0hZr4orNpDeOv3wDQ9tz3iMs+uQK
HU9/dtd3a+q6txJTjQw0
=puyn
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--
