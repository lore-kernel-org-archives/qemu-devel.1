Received: from eggs.gnu.org ([2001:4830:134:3::10]:34181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1eMpqW-0007z5-5A
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1eMpqR-0001Zy-74
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:39:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1eMpqQ-0001XL-N2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:39:43 -0500
From: Ilya Maximets <i.maximets@samsung.com>
Message-id: <249c9e25-0bdb-7a44-6821-59474d25baa5@samsung.com>
Date: Thu, 07 Dec 2017 09:39:36 +0300
MIME-version: 1.0
In-reply-to: <20171206184432-mutt-send-email-mst@kernel.org>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
References: <CGME20171206130624eucas1p1f73fd4cf613eaf3ce4ce6918c807f8e1@eucas1p1.samsung.com>
	<1512565578-12078-1-git-send-email-i.maximets@samsung.com>
	<20171206184432-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] vhost: fix crash on virtio_error while
 device stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Heetae Ahn <heetae82.ahn@samsung.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 06.12.2017 19:45, Michael S. Tsirkin wrote:
> On Wed, Dec 06, 2017 at 04:06:18PM +0300, Ilya Maximets wrote:
>> In case virtio error occured after vhost_dev_close(), qemu will crash
>> in nested cleanup while checking IOMMU flag because dev->vdev already
>> set to zero and resources are already freed.
>>
>> Example:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> vhost_virtqueue_stop at hw/virtio/vhost.c:1155
>>
>>     #0  vhost_virtqueue_stop at hw/virtio/vhost.c:1155
>>     #1  vhost_dev_stop at hw/virtio/vhost.c:1594
>>     #2  vhost_net_stop_one at hw/net/vhost_net.c:289
>>     #3  vhost_net_stop at hw/net/vhost_net.c:368
>>
>>             Nested call to vhost_net_stop(). First time was at #14.
>>
>>     #4  virtio_net_vhost_status at hw/net/virtio-net.c:180
>>     #5  virtio_net_set_status (status=79) at hw/net/virtio-net.c:254
>>     #6  virtio_set_status at hw/virtio/virtio.c:1146
>>     #7  virtio_error at hw/virtio/virtio.c:2455
>>
>>         virtqueue_get_head() failed here.
>>
>>     #8  virtqueue_get_head at hw/virtio/virtio.c:543
>>     #9  virtqueue_drop_all at hw/virtio/virtio.c:984
>>     #10 virtio_net_drop_tx_queue_data at hw/net/virtio-net.c:240
>>     #11 virtio_bus_set_host_notifier at hw/virtio/virtio-bus.c:297
>>     #12 vhost_dev_disable_notifiers at hw/virtio/vhost.c:1431
>>
>>         vhost_dev_stop() was executed here. dev->vdev == NULL now.
>>
>>     #13 vhost_net_stop_one at hw/net/vhost_net.c:290
>>     #14 vhost_net_stop at hw/net/vhost_net.c:368
>>     #15 virtio_net_vhost_status at hw/net/virtio-net.c:180
>>     #16 virtio_net_set_status (status=15) at hw/net/virtio-net.c:254
>>     #17 qmp_set_link ("hostnet0", up=false) at net/net.c:1430
>>     #18 chr_closed_bh at net/vhost-user.c:214
>>     #19 aio_bh_call at util/async.c:90
>>     #20 aio_bh_poll at util/async.c:118
>>     #21 aio_dispatch at util/aio-posix.c:429
>>     #22 aio_ctx_dispatch at util/async.c:261
>>     #23 g_main_context_dispatch
>>     #24 glib_pollfds_poll at util/main-loop.c:213
>>     #25 os_host_main_loop_wait at util/main-loop.c:261
>>     #26 main_loop_wait at util/main-loop.c:515
>>     #27 main_loop () at vl.c:1917
>>     #28 main at vl.c:4795
>>
>> Above backtrace captured from qemu crash on vhost disconnect while
>> virtio driver in guest was in failed state.
>>
>> We can just add checking for 'vdev' in 'vhost_dev_has_iommu()' but
>> it will assert further trying to free already freed ioeventfds. The
>> real problem is that we're allowing nested calls to 'vhost_net_stop'.
>>
>> This patch is aimed to forbid nested calls to 'vhost_net_stop' to avoid
>> any possible double frees and segmentation faults doue to using of
>> already freed resources by setting 'vhost_started' flag to zero prior
>> to 'vhost_net_stop' call.
>>
>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>> ---
>>
>> This issue was already addressed more than a year ago by the following
>> patch: https://lists.gnu.org/archive/html/qemu-devel/2016-03/msg06732.html
>> but it was dropped without review due to not yet implemented re-connection
>> of vhost-user. Re-connection implementation lately fixed most of the
>> nested calls, but few of them still exists. For example, above backtrace
>> captured after 'virtqueue_get_head()' failure on vhost-user disconnection.
>>
>>  hw/net/virtio-net.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 38674b0..4d95a18 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -177,8 +177,8 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
>>              n->vhost_started = 0;
>>          }
>>      } else {
>> -        vhost_net_stop(vdev, n->nic->ncs, queues);
>>          n->vhost_started = 0;
>> +        vhost_net_stop(vdev, n->nic->ncs, queues);
>>      }
>>  }
> 
> Well the wider context is
> 
> 
>         n->vhost_started = 1;
>         r = vhost_net_start(vdev, n->nic->ncs, queues);
>         if (r < 0) {
>             error_report("unable to start vhost net: %d: "
>                          "falling back on userspace virtio", -r);
>             n->vhost_started = 0;
>         }
>     } else {
>         vhost_net_stop(vdev, n->nic->ncs, queues);
>         n->vhost_started = 0;
> 
> So we set it to 1 before start, we should clear after stop.

OK. I agree that clearing after is a bit safer. But in this case we need
a separate flag or other way to detect that we're already inside the
'vhost_net_stop()'.

What do you think about that old patch:
https://lists.gnu.org/archive/html/qemu-devel/2016-03/msg06732.html  ?

It implements the same thing but introduces additional flag. It even could
be still applicable.
