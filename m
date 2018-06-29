Received: from eggs.gnu.org ([2001:4830:134:3::10]:43551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYkVD-0007o7-JI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYkVA-0003Nt-Cy
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:55:19 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:46360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYkVA-0003MV-5g
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:55:16 -0400
Received: by mail-pl0-x244.google.com with SMTP id 30-v6so3775172pld.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:55:15 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620045203.GE18985@xz-mi>
	<6f871708-d38b-2acf-350a-985c8a23a013@gmail.com>
	<5B34CCB9.5040406@intel.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <e7e37560-3c52-39d2-64be-67d79d210496@gmail.com>
Date: Fri, 29 Jun 2018 11:55:08 +0800
MIME-Version: 1.0
In-Reply-To: <5B34CCB9.5040406@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Wei Wang <wei.w.wang@intel.com>, Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, Xiao Guangrong <xiaoguangrong@tencent.com>, peterz@infradead.org, stefani@seibold.net, paulmck@linux.vnet.ibm.com, Lai Jiangshan <jiangshanlai@gmail.com>



On 06/28/2018 07:55 PM, Wei Wang wrote:
> On 06/28/2018 06:02 PM, Xiao Guangrong wrote:
>>
>> CC: Paul, Peter Zijlstra, Stefani, Lai who are all good at memory barrier.
>>
>>
>> On 06/20/2018 12:52 PM, Peter Xu wrote:
>>> On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:
>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>
>>>> It's the simple lockless ring buffer implement which supports both
>>>> single producer vs. single consumer and multiple producers vs.
>>>> single consumer.
>>>>
>>>> Many lessons were learned from Linux Kernel's kfifo (1) and DPDK's
>>>> rte_ring (2) before i wrote this implement. It corrects some bugs of
>>>> memory barriers in kfifo and it is the simpler lockless version of
>>>> rte_ring as currently multiple access is only allowed for producer.
>>>
>>> Could you provide some more information about the kfifo bug? Any
>>> pointer would be appreciated.
>>>
>>
>> Sure, i reported one of the memory barrier issue to linux kernel:
>>    https://lkml.org/lkml/2018/5/11/58
>>
>> Actually, beside that, there is another memory barrier issue in kfifo,
>> please consider this case:
>>
>>    at the beginning
>>    ring->size = 4
>>    ring->out = 0
>>    ring->in = 4
>>
>>      Consumer                            Producer
>>  ---------------                     --------------
>>    index = ring->out; /* index == 0 */
>>    ring->out++; /* ring->out == 1 */
>>    < Re-Order >
>>                                     out = ring->out;
>>                                     if (ring->in - out >= ring->mask)
>>                                         return -EFULL;
>>                                     /* see the ring is not full */
>>                                     index = ring->in & ring->mask; /* index == 0 */
>>                                     ring->data[index] = new_data;
>> 　　　　　　　　　　　　　　　　　　　　　ring->in++;
>>
>>    data = ring->data[index];
>>    !!!!!! the old data is lost !!!!!!
>>
>> So we need to make sure:
>> 1) for the consumer, we should read the ring->data[] out before updating ring->out
>> 2) for the producer, we should read ring->out before updating ring->data[]
>>
>> as followings:
>>       Producer                                       Consumer
>>   ------------------------------------ ------------------------
>>       Reading ring->out                            Reading ring->data[index]
>>       smp_mb()                                     smp_mb()
>>       Setting ring->data[index] = data ring->out++
>>
>> [ i used atomic_store_release() and atomic_load_acquire() instead of smp_mb() in the
>>   patch. ]
>>
>> But i am not sure if we can use smp_acquire__after_ctrl_dep() in the producer?
> 
> 
> I wonder if this could be solved by simply tweaking the above consumer implementation:
> 
> [1] index = ring->out;
> [2] data = ring->data[index];
> [3] index++;
> [4] ring->out = index;
> 
> Now [2] and [3] forms a WAR dependency, which avoids the reordering.

It can not. [2] and [4] still do not any dependency, CPU and complainer can omit
the 'index'.
