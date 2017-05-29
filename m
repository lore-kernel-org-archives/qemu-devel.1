Received: from eggs.gnu.org ([2001:4830:134:3::10]:58151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFRuk-0007wg-B8
	for qemu-devel@nongnu.org; Mon, 29 May 2017 17:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFRuf-0002kd-Bh
	for qemu-devel@nongnu.org; Mon, 29 May 2017 17:09:22 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFRuf-0002kU-4z
	for qemu-devel@nongnu.org; Mon, 29 May 2017 17:09:17 -0400
Received: by mail-oi0-x243.google.com with SMTP id h4so13125914oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 14:09:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-11-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9da6bf4c-120f-39e8-3711-79cc0b30277c@amsat.org>
Date: Mon, 29 May 2017 18:09:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170529084546.26500-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/14] char: generalize
 qemu_chr_write_all()
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

Hi Marc-André,

On 05/29/2017 05:45 AM, Marc-André Lureau wrote:
> qemu_chr_fe_write() is similar to qemu_chr_write_all(): the later write
> all with a chardev backend.
>
> Make qemu_chr_write() and qemu_chr_fe_write_buffer() take an 'all'
> argument. If false, handle 'partial' write the way qemu_chr_fe_write()
> use to, and call qemu_chr_write() from qemu_chr_fe_write().
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 70 +++++++++++++++++++++++-----------------------------------
>  1 file changed, 28 insertions(+), 42 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index a747e0279a..9a7c70c7aa 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -96,7 +96,8 @@ static void qemu_chr_fe_write_log(Chardev *s,
>  }
>
>  static int qemu_chr_fe_write_buffer(Chardev *s,
> -                                    const uint8_t *buf, int len, int *offset)
> +                                    const uint8_t *buf, int len,
> +                                    int *offset, bool write_all)
>  {
>      ChardevClass *cc = CHARDEV_GET_CLASS(s);
>      int res = 0;
> @@ -106,7 +107,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
>      while (*offset < len) {
>      retry:
>          res = cc->chr_write(s, buf + *offset, len - *offset);
> -        if (res < 0 && errno == EAGAIN) {
> +        if (res < 0 && errno == EAGAIN && write_all) {
>              g_usleep(100);
>              goto retry;
>          }
> @@ -116,6 +117,9 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
>          }
>
>          *offset += res;
> +        if (!write_all) {
> +            break;
> +        }
>      }
>      if (*offset > 0) {
>          qemu_chr_fe_write_log(s, buf, *offset);
> @@ -130,54 +134,20 @@ static bool qemu_chr_replay(Chardev *chr)
>      return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
>  }
>
> -int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
> +static int qemu_chr_write(Chardev *s, const uint8_t *buf, int len,
> +                          bool write_all)
>  {
> -    Chardev *s = be->chr;
> -    ChardevClass *cc;
> -    int ret;
> -
> -    if (!s) {
> -        return 0;
> -    }
> -
> -    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_PLAY) {
> -        int offset;
> -        replay_char_write_event_load(&ret, &offset);
> -        assert(offset <= len);
> -        qemu_chr_fe_write_buffer(s, buf, offset, &offset);
> -        return ret;
> -    }
> -
> -    cc = CHARDEV_GET_CLASS(s);
> -    qemu_mutex_lock(&s->chr_write_lock);
> -    ret = cc->chr_write(s, buf, len);
> -
> -    if (ret > 0) {
> -        qemu_chr_fe_write_log(s, buf, ret);
> -    }
> -
> -    qemu_mutex_unlock(&s->chr_write_lock);
> -
> -    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
> -        replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
> -    }
> -
> -    return ret;
> -}
> -
> -int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
> -{
> -    int offset;
> +    int offset = 0;
>      int res;
>
>      if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_PLAY) {
>          replay_char_write_event_load(&res, &offset);
>          assert(offset <= len);
> -        qemu_chr_fe_write_buffer(s, buf, offset, &offset);
> +        qemu_chr_fe_write_buffer(s, buf, offset, &offset, true);
>          return res;
>      }
>
> -    res = qemu_chr_fe_write_buffer(s, buf, len, &offset);
> +    res = qemu_chr_fe_write_buffer(s, buf, len, &offset, write_all);
>
>      if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
>          replay_char_write_event_save(res, offset);
> @@ -189,6 +159,22 @@ int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
>      return offset;
>  }
>
> +int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
> +{
> +    return qemu_chr_write(s, buf, len, true);
> +}
> +
> +int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
> +{
> +    Chardev *s = be->chr;
> +
> +    if (!s) {
> +        return 0;
> +    }
> +
> +    return qemu_chr_write(s, buf, len, false);
> +}
> +
>  int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
>  {
>      Chardev *s = be->chr;
> @@ -197,7 +183,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
>          return 0;
>      }
>
> -    return qemu_chr_write_all(s, buf, len);
> +    return qemu_chr_write(s, buf, len, true);

I think calling qemu_chr_write_all() is more readable.

Either ways:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  }
>
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>
