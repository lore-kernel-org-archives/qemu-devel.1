Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuXJ-0001VD-5e
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuXE-00041z-3A
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:16:41 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuXD-00041K-TR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:16:36 -0500
Received: by mail-qt0-x241.google.com with SMTP id k19so13143865qtj.6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:16:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-8-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18e691f6-5814-5467-c29f-0e25623de250@amsat.org>
Date: Fri, 15 Dec 2017 15:16:32 -0300
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/13] readline: add a free function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 12/15/2017 12:06 PM, Marc-André Lureau wrote:
> Fixes leaks such as:
> 
> Direct leak of 2 byte(s) in 1 object(s) allocated from:
>     #0 0x7eff58beb850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7eff57942f0c in g_malloc ../glib/gmem.c:94
>     #2 0x7eff579431cf in g_malloc_n ../glib/gmem.c:331
>     #3 0x7eff5795f6eb in g_strdup ../glib/gstrfuncs.c:363
>     #4 0x55db720f1d46 in readline_hist_add /home/elmarco/src/qq/util/readline.c:258
>     #5 0x55db720f2d34 in readline_handle_byte /home/elmarco/src/qq/util/readline.c:387
>     #6 0x55db71539d00 in monitor_read /home/elmarco/src/qq/monitor.c:3896
>     #7 0x55db71f9be35 in qemu_chr_be_write_impl /home/elmarco/src/qq/chardev/char.c:167
>     #8 0x55db71f9bed3 in qemu_chr_be_write /home/elmarco/src/qq/chardev/char.c:179
>     #9 0x55db71fa013c in fd_chr_read /home/elmarco/src/qq/chardev/char-fd.c:66
>     #10 0x55db71fe18a8 in qio_channel_fd_source_dispatch /home/elmarco/src/qq/io/channel-watch.c:84
>     #11 0x7eff5793a90b in g_main_dispatch ../glib/gmain.c:3182
>     #12 0x7eff5793b7ac in g_main_context_dispatch ../glib/gmain.c:3847
>     #13 0x55db720af3bd in glib_pollfds_poll /home/elmarco/src/qq/util/main-loop.c:214
>     #14 0x55db720af505 in os_host_main_loop_wait /home/elmarco/src/qq/util/main-loop.c:261
>     #15 0x55db720af6d6 in main_loop_wait /home/elmarco/src/qq/util/main-loop.c:515
>     #16 0x55db7184e0de in main_loop /home/elmarco/src/qq/vl.c:1995
>     #17 0x55db7185e956 in main /home/elmarco/src/qq/vl.c:4914
>     #18 0x7eff4ea17039 in __libc_start_main (/lib64/libc.so.6+0x21039)
> 
> (while at it, use g_new0(ReadLineState), it's a bit easier to read)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qemu/readline.h |  1 +
>  monitor.c               |  2 +-
>  util/readline.c         | 18 +++++++++++++++++-
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/readline.h b/include/qemu/readline.h
> index c08cf7400e..e81258322b 100644
> --- a/include/qemu/readline.h
> +++ b/include/qemu/readline.h
> @@ -59,5 +59,6 @@ ReadLineState *readline_init(ReadLinePrintfFunc *printf_func,
>                               ReadLineFlushFunc *flush_func,
>                               void *opaque,
>                               ReadLineCompletionFunc *completion_finder);
> +void readline_free(ReadLineState *rs);
>  
>  #endif /* READLINE_H */
> diff --git a/monitor.c b/monitor.c
> index e36fb5308d..024dd3d515 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -584,7 +584,7 @@ static void monitor_data_destroy(Monitor *mon)
>      if (monitor_is_qmp(mon)) {
>          json_message_parser_destroy(&mon->qmp.parser);
>      }
> -    g_free(mon->rs);
> +    readline_free(mon->rs);
>      QDECREF(mon->outbuf);
>      qemu_mutex_destroy(&mon->out_lock);
>  }
> diff --git a/util/readline.c b/util/readline.c
> index bbdee790b0..24ec839854 100644
> --- a/util/readline.c
> +++ b/util/readline.c
> @@ -500,12 +500,28 @@ const char *readline_get_history(ReadLineState *rs, unsigned int index)
>      return rs->history[index];
>  }
>  
> +void readline_free(ReadLineState *rs)
> +{
> +    int i;
> +
> +    if (!rs) {
> +        return;
> +    }
> +    for (i = 0; i < READLINE_MAX_CMDS; i++) {
> +        g_free(rs->history[i]);
> +    }
> +    for (i = 0; i < READLINE_MAX_COMPLETIONS; i++) {
> +        g_free(rs->completions[i]);
> +    }
> +    g_free(rs);
> +}
> +
>  ReadLineState *readline_init(ReadLinePrintfFunc *printf_func,
>                               ReadLineFlushFunc *flush_func,
>                               void *opaque,
>                               ReadLineCompletionFunc *completion_finder)
>  {
> -    ReadLineState *rs = g_malloc0(sizeof(*rs));
> +    ReadLineState *rs = g_new0(ReadLineState, 1);
>  
>      rs->hist_entry = -1;
>      rs->opaque = opaque;
> 
