Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djOmI-00077T-Hj
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 07:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djOmF-0001wL-Cn
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 07:52:26 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48817
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djOmE-0001t6-Fs
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 07:52:23 -0400
References: <1502847935-20483-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<9e5b10ce-6259-a21b-01dc-13f57d28a0ef@cn.fujitsu.com>
	<20170818164852.GZ3108@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e67b5c35-5077-2603-f0ca-6abcade205db@cn.fujitsu.com>
Date: Sun, 20 Aug 2017 19:52:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170818164852.GZ3108@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/acpi-build: Fix SRAT memory building
 when there is no memory in node0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

Hi Eduardo,

At 08/19/2017 12:48 AM, Eduardo Habkost wrote:
> On Thu, Aug 17, 2017 at 01:58:40PM +0800, Dou Liyang wrote:
>> Hi Igor,
>>
>> I tested this patch with following guests:
>>
>> 1. RHEL 6.5 with Linux 2.6.32
>> 2. RHEL 7.0 with Linux 3.10.0
>> 3. Fedora 23 with Linux 4.13.0-rc5
>> 4. window 2003 service
>> 5. window 7
>> 6. window 10
>
> What's the command-line(s) you have tested with each OS?  Have
>

I am sorry, one of the command-lines for the node0-without-RAM:

./x86_64-softmmu/qemu-system-x86_64 \
	-hda /home/douly/image/rhel6.5.qcow2 \
	-m 2G,slots=4,maxmem=32G \
	-enable-kvm \
	-smp 2,maxcpus=8,sockets=2,cores=2,threads=2\
	-object memory-backend-ram,id=mem0,size=1024M \
	-object memory-backend-ram,id=mem1,size=1024M \
	-object memory-backend-ram,id=mem2,size=1024M \
	-object memory-backend-ram,id=mem3,size=1024M \
	-device pc-dimm,id=dimm0,memdev=mem0,slot=0,node=0 \
	-device pc-dimm,id=dimm1,memdev=mem1,slot=1,node=1 \
	-device pc-dimm,id=dimm2,memdev=mem2,slot=2,node=2 \
	-device pc-dimm,id=dimm3,memdev=mem3,slot=3,node=3 \
	-device qemu64-x86_64-cpu,id=cpu2,socket-id=0,core-id=1,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu3,socket-id=0,core-id=1,thread-id=1 \
	-device qemu64-x86_64-cpu,id=cpu4,socket-id=1,core-id=0,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu5,socket-id=1,core-id=0,thread-id=1 \
	-device qemu64-x86_64-cpu,id=cpu6,socket-id=1,core-id=1,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu7,socket-id=1,core-id=1,thread-id=1 \
	-numa node,nodeid=0,cpus=0-1 \
	-numa node,mem=2G,nodeid=1,cpus=2-3 \
	-numa node,nodeid=2,cpus=4-5 \
	-numa node,nodeid=3,cpus=6-7 \
	-serial stdio \
	-monitor telnet:127.0.0.1:4444,server,nowait \
#	-kernel /home/douly/openSource/linux/arch/x86_64/boot/bzImage \
#	-append "root=/dev/mapper/fedora_s3101490-root console=tty0 
console=ttyS0 earlyprintk=ttyS0,115200n8 movable_node" \
#	-initrd /home/douly/openSource/initramfs_image/4.13.0.img \
  you tested both the node0-with-RAM and node0-without-RAM cases?
>

Yes, I tested three cases for each guests:

Case 1)  all node with RAM.

	-numa node,nodeid=0,cpus=0-1 \
	-numa node,nodeid=1,cpus=2-3 \
	-numa node,nodeid=2,cpus=4-5 \
	-numa node,nodeid=3,cpus=6-7 \

Case 2) the node0-with-RAM:

	-numa node,mem=2G,nodeid=0,cpus=0-1 \
	-numa node,nodeid=1,cpus=2-3 \
	-numa node,nodeid=2,cpus=4-5 \
	-numa node,nodeid=3,cpus=6-7 \

Case 3) the node0-without-RAM:

	-numa node,nodeid=0,cpus=0-1 \
	-numa node,mem=2G,nodeid=1,cpus=2-3 \
	-numa node,nodeid=2,cpus=4-5 \
	-numa node,nodeid=3,cpus=6-7 \

> I would be interested in a demonstration that no bytes in the
> ACPI table are changed by this patch when there is some RAM

Yes, you are right, there is no change if node 0 has some RAM.
This patch just works for the node0-without-RAM situation.

> configured in node 0.  (Is that already covered by our existing
> ACPI test cases?)

I am not sure it, could you tell me where are the SRAT test cases?
Seems there is no test cases about SRAT in bios-tables-test.c.

>
> A new test case in bios-tables-test.c for the bug you are fixing
> would be nice to have.
>

Ok, I will do it right now.

Thanks,
	dou.
>>


