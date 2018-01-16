Received: from eggs.gnu.org ([2001:4830:134:3::10]:53130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebYeu-0001ny-60
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebYep-00054S-7j
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:20:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ebYep-00054D-2e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:20:35 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GLKATu158893
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 16:20:34 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fhm6w62ca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 16:20:33 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 16:20:32 -0500
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<8fa53398-2a94-a0ce-d093-390869f2b974@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 16:20:28 -0500
MIME-Version: 1.0
In-Reply-To: <8fa53398-2a94-a0ce-d093-390869f2b974@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5f662f71-f134-f990-0efe-8b78271ccd67@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] acpi: build QEMU table for PPI
 virtual memory device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, kevin@koconnor.net, marcandre.lureau@redhat.com

On 01/16/2018 03:42 PM, Laszlo Ersek wrote:
> On 01/16/18 16:51, Stefan Berger wrote:
>> To avoid having to hard code the base address of the PPI virtual memory
>> device we introduce a QEMU ACPI table that holds the base address, if a
>> TPM 1.2 or 2 is used. This table gives us flexibility to move the base
>> address later on.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/i386/acpi-build.c        | 19 +++++++++++++++++++
>>   include/hw/acpi/acpi-defs.h |  8 ++++++++
>>   2 files changed, 27 insertions(+)
> I don't understand how the guest OS is supposed to consume the QEMU
> table. The AML code in patch #4 does not seem to consume the QEMU table,
> for locating the operation region. I'm not saying that it *should*
> consume the QEMU table, only that I'm currently not seeing a use for the
> QEMU table.
>
> How is the QEMU table useful? What breaks if we drop it?

The QEMU table would only be consumed by SeaBIOS. Following the 
discussion on the SeaBIOS ML, we'll move this into a new fw_cfg file.

     Stefan

>
> (Sorry if we've been through this; then I must have lost context.)
>
> Thanks,
> Laszlo
>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 18b939e..522d6d2 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2628,6 +2628,20 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>>       return true;
>>   }
>>   
>> +static void build_qemu(GArray *table_data, BIOSLinker *linker,
>> +                       TPMVersion tpm_version)
>> +{
>> +    AcpiTableQemu *qemu = acpi_data_push(table_data, sizeof(*qemu));
>> +
>> +    if (tpm_version != TPM_VERSION_UNSPEC) {
>> +        qemu->tpmppi_addr = TPM_PPI_ADDR_BASE;
>> +        qemu->tpm_version = tpm_version;
>> +    }
>> +
>> +    build_header(linker, table_data,
>> +                 (void *)qemu, "QEMU", sizeof(*qemu), 1, "QEMU", "CONF");
>> +}
>> +
>>   static
>>   void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>   {
>> @@ -2734,6 +2748,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>                             &pcms->acpi_nvdimm_state, machine->ram_slots);
>>       }
>>   
>> +    if (misc.tpm_version != TPM_VERSION_UNSPEC) {
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        build_qemu(tables_blob, tables->linker, misc.tpm_version);
>> +    }
>> +
>>       /* Add tables supplied by user (if any) */
>>       for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
>>           unsigned len = acpi_table_len(u);
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index 80c8099..98764c1 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -573,6 +573,14 @@ struct Acpi20TPM2 {
>>   } QEMU_PACKED;
>>   typedef struct Acpi20TPM2 Acpi20TPM2;
>>   
>> +/* QEMU - Custom QEMU table */
>> +struct AcpiTableQemu {
>> +    ACPI_TABLE_HEADER_DEF
>> +    uint32_t tpmppi_addr;
>> +    uint8_t tpm_version; /* 1 = 1.2, 2 = 2 */
>> +};
>> +typedef struct AcpiTableQemu AcpiTableQemu;
>> +
>>   /* DMAR - DMA Remapping table r2.2 */
>>   struct AcpiTableDmar {
>>       ACPI_TABLE_HEADER_DEF
>>
