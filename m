Received: from eggs.gnu.org ([2001:4830:134:3::10]:36553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMtte-0000G7-CQ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMttb-0003gP-63
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMtta-0003fb-W9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:26:59 -0400
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<20170619100813.GB17304@stefanha-x1.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4cec825b-d92e-832e-3a76-103767032528@redhat.com>
Date: Mon, 19 Jun 2017 12:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170619100813.GB17304@stefanha-x1.localdomain>
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

On 19.06.2017 12:08, Stefan Hajnoczi wrote:
> On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
>> Important restrictions of this concept:
>> - Guests without a virtio-mem guest driver can't see that memory.
>> - We will always require some boot memory that cannot get unplugged.
>>   Also, virtio-mem memory (as all other hotplugged memory) cannot become
>>   DMA memory under Linux. So the boot memory also defines the amount of
>>   DMA memory.
> 
> I didn't know that hotplug memory cannot become DMA memory.
> 
> Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
> won't be possible.
> 
> When running an application that uses O_DIRECT file I/O this probably
> means we now have 2 copies of pages in memory: 1. in the application and
> 2. in the kernel page cache.
> 
> So this increases pressure on the page cache and reduces performance :(.
> 
> Stefan
> 

arch/x86/mm/init_64.c:

/*
 * Memory is added always to NORMAL zone. This means you will never get
 * additional DMA/DMA32 memory.
 */
int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
{

The is for sure something to work on in the future. Until then, base
memory of 3.X GB should be sufficient, right?

-- 

Thanks,

David
