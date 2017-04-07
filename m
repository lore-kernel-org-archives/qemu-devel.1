Received: from eggs.gnu.org ([2001:4830:134:3::10]:39655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1cwQXc-0007Ex-GX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1cwQXa-0001hl-IC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:50:52 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:35907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists@philjordan.eu>) id 1cwQXa-0001hc-BW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:50:50 -0400
Received: by mail-vk0-x241.google.com with SMTP id d188so8865093vka.3
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 02:50:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8aRUOSvne8B=Uk1g7QByyNeNOY1o-A7ap_L1dqeOG5_g@mail.gmail.com>
References: <20170406212209.22788-1-ard.biesheuvel@linaro.org>
	<20170407085513.czs6tsbwhkecfjrq@kamzik.brq.redhat.com>
	<64d6ad1d-d9ce-2bbb-dfb9-35938f9593ec@redhat.com>
	<CAAibmn3D_vWCv0HwZ607ejESDEnf2i5QVZTfJBM29hRgqqdu_A@mail.gmail.com>
	<CAKv+Gu8aRUOSvne8B=Uk1g7QByyNeNOY1o-A7ap_L1dqeOG5_g@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 7 Apr 2017 21:50:28 +1200
Message-ID: <CAGCz3vt3mOmy-7jCSZY4Vs4qokeK8eSV7ifBJncD9Cv8+fkMtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: generate 64-bit addressable
 ACPI objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Fri, Apr 7, 2017 at 9:44 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 7 April 2017 at 10:36, Phil Dennis-Jordan <phil@philjordan.eu> wrote:
