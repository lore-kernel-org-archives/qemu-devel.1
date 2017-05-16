Received: from eggs.gnu.org ([2001:4830:134:3::10]:45694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dAU3i-0002cU-KG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dAU3f-00081l-Ga
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:26:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:63828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dAU3f-00080s-77
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:26:03 -0400
Message-ID: <591A7FCE.1010703@intel.com>
Date: Tue, 16 May 2017 12:27:58 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1494478641-24549-1-git-send-email-wei.w.wang@intel.com>
	<591974EB.2010409@intel.com>
	<20170515174044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170515174044-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] virtio-net: keep the
 packet layout intact
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com

On 05/15/2017 10:46 PM, Michael S. Tsirkin wrote:
> On Mon, May 15, 2017 at 05:29:15PM +0800, Wei Wang wrote:
>> Ping for comments, thanks.
>>
>> On 05/11/2017 12:57 PM, Wei Wang wrote:
>>> The current implementation may change the packet layout when
>>> vnet_hdr needs an endianness swap. The layout change causes
>>> one more iov to be added to the iov[] passed from the guest, which
>>> is a barrier to making the TX queue size 1024 due to the possible
>>> off-by-one issue.
> It blocks making it 512 but I don't think we can make it 1024
> as entries might cross page boundaries and get split.
>

I agree with the performance lose issue you mentioned
below, thanks. To understand more here, could you please
shed some light on "entries can't cross page boundaries"?

Seems the virtio spec doesn't mention that vring_desc entries
shouldn't be in two physically continuous pages. Also didn't
find an issue from the implementation.
On the device side, the writev manual does require the iov[]
array to be in one page only, and the limit to iovcnt is 1024.


>>> This patch changes the implementation to remain the packet layout
>>> intact. In this case, the number of iov[] passed to writev will be
>>> equal to the number obtained from the guest.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> As this is at the cost of a full data copy, I don't think
> this makes sense. We could limit this when sg list does not fit
> in 1024.

Yes, this would cause a performance loss with the layout that data
is adjacent with vnet_hdr. Since you prefer another solution below,
I will skip and not discuss my ideas to avoid that copy.

> But I really think we should just add a max s/g field to virtio
> and then we'll be free to increase the ring size.

Yes, that's also a good way to solve it. So, add a new device
property, "max_chain_size" and a feature bit to detect it?


Best,
Wei
