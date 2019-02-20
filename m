Received: from eggs.gnu.org ([209.51.188.92]:54481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPhh-00054E-LY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPhg-0001Us-MH
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:06:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPhg-0001U7-Ga
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:06:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so26653649qtp.8
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-10-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-10-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:06:04 +0100
Message-ID: <CAMxuvawxJf3udoJVGyQk5SkT1GBAHjpH4Bjq6=h7hMw-3zT8xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/25] vhost-user: Express sizeof with
 size_t
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
> VHOST_USER_HDR_SIZE uses offsetof(), thus is an expression of type
> size_t. Update the format string accordingly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/virtio/vhost-user.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 564a31d12c..2eb7143d3d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -215,11 +215,12 @@ static int vhost_user_read(struct vhost_dev *dev, V=
hostUserMsg *msg)
>      struct vhost_user *u =3D dev->opaque;
>      CharBackend *chr =3D u->user->chr;
>      uint8_t *p =3D (uint8_t *) msg;
> -    int r, size =3D VHOST_USER_HDR_SIZE;
> +    int r;
> +    size_t size =3D VHOST_USER_HDR_SIZE;
>
>      r =3D qemu_chr_fe_read_all(chr, p, size);
>      if (r !=3D size) {
> -        error_report("Failed to read msg header. Read %d instead of %d."
> +        error_report("Failed to read msg header. Read %d instead of %zu.=
"
>                       " Original request %d.", r, size, msg->hdr.request)=
;
>          goto fail;
>      }
> @@ -235,7 +236,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vho=
stUserMsg *msg)
>      /* validate message size is sane */
>      if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
>          error_report("Failed to read msg header."
> -                " Size %d exceeds the maximum %zu.", msg->hdr.size,
> +                " Size %u exceeds the maximum %zu.", msg->hdr.size,
>                  VHOST_USER_PAYLOAD_SIZE);
>          goto fail;
>      }
> @@ -246,7 +247,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vho=
stUserMsg *msg)
>          r =3D qemu_chr_fe_read_all(chr, p, size);
>          if (r !=3D size) {
>              error_report("Failed to read msg payload."
> -                         " Read %d instead of %d.", r, msg->hdr.size);
> +                         " Read %d instead of %u.", r, msg->hdr.size);
>              goto fail;
>          }
>      }
> @@ -300,7 +301,8 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
>  {
>      struct vhost_user *u =3D dev->opaque;
>      CharBackend *chr =3D u->user->chr;
> -    int ret, size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
> +    int ret;
> +    size_t size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
>
>      /*
>       * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
> @@ -320,7 +322,7 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
>      ret =3D qemu_chr_fe_write_all(chr, (const uint8_t *) msg, size);
>      if (ret !=3D size) {
>          error_report("Failed to write msg."
> -                     " Wrote %d instead of %d.", ret, size);
> +                     " Wrote %d instead of %zu.", ret, size);
>          return -1;
>      }
>
> --
> 2.20.1
>
