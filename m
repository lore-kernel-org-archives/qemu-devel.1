Received: from eggs.gnu.org ([2001:4830:134:3::10]:57698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNgZu-0001hY-SB
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNgZt-0005DC-1v
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:02:42 -0500
Date: Fri, 16 Nov 2018 17:02:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181116170226.35385388@redhat.com>
In-Reply-To: <20181105014047.26447-21-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-21-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 20/24] hw: acpi: Define ACPI tables
 builder interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon,  5 Nov 2018 02:40:43 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> In order to decouple ACPI APIs from specific machine types, we are
> creating an ACPI builder interface that each ACPI platform can choose to
> implement.
> This way, a new machine type can re-use the high level ACPI APIs and
> define some custom table build methods, without having to duplicate most
> of the existing implementation only to add small variations to it.
I'm not sure about motivation behind so high APIs,
what obvious here is an extra level of indirection for not clear gain.

Yep using table callbacks, one can attempt to generalize
acpi_setup() and help boards to decide which tables do not build
(MCFG comes to the mind). But I'm not convinced that acpi_setup()
could be cleanly generalized as a whole (probably some parts but
not everything) so it's minor benefit for extra headache of
figuring out what callback will be actually called when reading code.

However if board needs a slightly different table, it will have to
duplicate an exiting one and then modify to suit its needs.

to me it pretty much looks the same as calling build_foo()
we use now but with an extra indirection level and then
duplicating the later for usage in another board in slightly
different manner.

I agree with Paolo's suggestion to use interfaces for generalization,
however I'd suggest a fine grained approach for providing board/target
specific items/actions for generic tables.

For example take a look at AcpiDeviceIfClass interface that is
implemented by GPE devices and its madt_cpu() method. That should
simplify generalizing cpu hotplug for arm/virt and also help
to generalize build_madt(). It's not cleanest impl. by far but
headed in the right generic direction. I have it on my TODO list to
do list to generalize acpi parts of build_fadt()/cpu hotplug
some day as part of the project that adds cpu hotplug to arm/virt board.

