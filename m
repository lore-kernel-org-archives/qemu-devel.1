Received: from eggs.gnu.org ([2001:4830:134:3::10]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYkZm-0000Vm-OG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYkZj-0000xs-AY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:00:02 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYkZj-0000vx-3r
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:59:59 -0400
Received: by mail-pl0-x243.google.com with SMTP id 6-v6so3799381plb.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:59:58 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <73324779-b76f-3081-adbb-590bc2030833@gmail.com>
Date: Fri, 29 Jun 2018 11:59:46 +0800
MIME-Version: 1.0
In-Reply-To: <355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/28/2018 09:36 PM, Jason Wang wrote:
> 
> 
> On 2018年06月04日 17:55, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong<xiaoguangrong@tencent.com>
>>
>> It's the simple lockless ring buffer implement which supports both
>> single producer vs. single consumer and multiple producers vs.
>> single consumer.
>>

>> Finally, it fetches the valid data out, set the entry to the initialized
>> state and update ring->out to make the entry be usable to the producer:
>>
>>        data = *entry;
>>        *entry = NULL;
>>        ring->out++;
>>
>> Memory barrier is omitted here, please refer to the comment in the code.
>>
>> (1)https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
>> (2)http://dpdk.org/doc/api/rte__ring_8h.html
>>
>> Signed-off-by: Xiao Guangrong<xiaoguangrong@tencent.com>
>> ---
> 
> May I ask why you need a MPSC ring here? Can we just use N SPSC ring for submitting pages and another N SPSC ring for passing back results?

Sure.

We had this option in our mind, however, it is not scalable which will slow
the main thread down, instead, we'd rather to speed up main thread and move
reasonable workload to the threads.
