Received: from eggs.gnu.org ([2001:4830:134:3::10]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNeoj-0002dq-6V
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNeog-00048J-2F
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNeof-000467-Q2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:33:02 -0400
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<20170619100813.GB17304@stefanha-x1.localdomain>
	<4cec825b-d92e-832e-3a76-103767032528@redhat.com>
	<20170621110817.GF16183@stefanha-x1.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2361e86b-6660-4261-a805-c82c3b3a37c6@redhat.com>
Date: Wed, 21 Jun 2017 14:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170621110817.GF16183@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] virtio-mem: paravirtualized memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: KVM <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 21.06.2017 13:08, Stefan Hajnoczi wrote:
> On Mon, Jun 19, 2017 at 12:26:52PM +0200, David Hildenbrand wrote:
>> On 19.06.2017 12:08, Stefan Hajnoczi wrote:
>>> On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
>>>> Important restrictions of this concept:
>>>> - Guests without a virtio-mem guest driver can't see that memory.
>>>> - We will always require some boot memory that cannot get unplugged.
>>>>   Also, virtio-mem memory (as all other hotplugged memory) cannot become
>>>>   DMA memory under Linux. So the boot memory also defines the amount of
>>>>   DMA memory.
>>>
>>> I didn't know that hotplug memory cannot become DMA memory.
>>>
>>> Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
>>> won't be possible.
>>>
>>> When running an application that uses O_DIRECT file I/O this probably
>>> means we now have 2 copies of pages in memory: 1. in the application and
>>> 2. in the kernel page cache.
>>>
>>> So this increases pressure on the page cache and reduces performance :(.
>>>
>>> Stefan
>>>
>>
>> arch/x86/mm/init_64.c:
>>
>> /*
>>  * Memory is added always to NORMAL zone. This means you will never get
>>  * additional DMA/DMA32 memory.
>>  */
>> int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
>> {
>>
>> The is for sure something to work on in the future. Until then, base
>> memory of 3.X GB should be sufficient, right?
> 
> I'm not sure that helps because applications typically don't control
> where their buffers are located?

Okay, let me try to explain what is going on here (no expert, please
someone correct me if I am wrong).

There is a difference between DMA and DMA memory in Linux. DMA memory is
simply memory with special addresses. DMA is the general technique of a
device directly copying data to ram, bypassing the CPU.

ZONE_DMA contains all* memory < 16MB
ZONE_DMA32 contains all* memory < 4G
* meaning available on boot via a820 map, not hotplugged.

So memory from these zones can be used by devices that can only deal
with 24bit/32bit addresses.

Hotplugged memory is never added to the ZONE_DMA/DMA32, but to
ZONE_NORMAL. That means, kmalloc(.., GFP_DMA will) not be able to use
hotplugged memory. Say you have 1GB of main storage and hotplug 1G (on
address 1G). This memory will not be available in the ZONE_DMA, although
below 4g.

Memory in ZONE_NORMAL is used for ordinary kmalloc(), so all these
memory can be used to do DMA, but you are not guaranteed to get 32bit
capable addresses. I pretty much assume that virtio-net can deal with
64bit addresses.


My understanding of O_DIRECT:

The user space buffers (O_DIRECT) is directly used to do DMA. This will
work just fine as long as the device can deal with 64bit addresses. I
guess this is the case for virtio-net, otherwise there would be the
exact same problem already without virtio-mem.

Summary:

virtio-mem memory can be used for DMA, it will simply not be added to
ZONE_DMA/DMA32 and therefore won't be available for kmalloc(...,
GFP_DMA). This should work just fine with O_DIRECT as before.

If necessary, we could try to add memory to the ZONE_DMA later on,
however for now I would rate this a minor problem. By simply using 3.X
GB of base memory, basically all memory that could go to ZONE_DMA/DMA32
already is in these zones without virtio-mem.

Thanks!

> 
> Stefan
> 


-- 

Thanks,

David
