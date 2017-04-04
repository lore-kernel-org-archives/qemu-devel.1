Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvQ43-0002cR-OT
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvQ40-0007mL-G6
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:08:11 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvQ40-0007mD-BN
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:08:08 -0400
Received: by mail-qt0-x242.google.com with SMTP id r45so23635925qte.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 08:08:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <609eb1d3-eea1-e38c-d95e-d8ba18d0364b@amsat.org>
Date: Tue, 4 Apr 2017 12:08:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170316092121.25672-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/21] char: remove
 qemu_chr_be_generic_open
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

On 03/16/2017 06:21 AM, Marc-André Lureau wrote:
> The function simply alias and hides the real event function.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/sysemu/char.h |  1 -
>  chardev/char-pty.c    |  2 +-
>  chardev/char-socket.c |  2 +-
>  chardev/char.c        | 10 ++--------
>  ui/console.c          |  2 +-
>  ui/gtk.c              |  2 +-
>  6 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 450881d42c..a30ff3fa80 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -427,7 +427,6 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>   */
>  void qemu_chr_fe_take_focus(CharBackend *b);
>
> -void qemu_chr_be_generic_open(Chardev *s);
>  void qemu_chr_fe_accept_input(CharBackend *be);
>  int qemu_chr_add_client(Chardev *s, int fd);
>  Chardev *qemu_chr_find(const char *name);
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index a6337be8aa..aa9d0cb2c3 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -185,7 +185,7 @@ static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
>      PtyChardev *s = PTY_CHARDEV(opaque);
>
>      s->open_tag = 0;
> -    qemu_chr_be_generic_open(chr);
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      return FALSE;
>  }
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index d7e92e1bd3..dc3d3532a7 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -486,7 +486,7 @@ static void tcp_chr_connect(void *opaque)
>                                             tcp_chr_read,
>                                             chr, NULL);
>      }
> -    qemu_chr_be_generic_open(chr);
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void tcp_chr_update_read_handler(Chardev *chr,
> diff --git a/chardev/char.c b/chardev/char.c
> index 3df116350b..aad639b620 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -66,12 +66,6 @@ void qemu_chr_be_event(Chardev *s, int event)
>      be->chr_event(be->opaque, event);
>  }
>
> -void qemu_chr_be_generic_open(Chardev *s)
> -{
> -    qemu_chr_be_event(s, CHR_EVENT_OPENED);
> -}
> -
> -
>  /* Not reporting errors from writing to logfile, as logs are
>   * defined to be "best effort" only */
>  static void qemu_chr_fe_write_log(Chardev *s,
> @@ -469,7 +463,7 @@ static void muxes_realize_done(Notifier *notifier, void *unused)
>              /* mark mux as OPENED so any new FEs will immediately receive
>               * OPENED event
>               */
> -            qemu_chr_be_generic_open(chr);
> +            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>          }
>      }
>      muxes_realized = true;
> @@ -581,7 +575,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>          /* We're connecting to an already opened device, so let's make sure we
>             also get the open event */
>          if (s->be_open) {
> -            qemu_chr_be_generic_open(s);
> +            qemu_chr_be_event(s, CHR_EVENT_OPENED);
>          }
>      }
>
> diff --git a/ui/console.c b/ui/console.c
> index d1ff7504ec..d88c52efe5 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2070,7 +2070,7 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
>          s->t_attrib = s->t_attrib_default;
>      }
>
> -    qemu_chr_be_generic_open(chr);
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void vc_chr_open(Chardev *chr,
> diff --git a/ui/gtk.c b/ui/gtk.c
> index a86848f3b0..7479ceef35 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1868,7 +1868,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
>      gtk_notebook_append_page(GTK_NOTEBOOK(s->notebook), vc->tab_item,
>                               gtk_label_new(vc->label));
>
> -    qemu_chr_be_generic_open(vc->vte.chr);
> +    qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
>
>      return group;
>  }
>
