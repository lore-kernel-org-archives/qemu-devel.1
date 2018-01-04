Received: from eggs.gnu.org ([2001:4830:134:3::10]:55718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eX8yM-0006fJ-F3
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eX8xr-0002yu-Td
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:06:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eX8xr-0002vy-CQ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:05:59 -0500
Date: Thu, 4 Jan 2018 19:05:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180104190309-mutt-send-email-mst@kernel.org>
References: <cover.1515041373.git.jbaron@akamai.com>
	<e185a03168d0ab68150d21770bf0d02c5ef537c2.1515041373.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e185a03168d0ab68150d21770bf0d02c5ef537c2.1515041373.git.jbaron@akamai.com>
Subject: Re: [Qemu-devel] [PATCH net-next v3 1/3] virtio_net: propagate
 linkspeed/duplex settings from the hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>
Cc: davem@davemloft.net, jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Thu, Jan 04, 2018 at 12:16:44AM -0500, Jason Baron wrote:
> The ability to set speed and duplex for virtio_net is useful in various
> scenarios as described here:
> 
> 16032be virtio_net: add ethtool support for set and get of settings
> 
> However, it would be nice to be able to set this from the hypervisor,
> such that virtio_net doesn't require custom guest ethtool commands.
> 
> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> the hypervisor to export a linkspeed and duplex setting. The user can
> subsequently overwrite it later if desired via: 'ethtool -s'.
> 
> Note that VIRTIO_NET_F_SPEED_DUPLEX is defined as bit 63, the intention
> is that device feature bits are to grow down from bit 63, since the
> transports are starting from bit 24 and growing up.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtio-dev@lists.oasis-open.org
> ---
>  drivers/net/virtio_net.c        | 19 ++++++++++++++++++-
>  include/uapi/linux/virtio_net.h | 13 +++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6fb7b65..0b2d314 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2146,6 +2146,22 @@ static void virtnet_config_changed_work(struct work_struct *work)
>  
>  	vi->status = v;
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX)) {

BTW we can avoid this read for when link goes down.
Not a big deal but still.

> +		u32 speed;
> +		u8 duplex;
> +
> +		speed = virtio_cread32(vi->vdev,
> +				       offsetof(struct virtio_net_config,
> +						speed));
> +		if (ethtool_validate_speed(speed))
> +			vi->speed = speed;
> +		duplex = virtio_cread8(vi->vdev,
> +				       offsetof(struct virtio_net_config,
> +						duplex));
> +		if (ethtool_validate_duplex(duplex))
> +			vi->duplex = duplex;
> +	}
> +
>  	if (vi->status & VIRTIO_NET_S_LINK_UP) {
>  		netif_carrier_on(vi->dev);
>  		netif_tx_wake_all_queues(vi->dev);

OK so this handles the case when VIRTIO_NET_F_STATUS is set,
but when it's clear we need to call this from virtnet_probe.

I propose moving this chunk to a function and calling from two places.


> @@ -2796,7 +2812,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
>  	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
> -	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
> +	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> +	VIRTIO_NET_F_SPEED_DUPLEX
>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index fc353b5..5de6ed3 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,8 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
>  #endif /* VIRTIO_NET_NO_LEGACY */
> @@ -76,6 +78,17 @@ struct virtio_net_config {
>  	__u16 max_virtqueue_pairs;
>  	/* Default maximum transmit unit advice */
>  	__u16 mtu;
> +	/*
> +	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
> +	 * Any other value stands for unknown.
> +	 */
> +	__u32 speed;
> +	/*
> +	 * 0x00 - half duplex
> +	 * 0x01 - full duplex
> +	 * Any other value stands for unknown.
> +	 */
> +	__u8 duplex;
>  } __attribute__((packed));
>  
>  /*
> -- 
> 2.6.1
