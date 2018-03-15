Received: from eggs.gnu.org ([2001:4830:134:3::10]:50916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewQ0h-0008IC-9k
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewQ0d-0004HI-45
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:21:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:17302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ewQ0c-0004CN-R6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:21:19 -0400
Message-ID: <5AAA49D0.7010200@intel.com>
Date: Thu, 15 Mar 2018 18:24:16 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-4-git-send-email-wei.w.wang@intel.com>
	<20180313183558-mutt-send-email-mst@kernel.org>
	<5AA88C35.90300@intel.com>
	<20180314045130-mutt-send-email-mst@kernel.org>
	<5AA8BB27.6030205@intel.com>
	<20180314160832-mutt-send-email-mst@kernel.org>
	<5AA9C944.2010403@intel.com>
	<20180315044543-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180315044543-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v4 3/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/15/2018 10:47 AM, Michael S. Tsirkin wrote:
> On Thu, Mar 15, 2018 at 09:15:48AM +0800, Wei Wang wrote:
>> On 03/14/2018 10:12 PM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 14, 2018 at 02:03:19PM +0800, Wei Wang wrote:
>>>> On 03/14/2018 10:53 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Mar 14, 2018 at 10:43:01AM +0800, Wei Wang wrote:
>>>>>> On 03/14/2018 12:49 AM, Michael S. Tsirkin wrote:
>>>>>>> On Wed, Mar 07, 2018 at 08:34:24PM +0800, Wei Wang wrote:
>>>>>>>
>>>>>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>>>>>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>>>>>>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>>>> CC: Juan Quintela <quintela@redhat.com>
>>>>>>> I find it suspicious that neither unrealize nor reset
>>>>>>> functions have been touched at all.
>>>>>>> Are you sure you have thought through scenarious like
>>>>>>> hot-unplug or disabling the device by guest?
>>>>>> OK. I think we can call balloon_free_page_stop in unrealize and reset.
>>>>>>
>>>>>>
>>>>>>> +static void *virtio_balloon_poll_free_page_hints(void *opaque)
>>>>>>> +{
>>>>>>> +    VirtQueueElement *elem;
>>>>>>> +    VirtIOBalloon *dev = opaque;
>>>>>>> +    VirtQueue *vq = dev->free_page_vq;
>>>>>>> +    uint32_t id;
>>>>>>> +    size_t size;
>>>>>>> What makes it safe to poke at this device from multiple threads?
>>>>>>> I think that it would be safer to do it from e.g. BH.
>>>>>>>
>>>>>> Actually the free_page_optimization thread is the only user of free_page_vq,
>>>>>> and there is only one optimization thread each time. Would this be safe
>>>>>> enough?
>>>>>>
>>>>>> Best,
>>>>>> Wei
>>>>> Aren't there other fields there? Also things like reset affect all VQs.
>>>>>
>>>> Yes. But I think BHs are used to avoid re-entrancy, which isn't the issue
>>>> here.
>>> Since you are adding locks to address the issue - doesn't this imply
>>> reentrancy is exactly the issue?
>> Not really. The lock isn't intended for any reentrancy issues, since there
>> will be only one run of the virtio_balloon_poll_free_page_hints function at
>> any given time. Instead, the lock is used to synchronize
>> virtio_balloon_poll_free_page_hints and virtio_balloon_free_page_stop to
>> access dev->free_page_report_status.
> I wonder whether that's enough. E.g. is there a race with guest
> trying to reset the device? That resets all VQs you know.

I think that's OK - we will call virtio_balloon_free_page_stop in the 
device reset function, and qemu_thread_join() in 
virtio_balloon_free_page_stop will wait till the optimization thread 
exits. That is, the reset will proceed after the optimization thread exits.


>
>
>> Please see the whole picture below:
>>
>> virtio_balloon_poll_free_page_hints()
>> {
>>
>>      while (1) {
>>          qemu_spin_lock();
>>          if (dev->free_page_report_status >= FREE_PAGE_REPORT_S_STOP ||
>>              !runstate_is_running()) {
>>              qemu_spin_unlock();
>>              break;
>>          }
>>          ...
>>          if (id == dev->free_page_report_cmd_id) {
>> ==>        dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>>          ...
>>          qemu_spin_unlock();
>>      }
>> }
>>
>>
>> static void virtio_balloon_free_page_stop(void *opaque)
>> {
>>      VirtIOBalloon *s = opaque;
>>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>
>>      qemu_spin_lock();
>> ...
>> ==>       s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>      ...
>>      qemu_spin_unlock();
>> }
>>
>>
>> Without the lock, there are theoretical possibilities that assigning STOP
>> below is overridden by START above. In that
>> case,virtio_balloon_free_page_stop does not effectively stop
>> virtio_balloon_poll_free_page_hints.
>> I think this issue couldn't be solved by BHs.
>>
>> Best,
>> Wei
> Don't all BHs run under the BQL?

Actually the virtio_balloon_free_page_stop is called by the migration 
thread (instead of a BH). Even we guarantee the migration thread calls 
virtio_balloon_free_page_stop under BQL, the BQL is still too big for 
our case. Imagine this case: when the migration thread calls 
virtio_balloon_free_page_stop to stop the reporting, it blocks by BQL as 
virtio_balloon_poll_free_page_hints is in progress with BQL held, and 
the migration thread won't proceed untill 
virtio_balloon_poll_free_page_hints exits (i.e. getting all the hints). 
I think this isn't our intention - we basically want the migration 
thread to stop the guest reporting immediately.
So I think the small lock above is better (it locks for only one hint).

Best,
Wei
