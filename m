Received: from eggs.gnu.org ([209.51.188.92]:58054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPwu-0006me-Hn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPwt-0007zH-Bs
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:22:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPwr-0007t3-Dv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:21:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so26677874qta.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-15-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-15-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:21:32 +0100
Message-ID: <CAMxuvay56AwY0Mw9RfjNU4eJn+zJkvSKDKPpx+Qkx2tgp6r2tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/25] virtio-serial: Let
 VirtIOSerialPortClass::have_data() use size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 2:06 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Both callers in hw/char/virtio-serial-bus.c provide unsigned values,
> even the trace event display an unsigned value.
> Convert the have_data() handler to take an unsigned value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> It is funny/scary that there are big comments about how to treat
> errors to set the return value, then the return value is simply
> ignored by the caller.

have_data() return value? yes, the code may have change and the
comment doesn't seem to reflect accurately what's going on.

> ---
>  hw/char/virtio-console.c          | 2 +-
>  include/hw/virtio/virtio-serial.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 2cbe1d4ed5..19639dca3b 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -45,7 +45,7 @@ static gboolean chr_write_unblocked(GIOChannel *chan, G=
IOCondition cond,
>
>  /* Callback function that's called when the guest sends us data */
>  static ssize_t flush_buf(VirtIOSerialPort *port,
> -                         const uint8_t *buf, ssize_t len)
> +                         const uint8_t *buf, size_t len)
>  {
>      VirtConsole *vcon =3D VIRTIO_CONSOLE(port);
>      ssize_t ret;
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio=
-serial.h
> index 12657a9f39..f1a5ccf4f7 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -81,7 +81,7 @@ typedef struct VirtIOSerialPortClass {
>       * 'len'.  In this case, throttling will be enabled for this port.
>       */
>      ssize_t (*have_data)(VirtIOSerialPort *port, const uint8_t *buf,
> -                         ssize_t len);
> +                         size_t len);
>  } VirtIOSerialPortClass;
>
>  /*
> --
> 2.20.1
>
