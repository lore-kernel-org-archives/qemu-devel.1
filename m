Received: from eggs.gnu.org ([2001:4830:134:3::10]:49272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cOV0C-0000cc-U9
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cOV09-0006uE-RQ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:44:08 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=44655 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cOV09-0006u3-Kz
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:44:05 -0500
References: <20170103191933.19416-1-marcandre.lureau@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <bd3b52ff-39c8-fcf4-ab47-15fcde35d19c@weilnetz.de>
Date: Tue, 3 Jan 2017 20:44:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170103191933.19416-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] win32: use glib gpoll if glib >= 2.50
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

On 01/03/17 20:19, Marc-Andr=C3=A9 Lureau wrote:
> A fix has been committed in upstream glib commit
> 210a9796f78eb90f76f1bd6a304e9fea05e97617.
> (See also related bug https://bugzilla.gnome.org/show_bug.cgi?id=3D7644=
15)
>
> It is desirable to use the glib version instead of qemu copy, since it
> provides more debugging facilities (G_MAIN_POLL_DEBUG etc), and
> hopefully has a better maintainance. Hopefully, we can drop the qemu
> copy in a few years.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/glib-compat.h | 2 +-
>  util/oslib-win32.c    | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index acf254d2a0..0cd24ffbe9 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -39,7 +39,7 @@ static inline gint64 qemu_g_get_monotonic_time(void)
>  #define g_get_monotonic_time() qemu_g_get_monotonic_time()
>  #endif
>
> -#ifdef _WIN32
> +#if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
>  /*
>   * g_poll has a problem on Windows when using
>   * timeouts < 10ms, so use wrapper.
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index d09863cc9d..0b1890fd33 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -327,6 +327,7 @@ char *qemu_get_exec_dir(void)
>      return g_strdup(exec_dir);
>  }
>
> +#if !GLIB_CHECK_VERSION(2, 50, 0)
>  /*
>   * The original implementation of g_poll from glib has a problem on Wi=
ndows
>   * when using timeouts < 10 ms.
> @@ -530,6 +531,7 @@ gint g_poll(GPollFD *fds, guint nfds, gint timeout)
>
>      return retval;
>  }
> +#endif
>
>  int getpagesize(void)
>  {
>

Thanks for this patch.
I think it can be applied via qemu-trivial (cc'ed).

Reviewed-by: Stefan Weil <sw@weilnetz.de>
