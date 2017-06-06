Received: from eggs.gnu.org ([2001:4830:134:3::10]:35119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dI5CH-0007pz-UH
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dI5CD-0007oV-OX
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:30:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:16688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dI5CD-0007lt-By
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:30:17 -0400
Message-ID: <59362247.70608@intel.com>
Date: Tue, 06 Jun 2017 11:32:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170605182514-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: enable configurable tx
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
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, eblake@redhat.com, armbru@redhat.com

On 06/05/2017 11:38 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 05, 2017 at 04:57:29PM +0800, Wei Wang wrote:
>   /*
>    * Calculate the number of bytes up to and including the given 'field' of
> @@ -57,6 +62,8 @@ static VirtIOFeature feature_sizes[] = {
>        .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
>       {.flags = 1 << VIRTIO_NET_F_MTU,
>        .end = endof(struct virtio_net_config, mtu)},
> +    {.flags = 1 << VIRTIO_F_MAX_CHAIN_SIZE,
> +     .end = endof(struct virtio_net_config, max_chain_size)},
>       {}
>   };
>
> Using a generic VIRTIO_F_MAX_CHAIN_SIZE flag, so this should go into the
> generic virtio section, not virtio_net_config.
>    
Do you mean VIRTIO_PCI_xx under virtio_pci.h?

The reason that the config field wasn't added there is because I didn't find
space to put into the new 16-bit field into the existing layout. The 
last one
is "#define VIRTIO_MSI_QUEUE_VECTOR 22".  The per-driver configuration
space directly follows that last register by
"#define VIRTIO_PCI_CONFIG_OFF(msix_enabled) ((msix_enabled) ? 24:20)"

Changing the MACRO to something like
VIRTIO_PCI_CONFIG_OFF(max_chain_size_enabled) would be difficult.

Do you see a good way to add the new field here?


>> @@ -84,6 +91,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>>       virtio_stw_p(vdev, &netcfg.status, n->status);
>>       virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
>>       virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
>> +    virtio_stw_p(vdev, &netcfg.max_chain_size, VIRTIO_NET_MAX_CHAIN_SIZE);
>>       memcpy(netcfg.mac, n->mac, ETH_ALEN);
>>       memcpy(config, &netcfg, n->config_size);
>>   }
>> @@ -635,9 +643,33 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
>>       return virtio_net_guest_offloads_by_features(vdev->guest_features);
>>   }
>>   
>> +static bool is_tx(int queue_index)
>> +{
>> +    return queue_index % 2 == 1;
>> +}
>> +
>> +static void virtio_net_reconfig_tx_queue_size(VirtIONet *n)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +    int i, num_queues = virtio_get_num_queues(vdev);
>> +
>> +    /* Return when the queue size is already less than the 1024 */
>> +    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE) {
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < num_queues; i++) {
>> +        if (is_tx(i)) {
>> +            n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE / 2;
>> +            virtio_queue_set_num(vdev, i, n->net_conf.tx_queue_size);
>> +        }
>> +    }
>> +}
>> +
>>   static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>>   {
>>       VirtIONet *n = VIRTIO_NET(vdev);
>> +    NetClientState *nc = qemu_get_queue(n->nic);
>>       int i;
>>   
>>       virtio_net_set_multiqueue(n,
>> @@ -649,6 +681,16 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>>                                  virtio_has_feature(features,
>>                                                     VIRTIO_F_VERSION_1));
>>   
>> +    /*
>> +     * When the traditional QEMU backend is used, using 1024 tx queue size
>> +     * requires the driver to support the VIRTIO_F_MAX_CHAIN_SIZE feature. If
>> +     * the feature is not supported, reconfigure the tx queue size to 512.
>> +     */
>> +    if (!get_vhost_net(nc->peer) &&
>> +        !virtio_has_feature(features, VIRTIO_F_MAX_CHAIN_SIZE)) {
>> +        virtio_net_reconfig_tx_queue_size(n);
>> +    }
>> +
>>       if (n->has_vnet_hdr) {
>>           n->curr_guest_offloads =
>>               virtio_net_guest_offloads_by_features(features);
>> @@ -1297,8 +1339,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>>   
>>           out_num = elem->out_num;
>>           out_sg = elem->out_sg;
>> -        if (out_num < 1) {
>> -            virtio_error(vdev, "virtio-net header not in first element");
>> +        if (out_num < 1 || out_num > VIRTIO_NET_MAX_CHAIN_SIZE) {
>> +            virtio_error(vdev, "no packet or too large vring desc chain");
>>               virtqueue_detach_element(q->tx_vq, elem, 0);
>>               g_free(elem);
>>               return -EINVAL;
> what about rx vq? we need to limit that as well, do we not?
I think the rx vq doesn't need the limit, because there is no off-by-one 
issue
like the tx side writev().
>   
> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
> index b777069..b70cbfe 100644
> --- a/include/standard-headers/linux/virtio_config.h
> +++ b/include/standard-headers/linux/virtio_config.h
> @@ -60,6 +60,9 @@
>   #define VIRTIO_F_ANY_LAYOUT		27
>   #endif /* VIRTIO_CONFIG_NO_LEGACY */
>   
> +/* Guest chains vring descriptors within a limit */
> +#define VIRTIO_F_MAX_CHAIN_SIZE		31
> +
> Pls use a flag in the high 32 bit.

I think this should be considered as a transport feature. How about changing
VIRTIO_TRANSPORT_F_END to 35 (was 34), and use 34 for
VIRTIO_F_MAX_CHAIN_SIZE?

Best,
Wei
