Received: from eggs.gnu.org ([2001:4830:134:3::10]:50320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dDSOw-0003in-JE
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dDSOt-0007L0-Ty
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:16:18 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:32793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dDSOt-0007Kn-Ps
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:16:15 -0400
Received: by mail-ua0-f171.google.com with SMTP id e28so93302570uah.0
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 02:16:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <437f8abb-8d19-f4cd-b92d-9780efa0fe0e@redhat.com>
References: <20170524080914.23484-1-lprosek@redhat.com>
	<437f8abb-8d19-f4cd-b92d-9780efa0fe0e@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 24 May 2017 11:16:14 +0200
Message-ID: <CABdb737srRzOoZT4Usr174yn65rRk4AvM2YEnzs0VjvKRo8BMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pc: ACPI BIOS: use highest NUMA node for
 hotplug mem hole SRAT entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, May 24, 2017 at 11:07 AM, Laszlo Ersek <lersek@redhat.com> wrote:
> On 05/24/17 10:09, Ladi Prosek wrote:
>> For reasons unknown, Windows won't online all memory, both at command
>> line and hot-plugged later, unless the hotplug mem hole SRAT entry
>> specifies a node greater or equal to the ones where memory is added.
>
> s/greater or equal to/greater *than* or equal to/
>
> Thanks,
> Laszlo
> (always finding the important issues! ;) )

Haha, thanks! Igor, please let me know if you'd like me to send a
corrected version.

>>
>> Using the highest node on the machine makes recent versions of Windows
>> happy.
>>
>> With this example command line:
>>   ... \
>>   -m 1024,slots=4,maxmem=32G \
>>   -numa node,nodeid=0 \
>>   -numa node,nodeid=1 \
>>   -numa node,nodeid=2 \
>>   -numa node,nodeid=3 \
>>   -object memory-backend-ram,size=1G,id=mem-mem1 \
>>   -device pc-dimm,id=dimm-mem1,memdev=mem-mem1,node=1
>>
>> Windows reports a total of 1G of RAM without this commit and the expected
>> 2G with this commit.
>>
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> ---
>>  hw/i386/acpi-build.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index afcadac..9653583 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2404,14 +2404,17 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>      }
>>
>>      /*
>> -     * Entry is required for Windows to enable memory hotplug in OS.
>> +     * Entry is required for Windows to enable memory hotplug in OS
>> +     * and for Linux to enable SWIOTLB even if booted with less than
>> +     * 4G of RAM. Windows works better if the entry sets proximity
>> +     * to the highest NUMA node in the machine.
>>       * Memory devices may override proximity set by this entry,
>>       * providing _PXM method if necessary.
>>       */
>>      if (hotplugabble_address_space_size) {
>>          numamem = acpi_data_push(table_data, sizeof *numamem);
>>          build_srat_memory(numamem, pcms->hotplug_memory.base,
>> -                          hotplugabble_address_space_size, 0,
>> +                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
>>                            MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>>      }
>>
>>
>
