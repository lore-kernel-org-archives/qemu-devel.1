Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp2UQ-0008Cw-1R
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 21:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp2UL-0002mx-3U
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 21:17:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53075
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp2UK-0002mT-OV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 21:17:13 -0400
References: <20170901154542.5687-1-cascardo@canonical.com>
	<20170901161118.GQ7570@localhost.localdomain>
	<2ab3aaef-c6d7-ae3d-808b-f947dcb3ed1c@cn.fujitsu.com>
	<20170904130814.GR7570@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e970608d-fb97-210c-72e9-bf4f43a3e54c@cn.fujitsu.com>
Date: Tue, 5 Sep 2017 09:17:06 +0800
MIME-Version: 1.0
In-Reply-To: <20170904130814.GR7570@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86/acpi: build SRAT when memory hotplug
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Eduardo,

At 09/04/2017 09:08 PM, Eduardo Habkost wrote:
[...]
>> In my opinion, this may also add the hotpluggable memory, and see the
>> following commemts.
>>
>>     /*
>>      * Entry is required for Windows to enable memory hotplug in OS
>>      * and for Linux to enable SWIOTLB when booted with less than
>>            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      * 4G of RAM. Windows works better if the entry sets proximity
>>      * to the highest NUMA node in the machine.
>>      * Memory devices may override proximity set by this entry,
>>      * providing _PXM method if necessary.
>>      */
>>     if (hotplugabble_address_space_size) {
>>         numamem = acpi_data_push(table_data, sizeof *numamem);
>>         build_srat_memory(numamem, pcms->hotplug_memory.base,
>>                           hotplugabble_address_space_size, pcms->numa_nodes
>> - 1,
>>                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>>     }
>
> You are correct, I didn't see that part of the code.  If that's
> the entry that's missing, the patch makes sense.  Thanks!
>
> However, the resulting tables still don't look correct: it will
> generate an entry assigned to NUMA node (uint32_t)-1 if no NUMA
> nodes are configured elsewhere, some APIC entries, but no entries
> for the rest of the memory.

Yes, indeed.

>
> Igor's suggestion to enable NUMA implicitly sounds safer to me.
>

I agree with Igor too.

Is anybody doing this? If not, may I make a patch to enable adding NUMA
node implicitly first. let's see what it looks like.

Thanks,
	dou.
