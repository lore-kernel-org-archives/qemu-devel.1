Received: from eggs.gnu.org ([209.51.188.92]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1wMJ-0001HU-OA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1wMI-0001H8-2q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:59:03 -0500
Date: Thu, 7 Mar 2019 13:58:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190307165840.GB8899@habkost.net>
References: <20190307090639.8261-1-eric.auger@redhat.com>
	<d36618f5-4dc4-f4a2-2cb3-9a689cb3f771@redhat.com>
	<8db3bb89-6b7f-fe6b-1ba5-3263da3d0528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8db3bb89-6b7f-fe6b-1ba5-3263da3d0528@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] machine: Move acpi_nvdimm_state into
 struct MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com

On Thu, Mar 07, 2019 at 04:15:21PM +0100, Auger Eric wrote:
> Hi Philippe, Eduardo,
>=20
> On 3/7/19 11:56 AM, Philippe Mathieu-Daud=E9 wrote:
> > Hi Eric, Eduardo,
> >=20
> > On 3/7/19 10:06 AM, Eric Auger wrote:
> >> As NVDIMM support is looming for ARM and SPAPR, let's
> >> move the acpi_nvdimm_state to the generic machine struct
> >> instead of duplicating the same code in several machines.
> >> It is also renamed into nvdimms_state.
> >>
> >> nvdimm and nvdimm-persistence become generic machine options.
> >> We also add a description for those options.
> >>
> >> We also remove the nvdimms_state.is_enabled initialization to
> >> false as objects are guaranteed to be zero initialized.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> >>
> >> ---
> >>
> >> v1 -> v2:
> >> - s/acpi_nvdimm_state/nvdimms_state
> >> - remove ms->nvdimms_state.is_enabled initialization to false.
> >> ---
> >>  hw/core/machine.c        | 55 +++++++++++++++++++++++++++++++++++++=
++
> >>  hw/i386/acpi-build.c     |  6 ++---
> >>  hw/i386/pc.c             | 56 +++----------------------------------=
---
> >>  hw/i386/pc_piix.c        |  4 +--
> >>  hw/i386/pc_q35.c         |  4 +--
> >>  include/hw/boards.h      |  2 ++
> >>  include/hw/i386/pc.h     |  4 ---
> >>  include/hw/mem/pc-dimm.h |  1 -
> >>  8 files changed, 68 insertions(+), 64 deletions(-)
> >>
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 766ca5899d..21a7209246 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -481,6 +481,47 @@ static void machine_set_memory_encryption(Objec=
t *obj, const char *value,
> >>      ms->memory_encryption =3D g_strdup(value);
> >>  }
> >> =20
> >> +static bool machine_get_nvdimm(Object *obj, Error **errp)
> >> +{
> >> +    MachineState *ms =3D MACHINE(obj);
> >> +
> >> +    return ms->nvdimms_state.is_enabled;
> >> +}
> >> +
> >> +static void machine_set_nvdimm(Object *obj, bool value, Error **err=
p)
> >> +{
> >> +    MachineState *ms =3D MACHINE(obj);
> >> +
> >> +    ms->nvdimms_state.is_enabled =3D value;
> >> +}
> >> +
> >> +static char *machine_get_nvdimm_persistence(Object *obj, Error **er=
rp)
> >> +{
> >> +    MachineState *ms =3D MACHINE(obj);
> >> +
> >> +    return g_strdup(ms->nvdimms_state.persistence_string);
> >> +}
> >> +
> >> +static void machine_set_nvdimm_persistence(Object *obj, const char =
*value,
> >> +                                               Error **errp)
> >> +{
> >> +    MachineState *ms =3D MACHINE(obj);
> >> +    AcpiNVDIMMState *nvdimms_state =3D &ms->nvdimms_state;
> >> +
> >> +    if (strcmp(value, "cpu") =3D=3D 0)
> >> +        nvdimms_state->persistence =3D 3;
> >> +    else if (strcmp(value, "mem-ctrl") =3D=3D 0)
> >> +        nvdimms_state->persistence =3D 2;
> >> +    else {
> >> +        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsuppo=
rted option",
> >> +                   value);
> >> +        return;
> >> +    }
> >> +
> >> +    g_free(nvdimms_state->persistence_string);
> >> +    nvdimms_state->persistence_string =3D g_strdup(value);
> >> +}
> >> +
> >>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const=
 char *type)
