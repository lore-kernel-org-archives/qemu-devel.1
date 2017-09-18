Received: from eggs.gnu.org ([2001:4830:134:3::10]:51087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0001D1-K0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002no-UB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:43 -0400
Date: Tue, 19 Sep 2017 07:23:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918212329.GD27153@umbus>
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
	<150548138021.5945.4408791416827487125.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <150548138021.5945.4408791416827487125.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc/kvm: generalize the use of
 kvmppc_get_htab_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 03:16:20PM +0200, Greg Kurz wrote:
> The use of KVM_PPC_GET_HTAB_FD is open-coded in kvmppc_read_hptes()
> and kvmppc_write_hpte().
>=20
> This patch modifies kvmppc_get_htab_fd() so that it can be used
> everywhere we need to access the in-kernel htab:
> - add an index argument
>   =3D> only kvmppc_read_hptes() passes an actual index, all other users
>      pass 0
> - add an errp argument to propagate error messages to the caller.
>   =3D> spapr migration code prints the error
>   =3D> hpte helpers pass &error_abort to keep the current behavior
>      of hw_error()
>=20
> While here, this also fixes a bug in kvmppc_write_hpte() so that it
> opens the htab fd for writing instead of reading as it currently does.
> This never broke anything because we currently never call this code,
> as explained in the changelog of commit c1385933804bb:
>=20
> "This support updating htab managed by the hypervisor. Currently
>  we don't have any user for this feature. This actually bring the
>  store_hpte interface in-line with the load_hpte one. We may want
>  to use this when we want to emulate henter hcall in qemu for HV
>  kvm."
>=20
> The above is still true today.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr.c       |   15 +++++++--------
>  target/ppc/kvm.c     |   27 +++++++++------------------
>  target/ppc/kvm_ppc.h |    4 ++--
>  3 files changed, 18 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1ae79326d1ac..eeef549fbc15 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1211,14 +1211,15 @@ static uint64_t spapr_get_patbe(PPCVirtualHypervi=
sor *vhyp)
>   */
>  static int get_htab_fd(sPAPRMachineState *spapr)
>  {
> +    Error *local_err =3D NULL;
> +
>      if (spapr->htab_fd >=3D 0) {
>          return spapr->htab_fd;
>      }
> =20
> -    spapr->htab_fd =3D kvmppc_get_htab_fd(false);
> +    spapr->htab_fd =3D kvmppc_get_htab_fd(false, 0, &local_err);
>      if (spapr->htab_fd < 0) {
> -        error_report("Unable to open fd for reading hash table from KVM:=
 %s",
> -                     strerror(spapr->htab_fd));
> +        error_report_err(local_err);
>      }
> =20
>      return spapr->htab_fd;
> @@ -1931,6 +1932,7 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
>      sPAPRMachineState *spapr =3D opaque;
>      uint32_t section_hdr;
>      int fd =3D -1;
> +    Error *local_err =3D NULL;
> =20
>      if (version_id < 1 || version_id > 1) {
>          error_report("htab_load() bad version");
> @@ -1945,8 +1947,6 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
>      }
> =20
>      if (section_hdr) {
> -        Error *local_err =3D NULL;
> -
>          /* First section gives the htab size */
>          spapr_reallocate_hpt(spapr, section_hdr, &local_err);
>          if (local_err) {
> @@ -1959,10 +1959,9 @@ static int htab_load(QEMUFile *f, void *opaque, in=
t version_id)
>      if (!spapr->htab) {
>          assert(kvm_enabled());
> =20
> -        fd =3D kvmppc_get_htab_fd(true);
> +        fd =3D kvmppc_get_htab_fd(true, 0, &local_err);
>          if (fd < 0) {
> -            error_report("Unable to open fd to restore KVM hash table: %=
s",
> -                         strerror(fd));
> +            error_report_err(local_err);
>              return fd;
>          }
>      }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 09d7dea79e2d..c37d74941085 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2550,21 +2550,25 @@ int kvmppc_define_rtas_kernel_token(uint32_t toke=
n, const char *function)
>      return kvm_vm_ioctl(kvm_state, KVM_PPC_RTAS_DEFINE_TOKEN, &args);
>  }
> =20
> -int kvmppc_get_htab_fd(bool write)
> +int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp)
>  {
>      struct kvm_get_htab_fd s =3D {
>          .flags =3D write ? KVM_GET_HTAB_WRITE : 0,
> -        .start_index =3D 0,
> +        .start_index =3D index,
>      };
>      int ret;
> =20
>      if (!cap_htab_fd) {
> -        fprintf(stderr, "KVM version doesn't support saving the hash tab=
le\n");
> +        error_setg(errp, "KVM version doesn't support %s the HPT",
> +                   write ? "writing" : "reading");
>          return -ENOTSUP;
>      }
> =20
>      ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &s);
>      if (ret < 0) {
> +        error_setg(errp, "Unable to open fd for %s HPT %s KVM: %s",
> +                   write ? "writing" : "reading", write ? "to" : "from",
> +                   strerror(errno));
>          return -errno;
>      }
> =20
> @@ -2648,17 +2652,10 @@ void kvm_arch_init_irq_routing(KVMState *s)
> =20
>  void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n)
>  {
> -    struct kvm_get_htab_fd ghf =3D {
> -        .flags =3D 0,
> -        .start_index =3D ptex,
> -    };
>      int fd, rc;
>      int i;
> =20
> -    fd =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
> -    if (fd < 0) {
> -        hw_error("kvmppc_read_hptes: Unable to open HPT fd");
> -    }
> +    fd =3D kvmppc_get_htab_fd(false, ptex, &error_abort);
> =20
>      i =3D 0;
>      while (i < n) {
> @@ -2700,19 +2697,13 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, h=
waddr ptex, int n)
>  void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
>  {
>      int fd, rc;
> -    struct kvm_get_htab_fd ghf;
>      struct {
>          struct kvm_get_htab_header hdr;
>          uint64_t pte0;
>          uint64_t pte1;
>      } buf;
> =20
> -    ghf.flags =3D 0;
> -    ghf.start_index =3D 0;     /* Ignored */
> -    fd =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
> -    if (fd < 0) {
> -        hw_error("kvmppc_write_hpte: Unable to open HPT fd");
> -    }
> +    fd =3D kvmppc_get_htab_fd(true, 0 /* Ignored */, &error_abort);
> =20
>      buf.hdr.n_valid =3D 1;
>      buf.hdr.n_invalid =3D 0;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 08aab46c5a56..349f892631bf 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -51,7 +51,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigne=
d int hash_shift);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function=
);
> -int kvmppc_get_htab_fd(bool write);
> +int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns=
);
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
>                             uint16_t n_valid, uint16_t n_invalid);
> @@ -245,7 +245,7 @@ static inline int kvmppc_define_rtas_kernel_token(uin=
t32_t token,
>      return -1;
>  }
> =20
> -static inline int kvmppc_get_htab_fd(bool write)
> +static inline int kvmppc_get_htab_fd(bool write, uint64_t index, Error *=
*errp)
>  {
>      return -1;
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAOVEACgkQbDjKyiDZ
s5I9HBAAxs1Id5MmvIajNhfuypvpPKiwwrJhvKrwJP74FsRDdg9ziZAodbHSZNAs
5mDreBUu717mvwnpJ3t1s3ojJVOTA2gKPwhAyVyaob4cGlYaiUjvmyjPvSHPKSW6
PmvCTizaADMpCUDKnXQCPwJAsFU40uTJY8H0pbvtCALColQo8wuvv1pdUpD0ZnHx
33WhBOP+Gi/dq7b7yObEBTVMn4uoqhnLhTPV+Kz0sg0EDg/QUVih3Q3xXS8MTJJA
r6k3zJEkFfmRGXZUqs7rEoI3impeZ4fUAT6Fiowenb4/KHglNEN9CYAwgHqiCu+k
aCQtgELolwCLakgD++nl+opMIsQGJ2Ywb84CmouFJEvM9YxCvJViofbOGOdK/pC7
daqGy30LXj+YK/LHkCHxlD1qr7+fnOTrfR3fnEgAeX9PIQCzZfkJ0tIqa9YryrBC
x1Xp5ZFqV8QdLxOtpbf6wK8GDxXg/xXNIQipNM2Yc+lK+XPMHVmFcJS3oAC8Hgfz
Q1nCvNnDSdjTrDsfBNcfDs8n6JUwrNm4cYfdK7R/IYtiZBqdWjm3XZ0Z+TSQntt4
FkGh57+1LmOzFV5uG/6sF5iyfkFRvJ9+9lKL+X4dcgEJQGs/KaFPdIwfHy4ZXVWr
RVplGbs9MZJKndZCjRxILwYsep3roX5dfW9sOCoy1mutXUBfjFI=
=6vzy
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
