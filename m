Received: from eggs.gnu.org ([2001:4830:134:3::10]:34883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnam4-0002BW-7S
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 21:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnalz-0001Zj-JX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 21:29:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56037
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnaly-0001Z3-OV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 21:29:27 -0400
References: <1504181068-17822-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1504181068-17822-2-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170831213618.GG7570@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <68bc78e7-c928-8343-c9ee-ce7e531d35d4@cn.fujitsu.com>
Date: Fri, 1 Sep 2017 09:29:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170831213618.GG7570@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] hw/acpi-build: Fix SRAT memory
 building in case of node 0 without RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com, rth@twiddle.net

Hi, Eduardo

At 09/01/2017 05:36 AM, Eduardo Habkost wrote:
> On Thu, Aug 31, 2017 at 08:04:26PM +0800, Dou Liyang wrote:
>> From: Eduardo Habkost <ehabkost@redhat.com>
>>
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
>> This is because when QEMU builds ACPI SRAT, it regards node 0 as the
>> default node to deal with the memory hole(640K-1M). this means the
>> node0 must have some memory(>1M), but, actually it can have no
>> memory.
>>
>> Fix this problem by  cut out the 640K hole in the same way the PCI
>> 4G hole does. Also do some cleanup.
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>>  hw/i386/acpi-build.c | 30 +++++++++++++++++++++++-------
>>  1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 98dd424..48525a1 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2318,6 +2318,9 @@ build_tpm2(GArray *table_data, BIOSLinker *linker)
>>                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
>>  }
>>
>> +#define HOLE_640K_START  (640 * 1024)
>> +#define HOLE_640K_END   (1024 * 1024)
>> +
>>  static void
>>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>  {
>> @@ -2373,17 +2376,30 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>      next_base = 0;
>>      numa_start = table_data->len;
>>
>> -    numamem = acpi_data_push(table_data, sizeof *numamem);
>> -    build_srat_memory(numamem, 0, 640 * 1024, 0, MEM_AFFINITY_ENABLED);
>> -    next_base = 1024 * 1024;
>>      for (i = 1; i < pcms->numa_nodes + 1; ++i) {
>>          mem_base = next_base;
>>          mem_len = pcms->node_mem[i - 1];
>> -        if (i == 1) {
>> -            mem_len -= 1024 * 1024;
>> -        }
>>          next_base = mem_base + mem_len;
>>
>> +        /* Cut out the 640K hole */
>> +        if (mem_base <= HOLE_640K_START &&
>> +            next_base > HOLE_640K_START) {
>> +            mem_len -= next_base - HOLE_640K_START;
>> +            if (mem_len > 0) {
>> +                numamem = acpi_data_push(table_data, sizeof *numamem);
>> +                build_srat_memory(numamem, mem_base, mem_len, i - 1,
>> +                                  MEM_AFFINITY_ENABLED);
>> +            }
>> +
>> +            /* Check for the rare case: 640K < RAM < 1M */
>> +            if (next_base <= HOLE_640K_END) {
>> +                next_base = HOLE_640K_END;
>> +                continue;
>> +            }
>> +            mem_base = HOLE_640K_END;
>> +            mem_len = next_base - HOLE_640K_END;
>> +        }
>> +
>>          /* Cut out the ACPI_PCI hole */
>>          if (mem_base <= pcms->below_4g_mem_size &&
>>              next_base > pcms->below_4g_mem_size) {
>> @@ -2395,7 +2411,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>              }
>>              mem_base = 1ULL << 32;
>>              mem_len = next_base - pcms->below_4g_mem_size;
>> -            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>> +            next_base = mem_base + mem_len;
>
> Is this extra change intentional?
>

Yes, it is, Just for readability. :-)

> I find the code more readable with it, but it should go in a
> separate patch because it is unrelated to the bug fix.
>

Indeed, I will split it out.

Thanks,
	dou.
