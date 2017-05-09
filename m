Received: from eggs.gnu.org ([2001:4830:134:3::10]:49341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84cA-0000Qx-MK
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84c5-0002Qz-QD
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:51:42 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84c5-0002Qs-Lw
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:51:37 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so13591396qtb.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:51:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-13-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1486ab58-922b-5ff1-11da-a7e23b15067b@amsat.org>
Date: Tue, 9 May 2017 09:51:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/13] char: rename functions that are not
 part of fe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 05/09/2017 08:33 AM, Marc-André Lureau wrote:
> There is no clear reason to have those functions associated with
> frontend.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index b986ce1857..77e7b347f4 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -66,8 +66,7 @@ void qemu_chr_be_event(Chardev *s, int event)
>
>  /* Not reporting errors from writing to logfile, as logs are
>   * defined to be "best effort" only */
> -static void qemu_chr_fe_write_log(Chardev *s,
> -                                  const uint8_t *buf, size_t len)
> +static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
>  {
>      size_t done = 0;
>      ssize_t ret;
> @@ -91,9 +90,9 @@ static void qemu_chr_fe_write_log(Chardev *s,
>      }
>  }
>
> -static int qemu_chr_fe_write_buffer(Chardev *s,
> -                                    const uint8_t *buf, int len,
> -                                    int *offset, bool all)
> +static int qemu_chr_write_buffer(Chardev *s,
> +                                 const uint8_t *buf, int len,
> +                                 int *offset, bool all)
>  {
>      ChardevClass *cc = CHARDEV_GET_CLASS(s);
>      int res = 0;
> @@ -118,7 +117,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
>          }
>      }
>      if (*offset > 0) {
> -        qemu_chr_fe_write_log(s, buf, *offset);
> +        qemu_chr_write_log(s, buf, *offset);
>      }
>      qemu_mutex_unlock(&s->chr_write_lock);
>
> @@ -133,11 +132,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool all)
>      if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_PLAY) {
>          replay_char_write_event_load(&res, &offset);
>          assert(offset <= len);
> -        qemu_chr_fe_write_buffer(s, buf, offset, &offset, true);
> +        qemu_chr_write_buffer(s, buf, offset, &offset, true);
>          return res;
>      }
>
> -    res = qemu_chr_fe_write_buffer(s, buf, len, &offset, all);
> +    res = qemu_chr_write_buffer(s, buf, len, &offset, all);
>
>      if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
>          replay_char_write_event_save(res, offset);
>
