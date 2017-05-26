Received: from eggs.gnu.org ([2001:4830:134:3::10]:51586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEHKz-0002vb-4l
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEHKv-0008Lz-RH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:39:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEHKv-0008Lp-LM
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:39:33 -0400
Received: by mail-oi0-x243.google.com with SMTP id w138so2231017oiw.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:39:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-9-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb33b11c-5703-d100-5b12-3ad50ca5eeaf@amsat.org>
Date: Fri, 26 May 2017 12:39:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/13] be-hci: use backend functions
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
> Avoid accessing CharBackend directly, use qemu_chr_be_* methods instead.
>
> be->chr_read should exists if qemu_chr_be_can_write() is true.
>
> (use qemu_chr_be_write(), _impl() bypasses replay)
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/bt/hci-csr.c | 9 +++------
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
> -    Chardev *chr = (Chardev *)s;
> -    CharBackend *be = chr->be;
> +    Chardev *chr = CHARDEV(s);
>
>      if (!s->enable || !s->out_len)
>          return;
>
>      /* XXX: Should wait for s->modem_state & CHR_TIOCM_RTS? */
> -    if (be && be->chr_can_read && be->chr_can_read(be->opaque) &&
> -        be->chr_read) {
> +    if (qemu_chr_be_can_write(chr)) {

Correct.

> -        be->chr_read(be->opaque,
> -                     s->outfifo + s->out_start++, 1);
> +        qemu_chr_be_write(chr, s->outfifo + s->out_start++, 1);

Here the difference with qemu_chr_be_write_impl() is the check with 
REPLAY_MODE_PLAY which is what you want from your commit message, right? 
I'm not sure if it makes sens or not to instead call _impl() directly.

>          s->out_len--;
>          if (s->out_start >= s->out_size) {
>              s->out_start = 0;
>

Regards,

Phil.
