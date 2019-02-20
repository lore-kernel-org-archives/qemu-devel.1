Received: from eggs.gnu.org ([209.51.188.92]:54730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPiz-0005lN-UM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPix-0002vs-FE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:07:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPio-0002oj-Dv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:07:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so1711513qkf.3
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-12-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-12-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:07:13 +0100
Message-ID: <CAMxuvaxORh6Kc-rJ605fJidj1yd+e23VeeA_+O=FU1dH7Zh32w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/25] xen: Let xencons_send() take a
 'size' argument
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

On Wed, Feb 20, 2019 at 2:05 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The single caller of xencons_send(), con_event() already use the
> difference 'con->buffer.size - con->buffer.consumed'.
> Deduplicate by passing the difference as an argument.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/char/xen_console.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index 91f34ef06c..083b2c8e2a 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -144,11 +144,10 @@ static void xencons_receive(void *opaque, const uin=
t8_t *buf, int len)
>      xen_pv_send_notify(&con->xendev);
>  }
>
> -static void xencons_send(struct XenConsole *con)
> +static void xencons_send(struct XenConsole *con, ssize_t size)
>  {
> -    ssize_t len, size;
> +    ssize_t len;
>
> -    size =3D con->buffer.size - con->buffer.consumed;
>      if (qemu_chr_fe_backend_connected(&con->chr)) {
>          len =3D qemu_chr_fe_write(&con->chr,
>                                  con->buffer.data + con->buffer.consumed,
> @@ -280,10 +279,13 @@ static void con_disconnect(struct XenLegacyDevice *=
xendev)
>  static void con_event(struct XenLegacyDevice *xendev)
>  {
>      struct XenConsole *con =3D container_of(xendev, struct XenConsole, x=
endev);
> +    ssize_t size;
>
>      buffer_append(con);
> -    if (con->buffer.size - con->buffer.consumed)
> -        xencons_send(con);
> +    size =3D con->buffer.size - con->buffer.consumed;
> +    if (size) {
> +        xencons_send(con, size);
> +    }
>  }
>
>  /* -------------------------------------------------------------------- =
*/
> --
> 2.20.1
>
