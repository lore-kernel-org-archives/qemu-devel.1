Received: from eggs.gnu.org ([2001:4830:134:3::10]:60265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqYv-0005e2-CT
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqYn-0005YW-F3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUqYn-0005YA-6L
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:30:21 -0400
References: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d97e3209-e1d0-1c00-ae8b-7bb22eb198e2@redhat.com>
Date: Tue, 11 Jul 2017 10:30:14 +0200
MIME-Version: 1.0
In-Reply-To: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, wang.yechao255@zte.com.cn, Daniel Berrange <berrange@redhat.com>

On 11/07/2017 13:47, Peng Hao wrote:
> Parallel device don't register be->chr_can_read function, but remote
> disconnect event is handled in chr_read.So connected parallel device
> can not detect remote disconnect event. The chardevs with chr_can_read=3D=
NULL
> has the same problem.
>=20
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  chardev/char-socket.c  | 11 +++++++++++
>  chardev/char.c         | 10 ++++++++++
>  include/chardev/char.h |  9 +++++++++
>  3 files changed, 30 insertions(+)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499c..aa44f8f 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -139,6 +139,9 @@ static int tcp_chr_read_poll(void *opaque)
>          return 0;
>      }
>      s->max_size =3D qemu_chr_be_can_write(chr);
> +    if (qemu_chr_null_be_can_read(chr)) {
> +        return 1;
> +    }
>      return s->max_size;
>  }
> =20
> @@ -422,6 +425,14 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIO=
Condition cond, void *opaque)
>      uint8_t buf[CHR_READ_BUF_LEN];
>      int len, size;
> =20
> +    if (qemu_chr_null_be_can_read(chr)) {
> +        size =3D tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);

It would be better not to destroy data in the channel, because the
device could set handlers later.

Daniel, maybe QIOChannel could have a function to check for hung-up
channels and return a bool?  For file descriptors it would poll the file
descriptor and check for POLLHUP, while other channels would have a more
or less obvious implementation.

> +        if (size =3D=3D 0 || size =3D=3D -1) {
> +            tcp_chr_disconnect(chr);
> +        }
> +        return TRUE;
> +    }
> +
>      if (!s->connected || s->max_size <=3D 0) {
>          return TRUE;
>      }
> diff --git a/chardev/char.c b/chardev/char.c
> index 2b679a2..7f7f486 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -148,6 +148,16 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf,=
 int len, bool write_all)
>      return offset;
>  }
> =20
> +int qemu_chr_null_be_can_read(Chardev *s)
> +{
> +    CharBackend *be =3D s->be;
> +
> +    if (!be || !be->chr_can_read) {

I think it's really chr_read that you want to consider here.

Thanks,

Paolo

> +        return 1;
> +    }
> +    return 0;
> +}
> +
>  int qemu_chr_be_can_write(Chardev *s)
>  {
>      CharBackend *be =3D s->be;
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 8a9ade4..8dd28a8 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -114,6 +114,15 @@ void qemu_chr_cleanup(void);
>  Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
);
> =20
>  /**
> + * @qemu_chr_null_be_can_read:
> + *
> + * Check if Chardev's chr_can_read is registered.
> + *
> + * Returns: 1 if Chardev's chr_can_read is null.
> + */
> +int qemu_chr_null_be_can_read(Chardev *s);
> +
> +/**
>   * @qemu_chr_be_can_write:
>   *
>   * Determine how much data the front end can currently accept.  This f=
unction
>=20
