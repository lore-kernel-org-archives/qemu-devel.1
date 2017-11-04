Received: from eggs.gnu.org ([2001:4830:134:3::10]:39893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eAwII-0004n7-Vq
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 07:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eAwIF-0006RL-Qw
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 07:07:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:7404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eAwIF-0006Ql-HB
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 07:07:15 -0400
Message-ID: <59FD9FE3.5090409@intel.com>
Date: Sat, 04 Nov 2017 19:09:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com>
	<201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>
In-Reply-To: <201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 11/03/2017 07:25 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> @@ -164,6 +284,8 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>>   			break;
>>   		}
>>   
>> +		if (use_sg && xb_set_page(vb, page, &pfn_min, &pfn_max) < 0)
> Isn't this leaking "page" ?


Right, thanks, will add __free_page(page) here.

>> @@ -184,8 +307,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>>   
>>   	num_allocated_pages = vb->num_pfns;
>>   	/* Did we get any? */
>> -	if (vb->num_pfns != 0)
>> -		tell_host(vb, vb->inflate_vq);
>> +	if (vb->num_pfns) {
>> +		if (use_sg)
>> +			tell_host_sgs(vb, vb->inflate_vq, pfn_min, pfn_max);
> Please describe why tell_host_sgs() can work without __GFP_DIRECT_RECLAIM allocation,
> for tell_host_sgs() is called with vb->balloon_lock mutex held.

Essentially, 
tell_host_sgs()-->send_balloon_page_sg()-->add_one_sg()-->virtqueue_add_inbuf( 
, , num=1 ,,GFP_KERNEL)
won't need any memory allocation, because we always add one sg (i.e. 
num=1) each time. That memory
allocation option is only used when multiple sgs are added (i.e. num > 
1) and the implementation inside virtqueue_add_inbuf
need allocation of indirect descriptor table.

We could also add some comments above the function to explain a little 
about this if necessary.

>
>
>> @@ -223,7 +353,13 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>>   		page = balloon_page_dequeue(vb_dev_info);
>>   		if (!page)
>>   			break;
>> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>> +		if (use_sg) {
>> +			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0)
> Isn't this leaking "page" ?

Yes, will make it:

     if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
         balloon_page_enqueue(..., page);
         break;
     }

>
> If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
> use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
> on vb->balloon_lock mutex.

OK. Since the preload() doesn't need too much memory (< 4K in total), 
how about GFP_NOWAIT here?


Best,
Wei
