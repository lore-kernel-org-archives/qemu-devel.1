Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7v8E-00051Y-U0
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7v8B-0004n5-RY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:44:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:65409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d7v8B-0004me-Gq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:44:07 -0400
Message-ID: <59112D67.9080405@intel.com>
Date: Tue, 09 May 2017 10:45:59 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1492076108-117229-3-git-send-email-wei.w.wang@intel.com>
	<20170413184040-mutt-send-email-mst@kernel.org>
	<58F08A60.2020407@intel.com>
	<20170415000934-mutt-send-email-mst@kernel.org>
	<58F43801.7060004@intel.com>
	<286AC319A985734F985F78AFA26841F7391F6DCD@shsmsx102.ccr.corp.intel.com>
	<20170426192753-mutt-send-email-mst@kernel.org>
	<59019055.3040708@intel.com>
	<20170506012322-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7391FFBB0@shsmsx102.ccr.corp.intel.com>
	<20170508203533-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170508203533-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v9 2/5] virtio-balloon:
 VIRTIO_BALLOON_F_BALLOON_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>

On 05/09/2017 01:40 AM, Michael S. Tsirkin wrote:
> On Sun, May 07, 2017 at 04:19:28AM +0000, Wang, Wei W wrote:
>> On 05/06/2017 06:26 AM, Michael S. Tsirkin wrote:
>>> On Thu, Apr 27, 2017 at 02:31:49PM +0800, Wei Wang wrote:
>>>> On 04/27/2017 07:20 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Apr 26, 2017 at 11:03:34AM +0000, Wang, Wei W wrote:
>>>>>> Hi Michael, could you please give some feedback?
>>>>> I'm sorry, I'm not sure feedback on what you are requesting.
>>>> Oh, just some trivial things (e.g. use a field in the header,
>>>> hdr->chunks to indicate the number of chunks in the payload) that
>>>> wasn't confirmed.
>>>>
>>>> I will prepare the new version with fixing the agreed issues, and we
>>>> can continue to discuss those parts if you still find them improper.
>>>>
>>>>
>>>>> The interface looks reasonable now, even though there's a way to
>>>>> make it even simpler if we can limit chunk size to 2G (in fact 4G -
>>>>> 1). Do you think we can live with this limitation?
>>>> Yes, I think we can. So, is it good to change to use the previous
>>>> 64-bit chunk format (52-bit base + 12-bit size)?
>>> This isn't what I meant. virtio ring has descriptors with a 64 bit address and 32 bit
>>> size.
>>>
>>> If size < 4g is not a significant limitation, why not just use that to pass
>>> address/size in a standard s/g list, possibly using INDIRECT?
>> OK, I see your point, thanks. Post the two options here for an analysis:
>> Option1 (what we have now):
>> struct virtio_balloon_page_chunk {
>>          __le64 chunk_num;
>>          struct virtio_balloon_page_chunk_entry entry[];
>> };
>> Option2:
>> struct virtio_balloon_page_chunk {
>>          __le64 chunk_num;
>>          struct scatterlist entry[];
>> };
> This isn't what I meant really :) I meant vring_desc.

OK. Repost the code change:

Option2:
struct virtio_balloon_page_chunk {
         __le64 chunk_num;
         struct ving_desc entry[];
};

We pre-allocate a table of desc, and each desc is used to hold a chunk.

In that case, the virtqueue_add() function, which deals with sg, is not
usable for us. We may need to add a new one,
virtqueue_add_indirect_desc(),
to add a pre-allocated indirect descriptor table to vring.


>
>> I don't have an issue to change it to Option2, but I would prefer Option1,
>> because I think there is no be obvious difference between the two options,
>> while Option1 appears to have little advantages here:
>> 1) "struct virtio_balloon_page_chunk_entry" has smaller size than
>> "struct scatterlist", so the same size of allocated page chunk buffer
>> can hold more entry[] using Option1;
>> 2) INDIRECT needs on demand kmalloc();
> Within alloc_indirect?  We can fix that with a separate patch.
>
>
>> 3) no 4G size limit;
> Do you see lots of >=4g chunks in practice?
It wouldn't be much in practice, but we still need the extra code to
handle the case - break larger chunks into less-than 4g ones.

Best,
Wei