GPE/GED device might be not ideal place to implement that interface
(worked for pc/q35) and may be we should move it to machine level
as board has access to much more data for building ACPI tables.
For i386/virt, I'd extend/modify AcpiDeviceIfClass when/where it's
necessary instead of adding high level table hooks.
That way generic build_foo() API's would share much more code.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  include/hw/acpi/builder.h | 100 ++++++++++++++++++++++++++++++++++++++
>  hw/acpi/builder.c         |  97 ++++++++++++++++++++++++++++++++++++
>  hw/acpi/Makefile.objs     |   1 +
>  3 files changed, 198 insertions(+)
>  create mode 100644 include/hw/acpi/builder.h
>  create mode 100644 hw/acpi/builder.c
>=20
> diff --git a/include/hw/acpi/builder.h b/include/hw/acpi/builder.h
> new file mode 100644
> index 0000000000..a63b88ffe9
> --- /dev/null
> +++ b/include/hw/acpi/builder.h
> @@ -0,0 +1,100 @@
> +/*
> + *
> + * Copyright (c) 2018 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef ACPI_BUILDER_H
> +#define ACPI_BUILDER_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "qom/object.h"
> +
> +#define TYPE_ACPI_BUILDER "acpi-builder"
> +
> +#define ACPI_BUILDER_METHODS(klass) \
> +     OBJECT_CLASS_CHECK(AcpiBuilderMethods, (klass), TYPE_ACPI_BUILDER)
> +#define ACPI_BUILDER_GET_METHODS(obj) \
> +     OBJECT_GET_CLASS(AcpiBuilderMethods, (obj), TYPE_ACPI_BUILDER)
> +#define ACPI_BUILDER(obj)                                       \
> +     INTERFACE_CHECK(AcpiBuilder, (obj), TYPE_ACPI_BUILDER)
> +
> +typedef struct AcpiConfiguration AcpiConfiguration;
> +typedef struct AcpiBuildState AcpiBuildState;
> +typedef struct AcpiMcfgInfo AcpiMcfgInfo;
> +
> +typedef struct AcpiBuilder {
> +    /* <private> */
> +    Object Parent;
> +} AcpiBuilder;
> +
> +/**
> + * AcpiBuildMethods:
> + *
> + * Interface to be implemented by a machine type that needs to provide
> + * custom ACPI tables build method.
> + *
> + * @parent: Opaque parent interface.
> + * @rsdp: ACPI RSDP (Root System Description Pointer) table build callba=
ck.
> + * @madt: ACPI MADT (Multiple APIC Description Table) table build callba=
ck.
> + * @mcfg: ACPI MCFG table build callback.
> + * @srat: ACPI SRAT (System/Static Resource Affinity Table)
> + *        table build callback.
> + * @slit: ACPI SLIT (System Locality System Information Table)
> + *        table build callback.
> + * @configuration: ACPI configuration getter.
> + *                 This is used to query the machine instance for its
> + *                 AcpiConfiguration pointer.
> + */
> +typedef struct AcpiBuilderMethods {
> +    /* <private> */
> +    InterfaceClass parent;
> +
> +    /* <public> */
> +    void (*rsdp)(GArray *table_data, BIOSLinker *linker,
> +                 unsigned rsdt_tbl_offset);
> +    void (*madt)(GArray *table_data, BIOSLinker *linker,
> +                 MachineState *ms, AcpiConfiguration *conf);
> +    void (*mcfg)(GArray *table_data, BIOSLinker *linker,
> +                 AcpiMcfgInfo *info);
> +    void (*srat)(GArray *table_data, BIOSLinker *linker,
> +                 MachineState *machine, AcpiConfiguration *conf);
> +    void (*slit)(GArray *table_data, BIOSLinker *linker);
> +
> +    AcpiConfiguration *(*configuration)(AcpiBuilder *builder);
> +} AcpiBuilderMethods;
> +
> +void acpi_builder_rsdp(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       unsigned rsdt_tbl_offset);
> +
> +void acpi_builder_madt(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       MachineState *ms, AcpiConfiguration *conf);
> +
> +void acpi_builder_mcfg(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       AcpiMcfgInfo *info);
> +
> +void acpi_builder_srat(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       MachineState *machine, AcpiConfiguration *conf);
> +
> +void acpi_builder_slit(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker);
> +
> +AcpiConfiguration *acpi_builder_configuration(AcpiBuilder *builder);
> +
> +#endif
> diff --git a/hw/acpi/builder.c b/hw/acpi/builder.c
> new file mode 100644
> index 0000000000..c29a614793
> --- /dev/null
> +++ b/hw/acpi/builder.c
> @@ -0,0 +1,97 @@
> +/*
> + *
> + * Copyright (c) 2018 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +#include "hw/acpi/builder.h"
> +
> +void acpi_builder_rsdp(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       unsigned rsdt_tbl_offset)
> +{
> +    AcpiBuilderMethods *abm =3D ACPI_BUILDER_GET_METHODS(builder);
> +
> +    if (abm && abm->rsdp) {
> +        abm->rsdp(table_data, linker, rsdt_tbl_offset);
> +    }
> +}
> +
> +void acpi_builder_madt(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       MachineState *ms, AcpiConfiguration *conf)
> +{
> +    AcpiBuilderMethods *abm =3D ACPI_BUILDER_GET_METHODS(builder);
> +
> +    if (abm && abm->madt) {
> +        abm->madt(table_data, linker, ms, conf);
> +    }
> +}
> +
> +void acpi_builder_mcfg(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       AcpiMcfgInfo *info)
> +{
> +    AcpiBuilderMethods *abm =3D ACPI_BUILDER_GET_METHODS(builder);
> +
> +    if (abm && abm->mcfg) {
> +        abm->mcfg(table_data, linker, info);
> +    }
> +}
> +
> +void acpi_builder_srat(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker,
> +                       MachineState *machine, AcpiConfiguration *conf)
> +{
> +    AcpiBuilderMethods *abm =3D ACPI_BUILDER_GET_METHODS(builder);
> +
> +    if (abm && abm->srat) {
> +        abm->srat(table_data, linker, machine, conf);
> +    }
> +}
> +
> +void acpi_builder_slit(AcpiBuilder *builder,
> +                       GArray *table_data, BIOSLinker *linker)
> +{
> +    AcpiBuilderMethods *abm =3D ACPI_BUILDER_GET_METHODS(builder);
> +
> +    if (abm && abm->slit) {
> +        abm->slit(table_data, linker);
> +    }
> +}
> +
> +AcpiConfiguration *acpi_builder_configuration(AcpiBuilder *builder)
> +{
> +    AcpiBuilderMethods *abm =3D ACPI_BUILDER_GET_METHODS(builder);
> +    if (abm && abm->configuration) {
> +        return abm->configuration(builder);
> +    }
> +    return NULL;
> +}
> +
> +static const TypeInfo acpi_builder_info =3D {
> +    .name          =3D TYPE_ACPI_BUILDER,
> +    .parent        =3D TYPE_INTERFACE,
> +    .class_size    =3D sizeof(AcpiBuilderMethods),
> +};
> +
> +static void acpi_builder_register_type(void)
> +{
> +    type_register_static(&acpi_builder_info);
> +}
> +
> +type_init(acpi_builder_register_type)
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 11c35bcb44..2f383adc6f 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-st=
ub.o
>  common-obj-y +=3D acpi_interface.o
>  common-obj-y +=3D bios-linker-loader.o
>  common-obj-y +=3D aml-build.o
> +common-obj-y +=3D builder.o
> =20
>  common-obj-$(CONFIG_IPMI) +=3D ipmi.o
>  common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
