Received: from eggs.gnu.org ([2001:4830:134:3::10]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gQF5u-0004z0-TP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gQF5r-0000XE-Qc
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:18:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gQF5r-0000Ti-Cv
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:18:15 -0500
References: <49e9640f3fc040a9c9ab40f93935a6572b34bdff.1541085026.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47b9174d-6a37-29df-b8a0-38143759015c@redhat.com>
Date: Fri, 23 Nov 2018 18:18:07 +0100
MIME-Version: 1.0
In-Reply-To: <49e9640f3fc040a9c9ab40f93935a6572b34bdff.1541085026.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtserialport/virtconsole: fix messy
 opening/closing port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/11/18 16:11, Artem Pisarenko wrote:
> This fixes wrong interfacing between virtio serial port and bus
> models, and corresponding chardev backends, caused extra and incorrect
> activity during guest boot process (when virtserialport device used).
>=20
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
>=20
> Notes:
>     Although this doesn't trigger any issue/bug (known to me), this may=
 prevent them in future.
>     Also this patch optimizes emulation performance by avoiding extra a=
ctivity and fixes a case, when serial port wasn't closed if backend close=
d while being disabled (even worse - serial port will open again!).

Marc-Andr=C3=A9, can you review this?

Thanks,

Paolo

>  hw/char/virtio-console.c          | 24 ++++++++++++++++++++----
>  hw/char/virtio-serial-bus.c       |  8 +++++++-
>  include/hw/virtio/virtio-serial.h |  8 ++++++++
>  3 files changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 2cbe1d4..634e9bf 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -25,6 +25,7 @@
>  typedef struct VirtConsole {
>      VirtIOSerialPort parent_obj;
> =20
> +    bool backend_active;
>      CharBackend chr;
>      guint watch;
>  } VirtConsole;
> @@ -149,6 +150,11 @@ static void chr_event(void *opaque, int event)
>      VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(vcon);
> =20
>      trace_virtio_console_chr_event(port->id, event);
> +
> +    if (!vcon->backend_active) {
> +        return;
> +    }
> +
>      switch (event) {
>      case CHR_EVENT_OPENED:
>          virtio_serial_open(port);
> @@ -187,17 +193,24 @@ static int chr_be_change(void *opaque)
>      return 0;
>  }
> =20
> +static bool virtconsole_is_backend_enabled(VirtIOSerialPort *port)
> +{
> +    VirtConsole *vcon =3D VIRTIO_CONSOLE(port);
> +
> +    return vcon->backend_active;
> +}
> +
>  static void virtconsole_enable_backend(VirtIOSerialPort *port, bool en=
able)
>  {
>      VirtConsole *vcon =3D VIRTIO_CONSOLE(port);
> =20
> -    if (!qemu_chr_fe_backend_connected(&vcon->chr)) {
> -        return;
> -    }
> -
>      if (enable) {
>          VirtIOSerialPortClass *k =3D VIRTIO_SERIAL_PORT_GET_CLASS(port=
);
> =20
> +        if (!k->is_console && virtio_serial_is_opened(port)
> +            && !qemu_chr_fe_backend_open(&vcon->chr)) {
> +            virtio_serial_close(port);
> +        }
>          qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
>                                   k->is_console ? NULL : chr_event,
>                                   chr_be_change, vcon, NULL, false);
> @@ -205,6 +218,7 @@ static void virtconsole_enable_backend(VirtIOSerial=
Port *port, bool enable)
>          qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
>                                   NULL, NULL, NULL, false);
>      }
> +    vcon->backend_active =3D enable;
>  }
> =20
>  static void virtconsole_realize(DeviceState *dev, Error **errp)
> @@ -220,6 +234,7 @@ static void virtconsole_realize(DeviceState *dev, E=
rror **errp)
>      }
> =20
>      if (qemu_chr_fe_backend_connected(&vcon->chr)) {
> +        vcon->backend_active =3D true;
>          /*
>           * For consoles we don't block guest data transfer just
>           * because nothing is connected - we'll just let it go
> @@ -278,6 +293,7 @@ static void virtserialport_class_init(ObjectClass *=
klass, void *data)
>      k->unrealize =3D virtconsole_unrealize;
>      k->have_data =3D flush_buf;
>      k->set_guest_connected =3D set_guest_connected;
> +    k->is_backend_enabled =3D virtconsole_is_backend_enabled;
>      k->enable_backend =3D virtconsole_enable_backend;
>      k->guest_writable =3D guest_writable;
>      dc->props =3D virtserialport_properties;
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 04e3ebe..d23d99d 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -258,6 +258,11 @@ static size_t send_control_event(VirtIOSerial *vse=
r, uint32_t port_id,
>  }
> =20
>  /* Functions for use inside qemu to open and read from/write to ports =
*/
> +bool virtio_serial_is_opened(VirtIOSerialPort *port)
> +{
> +    return port->host_connected;
> +}
> +
>  int virtio_serial_open(VirtIOSerialPort *port)
>  {
>      /* Don't allow opening an already-open port */
> @@ -643,7 +648,8 @@ static void set_status(VirtIODevice *vdev, uint8_t =
status)
> =20
>      QTAILQ_FOREACH(port, &vser->ports, next) {
>          VirtIOSerialPortClass *vsc =3D VIRTIO_SERIAL_PORT_GET_CLASS(po=
rt);
> -        if (vsc->enable_backend) {
> +        if (vsc->is_backend_enabled && vsc->enable_backend
> +            && (vsc->is_backend_enabled(port) !=3D vdev->vm_running)) =
{
>              vsc->enable_backend(port, vdev->vm_running);
>          }
>      }
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virt=
io-serial.h
> index 12657a9..4b72562 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -58,6 +58,8 @@ typedef struct VirtIOSerialPortClass {
>          /* Guest opened/closed device. */
>      void (*set_guest_connected)(VirtIOSerialPort *port, int guest_conn=
ected);
> =20
> +    /* Is backend currently enabled for virtio serial port */
> +    bool (*is_backend_enabled)(VirtIOSerialPort *port);
>      /* Enable/disable backend for virtio serial port */
>      void (*enable_backend)(VirtIOSerialPort *port, bool enable);
> =20
> @@ -194,6 +196,12 @@ struct VirtIOSerial {
>  /* Interface to the virtio-serial bus */
> =20
>  /*
> + * Checks status of connection to the port
> + *   Returns true if connected, false otherwise.
> + */
> +bool virtio_serial_is_opened(VirtIOSerialPort *port);
> +
> +/*
>   * Open a connection to the port
>   *   Returns 0 on success (always).
>   */
>=20
