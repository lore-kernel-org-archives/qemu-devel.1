Received: from eggs.gnu.org ([2001:4830:134:3::10]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1djf6y-0006fP-96
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1djf6u-0003rG-Tg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:18:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:38631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1djf6u-0003hP-Kz
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:18:48 -0400
Message-ID: <599A6DE2.3040309@intel.com>
Date: Mon, 21 Aug 2017 13:21:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-6-git-send-email-wei.w.wang@intel.com>
	<20170818045519-mutt-send-email-mst@kernel.org>
	<5996A845.4010405@intel.com>
	<20170818211119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170818211119-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 5/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 08/19/2017 02:26 AM, Michael S. Tsirkin wrote:
> On Fri, Aug 18, 2017 at 04:41:41PM +0800, Wei Wang wrote:
>> On 08/18/2017 10:13 AM, Michael S. Tsirkin wrote:
>>> On Thu, Aug 17, 2017 at 11:26:56AM +0800, Wei Wang wrote:
>>>> Add a new vq to report hints of guest free pages to the host.
>>> Please add some text here explaining the report_free_page_signal
>>> thing.
>>>
>>>
>>> I also really think we need some kind of ID in the
>>> buffer to do a handshake. whenever id changes you
>>> add another outbuf.
>> Please let me introduce the current design first:
>> 1) device put the signal buf to the vq and notify the driver (we need
>> a buffer because currently the device can't notify when the vq is empty);
>>
>> 2) the driver starts the report of free page blocks via inbuf;
>>
>> 3) the driver adds an the signal buf via outbuf to tell the device all are
>> reported.
>>
>>
>> Could you please elaborate more on the usage of ID?
> While driver is free to maintain at most one buffer in flight
> the design must work with pipelined requests as that
> is important for performance.

How would the pipeline be designed?

Currently, once the report starts,
- the driver work: add_inbuf(free_pages) & kick;

- the device work:
     record the pages into a free page bitmap;
     virtqueue_push(elem);
     virtio_notify();

For the driver, as long as the vq has available entries, it keeps doing 
its work;
For the device, as long as there are free pages in the vq, it also keeps 
doing its work.


>
> So host might be able to request the reporting twice.
> How does it know what is the report in response to?

The request to start is sent when live migration starts, where would be
the second chance to send the request to start?



>
> If we put an id in request and in response, then that fixes it.
>
>
> So there's a vq used for requesting free page reports.
> driver does add_inbuf( &device->id).
>
> Then when it starts reporting it does
>
>
> add_outbuf(&device->id)
>
> followed by pages.
>
>
> Also if device->id changes it knows it should restart
> reporting from beginning.
>
>
>
>
>
>
>>>> +retry:
>>>> +	ret = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>>>> +	virtqueue_kick(vq);
>>>> +	if (unlikely(ret == -ENOSPC)) {
>>> what if there's another error?
>> Another error is -EIO, how about disabling the free page report feature?
>> (I also saw it isn't handled in many other virtio devices e.g. virtio-net)
>>
>>>> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
>>>> +		goto retry;
>>>> +	}
>>> what is this trickery doing? needs more comments or
>>> a simplification.
>> Just this:
>> if the vq is full, blocking wait till an entry gets released, then retry.
>> This is the
>> final one, which puts the signal buf to the vq to signify the end of the
>> report and
>> the mm lock is not held here, so it is fine to block.
>>
> But why do you kick here on failure? I would understand it if you
> did not kick when adding pages, as it is I don't understand.
>
>
> Also pls rewrite this with a for or while loop for clarity.

OK, I will rewrite this part.


Best,
Wei
