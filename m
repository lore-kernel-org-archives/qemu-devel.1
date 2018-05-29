Received: from eggs.gnu.org ([2001:4830:134:3::10]:56492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fNbVc-0006fp-Jl
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fNbVX-0006y3-Hs
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:05:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fNbVX-0006xa-3I
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:05:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4TA5Brj117188
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 06:05:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j94swr0kf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 06:05:33 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 29 May 2018 04:05:32 -0600
References: <20180529073140.7392-1-zyimin@linux.ibm.com>
	<c414c2a0-8591-3892-59d1-58c894f984fd@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue, 29 May 2018 18:05:25 +0800
MIME-Version: 1.0
In-Reply-To: <c414c2a0-8591-3892-59d1-58c894f984fd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <80481571-a84c-0c62-43c6-69b87117f19a@linux.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, fiuczy@linux.ibm.com, jtomko@redhat.com, borntraeger@de.ibm.com, jferlan@redhat.com



=E5=9C=A8 2018/5/29 =E4=B8=8B=E5=8D=885:37, Paolo Bonzini =E5=86=99=E9=81=
=93:
> On 29/05/2018 09:31, Yi Min Zhao wrote:
>> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
>> compiled. This would make libvirt set the corresponding capability and
>> then trigger failure during guest startup. This patch moves the code
>> regarding seccomp command line options to qemu-seccomp.c file and
>> wraps qemu_opts_foreach finding sandbox option with CONFIG_SECCOMP.
>> Because parse_sandbox() is moved into qemu-seccomp.c file, change
>> seccomp_start() to static function.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> I had to squash this in:
>
> diff --git a/vl.c b/vl.c
> index 1140feb227..66c17ff8f8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3842,11 +3842,16 @@ int main(int argc, char **argv, char **envp)
>                   qtest_log =3D optarg;
>                   break;
>               case QEMU_OPTION_sandbox:
> +#ifndef CONFIG_SECCOMP
One question, I guess you want to use #ifdef ?
>                   opts =3D qemu_opts_parse_noisily(qemu_find_opts("sand=
box"),
>                                                  optarg, true);
>                   if (!opts) {
>                       exit(1);
>                   }
> +#else
> +                error_report("-sandbox support is not enabled in this =
QEMU binary");
> +                exit(1);
> +#endif
>                   break;
>               case QEMU_OPTION_add_fd:
>   #ifndef _WIN32
>
>
> Otherwise "-sandbox" will crash with a NULL pointer dereference in a bi=
nary without
> seccomp support.  Otherwise looks great, thanks!
>
> Paolo
>
>> ---
>> 1. Problem Description
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> If QEMU is built without seccomp support, 'elevateprivileges' remains =
compiled.
>> This option of sandbox is treated as an indication for seccomp blackli=
st support
>> in libvirt. This behavior is introduced by the libvirt commits 31ca6a5=
 and
>> 3527f9d. It would make libvirt build wrong QEMU cmdline, and then the =
guest
>> startup would fail.
>>
>> 2. Libvirt Log
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> qemu-system-s390x: -sandbox on,obsolete=3Ddeny,elevateprivileges=3Dden=
y,spawn=3Ddeny,\
>> resourcecontrol=3Ddeny: seccomp support is disabled
>>
>> 3. Fixup
>> =3D=3D=3D=3D=3D=3D=3D=3D
>> Move the code related ot sandbox to qemu-seccomp.c file and wrap them =
with
>> CONFIG_SECCOMP. So compile the code related to sandbox only when
>> CONFIG_SECCOMP is defined.
>> ---
>>   include/sysemu/seccomp.h |   3 +-
>>   qemu-seccomp.c           | 121 +++++++++++++++++++++++++++++++++++++=
+++++++++-
>>   vl.c                     | 118 +------------------------------------=
--------
>>   3 files changed, 124 insertions(+), 118 deletions(-)
>>
>> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
>> index 9b092aa23f..fe859894f6 100644
>> --- a/include/sysemu/seccomp.h
>> +++ b/include/sysemu/seccomp.h
>> @@ -21,5 +21,6 @@
>>   #define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
>>   #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
>>  =20
>> -int seccomp_start(uint32_t seccomp_opts);
>> +int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp);
>> +
>>   #endif
>> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
>> index b770a77d33..148e4c6f24 100644
>> --- a/qemu-seccomp.c
>> +++ b/qemu-seccomp.c
>> @@ -13,6 +13,11 @@
>>    * GNU GPL, version 2 or (at your option) any later version.
>>    */
>>   #include "qemu/osdep.h"
>> +#include "qemu/config-file.h"
>> +#include "qemu/option.h"
>> +#include "qemu/module.h"
>> +#include "qemu/error-report.h"
>> +#include <sys/prctl.h>
>>   #include <seccomp.h>
>>   #include "sysemu/seccomp.h"
>>  =20
>> @@ -96,7 +101,7 @@ static const struct QemuSeccompSyscall blacklist[] =
=3D {
>>   };
>>  =20
>>  =20
>> -int seccomp_start(uint32_t seccomp_opts)
>> +static int seccomp_start(uint32_t seccomp_opts)
>>   {
>>       int rc =3D 0;
>>       unsigned int i =3D 0;
>> @@ -125,3 +130,117 @@ int seccomp_start(uint32_t seccomp_opts)
>>       seccomp_release(ctx);
>>       return rc;
>>   }
>> +
>> +#ifdef CONFIG_SECCOMP
>> +int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    if (qemu_opt_get_bool(opts, "enable", false)) {
>> +        uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
>> +                | QEMU_SECCOMP_SET_OBSOLETE;
>> +        const char *value =3D NULL;
>> +
>> +        value =3D qemu_opt_get(opts, "obsolete");
>> +        if (value) {
>> +            if (g_str_equal(value, "allow")) {
>> +                seccomp_opts &=3D ~QEMU_SECCOMP_SET_OBSOLETE;
>> +            } else if (g_str_equal(value, "deny")) {
>> +                /* this is the default option, this if is here
>> +                 * to provide a little bit of consistency for
>> +                 * the command line */
>> +            } else {
>> +                error_report("invalid argument for obsolete");
>> +                return -1;
>> +            }
>> +        }
>> +
>> +        value =3D qemu_opt_get(opts, "elevateprivileges");
>> +        if (value) {
>> +            if (g_str_equal(value, "deny")) {
>> +                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
>> +            } else if (g_str_equal(value, "children")) {
>> +                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
>> +
>> +                /* calling prctl directly because we're
>> +                 * not sure if host has CAP_SYS_ADMIN set*/
>> +                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
>> +                    error_report("failed to set no_new_privs "
>> +                                 "aborting");
>> +                    return -1;
>> +                }
>> +            } else if (g_str_equal(value, "allow")) {
>> +                /* default value */
>> +            } else {
>> +                error_report("invalid argument for elevateprivileges"=
);
>> +                return -1;
>> +            }
>> +        }
>> +
>> +        value =3D qemu_opt_get(opts, "spawn");
>> +        if (value) {
>> +            if (g_str_equal(value, "deny")) {
>> +                seccomp_opts |=3D QEMU_SECCOMP_SET_SPAWN;
>> +            } else if (g_str_equal(value, "allow")) {
>> +                /* default value */
>> +            } else {
>> +                error_report("invalid argument for spawn");
>> +                return -1;
>> +            }
>> +        }
>> +
>> +        value =3D qemu_opt_get(opts, "resourcecontrol");
>> +        if (value) {
>> +            if (g_str_equal(value, "deny")) {
>> +                seccomp_opts |=3D QEMU_SECCOMP_SET_RESOURCECTL;
>> +            } else if (g_str_equal(value, "allow")) {
>> +                /* default value */
>> +            } else {
>> +                error_report("invalid argument for resourcecontrol");
>> +                return -1;
>> +            }
>> +        }
>> +
>> +        if (seccomp_start(seccomp_opts) < 0) {
>> +            error_report("failed to install seccomp syscall filter "
>> +                         "in the kernel");
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static QemuOptsList qemu_sandbox_opts =3D {
>> +    .name =3D "sandbox",
>> +    .implied_opt_name =3D "enable",
>> +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_sandbox_opts.head),
>> +    .desc =3D {
>> +        {
>> +            .name =3D "enable",
>> +            .type =3D QEMU_OPT_BOOL,
>> +        },
>> +        {
>> +            .name =3D "obsolete",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name =3D "elevateprivileges",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name =3D "spawn",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name =3D "resourcecontrol",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +static void seccomp_register(void)
>> +{
>> +    qemu_add_opts(&qemu_sandbox_opts);
>> +}
>> +opts_init(seccomp_register);
>> +#endif
>> diff --git a/vl.c b/vl.c
>> index 806eec2ef6..ea04aa2e2b 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -28,11 +28,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/help_option.h"
>>   #include "qemu/uuid.h"
>> -
>> -#ifdef CONFIG_SECCOMP
>> -#include <sys/prctl.h>
>>   #include "sysemu/seccomp.h"
>> -#endif
>>  =20
>>   #ifdef CONFIG_SDL
>>   #if defined(__APPLE__) || defined(main)
>> @@ -257,35 +253,6 @@ static QemuOptsList qemu_rtc_opts =3D {
>>       },
>>   };
>>  =20
>> -static QemuOptsList qemu_sandbox_opts =3D {
>> -    .name =3D "sandbox",
>> -    .implied_opt_name =3D "enable",
>> -    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_sandbox_opts.head),
>> -    .desc =3D {
>> -        {
>> -            .name =3D "enable",
>> -            .type =3D QEMU_OPT_BOOL,
>> -        },
>> -        {
>> -            .name =3D "obsolete",
>> -            .type =3D QEMU_OPT_STRING,
>> -        },
>> -        {
>> -            .name =3D "elevateprivileges",
>> -            .type =3D QEMU_OPT_STRING,
>> -        },
>> -        {
>> -            .name =3D "spawn",
>> -            .type =3D QEMU_OPT_STRING,
>> -        },
>> -        {
>> -            .name =3D "resourcecontrol",
>> -            .type =3D QEMU_OPT_STRING,
>> -        },
>> -        { /* end of list */ }
>> -    },
>> -};
>> -
>>   static QemuOptsList qemu_option_rom_opts =3D {
>>       .name =3D "option-rom",
>>       .implied_opt_name =3D "romfile",
>> @@ -1041,88 +1008,6 @@ static int bt_parse(const char *opt)
>>       return 1;
>>   }
>>  =20
>> -static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>> -{
>> -    if (qemu_opt_get_bool(opts, "enable", false)) {
>> -#ifdef CONFIG_SECCOMP
>> -        uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
>> -                | QEMU_SECCOMP_SET_OBSOLETE;
>> -        const char *value =3D NULL;
>> -
>> -        value =3D qemu_opt_get(opts, "obsolete");
>> -        if (value) {
>> -            if (g_str_equal(value, "allow")) {
>> -                seccomp_opts &=3D ~QEMU_SECCOMP_SET_OBSOLETE;
>> -            } else if (g_str_equal(value, "deny")) {
>> -                /* this is the default option, this if is here
>> -                 * to provide a little bit of consistency for
>> -                 * the command line */
>> -            } else {
>> -                error_report("invalid argument for obsolete");
>> -                return -1;
>> -            }
>> -        }
>> -
>> -        value =3D qemu_opt_get(opts, "elevateprivileges");
>> -        if (value) {
>> -            if (g_str_equal(value, "deny")) {
>> -                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
>> -            } else if (g_str_equal(value, "children")) {
>> -                seccomp_opts |=3D QEMU_SECCOMP_SET_PRIVILEGED;
>> -
>> -                /* calling prctl directly because we're
>> -                 * not sure if host has CAP_SYS_ADMIN set*/
>> -                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
>> -                    error_report("failed to set no_new_privs "
>> -                                 "aborting");
>> -                    return -1;
>> -                }
>> -            } else if (g_str_equal(value, "allow")) {
>> -                /* default value */
>> -            } else {
>> -                error_report("invalid argument for elevateprivileges"=
);
>> -                return -1;
>> -            }
>> -        }
>> -
>> -        value =3D qemu_opt_get(opts, "spawn");
>> -        if (value) {
>> -            if (g_str_equal(value, "deny")) {
>> -                seccomp_opts |=3D QEMU_SECCOMP_SET_SPAWN;
>> -            } else if (g_str_equal(value, "allow")) {
>> -                /* default value */
>> -            } else {
>> -                error_report("invalid argument for spawn");
>> -                return -1;
>> -            }
>> -        }
>> -
>> -        value =3D qemu_opt_get(opts, "resourcecontrol");
>> -        if (value) {
>> -            if (g_str_equal(value, "deny")) {
>> -                seccomp_opts |=3D QEMU_SECCOMP_SET_RESOURCECTL;
>> -            } else if (g_str_equal(value, "allow")) {
>> -                /* default value */
>> -            } else {
>> -                error_report("invalid argument for resourcecontrol");
>> -                return -1;
>> -            }
>> -        }
>> -
>> -        if (seccomp_start(seccomp_opts) < 0) {
>> -            error_report("failed to install seccomp syscall filter "
>> -                         "in the kernel");
>> -            return -1;
>> -        }
>> -#else
>> -        error_report("seccomp support is disabled");
>> -        return -1;
>> -#endif
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
>>   {
>>       const char *proc_name;
>> @@ -3074,7 +2959,6 @@ int main(int argc, char **argv, char **envp)
>>       qemu_add_opts(&qemu_mem_opts);
>>       qemu_add_opts(&qemu_smp_opts);
>>       qemu_add_opts(&qemu_boot_opts);
>> -    qemu_add_opts(&qemu_sandbox_opts);
>>       qemu_add_opts(&qemu_add_fd_opts);
>>       qemu_add_opts(&qemu_object_opts);
>>       qemu_add_opts(&qemu_tpmdev_opts);
>> @@ -4071,10 +3955,12 @@ int main(int argc, char **argv, char **envp)
>>           exit(1);
>>       }
>>  =20
>> +#ifdef CONFIG_SECCOMP
>>       if (qemu_opts_foreach(qemu_find_opts("sandbox"),
>>                             parse_sandbox, NULL, NULL)) {
>>           exit(1);
>>       }
>> +#endif
>>  =20
>>       if (qemu_opts_foreach(qemu_find_opts("name"),
>>                             parse_name, NULL, NULL)) {
>>
>
>
