Received: from eggs.gnu.org ([2001:4830:134:3::10]:47249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eLhgf-0004hF-Ld
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eLhga-0000i2-Pl
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:44:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:42031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eLhga-0000hH-G6
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:44:52 -0500
Message-ID: <5A24C526.2060400@intel.com>
Date: Mon, 04 Dec 2017 11:46:46 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-8-git-send-email-wei.w.wang@intel.com>
	<20171201171746-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171201171746-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v18 07/10] virtio-balloon:
 VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On 12/01/2017 11:38 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 29, 2017 at 09:55:23PM +0800, Wei Wang wrote:
>> +static void send_one_desc(struct virtio_balloon *vb,
>> +			  struct virtqueue *vq,
>> +			  uint64_t addr,
>> +			  uint32_t len,
>> +			  bool inbuf,
>> +			  bool batch)
>> +{
>> +	int err;
>> +	unsigned int size;
>> +
>> +	/* Detach all the used buffers from the vq */
>> +	while (virtqueue_get_buf(vq, &size))
>> +		;
>> +
>> +	err = virtqueue_add_one_desc(vq, addr, len, inbuf, vq);
>> +	/*
>> +	 * This is expected to never fail: there is always at least 1 entry
>> +	 * available on the vq, because when the vq is full the worker thread
>> +	 * that adds the desc will be put into sleep until at least 1 entry is
>> +	 * available to use.
>> +	 */
>> +	BUG_ON(err);
>> +
>> +	/* If batching is requested, we batch till the vq is full */
>> +	if (!batch || !vq->num_free)
>> +		kick_and_wait(vq, vb->acked);
>> +}
>> +
> This internal kick complicates callers. I suggest that instead,
> you move this to callers, just return a "kick required" boolean.
> This way callers do not need to play with num_free at all.

Then in what situation would the function return true of "kick required"?

I think this wouldn't make a difference fundamentally. For example, we 
have 257 sgs (batching size=256) to send to host:

while (i < 257) {
     kick_required = send_sgs();
     if (kick_required)
         kick(); // After the 256 sgs have been added, the caller 
performs a kick().
}

Do we still need a kick here for the 257th sg as before? Only the caller 
knows if the last added sgs need a kick (when the send_sgs receives one 
sg, it doesn't know if there are more to come).

There is another approach to checking if the last added sgs haven't been 
sync-ed to the host: expose "vring_virtqueue->num_added" to the caller 
via a virtio_ring API:

     unsigned int virtqueue_num_added(struct virtqueue *_vq)
    {
         struct vring_virtqueue *vq = to_vvq(_vq);

         return vq->num_added;
   }



>> +/*
>> + * Send balloon pages in sgs to host. The balloon pages are recorded in the
>> + * page xbitmap. Each bit in the bitmap corresponds to a page of PAGE_SIZE.
>> + * The page xbitmap is searched for continuous "1" bits, which correspond
>> + * to continuous pages, to chunk into sgs.
>> + *
>> + * @page_xb_start and @page_xb_end form the range of bits in the xbitmap that
>> + * need to be searched.
>> + */
>> +static void tell_host_sgs(struct virtio_balloon *vb,
>> +			  struct virtqueue *vq,
>> +			  unsigned long page_xb_start,
>> +			  unsigned long page_xb_end)
>> +{
>> +	unsigned long pfn_start, pfn_end;
>> +	uint64_t addr;
>> +	uint32_t len, max_len = round_down(UINT_MAX, PAGE_SIZE);
>> +
>> +	pfn_start = page_xb_start;
>> +	while (pfn_start < page_xb_end) {
>> +		pfn_start = xb_find_next_set_bit(&vb->page_xb, pfn_start,
>> +						 page_xb_end);
>> +		if (pfn_start == page_xb_end + 1)
>> +			break;
>> +		pfn_end = xb_find_next_zero_bit(&vb->page_xb,
>> +						pfn_start + 1,
>> +						page_xb_end);
>> +		addr = pfn_start << PAGE_SHIFT;
>> +		len = (pfn_end - pfn_start) << PAGE_SHIFT;
> This assugnment can overflow. Next line compares with UINT_MAX but by
> that time it is too late.  I think you should do all math in 64 bit to
> avoid surprises, then truncate to max_len and then it's safe to assign
> to sg.

Sounds reasonable, thanks.


>> +
>> +	xb_clear_bit_range(&vb->page_xb, page_xb_start, page_xb_end);
>> +}
>> +
>> +static inline int xb_set_page(struct virtio_balloon *vb,
>> +			       struct page *page,
>> +			       unsigned long *pfn_min,
>> +			       unsigned long *pfn_max)
>> +{
>> +	unsigned long pfn = page_to_pfn(page);
>> +	int ret;
>> +
>> +	*pfn_min = min(pfn, *pfn_min);
>> +	*pfn_max = max(pfn, *pfn_max);
>> +
>> +	do {
>> +		ret = xb_preload_and_set_bit(&vb->page_xb, pfn,
>> +					     GFP_NOWAIT | __GFP_NOWARN);
>> +	} while (unlikely(ret == -EAGAIN));
> what exactly does this loop do? Does this wait
> forever until there is some free memory? why GFP_NOWAIT?

Basically, "-EAGAIN" is returned from xb_set_bit() in the case when the 
pre-allocated per-cpu ida_bitmap is NULL. In that case, the caller 
re-invokes xb_preload_and_set_bit(), which re-invokes xb_preload to 
allocate ida_bitmap. So "-EAGAIN" actually does not indicate a status 
about memory allocation. "-ENOMEM" is the one to indicate the failure of 
memory allocation, but the loop doesn't re-try on "-ENOMEM".

GFP_NOWAIT is used to avoid memory reclaiming, which could cause the 
deadlock issue we discussed before.




>   	return num_freed_pages;
>   }
>   
> +/*
> + * The regular leak_balloon() with VIRTIO_BALLOON_F_SG needs memory allocation
> + * for xbitmap, which is not suitable for the oom case. This function does not
> + * use xbitmap to chunk pages, so it can be used by oom notifier to deflate
> + * pages when VIRTIO_BALLOON_F_SG is negotiated.
> + */
> I guess we can live with this for now.

Agree, the patchset has been big. We can get the basic implementation in 
first, and leave the following as future work. I can add it in the 
commit log.

> Two things to consider
> - adding support for pre-allocating indirect buffers
> - sorting the internal page queue (how?)


Best,
Wei
