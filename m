Received: from eggs.gnu.org ([2001:4830:134:3::10]:50425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tMo-0005x9-FZ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tMk-0007hf-VN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:15:46 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-15-david@redhat.com>
	<99ab8baf-37c9-2df1-7292-8e0ac4f31137@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <500af147-f496-7fb4-47f8-183bd45f4cb4@redhat.com>
Date: Mon, 1 Oct 2018 10:15:33 +0200
MIME-Version: 1.0
In-Reply-To: <99ab8baf-37c9-2df1-7292-8e0ac4f31137@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/24] memory-device: complete factoring
 out plug handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 30/09/2018 17:55, Auger Eric wrote:
> Hi David,
> 
> On 9/26/18 11:42 AM, David Hildenbrand wrote:
>> With the new memory device functions in place, we can factor out
>> plugging of memory devices completely.
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/memory-device.c         | 13 ++++++++++---
>>  hw/mem/pc-dimm.c               |  9 +--------
>>  include/hw/mem/memory-device.h |  3 +--
>>  3 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 54e3f23b15..3914e2fe6f 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -275,10 +275,17 @@ out:
>>      error_propagate(errp, local_err);
>>  }
>>  
>> -void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
>> -                               uint64_t addr)
>> +void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
>>  {
>> -    /* we expect a previous call to memory_device_get_free_addr() */
>> +    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
>> +    const uint64_t addr = mdc->get_addr(md);
>> +    MemoryRegion *mr;
>> +
>> +    /*
>> +     * We expect a previous call to memory_device_pre_plug() succeeded so
>> +     * it and can't fail at this point.
> comment to be reworded
> 

Igor requested that rewording. I can turn that into "We expect that a
previous call ... succeeded, so " ..

> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric


-- 

Thanks,

David / dhildenb
