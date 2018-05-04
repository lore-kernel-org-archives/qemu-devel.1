Received: from eggs.gnu.org ([2001:4830:134:3::10]:50806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fEXRi-0001XD-Di
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fEXRh-00064D-G1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:56:10 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fEXRh-00062Q-9B
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:56:09 -0400
Received: by mail-wr0-x241.google.com with SMTP id y15-v6so8708229wrg.11
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 02:56:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504095346.14159-1-dgilbert@redhat.com>
References: <20180504095346.14159-1-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 4 May 2018 11:56:07 +0200
Message-ID: <CAJ+F1CLtH0NyYHM8dyXRGU8CGNmhEmtzwGSmYhTZzMZvhyBJAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Send messages with no data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, May 4, 2018 at 11:53 AM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The response to a VHOST_USER_POSTCOPY_ADVISE contains a fd but doesn't
> actually contain any data.   FIx vu_message_write so that it doesn't
> do a 0-byte write() call, since this was ending up with rc=3D0
> that was confusing the error handling code.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index beeed0c43f..54e643d871 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -323,13 +323,15 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUser=
Msg *vmsg)
>          rc =3D sendmsg(conn_fd, &msg, 0);
>      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>
> -    do {
> -        if (vmsg->data) {
> -            rc =3D write(conn_fd, vmsg->data, vmsg->size);
> -        } else {
> -            rc =3D write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->size);
> -        }
> -    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
> +    if (vmsg->size) {
> +        do {
> +            if (vmsg->data) {
> +                rc =3D write(conn_fd, vmsg->data, vmsg->size);
> +            } else {
> +                rc =3D write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->siz=
e);
> +            }
> +        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
> +    }
>
>      if (rc <=3D 0) {
>          vu_panic(dev, "Error while writing: %s", strerror(errno));
> --
> 2.17.0
>
>



--=20
Marc-Andr=C3=A9 Lureau
