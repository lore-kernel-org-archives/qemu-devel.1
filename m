Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebastien.boeuf@intel.com>) id 1gHH3X-00084h-4g
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebastien.boeuf@intel.com>) id 1gHH3S-0007Qd-KN
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:34:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:40252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
	id 1gHH3S-0007KX-8B
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:34:42 -0400
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Date: Mon, 29 Oct 2018 23:34:27 +0000
Message-ID: <1E91073893EF8F498411079ED374F91245EE1724@ORSMSX115.amr.corp.intel.com>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-16-sameo@linux.intel.com>,
	<fb3c4292-09ac-8161-1c65-9012ee2925ee@redhat.com>
In-Reply-To: <fb3c4292-09ac-8161-1c65-9012ee2925ee@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 15/19] hw: acpi: Export the PCI hotplug
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Samuel
	Ortiz <sameo@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jing Liu <jing2.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Yes makes sense. Let's change the naming.=0A=
=0A=
Thanks,=0A=
Sebastien=0A=
________________________________________=0A=
From: Philippe Mathieu-Daud=E9 [philmd@redhat.com]=0A=
Sent: Monday, October 29, 2018 12:46 PM=0A=
To: Samuel Ortiz; qemu-devel@nongnu.org=0A=
Cc: Eduardo Habkost; Michael S. Tsirkin; Jing Liu; Boeuf, Sebastien; Paolo =
Bonzini; Igor Mammedov; Richard Henderson=0A=
Subject: Re: [Qemu-devel] [PATCH v3 15/19] hw: acpi: Export the PCI hotplug=
 API=0A=
=0A=
On 29/10/18 18:01, Samuel Ortiz wrote:=0A=
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
>=0A=
> The ACPI hotplug support for PCI devices APIs are not x86 or even=0A=
> machine type specific. In order for future machine types to be able to=0A=
> re-use that code, we export it through the architecture agnostic=0A=
> hw/acpi folder.=0A=
>=0A=
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>=0A=
> ---=0A=
>   hw/acpi/aml-build.c         | 194 ++++++++++++++++++++++++++++++++++++=
=0A=
>   hw/i386/acpi-build.c        | 192 +----------------------------------=
=0A=
>   include/hw/acpi/aml-build.h |   3 +=0A=
>   3 files changed, 199 insertions(+), 190 deletions(-)=0A=
>=0A=
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c=0A=
> index c3f652a68f..1b057d1191 100644=0A=
> --- a/hw/acpi/aml-build.c=0A=
> +++ b/hw/acpi/aml-build.c=0A=
> @@ -35,6 +35,7 @@=0A=
>   #include "hw/acpi/tpm.h"=0A=
>   #include "qom/qom-qobject.h"=0A=
>   #include "qapi/qmp/qnum.h"=0A=
> +#include "hw/acpi/pcihp.h"=0A=
>=0A=
>   #define PCI_HOST_BRIDGE_CONFIG_ADDR        0xcf8=0A=
>   #define PCI_HOST_BRIDGE_IO_0_MIN_ADDR      0x0000=0A=
> @@ -2314,6 +2315,199 @@ Aml *build_pci_host_bridge(Aml *table, AcpiPciBus=
 *pci_host)=0A=
