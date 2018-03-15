Received: from eggs.gnu.org ([2001:4830:134:3::10]:46617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewHRs-0000DR-6y
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 21:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewHRo-00012B-Sz
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 21:12:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ewHRo-000118-Hr
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 21:12:48 -0400
Message-ID: <5AA9C944.2010403@intel.com>
Date: Thu, 15 Mar 2018 09:15:48 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-4-git-send-email-wei.w.wang@intel.com>
	<20180313183558-mutt-send-email-mst@kernel.org>
	<5AA88C35.90300@intel.com>
	<20180314045130-mutt-send-email-mst@kernel.org>
	<5AA8BB27.6030205@intel.com>
	<20180314160832-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180314160832-mutt-send-email-mst@kernel.org>
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

On 03/14/2018 10:12 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 14, 2018 at 02:03:19PM +0800, Wei Wang wrote:
>> On 03/14/2018 10:53 AM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 14, 2018 at 10:43:01AM +0800, Wei Wang wrote:
>>>> On 03/14/2018 12:49 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Mar 07, 2018 at 08:34:24PM +0800, Wei Wang wrote:
>>>>>
>>>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>>>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>>>>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>>>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>> CC: Juan Quintela <quintela@redhat.com>
>>>>> I find it suspicious that neither unrealize nor reset
>>>>> functions have been touched at all.
>>>>> Are you sure you have thought through scenarious like
>>>>> hot-unplug or disabling the device by guest?
>>>> OK. I think we can call balloon_free_page_stop in unrealize and reset.
>>>>
>>>>
>>>>> +static void *virtio_balloon_poll_free_page_hints(void *opaque)
>>>>> +{
>>>>> +    VirtQueueElement *elem;
>>>>> +    VirtIOBalloon *dev = opaque;
>>>>> +    VirtQueue *vq = dev->free_page_vq;
>>>>> +    uint32_t id;
>>>>> +    size_t size;
>>>>> What makes it safe to poke at this device from multiple threads?
>>>>> I think that it would be safer to do it from e.g. BH.
>>>>>
>>>> Actually the free_page_optimization thread is the only user of free_page_vq,
>>>> and there is only one optimization thread each time. Would this be safe
>>>> enough?
>>>>
>>>> Best,
>>>> Wei
>>> Aren't there other fields there? Also things like reset affect all VQs.
>>>
>> Yes. But I think BHs are used to avoid re-entrancy, which isn't the issue
>> here.
> Since you are adding locks to address the issue - doesn't this imply
> reentrancy is exactly the issue?

Not really. The lock isn't intended for any reentrancy issues, since 
there will be only one run of the virtio_balloon_poll_free_page_hints 
function at any given time. Instead, the lock is used to synchronize 
virtio_balloon_poll_free_page_hints and virtio_balloon_free_page_stop to 
access dev->free_page_report_status. Please see the whole picture below:

virtio_balloon_poll_free_page_hints()
{

     while (1) {
         qemu_spin_lock();
         if (dev->free_page_report_status >= FREE_PAGE_REPORT_S_STOP ||
             !runstate_is_running()) {
             qemu_spin_unlock();
             break;
         }
         ...
         if (id == dev->free_page_report_cmd_id) {
==>        dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         ...
         qemu_spin_unlock();
     }
}


static void virtio_balloon_free_page_stop(void *opaque)
{
     VirtIOBalloon *s = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);

     qemu_spin_lock();
...
==>       s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
     ...
     qemu_spin_unlock();
}


Without the lock, there are theoretical possibilities that assigning 
STOP below is overridden by START above. In that 
case,virtio_balloon_free_page_stop does not effectively stop 
virtio_balloon_poll_free_page_hints.
I think this issue couldn't be solved by BHs.

Best,
Wei
