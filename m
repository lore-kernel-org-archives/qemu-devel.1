Received: from eggs.gnu.org ([2001:4830:134:3::10]:53271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL5Hl-0000qR-N7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL5Hg-00079E-PC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:12:25 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL5Hg-000799-IP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:12:20 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 36so60358459wry.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 03:12:20 -0700 (PDT)
References: <20170614084538.32480-1-kraxel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170614084538.32480-1-kraxel@redhat.com>
Date: Wed, 14 Jun 2017 11:12:53 +0100
Message-ID: <87tw3ij2sa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] console: remove do_safe_dpy_refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


Gerd Hoffmann <kraxel@redhat.com> writes:

> Drop the temporary workaround for the broken display updates.
> All display adapters are updated, so this should be safe without
> causing regressions.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  ui/console.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index d914cced53..af0c56c600 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1579,36 +1579,13 @@ bool dpy_gfx_check_format(QemuConsole *con,
>      return true;
>  }
>
> -/*
> - * Safe DPY refresh for TCG guests. We use the exclusive mechanism to
> - * ensure the TCG vCPUs are quiescent so we can avoid races between
> - * dirty page tracking for direct frame-buffer access by the guest.
> - *
> - * This is a temporary stopgap until we've fixed the dirty tracking
> - * races in display adapters.
> - */
> -static void do_safe_dpy_refresh(DisplayChangeListener *dcl)
> -{
> -    qemu_mutex_unlock_iothread();
> -    start_exclusive();
> -    qemu_mutex_lock_iothread();
> -    dcl->ops->dpy_refresh(dcl);
> -    qemu_mutex_unlock_iothread();
> -    end_exclusive();
> -    qemu_mutex_lock_iothread();
> -}
> -
>  static void dpy_refresh(DisplayState *s)
>  {
>      DisplayChangeListener *dcl;
>
>      QLIST_FOREACH(dcl, &s->listeners, next) {
>          if (dcl->ops->dpy_refresh) {
> -            if (tcg_enabled()) {
> -                do_safe_dpy_refresh(dcl);
> -            } else {
> -                dcl->ops->dpy_refresh(dcl);
> -            }
> +            dcl->ops->dpy_refresh(dcl);
>          }
>      }
>  }


--
Alex Bennée