> >>  {
> >>      strList *item =3D g_new0(strList, 1);
> >> @@ -765,6 +806,20 @@ static void machine_class_init(ObjectClass *oc,=
 void *data)
> >>          &error_abort);
> >>      object_class_property_set_description(oc, "memory-encryption",
> >>          "Set memory encryption object to use", &error_abort);
> >> +
> >> +    object_class_property_add_bool(oc, "nvdimm",
> >> +        machine_get_nvdimm, machine_set_nvdimm, &error_abort);
> >> +    object_class_property_set_description(oc, "nvdimm",
> >> +                                         "Set on/off to enable/disa=
ble NVDIMM "
> >> +                                         "instantiation", NULL);
> >> +
> >> +    object_class_property_add_str(oc, "nvdimm-persistence",
> >> +                                  machine_get_nvdimm_persistence,
> >> +                                  machine_set_nvdimm_persistence, &=
error_abort);
> >> +    object_class_property_set_description(oc, "nvdimm-persistence",
> >> +                                          "Set NVDIMM persistence"
> >> +                                          "Valid values are cpu and=
 mem-ctrl",
> >> +                                          NULL);
> >>  }
> >> =20
> >>  static void machine_class_base_init(ObjectClass *oc, void *data)
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 9ecc96dcc7..2d7d46fe50 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1867,7 +1867,7 @@ build_dsdt(GArray *table_data, BIOSLinker *lin=
ker,
> >>              aml_append(scope, method);
> >>          }
> >> =20
> >> -        if (pcms->acpi_nvdimm_state.is_enabled) {
> >> +        if (machine->nvdimms_state.is_enabled) {
> >>              method =3D aml_method("_E04", 0, AML_NOTSERIALIZED);
> >>              aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
> >>                                            aml_int(0x80)));
> >> @@ -2704,9 +2704,9 @@ void acpi_build(AcpiBuildTables *tables, Machi=
neState *machine)
> >>              build_dmar_q35(tables_blob, tables->linker);
> >>          }
> >>      }
> >> -    if (pcms->acpi_nvdimm_state.is_enabled) {
> >> +    if (machine->nvdimms_state.is_enabled) {
> >>          nvdimm_build_acpi(table_offsets, tables_blob, tables->linke=
r,
> >> -                          &pcms->acpi_nvdimm_state, machine->ram_sl=
ots);
> >> +                          &machine->nvdimms_state, machine->ram_slo=
ts);
> >>      }
> >> =20
> >>      /* Add tables supplied by user (if any) */
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 42128183e9..cacc4068cf 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -2069,6 +2069,7 @@ static void pc_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> >>  {
> >>      const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> >>      const PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> >> +    const MachineState *ms =3D MACHINE(hotplug_dev);
> >>      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_=
NVDIMM);
> >>      const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
> >> =20
> >> @@ -2083,7 +2084,7 @@ static void pc_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> >>          return;
> >>      }
> >> =20
> >> -    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> >> +    if (is_nvdimm && !ms->nvdimms_state.is_enabled) {
> >>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' i=
n '-M'");
> >>          return;
> >>      }
> >> @@ -2097,6 +2098,7 @@ static void pc_memory_plug(HotplugHandler *hot=
plug_dev,
> >>  {
> >>      Error *local_err =3D NULL;
> >>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> >> +    MachineState *ms =3D MACHINE(hotplug_dev);
> >>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM=
);
> >> =20
> >>      pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
> >> @@ -2105,7 +2107,7 @@ static void pc_memory_plug(HotplugHandler *hot=
plug_dev,
> >>      }
> >> =20
> >>      if (is_nvdimm) {
> >> -        nvdimm_plug(&pcms->acpi_nvdimm_state);
> >> +        nvdimm_plug(&ms->nvdimms_state);
> >>      }
> >> =20
> >>      hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &err=
or_abort);
> >> @@ -2546,47 +2548,6 @@ static void pc_machine_set_smm(Object *obj, V=
isitor *v, const char *name,
> >>      visit_type_OnOffAuto(v, name, &pcms->smm, errp);
> >>  }
> >> =20
> >> -static bool pc_machine_get_nvdimm(Object *obj, Error **errp)
> >> -{
> >> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> >> -
> >> -    return pcms->acpi_nvdimm_state.is_enabled;
> >> -}
> >> -
> >> -static void pc_machine_set_nvdimm(Object *obj, bool value, Error **=
errp)
> >> -{
> >> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> >> -
> >> -    pcms->acpi_nvdimm_state.is_enabled =3D value;
> >> -}
> >> -
> >> -static char *pc_machine_get_nvdimm_persistence(Object *obj, Error *=
*errp)
> >> -{
> >> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> >> -
> >> -    return g_strdup(pcms->acpi_nvdimm_state.persistence_string);
> >> -}
> >> -
> >> -static void pc_machine_set_nvdimm_persistence(Object *obj, const ch=
ar *value,
> >> -                                               Error **errp)
> >> -{
> >> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> >> -    AcpiNVDIMMState *nvdimm_state =3D &pcms->acpi_nvdimm_state;
> >> -
> >> -    if (strcmp(value, "cpu") =3D=3D 0)
> >> -        nvdimm_state->persistence =3D 3;
> >> -    else if (strcmp(value, "mem-ctrl") =3D=3D 0)
> >> -        nvdimm_state->persistence =3D 2;
> >> -    else {
> >> -        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsuppo=
rted option",
> >> -                   value);
> >> -        return;
> >> -    }
> >> -
> >> -    g_free(nvdimm_state->persistence_string);
> >> -    nvdimm_state->persistence_string =3D g_strdup(value);
> >> -}
> >> -
> >>  static bool pc_machine_get_smbus(Object *obj, Error **errp)
> >>  {
> >>      PCMachineState *pcms =3D PC_MACHINE(obj);
> >> @@ -2636,8 +2597,6 @@ static void pc_machine_initfn(Object *obj)
> >>      pcms->max_ram_below_4g =3D 0; /* use default */
> >>      pcms->smm =3D ON_OFF_AUTO_AUTO;
> >>      pcms->vmport =3D ON_OFF_AUTO_AUTO;
> >> -    /* nvdimm is disabled on default. */
> >> -    pcms->acpi_nvdimm_state.is_enabled =3D false;
> >>      /* acpi build is enabled by default if machine supports it */
> >>      pcms->acpi_build_enabled =3D PC_MACHINE_GET_CLASS(pcms)->has_ac=
pi_build;
> >>      pcms->smbus_enabled =3D true;
> >> @@ -2798,13 +2757,6 @@ static void pc_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      object_class_property_set_description(oc, PC_MACHINE_VMPORT,
> >>          "Enable vmport (pc & q35)", &error_abort);
> >> =20
> >> -    object_class_property_add_bool(oc, PC_MACHINE_NVDIMM,
> >> -        pc_machine_get_nvdimm, pc_machine_set_nvdimm, &error_abort)=
;
> >> -
> >> -    object_class_property_add_str(oc, PC_MACHINE_NVDIMM_PERSIST,
> >> -        pc_machine_get_nvdimm_persistence,
> >> -        pc_machine_set_nvdimm_persistence, &error_abort);
> >> -
> >>      object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
> >>          pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
> >> =20
> >> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >> index 8770ecada9..16ebfc5a5a 100644
> >> --- a/hw/i386/pc_piix.c
> >> +++ b/hw/i386/pc_piix.c
> >> @@ -297,8 +297,8 @@ static void pc_init1(MachineState *machine,
> >>                                   PC_MACHINE_ACPI_DEVICE_PROP, &erro=
r_abort);
> >>      }
> >> =20
> >> -    if (pcms->acpi_nvdimm_state.is_enabled) {
> >> -        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
> >> +    if (machine->nvdimms_state.is_enabled) {
> >> +        nvdimm_init_acpi_state(&machine->nvdimms_state, system_io,
> >>                                 pcms->fw_cfg, OBJECT(pcms));
> >>      }
> >>  }
> >> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> >> index cfb9043e12..dacaa90611 100644
> >> --- a/hw/i386/pc_q35.c
> >> +++ b/hw/i386/pc_q35.c
> >> @@ -329,8 +329,8 @@ static void pc_q35_init(MachineState *machine)
> >>      pc_vga_init(isa_bus, host_bus);
> >>      pc_nic_init(pcmc, isa_bus, host_bus);
> >> =20
> >> -    if (pcms->acpi_nvdimm_state.is_enabled) {
> >> -        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
> >> +    if (machine->nvdimms_state.is_enabled) {
> >> +        nvdimm_init_acpi_state(&machine->nvdimms_state, system_io,
> >>                                 pcms->fw_cfg, OBJECT(pcms));
> >>      }
> >>  }
> >> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >> index 9690c71a6d..ccf0c5a69d 100644
> >> --- a/include/hw/boards.h
> >> +++ b/include/hw/boards.h
> >> @@ -8,6 +8,7 @@
> >>  #include "hw/qdev.h"
> >>  #include "qom/object.h"
> >>  #include "qom/cpu.h"
> >> +#include "hw/mem/nvdimm.h"
> >> =20
> >>  /**
> >>   * memory_region_allocate_system_memory - Allocate a board's main m=
emory
> >> @@ -272,6 +273,7 @@ struct MachineState {
> >>      const char *cpu_type;
> >>      AccelState *accelerator;
> >>      CPUArchIdList *possible_cpus;
> >> +    AcpiNVDIMMState nvdimms_state;
> >=20
> > It looks we are breaking the generic/abstract machine design.
> > You introduce 2 specific concepts here, ACPI and NVDIMM.
> at least this should be renamed NVDIMMState according to last Igor's
> comment.
> >=20
> > MachineClass tries to be generic, and and still suffer from specific
> > fields inherited from the PC Machine.
> >=20
> > I'd use an intermediate Memory-related object between Machine and
> > AcpiNVDIMM states.
> >=20
> > I see there already is DeviceMemoryState.
> >=20
> > Can AcpiNVDIMMState go there? That would be more acceptable IMHO.
> DeviceMemoryState is also declared in include/hw/boards.h so does it
> hide any details.
>=20
> Not every machine has device memory or irqchip_split either for instanc=
e
> (ARM virt is a good example). So my understanding is we put in
> MachineState fields that are generic enough to be used by several
> machines and avoid duplication.
>=20
> Eduardo, do you have any objection wrt putting this state in the base
> machine?

I am not against having code and fields in MachineState that
apply to just a few machines.  I would even prefer that instead
of adding even more complexity to the QOM tree and/or QOM type
hierarchy.

But I would make the it a pointer to an incomplete type, to avoid
the boards.h -> nvdimm.h header dependency.

--=20
Eduardo
