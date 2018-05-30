Received: from eggs.gnu.org ([2001:4830:134:3::10]:58929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fNykB-0004pv-9q
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fNyk8-00032h-3J
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:54:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fNyk7-00031a-TJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:54:12 -0400
Date: Wed, 30 May 2018 12:54:07 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180530105407.GB19798@vader>
References: <20180529073140.7392-1-zyimin@linux.ibm.com>
	<c414c2a0-8591-3892-59d1-58c894f984fd@redhat.com>
	<80481571-a84c-0c62-43c6-69b87117f19a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80481571-a84c-0c62-43c6-69b87117f19a@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, jtomko@redhat.com, jferlan@redhat.com

On 29/05/2018 - 18:05:25, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2018/5/29 =E4=B8=8B=E5=8D=885:37, Paolo Bonzini =E5=86=99=E9=81=
=93:
> > On 29/05/2018 09:31, Yi Min Zhao wrote:
> > > If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' rema=
ins
> > > compiled. This would make libvirt set the corresponding capability =
and
> > > then trigger failure during guest startup. This patch moves the cod=
e
> > > regarding seccomp command line options to qemu-seccomp.c file and
> > > wraps qemu_opts_foreach finding sandbox option with CONFIG_SECCOMP.
> > > Because parse_sandbox() is moved into qemu-seccomp.c file, change
> > > seccomp_start() to static function.
> > >=20
> > > Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> > I had to squash this in:
> >=20
> > diff --git a/vl.c b/vl.c
> > index 1140feb227..66c17ff8f8 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3842,11 +3842,16 @@ int main(int argc, char **argv, char **envp)
> >                   qtest_log =3D optarg;
> >                   break;
> >               case QEMU_OPTION_sandbox:
> > +#ifndef CONFIG_SECCOMP
> One question, I guess you want to use #ifdef ?

Yep, I guess he meant #ifdef.

Can you send a v4 with a cleaned up version? Also fixing a typo on the te=
xt
(elevateDprivileges).=20

Thanks for the contribution.

> >                   opts =3D qemu_opts_parse_noisily(qemu_find_opts("sa=
ndbox"),
> >                                                  optarg, true);
> >                   if (!opts) {
> >                       exit(1);
> >                   }
> > +#else
> > +                error_report("-sandbox support is not enabled in thi=
s QEMU binary");
> > +                exit(1);
> > +#endif
> >                   break;
> >               case QEMU_OPTION_add_fd:
> >   #ifndef _WIN32
> >=20
> >=20
> > Otherwise "-sandbox" will crash with a NULL pointer dereference in a =
binary without
> > seccomp support.  Otherwise looks great, thanks!
> >=20
> > Paolo
> >=20
> > > ---
> > > 1. Problem Description
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > If QEMU is built without seccomp support, 'elevateprivileges' remai=
ns compiled.
> > > This option of sandbox is treated as an indication for seccomp blac=
klist support
> > > in libvirt. This behavior is introduced by the libvirt commits 31ca=
6a5 and
> > > 3527f9d. It would make libvirt build wrong QEMU cmdline, and then t=
he guest
> > > startup would fail.
> > >=20
> > > 2. Libvirt Log
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > qemu-system-s390x: -sandbox on,obsolete=3Ddeny,elevateprivileges=3D=
deny,spawn=3Ddeny,\
> > > resourcecontrol=3Ddeny: seccomp support is disabled
> > >=20
> > > 3. Fixup
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > Move the code related ot sandbox to qemu-seccomp.c file and wrap th=
em with
> > > CONFIG_SECCOMP. So compile the code related to sandbox only when
> > > CONFIG_SECCOMP is defined.
> > > ---
> > >   include/sysemu/seccomp.h |   3 +-
> > >   qemu-seccomp.c           | 121 ++++++++++++++++++++++++++++++++++=
++++++++++++-
> > >   vl.c                     | 118 +---------------------------------=
-----------
> > >   3 files changed, 124 insertions(+), 118 deletions(-)
> > >=20
> > > diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> > > index 9b092aa23f..fe859894f6 100644
> > > --- a/include/sysemu/seccomp.h
> > > +++ b/include/sysemu/seccomp.h
> > > @@ -21,5 +21,6 @@
> > >   #define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
> > >   #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
> > > -int seccomp_start(uint32_t seccomp_opts);
> > > +int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp);
> > > +
> > >   #endif
> > > diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> > > index b770a77d33..148e4c6f24 100644
> > > --- a/qemu-seccomp.c
> > > +++ b/qemu-seccomp.c
> > > @@ -13,6 +13,11 @@
> > >    * GNU GPL, version 2 or (at your option) any later version.
> > >    */
> > >   #include "qemu/osdep.h"
> > > +#include "qemu/config-file.h"
> > > +#include "qemu/option.h"
> > > +#include "qemu/module.h"
> > > +#include "qemu/error-report.h"
> > > +#include <sys/prctl.h>
> > >   #include <seccomp.h>
> > >   #include "sysemu/seccomp.h"
> > > @@ -96,7 +101,7 @@ static const struct QemuSeccompSyscall blacklist=
[] =3D {
> > >   };
> > > -int seccomp_start(uint32_t seccomp_opts)
> > > +static int seccomp_start(uint32_t seccomp_opts)
> > >   {
> > >       int rc =3D 0;
> > >       unsigned int i =3D 0;
> > > @@ -125,3 +130,117 @@ int seccomp_start(uint32_t seccomp_opts)
> > >       seccomp_release(ctx);
> > >       return rc;
> > >   }
> > > +
> > > +#ifdef CONFIG_SECCOMP
> > > +int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
> > > +{
> > > +    if (qemu_opt_get_bool(opts, "enable", false)) {
> > > +        uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
> > > +                | QEMU_SECCOMP_SET_OBSOLETE;
> > > +        const char *value =3D NULL;
> > > +
> > > +        value =3D qemu_opt_get(opts, "obsolete");
> > > +        if (value) {
> > > +            if (g_str_equal(value, "allow")) {
> > > +                seccomp_opts &=3D ~QEMU_SECCOMP_SET_OBSOLETE;
> > > +            } else if (g_str_equal(value, "deny")) {
> > > +                /* this is the default option, this if is here
> > > +                 * to provide a little bit of consistency for
> > > +                 * the command line */
> > > +            } else {
> > > +                error_report("invalid argument for obsolete");
> > > +                return -1;
> > > +            }
> > > +        }
> > > +
> > > +        value =3D qemu_opt_get(opts, "elevateprivileges");
> > > +        if (value) {
> > > +            if (g_str_equal(value, "deny")) {
> > > +                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
> > > +            } else if (g_str_equal(value, "children")) {
> > > +                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
> > > +
> > > +                /* calling prctl directly because we're
> > > +                 * not sure if host has CAP_SYS_ADMIN set*/
> > > +                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
> > > +                    error_report("failed to set no_new_privs "
> > > +                                 "aborting");
> > > +                    return -1;
> > > +                }
> > > +            } else if (g_str_equal(value, "allow")) {
> > > +                /* default value */
> > > +            } else {
> > > +                error_report("invalid argument for elevateprivileg=
es");
> > > +                return -1;
> > > +            }
> > > +        }
> > > +
> > > +        value =3D qemu_opt_get(opts, "spawn");
> > > +        if (value) {
> > > +            if (g_str_equal(value, "deny")) {
> > > +                seccomp_opts |=3D QEMU_SECCOMP_SET_SPAWN;
> > > +            } else if (g_str_equal(value, "allow")) {
> > > +                /* default value */
> > > +            } else {
> > > +                error_report("invalid argument for spawn");
> > > +                return -1;
> > > +            }
> > > +        }
> > > +
> > > +        value =3D qemu_opt_get(opts, "resourcecontrol");
> > > +        if (value) {
> > > +            if (g_str_equal(value, "deny")) {
> > > +                seccomp_opts |=3D QEMU_SECCOMP_SET_RESOURCECTL;
> > > +            } else if (g_str_equal(value, "allow")) {
> > > +                /* default value */
> > > +            } else {
> > > +                error_report("invalid argument for resourcecontrol=
");
> > > +                return -1;
> > > +            }
> > > +        }
> > > +
> > > +        if (seccomp_start(seccomp_opts) < 0) {
> > > +            error_report("failed to install seccomp syscall filter=
 "
> > > +                         "in the kernel");
> > > +            return -1;
> > > +        }
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static QemuOptsList qemu_sandbox_opts =3D {
> > > +    .name =3D "sandbox",
> > > +    .implied_opt_name =3D "enable",
> > > +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_sandbox_opts.head),
> > > +    .desc =3D {
> > > +        {
> > > +            .name =3D "enable",
> > > +            .type =3D QEMU_OPT_BOOL,
> > > +        },
> > > +        {
> > > +            .name =3D "obsolete",
> > > +            .type =3D QEMU_OPT_STRING,
> > > +        },
> > > +        {
> > > +            .name =3D "elevateprivileges",
> > > +            .type =3D QEMU_OPT_STRING,
> > > +        },
> > > +        {
> > > +            .name =3D "spawn",
> > > +            .type =3D QEMU_OPT_STRING,
> > > +        },
> > > +        {
> > > +            .name =3D "resourcecontrol",
> > > +            .type =3D QEMU_OPT_STRING,
> > > +        },
> > > +        { /* end of list */ }
> > > +    },
> > > +};
> > > +
> > > +static void seccomp_register(void)
> > > +{
> > > +    qemu_add_opts(&qemu_sandbox_opts);
> > > +}
> > > +opts_init(seccomp_register);
> > > +#endif
> > > diff --git a/vl.c b/vl.c
> > > index 806eec2ef6..ea04aa2e2b 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -28,11 +28,7 @@
> > >   #include "qemu/cutils.h"
> > >   #include "qemu/help_option.h"
> > >   #include "qemu/uuid.h"
> > > -
> > > -#ifdef CONFIG_SECCOMP
> > > -#include <sys/prctl.h>
> > >   #include "sysemu/seccomp.h"
> > > -#endif
> > >   #ifdef CONFIG_SDL
> > >   #if defined(__APPLE__) || defined(main)
> > > @@ -257,35 +253,6 @@ static QemuOptsList qemu_rtc_opts =3D {
> > >       },
> > >   };
> > > -static QemuOptsList qemu_sandbox_opts =3D {
> > > -    .name =3D "sandbox",
> > > -    .implied_opt_name =3D "enable",
> > > -    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_sandbox_opts.head),
> > > -    .desc =3D {
> > > -        {
> > > -            .name =3D "enable",
> > > -            .type =3D QEMU_OPT_BOOL,
> > > -        },
> > > -        {
> > > -            .name =3D "obsolete",
> > > -            .type =3D QEMU_OPT_STRING,
> > > -        },
> > > -        {
> > > -            .name =3D "elevateprivileges",
> > > -            .type =3D QEMU_OPT_STRING,
> > > -        },
> > > -        {
> > > -            .name =3D "spawn",
> > > -            .type =3D QEMU_OPT_STRING,
> > > -        },
> > > -        {
> > > -            .name =3D "resourcecontrol",
> > > -            .type =3D QEMU_OPT_STRING,
> > > -        },
> > > -        { /* end of list */ }
> > > -    },
> > > -};
> > > -
> > >   static QemuOptsList qemu_option_rom_opts =3D {
> > >       .name =3D "option-rom",
> > >       .implied_opt_name =3D "romfile",
> > > @@ -1041,88 +1008,6 @@ static int bt_parse(const char *opt)
> > >       return 1;
> > >   }
> > > -static int parse_sandbox(void *opaque, QemuOpts *opts, Error **err=
p)
> > > -{
> > > -    if (qemu_opt_get_bool(opts, "enable", false)) {
> > > -#ifdef CONFIG_SECCOMP
> > > -        uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
> > > -                | QEMU_SECCOMP_SET_OBSOLETE;
> > > -        const char *value =3D NULL;
> > > -
> > > -        value =3D qemu_opt_get(opts, "obsolete");
> > > -        if (value) {
> > > -            if (g_str_equal(value, "allow")) {
> > > -                seccomp_opts &=3D ~QEMU_SECCOMP_SET_OBSOLETE;
> > > -            } else if (g_str_equal(value, "deny")) {
> > > -                /* this is the default option, this if is here
> > > -                 * to provide a little bit of consistency for
> > > -                 * the command line */
> > > -            } else {
> > > -                error_report("invalid argument for obsolete");
> > > -                return -1;
> > > -            }
> > > -        }
> > > -
> > > -        value =3D qemu_opt_get(opts, "elevateprivileges");
> > > -        if (value) {
> > > -            if (g_str_equal(value, "deny")) {
> > > -                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
> > > -            } else if (g_str_equal(value, "children")) {
> > > -                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
> > > -
> > > -                /* calling prctl directly because we're
> > > -                 * not sure if host has CAP_SYS_ADMIN set*/
> > > -                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
> > > -                    error_report("failed to set no_new_privs "
> > > -                                 "aborting");
> > > -                    return -1;
> > > -                }
> > > -            } else if (g_str_equal(value, "allow")) {
> > > -                /* default value */
> > > -            } else {
> > > -                error_report("invalid argument for elevateprivileg=
es");
> > > -                return -1;
> > > -            }
> > > -        }
> > > -
> > > -        value =3D qemu_opt_get(opts, "spawn");
> > > -        if (value) {
> > > -            if (g_str_equal(value, "deny")) {
> > > -                seccomp_opts |=3D QEMU_SECCOMP_SET_SPAWN;
> > > -            } else if (g_str_equal(value, "allow")) {
> > > -                /* default value */
> > > -            } else {
> > > -                error_report("invalid argument for spawn");
> > > -                return -1;
> > > -            }
> > > -        }
> > > -
> > > -        value =3D qemu_opt_get(opts, "resourcecontrol");
> > > -        if (value) {
> > > -            if (g_str_equal(value, "deny")) {
> > > -                seccomp_opts |=3D QEMU_SECCOMP_SET_RESOURCECTL;
> > > -            } else if (g_str_equal(value, "allow")) {
> > > -                /* default value */
> > > -            } else {
> > > -                error_report("invalid argument for resourcecontrol=
");
> > > -                return -1;
> > > -            }
> > > -        }
> > > -
> > > -        if (seccomp_start(seccomp_opts) < 0) {
> > > -            error_report("failed to install seccomp syscall filter=
 "
> > > -                         "in the kernel");
> > > -            return -1;
> > > -        }
> > > -#else
> > > -        error_report("seccomp support is disabled");
> > > -        return -1;
> > > -#endif
> > > -    }
> > > -
> > > -    return 0;
> > > -}
> > > -
> > >   static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
> > >   {
> > >       const char *proc_name;
> > > @@ -3074,7 +2959,6 @@ int main(int argc, char **argv, char **envp)
> > >       qemu_add_opts(&qemu_mem_opts);
> > >       qemu_add_opts(&qemu_smp_opts);
> > >       qemu_add_opts(&qemu_boot_opts);
> > > -    qemu_add_opts(&qemu_sandbox_opts);
> > >       qemu_add_opts(&qemu_add_fd_opts);
> > >       qemu_add_opts(&qemu_object_opts);
> > >       qemu_add_opts(&qemu_tpmdev_opts);
> > > @@ -4071,10 +3955,12 @@ int main(int argc, char **argv, char **envp=
)
> > >           exit(1);
> > >       }
> > > +#ifdef CONFIG_SECCOMP
> > >       if (qemu_opts_foreach(qemu_find_opts("sandbox"),
> > >                             parse_sandbox, NULL, NULL)) {
> > >           exit(1);
> > >       }
> > > +#endif
> > >       if (qemu_opts_foreach(qemu_find_opts("name"),
> > >                             parse_name, NULL, NULL)) {
> > >=20
> >=20
> >=20
>=20
>=20

--=20
Eduardo Otubo
