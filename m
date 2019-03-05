Received: from eggs.gnu.org ([209.51.188.92]:44769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h16YV-0002wD-Gl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h16YP-0007sf-5E
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:40:11 -0500
References: <20190301140623.5390-1-eric.auger@redhat.com>
	<e0565169-23e6-5934-47b1-478130ee987e@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <25a67533-b557-25dd-c528-0034fe06c3e2@redhat.com>
Date: Tue, 5 Mar 2019 10:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <e0565169-23e6-5934-47b1-478130ee987e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, richard.henderson@linaro.org

Hi Shivaprasad,

On 3/5/19 10:35 AM, Shivaprasad G Bhat wrote:
>=20
>=20
> On 03/01/2019 07:36 PM, Eric Auger wrote:
>> As NVDIMM support is looming for ARM and SPAPR, let's
>> move the acpi_nvdimm_state to the generic machine struct
> Name - "acpi_nvdimm_state" sounds very x86 specific.
>=20
> Could you please rename ?
Sure, do you have any suggestion?

Thanks

Eric
>=20
> Thanks,
> Shivaprasad
>> instead of duplicating the same code in several machines.
>>
>> nvdimm and nvdimm-persistence become generic machine options.
>> We also add a description for those options.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> =C2=A0 hw/core/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5=
7 ++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 hw/i386/acpi-build.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++---
>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 56 +++------------------------------------
>> =C2=A0 hw/i386/pc_piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +--
>> =C2=A0 hw/i386/pc_q35.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 4 +--
>> =C2=A0 include/hw/boards.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ---
>> =C2=A0 include/hw/mem/pc-dimm.h |=C2=A0 1 -
>> =C2=A0 8 files changed, 70 insertions(+), 64 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 766ca5899d..19a5ee7cd8 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -481,6 +481,47 @@ static void machine_set_memory_encryption(Object
>> *obj, const char *value,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->memory_encryption =3D g_strdup(valu=
e);
>> =C2=A0 }
>> =C2=A0 +static bool machine_get_nvdimm(Object *obj, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 MachineState *ms =3D MACHINE(obj);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ms->acpi_nvdimm_state.is_enabled;
>> +}
>> +
>> +static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 MachineState *ms =3D MACHINE(obj);
>> +
>> +=C2=A0=C2=A0=C2=A0 ms->acpi_nvdimm_state.is_enabled =3D value;
>> +}
>> +
>> +static char *machine_get_nvdimm_persistence(Object *obj, Error **errp=
)
>> +{
>> +=C2=A0=C2=A0=C2=A0 MachineState *ms =3D MACHINE(obj);
>> +
>> +=C2=A0=C2=A0=C2=A0 return g_strdup(ms->acpi_nvdimm_state.persistence_=
string);
>> +}
>> +
>> +static void machine_set_nvdimm_persistence(Object *obj, const char
>> *value,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 MachineState *ms =3D MACHINE(obj);
>> +=C2=A0=C2=A0=C2=A0 AcpiNVDIMMState *nvdimm_state =3D &ms->acpi_nvdimm=
_state;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (strcmp(value, "cpu") =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_state->persistence =
=3D 3;
>> +=C2=A0=C2=A0=C2=A0 else if (strcmp(value, "mem-ctrl") =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_state->persistence =
=3D 2;
>> +=C2=A0=C2=A0=C2=A0 else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "-machine=
 nvdimm-persistence=3D%s: unsupported
>> option",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(nvdimm_state->persistence_string);
>> +=C2=A0=C2=A0=C2=A0 nvdimm_state->persistence_string =3D g_strdup(valu=
e);
>> +}
>> +
>> =C2=A0 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, c=
onst
>> char *type)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strList *item =3D g_new0(strList, 1);
>> @@ -765,6 +806,20 @@ static void machine_class_init(ObjectClass *oc,
>> void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abort);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_class_property_set_description(o=
c, "memory-encryption",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Set memory enc=
ryption object to use", &error_abort);
>> +
>> +=C2=A0=C2=A0=C2=A0 object_class_property_add_bool(oc, "nvdimm",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_get_nvdimm, machin=
e_set_nvdimm, &error_abort);
>> +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "nvdimm"=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "Set on/off to
>> enable/disable NVDIMM "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "instantiation", NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 object_class_property_add_str(oc, "nvdimm-persiste=
nce",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_get_nvdimm=
_persistence,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_set_nvdimm=
_persistence,
>> &error_abort);
>> +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "nvdimm-=
persistence",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Set NVDIMM persistence"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Valid values are cpu and
>> mem-ctrl",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void machine_class_base_init(ObjectClass *oc, voi=
d *data)
>> @@ -790,6 +845,8 @@ static void machine_initfn(Object *obj)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->dump_guest_core =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->mem_merge =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->enable_graphics =3D true;
>> +=C2=A0=C2=A0=C2=A0 /* nvdimm is disabled on default. */
>> +=C2=A0=C2=A0=C2=A0 ms->acpi_nvdimm_state.is_enabled =3D false;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Register notifier when init i=
s done for sysbus sanity
>> checks */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->sysbus_notifier.notify =3D machine_=
init_notify;
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9ecc96dcc7..622ccb9408 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1867,7 +1867,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 aml_append(scope, method);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcms->acpi_nvdi=
mm_state.is_enabled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (machine->acpi_nvdimm_s=
tate.is_enabled) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 method =3D aml_method("_E04", 0, AML_NOTSERIALIZED);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_int(0x80)));
>> @@ -2704,9 +2704,9 @@ void acpi_build(AcpiBuildTables *tables,
>> MachineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 build_dmar_q35(tables_blob, tables->linker);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (pcms->acpi_nvdimm_state.is_enabled) {
>> +=C2=A0=C2=A0=C2=A0 if (machine->acpi_nvdimm_state.is_enabled) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_build_ac=
pi(table_offsets, tables_blob, tables->linker,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &pcms->acpi_nvdimm_state, machine->ram_slots);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &machine->acpi_nvdimm_state,
>> machine->ram_slots);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add tables supplied by user (=
if any) */
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3889eccdc3..356213e0b8 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2096,6 +2096,7 @@ static void pc_memory_pre_plug(HotplugHandler
>> *hotplug_dev, DeviceState *dev,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const PCMachineState *pcms =3D PC_MACHI=
NE(hotplug_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const PCMachineClass *pcmc =3D PC_MACHI=
NE_GET_CLASS(pcms);
>> +=C2=A0=C2=A0=C2=A0 const MachineState *ms =3D MACHINE(hotplug_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const bool is_nvdimm =3D object_dynamic=
_cast(OBJECT(dev),
>> TYPE_NVDIMM);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint64_t legacy_align =3D TARGET_=
PAGE_SIZE;
>> =C2=A0 @@ -2110,7 +2111,7 @@ static void pc_memory_pre_plug(HotplugHan=
dler
>> *hotplug_dev, DeviceState *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (is_nvdimm && !pcms->acpi_nvdimm_state.i=
s_enabled) {
>> +=C2=A0=C2=A0=C2=A0 if (is_nvdimm && !ms->acpi_nvdimm_state.is_enabled=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp=
, "nvdimm is not enabled: missing 'nvdimm' in
>> '-M'");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -2124,6 +2125,7 @@ static void pc_memory_plug(HotplugHandler
>> *hotplug_dev,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCMachineState *pcms =3D PC_MACHINE(hot=
plug_dev);
>> +=C2=A0=C2=A0=C2=A0 MachineState *ms =3D MACHINE(hotplug_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_nvdimm =3D object_dynamic_cast(=
OBJECT(dev), TYPE_NVDIMM);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_dimm_plug(PC_DIMM(dev), MACHI=
NE(pcms), &local_err);
>> @@ -2132,7 +2134,7 @@ static void pc_memory_plug(HotplugHandler
>> *hotplug_dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_nvdimm) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_plug(&pcms->acpi_nv=
dimm_state);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_plug(&ms->acpi_nvdi=
mm_state);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hotplug_handler_plug(HOTPLUG_HAN=
DLER(pcms->acpi_dev), dev,
>> &error_abort);
>> @@ -2574,47 +2576,6 @@ static void pc_machine_set_smm(Object *obj,
>> Visitor *v, const char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 visit_type_OnOffAuto(v, name, &pcms->sm=
m, errp);
>> =C2=A0 }
>> =C2=A0 -static bool pc_machine_get_nvdimm(Object *obj, Error **errp)
>> -{
>> -=C2=A0=C2=A0=C2=A0 PCMachineState *pcms =3D PC_MACHINE(obj);
>> -
>> -=C2=A0=C2=A0=C2=A0 return pcms->acpi_nvdimm_state.is_enabled;
>> -}
>> -
>> -static void pc_machine_set_nvdimm(Object *obj, bool value, Error **er=
rp)
>> -{
>> -=C2=A0=C2=A0=C2=A0 PCMachineState *pcms =3D PC_MACHINE(obj);
>> -
>> -=C2=A0=C2=A0=C2=A0 pcms->acpi_nvdimm_state.is_enabled =3D value;
>> -}
>> -
>> -static char *pc_machine_get_nvdimm_persistence(Object *obj, Error
>> **errp)
>> -{
>> -=C2=A0=C2=A0=C2=A0 PCMachineState *pcms =3D PC_MACHINE(obj);
>> -
>> -=C2=A0=C2=A0=C2=A0 return g_strdup(pcms->acpi_nvdimm_state.persistenc=
e_string);
>> -}
>> -
>> -static void pc_machine_set_nvdimm_persistence(Object *obj, const char
>> *value,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> -{
>> -=C2=A0=C2=A0=C2=A0 PCMachineState *pcms =3D PC_MACHINE(obj);
>> -=C2=A0=C2=A0=C2=A0 AcpiNVDIMMState *nvdimm_state =3D &pcms->acpi_nvdi=
mm_state;
>> -
>> -=C2=A0=C2=A0=C2=A0 if (strcmp(value, "cpu") =3D=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_state->persistence =
=3D 3;
>> -=C2=A0=C2=A0=C2=A0 else if (strcmp(value, "mem-ctrl") =3D=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_state->persistence =
=3D 2;
>> -=C2=A0=C2=A0=C2=A0 else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "-machine=
 nvdimm-persistence=3D%s: unsupported
>> option",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 g_free(nvdimm_state->persistence_string);
>> -=C2=A0=C2=A0=C2=A0 nvdimm_state->persistence_string =3D g_strdup(valu=
e);
>> -}
>> -
>> =C2=A0 static bool pc_machine_get_smbus(Object *obj, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCMachineState *pcms =3D PC_MACHINE(obj=
);
>> @@ -2664,8 +2625,6 @@ static void pc_machine_initfn(Object *obj)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->max_ram_below_4g =3D 0; /* use de=
fault */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->smm =3D ON_OFF_AUTO_AUTO;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->vmport =3D ON_OFF_AUTO_AUTO;
>> -=C2=A0=C2=A0=C2=A0 /* nvdimm is disabled on default. */
>> -=C2=A0=C2=A0=C2=A0 pcms->acpi_nvdimm_state.is_enabled =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* acpi build is enabled by default if =
machine supports it */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->acpi_build_enabled =3D
>> PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->smbus_enabled =3D true;
>> @@ -2826,13 +2785,6 @@ static void pc_machine_class_init(ObjectClass
>> *oc, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_class_property_set_description(o=
c, PC_MACHINE_VMPORT,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Enable vmport =
(pc & q35)", &error_abort);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 object_class_property_add_bool(oc, PC_MACHI=
NE_NVDIMM,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_machine_get_nvdimm, pc_=
machine_set_nvdimm, &error_abort);
>> -
>> -=C2=A0=C2=A0=C2=A0 object_class_property_add_str(oc, PC_MACHINE_NVDIM=
M_PERSIST,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_machine_get_nvdimm_pers=
istence,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_machine_set_nvdimm_pers=
istence, &error_abort);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_class_property_add_bool(oc, PC_M=
ACHINE_SMBUS,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_machine_get_=
smbus, pc_machine_set_smbus, &error_abort);
>> =C2=A0 diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index fd0f2c268f..8b94b70f14 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -297,8 +297,8 @@ static void pc_init1(MachineState *machine,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PC_MACHINE_ACPI=
_DEVICE_PROP,
>> &error_abort);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (pcms->acpi_nvdimm_state.is_enabled) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_init_acpi_state(&pc=
ms->acpi_nvdimm_state, system_io,
>> +=C2=A0=C2=A0=C2=A0 if (machine->acpi_nvdimm_state.is_enabled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_init_acpi_state(&ma=
chine->acpi_nvdimm_state, system_io,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->fw_cfg, OBJECT(pcms))=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 4a175ea50e..26727c964d 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -329,8 +329,8 @@ static void pc_q35_init(MachineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_vga_init(isa_bus, host_bus);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_nic_init(pcmc, isa_bus, host_bus);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (pcms->acpi_nvdimm_state.is_enabled) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_init_acpi_state(&pc=
ms->acpi_nvdimm_state, system_io,
>> +=C2=A0=C2=A0=C2=A0 if (machine->acpi_nvdimm_state.is_enabled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvdimm_init_acpi_state(&ma=
chine->acpi_nvdimm_state, system_io,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->fw_cfg, OBJECT(pcms))=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 05f9f45c3d..b55c9cc087 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -8,6 +8,7 @@
>> =C2=A0 #include "hw/qdev.h"
>> =C2=A0 #include "qom/object.h"
>> =C2=A0 #include "qom/cpu.h"
>> +#include "hw/mem/nvdimm.h"
>> =C2=A0 =C2=A0 /**
>> =C2=A0=C2=A0 * memory_region_allocate_system_memory - Allocate a board=
's main
>> memory
>> @@ -268,6 +269,7 @@ struct MachineState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *cpu_type;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AccelState *accelerator;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUArchIdList *possible_cpus;
>> +=C2=A0=C2=A0=C2=A0 AcpiNVDIMMState acpi_nvdimm_state;
>> =C2=A0 };
>> =C2=A0 =C2=A0 #define DEFINE_MACHINE(namestr, machine_initfn) \
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 3ff127ebd0..f7c59743e0 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -45,8 +45,6 @@ struct PCMachineState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OnOffAuto vmport;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OnOffAuto smm;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 AcpiNVDIMMState acpi_nvdimm_state;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool acpi_build_enabled;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool smbus_enabled;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool sata_enabled;
>> @@ -74,8 +72,6 @@ struct PCMachineState {
>> =C2=A0 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
>> =C2=A0 #define PC_MACHINE_VMPORT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "vmport"
>> =C2=A0 #define PC_MACHINE_SMM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "smm"
>> -#define PC_MACHINE_NVDIMM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "nvdimm"
>> -#define PC_MACHINE_NVDIMM_PERSIST=C2=A0=C2=A0 "nvdimm-persistence"
>> =C2=A0 #define PC_MACHINE_SMBUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "smbus"
>> =C2=A0 #define PC_MACHINE_SATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sata"
>> =C2=A0 #define PC_MACHINE_PIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pit"
>> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
>> index 01436b9f50..3e5489d3a1 100644
>> --- a/include/hw/mem/pc-dimm.h
>> +++ b/include/hw/mem/pc-dimm.h
>> @@ -19,7 +19,6 @@
>> =C2=A0 #include "exec/memory.h"
>> =C2=A0 #include "sysemu/hostmem.h"
>> =C2=A0 #include "hw/qdev.h"
>> -#include "hw/boards.h"
>> =C2=A0 =C2=A0 #define TYPE_PC_DIMM "pc-dimm"
>> =C2=A0 #define PC_DIMM(obj) \
>=20
>=20
