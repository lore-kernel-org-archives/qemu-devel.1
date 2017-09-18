Received: from eggs.gnu.org ([2001:4830:134:3::10]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtS-0001A6-HC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002mi-BA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:42 -0400
Date: Tue, 19 Sep 2017 07:23:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918212316.GC27153@umbus>
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
	<150548137066.5945.3950849052176752689.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <150548137066.5945.3950849052176752689.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc/kvm: change kvmppc_get_htab_fd()
 to return -errno on error
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


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 03:16:10PM +0200, Greg Kurz wrote:
> When kvmppc_get_htab_fd() fails, its return value is propagated up to
> qemu_savevm_state_iterate() or to qemu_savevm_state_complete_precopy().
> All savevm handlers expect to receive a negative errno on error.
>=20
> Let's patch kvmppc_get_htab_fd() accordingly.
>=20
> While here, let's change htab_load() in the spapr code to also
> propagate the error, since it doesn't make sense to abort() if
> we couldn't get the htab fd from KVM.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr.c   |    5 +++--
>  target/ppc/kvm.c |   10 ++++++++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 841117f6d185..1ae79326d1ac 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1218,7 +1218,7 @@ static int get_htab_fd(sPAPRMachineState *spapr)
>      spapr->htab_fd =3D kvmppc_get_htab_fd(false);
>      if (spapr->htab_fd < 0) {
>          error_report("Unable to open fd for reading hash table from KVM:=
 %s",
> -                     strerror(errno));
> +                     strerror(spapr->htab_fd));
>      }
> =20
>      return spapr->htab_fd;
> @@ -1962,7 +1962,8 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
>          fd =3D kvmppc_get_htab_fd(true);
>          if (fd < 0) {
>              error_report("Unable to open fd to restore KVM hash table: %=
s",
> -                         strerror(errno));
> +                         strerror(fd));
> +            return fd;
>          }
>      }
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 00d7029b8d7a..09d7dea79e2d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2556,13 +2556,19 @@ int kvmppc_get_htab_fd(bool write)
>          .flags =3D write ? KVM_GET_HTAB_WRITE : 0,
>          .start_index =3D 0,
>      };
> +    int ret;
> =20
>      if (!cap_htab_fd) {
>          fprintf(stderr, "KVM version doesn't support saving the hash tab=
le\n");
> -        return -1;
> +        return -ENOTSUP;
> +    }
> +
> +    ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &s);
> +    if (ret < 0) {
> +        return -errno;
>      }
> =20
> -    return kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &s);
> +    return ret;
>  }
> =20
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAOUEACgkQbDjKyiDZ
s5IERhAAlheET4e39ljOKTu1OWu16ISJ58QqO7ERD4oef1ql6P0HlnM0Y1zpDAQh
I7ZGeNHf3Jn7Qfp9P0dvQXgTSL07bHevmySArtZFPIfAAfwLPkCa0oc4CqXojSxR
sNFZIqL0hPxYRB3IqnnotZqK0ObHqODmVuVNiqPlZkb3ZwLucLOcqCSla50AJZms
xWoEnD5+VuaKWuaLndIEdAFKkrnHrDAKrUSswMBOhe1QuhgRCg51Vdw0ahURpPt3
O27QqdCjnfkOWQ8SL5CSYpy7A85QqOVX3bRW8INqPFtrMT/qAohQ1Ub7YGrPQc6p
HLouur/vR4PGoKyB4kEKUKkpAKe6wD1AuTZCTfSoORGO6Y9l2Um44YYXLb9F1Up8
3ifkoNoA0gQxLqgT7z59Z/ThcbR4YTVw+b3o7rMaUxmZsDaFSAQJAwVMQO/SUtf/
kpb26nvYfgevxwHlCbbp09GGk+CrQCJ1KZ8HwjOKmcMQgRB4x2QAD9absx13VYJb
Hqzwi2YPoku4qV2R0yCMr9vNIim3SYc8ugG4NXecmuzadpKWzMHn9sQ74pBncSMr
GqIan/AGN6Bi1P/3Wh+kZ/aqP51YOmu1I8Yrg1Wl4bgesNK579ZpTcadrNc0DV9Z
XMdWXzuUvi5nC5zQ1ih8mZmeLk/vEjeS+kaWNQg3HF09O8ndBJU=
=SFRP
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
