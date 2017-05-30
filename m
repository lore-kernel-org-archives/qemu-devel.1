Received: from eggs.gnu.org ([2001:4830:134:3::10]:42359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFfRO-0001EE-94
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFfRN-0000d4-3B
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:35:58 -0400
Date: Tue, 30 May 2017 19:35:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170530113552.GD27787@lemon.lan>
References: <20170530085943.18141-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530085943.18141-1-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-serial-bus: Unset hotplug handler
 when unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, mst@redhat.com

On Tue, 05/30 10:59, Ladi Prosek wrote:
> Virtio serial device controls the lifetime of virtio-serial-bus and
> virtio-serial-bus links back to the device via its hotplug-handler
> property. This extra ref-count prevents the device from getting
> finalized, leaving the VirtIODevice memory listener registered and
> leading to use-after-free later on.
> 
> This patch addresses the same issue as Fam Zheng's
> "virtio-scsi: Unset hotplug handler when unrealize"
> only for a different virtio device.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/char/virtio-serial-bus.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index d797a67..aa9c11a 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1121,6 +1121,9 @@ static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
>          timer_free(vser->post_load->timer);
>          g_free(vser->post_load);
>      }
> +
> +    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, errp);
> +
>      virtio_cleanup(vdev);
>  }
>  
> -- 
> 2.9.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
