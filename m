Received: from eggs.gnu.org ([2001:4830:134:3::10]:60252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIlg-0006vG-Tc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIlc-0004ob-3H
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:53:32 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:33221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIlb-0004oN-Ub
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:53:28 -0400
Received: by mail-qk0-x234.google.com with SMTP id c131-v6so331839qkb.0
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 07:53:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3df8dfad-94b0-d57a-89c1-acc698c1d48b@amsat.org>
Date: Fri, 8 Jun 2018 11:53:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180601162749.27406-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v2 03/12] vhost-user: wrap some read/write
 with retry handling
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/virtio/vhost-user.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ca554d4ff1..cc9298792d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -869,7 +869,10 @@ static void slave_read(void *opaque)
>      iov.iov_base = &hdr;
>      iov.iov_len = VHOST_USER_HDR_SIZE;
>  
> -    size = recvmsg(u->slave_fd, &msgh, 0);
> +    do {
> +        size = recvmsg(u->slave_fd, &msgh, 0);
> +    } while (size < 0 && (errno == EINTR || errno == EAGAIN));
> +
>      if (size != VHOST_USER_HDR_SIZE) {
>          error_report("Failed to read from slave.");
>          goto err;
> @@ -898,7 +901,10 @@ static void slave_read(void *opaque)
>      }
>  
>      /* Read payload */
> -    size = read(u->slave_fd, &payload, hdr.size);
> +    do {
> +        size = read(u->slave_fd, &payload, hdr.size);
> +    } while (size < 0 && (errno == EINTR || errno == EAGAIN));
> +
>      if (size != hdr.size) {
>          error_report("Failed to read payload from slave.");
>          goto err;
> @@ -941,7 +947,10 @@ static void slave_read(void *opaque)
>          iovec[1].iov_base = &payload;
>          iovec[1].iov_len = hdr.size;
>  
> -        size = writev(u->slave_fd, iovec, ARRAY_SIZE(iovec));
> +        do {
> +            size = writev(u->slave_fd, iovec, ARRAY_SIZE(iovec));
> +        } while (size < 0 && (errno == EINTR || errno == EAGAIN));
> +
>          if (size != VHOST_USER_HDR_SIZE + hdr.size) {
>              error_report("Failed to send msg reply to slave.");
>              goto err;
> 
