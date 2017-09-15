Received: from eggs.gnu.org ([2001:4830:134:3::10]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsu7U-00069O-8l
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsu7Q-0003XT-Tb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:09:36 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsu7Q-0003Wf-Mg
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:09:32 -0400
Received: by mail-wm0-f48.google.com with SMTP id v142so9910182wmv.5
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:09:32 -0700 (PDT)
References: <20170707142138.411-1-pbutsykin@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55a8a300-2247-dadb-40b3-0c1d4e651e08@redhat.com>
Date: Fri, 15 Sep 2017 19:09:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170707142138.411-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-serial: add enable_backend callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, dgilbert@redhat.com, amit@kernel.org, den@openvz.org

On 07/07/2017 16:21, Pavel Butsykin wrote:
> We should guarantee that RAM will not be modified while VM has a stopped
> state, otherwise it can lead to negative consequences during post-copy
> migration. In RUN_STATE_FINISH_MIGRATE step, it's expected that RAM on
> source side will not be modified as this could lead to non-consistent vm state
> on the destination side. Also RAM access during postcopy-ram migration with
> enabled release-ram capability can lead to sad consequences.
> 
> Let's add enable_backend() callback to avoid undesirable virtioqueue changes
> in the guest memory.
> 
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>

To understand the patch better this doesn't fix _all_ stopped states,
only migration, right?  That said it's a valid bugfix even independent
of the effects for stopped runstate.

Thanks,

Paolo

> ---
>  hw/char/virtio-console.c          | 21 +++++++++++++++++++++
>  hw/char/virtio-serial-bus.c       |  7 +++++++
>  include/hw/virtio/virtio-serial.h |  3 +++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 0cb1668c8a..b55905892e 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -163,6 +163,26 @@ static void chr_event(void *opaque, int event)
>      }
>  }
>  
> +static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
> +{
> +    VirtConsole *vcon = VIRTIO_CONSOLE(port);
> +
> +    if (!qemu_chr_fe_get_driver(&vcon->chr)) {
> +        return;
> +    }
> +
> +    if (enable) {
> +        VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
> +
> +        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
> +                                 k->is_console ? NULL : chr_event,
> +                                 vcon, NULL, false);
> +    } else {
> +        qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL,
> +                                 NULL, NULL, NULL, false);
> +    }
> +}
> +
>  static void virtconsole_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
> @@ -233,6 +253,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
>      k->unrealize = virtconsole_unrealize;
>      k->have_data = flush_buf;
>      k->set_guest_connected = set_guest_connected;
> +    k->enable_backend = virtconsole_enable_backend;
>      k->guest_writable = guest_writable;
>      dc->props = virtserialport_properties;
>  }
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index f5bc173844..f0f18c8e7c 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -637,6 +637,13 @@ static void set_status(VirtIODevice *vdev, uint8_t status)
>      if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>          guest_reset(vser);
>      }
> +
> +    QTAILQ_FOREACH(port, &vser->ports, next) {
> +        VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
> +        if (vsc->enable_backend) {
> +            vsc->enable_backend(port, vdev->vm_running);
> +        }
> +    }
>  }
>  
>  static void vser_reset(VirtIODevice *vdev)
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
> index b19c44727f..12657a9f39 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -58,6 +58,9 @@ typedef struct VirtIOSerialPortClass {
>          /* Guest opened/closed device. */
>      void (*set_guest_connected)(VirtIOSerialPort *port, int guest_connected);
>  
> +    /* Enable/disable backend for virtio serial port */
> +    void (*enable_backend)(VirtIOSerialPort *port, bool enable);
> +
>          /* Guest is now ready to accept data (virtqueues set up). */
>      void (*guest_ready)(VirtIOSerialPort *port);
>  
> 
