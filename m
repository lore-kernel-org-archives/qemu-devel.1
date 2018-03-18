Received: from eggs.gnu.org ([2001:4830:134:3::10]:37716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1exVd2-0005qu-AB
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 06:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1exVcz-0005Iq-4o
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 06:33:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:51258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1exVcy-0005Ca-EC
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 06:33:24 -0400
Message-ID: <5AAE4124.5010602@intel.com>
Date: Sun, 18 Mar 2018 18:36:20 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
	<1521197309-13544-5-git-send-email-wei.w.wang@intel.com>
	<20180316165319-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180316165319-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/5] virtio-balloon:
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

On 03/16/2018 11:16 PM, Michael S. Tsirkin wrote:
> On Fri, Mar 16, 2018 at 06:48:28PM +0800, Wei Wang wrote:
>> The new feature enables the virtio-balloon device to receive hints of
>> guest free pages from the free page vq.
>>
>> balloon_free_page_start - start guest free page hint reporting.
>> balloon_free_page_stop - stop guest free page hint reporting.
>>
>> Note: balloon will report pages which were free at the time
>> of this call. As the reporting happens asynchronously, dirty bit logging
>> must be enabled before this call is made. Guest reporting must be
>> disabled before the migration dirty bitmap is synchronized.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> ---
>>   balloon.c                                       |  58 +++++--
>>   hw/virtio/virtio-balloon.c                      | 217 ++++++++++++++++++++++--
>>   include/hw/virtio/virtio-balloon.h              |  20 ++-
>>   include/standard-headers/linux/virtio_balloon.h |   7 +
>>   include/sysemu/balloon.h                        |  15 +-
>>   5 files changed, 288 insertions(+), 29 deletions(-)
>>
>> diff --git a/balloon.c b/balloon.c
>> index 6bf0a96..87a0410 100644
>> --- a/balloon.c
>> +++ b/balloon.c
>> @@ -36,6 +36,9 @@
>>   
>>
>> +static void *virtio_balloon_poll_free_page_hints(void *opaque)
>> +{
>> +    VirtQueueElement *elem;
>> +    VirtIOBalloon *dev = opaque;
>> +    VirtQueue *vq = dev->free_page_vq;
>> +    uint32_t id;
>> +    size_t size;
>> +
>> +    /* The optimization thread runs only when the guest is running. */
>> +    while (runstate_is_running()) {
> Note that this check is not guaranteed to be correct
> when checked like this outside BQL.
>
> I think you are better off relying on status
> callback to synchronise with the backend thread.
>

It's actually OK here, I think we don't need the guarantee. The device 
is just the consumer of the vq, essentially it doesn't have a dependency 
(i.e. won't block or cause errors) on the guest state.
For example:
1) when the device executes "while (runstate_is_running())" and finds 
that the guest is running, it proceeds;
2) the guest is stopped immediately right after the "while 
(runstate_is_running())" check;
3) the device side execution reaches virtqueue_pop(), and finds 
"elem==NULL", since the driver (provider) stops adding hints. Then it 
continues by going back to "while (runstate_is_running())", and now it 
finds the guest is stopped, and then exits.

Essentially, this runstate check is just an optimization to the case 
that the driver is stopped to provide hints while the device side 
optimization thread is still polling the empty vq (i.e. effort in vain). 
Probably, it would be better to check the runstate under "elem==NULL":

while (1) {
     ...
     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     if (!elem) {
             qemu_spin_unlock(&dev->free_page_lock);
             if (runstate_is_running())
                 continue;
             else
                 break;
     }
     ...
}


>> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>> +            } else if (dev->free_page_report_status ==
>> +                       FREE_PAGE_REPORT_S_START) {
>> +                /*
>> +                 * Stop the optimization only when it has started. This avoids
>> +                 * a stale stop sign for the previous command.
>> +                 */
>> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>> +                qemu_spin_unlock(&dev->free_page_lock);
>> +                break;
>> +            }
> And else? What if it does not match and status is not start?
> Don't you need to skip in elem decoding?

No, actually we don't need "else". Please see the code inside if 
(elem->in_num) below. If the status isn't set to START, 
qemu_guest_free_page_hint will not be called to decode the elem.


>
>> +        }
>> +
>> +        if (elem->in_num) {
>> +            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START &&
>> +                !dev->poison_val) {
> poison generally disables everything? Add a TODO to handle
> it in he future pls.


OK, will add TODO in the commit.



@@ -368,6 +499,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
                          &error_abort);
      }
+    dev->poison_val = le32_to_cpu(config.poison_val);

> We probably should not assume this value is correct if guest didn't
> ack the appropriate feature.


OK, I'll add a comment to explain that.


@@ -475,11 +632,37 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
  {
      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
  
-    if (!s->stats_vq_elem && vdev->vm_running &&
-        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
-        /* poll stats queue for the element we have discarded when the VM
-         * was stopped */
-        virtio_balloon_receive_stats(vdev, s->svq);
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        if (!s->stats_vq_elem && vdev->vm_running &&
+            virtqueue_rewind(s->svq, 1)) {
+            /*
+             * Poll stats queue for the element we have discarded when the VM
+             * was stopped.
+             */
+            virtio_balloon_receive_stats(vdev, s->svq);
+        }
+
+        if (virtio_balloon_free_page_support(s)) {
+            qemu_add_balloon_handler(virtio_balloon_to_target,
+                                     virtio_balloon_stat,
+                                     virtio_balloon_free_page_support,
+                                     virtio_balloon_free_page_start,
+                                     virtio_balloon_free_page_stop,
+                                     s);
+            /*
+             * This handles the case that the guest is being stopped (e.g. by
+             * qmp commands) while the driver is still reporting hints. When
+             * the guest is woken up, it will continue to report hints, which
+             * are not needed. So when the wakeup notifier invokes the
+             * set_status callback here, we get the chance to make sure that
+             * the free page optimization thread is exited via
+             * virtio_balloon_free_page_stop.
+             */
+            virtio_balloon_free_page_stop(s);

> I don't understand the logic here at all.
> So if status is set to DRIVER_OK, then we stop reporting?
>

I thought about this more. It's not necessary to call the stop() 
function here, because we have already made the optimization thread exit 
when the guest is stopped. When the guest is woken up, it will continue 
to report, and there is no consumer of the vq (the optimization thread 
has exited). There is no functional issue here, since the driver will 
just drop the hint when the vq is full. From the optimization point of 
view, I think we can consider to replace the above sop() function with 
virtio_notify_config(vdev), which will stop the guest's unnecessary 
reporting.


Best,
Wei
