Received: from eggs.gnu.org ([2001:4830:134:3::10]:44192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQnQX-00017l-TN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQnQU-0004Yw-Ot
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:25:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:33777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fQnQU-0004Y3-E0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:25:34 -0400
Message-ID: <5B18C2B2.30709@intel.com>
Date: Thu, 07 Jun 2018 13:29:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180606064315.GB7815@xz-mi> <5B17B366.5030802@intel.com>
	<20180607031732.GG7815@xz-mi>
In-Reply-To: <20180607031732.GG7815@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On 06/07/2018 11:17 AM, Peter Xu wrote:
> On Wed, Jun 06, 2018 at 06:11:50PM +0800, Wei Wang wrote:
>
> I got similar comments from Michael, and it will be
> while (1) {
> lock;
> func();
> unlock();
> }
>
> All the unlock inside the body will be gone.
> Ok I think I have more question on this part...
>
> Actually AFAICT this new feature uses iothread in a way very similar
> to the block layer, so I digged a bit on how block layer used the
> iothreads.  I see that the block code is using something like
> virtio_queue_aio_set_host_notifier_handler() to hook up the
> iothread/aiocontext and the ioeventfd, however here you are manually
> creating one QEMUBH and bound that to the new context.  Should you
> also use something like the block layer?  Then IMHO you can avoid
> using a busy loop there (assuming the performance does not really
> matter that much here for page hintings), and all the packet handling
> can again be based on interrupts from the guest (ioeventfd).
>
> [1]

Also mentioned in another discussion thread that it's better to not let 
guest send notifications. Otherwise, we would have used the virtqueue 
door bell to notify host.
So we need to use polling here, and Michael suggested to implemented in 
BH, which sounds good to me.


>
>>> [...]
>>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>>>> +    .name = "virtio-balloon-device/free-page-report",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = virtio_balloon_free_page_support,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>>> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
>>> (could we move all the poison-related lines into another patch or
>>>    postpone?  after all we don't support it yet, do we?)
>>>
>>   We don't support migrating poison value, but guest maybe use it, so we are
>> actually disabling this feature in that case. Probably good to leave the
>> code together to handle that case.
> Could we just avoid declaring that feature bit in emulation code
> completely?  I mean, we support VIRTIO_BALLOON_F_FREE_PAGE_HINT first
> as the first step (as you mentioned in commit message, the POISON is a
> TODO).  Then when you really want to completely support the POISON
> bit, you can put all that into a separate patch.  Would that work?
>

Not really. The F_PAGE_POISON isn't a feature configured via QEMU cmd 
line like F_FREE_PAGE_HINT. We always set F_PAGE_POISON if 
F_FREE_PAGE_HINT is enabled. It is used to detect if the guest is using 
page poison.


>>
>>>> +    if (virtio_has_feature(s->host_features,
>>>> +                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>>> +        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
>>>> +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>>> +        s->free_page_report_cmd_id =
>>>> +                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;
>>> Why explicitly -1?  I thought ID_MIN would be fine too?
>> Yes, that will also be fine. Since we states that the cmd id will be from
>> [MIN, MAX], and we make s->free_page_report_cmd_id++ in start(), using
>> VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN here will make it [MIN + 1, MAX].
> Then I would prefer we just use the MIN value, otherwise IMO we'd
> better have a comment mentioning about why that -1 is there.

Sure, we can do that.

Best,
Wei
