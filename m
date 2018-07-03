Received: from eggs.gnu.org ([2001:4830:134:3::10]:35367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1faFnn-0007xZ-Kg
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1faFnA-0007Vo-At
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:32:43 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1faFn9-0007VB-VN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:32:04 -0400
Received: by mail-pf0-x241.google.com with SMTP id y8-v6so575322pfm.10
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 00:32:03 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620152407-mutt-send-email-mst@kernel.org>
	<a90a7cd1-3362-fdd6-0caa-148fd5d3acff@gmail.com>
	<20180629160249-mutt-send-email-mst@kernel.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <267974b6-d316-cdc2-27b8-adb5ede31f53@gmail.com>
Date: Tue, 3 Jul 2018 15:31:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180629160249-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/29/2018 09:08 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 29, 2018 at 03:30:44PM +0800, Xiao Guangrong wrote:
>>
>> Hi Michael,
>>
>> On 06/20/2018 08:38 PM, Michael S. Tsirkin wrote:
>>> On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:
>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>>>>
>>>>
>>>> (1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
>>>> (2) http://dpdk.org/doc/api/rte__ring_8h.html
>>>>
>>>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>
>>> So instead of all this super-optimized trickiness, how about
>>> a simple port of ptr_ring from linux?
>>>
>>> That one isn't lockless but it's known to outperform
>>> most others for a single producer/single consumer case.
>>> And with a ton of networking going on,
>>> who said it's such a hot spot? OTOH this implementation
>>> has more barriers which slows down each individual thread.
>>> It's also a source of bugs.
>>>
>>
>> Thank you for pointing it out.
>>
>> I just quickly went through the code of ptr_ring that is very nice and
>> really impressive. I will consider to port it to QEMU.
> 
> The port is pretty trivial. See below. It's a SPSC structure though.  So
> you need to use it with lock.  Given the critical section is small, I

Why put these locks into this common struct? For our case, each thread
has its own ring which is SCSP, no lock is needed at all. Atomic operations
still slow things down, see [PATCH 07/12] migration: hold the lock only if
it is really needed. I'd move the inner locks to the user instead.
