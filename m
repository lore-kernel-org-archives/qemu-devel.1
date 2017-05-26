Received: from eggs.gnu.org ([2001:4830:134:3::10]:55480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEEE6-0002dV-Np
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEEE5-00041x-Pa
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:20:18 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dEEE5-00041k-Hq
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:20:17 -0400
Received: by mail-lf0-x243.google.com with SMTP id 99so866659lfu.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 05:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-9-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 12:20:05 +0000
Message-ID: <CAJ+F1C+0TczwOVnfaO8jPVKWeiFXJNa4SiKp4yn662u3Evko0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/13] be-hci: use backend functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, balrog@zabor.org

On Tue, May 9, 2017 at 3:42 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Avoid accessing CharBackend directly, use qemu_chr_be_* methods instead.
>
> be->chr_read should exists if qemu_chr_be_can_write() is true.
>
> (use qemu_chr_be_write(), _impl() bypasses replay)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/bt/hci-csr.c | 9 +++------
>

No maintainer for this file. Andrzej, as author of the file, can you
review?


>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
> index 0f2021086d..d13192b9b5 100644
> --- a/hw/bt/hci-csr.c
> +++ b/hw/bt/hci-csr.c
> @@ -82,17 +82,14 @@ enum {
>
>  static inline void csrhci_fifo_wake(struct csrhci_s *s)
>  {
> -    Chardev *chr =3D (Chardev *)s;
> -    CharBackend *be =3D chr->be;
> +    Chardev *chr =3D CHARDEV(s);
>
>      if (!s->enable || !s->out_len)
>          return;
>
>      /* XXX: Should wait for s->modem_state & CHR_TIOCM_RTS? */
> -    if (be && be->chr_can_read && be->chr_can_read(be->opaque) &&
> -        be->chr_read) {
> -        be->chr_read(be->opaque,
> -                     s->outfifo + s->out_start++, 1);
> +    if (qemu_chr_be_can_write(chr)) {
> +        qemu_chr_be_write(chr, s->outfifo + s->out_start++, 1);
>          s->out_len--;
>          if (s->out_start >=3D s->out_size) {
>              s->out_start =3D 0;
> --
> 2.13.0.rc1.16.gd80b50c3f
>
>
> --
Marc-Andr=C3=A9 Lureau
