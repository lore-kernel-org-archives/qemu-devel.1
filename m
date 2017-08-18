Received: from eggs.gnu.org ([2001:4830:134:3::10]:43951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dicnx-000585-4n
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dicnu-0002qC-0t
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:38:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:3369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dicnt-0002ps-OT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:38:53 -0400
Message-ID: <5996A845.4010405@intel.com>
Date: Fri, 18 Aug 2017 16:41:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-6-git-send-email-wei.w.wang@intel.com>
	<20170818045519-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170818045519-mutt-send-email-mst@kernel.org>
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

On 08/18/2017 10:13 AM, Michael S. Tsirkin wrote:
> On Thu, Aug 17, 2017 at 11:26:56AM +0800, Wei Wang wrote:
>> Add a new vq to report hints of guest free pages to the host.
> Please add some text here explaining the report_free_page_signal
> thing.
>
>
> I also really think we need some kind of ID in the
> buffer to do a handshake. whenever id changes you
> add another outbuf.

Please let me introduce the current design first:
1) device put the signal buf to the vq and notify the driver (we need
a buffer because currently the device can't notify when the vq is empty);

2) the driver starts the report of free page blocks via inbuf;

3) the driver adds an the signal buf via outbuf to tell the device all 
are reported.


Could you please elaborate more on the usage of ID?

>> +retry:
>> +	ret = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>> +	virtqueue_kick(vq);
>> +	if (unlikely(ret == -ENOSPC)) {
> what if there's another error?

Another error is -EIO, how about disabling the free page report feature?
(I also saw it isn't handled in many other virtio devices e.g. virtio-net)

>> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
>> +		goto retry;
>> +	}
> what is this trickery doing? needs more comments or
> a simplification.

Just this:
if the vq is full, blocking wait till an entry gets released, then 
retry. This is the
final one, which puts the signal buf to the vq to signify the end of the 
report and
the mm lock is not held here, so it is fine to block.


>
>
>> +}
>> +
>> +static void report_free_page(struct work_struct *work)
>> +{
>> +	struct virtio_balloon *vb;
>> +
>> +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
>> +	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
> That's a lot of work here. And system_wq documentation says:
>   *
>   * system_wq is the one used by schedule[_delayed]_work[_on]().
>   * Multi-CPU multi-threaded.  There are users which expect relatively
>   * short queue flush time.  Don't queue works which can run for too
>   * long.
>
> You might want to create your own wq, maybe even with WQ_CPU_INTENSIVE.

Thanks for the reminder. If not creating a new wq, how about 
system_unbound_wq?
The first round of live migration needs the free pages, in that way we 
can have the
pages reported to the hypervisor quicker.

>
>> +	report_free_page_completion(vb);
> So first you get list of pages, then an outbuf telling you
> what they are in end of.  I think it's backwards.
> Add an outbuf first followed by inbufs that tell you
> what they are.


If we have the signal filled with those flags like
VIRTIO_BALLOON_F_FREE_PAGE_REPORT_START,
Probably not necessary to have an inbuf followed by an outbuf, right?


Best,
Wei
