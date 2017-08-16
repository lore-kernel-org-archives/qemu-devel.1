Received: from eggs.gnu.org ([2001:4830:134:3::10]:53335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhup1-000792-Fq
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhuox-0002C9-E0
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:41:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:43852
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhuow-0002Aa-IB
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:41:03 -0400
References: <1502846811-32360-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170816111807.0275dd5d@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <d05d94e3-0216-8d18-7b51-56fa8161fd31@cn.fujitsu.com>
Date: Wed, 16 Aug 2017 17:40:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170816111807.0275dd5d@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/acpi: Select an node with memory for
 mapping memory hole to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com

Hi Igor,

At 08/16/2017 05:18 PM, Igor Mammedov wrote:
> On Wed, 16 Aug 2017 09:26:51 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>> Currently, Using the fisrt node without memory on the machine makes
>> QEMU unhappy. With this example command line:
>>   ... \
>>   -m 1024M,slots=4,maxmem=32G \
>>   -numa node,nodeid=0 \
>>   -numa node,mem=1024M,nodeid=1 \
>>   -numa node,nodeid=2 \
>>   -numa node,nodeid=3 \
>> Guest reports "No NUMA configuration found" and the NUMA topology is
>> wrong.
>>
>> This is because when QEMU builds ACPI SRAT, it regards node0 as the
>> default node to deal with the memory hole(640K-1M). this means the
>> node0 must have some memory(>1M), but, actually it can have no
>> memory.
>>
>> Fix this problem by replace the node0 with the first node which has
>> memory on it. Add a new function for each node. Also do some cleanup.
> It seems harmless but one never knows for sure,
> could you test it with different guests including old windows (up to XP)/
> linux (2.6 stable kernel) versions?
>

I have test it with the following guests:

windows 7.
linux 4.13-rc5.

will test it in linux (2.6 and 3.10 stable kernel).

Thanks,
	dou.

>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>> V2 --> V1:
>>   -Fix a coding style problem
>> Replace
>>     for (node = 0;
>>             node < pcms->numa_nodes && pcms->node_mem[node] == 0;
>>             node++);
>>
>> with
>>     for (node = 0; node < pcms->numa_nodes; node++) {
>>        if (pcms->node_mem[node] != 0) {
>>             break;
>>          }
>>
>>  hw/i386/acpi-build.c | 78 +++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 98dd424..f93d712 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2318,15 +2318,43 @@ build_tpm2(GArray *table_data, BIOSLinker *linker)
>>                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
>>  }
>>
>> +static uint64_t
>> +build_srat_node_entry(GArray *table_data, PCMachineState *pcms,
>> +                                int i, uint64_t mem_base, uint64_t mem_len)
>> +{
>> +    AcpiSratMemoryAffinity *numamem;
>> +    uint64_t next_base;
>> +
>> +    next_base = mem_base + mem_len;
>> +
>> +    /* Cut out the ACPI_PCI hole */
>> +    if (mem_base <= pcms->below_4g_mem_size &&
>> +        next_base > pcms->below_4g_mem_size) {
>> +        mem_len -= next_base - pcms->below_4g_mem_size;
>> +        if (mem_len > 0) {
>> +            numamem = acpi_data_push(table_data, sizeof *numamem);
>> +            build_srat_memory(numamem, mem_base, mem_len, i,
>> +                              MEM_AFFINITY_ENABLED);
>> +        }
>> +        mem_base = 1ULL << 32;
>> +        mem_len = next_base - pcms->below_4g_mem_size;
>> +        next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>> +    }
>> +    numamem = acpi_data_push(table_data, sizeof *numamem);
>> +    build_srat_memory(numamem, mem_base, mem_len, i,
>> +                      MEM_AFFINITY_ENABLED);
>> +    return next_base;
>> +}
>> +
>>  static void
>>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>  {
>>      AcpiSystemResourceAffinityTable *srat;
>>      AcpiSratMemoryAffinity *numamem;
>>
>> -    int i;
>> +    int i, node;
>>      int srat_start, numa_start, slots;
>> -    uint64_t mem_len, mem_base, next_base;
>> +    uint64_t mem_len, mem_base;
>>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>>      const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
>>      PCMachineState *pcms = PC_MACHINE(machine);
>> @@ -2370,36 +2398,30 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>      /* the memory map is a bit tricky, it contains at least one hole
>>       * from 640k-1M and possibly another one from 3.5G-4G.
>>       */
>> -    next_base = 0;
>> +
>>      numa_start = table_data->len;
>>
>> -    numamem = acpi_data_push(table_data, sizeof *numamem);
>> -    build_srat_memory(numamem, 0, 640 * 1024, 0, MEM_AFFINITY_ENABLED);
>> -    next_base = 1024 * 1024;
>> -    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
>> -        mem_base = next_base;
>> -        mem_len = pcms->node_mem[i - 1];
>> -        if (i == 1) {
>> -            mem_len -= 1024 * 1024;
>> +    /* get the first node which has memory and map the hole from 640K-1M */
>> +    for (node = 0; node < pcms->numa_nodes; node++) {
>> +        if (pcms->node_mem[node] != 0) {
>> +            break;
>>          }
>> -        next_base = mem_base + mem_len;
>> -
>> -        /* Cut out the ACPI_PCI hole */
>> -        if (mem_base <= pcms->below_4g_mem_size &&
>> -            next_base > pcms->below_4g_mem_size) {
>> -            mem_len -= next_base - pcms->below_4g_mem_size;
>> -            if (mem_len > 0) {
>> -                numamem = acpi_data_push(table_data, sizeof *numamem);
>> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
>> -                                  MEM_AFFINITY_ENABLED);
>> -            }
>> -            mem_base = 1ULL << 32;
>> -            mem_len = next_base - pcms->below_4g_mem_size;
>> -            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>> +    }
>> +    numamem = acpi_data_push(table_data, sizeof *numamem);
>> +    build_srat_memory(numamem, 0, 640 * 1024, node, MEM_AFFINITY_ENABLED);
>> +
>> +    /* map the rest of memory from 1M */
>> +    mem_base = 1024 * 1024;
>> +    mem_len = pcms->node_mem[node] - mem_base;
>> +    mem_base = build_srat_node_entry(table_data, pcms, node,
>> +                                            mem_base, mem_len);
>> +
>> +    for (i = 0; i < pcms->numa_nodes; i++) {
>> +        if (i == node) {
>> +            continue;
>>          }
>> -        numamem = acpi_data_push(table_data, sizeof *numamem);
>> -        build_srat_memory(numamem, mem_base, mem_len, i - 1,
>> -                          MEM_AFFINITY_ENABLED);
>> +        mem_base = build_srat_node_entry(table_data, pcms, i,
>> +                                            mem_base, pcms->node_mem[i]);
>>      }
>>      slots = (table_data->len - numa_start) / sizeof *numamem;
>>      for (; slots < pcms->numa_nodes + 2; slots++) {
>
>
>
>