>> Thanks,
>> 	dou.
>>
>> At 08/16/2017 09:45 AM, Dou Liyang wrote:
>>> Currently, Using the fisrt node without memory on the machine makes
>>> QEMU unhappy. With this example command line:
>>>   ... \
>>>   -m 1024M,slots=4,maxmem=32G \
>>>   -numa node,nodeid=0 \
>>>   -numa node,mem=1024M,nodeid=1 \
>>>   -numa node,nodeid=2 \
>>>   -numa node,nodeid=3 \
>>> Guest reports "No NUMA configuration found" and the NUMA topology is
>>> wrong.
>>>
>>> This is because when QEMU builds ACPI SRAT, it regards node0 as the
>>> default node to deal with the memory hole(640K-1M). this means the
>>> node0 must have some memory(>1M), but, actually it can have no
>>> memory.
>>>
>>> Fix this problem by replace the node0 with the first node which has
>>> memory on it. Add a new function for each node. Also do some cleanup.
>>>
>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>> ---
>>> V3 --> V2
>>>   -Modify the title
>>> V2 --> V1:
>>>   -Fix a coding style problem
>>> Replace
>>>     for (node = 0;
>>>             node < pcms->numa_nodes && pcms->node_mem[node] == 0;
>>>             node++);
>>>
>>> with
>>>     for (node = 0; node < pcms->numa_nodes; node++) {
>>>        if (pcms->node_mem[node] != 0) {
>>>             break;
>>>          }
>>>
>>>  hw/i386/acpi-build.c | 78 +++++++++++++++++++++++++++++++++-------------------
>>>  1 file changed, 50 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 98dd424..f93d712 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2318,15 +2318,43 @@ build_tpm2(GArray *table_data, BIOSLinker *linker)
>>>                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
>>>  }
>>>
>>> +static uint64_t
>>> +build_srat_node_entry(GArray *table_data, PCMachineState *pcms,
>>> +                                int i, uint64_t mem_base, uint64_t mem_len)
>>> +{
>>> +    AcpiSratMemoryAffinity *numamem;
>>> +    uint64_t next_base;
>>> +
>>> +    next_base = mem_base + mem_len;
>>> +
>>> +    /* Cut out the ACPI_PCI hole */
>>> +    if (mem_base <= pcms->below_4g_mem_size &&
>>> +        next_base > pcms->below_4g_mem_size) {
>>> +        mem_len -= next_base - pcms->below_4g_mem_size;
>>> +        if (mem_len > 0) {
>>> +            numamem = acpi_data_push(table_data, sizeof *numamem);
>>> +            build_srat_memory(numamem, mem_base, mem_len, i,
>>> +                              MEM_AFFINITY_ENABLED);
>>> +        }
>>> +        mem_base = 1ULL << 32;
>>> +        mem_len = next_base - pcms->below_4g_mem_size;
>>> +        next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>>> +    }
>>> +    numamem = acpi_data_push(table_data, sizeof *numamem);
>>> +    build_srat_memory(numamem, mem_base, mem_len, i,
>>> +                      MEM_AFFINITY_ENABLED);
>>> +    return next_base;
>>> +}
>>> +
>>>  static void
>>>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>>  {
>>>      AcpiSystemResourceAffinityTable *srat;
>>>      AcpiSratMemoryAffinity *numamem;
>>>
>>> -    int i;
>>> +    int i, node;
>>>      int srat_start, numa_start, slots;
>>> -    uint64_t mem_len, mem_base, next_base;
>>> +    uint64_t mem_len, mem_base;
>>>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>>>      const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
>>>      PCMachineState *pcms = PC_MACHINE(machine);
>>> @@ -2370,36 +2398,30 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>>      /* the memory map is a bit tricky, it contains at least one hole
>>>       * from 640k-1M and possibly another one from 3.5G-4G.
>>>       */
>>> -    next_base = 0;
>>> +
>>>      numa_start = table_data->len;
>>>
>>> -    numamem = acpi_data_push(table_data, sizeof *numamem);
>>> -    build_srat_memory(numamem, 0, 640 * 1024, 0, MEM_AFFINITY_ENABLED);
>>> -    next_base = 1024 * 1024;
>>> -    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
>>> -        mem_base = next_base;
>>> -        mem_len = pcms->node_mem[i - 1];
>>> -        if (i == 1) {
>>> -            mem_len -= 1024 * 1024;
>>> +    /* get the first node which has memory and map the hole from 640K-1M */
>>> +    for (node = 0; node < pcms->numa_nodes; node++) {
>>> +        if (pcms->node_mem[node] != 0) {
>>> +            break;
>>>          }
>>> -        next_base = mem_base + mem_len;
>>> -
>>> -        /* Cut out the ACPI_PCI hole */
>>> -        if (mem_base <= pcms->below_4g_mem_size &&
>>> -            next_base > pcms->below_4g_mem_size) {
>>> -            mem_len -= next_base - pcms->below_4g_mem_size;
>>> -            if (mem_len > 0) {
>>> -                numamem = acpi_data_push(table_data, sizeof *numamem);
>>> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
>>> -                                  MEM_AFFINITY_ENABLED);
>>> -            }
>>> -            mem_base = 1ULL << 32;
>>> -            mem_len = next_base - pcms->below_4g_mem_size;
>>> -            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>>> +    }
>>> +    numamem = acpi_data_push(table_data, sizeof *numamem);
>>> +    build_srat_memory(numamem, 0, 640 * 1024, node, MEM_AFFINITY_ENABLED);
>>> +
>>> +    /* map the rest of memory from 1M */
>>> +    mem_base = 1024 * 1024;
>>> +    mem_len = pcms->node_mem[node] - mem_base;
>>> +    mem_base = build_srat_node_entry(table_data, pcms, node,
>>> +                                            mem_base, mem_len);
>>> +
>>> +    for (i = 0; i < pcms->numa_nodes; i++) {
>>> +        if (i == node) {
>>> +            continue;
>>>          }
>>> -        numamem = acpi_data_push(table_data, sizeof *numamem);
>>> -        build_srat_memory(numamem, mem_base, mem_len, i - 1,
>>> -                          MEM_AFFINITY_ENABLED);
>>> +        mem_base = build_srat_node_entry(table_data, pcms, i,
>>> +                                            mem_base, pcms->node_mem[i]);
>>>      }
>>>      slots = (table_data->len - numa_start) / sizeof *numamem;
>>>      for (; slots < pcms->numa_nodes + 2; slots++) {
>>>
>>
>>
>
