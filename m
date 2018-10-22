Received: from eggs.gnu.org ([2001:4830:134:3::10]:42112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gEPnP-00023B-HT
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 22:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gEPnJ-0004QM-5J
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 22:18:19 -0400
Received: from synology.com ([59.124.61.242]:33404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuchenlin@synology.com>)
	id 1gEPnI-0004PK-KM
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 22:18:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Oct 2018 10:17:59 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20181012090752.31891-1-yuchenlin@synology.com>
References: <20181012090752.31891-1-yuchenlin@synology.com>
Message-ID: <d8051b2fc349d58dcd98cd383ae6bf32@synology.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-scsi: prevent using uninitialized vqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, Forrest Liu <forrestl@synology.com>

Ping?

On 2018-10-12 17:07, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> There are 3 virtqueues (ctrl, event and cmd) for virtio scsi device,
> but seabios will only set the physical address for the 3rd one (cmd).
> Then in vhost_virtqueue_start(), virtio_queue_get_desc_addr()
> will be 0 for ctrl and event vq.
> 
> In this case, ctrl and event vq are not initialized.
> vhost_verify_ring_mappings may use uninitialized vhost_virtqueue
> such that vhost_verify_ring_part_mapping returns ENOMEM.
> 
> When encountered this problem, we got the following logs:
> 
>     qemu-system-x86_64: Unable to map available ring for ring 0
>     qemu-system-x86_64: Verify ring failure on region 0
> 
> Signed-off-by: Forrest Liu <forrestl@synology.com>
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
>  hw/scsi/vhost-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index becf550085..7f21b4f9d6 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -183,7 +183,7 @@ static void vhost_scsi_realize(DeviceState *dev,
> Error **errp)
>      }
> 
>      vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> -    vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
> +    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
>      vsc->dev.vq_index = 0;
>      vsc->dev.backend_features = 0;
