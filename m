Received: from eggs.gnu.org ([2001:4830:134:3::10]:52621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSIJ2-0000el-1D
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSIIy-00023G-2o
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:31:32 -0400
Date: Tue, 4 Jul 2017 17:29:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704072901.GA2180@umbus.fritz.box>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote:
> The sPAPR machine always create a default PHB during initialization, even
> if -nodefaults was passed on the command line. This forces the user to
> rely on -global if she wants to set properties of the default PHB, such
> as numa_node.
>=20
> This patch introduces a new machine create-default-phb property to control
> whether the default PHB must be created or not. It defaults to on in order
> to preserve old setups (which is also the motivation to not alter the
> current behavior of -nodefaults).
>=20
> If create-default-phb is set to off, the default PHB isn't created, nor
> any other device usually created with it. It is mandatory to provide
> a PHB on the command line to be able to use PCI devices (otherwise QEMU
> won't start). For example, the following creates a PHB with the same
> mappings as the default PHB and also sets the NUMA affinity:
>=20
>     -machine type=3Dpseries,create-default-phb=3Doff \
>     -numa node,nodeid=3D0 -device spapr-pci-host-bridge,index=3D0,numa_no=
de=3D0
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

So, I agree that the distinction between default devices that are
disabled with -nodefaults and default devices that aren't is a big
mess in qemu configuration.  But on the other hand this only addresses
one tiny aspect of that, and in the meantime means we will silently
ignore some other configuration options in some conditions.

So, what's the immediate benefit / use case for this?

> ---
>  hw/ppc/spapr.c         |   63 ++++++++++++++++++++++++++++++++++--------=
------
>  include/hw/ppc/spapr.h |    2 ++
>  2 files changed, 47 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ba8f57a5a054..3395bb3774b9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2103,7 +2103,7 @@ static void ppc_spapr_init(MachineState *machine)
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *initrd_filename =3D machine->initrd_filename;
> -    PCIHostState *phb;
> +    PCIHostState *phb =3D NULL;
>      int i;
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> @@ -2294,7 +2294,9 @@ static void ppc_spapr_init(MachineState *machine)
>      /* Set up PCI */
>      spapr_pci_rtas_init();
> =20
> -    phb =3D spapr_create_phb(spapr, 0);
> +    if (spapr->create_default_phb) {
> +        phb =3D spapr_create_phb(spapr, 0);
> +    }
> =20
>      for (i =3D 0; i < nb_nics; i++) {
>          NICInfo *nd =3D &nd_table[i];
> @@ -2305,7 +2307,7 @@ static void ppc_spapr_init(MachineState *machine)
> =20
>          if (strcmp(nd->model, "ibmveth") =3D=3D 0) {
>              spapr_vlan_create(spapr->vio_bus, nd);
> -        } else {
> +        } else if (phb) {
>              pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, NULL);
>          }
>      }
> @@ -2314,24 +2316,26 @@ static void ppc_spapr_init(MachineState *machine)
>          spapr_vscsi_create(spapr->vio_bus);
>      }
> =20
> -    /* Graphics */
> -    if (spapr_vga_init(phb->bus, &error_fatal)) {
> -        spapr->has_graphics =3D true;
> -        machine->usb |=3D defaults_enabled() && !machine->usb_disabled;
> -    }
> -
> -    if (machine->usb) {
> -        if (smc->use_ohci_by_default) {
> -            pci_create_simple(phb->bus, -1, "pci-ohci");
> -        } else {
> -            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> +    if (phb) {
> +        /* Graphics */
> +        if (spapr_vga_init(phb->bus, &error_fatal)) {
> +            spapr->has_graphics =3D true;
> +            machine->usb |=3D defaults_enabled() && !machine->usb_disabl=
ed;
>          }
> =20
> -        if (spapr->has_graphics) {
> -            USBBus *usb_bus =3D usb_bus_find(-1);
> +        if (machine->usb) {
> +            if (smc->use_ohci_by_default) {
> +                pci_create_simple(phb->bus, -1, "pci-ohci");
> +            } else {
> +                pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> +            }
> +
> +            if (spapr->has_graphics) {
> +                USBBus *usb_bus =3D usb_bus_find(-1);
> =20
> -            usb_create_simple(usb_bus, "usb-kbd");
> -            usb_create_simple(usb_bus, "usb-mouse");
> +                usb_create_simple(usb_bus, "usb-kbd");
> +                usb_create_simple(usb_bus, "usb-mouse");
> +            }
>          }
>      }
> =20
> @@ -2544,12 +2548,27 @@ static void spapr_set_modern_hotplug_events(Objec=
t *obj, bool value,
>      spapr->use_hotplug_event_source =3D value;
>  }
> =20
> +static bool spapr_get_create_default_phb(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->create_default_phb;
> +}
> +
> +static void spapr_set_create_default_phb(Object *obj, bool value, Error =
**errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->create_default_phb =3D value;
> +}
> +
>  static void spapr_machine_initfn(Object *obj)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> =20
>      spapr->htab_fd =3D -1;
>      spapr->use_hotplug_event_source =3D true;
> +    spapr->create_default_phb =3D true;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NULL=
);
>      object_property_set_description(obj, "kvm-type",
> @@ -2568,6 +2587,14 @@ static void spapr_machine_initfn(Object *obj)
>      ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pv=
r,
>                              "Maximum permitted CPU compatibility mode",
>                              &error_fatal);
> +
> +    object_property_add_bool(obj, "create-default-phb",
> +                            spapr_get_create_default_phb,
> +                            spapr_set_create_default_phb,
> +                            NULL);
> +    object_property_set_description(obj, "create-default-phb",
> +                                    "Create a default PCI Host Bridge",
> +                                    NULL);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a184ffab0ebc..6ee914764807 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -93,6 +93,8 @@ struct sPAPRMachineState {
>      bool use_hotplug_event_source;
>      sPAPREventSource *event_sources;
> =20
> +    bool create_default_phb;
> +
>      /* ibm,client-architecture-support option negotiation */
>      bool cas_reboot;
>      bool cas_legacy_guest_workaround;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW0O9AAoJEGw4ysog2bOSZhoP/iw5N+1Am0oOw0VRmPcZmDf2
ASxYatmnMVdAeoLTMvW2P08REN8sgsVaNF2UrAHbTxaWArEaLY+Um7mBJnnffMeF
UK1SHmwLAzFGKXJ7zGnr9nilQ/+cdtjLhsXal8qXuNsG5G0SEbXApAt0VGKAMEXa
J3kIHz0h0yDr3M7n+/S5p1ThCa6Lt8KnXzMNF7O632aN0H9BZN62Muqi20YthXxz
JS1QjtaBDRFG0mipB7Y+Le916mKnYJmGIQDiuCwthc0NgTalTX6jgvxkXyHK327d
HFqyYmwLfMykeqb0lA4rIOj4gIdoZ8XzHj19stKemlGuSK3CFb0e5QlM3Lpt0MhZ
1BlW4zNQwUMtYC1mdLASZkDLkG9yNpVsvXFhHuAsmMzdfseu15zqp8jvFdqfqO6X
UKo5BfsdfJOT4A63rKJRge2gtQ9W6Ankt+Vvha6VOAg+kzh82Li8yVBqDO4GdzP6
cSlRAhVZ7jyr0g/sveilgMbuswErmKT5UW/YpAMauRYR+qviiN2qhqPJtRxcIzUk
rhNxa2eAzma2Be2NFBnUOuQLF38iVGyBqT9nmbpUCzmoYIEvBL+BoXLng5lHbRMc
zBFcnWZ0BFDus7EjqGIo3ImCveDdXUNBbwMQuilKVpRwdReRiOb4LLJmkxSIQJjv
ljHH6x4moURMOeTLoKh9
=M+Wq
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
