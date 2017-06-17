Received: from eggs.gnu.org ([2001:4830:134:3::10]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dM9Cu-0002iK-Bd
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 04:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dM9Cs-0001S3-2h
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 04:35:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:63355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dM9Cr-0001RK-Ow
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 04:35:45 -0400
Message-ID: <5944EA6B.2080606@intel.com>
Date: Sat, 17 Jun 2017 16:38:03 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1497610119-45041-1-git-send-email-wei.w.wang@intel.com>
	<20170616172531-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170616172531-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, marcandre.lureau@gmail.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, stefanha@gmail.com, pbonzini@redhat.com, armbru@redhat.com, jan.scheurich@ericsson.com

On 06/16/2017 10:31 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 16, 2017 at 06:48:38PM +0800, Wei Wang wrote:
>> This patch enables the virtio-net tx queue size to be configurable
>> between 256 (the default queue size) and 1024 by the user when the
>> vhost-user backend is used.
>>
>> Currently, the maximum tx queue size for other backends is 512 due
>> to the following limitations:
>> - QEMU backend: the QEMU backend implementation in some cases may
>> send 1024+1 iovs to writev.
>> - Vhost_net backend: there are possibilities that the guest sends
>> a vring_desc of memory which corsses a MemoryRegion thereby
>> generating more than 1024 iovs in total after translattion from
>> guest-physical address in the backend.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   hw/net/virtio-net.c            | 46 ++++++++++++++++++++++++++++++++++--------
>>   include/hw/virtio/virtio-net.h |  1 +
>>   2 files changed, 39 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 7d091c9..e1a08fd 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -33,8 +33,11 @@
>>   
>>   /* previously fixed value */
>>   #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
>> +#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
>> +
>>   /* for now, only allow larger queues; with virtio-1, guest can downsize */
>>   #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
>> +#define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
>>   
>>   /*
>>    * Calculate the number of bytes up to and including the given 'field' of
>> @@ -1491,18 +1494,33 @@ static void virtio_net_tx_bh(void *opaque)
>>   static void virtio_net_add_queue(VirtIONet *n, int index)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +    NetClientState *nc = qemu_get_queue(n->nic);
>>   
>>       n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
>>                                              virtio_net_handle_rx);
>> +
>> +    /*
>> +     * Currently, backends other than vhost-user don't support 1024 queue
>> +     * size.
>> +     */
>> +    if (n->net_conf.tx_queue_size == VIRTQUEUE_MAX_SIZE &&
>> +        nc->peer->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
>> +        fprintf(stderr, "warning: %s: queue size %d not supported\n",
>> +                __func__, n->net_conf.tx_queue_size);
>> +        n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
>> +    }
>> +
> Also, I suspect we can get here with no peer, and above will crash.
> It seems ugly to do this on each virtio_net_add_queue.
> How about moving this to realize?

The code has been re-arranged to make sure nc->peer is ready before
it's used, but I agree that it looks better to move the above to realize().

Best,
Wei
