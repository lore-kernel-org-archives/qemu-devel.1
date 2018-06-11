Received: from eggs.gnu.org ([2001:4830:134:3::10]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSQa2-0000C2-Gq
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSQZz-0001Ue-SB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:26:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSQZz-0001UN-LX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:26:07 -0400
Date: Mon, 11 Jun 2018 20:26:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611202207-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, qemu-devel@nongnu.org

On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote:
> This feature bit can be used by hypervisor to indicate virtio_net device to
> act as a standby for another device with the same MAC address.
> 
> I tested this with a small change to the patch to mark the STANDBY feature 'true'
> by default as i am using libvirt to start the VMs.
> Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
> XML file?
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

So I do not think we can commit to this interface: we
really need to control visibility of the primary device.

However just for testing purposes, we could add a non-stable
interface "x-standby" with the understanding that as any
x- prefix it's unstable and will be changed down the road,
likely in the next release.


> ---
>  hw/net/virtio-net.c                         | 2 ++
>  include/standard-headers/linux/virtio_net.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 90502fca7c..38b3140670 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>                       true),
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> +                      false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index e9f255ea3f..01ec09684c 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -57,6 +57,9 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
> +                                         * with the same MAC.
> +                                         */
>  #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>  
>  #ifndef VIRTIO_NET_NO_LEGACY
> -- 
> 2.14.3
