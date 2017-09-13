Received: from eggs.gnu.org ([2001:4830:134:3::10]:57386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0L7-0005k2-7W
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0L3-0004IY-6z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:35:57 -0400
Date: Wed, 13 Sep 2017 14:40:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913044024.GD7550@umbus.fritz.box>
References: <150525508489.11068.5231444460720976552.stgit@bahia.lan>
	<150525509384.11068.12660058285712851211.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <150525509384.11068.12660058285712851211.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: introduce common helper to
 write HPT address to KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 12:24:53AM +0200, Greg Kurz wrote:
> When running with KVM PR, if a new HPT is allocated we need to inform
> KVM about the HPT address and size. This is currently done with a hack
> which is open-coded in several places.
>=20
> This patch consolidate the code in a dedicated helper that records
> the HPT address and size in the sPAPR context, and then does the
> magic for KVM PR.
>=20
> Note that ppc_spapr_reset() now resets all devices and CPUs before
> allocating the HPT. This allows to drop the hack from spapr_cpu_reset().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I like this more than the previous spin, but while discussing stuff
with SamB, I thought up a different approach, which I think will be
both cleaner and simpler.

It basically doesn't make sense to put the userspace HPT pointer into
env->spr[SDR1], we only do it to make kvmppc_put_books_sregs() do the
right thing.

Instead, we can have kvmppc_put_books_sregs() populate the "SDR1"
field in kvm_sregs from a vhyp hook.  We already have the reverse side
in that kvmppc_get_books_sregs() doesn't update the internal SDR1
value if vhyp is set.

In any case the spapr hook would compute the correct value direct from
spapr->htab.

After incoming migration I'm not sure we need to do anything - I think
we already do a pretty thorough register resync with KVM.

> ---
>  hw/ppc/spapr.c          |   31 ++++++++++++++++++++++++++-----
>  hw/ppc/spapr_cpu_core.c |   15 ---------------
>  hw/ppc/spapr_hcall.c    |   16 +---------------
>  include/hw/ppc/spapr.h  |    1 +
>  4 files changed, 28 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f680f28a15ea..97f8afdbd7fe 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1309,6 +1309,25 @@ void spapr_free_hpt(sPAPRMachineState *spapr)
>      close_htab_fd(spapr);
>  }
> =20
> +void spapr_install_hpt(sPAPRMachineState *spapr, void *htab, uint32_t sh=
ift)
> +{
> +    assert(htab);
> +
> +    spapr->htab =3D htab;
> +    spapr->htab_shift =3D shift;
> +
> +    /*
> +     * This is a hack for the benefit of KVM PR - it abuses the SDR1
> +     * slot in kvm_sregs to communicate the userspace address of the
> +     * HPT
> +     */
> +    if (kvm_enabled()) {
> +        target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->htab
> +            | (spapr->htab_shift - 18);
> +        kvmppc_update_sdr1(sdr1);
> +    }
> +}
> +
>  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>                            Error **errp)
>  {
> @@ -1339,16 +1358,17 @@ void spapr_reallocate_hpt(sPAPRMachineState *spap=
r, int shift,
>          /* kernel-side HPT not needed, allocate in userspace instead */
>          size_t size =3D 1ULL << shift;
>          int i;
> +        void *htab;
> =20
> -        spapr->htab =3D qemu_memalign(size, size);
> -        if (!spapr->htab) {
> +        htab =3D qemu_memalign(size, size);
> +        if (!htab) {
>              error_setg_errno(errp, errno,
>                               "Could not allocate HPT of order %d", shift=
);
>              return;
>          }
> =20
> -        memset(spapr->htab, 0, size);
> -        spapr->htab_shift =3D shift;
> +        memset(htab, 0, size);
> +        spapr_install_hpt(spapr, htab, shift);
> =20
>          for (i =3D 0; i < size / HASH_PTE_SIZE_64; i++) {
>              DIRTY_HPTE(HPTE(spapr->htab, i));
> @@ -1405,6 +1425,8 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> +    qemu_devices_reset();
> +
>      if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
>          /* If using KVM with radix mode available, VCPUs can be started
>           * without a HPT because KVM will start them in radix mode.
> @@ -1414,7 +1436,6 @@ static void ppc_spapr_reset(void)
>          spapr_setup_hpt_and_vrma(spapr);
>      }
> =20
> -    qemu_devices_reset();
>      spapr_clear_pending_events(spapr);
> =20
>      /*
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee7571a50..c20b5c64b045 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -73,7 +73,6 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> =20
>  static void spapr_cpu_reset(void *opaque)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      PowerPCCPU *cpu =3D opaque;
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> @@ -86,20 +85,6 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
> =20
>      env->spr[SPR_HIOR] =3D 0;
> -
> -    /*
> -     * This is a hack for the benefit of KVM PR - it abuses the SDR1
> -     * slot in kvm_sregs to communicate the userspace address of the
> -     * HPT
> -     */
> -    if (kvm_enabled()) {
> -        env->spr[SPR_SDR1] =3D (target_ulong)(uintptr_t)spapr->htab
> -            | (spapr->htab_shift - 18);
> -        if (kvmppc_put_books_sregs(cpu) < 0) {
> -            error_report("Unable to update SDR1 in KVM");
> -            exit(1);
> -        }
> -    }
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57bb411394ed..7892cd3e7ffa 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -730,15 +730,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *=
cpu,
>                      pending->hpt, newsize);
>      if (rc =3D=3D H_SUCCESS) {
>          qemu_vfree(spapr->htab);
> -        spapr->htab =3D pending->hpt;
> -        spapr->htab_shift =3D pending->shift;
> -
> -        if (kvm_enabled()) {
> -            /* For KVM PR, update the HPT pointer */
> -            target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->htab
> -                | (spapr->htab_shift - 18);
> -            kvmppc_update_sdr1(sdr1);
> -        }
> +        spapr_install_hpt(spapr, pending->hpt, pending->shift);
> =20
>          pending->hpt =3D NULL; /* so it's not free()d */
>      }
> @@ -1564,12 +1556,6 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>               * the point this is called, nothing should have been
>               * entered into the existing HPT */
>              spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> -            if (kvm_enabled()) {
> -                /* For KVM PR, update the HPT pointer */
> -                target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->ht=
ab
> -                    | (spapr->htab_shift - 18);
> -                kvmppc_update_sdr1(sdr1);
> -            }
>          }
>      }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c1b365f56431..30e5805acca4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -709,4 +709,5 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
>  int spapr_vcpu_id(PowerPCCPU *cpu);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
> +void spapr_install_hpt(sPAPRMachineState *spapr, void *htab, uint32_t sh=
ift);
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm4trYACgkQbDjKyiDZ
s5Kiuw//bAw88WzzH4vFkRR0viIXoaAtKA0rcWxFmFp/9Xz6jcTKqQoo3dskezG/
5r+w4JhUNL2V4mD97wuVun0+hjjVVDcjKj8DZ6RUgtk0+8SVL6CvjD06jfJsqBcC
BYWKgOLQxCGjqRJwUAZFF3VEqNVqBbkBvnJBrl1oghNL4PUv6Lxhl6bHXNg4WklH
vjdJ1I1SPdpbtBoluFBj+V1YJyPBBSMKzODoRNTk9OJ5vlXY2zn9Su8Tb2sDFNyP
7dqXMzeyzwbCv50w0upHhUw6QU3yeFVDF0WtmXeR49f2MXRlmocGNO6yluYrHsMy
DbLnKiIuXV6twFW0+T5OX8SWaULAkkdAIckj4jAr/X098xNRT2yi0cHSyGoU1cwq
aqM25/AZ5kYQ2XTu+Nk8xzbHX9divCQXPI6XfLjvGTnYb/ckYaUjNSf0XbO+t/T8
uEN+6fNzomq+NDG5vZqPhnrtlyxQAWaMb/4jINfPBvVkKD498A0Fs8n5zWJJbNou
4CQZmFm64PKf8xdV82P77FbjwAD8cgJZhVtGHuiBaxXRV9gop6hrD+QDZe3oqHCu
atPJfmKy7TXRBnFnHQtcUPJBbQz1c8iOiAl0u8SPOm/jleLw0aC3IRtKoFLJRRLr
b25yHDOO6OV8SkUPPg+ExVVul7jqis0+TxsSimqyhbCHhF2egKI=
=X7xl
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
