Received: from eggs.gnu.org ([2001:4830:134:3::10]:44402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1g0NGo-0004ta-Cw
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1g0NGl-0002q7-3j
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:46:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45922 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1g0NGk-0002op-PX
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:46:35 -0400
References: <20180907133902.28462-1-fli@suse.com>
	<20180907133902.28462-2-fli@suse.com>
	<20180912075508.GD2526@lemon.usersys.redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <442ff5f2-b1fb-e871-4a4c-e7346f4f273d@suse.com>
Date: Thu, 13 Sep 2018 16:46:26 +0800
MIME-Version: 1.0
In-Reply-To: <20180912075508.GD2526@lemon.usersys.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, eblake@redhat.com



On 09/12/2018 03:55 PM, Fam Zheng wrote:
> On Fri, 09/07 21:38, Fei Li wrote:
>> Currently, when qemu_signal_init() fails it only returns a non-zero
>> value but without propagating any Error. But its callers need a
>> non-null err when runs error_report_err(err), or else 0->msg occurs.
>>
>> To avoid such segmentation fault, add a new Error parameter to make
>> the call trace to propagate the err to the final caller.
>>
>> This patch also adds the omitted error handling when creating signalfd
>> pipe fails in qemu_signalfd_compat().
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   include/qemu/osdep.h |  2 +-
>>   util/compatfd.c      |  9 ++++++---
>>   util/main-loop.c     | 10 +++++-----
>>   3 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index a91068df0e..09ed85fcb8 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -421,7 +421,7 @@ struct qemu_signalfd_siginfo {
>>                                additional fields in the future) */
>>   };
>>  =20
>> -int qemu_signalfd(const sigset_t *mask);
>> +int qemu_signalfd(const sigset_t *mask, Error **errp);
>>   void sigaction_invoke(struct sigaction *action,
>>                         struct qemu_signalfd_siginfo *info);
>>   #endif
>> diff --git a/util/compatfd.c b/util/compatfd.c
>> index 980bd33e52..d3ed890405 100644
>> --- a/util/compatfd.c
>> +++ b/util/compatfd.c
>> @@ -16,6 +16,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu-common.h"
>>   #include "qemu/thread.h"
>> +#include "qapi/error.h"
>>  =20
>>   #include <sys/syscall.h>
>>  =20
>> @@ -65,7 +66,7 @@ static void *sigwait_compat(void *opaque)
>>       }
>>   }
>>  =20
>> -static int qemu_signalfd_compat(const sigset_t *mask)
>> +static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
>>   {
>>       struct sigfd_compat_info *info;
>>       QemuThread thread;
>> @@ -73,11 +74,13 @@ static int qemu_signalfd_compat(const sigset_t *ma=
sk)
>>  =20
>>       info =3D malloc(sizeof(*info));
>>       if (info =3D=3D NULL) {
>> +        error_setg(errp, "Failed to allocate signalfd memory");
>>           errno =3D ENOMEM;
>>           return -1;
>>       }
>>  =20
>>       if (pipe(fds) =3D=3D -1) {
>> +        error_setg(errp, "Failed to create signalfd pipe");
>>           free(info);
>>           return -1;
>>       }
>> @@ -94,7 +97,7 @@ static int qemu_signalfd_compat(const sigset_t *mask=
)
>>       return fds[0];
>>   }
>>  =20
>> -int qemu_signalfd(const sigset_t *mask)
>> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>>   {
>>   #if defined(CONFIG_SIGNALFD)
>>       int ret;
> Extend the context:
>
>         ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>         if (ret !=3D -1) {
>             qemu_set_cloexec(ret);
>             return ret;
>         }
>
> This error path need error_setg() as well.
Thanks for the comment. :)
Like adding as below?

 =C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D -1) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_cloexec(ret);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
+=C2=A0=C2=A0=C2=A0 } else {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "syscall SYS=
_signalfd failed: %s",=20
strerror(errno));
 =C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0#endif

 =C2=A0=C2=A0=C2=A0 return qemu_signalfd_compat(mask, errp);


If yes, I'd like to confirm the logic:

- 1.1 if the syscall() succeeds, return its value which is not -1: none=20
error;
-=C2=A0 if fails[1], continue to run the below "qemu_signalfd_compat(mask=
,=20
errp);"
 =C2=A0 =3D2.1 if qemu_signalfd_compat() succeeds, the error msg of [1] w=
ill be=20
kept in
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 **errp, although the return val=
ue indicates a success;
 =C2=A0 =3D2.2 if qemu_signalfd_compat() fails, the error msg[1] is repla=
ced by=20
another
 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 error[2] in the failing function=
 which indicates a failure.

Do you mean for the above 2.1, we still need keep the error message?
>
>> @@ -106,5 +109,5 @@ int qemu_signalfd(const sigset_t *mask)
>>       }
>>   #endif
>>  =20
>> -    return qemu_signalfd_compat(mask);
>> +    return qemu_signalfd_compat(mask, errp);
>>   }
>> diff --git a/util/main-loop.c b/util/main-loop.c
>> index affe0403c5..22aa2b1007 100644
>> --- a/util/main-loop.c
>> +++ b/util/main-loop.c
>> @@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
>>       }
>>   }
>>  =20
>> -static int qemu_signal_init(void)
>> +static int qemu_signal_init(Error **errp)
>>   {
>>       int sigfd;
>>       sigset_t set;
>> @@ -94,10 +94,10 @@ static int qemu_signal_init(void)
>>       pthread_sigmask(SIG_BLOCK, &set, NULL);
>>  =20
>>       sigdelset(&set, SIG_IPI);
>> -    sigfd =3D qemu_signalfd(&set);
>> +    sigfd =3D qemu_signalfd(&set, errp);
>>       if (sigfd =3D=3D -1) {
>>           fprintf(stderr, "failed to create signalfd\n");
> This fprintf is not needed any more.
Ok.

Have a nice day
Fei
>
>> -        return -errno;
>> +        return -1;
>>       }
>>  =20
>>       fcntl_setfl(sigfd, O_NONBLOCK);
>> @@ -109,7 +109,7 @@ static int qemu_signal_init(void)
>>  =20
>>   #else /* _WIN32 */
>>  =20
>> -static int qemu_signal_init(void)
>> +static int qemu_signal_init(Error **errp)
>>   {
>>       return 0;
>>   }
>> @@ -148,7 +148,7 @@ int qemu_init_main_loop(Error **errp)
>>  =20
>>       init_clocks(qemu_timer_notify_cb);
>>  =20
>> -    ret =3D qemu_signal_init();
>> +    ret =3D qemu_signal_init(errp);
>>       if (ret) {
>>           return ret;
>>       }
>> --=20
>> 2.13.7
>>
> Fam
>
>