>       return scope;=0A=
>   }=0A=
>=0A=
> +void build_acpi_pci_hotplug(Aml *scope)=0A=
=0A=
Or build_acpi_pcihp() to match the header file name.=0A=
=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
=0A=
> +{=0A=
> +    Aml *field;=0A=
> +    Aml *method;=0A=
> +=0A=
> +    aml_append(scope,=0A=
> +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x0=
8));=0A=
> +    field =3D aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_=
ZEROS);=0A=
> +    aml_append(field, aml_named_field("PCIU", 32));=0A=
> +    aml_append(field, aml_named_field("PCID", 32));=0A=
> +    aml_append(scope, field);=0A=
> +=0A=
> +    aml_append(scope,=0A=
> +        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04=
));=0A=
> +    field =3D aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_Z=
EROS);=0A=
> +    aml_append(field, aml_named_field("B0EJ", 32));=0A=
> +    aml_append(scope, field);=0A=
> +=0A=
> +    aml_append(scope,=0A=
> +        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x0=
4));=0A=
> +    field =3D aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_=
ZEROS);=0A=
> +    aml_append(field, aml_named_field("BNUM", 32));=0A=
> +    aml_append(scope, field);=0A=
> +=0A=
> +    aml_append(scope, aml_mutex("BLCK", 0));=0A=
> +=0A=
> +    method =3D aml_method("PCEJ", 2, AML_NOTSERIALIZED);=0A=
> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));=0A=
> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));=0A=
> +    aml_append(method,=0A=
> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ"=
)));=0A=
> +    aml_append(method, aml_release(aml_name("BLCK")));=0A=
> +    aml_append(method, aml_return(aml_int(0)));=0A=
> +    aml_append(scope, method);=0A=
> +}=0A=
> +=0A=
> +static void build_append_pcihp_notify_entry(Aml *method, int slot)=0A=
> +{=0A=
> +    Aml *if_ctx;=0A=
> +    int32_t devfn =3D PCI_DEVFN(slot, 0);=0A=
> +=0A=
> +    if_ctx =3D aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));=
=0A=
> +    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1))=
);=0A=
> +    aml_append(method, if_ctx);=0A=
> +}=0A=
> +=0A=
> +void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,=0A=
> +                                  bool pcihp_bridge_en)=0A=
> +{=0A=
> +    Aml *dev, *notify_method =3D NULL, *method;=0A=
> +    QObject *bsel;=0A=
> +    PCIBus *sec;=0A=
> +    int i;=0A=
> +=0A=
> +    bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);=0A=
> +    if (bsel) {=0A=
> +        uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));=0A=
> +=0A=
> +        aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));=0A=
> +        notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);=0A=
> +    }=0A=
> +=0A=
> +    for (i =3D 0; i < ARRAY_SIZE(bus->devices); i +=3D PCI_FUNC_MAX) {=
=0A=
> +        DeviceClass *dc;=0A=
> +        PCIDeviceClass *pc;=0A=
> +        PCIDevice *pdev =3D bus->devices[i];=0A=
> +        int slot =3D PCI_SLOT(i);=0A=
> +        bool hotplug_enabled_dev;=0A=
> +        bool bridge_in_acpi;=0A=
> +=0A=
> +        if (!pdev) {=0A=
> +            if (bsel) { /* add hotplug slots for non present devices */=
=0A=
> +                dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));=0A=
> +                aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));=
=0A=
> +                aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16=
)));=0A=
> +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);=0A=
> +                aml_append(method,=0A=
> +                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN")=
)=0A=
> +                );=0A=
> +                aml_append(dev, method);=0A=
> +                aml_append(parent_scope, dev);=0A=
> +=0A=
> +                build_append_pcihp_notify_entry(notify_method, slot);=0A=
> +            }=0A=
> +            continue;=0A=
> +        }=0A=
> +=0A=
> +        pc =3D PCI_DEVICE_GET_CLASS(pdev);=0A=
> +        dc =3D DEVICE_GET_CLASS(pdev);=0A=
> +=0A=
> +        /* When hotplug for bridges is enabled, bridges are=0A=
> +         * described in ACPI separately (see build_pci_bus_end).=0A=
> +         * In this case they aren't themselves hot-pluggable.=0A=
> +         * Hotplugged bridges *are* hot-pluggable.=0A=
> +         */=0A=
> +        bridge_in_acpi =3D pc->is_bridge && pcihp_bridge_en &&=0A=
> +            !DEVICE(pdev)->hotplugged;=0A=
> +=0A=
> +        hotplug_enabled_dev =3D bsel && dc->hotpluggable && !bridge_in_a=
cpi;=0A=
> +=0A=
> +        if (pc->class_id =3D=3D PCI_CLASS_BRIDGE_ISA) {=0A=
> +            continue;=0A=
> +        }=0A=
> +=0A=
> +        /* start to compose PCI slot descriptor */=0A=
> +        dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));=0A=
> +        aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));=0A=
> +=0A=
> +        if (pc->class_id =3D=3D PCI_CLASS_DISPLAY_VGA) {=0A=
> +            /* add VGA specific AML methods */=0A=
> +            int s3d;=0A=
> +=0A=
> +            if (object_dynamic_cast(OBJECT(pdev), "qxl-vga")) {=0A=
> +                s3d =3D 3;=0A=
> +            } else {=0A=
> +                s3d =3D 0;=0A=
> +            }=0A=
> +=0A=
> +            method =3D aml_method("_S1D", 0, AML_NOTSERIALIZED);=0A=
> +            aml_append(method, aml_return(aml_int(0)));=0A=
> +            aml_append(dev, method);=0A=
> +=0A=
> +            method =3D aml_method("_S2D", 0, AML_NOTSERIALIZED);=0A=
> +            aml_append(method, aml_return(aml_int(0)));=0A=
> +            aml_append(dev, method);=0A=
> +=0A=
> +            method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);=0A=
> +            aml_append(method, aml_return(aml_int(s3d)));=0A=
> +            aml_append(dev, method);=0A=
> +        } else if (hotplug_enabled_dev) {=0A=
> +            /* add _SUN/_EJ0 to make slot hotpluggable  */=0A=
> +            aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));=0A=
> +=0A=
> +            method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);=0A=
> +            aml_append(method,=0A=
> +                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))=0A=
> +            );=0A=
> +            aml_append(dev, method);=0A=
> +=0A=
> +            if (bsel) {=0A=
> +                build_append_pcihp_notify_entry(notify_method, slot);=0A=
> +            }=0A=
> +        } else if (bridge_in_acpi) {=0A=
> +            /*=0A=
> +             * device is coldplugged bridge,=0A=
> +             * add child device descriptions into its scope=0A=
> +             */=0A=
> +            PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev))=
;=0A=
> +=0A=
> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);=
=0A=
> +        }=0A=
> +        /* slot descriptor has been composed, add it into parent context=
 */=0A=
