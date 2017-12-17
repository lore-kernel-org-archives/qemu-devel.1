Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQRPB-0005fz-5e
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQRP8-0003kf-2V
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:22:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:28559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eQRP7-0003ic-Q0
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:22:25 -0500
Message-ID: <5A35FF89.8040500@intel.com>
Date: Sun, 17 Dec 2017 13:24:25 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<20171215184256.GA27160@bombadil.infradead.org>	<5A34F193.5040700@intel.com>
	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
In-Reply-To: <201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On 12/16/2017 07:28 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> On 12/16/2017 02:42 AM, Matthew Wilcox wrote:
>>> On Tue, Dec 12, 2017 at 07:55:55PM +0800, Wei Wang wrote:
>>>> +int xb_preload_and_set_bit(struct xb *xb, unsigned long bit, gfp_t gfp);
>>> I'm struggling to understand when one would use this.  The xb_ API
>>> requires you to handle your own locking.  But specifying GFP flags
>>> here implies you can sleep.  So ... um ... there's no locking?
>> In the regular use cases, people would do xb_preload() before taking the
>> lock, and the xb_set/clear within the lock.
>>
>> In the virtio-balloon usage, we have a large number of bits to set with
>> the balloon_lock being held (we're not unlocking for each bit), so we
>> used the above wrapper to do preload and set within the balloon_lock,
>> and passed in GFP_NOWAIT to avoid sleeping. Probably we can change to
>> put this wrapper implementation to virtio-balloon, since it would not be
>> useful for the regular cases.
> GFP_NOWAIT is chosen in order not to try to OOM-kill something, isn't it?

Yes, I think that's right the issue we are discussing here (also 
discussed in the deadlock patch before): Suppose we use a sleep-able 
flag GFP_KERNEL, which gets the caller (fill_balloon or leak_balloon) 
into sleep with balloon_lock being held, and the memory reclaiming from 
GFP_KERNEL would fall into the OOM code path which first invokes the 
oom_notify-->leak_balloon to release some balloon memory, which needs to 
take the balloon_lock that is being held by the task who is sleeping.

So, using GFP_NOWAIT avoids sleeping to get memory through directly 
memory reclaiming, which could fall into that OOM code path that needs 
to take the balloon_lock.


> But passing GFP_NOWAIT means that we can handle allocation failure. There is
> no need to use preload approach when we can handle allocation failure.

I think the reason we need xb_preload is because radix tree insertion 
needs the memory being preallocated already (it couldn't suffer from 
memory failure during the process of inserting, probably because 
handling the failure there isn't easy, Matthew may know the backstory of 
this)

So, I think we can handle the memory failure with xb_preload, which 
stops going into the radix tree APIs, but shouldn't call radix tree APIs 
without the related memory preallocated.

Best,
Wei
