Received: from eggs.gnu.org ([2001:4830:134:3::10]:48461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gADmD-0004oN-EF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gADm8-0000Y8-Cb
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1gADm8-0000WD-3z
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF7A630024DC
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 12:39:38 +0000 (UTC)
Date: Wed, 10 Oct 2018 14:39:37 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20181010123937.GC3661@vader>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-17-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20181008173125.19678-17-armbru@redhat.com>
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
Cc: qemu-devel@nongnu.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/10/2018 - 19:31:10, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_sandbox() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>=20
> Cc: Eduardo Otubo <otubo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-seccomp.c | 18 +++++++++---------
>  vl.c           |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>=20
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
>                      return -1;

Except for this " " all else is good.

Acked-by: Eduardo Otubo <otubo@redhat.com>

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
> +                error_setg(errp, "invalid argument for resourcecontrol");
>                  return -1;
>              }
>          }
> =20
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
> =20
>  #ifdef CONFIG_SECCOMP
>      olist =3D qemu_find_opts_err("sandbox", NULL);
> -    if (olist && qemu_opts_foreach(olist, parse_sandbox, NULL, NULL)) {
> -        exit(1);
> +    if (olist) {
> +        qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
>      }
>  #endif
> =20
> --=20
> 2.17.1
>=20

--=20
Eduardo Otubo

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbvfMJAAoJEN8y58Dw//miXa8H/0YTnULomZfPRD+eaCbL0Gsk
OEMG81cZqq3ZmdZ3KOX7P4AtBhCE8C003Cjl53BJZaOms3Pq2HKNi7Q0E/2I2m+c
3kXZ2Ztb30zVt/vrYyMXlYWOj7efe19ddFeFmCt0WEV2vKsfsAoTPtRsYslK7gfH
Kj5CcXGSKUr5U5BJrzoT/A/V24FZeMvpRjeLVb1x6wB4zGtQGd/0Fl8sQlN0aUzj
AW4k1ZIbjF+SXKC24UspVqHLHxCkmVyZajK5tw7/BLvWrlYv9tsRBV+CVwMnkL3r
uv9en6pC6/ZH2vuKGRgMJOGxW2gEX8nUdPkMSkPzUifb30Lgq6Hedn6zXY0c3zQ=
=YMZf
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
