Received: from eggs.gnu.org ([209.51.188.92]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1h16Tx-0001Yi-43
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1h16Tv-0000xP-7p
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:35:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46000
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1h16Tu-0000w4-Vs
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:35:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x259ZBHZ016402
	for <qemu-devel@nongnu.org>; Tue, 5 Mar 2019 04:35:25 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r1pj4048h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 04:35:22 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Tue, 5 Mar 2019 09:35:19 -0000
References: <20190301140623.5390-1-eric.auger@redhat.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Tue, 5 Mar 2019 15:05:11 +0530
MIME-Version: 1.0
In-Reply-To: <20190301140623.5390-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <e0565169-23e6-5934-47b1-478130ee987e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] machine: Move acpi_nvdimm_state into
 struct MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, richard.henderson@linaro.org



On 03/01/2019 07:36 PM, Eric Auger wrote:
> As NVDIMM support is looming for ARM and SPAPR, let's
> move the acpi_nvdimm_state to the generic machine struct
Name - "acpi_nvdimm_state" sounds very x86 specific.

Could you please rename ?

Thanks,
Shivaprasad
> instead of duplicating the same code in several machines.
>
> nvdimm and nvdimm-persistence become generic machine options.
> We also add a description for those options.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/core/machine.c        | 57 ++++++++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c     |  6 ++---
>   hw/i386/pc.c             | 56 +++------------------------------------
>   hw/i386/pc_piix.c        |  4 +--
>   hw/i386/pc_q35.c         |  4 +--
>   include/hw/boards.h      |  2 ++
>   include/hw/i386/pc.h     |  4 ---
>   include/hw/mem/pc-dimm.h |  1 -
>   8 files changed, 70 insertions(+), 64 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 766ca5899d..19a5ee7cd8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -481,6 +481,47 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
>       ms->memory_encryption = g_strdup(value);
>   }
>   
> +static bool machine_get_nvdimm(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return ms->acpi_nvdimm_state.is_enabled;
> +}
> +
> +static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    ms->acpi_nvdimm_state.is_enabled = value;
> +}
> +
> +static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return g_strdup(ms->acpi_nvdimm_state.persistence_string);
> +}
> +
> +static void machine_set_nvdimm_persistence(Object *obj, const char *value,
> +                                               Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +    AcpiNVDIMMState *nvdimm_state = &ms->acpi_nvdimm_state;
> +
> +    if (strcmp(value, "cpu") == 0)
> +        nvdimm_state->persistence = 3;
> +    else if (strcmp(value, "mem-ctrl") == 0)
> +        nvdimm_state->persistence = 2;
> +    else {
> +        error_setg(errp, "-machine nvdimm-persistence=%s: unsupported option",
> +                   value);
> +        return;
> +    }
> +
> +    g_free(nvdimm_state->persistence_string);
> +    nvdimm_state->persistence_string = g_strdup(value);
> +}
> +
>   void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
>   {
>       strList *item = g_new0(strList, 1);
> @@ -765,6 +806,20 @@ static void machine_class_init(ObjectClass *oc, void *data)
>           &error_abort);
>       object_class_property_set_description(oc, "memory-encryption",
>           "Set memory encryption object to use", &error_abort);
> +
> +    object_class_property_add_bool(oc, "nvdimm",
> +        machine_get_nvdimm, machine_set_nvdimm, &error_abort);
> +    object_class_property_set_description(oc, "nvdimm",
> +                                         "Set on/off to enable/disable NVDIMM "
> +                                         "instantiation", NULL);
> +
> +    object_class_property_add_str(oc, "nvdimm-persistence",
> +                                  machine_get_nvdimm_persistence,
> +                                  machine_set_nvdimm_persistence, &error_abort);
> +    object_class_property_set_description(oc, "nvdimm-persistence",
> +                                          "Set NVDIMM persistence"
> +                                          "Valid values are cpu and mem-ctrl",
> +                                          NULL);
>   }
>   
>   static void machine_class_base_init(ObjectClass *oc, void *data)
> @@ -790,6 +845,8 @@ static void machine_initfn(Object *obj)
>       ms->dump_guest_core = true;
>       ms->mem_merge = true;
>       ms->enable_graphics = true;
> +    /* nvdimm is disabled on default. */
> +    ms->acpi_nvdimm_state.is_enabled = false;
>   
>       /* Register notifier when init is done for sysbus sanity checks */
>       ms->sysbus_notifier.notify = machine_init_notify;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9ecc96dcc7..622ccb9408 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1867,7 +1867,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               aml_append(scope, method);
>           }
>   
> -        if (pcms->acpi_nvdimm_state.is_enabled) {
> +        if (machine->acpi_nvdimm_state.is_enabled) {
>               method = aml_method("_E04", 0, AML_NOTSERIALIZED);
>               aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
>                                             aml_int(0x80)));
> @@ -2704,9 +2704,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>               build_dmar_q35(tables_blob, tables->linker);
>           }
>       }
> -    if (pcms->acpi_nvdimm_state.is_enabled) {
> +    if (machine->acpi_nvdimm_state.is_enabled) {
>           nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
> -                          &pcms->acpi_nvdimm_state, machine->ram_slots);
> +                          &machine->acpi_nvdimm_state, machine->ram_slots);
>       }
>   
>       /* Add tables supplied by user (if any) */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3889eccdc3..356213e0b8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2096,6 +2096,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   {
>       const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>       const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    const MachineState *ms = MACHINE(hotplug_dev);
>       const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>       const uint64_t legacy_align = TARGET_PAGE_SIZE;
>   
> @@ -2110,7 +2111,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           return;
>       }
>   
> -    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> +    if (is_nvdimm && !ms->acpi_nvdimm_state.is_enabled) {
>           error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>           return;
>       }
> @@ -2124,6 +2125,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
>   {
>       Error *local_err = NULL;
>       PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
>       bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>   
>       pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
> @@ -2132,7 +2134,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
>       }
>   
>       if (is_nvdimm) {
> -        nvdimm_plug(&pcms->acpi_nvdimm_state);
> +        nvdimm_plug(&ms->acpi_nvdimm_state);
>       }
>   
>       hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
> @@ -2574,47 +2576,6 @@ static void pc_machine_set_smm(Object *obj, Visitor *v, const char *name,
>       visit_type_OnOffAuto(v, name, &pcms->smm, errp);
>   }
>   
> -static bool pc_machine_get_nvdimm(Object *obj, Error **errp)
> -{
> -    PCMachineState *pcms = PC_MACHINE(obj);
> -
> -    return pcms->acpi_nvdimm_state.is_enabled;
> -}
> -
> -static void pc_machine_set_nvdimm(Object *obj, bool value, Error **errp)
> -{
> -    PCMachineState *pcms = PC_MACHINE(obj);
> -
> -    pcms->acpi_nvdimm_state.is_enabled = value;
> -}
> -
> -static char *pc_machine_get_nvdimm_persistence(Object *obj, Error **errp)
> -{
> -    PCMachineState *pcms = PC_MACHINE(obj);
> -
> -    return g_strdup(pcms->acpi_nvdimm_state.persistence_string);
> -}
> -
> -static void pc_machine_set_nvdimm_persistence(Object *obj, const char *value,
> -                                               Error **errp)
> -{
> -    PCMachineState *pcms = PC_MACHINE(obj);
> -    AcpiNVDIMMState *nvdimm_state = &pcms->acpi_nvdimm_state;
> -
> -    if (strcmp(value, "cpu") == 0)
> -        nvdimm_state->persistence = 3;
> -    else if (strcmp(value, "mem-ctrl") == 0)
> -        nvdimm_state->persistence = 2;
> -    else {
> -        error_setg(errp, "-machine nvdimm-persistence=%s: unsupported option",
> -                   value);
> -        return;
> -    }
> -
> -    g_free(nvdimm_state->persistence_string);
> -    nvdimm_state->persistence_string = g_strdup(value);
> -}
> -
>   static bool pc_machine_get_smbus(Object *obj, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
> @@ -2664,8 +2625,6 @@ static void pc_machine_initfn(Object *obj)
>       pcms->max_ram_below_4g = 0; /* use default */
>       pcms->smm = ON_OFF_AUTO_AUTO;
>       pcms->vmport = ON_OFF_AUTO_AUTO;
> -    /* nvdimm is disabled on default. */
> -    pcms->acpi_nvdimm_state.is_enabled = false;
>       /* acpi build is enabled by default if machine supports it */
>       pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
>       pcms->smbus_enabled = true;
> @@ -2826,13 +2785,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       object_class_property_set_description(oc, PC_MACHINE_VMPORT,
>           "Enable vmport (pc & q35)", &error_abort);
>   
> -    object_class_property_add_bool(oc, PC_MACHINE_NVDIMM,
> -        pc_machine_get_nvdimm, pc_machine_set_nvdimm, &error_abort);
> -
> -    object_class_property_add_str(oc, PC_MACHINE_NVDIMM_PERSIST,
> -        pc_machine_get_nvdimm_persistence,
> -        pc_machine_set_nvdimm_persistence, &error_abort);
> -
>       object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
>           pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
>   
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fd0f2c268f..8b94b70f14 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -297,8 +297,8 @@ static void pc_init1(MachineState *machine,
>                                    PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
>       }
>   
> -    if (pcms->acpi_nvdimm_state.is_enabled) {
> -        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
> +    if (machine->acpi_nvdimm_state.is_enabled) {
> +        nvdimm_init_acpi_state(&machine->acpi_nvdimm_state, system_io,
>                                  pcms->fw_cfg, OBJECT(pcms));
>       }
>   }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 4a175ea50e..26727c964d 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -329,8 +329,8 @@ static void pc_q35_init(MachineState *machine)
>       pc_vga_init(isa_bus, host_bus);
>       pc_nic_init(pcmc, isa_bus, host_bus);
>   
> -    if (pcms->acpi_nvdimm_state.is_enabled) {
> -        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
> +    if (machine->acpi_nvdimm_state.is_enabled) {
> +        nvdimm_init_acpi_state(&machine->acpi_nvdimm_state, system_io,
>                                  pcms->fw_cfg, OBJECT(pcms));
>       }
>   }
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 05f9f45c3d..b55c9cc087 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -8,6 +8,7 @@
>   #include "hw/qdev.h"
>   #include "qom/object.h"
>   #include "qom/cpu.h"
> +#include "hw/mem/nvdimm.h"
>   
>   /**
>    * memory_region_allocate_system_memory - Allocate a board's main memory
> @@ -268,6 +269,7 @@ struct MachineState {
>       const char *cpu_type;
>       AccelState *accelerator;
>       CPUArchIdList *possible_cpus;
> +    AcpiNVDIMMState acpi_nvdimm_state;
>   };
>   
>   #define DEFINE_MACHINE(namestr, machine_initfn) \
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 3ff127ebd0..f7c59743e0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -45,8 +45,6 @@ struct PCMachineState {
>       OnOffAuto vmport;
>       OnOffAuto smm;
>   
> -    AcpiNVDIMMState acpi_nvdimm_state;
> -
>       bool acpi_build_enabled;
>       bool smbus_enabled;
>       bool sata_enabled;
> @@ -74,8 +72,6 @@ struct PCMachineState {
>   #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
>   #define PC_MACHINE_VMPORT           "vmport"
>   #define PC_MACHINE_SMM              "smm"
> -#define PC_MACHINE_NVDIMM           "nvdimm"
> -#define PC_MACHINE_NVDIMM_PERSIST   "nvdimm-persistence"
>   #define PC_MACHINE_SMBUS            "smbus"
>   #define PC_MACHINE_SATA             "sata"
>   #define PC_MACHINE_PIT              "pit"
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 01436b9f50..3e5489d3a1 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -19,7 +19,6 @@
>   #include "exec/memory.h"
>   #include "sysemu/hostmem.h"
>   #include "hw/qdev.h"
> -#include "hw/boards.h"
>   
>   #define TYPE_PC_DIMM "pc-dimm"
>   #define PC_DIMM(obj) \
