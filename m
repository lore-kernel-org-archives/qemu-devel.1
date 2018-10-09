Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oiD-0005ka-6N
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oiC-0000zk-6i
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:53:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9oiB-0000yn-UJ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:53:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5-v6so1107543wrt.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-17-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-17-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 13:53:42 +0400
Message-ID: <CAJ+F1CLVB=MhDPv9mW5MBzoWXyD-GFbsRUk_5oFW=Nk0nh1d4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/31] seccomp: Clean up error reporting in
 parse_sandbox()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Otubo <otubo@redhat.com>

Hi

On Mon, Oct 8, 2018 at 9:50 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_sandbox() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Cc: Eduardo Otubo <otubo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-seccomp.c | 18 +++++++++---------
>  vl.c           |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 1baa5c69ed..6d27699409 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -12,11 +12,12 @@
>   * Contributions after 2012-01-13 are licensed under the terms of the
>   * GNU GPL, version 2 or (at your option) any later version.
>   */
> +
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
>  #include "qemu/module.h"
> -#include "qemu/error-report.h"
>  #include <sys/prctl.h>
>  #include <seccomp.h>
>  #include "sysemu/seccomp.h"
> @@ -190,7 +191,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Error=
 **errp)
>                   * to provide a little bit of consistency for
>                   * the command line */
>              } else {
> -                error_report("invalid argument for obsolete");
> +                error_setg(errp, "invalid argument for obsolete");
>                  return -1;
>              }
>          }
> @@ -205,14 +206,13 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Err=
or **errp)
>                  /* calling prctl directly because we're
>                   * not sure if host has CAP_SYS_ADMIN set*/
>                  if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
> -                    error_report("failed to set no_new_privs "
> -                                 "aborting");
> +                    error_setg(errp, "failed to set no_new_privs " "abor=
ting");

Extra " "

>                      return -1;
>                  }
>              } else if (g_str_equal(value, "allow")) {
>                  /* default value */
>              } else {
> -                error_report("invalid argument for elevateprivileges");
> +                error_setg(errp, "invalid argument for elevateprivileges=
");
>                  return -1;
>              }
>          }
> @@ -224,7 +224,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Error=
 **errp)
>              } else if (g_str_equal(value, "allow")) {
>                  /* default value */
>              } else {
> -                error_report("invalid argument for spawn");
> +                error_setg(errp, "invalid argument for spawn");
>                  return -1;
>              }
>          }
> @@ -236,14 +236,14 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Err=
or **errp)
>              } else if (g_str_equal(value, "allow")) {
>                  /* default value */
>              } else {
> -                error_report("invalid argument for resourcecontrol");
> +                error_setg(errp, "invalid argument for resourcecontrol")=
;
>                  return -1;
>              }
>          }
>
>          if (seccomp_start(seccomp_opts) < 0) {
> -            error_report("failed to install seccomp syscall filter "
> -                         "in the kernel");
> +            error_setg(errp, "failed to install seccomp syscall filter "
> +                       "in the kernel");
>              return -1;
>          }
>      }
> diff --git a/vl.c b/vl.c
> index 9d2b38a31f..485c3fc008 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3925,8 +3925,8 @@ int main(int argc, char **argv, char **envp)
>
>  #ifdef CONFIG_SECCOMP
>      olist =3D qemu_find_opts_err("sandbox", NULL);
> -    if (olist && qemu_opts_foreach(olist, parse_sandbox, NULL, NULL)) {
> -        exit(1);
> +    if (olist) {
> +        qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
>      }
>  #endif
>

Other than that,


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
