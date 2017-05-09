Received: from eggs.gnu.org ([2001:4830:134:3::10]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84jJ-0005J3-Gx
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84jF-0005SR-BD
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:59:05 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84jF-0005SK-4T
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:59:01 -0400
Received: by mail-qk0-x243.google.com with SMTP id u75so14539996qka.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:59:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-10-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a271264-56e5-e919-09d1-9e058ef6b2f5@amsat.org>
Date: Tue, 9 May 2017 09:58:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/13] char: generalize qemu_chr_write_all()
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

On 05/09/2017 08:33 AM, Marc-André Lureau wrote:
> qemu_chr_fe_write() is similar to qemu_chr_write_all(): the later write
> all with a chardev backend.
>
> Make qemu_chr_write() and qemu_chr_fe_write_buffer() take an 'all'
> argument. If false, handle 'partial' write the way qemu_chr_fe_write()
> use to, and call qemu_chr_write() from qemu_chr_fe_write().

What about invert logic and name the argument 'is_partial[_write]'? Else 
'write_all' to have more readable code?

>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 69 +++++++++++++++++++++++-----------------------------------
>  1 file changed, 27 insertions(+), 42 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index af7d871ed5..392dba6a86 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -96,7 +96,8 @@ static void qemu_chr_fe_write_log(Chardev *s,
>  }
>
>  static int qemu_chr_fe_write_buffer(Chardev *s,
> -                                    const uint8_t *buf, int len, int *offset)
> +                                    const uint8_t *buf, int len,
> +                                    int *offset, bool all)
>  {
>      ChardevClass *cc = CHARDEV_GET_CLASS(s);
>      int res = 0;
> @@ -106,7 +107,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
>      while (*offset < len) {
>      retry:
>          res = cc->chr_write(s, buf + *offset, len - *offset);
> -        if (res < 0 && errno == EAGAIN) {
> +        if (res < 0 && errno == EAGAIN && all) {
>              g_usleep(100);
>              goto retry;
>          }
> @@ -116,6 +117,9 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
>          }
>
>          *offset += res;
> +        if (!all) {
> +            break;
> +        }
>      }
>      if (*offset > 0) {
>          qemu_chr_fe_write_log(s, buf, *offset);
> @@ -130,54 +134,19 @@ static bool qemu_chr_replay(Chardev *chr)
>      return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
>  }
>
> -int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
> +static int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool all)
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
> +    res = qemu_chr_fe_write_buffer(s, buf, len, &offset, all);
>
>      if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
>          replay_char_write_event_save(res, offset);
> @@ -189,6 +158,22 @@ int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
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
> @@ -197,7 +182,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
>          return 0;
>      }
>
> -    return qemu_chr_write_all(s, buf, len);
> +    return qemu_chr_write(s, buf, len, true);
>  }
>
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>
