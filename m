Received: from eggs.gnu.org ([209.51.188.92]:42897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG6-0007XE-JV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG3-0000Kr-MT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:13 -0500
Date: Tue, 12 Feb 2019 11:58:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212005818.GE1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-11-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 10/13] spapr: introduce routines to delete
 the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:43PM +0100, C=E9dric Le Goater wrote:
> If a new interrupt mode is chosen by CAS, the machine generates a
> reset to reconfigure. At this point, the connection with the previous
> KVM device needs to be closed and a new connection needs to opened
> with the KVM device operating the chosen interrupt mode.
>=20
> New routines are introduced to destroy the XICS and the XIVE KVM
> devices. They make use of a new KVM device ioctl which destroys the
> device and also disconnects the IRQ presenters from the vCPUs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Looks reasonable.

> ---
>  include/hw/ppc/spapr_xive.h |  1 +
>  include/hw/ppc/xics.h       |  1 +
>  hw/intc/spapr_xive_kvm.c    | 60 +++++++++++++++++++++++++++++++++++++
>  hw/intc/xics_kvm.c          | 57 +++++++++++++++++++++++++++++++++++
>  4 files changed, 119 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 52804516e909..f172fc20b650 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -70,6 +70,7 @@ void spapr_xive_map_mmio(sPAPRXive *xive);
>   * KVM XIVE device helpers
>   */
>  void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
> +void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp);
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp);
>  int kvmppc_xive_pre_save(sPAPRXive *xive);
>  int kvmppc_xive_post_load(sPAPRXive *xive, int version_id);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 07508cbd217e..75d4effb5c5f 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -205,6 +205,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> +int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp);
>  void xics_spapr_init(sPAPRMachineState *spapr);
> =20
>  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index fe58a9ee32d3..93ea8e71047a 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -57,6 +57,16 @@ static void kvm_cpu_enable(CPUState *cs)
>      QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
>  }
> =20
> +static void kvm_cpu_disable_all(void)
> +{
> +    KVMEnabledCPU *enabled_cpu, *next;
> +
> +    QLIST_FOREACH_SAFE(enabled_cpu, &kvm_enabled_cpus, node, next) {
> +        QLIST_REMOVE(enabled_cpu, node);
> +        g_free(enabled_cpu);
> +    }
> +}
> +
>  /*
>   * XIVE Thread Interrupt Management context (KVM)
>   */
> @@ -769,3 +779,53 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
>      /* Map all regions */
>      spapr_xive_map_mmio(xive);
>  }
> +
> +void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp)
> +{
> +    XiveSource *xsrc;
> +    struct kvm_create_device xive_destroy_device =3D { 0 };
> +    size_t esb_len;
> +    int rc;
> +
> +    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
> +        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
> +        return;
> +    }
> +
> +    /* The KVM XIVE device is not in use */
> +    if (!xive || xive->fd =3D=3D -1) {
> +        return;
> +    }
> +
> +    /* Clear the KVM mapping */
> +    xsrc =3D &xive->source;
> +    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +
> +    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 0);
> +    munmap(xsrc->esb_mmap, esb_len);
> +
> +    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 1);
> +
> +    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 2);
> +    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
> +
> +    /* Destroy the KVM device. This also clears the VCPU presenters */
> +    xive_destroy_device.fd =3D xive->fd;
> +    xive_destroy_device.type =3D KVM_DEV_TYPE_XIVE;
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xive_destroy_dev=
ice);
> +    if (rc < 0) {
> +        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIV=
E");
> +    }
> +    close(xive->fd);
> +    xive->fd =3D -1;
> +
> +    kvm_kernel_irqchip =3D false;
> +    kvm_msi_via_irqfd_allowed =3D false;
> +    kvm_gsi_direct_mapping =3D false;
> +
> +    /* Clear the local list of presenter (hotplug) */
> +    kvm_cpu_disable_all();
> +
> +    /* VM Change state handler is not needed anymore */
> +    qemu_del_vm_change_state_handler(xive->change);
> +}
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 2426e5b2f4ed..da6a00bc88cc 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -50,6 +50,16 @@ typedef struct KVMEnabledICP {
>  static QLIST_HEAD(, KVMEnabledICP)
>      kvm_enabled_icps =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_icps);
> =20
> +static void kvm_disable_icps(void)
> +{
> +    KVMEnabledICP *enabled_icp, *next;
> +
> +    QLIST_FOREACH_SAFE(enabled_icp, &kvm_enabled_icps, node, next) {
> +        QLIST_REMOVE(enabled_icp, node);
> +        g_free(enabled_icp);
> +    }
> +}
> +
>  /*
>   * ICP-KVM
>   */
> @@ -455,6 +465,53 @@ fail:
>      return -1;
>  }
> =20
> +int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp)
> +{
> +    int rc;
> +    struct kvm_create_device xics_create_device =3D {
> +        .fd =3D kernel_xics_fd,
> +        .type =3D KVM_DEV_TYPE_XICS,
> +        .flags =3D 0,
> +    };
> +
> +    /* The KVM XICS device is not in use */
> +    if (kernel_xics_fd =3D=3D -1) {
> +        return 0;
> +    }
> +
> +    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
> +        error_setg(errp,
> +                   "KVM and IRQ_XICS capability must be present for KVM =
XICS device");
> +        return -1;
> +    }
> +
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xics_create_devi=
ce);
> +    if (rc < 0) {
> +        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIC=
S");
> +    }
> +    close(kernel_xics_fd);
> +    kernel_xics_fd =3D -1;
> +
> +    spapr_rtas_register(RTAS_IBM_SET_XIVE, NULL, 0);
> +    spapr_rtas_register(RTAS_IBM_GET_XIVE, NULL, 0);
> +    spapr_rtas_register(RTAS_IBM_INT_OFF, NULL, 0);
> +    spapr_rtas_register(RTAS_IBM_INT_ON, NULL, 0);
> +
> +    kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
> +    kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
> +    kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
> +    kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
> +
> +    kvm_kernel_irqchip =3D false;
> +    kvm_msi_via_irqfd_allowed =3D false;
> +    kvm_gsi_direct_mapping =3D false;
> +
> +    /* Clear the presenter from the VCPUs */
> +    kvm_disable_icps();
> +
> +    return rc;
> +}
> +
>  static void xics_kvm_register_types(void)
>  {
>      type_register_static(&ics_kvm_info);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiGicACgkQbDjKyiDZ
s5Kxdw/6AlSjtR573788ittvkWRyo1+VH3thBGtKxChN0smPlZIIcFdpK9HJcYay
zXiik0KPP2LhS1gcodJZdpalia+UEGLCkCIypuESf53hjPDKG6QmRQ8Vo18M1e+8
IfY4fKDbl1lyi8IfE7BR43H2YAKyoGU2RaTQL9VoDihHvq7dRXUwX2loiwaRzqS8
v5y3tKZTLGDW0DFxYvEcIfe4unNrtWcLgqr+4pCMa0VcU3MVtQiz5UD1kH8zwJue
ZKdjHgYyTbvOD25S3+U7YzBk/E+nrl4LRH79rXngnQoy44SEgBvuAkw2WKRAmhFv
41+jpwUiw9pRYl8UEMqJSy95VOYwhDdg20a4v+xT5oghimDbMvRaOTEWgNbnLVXd
ZpImJowpWZ666RZ3NeZbw1jjLJ9X96P1zv2mjBY15OHgHQcTU5pgcdIeeGt7/Iix
hY6v33WL36jObP4b/6SnMUh9QR8pKFaWPIyU0Jg2ERnMu344Pu3OfMMONT6rDYau
Hbu6eMbvtBknu5pqPbxlu0Tuwlipe1k+cmUlA3L08wYN9dfmwSWKl4HWpnYvniO2
pvwRilqYtlU40ttJwu6n0gjm1YP48Hj0xKO6JHjs+bQlIUsjGfjbQ696w5RI2QLH
38KL6EVE2NOssJttWk6sW2k/ot7PHnhChDPohktDsdumAtgEfMU=
=NSgx
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
