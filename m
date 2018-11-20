Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gOz8z-0000cu-VP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gOz5r-0003RW-9J
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:01:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gOz5r-0003Qd-5u
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:01:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so1120537qkh.6
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 22:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 10:00:49 +0400
Message-ID: <CAMxuvax5eYVwaqZDRBQzZ2cwJqd6aMV4U6VcjTq=LyHZYddn4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Enable fork_exec support on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>, "Blake, Eric" <eblake@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>

Hi

On Tue, Nov 20, 2018 at 4:57 AM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> g_spawn_async_with_fds is portable on Windows, so we can now enable
> fork_exec support there.
>
> Thanks Daniel P. Berrang=C3=A9 for the notice!
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  slirp/misc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 7972b9b05b..59b4e8f31c 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -62,17 +62,6 @@ int add_exec(struct ex_list **ex_ptr, void *chardev, c=
onst char *cmdline,
>  }
>
>
> -#ifdef _WIN32
> -
> -int
> -fork_exec(struct socket *so, const char *ex)
> -{
> -    /* not implemented */
> -    return 0;
> -}
> -
> -#else
> -
>  static int
>  slirp_socketpair_with_oob(int sv[2])
>  {
> @@ -132,7 +121,9 @@ err:
>  static void
>  fork_exec_child_setup(gpointer data)
>  {
> +#ifndef _WIN32
>      setsid();
> +#endif
>  }
>
>  int
> @@ -177,7 +168,6 @@ fork_exec(struct socket *so, const char *ex)
>      qemu_set_nonblock(so->s);
>      return 1;
>  }
> -#endif
>
>  char *slirp_connection_info(Slirp *slirp)
>  {
> --
> 2.19.1
>
