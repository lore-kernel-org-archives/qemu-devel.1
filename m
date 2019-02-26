Received: from eggs.gnu.org ([209.51.188.92]:41592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFc-00075m-W5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFb-0006ru-EK
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Date: Tue, 26 Feb 2019 12:10:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226011018.GH6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-11-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 10/13] spapr: introduce routines to
 delete the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:19PM +0100, C=E9dric Le Goater wrote:
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

Ugly, but necessary

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_xive.h |  1 +
>  include/hw/ppc/xics_spapr.h |  1 +
>  hw/intc/spapr_xive_kvm.c    | 60 +++++++++++++++++++++++++++++++++++++
>  hw/intc/xics_kvm.c          | 56 ++++++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 22d70650b51f..a7c4c275a747 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -71,6 +71,7 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t =
end_idx,
>   * KVM XIVE device helpers
>   */
>  void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
> +void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp);
>  void kvmppc_xive_reset(sPAPRXive *xive, Error **errp);
>  void kvmppc_xive_set_source_config(sPAPRXive *xive, uint32_t lisn, XiveE=
AS *eas,
>                                     Error **errp);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index b8d924baf437..bddf09821cb0 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -34,6 +34,7 @@
>  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> +int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp);
>  void xics_spapr_init(sPAPRMachineState *spapr);
> =20
>  #endif /* XICS_SPAPR_H */
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 119fd59fc9ae..e31035c90260 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -58,6 +58,16 @@ static void kvm_cpu_enable(CPUState *cs)
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
> @@ -674,3 +684,53 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
>      /* Map all regions */
>      spapr_xive_map_mmio(xive);
>  }
> +
> +void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp)
> +{
> +    XiveSource *xsrc;
> +    struct kvm_destroy_device xive_destroy_device;
> +    size_t esb_len;
> +    int rc;
> +
> +    /* The KVM XIVE device is not in use */
> +    if (!xive || xive->fd =3D=3D -1) {
> +        return;
> +    }
> +
> +    if (!kvmppc_has_cap_xive()) {
> +        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
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
> +    xive_destroy_device.flags =3D 0;
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
> index c6e1b630a404..373de3155f6b 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -51,6 +51,16 @@ typedef struct KVMEnabledICP {
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
> @@ -360,3 +370,49 @@ fail:
>      kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
>      return -1;
>  }
> +
> +int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp)
> +{
> +    int rc;
> +    struct kvm_destroy_device xics_destroy_device =3D {
> +        .fd =3D kernel_xics_fd,
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
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xics_destroy_dev=
ice);
> +    if (rc < 0) {
> +        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIC=
S");
> +    }
> +    close(kernel_xics_fd);
> +    kernel_xics_fd =3D -1;
> +
> +    spapr_rtas_unregister(RTAS_IBM_SET_XIVE);
> +    spapr_rtas_unregister(RTAS_IBM_GET_XIVE);
> +    spapr_rtas_unregister(RTAS_IBM_INT_OFF);
> +    spapr_rtas_unregister(RTAS_IBM_INT_ON);
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0kfoACgkQbDjKyiDZ
s5Lkbw/5ATCrMm9idDtP3LovfB/k8q5EzzDU7wAP9cuBif5/xIp3pQG/kL9VN1JE
X9lM0KXjlB5rxBMZ90n1GK0qfv3aQnmGjS7d4n4JX4EUM55Z2XTNhbunhHoCnvVx
1Qa1GkWhlnYtrgZ0zNuBUBxlI8/Y3jJojsFzdAScS4FMhuOFlL2YubGFKZEbNMx0
6cYMbf1opTK5t55d4wF0vlYiwEu4aJu1JIPSRWYvwiBYzWYcKB/oPj42f1ygPdmq
QRdYglpevIrgz25sxN5rK4/Zr9xRE0IxeTWWuoEto4accOPrxoxyUD4/Y9aXkL+k
B+KjUL15/aBBguJ1hcSLKGcCJn4PK9eYvE0SzKRi3vmFGYdD6uimaRtFytmffOXB
VP0V4Htc4qVYXXK16Id3J76yCATjROHBt97EAAuP9gpbq8DLaUcscgkHpI3kjTyI
HL9WdTGQeUXIlRUG0eNgFXVpYelg5+EwJjBDfucTXqJ5VK18HK+M/jKrwayxTCOA
xpQux3h2Ziaagl7m7hpasIJutnEx9BNdmNkb+Z8mnI5lwesUxBsSUA7vm+MIzGd9
17f+8hvPV/Ip7ndD17xR0I2iMdcSk6PwBHhJ+FvYWrbLjEM8Lfkx9dCwe5qxqCs/
CLcUKb4MdJ1CLZEa91K+GAe4XTGZGVq2Y9R9DhNvSoYuHIC3ms4=
=fJ4c
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
