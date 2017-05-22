Received: from eggs.gnu.org ([2001:4830:134:3::10]:50246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCd7S-0007Qi-KS
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCd7P-0002Sl-Ck
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:30:50 -0400
Date: Mon, 22 May 2017 12:30:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522023039.GH30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994738.24289.215239362416048889.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
In-Reply-To: <149518994738.24289.215239362416048889.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 12:32:27PM +0200, Greg Kurz wrote:
> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> is an improvement since we no longer allocate ICP objects that will
> never be used. But it has the side-effect of breaking migration of
> older machine types from older QEMU versions.
>=20
> This patch introduces a compat flag in the sPAPR machine class so
> that all pseries machine up to 2.9 go on with the previous behavior
> of pre-allocating ICP objects.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - s/void* /void * in xics_system_init()
>     - don't use "[*]" in the ICP object name
>     - use pre_2_10_ prefix in field names
>     - added xics_nr_servers() helper
> ---
>  hw/ppc/spapr.c          |   40 +++++++++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_cpu_core.c |   29 ++++++++++++++++++++---------
>  include/hw/ppc/spapr.h  |    2 ++
>  3 files changed, 61 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1bb05a9a6b07..182262257c60 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -123,9 +123,15 @@ error:
>      return NULL;
>  }
> =20
> +static inline int xics_nr_servers(void)
> +{
> +    return ppc_cpu_dt_id_from_index(max_cpus);
> +}
> +
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
> @@ -147,6 +153,35 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
>              return;
>          }
>      }
> +
> +    if (smc->pre_2_10_icp_allocation) {
> +        int nr_servers =3D xics_nr_servers();
> +        Error *local_err =3D NULL;
> +        int i;
> +
> +        spapr->pre_2_10_icps =3D g_malloc0(nr_servers * sizeof(ICPState)=
);
> +
> +        for (i =3D 0; i < nr_servers; i++) {
> +            void *obj =3D &spapr->pre_2_10_icps[i];
> +            char *name =3D g_strdup_printf("icp[%d]", i);
> +
> +            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
> +            object_property_add_child(OBJECT(spapr), name, obj, &error_a=
bort);
> +            g_free(name);
> +            object_unref(obj);
> +            object_property_add_const_link(obj, "xics", OBJECT(spapr),
> +                                           &error_abort);
> +            object_property_set_bool(obj, true, "realized", &local_err);
> +            if (local_err) {
> +                while (i--) {
> +                    object_unparent(obj);
> +                }
> +                g_free(spapr->pre_2_10_icps);
> +                error_propagate(errp, local_err);
> +                break;
> +            }
> +        }
> +    }
>  }
> =20
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
> @@ -1020,7 +1055,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_XICP);
> +    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -3286,9 +3321,12 @@ static void spapr_machine_2_9_instance_options(Mac=
hineState *machine)
> =20
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
>      mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> +    smc->pre_2_10_icp_allocation =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ff7058ecc00e..13c4916aa5e6 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -119,6 +119,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *d=
ev, Error **errp)
>      size_t size =3D object_type_get_instance_size(typename);
>      CPUCore *cc =3D CPU_CORE(dev);
>      int i;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>      for (i =3D 0; i < cc->nr_threads; i++) {
>          void *obj =3D sc->threads + i * size;
> @@ -127,7 +128,9 @@ static void spapr_cpu_core_unrealizefn(DeviceState *d=
ev, Error **errp)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
>          spapr_cpu_destroy(cpu);
> -        object_unparent(cpu->intc);
> +        if (!spapr->pre_2_10_icps) {

Hrm.  I dislike code for the core object directly reaching into the
machine to check the compat flag here (and a bunch of other places
below).  I can think of a few possible ways of avoiding this:

1) The most direct is to make another compat flag in the cpu core
object, set by the machine.  Straightforward, but ugly.

2) Use a property to optionally pass a reference to the ICP array into
the core object.  If set it will give the cpu objects ICPs from that
array (compat mode), if not it will allocate them (new style mode).

