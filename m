Received: from eggs.gnu.org ([209.51.188.92]:49735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwUaO-0004lp-Fn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwUa4-0004ja-L7
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:18:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwUa1-0004Kf-Vp
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:18:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so1657975qte.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-25-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-25-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 14:44:54 +0100
Message-ID: <CAMxuvaxwbxXKAYKdU4E8LmQ46_8_2L8GJrfp9+AmNOL0uvWsXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/25] chardev: Let
 qemu_chr_fe_write[_all] use size_t type argument
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

On Wed, Feb 20, 2019 at 2:08 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> All caller have been audited and call these functions with
> unsigned arguments.
>
> Most of them use a size_t argument, or directly pass sizeof().
>
> One case is unclear: the mux_chr_write() call in chardev/char-mux.c.
> There we add an assert (which will be removed in few patches) and
> cast the parameter as size_t to make explicit this value is unsigned.

mux_chr_write() is called indirectly from qemu_chr_fe_write(), so the
same argument applies here. Fine with or without the assert().

>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-fe.c         | 4 ++--
>  chardev/char-mux.c        | 3 ++-
>  include/chardev/char-fe.h | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index f3530a90e6..ab2a01709d 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -31,7 +31,7 @@
>  #include "chardev/char-io.h"
>  #include "chardev/char-mux.h"
>
> -int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
> +int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, size_t len)
>  {
>      Chardev *s =3D be->chr;
>
> @@ -42,7 +42,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *b=
uf, int len)
>      return qemu_chr_write(s, buf, len, false);
>  }
>
> -int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
> +int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, size_t le=
n)
>  {
>      Chardev *s =3D be->chr;
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 23aa82125d..7a3ff21db4 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -38,7 +38,8 @@ static int mux_chr_write(Chardev *chr, const uint8_t *b=
uf, int len)
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>      int ret;
>      if (!d->timestamps) {
> -        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
> +        assert(len >=3D 0);
> +        ret =3D qemu_chr_fe_write(&d->chr, buf, (size_t)len);
>      } else {
>          int i;
>
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index aa1b864ccd..5fb2c2e7ec 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -203,7 +203,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
>   *
>   * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
> -int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
> +int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, size_t len);
>
>  /**
>   * qemu_chr_fe_write_all:
> @@ -217,7 +217,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len);
>   *
>   * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
> -int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
> +int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, size_t le=
n);
>
>  /**
>   * qemu_chr_fe_read_all:
> --
> 2.20.1
>