> +        aml_append(parent_scope, dev);=0A=
> +    }=0A=
> +=0A=
> +    if (bsel) {=0A=
> +        aml_append(parent_scope, notify_method);=0A=
> +    }=0A=
> +=0A=
> +    /* Append PCNT method to notify about events on local and child buse=
s.=0A=
> +     * Add unconditionally for root since DSDT expects it.=0A=
> +     */=0A=
> +    method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);=0A=
> +=0A=
> +    /* If bus supports hotplug select it and notify about local events *=
/=0A=
> +    if (bsel) {=0A=
> +        uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));=0A=
> +=0A=
> +        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));=0A=
> +        aml_append(method,=0A=
> +            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)=0A=
> +        );=0A=
> +        aml_append(method,=0A=
> +            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Reque=
st */)=0A=
> +        );=0A=
> +    }=0A=
> +=0A=
> +    /* Notify about child bus events in any case */=0A=
> +    if (pcihp_bridge_en) {=0A=
> +        QLIST_FOREACH(sec, &bus->child, sibling) {=0A=
> +            int32_t devfn =3D sec->parent_dev->devfn;=0A=
> +=0A=
> +            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {=0A=
> +                continue;=0A=
> +            }=0A=
> +=0A=
> +            aml_append(method, aml_name("^S%.02X.PCNT", devfn));=0A=
> +        }=0A=
> +    }=0A=
> +    aml_append(parent_scope, method);=0A=
> +    qobject_unref(bsel);=0A=
> +}=0A=
> +=0A=
>   void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host)=0A=
>   {=0A=
>       Aml *dev, *pci_scope;=0A=
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c=0A=
> index 5932dbe825..9cb739bf5c 100644=0A=
> --- a/hw/i386/acpi-build.c=0A=
> +++ b/hw/i386/acpi-build.c=0A=
> @@ -362,163 +362,6 @@ build_madt(GArray *table_data, BIOSLinker *linker,=
=0A=
>                    table_data->len - madt_start, 1, NULL, NULL);=0A=
>   }=0A=
>=0A=
> -static void build_append_pcihp_notify_entry(Aml *method, int slot)=0A=
> -{=0A=
> -    Aml *if_ctx;=0A=
> -    int32_t devfn =3D PCI_DEVFN(slot, 0);=0A=
> -=0A=
> -    if_ctx =3D aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));=
=0A=
> -    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1))=
);=0A=
> -    aml_append(method, if_ctx);=0A=
> -}=0A=
> -=0A=
> -static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,=
=0A=
> -                                         bool pcihp_bridge_en)=0A=
> -{=0A=
> -    Aml *dev, *notify_method =3D NULL, *method;=0A=
> -    QObject *bsel;=0A=
> -    PCIBus *sec;=0A=
> -    int i;=0A=
> -=0A=
> -    bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);=0A=
> -    if (bsel) {=0A=
> -        uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));=0A=
> -=0A=
> -        aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));=0A=
> -        notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);=0A=
> -    }=0A=
> -=0A=
> -    for (i =3D 0; i < ARRAY_SIZE(bus->devices); i +=3D PCI_FUNC_MAX) {=
=0A=
> -        DeviceClass *dc;=0A=
> -        PCIDeviceClass *pc;=0A=
> -        PCIDevice *pdev =3D bus->devices[i];=0A=
> -        int slot =3D PCI_SLOT(i);=0A=
> -        bool hotplug_enabled_dev;=0A=
> -        bool bridge_in_acpi;=0A=
> -=0A=
> -        if (!pdev) {=0A=
> -            if (bsel) { /* add hotplug slots for non present devices */=
=0A=
> -                dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));=0A=
> -                aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));=
=0A=
> -                aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16=
)));=0A=
> -                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);=0A=
> -                aml_append(method,=0A=
> -                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN")=
)=0A=
> -                );=0A=
> -                aml_append(dev, method);=0A=
> -                aml_append(parent_scope, dev);=0A=
> -=0A=
> -                build_append_pcihp_notify_entry(notify_method, slot);=0A=
> -            }=0A=
> -            continue;=0A=
> -        }=0A=
> -=0A=
> -        pc =3D PCI_DEVICE_GET_CLASS(pdev);=0A=
> -        dc =3D DEVICE_GET_CLASS(pdev);=0A=
> -=0A=
> -        /* When hotplug for bridges is enabled, bridges are=0A=
> -         * described in ACPI separately (see build_pci_bus_end).=0A=
> -         * In this case they aren't themselves hot-pluggable.=0A=
> -         * Hotplugged bridges *are* hot-pluggable.=0A=
> -         */=0A=
> -        bridge_in_acpi =3D pc->is_bridge && pcihp_bridge_en &&=0A=
> -            !DEVICE(pdev)->hotplugged;=0A=
> -=0A=
> -        hotplug_enabled_dev =3D bsel && dc->hotpluggable && !bridge_in_a=
cpi;=0A=
> -=0A=
> -        if (pc->class_id =3D=3D PCI_CLASS_BRIDGE_ISA) {=0A=
> -            continue;=0A=
> -        }=0A=
> -=0A=
> -        /* start to compose PCI slot descriptor */=0A=
> -        dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));=0A=
> -        aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));=0A=
> -=0A=
> -        if (pc->class_id =3D=3D PCI_CLASS_DISPLAY_VGA) {=0A=
> -            /* add VGA specific AML methods */=0A=
> -            int s3d;=0A=
> -=0A=
> -            if (object_dynamic_cast(OBJECT(pdev), "qxl-vga")) {=0A=
> -                s3d =3D 3;=0A=
> -            } else {=0A=
> -                s3d =3D 0;=0A=
> -            }=0A=
> -=0A=
> -            method =3D aml_method("_S1D", 0, AML_NOTSERIALIZED);=0A=
> -            aml_append(method, aml_return(aml_int(0)));=0A=
> -            aml_append(dev, method);=0A=
> -=0A=
> -            method =3D aml_method("_S2D", 0, AML_NOTSERIALIZED);=0A=
> -            aml_append(method, aml_return(aml_int(0)));=0A=
> -            aml_append(dev, method);=0A=
> -=0A=
> -            method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);=0A=
> -            aml_append(method, aml_return(aml_int(s3d)));=0A=
> -            aml_append(dev, method);=0A=
> -        } else if (hotplug_enabled_dev) {=0A=
> -            /* add _SUN/_EJ0 to make slot hotpluggable  */=0A=
> -            aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));=0A=
> -=0A=
> -            method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);=0A=
> -            aml_append(method,=0A=
> -                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))=0A=
> -            );=0A=
> -            aml_append(dev, method);=0A=
> -=0A=
> -            if (bsel) {=0A=
> -                build_append_pcihp_notify_entry(notify_method, slot);=0A=
> -            }=0A=
> -        } else if (bridge_in_acpi) {=0A=
> -            /*=0A=
> -             * device is coldplugged bridge,=0A=
> -             * add child device descriptions into its scope=0A=
> -             */=0A=
> -            PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev))=
;=0A=
> -=0A=
> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);=
=0A=
> -        }=0A=
> -        /* slot descriptor has been composed, add it into parent context=
 */=0A=