3) (Preferred, if it works)  Always have the core allocate ICPs for
each CPU.  For compat mode instead of directly allocating ICPs, the
machine sets up an array of pointers to the existing ICPs for each
CPU.  The "extra" slots that don't have ICPs in new-style allocation
get references to dummy ICP objects (maybe even all the same one).
Only the dummy ICP(s) are allocated by the machine, the rest remain
owned by the cpu.


> +            object_unparent(cpu->intc);
> +        }
>          cpu_remove_sync(cs);
>          object_unparent(obj);
>      }
> @@ -142,13 +145,19 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> =20
> -    obj =3D object_new(spapr->icp_type);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> -        goto error;
> +    if (spapr->pre_2_10_icps) {
> +        int index =3D cpu->parent_obj.cpu_index;
> +
> +        obj =3D OBJECT(&spapr->pre_2_10_icps[index]);
> +    } else {
> +        obj =3D object_new(spapr->icp_type);
> +        object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> +        object_property_add_const_link(obj, "xics", OBJECT(spapr),
> +                                       &error_abort);
> +        object_property_set_bool(obj, true, "realized", &local_err);
> +        if (local_err) {
> +            goto error;
> +        }
>      }
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
> @@ -165,7 +174,9 @@ static void spapr_cpu_core_realize_child(Object *chil=
d, Error **errp)
>      return;
> =20
>  error:
> -    object_unparent(obj);
> +    if (!spapr->pre_2_10_icps) {
> +        object_unparent(obj);
> +    }
>      error_propagate(errp, local_err);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f875dc41d811..d1dcf0c8bddf 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -54,6 +54,7 @@ struct sPAPRMachineClass {
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      bool pre_2_9_cas_pvr;      /* Use old logic for PVR compat negotiati=
on */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
> +    bool pre_2_10_icp_allocation;
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
>                            hwaddr *mmio32, hwaddr *mmio64,
> @@ -110,6 +111,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
> =20
>      const char *icp_type;
> +    ICPState *pre_2_10_icps;
>  };
> =20
>  #define H_SUCCESS         0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIk1MAAoJEGw4ysog2bOSfsoQAORtm0YUg/lyQW0EHvqrau89
mgdebRgU5Yfs5H+KCA7OXcsFrIiJoHW4m0IZWJp/GpB0hOXMQ8+7fcooo1fqpYXn
R0bKJArKeZ6MQbklVB0UA8ZE8qoiUd3fNwboVPA55RaLmi+VoFUF4ioVaFJmnGIf
bvgeNVuZeXNYwWoqcal5bQlZzf2Z9Pr1OK3PKMa6hJPDm85LNRCnvEkQx5sAQQPu
nK1Mm4gbgqr9WnmQsrWutEYrFMJt9Xx9ZmCkcjcMYzeM/AQs6fkYW86Tfx/qXPw0
oWWlX4y+mq2KWFR2ypM3IrhBQabrsMf72vUNR2WRsDrLow+rltmAVdp3G9y56hV4
Gia94Hts+1m4C28YQwqOn7G+3cBGjrbXEWGmJfsZxOTXePuZsRU1y3LOAOKYq+QY
NOZ3qtLox9GGqgs4g96rMofjN+ScsixCNJXgIHbD6cRyI0QYfxhSl4zAcSXuyAhA
8TRTfqNKAy5YKxm02/fIaX1bZWfjgl6dqqcd85AXVQMZCXhJDmcWxcgc500H713e
tBrphmC53gGyOG02500KLTs94nnp2yESidr/R5Jdy1J2xVljoRIDjODIiY23s3+w
ITKdFcmjWb95DtwpbhAj4SFxbqgwX/fMqjab//P54FeDrqLyLTjnG/RYkllQ8d0p
lJLoWYV5N70ETR6yuY7J
=9GfD
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
