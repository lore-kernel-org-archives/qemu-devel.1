Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqt8B-0004S9-MV
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqt88-0002xB-JY
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:41:59 -0400
Date: Sun, 10 Sep 2017 13:41:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910034141.GC2735@umbus.fritz.box>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
	<150456162500.17000.8195671755736683016.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chE8DYtGH5bd9Y2b"
Content-Disposition: inline
In-Reply-To: <150456162500.17000.8195671755736683016.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/4] spapr: introduce a helper to compute
 the address of the HPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>


--chE8DYtGH5bd9Y2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Sep 04, 2017 at 11:47:05PM +0200, Greg Kurz wrote:
> The formula used to compute the address of the HPT allocated by QEMU is
> open-coded in several places. This patch moves the magic to a dedicated
> helper. While here, we also patch the callers to only pass the address
> to KVM if we indeed have a userland HPT (ie, KVM PR).

The helper function seems reasonable, though I'm not sure about the
name (a. it's not just a pointer, since it includes the encoded size
and b. the name doesn't indicate this is basically KVM PR specific).

THe "only pass the address to KVM if we indeed have a userland HPT
(ie, KVM PR)" bit doesn't really work.  You're doing it by testing for
(sdr1 !=3D 0), but that can only be true if the HPT is minimum size,
which doesn't have much to do with anything meaningful.

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c          |    9 +++++++++
>  hw/ppc/spapr_cpu_core.c |   12 +++++++-----
>  hw/ppc/spapr_hcall.c    |   14 ++++++++------
>  include/hw/ppc/spapr.h  |    1 +
>  4 files changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index caffa1276328..bf24c26b756d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1290,6 +1290,15 @@ static void spapr_store_hpte(PPCVirtualHypervisor =
*vhyp, hwaddr ptex,
>      }
>  }
> =20
> +target_ulong spapr_get_hpt_pointer(sPAPRMachineState *spapr)
> +{
> +    if (!spapr->htab) {
> +        return 0;
> +    }
> +
> +    return (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shift - 1=
8);
> +}
> +
>  int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
>  {
>      int shift;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 85037ef71e27..581eb4d92de9 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -93,11 +93,13 @@ static void spapr_cpu_reset(void *opaque)
>       * HPT
>       */
>      if (kvm_enabled()) {
> -        env->spr[SPR_SDR1] =3D (target_ulong)(uintptr_t)spapr->htab
> -            | (spapr->htab_shift - 18);
> -        if (kvmppc_put_books_sregs(cpu) < 0) {
> -            error_report("Unable to update SDR1 in KVM");
> -            exit(1);
> +        target_ulong sdr1 =3D spapr_get_hpt_pointer(spapr);
> +        if (sdr1) {
> +            env->spr[SPR_SDR1] =3D sdr1;
> +            if (kvmppc_put_books_sregs(cpu) < 0) {
> +                error_report("Unable to update SDR1 in KVM");
> +                exit(1);
> +            }
>          }
>      }
>  }
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6ab8c188f381..06059b44ab40 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -735,9 +735,10 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *=
cpu,
> =20
>          if (kvm_enabled()) {
>              /* For KVM PR, update the HPT pointer */
> -            target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->htab
> -                | (spapr->htab_shift - 18);
> -            kvmppc_update_sdr1(sdr1);
> +            target_ulong sdr1 =3D spapr_get_hpt_pointer(spapr);
> +            if (sdr1) {
> +                kvmppc_update_sdr1(sdr1);
> +            }
>          }
> =20
>          pending->hpt =3D NULL; /* so it's not free()d */
> @@ -1566,9 +1567,10 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>              spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
>              if (kvm_enabled()) {
>                  /* For KVM PR, update the HPT pointer */
> -                target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->ht=
ab
> -                    | (spapr->htab_shift - 18);
> -                kvmppc_update_sdr1(sdr1);
> +                target_ulong sdr1 =3D spapr_get_hpt_pointer(spapr);
> +                if (sdr1) {
> +                    kvmppc_update_sdr1(sdr1);
> +                }
>              }
>          }
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c1b365f56431..a1f5edc15018 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -709,4 +709,5 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
>  int spapr_vcpu_id(PowerPCCPU *cpu);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
> +target_ulong spapr_get_hpt_pointer(sPAPRMachineState *spapr);
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--chE8DYtGH5bd9Y2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0tHEACgkQbDjKyiDZ
s5K28w//YNHzgy1qWWagqXCcPduu5U65UEOeC44HS5z3x+MhwgDA4KWKIiAGdQ9y
32O+L0R5aYgKBuAIjKHZYX8JwUp4uLV8q0bkNy0RwWrvkMJhQziwYdvg3zX3+4SL
Vrh0kc2CNKIYoOGZXC67WYCz5Q4rfaKYFVMu/34kXPBWzbwuo567M14xcjqYQkyX
ZuUysbPspDkC7YRWOgndqZ92BBj1jxATiOsII0C93kTH9jlk6MeiaX+11GqsvMKR
7WiGDwdsFkUPUZr45lOlgc3uSnl/wgQX2Upd5/8NT1qIOFPEl2MJgWIQcJHO99/E
llK4oy/6PgbR/qW/cc7UP/ocuS5WK1sal8A4tCVAex01zgFZ43On+Iv/Hzo4v67H
35L1HxSma4uxGxLL0u0TpC6hibpiwxU7nJHueXLqY48z1OYx2AMd8EEeQG5P6EX+
BxjZYxPVLV3iMM83j6Rdwxk9AZVz28l/ojetM5i9yRc2WunuJ3f4C7FKlZYsUhJt
YSklF7if7yRKGQrBEdcw3gn3GZz2hXS0MUePgXhJuumS0F2oHsLWnbiIZ/4bCGf0
uNhDp5tyuAlwYFjXjI+wEatz0jN4lQ2JAJnK+aS+aSSLuI2Z1schRfMaVIlVnYM0
NQi+okEPEddcDwl6/2YU7HkPrHw4kLC3z7pIyctVAoXnK7dJphQ=
=egx+
-----END PGP SIGNATURE-----

--chE8DYtGH5bd9Y2b--
