Received: from eggs.gnu.org ([2001:4830:134:3::10]:35949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxss6-0003Mv-AN
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxss1-0006mo-Mc
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:18:02 -0400
Date: Tue, 11 Apr 2017 17:06:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411070646.GD12900@umbus.fritz.box>
References: <1491374264-26293-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <1491374264-26293-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] spapr: remove the 'nr_servers' field from
 the machine
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


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 08:37:44AM +0200, C=E9dric Le Goater wrote:
> xics_system_init() does not need 'nr_servers' anymore as it is only
> used to define the 'interrupt-controller' node in the device tree. So
> let's just compute the value when calling spapr_dt_xics().
>=20
> This also gives us an opportunity to simplify the xics_system_init()
> routine and introduce a specific spapr_ics_create() helper to create
> the sPAPR ICS object.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c         | 56 ++++++++++++++++++++++----------------------=
------
>  include/hw/ppc/spapr.h |  1 -
>  2 files changed, 24 insertions(+), 33 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4e87ffe776ea..df231a3fc4a1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -96,45 +96,40 @@
> =20
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> =20
> -static int try_create_xics(sPAPRMachineState *spapr, const char *type_ic=
s,
> -                           const char *type_icp, int nr_servers,
> -                           int nr_irqs, Error **errp)
> +static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
> +                                  const char *type_ics,
> +                                  int nr_irqs, Error **errp)
>  {
> -    XICSFabric *xi =3D XICS_FABRIC(spapr);
>      Error *err =3D NULL, *local_err =3D NULL;
> -    ICSState *ics =3D NULL;
> +    Object *obj;
> =20
> -    ics =3D ICS_SIMPLE(object_new(type_ics));
> -    object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
> -    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
> -    object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xi), NULL=
);
> -    object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
> +    obj =3D object_new(type_ics);
> +    object_property_add_child(OBJECT(spapr), "ics", obj, NULL);
> +    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
> +    object_property_set_int(obj, nr_irqs, "nr-irqs", &err);
> +    object_property_set_bool(obj, true, "realized", &local_err);
>      error_propagate(&err, local_err);
>      if (err) {
>          error_propagate(errp, err);
> -        return -1;
> +        return NULL;
>      }
> =20
> -    spapr->nr_servers =3D nr_servers;
> -    spapr->ics =3D ics;
> -    spapr->icp_type =3D type_icp;
> -    return 0;
> +    return ICS_SIMPLE(obj);
>  }
> =20
> -static int xics_system_init(MachineState *machine,
> -                            int nr_servers, int nr_irqs, Error **errp)
> +static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
>  {
> -    int rc =3D -1;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> =20
>      if (kvm_enabled()) {
>          Error *err =3D NULL;
> =20
>          if (machine_kernel_irqchip_allowed(machine) &&
> -            !xics_kvm_init(SPAPR_MACHINE(machine), errp)) {
> -            rc =3D try_create_xics(SPAPR_MACHINE(machine), TYPE_ICS_KVM,
> -                                 TYPE_KVM_ICP, nr_servers, nr_irqs, &err=
);
> +            !xics_kvm_init(spapr, errp)) {
> +            spapr->icp_type =3D TYPE_KVM_ICP;
> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, &err);
>          }
> -        if (machine_kernel_irqchip_required(machine) && rc < 0) {
> +        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
>              error_reportf_err(err,
>                                "kernel_irqchip requested but unavailable:=
 ");
>          } else {
> @@ -142,13 +137,11 @@ static int xics_system_init(MachineState *machine,
>          }
>      }
> =20
> -    if (rc < 0) {
> -        xics_spapr_init(SPAPR_MACHINE(machine), errp);
> -        rc =3D try_create_xics(SPAPR_MACHINE(machine), TYPE_ICS_SIMPLE,
> -                               TYPE_ICP, nr_servers, nr_irqs, errp);
> +    if (!spapr->ics) {
> +        xics_spapr_init(spapr, errp);
> +        spapr->icp_type =3D TYPE_ICP;
> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
>      }
> -
> -    return rc;
>  }
> =20
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
> @@ -912,6 +905,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
>      void *fdt;
>      sPAPRPHBState *phb;
>      char *buf;
> +    int smt =3D kvmppc_smt_threads();
> =20
>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> @@ -951,7 +945,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(spapr->nr_servers, fdt, PHANDLE_XICP);
> +    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDL=
E_XICP);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -1970,7 +1964,6 @@ static void ppc_spapr_init(MachineState *machine)
>      hwaddr node0_size =3D spapr_node0_size();
>      long load_limit, fw_size;
>      char *filename;
> -    int smt =3D kvmppc_smt_threads();
> =20
>      msi_nonbroken =3D true;
> =20
> @@ -2021,8 +2014,7 @@ static void ppc_spapr_init(MachineState *machine)
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> =20
>      /* Set up Interrupt Controller before we create the VCPUs */
> -    xics_system_init(machine, DIV_ROUND_UP(max_cpus * smt, smp_threads),
> -                     XICS_IRQS_SPAPR, &error_fatal);
> +    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> =20
>      /* Set up containers for ibm,client-set-architecture negotiated opti=
ons */
>      spapr->ov5 =3D spapr_ovec_new();
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index db3d4acb18a6..742777f40a2d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -95,7 +95,6 @@ struct sPAPRMachineState {
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> =20
> -    uint32_t nr_servers;
>      const char *icp_type;
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7ICDAAoJEGw4ysog2bOSTAMP/37SSx1Gtdr2us4fHq03ZcJY
bfHEPqTWOWkr6ZL3UJYs5N1hPTNmQ5B9xLdfz+BlikVCcAM1ixkwTu0pbRfGk9/s
xHxqfUGL8UlPbCJ46bK7JU7SvfuI0YqUrZgEJ8e79gU8yvARAaUbW4W+07ppQo/2
aj4nYFTJk6TRzUfr6RYi5qzEQSxe52PZnsniHyoSo4hY5hWfyTvdwNlEqXjsfNO8
gL1YnSWSMvasRuAAfTKBWnoQXnDWwq4nBPwzHhkSRraZg7iAIxVT0wGseWY1f/s1
vIUTF4/lnIAdbnbVZ8CHvL90w6UScWRVhZpFxLEaEUbM8PXuYMknnAOuCmQnA73p
bR4nNCz2WlJmOOeVmFwZ1VlDKCEjUfuFN1PbKar4S+77yoeUas7m6T/wzPEDZW0J
IUQlOsFZAW5uQR+JqjqqsSajEgB8u4lnQBhvl/yF2rRdAiIrHRAyQF7VNPtqWFHH
ru1Rt9iluTiDVr65Uu+3tUDl5dsagbxq3PwSs0ZXXT2E/zXr2YDoTx/l6TJj8mAp
k7wyllLdGbP6F9bmVi+9Hfihdr6Xwk0gNfQpJLhFDa8mvN4uxoa+oR/YUW76Dwjt
5LJuQU6RFzQr5gBRQH1q0rTGHzio1mPeQq0n4/PAZimr3tZnFaTfdtiO59La+BAu
xKjAobmoTJajTdXkMJOO
=sgJe
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
