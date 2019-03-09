Received: from eggs.gnu.org ([209.51.188.92]:47414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1h2ZyU-00085i-Lc
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 06:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1h2ZyT-0001AM-P2
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 06:17:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:8467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1h2ZyT-00011a-D1
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 06:17:05 -0500
Message-ID: <5C83A1DF.2020803@intel.com>
Date: Sat, 09 Mar 2019 19:22:07 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20190306114227.9125-1-dgilbert@redhat.com>
	<20190306114227.9125-20-dgilbert@redhat.com>
	<CAFEAcA-mJdymqYBp-xrUbrXQ_fZ+mTZ90DG0nQs3v40HVxETzA@mail.gmail.com>
	<20190308183053.GI2834@work-vm>
In-Reply-To: <20190308183053.GI2834@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 19/22] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, yury-kotov@yandex-team.ru, Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>

On 03/09/2019 02:30 AM, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On Wed, 6 Mar 2019 at 11:55, Dr. David Alan Gilbert (git)
>> <dgilbert@redhat.com> wrote:
>>> From: Wei Wang <wei.w.wang@intel.com>
>
> Wei: Can you look at this....

Sure, I'll send a followup patch to fix this.


>
>>> The new feature enables the virtio-balloon device to receive hints of
>>> guest free pages from the free page vq.
>>>
>>> A notifier is registered to the migration precopy notifier chain. The
>>> notifier calls free_page_start after the migration thread syncs the dirty
>>> bitmap, so that the free page optimization starts to clear bits of free
>>> pages from the bitmap. It calls the free_page_stop before the migration
>>> thread syncs the bitmap, which is the end of the current round of ram
>>> save. The free_page_stop is also called to stop the optimization in the
>>> case when there is an error occurred in the process of ram saving.
>>>
>>> Note: balloon will report pages which were free at the time of this call.
>>> As the reporting happens asynchronously, dirty bit logging must be
>>> enabled before this free_page_start call is made. Guest reporting must be
>>> disabled before the migration dirty bitmap is synchronized.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> CC: Juan Quintela <quintela@redhat.com>
>>> CC: Peter Xu <peterx@redhat.com>
>>> Message-Id: <1544516693-5395-8-git-send-email-wei.w.wang@intel.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>    dgilbert: Dropped kernel header update, fixed up CMD_ID_* name change
>>> ---
>> Hi -- Coverity points out a use-after-free here (CID 1399412):
>>
>>> +static bool get_free_page_hints(VirtIOBalloon *dev)
>>> +{
>>> +    VirtQueueElement *elem;
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>> +    VirtQueue *vq = dev->free_page_vq;
>>> +
>>> +    while (dev->block_iothread) {
>>> +        qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
>>> +    }
>>> +
>>> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>>> +    if (!elem) {
>>> +        return false;
>>> +    }
>>> +
>>> +    if (elem->out_num) {
>>> +        uint32_t id;
>>> +        size_t size = iov_to_buf(elem->out_sg, elem->out_num, 0,
>>> +                                 &id, sizeof(id));
>>> +        virtqueue_push(vq, elem, size);
>>> +        g_free(elem);
>> Here we free elem...
>>
>>> +
>>> +        virtio_tswap32s(vdev, &id);
>>> +        if (unlikely(size != sizeof(id))) {
>>> +            virtio_error(vdev, "received an incorrect cmd id");
>>> +            return false;
>>> +        }
>>> +        if (id == dev->free_page_report_cmd_id) {
>>> +            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>>> +        } else {
>>> +            /*
>>> +             * Stop the optimization only when it has started. This
>>> +             * avoids a stale stop sign for the previous command.
>>> +             */
>>> +            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
>>> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    if (elem->in_num) {
>> ...but we can fall through here and try to dereference elem...
>>
>>> +        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
>>> +            qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
>>> +                                      elem->in_sg[0].iov_len);
>>> +        }
>>> +        virtqueue_push(vq, elem, 1);
>>> +        g_free(elem);
>> ...and then free it again.
> OK, so the question here is:
>    Is it allowed to have both in and out in the same queue element; if
> it's not then we need to error the device.
>    If it is allowed then we need to fix up the out_num case.
>

I think it is allowed. From virtqueue_pop, an elem could consist of 
several inbufs and outbufs.

Probably we could just delay the free till the end of this 
function..will post the fix patch for review soon.

Best,
Wei
