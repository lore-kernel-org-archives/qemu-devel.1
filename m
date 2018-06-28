Received: from eggs.gnu.org ([2001:4830:134:3::10]:57808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fYVSm-0007uE-HL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fYVSj-0004I9-Eb
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:51:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:31976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fYVSj-0004F2-4L
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:51:45 -0400
Message-ID: <5B34CCB9.5040406@intel.com>
Date: Thu, 28 Jun 2018 19:55:37 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620045203.GE18985@xz-mi>
	<6f871708-d38b-2acf-350a-985c8a23a013@gmail.com>
In-Reply-To: <6f871708-d38b-2acf-350a-985c8a23a013@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, Xiao Guangrong <xiaoguangrong@tencent.com>, peterz@infradead.org, stefani@seibold.net, paulmck@linux.vnet.ibm.com, Lai Jiangshan <jiangshanlai@gmail.com>

On 06/28/2018 06:02 PM, Xiao Guangrong wrote:
>
> CC: Paul, Peter Zijlstra, Stefani, Lai who are all good at memory 
> barrier.
>
>
> On 06/20/2018 12:52 PM, Peter Xu wrote:
>> On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com 
>> wrote:
>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>
>>> It's the simple lockless ring buffer implement which supports both
>>> single producer vs. single consumer and multiple producers vs.
>>> single consumer.
>>>
>>> Many lessons were learned from Linux Kernel's kfifo (1) and DPDK's
>>> rte_ring (2) before i wrote this implement. It corrects some bugs of
>>> memory barriers in kfifo and it is the simpler lockless version of
>>> rte_ring as currently multiple access is only allowed for producer.
>>
>> Could you provide some more information about the kfifo bug? Any
>> pointer would be appreciated.
>>
>
> Sure, i reported one of the memory barrier issue to linux kernel:
>    https://lkml.org/lkml/2018/5/11/58
>
> Actually, beside that, there is another memory barrier issue in kfifo,
> please consider this case:
>
>    at the beginning
>    ring->size = 4
>    ring->out = 0
>    ring->in = 4
>
>      Consumer                            Producer
>  ---------------                     --------------
>    index = ring->out; /* index == 0 */
>    ring->out++; /* ring->out == 1 */
>    < Re-Order >
>                                     out = ring->out;
>                                     if (ring->in - out >= ring->mask)
>                                         return -EFULL;
>                                     /* see the ring is not full */
>                                     index = ring->in & ring->mask; /* 
> index == 0 */
>                                     ring->data[index] = new_data;
> 　　　　　　　　　　　　　　　　　　　　　ring->in++;
>
>    data = ring->data[index];
>    !!!!!! the old data is lost !!!!!!
>
> So we need to make sure:
> 1) for the consumer, we should read the ring->data[] out before 
> updating ring->out
> 2) for the producer, we should read ring->out before updating 
> ring->data[]
>
> as followings:
>       Producer                                       Consumer
>   ------------------------------------ ------------------------
>       Reading ring->out                            Reading 
> ring->data[index]
>       smp_mb()                                     smp_mb()
>       Setting ring->data[index] = data ring->out++
>
> [ i used atomic_store_release() and atomic_load_acquire() instead of 
> smp_mb() in the
>   patch. ]
>
> But i am not sure if we can use smp_acquire__after_ctrl_dep() in the 
> producer?


I wonder if this could be solved by simply tweaking the above consumer 
implementation:

[1] index = ring->out;
[2] data = ring->data[index];
[3] index++;
[4] ring->out = index;

Now [2] and [3] forms a WAR dependency, which avoids the reordering.


Best,
Wei
