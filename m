Received: from eggs.gnu.org ([209.51.188.92]:56204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPpL-0008IX-GV
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPpJ-0008EX-SM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPpG-00084J-GV
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so1700242qkk.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-13-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-13-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:13:54 +0100
Message-ID: <CAMxuvaxm_uHMm3ccWSwFpk7T3ZDqoOP0FE+Eu-M_NWnXAh=QYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/25] xen: Let buffer_append() return
 the size consumed
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

Hi

On Wed, Feb 20, 2019 at 2:06 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The buffer.size and buffer.consumed fields are only updated within the
> buffer_append() body. We can simply let buffer_append() return the
> difference (the buffer consumed).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This is weird, why not introduce a buffer_size() function instead?

> ---
>  hw/char/xen_console.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index 083b2c8e2a..1a30014a11 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -48,7 +48,7 @@ struct XenConsole {
>      int               backlog;
>  };
>
> -static void buffer_append(struct XenConsole *con)
> +static ssize_t buffer_append(struct XenConsole *con)
>  {
>      struct buffer *buffer =3D &con->buffer;
>      XENCONS_RING_IDX cons, prod, size;
> @@ -59,8 +59,9 @@ static void buffer_append(struct XenConsole *con)
>      xen_mb();
>
>      size =3D prod - cons;
> -    if ((size =3D=3D 0) || (size > sizeof(intf->out)))
> -        return;
> +    if ((size =3D=3D 0) || (size > sizeof(intf->out))) {
> +        goto out;
> +    }
>
>      if ((buffer->capacity - buffer->size) < size) {
>          buffer->capacity +=3D (size + 1024);
> @@ -89,6 +90,9 @@ static void buffer_append(struct XenConsole *con)
>          if (buffer->consumed > buffer->max_capacity - over)
>              buffer->consumed =3D buffer->max_capacity - over;
>      }
> +
> + out:
> +    return buffer->size - buffer->consumed;
>  }
>
>  static void buffer_advance(struct buffer *buffer, size_t len)
> @@ -281,8 +285,7 @@ static void con_event(struct XenLegacyDevice *xendev)
>      struct XenConsole *con =3D container_of(xendev, struct XenConsole, x=
endev);
>      ssize_t size;
>
> -    buffer_append(con);
> -    size =3D con->buffer.size - con->buffer.consumed;
> +    size =3D buffer_append(con);
>      if (size) {
>          xencons_send(con, size);
>      }
> --
> 2.20.1
>