>> On 7 April 2017 at 21:11, Laszlo Ersek <lersek@redhat.com> wrote:
>>> On 04/07/17 10:55, Andrew Jones wrote:
>>>> On Thu, Apr 06, 2017 at 10:22:09PM +0100, Ard Biesheuvel wrote:
>>>>> Our current ACPI table generation code limits the placement of ACPI
>>>>> tables to 32-bit addressable memory, in order to be able to emit the
>>>>> root pointer (RSDP) and root table (RSDT) using table types from the
>>>>> ACPI 1.0 days.
>>>>>
>>>>> Since ARM was not supported by ACPI before version 5.0, it makes sense
>>>>> to lift this restriction. This is not crucial for mach-virt, which is
>>>>> guaranteed to have some memory available below the 4 GB mark, but it
>>>>> is a nice to have for QEMU machines that do not have any 32-bit
>>>>> addressable, not unlike some real world 64-bit ARM systems.
>>
>> "QEMU machines that do not have any 32-bit addressable memory," perhaps?
>>
>
> Yes, better.
>
>>>>> Since we already emit a version of the RSDP root pointer that carries
>>>>> a 64-bit wide address for the 64-bit root table (XSDT), all we need to
>>>>> do is replace the RSDT generation with the generation of an XSDT table,
>>>>> and use a different slot in the FADT table to refer to the DSDT.
>>>>>
>>>>> Note that this only modifies the private interaction between QEMU and
>>>>> UEFI. Since these tables are all handled by the generic AcpiTableDxe
>>>>> driver which generates its own RSDP, RSDT and XSDT tables and manages
>>>>> the DSDT pointer in FADT itself, the tables that are present to the
>>>>> guest are identical, and so no mach-virt versioning is required for
>>>>> this change.
>>>
>>> The last paragraph could be dropped from the commit message (or trimmed
>>> a bit). Not really necessary, saying it just FYI. Namely, we don't
>>> version firmware blobs (i.e., we don't tie different firmware blobs to
>>> different versions of a machine type), and ACPI tables are considered
>>> part of the firmware (from the OS's POV), despite the fact that
>>> technically we generate them in QEMU. So, in my understanding, the ACPI
>>> content we generate never needs to consider machine types.
>>>
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> ---
>>>>>  hw/arm/virt-acpi-build.c    | 55 ++++++++++++++++++++++++++++++++++-----------
>>>>>  include/hw/acpi/acpi-defs.h | 11 +++++++++
>>>>>  2 files changed, 53 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>>> index b173bd109b91..d18368094c00 100644
>>>>> --- a/hw/arm/virt-acpi-build.c
>>>>> +++ b/hw/arm/virt-acpi-build.c
>>>>> @@ -391,12 +391,12 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>>>>>
>>>>>  /* RSDP */
>>>>>  static GArray *
>>>>> -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
>>>>> +build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>>>>>  {
>>>>>      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
>>>>> -    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
>>>>> -    unsigned rsdt_pa_offset =
>>>>> -        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
>>>>> +    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
>>>>> +    unsigned xsdt_pa_offset =
>>>>> +        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
>>>>>
>>>>>      bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
>>>>>                               true /* fseg memory */);
>>>>> @@ -408,8 +408,8 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
>>>>>
>>>>>      /* Address to be filled by Guest linker */
>>>>>      bios_linker_loader_add_pointer(linker,
>>>>> -        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
>>>>> -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
>>>>> +        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
>>>>> +        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
>>>>>
>>>>>      /* Checksum to be filled by Guest linker */
>>>>>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>>>>> @@ -686,7 +686,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
>>>>>                         VirtMachineState *vms, unsigned dsdt_tbl_offset)
>>>>>  {
>>>>>      AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
>>>>> -    unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
>>>>> +    unsigned xdsdt_entry_offset = (char *)&fadt->Xdsdt - table_data->data;
>>>>>      uint16_t bootflags;
>>>>>
>>>>>      switch (vms->psci_conduit) {
>>>>> @@ -712,7 +712,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
>>>>>
>>>>>      /* DSDT address to be filled by Guest linker */
>>>>>      bios_linker_loader_add_pointer(linker,
>>>>> -        ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>>>>> +        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->Xdsdt),
>>>>>          ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>>>>>
>>>>>      build_header(linker, table_data,
>>
>> I don't know what it's like in ARM-Land, but X64 Windows does not take
>> kindly to a zero DSDT pointer in my experience. It might make sense to
>> make the choice between DSDT and XDSDT conditional on whether the
>> pointer is actually above 4GB? Mind you, I don't even know if
>> Microsoft makes ARM variants of Windows generally available, and
>> whether they currently work in Qemu; the FOSS OSes are typically more
>> lenient.
>>
>
> Documentation/arm64/acpi_object_usage.txt in the kernel contains this under FADT
>
>    For the DSDT that is also required, the X_DSDT field is to be used,
>    not the DSDT field.
>
> and so we should be using xdsdt anyway.

IME, what the documentation & standard say can diverge wildly from
what shipping OSes actually expect. That's all I'm saying. :-)

> *However*, this is all moot
> given that UEFI is in charge of populating these fields. What we
> generate here and what the guest sees are two different things that
> are almost completely disconnected when it comes to RSDP, RSDT/XSDT
> and the DSDT field in FADT.

Indeed. For x86 we have to care about SeaBIOS of course, I guess on
ARM there's no such concern.

>> See also the discussion in this thread on qemu-devel:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05754.html
>> and a related issue on edk2-devel:
>> https://lists.01.org/pipermail/edk2-devel/2017-March/008460.html
>>
>>>>> @@ -772,12 +772,41 @@ struct AcpiBuildState {
>>>>>      bool patched;
>>>>>  } AcpiBuildState;
>>>>>
>>>>> +/* Build xsdt table */
>>>>> +
>>>>> +static
>>>>> +void build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
>>>>> +                const char *oem_id, const char *oem_table_id)
>>>>> +{
>>>>> +    int i;
>>>>> +    unsigned xsdt_entries_offset;
>>>>> +    AcpiXsdtDescriptorRev2 *xsdt;
>>>>> +    const unsigned table_data_len = (sizeof(uint64_t) * table_offsets->len);
>>>>> +    const unsigned xsdt_entry_size = sizeof(xsdt->table_offset_entry[0]);
>>>>> +    const size_t xsdt_len = sizeof(*xsdt) + table_data_len;
>>>>> +
>>>>> +    xsdt = acpi_data_push(table_data, xsdt_len);
>>>>> +    xsdt_entries_offset = (char *)xsdt->table_offset_entry - table_data->data;
>>>>> +    for (i = 0; i < table_offsets->len; ++i) {
>>>>> +        uint64_t ref_tbl_offset = g_array_index(table_offsets, uint32_t, i);
>>>>> +        uint64_t xsdt_entry_offset = xsdt_entries_offset + xsdt_entry_size * i;
>>>>> +
>>>>> +        /* xsdt->table_offset_entry to be filled by Guest linker */
>>>>> +        bios_linker_loader_add_pointer(linker,
>>>>> +            ACPI_BUILD_TABLE_FILE, xsdt_entry_offset, xsdt_entry_size,
>>>>> +            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
>>>>> +    }
>>>>> +    build_header(linker, table_data,
>>>>> +                 (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
>>>>> +}
>>>>
>>>> build_xsdt should probably go in hw/acpi/aml-build.c
>>>>
>>>>> +
>>>>> +
>>>>>  static
>>>>>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>>>>  {
>>>>>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>>>>      GArray *table_offsets;
>>>>> -    unsigned dsdt, rsdt;
>>>>> +    unsigned dsdt, xsdt;
>>>>>      GArray *tables_blob = tables->table_data;
>>>>>
>>>>>      table_offsets = g_array_new(false, true /* clear */,
>>>>> @@ -817,12 +846,12 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>>>>          build_iort(tables_blob, tables->linker);
>>>>>      }
>>>>>
>>>>> -    /* RSDT is pointed to by RSDP */
>>>>> -    rsdt = tables_blob->len;
>>>>> -    build_rsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
>>>>> +    /* XSDT is pointed to by RSDP */
>>>>> +    xsdt = tables_blob->len;
>>>>> +    build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
>>>>>
>>>>>      /* RSDP is in FSEG memory, so allocate it separately */
>>>>> -    build_rsdp(tables->rsdp, tables->linker, rsdt);
>>>>> +    build_rsdp(tables->rsdp, tables->linker, xsdt);
>>>>>
>>>>>      /* Cleanup memory that's no longer used. */
>>>>>      g_array_free(table_offsets, true);
>>>>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>>>>> index 4cc3630e613e..bf37acf4c4c6 100644
>>>>> --- a/include/hw/acpi/acpi-defs.h
>>>>> +++ b/include/hw/acpi/acpi-defs.h
>>>>> @@ -238,6 +238,17 @@ struct AcpiRsdtDescriptorRev1
>>>>>  typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescriptorRev1;
>>>>>
>>>>>  /*
>>>>> + * ACPI 2.0 eXtended System Description Table (XSDT)
>>>>> + */
>>>>> +struct AcpiXsdtDescriptorRev2
>>>>> +{
>>>>> +    ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
>>>>> +    uint64_t table_offset_entry[0];  /* Array of pointers to other */
>>>>> +    /* ACPI tables */
>>>>> +} QEMU_PACKED;
>>>>> +typedef struct AcpiXsdtDescriptorRev2 AcpiXsdtDescriptorRev2;
>>>>> +
>>>>> +/*
>>>>>   * ACPI 1.0 Firmware ACPI Control Structure (FACS)
>>>>>   */
>>>>>  struct AcpiFacsDescriptorRev1
>>>>> --
>>>>> 2.9.3
>>>>>
>>>>>
>>>>
>>>> Otherwise
>>>>
>>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>>>
>>>
>>> Great, I didn't want to be the first one to provide public feedback. :)
>>>
>>> Personally I'm fine if we keep the XSDT generation local to
>>> "hw/arm/virt-acpi-build.c" for now, and we upstream it to
>>> "hw/acpi/aml-build.c" later (for example when i386 actually puts it to
>>> use -- which shouldn't be that far out, AIUI, since Phil will probably
>>> need XSDT for OSX guests). However, I also wouldn't mind if the XSDT
>>> builder were moved to "hw/acpi/aml-build.c" right now.
>>
>> FWIW, OS X guests don't appear to care about an XSDT, and I'm not
>> planning any work in that area. My patch only affects the x86 FADT
>> (Rev1->Rev3). From what I saw, this is, aside from the struct
>> definition, completely independent from Qemu's ARM FADT, which I think
>> has always used the Rev5(.1?) variant.
>> (Are patches for 2.10 already being accepted? Michael previously said
>> I should wait until 2.9 is out, that's the only reason I'm still
>> hanging onto my patch.)
>>
>>> So one way or another,
>>>
>>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>>
>>> Thanks
>>> Laszlo
>
