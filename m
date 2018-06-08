Received: from eggs.gnu.org ([2001:4830:134:3::10]:33307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIpB-0000L8-ID
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIp6-0006d0-NI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:57:09 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIp6-0006ci-Ix
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:57:04 -0400
Received: by mail-qt0-x244.google.com with SMTP id l33-v6so13683883qta.11
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 07:57:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e0a90bd4-93b0-fd0b-a16d-034093589f6b@amsat.org>
Date: Fri, 8 Jun 2018 11:57:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180601162749.27406-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v2 05/12] vhost-user: split vhost_user_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 06/01/2018 01:27 PM, Marc-André Lureau wrote:
> Split vhost_user_read(), so only header can be read with
> vhost_user_read_header().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cc9298792d..a87db01e55 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -196,7 +196,7 @@ static bool ioeventfd_enabled(void)
>      return kvm_enabled() && kvm_eventfds_enabled();
>  }
>  
> -static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
> +static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)

Can this be simply:

static int vhost_user_read_header(CharBackend *chr, VhostUserMsg *msg) ?

>  {
>      struct vhost_user *u = dev->opaque;
>      CharBackend *chr = u->chr;
> @@ -207,7 +207,7 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>      if (r != size) {
>          error_report("Failed to read msg header. Read %d instead of %d."
>                       " Original request %d.", r, size, msg->hdr.request);
> -        goto fail;
> +        return -1;
>      }
>  
>      /* validate received flags */
> @@ -215,7 +215,21 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>          error_report("Failed to read msg header."
>                  " Flags 0x%x instead of 0x%x.", msg->hdr.flags,
>                  VHOST_USER_REPLY_MASK | VHOST_USER_VERSION);
> -        goto fail;
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    CharBackend *chr = u->chr;
> +    uint8_t *p = (uint8_t *) msg;
> +    int r, size;
> +
> +    if (vhost_user_read_header(dev, msg) < 0) {
> +        return -1;
>      }
>  
>      /* validate message size is sane */
> @@ -223,7 +237,7 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>          error_report("Failed to read msg header."
>                  " Size %d exceeds the maximum %zu.", msg->hdr.size,
>                  VHOST_USER_PAYLOAD_SIZE);
> -        goto fail;
> +        return -1;
>      }
>  
>      if (msg->hdr.size) {
> @@ -233,14 +247,11 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>          if (r != size) {
>              error_report("Failed to read msg payload."
>                           " Read %d instead of %d.", r, msg->hdr.size);
> -            goto fail;
> +            return -1;
>          }
>      }
>  
>      return 0;
> -
> -fail:
> -    return -1;
>  }
>  
>  static int process_message_reply(struct vhost_dev *dev,
> 
