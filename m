Received: from eggs.gnu.org ([2001:4830:134:3::10]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAozz-0005O0-Vy
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 00:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAozw-0008CB-QG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 00:24:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59146 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gAozw-0008A7-AZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 00:24:24 -0400
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-2-fli@suse.com>
	<87in286bst.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <3bef7443-9212-db30-a27f-4aa1bd70e65b@suse.com>
Date: Fri, 12 Oct 2018 12:24:13 +0800
MIME-Version: 1.0
In-Reply-To: <87in286bst.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v5 1/7] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, famz@redhat.com



On 10/11/2018 06:02 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> Currently, when qemu_signal_init() fails it only returns a non-zero
>> value but without propagating any Error. But its callers need a
>> non-null err when runs error_report_err(err), or else 0->msg occurs.
> The bug is in qemu_init_main_loop():
>
>      ret =3D qemu_signal_init();
>      if (ret) {
>          return ret;
>      }
>
> Fails without setting an error, unlike the other failures.  Its callers
> crash then.
Thanks!
>> To avoid such segmentation fault, add a new Error parameter to make
>> the call trace to propagate the err to the final caller.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>   include/qemu/osdep.h | 2 +-
>>   util/compatfd.c      | 9 ++++++---
>>   util/main-loop.c     | 9 ++++-----
>>   3 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 4f8559e550..f1f56763a0 100644
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
>> @@ -106,5 +109,5 @@ int qemu_signalfd(const sigset_t *mask)
>>       }
>>   #endif
>>  =20
>> -    return qemu_signalfd_compat(mask);
>> +    return qemu_signalfd_compat(mask, errp);
>>   }
> I think this takes the Error conversion too far.
>
> qemu_signalfd() is like the signalfd() system call, only portable, and
> setting FD_CLOEXEC.  In particular, it reports failure just like a
> system call: it sets errno and returns -1.  I'd prefer to keep it that
> way.  Instead...
>
>> diff --git a/util/main-loop.c b/util/main-loop.c
>> index affe0403c5..9671b6d226 100644
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
>> @@ -94,9 +94,8 @@ static int qemu_signal_init(void)
>>       pthread_sigmask(SIG_BLOCK, &set, NULL);
>>  =20
>>       sigdelset(&set, SIG_IPI);
>> -    sigfd =3D qemu_signalfd(&set);
>> +    sigfd =3D qemu_signalfd(&set, errp);
>>       if (sigfd =3D=3D -1) {
>> -        fprintf(stderr, "failed to create signalfd\n");
>>           return -errno;
>>       }
>>  =20
> ... change this function so:
>
>         pthread_sigmask(SIG_BLOCK, &set, NULL);
>    =20
>         sigdelset(&set, SIG_IPI);
>         sigfd =3D qemu_signalfd(&set);
>         if (sigfd =3D=3D -1) {
>    -        fprintf(stderr, "failed to create signalfd\n");
>    +        error_setg_errno(errp, errno, "failed to create signalfd");
>             return -errno;
>         }
>
> Does this make sense?
Yes, it looks more concise if we only have this patch, but triggers one=20
errno-set
issue after applying patch 7/7, which adds a Error **errp parameter for
qemu_thread_create() to let its callers handle the error instead of=20
exit() directly
to add the robustness.

For the patch series' current implementation, the=C2=A0 modified=20
qemu_thread_create()
in 7/7 patch returns a Boolean value to indicate whether it succeeds and=20
set the
error reason into the passed errp, and did not set the errno. Actually=20
another
similar errno-set issue has been talked in last patch. :)
If we set the errno in future qemu_thread_create(), we need to=20
distinguish the Linux
and Windows implementation. For Linux, we can use error_setg_errno() to=20
set errno.
But for Windows, I am not sure if we can use

"errno =3D GetLastError()"

to set errno, as this seems a little weird. Do you have any idea about th=
is?

BTW, if we have a decent errno-set way for Windows, I will adopt your abo=
ve
proposal for this patch.

Have a nice day, thanks for the review :)
Fei
>> @@ -109,7 +108,7 @@ static int qemu_signal_init(void)
>>  =20
>>   #else /* _WIN32 */
>>  =20
>> -static int qemu_signal_init(void)
>> +static int qemu_signal_init(Error **errp)
>>   {
>>       return 0;
>>   }
>> @@ -148,7 +147,7 @@ int qemu_init_main_loop(Error **errp)
>>  =20
>>       init_clocks(qemu_timer_notify_cb);
>>  =20
>> -    ret =3D qemu_signal_init();
>> +    ret =3D qemu_signal_init(errp);
>>       if (ret) {
>>           return ret;
>>       }
>
