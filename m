Received: from eggs.gnu.org ([2001:4830:134:3::10]:53433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSX3m-0005TZ-V6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSX3l-0006XE-Pw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:21:18 -0400
Date: Tue, 12 Jun 2018 10:05:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612000509.GI2737@umbus.fritz.box>
References: <20180611162310.19968-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <20180611162310.19968-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] xics_kvm: use KVM helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 06:23:10PM +0200, C=E9dric Le Goater wrote:
> The KVM helpers hide the low level interface used to communicate to
> the XICS KVM device and provide a good cleanup to the XICS KVM models.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/intc/xics_kvm.c | 52 ++++++++++++++----------------------------------=
----
>  1 file changed, 14 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 89fb20e2c55c..8bdf6afe82a0 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -56,10 +56,6 @@ static QLIST_HEAD(, KVMEnabledICP)
>  static void icp_get_kvm_state(ICPState *icp)
>  {
>      uint64_t state;
> -    struct kvm_one_reg reg =3D {
> -        .id =3D KVM_REG_PPC_ICP_STATE,
> -        .addr =3D (uintptr_t)&state,
> -    };
>      int ret;
> =20
>      /* ICP for this CPU thread is not in use, exiting */
> @@ -67,7 +63,7 @@ static void icp_get_kvm_state(ICPState *icp)
>          return;
>      }
> =20
> -    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_GET_ONE_REG, &reg);
> +    ret =3D kvm_get_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
>      if (ret !=3D 0) {
>          error_report("Unable to retrieve KVM interrupt controller state"
>                  " for CPU %ld: %s", kvm_arch_vcpu_id(icp->cs), strerror(=
errno));
> @@ -96,10 +92,6 @@ static void icp_synchronize_state(ICPState *icp)
>  static int icp_set_kvm_state(ICPState *icp, int version_id)
>  {
>      uint64_t state;
> -    struct kvm_one_reg reg =3D {
> -        .id =3D KVM_REG_PPC_ICP_STATE,
> -        .addr =3D (uintptr_t)&state,
> -    };
>      int ret;
> =20
>      /* ICP for this CPU thread is not in use, exiting */
> @@ -111,7 +103,7 @@ static int icp_set_kvm_state(ICPState *icp, int versi=
on_id)
>          | ((uint64_t)icp->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT)
>          | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT=
);
> =20
> -    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_SET_ONE_REG, &reg);
> +    ret =3D kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
>      if (ret !=3D 0) {
>          error_report("Unable to restore KVM interrupt controller state (=
0x%"
>                  PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(icp-=
>cs),
> @@ -185,21 +177,15 @@ static const TypeInfo icp_kvm_info =3D {
>  static void ics_get_kvm_state(ICSState *ics)
>  {
>      uint64_t state;
> -    struct kvm_device_attr attr =3D {
> -        .flags =3D 0,
> -        .group =3D KVM_DEV_XICS_GRP_SOURCES,
> -        .addr =3D (uint64_t)(uintptr_t)&state,
> -    };
>      int i;
> +    Error *local_err =3D NULL;
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> -        int ret;
> -
> -        attr.attr =3D i + ics->offset;
> =20
> -        ret =3D ioctl(kernel_xics_fd, KVM_GET_DEVICE_ATTR, &attr);
> -        if (ret !=3D 0) {
> +        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> +                          i + ics->offset, &state, false, &local_err);
> +        if (local_err) {
>              error_report("Unable to retrieve KVM interrupt controller st=
ate"
>                      " for IRQ %d: %s", i + ics->offset, strerror(errno));
>              exit(1);
> @@ -255,19 +241,13 @@ static void ics_synchronize_state(ICSState *ics)
>  static int ics_set_kvm_state(ICSState *ics, int version_id)
>  {
>      uint64_t state;
> -    struct kvm_device_attr attr =3D {
> -        .flags =3D 0,
> -        .group =3D KVM_DEV_XICS_GRP_SOURCES,
> -        .addr =3D (uint64_t)(uintptr_t)&state,
> -    };
>      int i;
> +    Error *local_err =3D NULL;
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
>          int ret;
> =20
> -        attr.attr =3D i + ics->offset;
> -
>          state =3D irq->server;
>          state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MA=
SK)
>              << KVM_XICS_PRIORITY_SHIFT;
> @@ -293,8 +273,9 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
>                  state |=3D KVM_XICS_QUEUED;
>          }
> =20
> -        ret =3D ioctl(kernel_xics_fd, KVM_SET_DEVICE_ATTR, &attr);
> -        if (ret !=3D 0) {
> +        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> +                          i + ics->offset, &state, true, &local_err);
> +        if (local_err) {
>              error_report("Unable to restore KVM interrupt controller sta=
te"
>                      " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
>              return ret;
> @@ -391,10 +372,6 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
>  {
>      int rc;
> -    struct kvm_create_device xics_create_device =3D {
> -        .type =3D KVM_DEV_TYPE_XICS,
> -        .flags =3D 0,
> -    };
> =20
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
>          error_setg(errp,
> @@ -431,20 +408,19 @@ int xics_kvm_init(sPAPRMachineState *spapr, Error *=
*errp)
>          goto fail;
>      }
> =20
> -    /* Create the kernel ICP */
> -    rc =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &xics_create_devic=
e);
> +    /* Create the KVM XICS device */
> +    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
>      if (rc < 0) {
>          error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for XICS=
");
>          goto fail;
>      }
> =20
> -    kernel_xics_fd =3D xics_create_device.fd;
> -
> +    kernel_xics_fd =3D rc;
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> =20
> -    return rc;
> +    return 0;
> =20
>  fail:
>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfDjAACgkQbDjKyiDZ
s5Lcbg//egZHZPkDRpJm+DVhj0Ooar/8pFx8DvC/uYmnyGYK/P6YK5jCHxTPjVzY
nmxfdfleubGn4ODFQ9qsHxwLeclAAk1PKUHZbwIHpAoUbMrsxtcT80qoe2b22RVe
sBNr9fHMQHCfYeVyfsCCpmZAqccCHKfSfsNZDdWAIfi+0DJgrUtNsL0DNzm/oDFv
rHXyo+Vgr6zEUdjYxWwxqatG+sP7zM83c6og53Juo3Porfn65RVC7/Pn8H6I13W0
lc05rA3ZNzajJ/BdsThIkBoS1LixWQWyYBqc2cAAzHnz+xuUo8z6+eLTPNZ+/J7M
QqO0Pslc0UvahW9TvNFqWLmC4HO7Y+VkZUBJlHMps31P/Q9eP6AR5FKNHeUdLCA8
oeqYPdkyUDWdw23lnR6UPJukdDQvZs2ndrnWt3N3LfTL2Bxuu4XS/uDr5nkvq5Z2
gmF2GV70OoPq5cT6LMRWD7xE/SrmHVDboSJnW0/4t9bqrw2KTBcSPUyFxvTbq5ky
ZL5A2VLTsczQ5SKzH25nFoa94McIBG1pE7pntLzkAAE2DCLc7x/lEo2DvZ8Il2sU
3xd194ibqeKvP98HJpfWKoSgKXrFQCd0FK95tZQU7MPFPNC7LuLyEC0BL1JElN/X
71If8/Pcq2TfXpgQh2q4rRZ+pFSQ3Xpc506l7nv9BAdIJYsqYNY=
=ebzN
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
