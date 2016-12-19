Received: from eggs.gnu.org ([2001:4830:134:3::10]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cItIT-0006Ge-Dm
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cItIQ-0005ms-Ai
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:27:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:2344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cItIP-0005lX-PL
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:27:46 -0500
Message-ID: <58579A1A.60107@intel.com>
Date: Mon, 19 Dec 2016 16:28:10 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
	<1482127152-84732-37-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-37-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RESEND Patch v1 36/37] vhost-user/msg: handling
 VHOST_USER_SET_FEATURES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On 12/19/2016 01:59 PM, Wei Wang wrote:
> If the featuer bits sent by the slave are not equal to the ones that
> were sent by the master, perform a reset of the master device.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   hw/net/vhost_net.c       |  2 ++
>   hw/virtio/vhost-user.c   | 20 ++++++++++++++++++++
>   hw/virtio/virtio-pci.c   | 20 ++++++++++++++++++++
>   hw/virtio/virtio-pci.h   |  2 ++
>   include/net/vhost-user.h | 14 ++++++++++++++
>   net/vhost-user.c         | 14 +++++---------
>   6 files changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 8256018..e8a2d4f 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
>   
>   /* virtio-net-pci */
>   
> +void master_reset_virtio_net(VirtIODevice *vdev)
> +{
> +    VirtIONet *net = VIRTIO_NET(vdev);
> +    VirtIONetPCI *net_pci = container_of(net, VirtIONetPCI, vdev);
> +    VirtIOPCIProxy *proxy = &net_pci->parent_obj;
> +    DeviceState *qdev = DEVICE(proxy);
> +    DeviceState *qdev_new;
> +    Error *err = NULL;
> +
> +    virtio_pci_reset(qdev);
> +    qdev_unplug(qdev, &err);
> +    qdev->realized = false;
> +    qdev_new = qdev_device_add(qdev->opts, &err);
> +    if (!qdev_new) {
> +        qemu_opts_del(qdev->opts);
> +    }
> +    object_unref(OBJECT(qdev));
> +}
> +

I still have a problem with this patch. Looks like the virtio reset here 
only clears the registers and queue related things. Do we have a power 
reset of virtio, which has the same effect as re-plugging into the 
virtio device (the driver probe() are re-invoked and feature bits are 
re-negotiated). Thanks.

Best,
Wei
