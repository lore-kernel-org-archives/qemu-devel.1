Received: from eggs.gnu.org ([2001:4830:134:3::10]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eejpL-0002mD-Av
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eejpI-00063i-82
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:52:35 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eejpI-00062q-3J
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:52:32 -0500
Received: by mail-qt0-f195.google.com with SMTP id s39so20289229qth.7
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 07:52:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516923604-101518-1-git-send-email-peng.hao2@zte.com.cn>
References: <1516923604-101518-1-git-send-email-peng.hao2@zte.com.cn>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Thu, 25 Jan 2018 16:52:30 +0100
Message-ID: <CAMxuvaxiw8JD20u0X8ek2X+uV-S0E=zbgvh0fGNYQ6v8OEyCoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] char-pty: avoid assertion warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, Peter Xu <peterx@redhat.com>
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

On Fri, Jan 26, 2018 at 12:40 AM, Peng Hao <peng.hao2@zte.com.cn> wrote:
> g_source_unref(s->open_source) in pty_chr_timer may trigger a assertion like this:
> g_source_unref: assertion 'source != NULL' failed.
> pty_chr_update_read_handler_locked-->pty_chr_state(chr, 0) may be called
> in pty_chr_timer, pty_chr_state(chr, 0) will call g_source_unref(s->open_source)
> and set s->open_source=NULL.

Peter already sent "[PATCH] chardev: fix incorrect unref of source",
queued by Paolo,
thanks

>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  chardev/char-pty.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 89315e6..da0f286 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -58,8 +58,10 @@ static gboolean pty_chr_timer(gpointer opaque)
>
>      qemu_mutex_lock(&chr->chr_write_lock);
>      s->timer_src = NULL;
> -    g_source_unref(s->open_source);
> -    s->open_source = NULL;
> +    if (s->open_source) {
> +        g_source_unref(s->open_source);
> +        s->open_source = NULL;
> +    }
>      if (!s->connected) {
>          /* Next poll ... */
>          pty_chr_update_read_handler_locked(chr);
> --
> 1.8.3.1
>