> -        aml_append(parent_scope, dev);=0A=
> -    }=0A=
> -=0A=
> -    if (bsel) {=0A=
> -        aml_append(parent_scope, notify_method);=0A=
> -    }=0A=
> -=0A=
> -    /* Append PCNT method to notify about events on local and child buse=
s.=0A=
> -     * Add unconditionally for root since DSDT expects it.=0A=
> -     */=0A=
> -    method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);=0A=
> -=0A=
> -    /* If bus supports hotplug select it and notify about local events *=
/=0A=
> -    if (bsel) {=0A=
> -        uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));=0A=
> -=0A=
> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));=0A=
> -        aml_append(method,=0A=
> -            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)=0A=
> -        );=0A=
> -        aml_append(method,=0A=
> -            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Reque=
st */)=0A=
> -        );=0A=
> -    }=0A=
> -=0A=
> -    /* Notify about child bus events in any case */=0A=
> -    if (pcihp_bridge_en) {=0A=
> -        QLIST_FOREACH(sec, &bus->child, sibling) {=0A=
> -            int32_t devfn =3D sec->parent_dev->devfn;=0A=
> -=0A=
> -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {=0A=
> -                continue;=0A=
> -            }=0A=
> -=0A=
> -            aml_append(method, aml_name("^S%.02X.PCNT", devfn));=0A=
> -        }=0A=
> -    }=0A=
> -    aml_append(parent_scope, method);=0A=
> -    qobject_unref(bsel);=0A=
> -}=0A=
> -=0A=
>   static void build_hpet_aml(Aml *table)=0A=
>   {=0A=
>       Aml *crs;=0A=
> @@ -1214,41 +1057,10 @@ static void build_piix4_isa_bridge(Aml *table)=0A=
>   static void build_piix4_pci_hotplug(Aml *table)=0A=
>   {=0A=
>       Aml *scope;=0A=
> -    Aml *field;=0A=
> -    Aml *method;=0A=
> -=0A=
> -    scope =3D  aml_scope("_SB.PCI0");=0A=
> -=0A=
> -    aml_append(scope,=0A=
> -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x0=
8));=0A=
> -    field =3D aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_=
ZEROS);=0A=
> -    aml_append(field, aml_named_field("PCIU", 32));=0A=
> -    aml_append(field, aml_named_field("PCID", 32));=0A=
> -    aml_append(scope, field);=0A=
>=0A=
> -    aml_append(scope,=0A=
> -        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04=
));=0A=
> -    field =3D aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_Z=
EROS);=0A=
> -    aml_append(field, aml_named_field("B0EJ", 32));=0A=
> -    aml_append(scope, field);=0A=
> -=0A=
> -    aml_append(scope,=0A=
> -        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x0=
4));=0A=
> -    field =3D aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_=
ZEROS);=0A=
> -    aml_append(field, aml_named_field("BNUM", 32));=0A=
> -    aml_append(scope, field);=0A=
> -=0A=
> -    aml_append(scope, aml_mutex("BLCK", 0));=0A=
> -=0A=
> -    method =3D aml_method("PCEJ", 2, AML_NOTSERIALIZED);=0A=
> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));=0A=
> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));=0A=
> -    aml_append(method,=0A=
> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ"=
)));=0A=
> -    aml_append(method, aml_release(aml_name("BLCK")));=0A=
> -    aml_append(method, aml_return(aml_int(0)));=0A=
> -    aml_append(scope, method);=0A=
> +    scope =3D aml_scope("_SB.PCI0");=0A=
>=0A=
> +    build_acpi_pci_hotplug(scope);=0A=
>       aml_append(table, scope);=0A=
>   }=0A=
>=0A=
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h=0A=
> index 654ce2ec26..3ea2df5f83 100644=0A=
> --- a/include/hw/acpi/aml-build.h=0A=
> +++ b/include/hw/acpi/aml-build.h=0A=
> @@ -419,6 +419,9 @@ Aml *build_osc_method(uint32_t value);=0A=
>   void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *i=
nfo);=0A=
>   Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi);=0A=
>   Aml *build_prt(bool is_pci0_prt);=0A=
> +void build_acpi_pci_hotplug(Aml *scope);=0A=
> +void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,=0A=
> +                                  bool pcihp_bridge_en);=0A=
>   void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host);=0A=
>   Aml *build_pci_host_bridge(Aml *table, AcpiPciBus *pci_host);=0A=
>   void crs_range_set_init(CrsRangeSet *range_set);=0A=
>=0A=
