Received: from eggs.gnu.org ([2001:4830:134:3::10]:40719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e1tgV-0008SB-CT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e1tgP-00058q-6b
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:30:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:44569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1e1tgO-00056S-S2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:30:49 -0400
Message-ID: <59DCBDE9.4050404@intel.com>
Date: Tue, 10 Oct 2017 20:32:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>	<20171009181612-mutt-send-email-mst@kernel.org>	<59DC76BA.7070202@intel.com>
	<201710102008.FIG57851.QFJLMtVOFOHFOS@I-love.SAKURA.ne.jp>
In-Reply-To: <201710102008.FIG57851.QFJLMtVOFOHFOS@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 10/10/2017 07:08 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> On 10/09/2017 11:20 PM, Michael S. Tsirkin wrote:
>>> On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
>>>> +static inline void xb_set_page(struct virtio_balloon *vb,
>>>> +			       struct page *page,
>>>> +			       unsigned long *pfn_min,
>>>> +			       unsigned long *pfn_max)
>>>> +{
>>>> +	unsigned long pfn = page_to_pfn(page);
>>>> +
>>>> +	*pfn_min = min(pfn, *pfn_min);
>>>> +	*pfn_max = max(pfn, *pfn_max);
>>>> +	xb_preload(GFP_KERNEL);
>>>> +	xb_set_bit(&vb->page_xb, pfn);
>>>> +	xb_preload_end();
>>>> +}
>>>> +
>>> So, this will allocate memory
>>>
>>> ...
>>>
>>>> @@ -198,9 +327,12 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>>>>    	struct page *page;
>>>>    	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>>>>    	LIST_HEAD(pages);
>>>> +	bool use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG);
>>>> +	unsigned long pfn_max = 0, pfn_min = ULONG_MAX;
>>>>    
>>>> -	/* We can only do one array worth at a time. */
>>>> -	num = min(num, ARRAY_SIZE(vb->pfns));
>>>> +	/* Traditionally, we can only do one array worth at a time. */
>>>> +	if (!use_sg)
>>>> +		num = min(num, ARRAY_SIZE(vb->pfns));
>>>>    
>>>>    	mutex_lock(&vb->balloon_lock);
>>>>    	/* We can't release more pages than taken */
>>> And is sometimes called on OOM.
>>>
>>>
>>> I suspect we need to
>>>
>>> 1. keep around some memory for leak on oom
>>>
>>> 2. for non oom allocate outside locks
>>>
>>>
>> I think maybe we can optimize the existing balloon logic, which could
>> remove the big balloon lock:
>>
>> It would not be necessary to have the inflating and deflating run at the
>> same time.
>> For example, 1st request to inflate 7G RAM, when 1GB has been given to
>> the host (so 6G left), the
>> 2nd request to deflate 5G is received. Instead of waiting for the 1st
>> request to inflate 6G and then
>> continuing with the 2nd request to deflate 5G, we can do a diff (6G to
>> inflate - 5G to deflate) immediately,
>> and got 1G to inflate. In this way, all that driver will do is to simply
>> inflate another 1G.
>>
>> Same for the OOM case: when OOM asks for 1G, while inflating 5G is in
>> progress, then the driver can
>> deduct 1G from the amount that needs to inflate, and as a result, it
>> will inflate 4G.
>>
>> In this case, we will never have the inflating and deflating task run at
>> the same time, so I think it is
>> possible to remove the lock, and therefore, we will not have that
>> deadlock issue.
>>
>> What would you guys think?
> What is balloon_lock at virtballoon_migratepage() for?
>
>    e22504296d4f64fb "virtio_balloon: introduce migration primitives to balloon pages"
>    f68b992bbb474641 "virtio_balloon: fix race by fill and leak"

I think that's the part we need to improve for the existing 
implementation when going with the above direction.

As also stated in the commit log, the lock was proposed to synchronize 
accesses to elements
of struct virtio_balloon and its queue operation. To be more precise, 
fill_balloon/leak_balloon/migrationpage
share vb->pfns[] and vb->num_pfns, which can actually be changed to use 
local variables of their own each.

For example, for migratepage:
+       __virtio32 pfn;
...
-       vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
-       set_page_pfns(vb, vb->pfns, newpage);
-       tell_host(vb, vb->inflate_vq);
+       set_page_pfns(vb, &pfn, newpage);
+       tell_host(vb, vb->inflate_vq, &pfn, VIRTIO_BALLOON_PAGES_PER_PAGE);

For the queue access, it could be a small lock for each queue access, 
which I think won't cause the issue.



> And even if we could remove balloon_lock, you still cannot use
> __GFP_DIRECT_RECLAIM at xb_set_page(). I think you will need to use
> "whether it is safe to wait" flag from
> "[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()" .

Without the lock being held, why couldn't we use __GFP_DIRECT_RECLAIM at 
xb_set_page()?


Best,
Wei
