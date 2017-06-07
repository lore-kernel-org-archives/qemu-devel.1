Received: from eggs.gnu.org ([2001:4830:134:3::10]:43294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIgCT-0007CV-Rt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIgCS-0008Nc-QJ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:01:01 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIgCS-0008ME-7l
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:01:00 -0400
Received: by mail-lf0-x243.google.com with SMTP id x81so1583885lfb.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 12:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20170602081519.15648-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170602081519.15648-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 07 Jun 2017 19:00:46 +0000
Message-ID: <CAJ+F1C+fqVd2PDkaPCPS9ZsikZ841hT1wc7tNOj8=JnZOHFchg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user-bridge: fix iov_restore_front()
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: dgilbert@redhat.com

Hi, Michael, could you pick this patch?

thanks

On Fri, Jun 2, 2017 at 12:26 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

>   CC      tests/vhost-user-bridge.o
> /home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warning:
> variables 'front' and 'iov' used in loop condition not modified in loop
> body [-Wfor-loop-analysis]
>     for (cur =3D front; front !=3D iov; cur++) {
>                       ^~~~~    ~~~
> 1 warning generated.
>
> Fix the loop, document the function, and fix some related assert().
>
> In practice, the loop bug was harmless because the front sg buffer is
> enough to discard/restore the header size.
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vhost-user-bridge.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 8618c20d53..1e5b5ca3da 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -220,12 +220,18 @@ vubr_handle_tx(VuDev *dev, int qidx)
>      free(elem);
>  }
>
> +
> +/* this function reverse the effect of iov_discard_front() it must be
> + * called with 'front' being the original struct iovec and 'bytes'
> + * being the number of bytes you shaved off
> + */
>  static void
>  iov_restore_front(struct iovec *front, struct iovec *iov, size_t bytes)
>  {
>      struct iovec *cur;
>
> -    for (cur =3D front; front !=3D iov; cur++) {
> +    for (cur =3D front; cur !=3D iov; cur++) {
> +        assert(bytes >=3D cur->iov_len);
>          bytes -=3D cur->iov_len;
>      }
>
> @@ -302,7 +308,8 @@ vubr_backend_recv_cb(int sock, void *ctx)
>              }
>              iov_from_buf(sg, elem->in_num, 0, &hdr, sizeof hdr);
>              total +=3D hdrlen;
> -            assert(iov_discard_front(&sg, &num, hdrlen) =3D=3D hdrlen);
> +            ret =3D iov_discard_front(&sg, &num, hdrlen);
> +            assert(ret =3D=3D hdrlen);
>          }
>
>          struct msghdr msg =3D {
> --
> 2.13.0.91.g00982b8dd
>
>
> --
Marc-Andr=C3=A9 Lureau
