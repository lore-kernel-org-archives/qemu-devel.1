Received: from eggs.gnu.org ([2001:4830:134:3::10]:50282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dXSEF-0008Pf-I3
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dXSEA-0007y2-Ph
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:07:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dXSEA-0007xm-GZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:07:50 -0400
References: <20170621132340.27686-1-kraxel@redhat.com>
	<20170621132340.27686-6-kraxel@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a69b1a3c-74b5-6aa2-6ae3-b80fd1a4f9e6@redhat.com>
Date: Tue, 18 Jul 2017 15:07:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170621132340.27686-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 5/6] console: remove do_safe_dpy_refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On 21/06/2017 15:23, Gerd Hoffmann wrote:
> Drop the temporary workaround for the broken display updates.
> All display adapters are updated, so this should be safe without
> causing regressions.

It seems it breaks QMP command 'migrate "exec:cat>mig"'.

The command hangs and doesn't create the file.

It happens with qemu-system-ppc64 on x86 (so TCG mode).

my command:

   ./ppc64-softmmu/qemu-system-ppc64 -serial mon:stdio

I wait SLOF fails to find an OS, and:

    Ctrl-a c
    (qemu) migrate -d "exec:cat>mig"

The file is not created and the command hangs:

#0  in __lll_lock_wait
#1  in pthread_mutex_lock
#2  in qemu_mutex_lock
#3  in rcu_init_lock
#4  in fork
#5  in qemu_fork
#6  in qio_channel_command_new_spawn
#7  in exec_start_outgoing_migration
#8  in qmp_migrate
...

It looks like a deadlock.

Laurent

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-id: 20170614084538.32480-1-kraxel@redhat.com
> ---
>  ui/console.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
>=20
> diff --git a/ui/console.c b/ui/console.c
> index d914cced53..af0c56c600 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1579,36 +1579,13 @@ bool dpy_gfx_check_format(QemuConsole *con,
>      return true;
>  }
> =20
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
> =20
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
>=20
