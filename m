Received: from eggs.gnu.org ([2001:4830:134:3::10]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAexA-0003yg-On
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAex7-0004QX-8O
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAex5-0004N7-3g
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:40:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-17-armbru@redhat.com>
	<CAJ+F1CLVB=MhDPv9mW5MBzoWXyD-GFbsRUk_5oFW=Nk0nh1d4w@mail.gmail.com>
Date: Thu, 11 Oct 2018 19:40:32 +0200
In-Reply-To: <CAJ+F1CLVB=MhDPv9mW5MBzoWXyD-GFbsRUk_5oFW=Nk0nh1d4w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 Oct 2018
	13:53:42 +0400")
Message-ID: <874ldsz8j3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Otubo <otubo@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Oct 8, 2018 at 9:50 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  parse_sandbox() does that, and then fails without
>> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
>> with it, but clean it up anyway.
>>
>> Cc: Eduardo Otubo <otubo@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qemu-seccomp.c | 18 +++++++++---------
>>  vl.c           |  4 ++--
>>  2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
>> index 1baa5c69ed..6d27699409 100644
>> --- a/qemu-seccomp.c
>> +++ b/qemu-seccomp.c
>> @@ -12,11 +12,12 @@
>>   * Contributions after 2012-01-13 are licensed under the terms of the
>>   * GNU GPL, version 2 or (at your option) any later version.
>>   */
>> +
>>  #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>>  #include "qemu/config-file.h"
>>  #include "qemu/option.h"
>>  #include "qemu/module.h"
>> -#include "qemu/error-report.h"
>>  #include <sys/prctl.h>
>>  #include <seccomp.h>
>>  #include "sysemu/seccomp.h"
>> @@ -190,7 +191,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Erro=
r **errp)
>>                   * to provide a little bit of consistency for
>>                   * the command line */
>>              } else {
>> -                error_report("invalid argument for obsolete");
>> +                error_setg(errp, "invalid argument for obsolete");
>>                  return -1;
>>              }
>>          }
>> @@ -205,14 +206,13 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Er=
ror **errp)
>>                  /* calling prctl directly because we're
>>                   * not sure if host has CAP_SYS_ADMIN set*/
>>                  if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
>> -                    error_report("failed to set no_new_privs "
>> -                                 "aborting");
>> +                    error_setg(errp, "failed to set no_new_privs " "abo=
rting");
>
> Extra " "

Fixing...

>>                      return -1;
>>                  }
>>              } else if (g_str_equal(value, "allow")) {
>>                  /* default value */
>>              } else {
>> -                error_report("invalid argument for elevateprivileges");
>> +                error_setg(errp, "invalid argument for elevateprivilege=
s");
>>                  return -1;
>>              }
>>          }
>> @@ -224,7 +224,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Erro=
r **errp)
>>              } else if (g_str_equal(value, "allow")) {
>>                  /* default value */
>>              } else {
>> -                error_report("invalid argument for spawn");
>> +                error_setg(errp, "invalid argument for spawn");
>>                  return -1;
>>              }
>>          }
>> @@ -236,14 +236,14 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Er=
ror **errp)
>>              } else if (g_str_equal(value, "allow")) {
>>                  /* default value */
>>              } else {
>> -                error_report("invalid argument for resourcecontrol");
>> +                error_setg(errp, "invalid argument for resourcecontrol"=
);
>>                  return -1;
>>              }
>>          }
>>
>>          if (seccomp_start(seccomp_opts) < 0) {
>> -            error_report("failed to install seccomp syscall filter "
>> -                         "in the kernel");
>> +            error_setg(errp, "failed to install seccomp syscall filter "
>> +                       "in the kernel");
>>              return -1;
>>          }
>>      }
>> diff --git a/vl.c b/vl.c
>> index 9d2b38a31f..485c3fc008 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3925,8 +3925,8 @@ int main(int argc, char **argv, char **envp)
>>
>>  #ifdef CONFIG_SECCOMP
>>      olist =3D qemu_find_opts_err("sandbox", NULL);
>> -    if (olist && qemu_opts_foreach(olist, parse_sandbox, NULL, NULL)) {
>> -        exit(1);
>> +    if (olist) {
>> +        qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
>>      }
>>  #endif
>>
>
> Other than that,
>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
