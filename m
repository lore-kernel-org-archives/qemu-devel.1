Received: from eggs.gnu.org ([2001:4830:134:3::10]:55565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxPGA-0001Pv-No
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxPG6-0002Ss-Dl
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:17:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38346 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fxPG5-0002M2-NQ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:17:38 -0400
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-2-fli@suse.com>
	<20180904112620.GG22349@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <0831de15-95cb-0774-10f9-8b03f4141c10@suse.com>
Date: Wed, 5 Sep 2018 12:17:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180904112620.GG22349@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Thanks for the review! :)


On 09/04/2018 07:26 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 04, 2018 at 07:08:18PM +0800, Fei Li wrote:
>> Currently, when qemu_signal_init() fails it only returns a non-zero
>> value but without propagating any Error. But its callers need a
>> non-null err when runs error_report_err(err), or else 0->msg occurs.
>>
>> To avoid such segmentation fault, add a new Error parameter to make
>> the call trace to propagate the err to the final caller.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   include/qemu/osdep.h |  2 +-
>>   util/compatfd.c      | 17 ++++++++++++-----
>>   util/main-loop.c     | 11 +++++++----
>>   3 files changed, 20 insertions(+), 10 deletions(-)
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
>> index 980bd33e52..65501de622 100644
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
>> +        error_setg(errp, "Failed to malloc in %s", __func__);
> I'd avoid using __func__ in error messages. Instead
>
>     "Failed to allocate signalfd memory"
Ok, thanks.
>
>>           errno =3D ENOMEM;
>>           return -1;
>>       }
>>  =20
>>       if (pipe(fds) =3D=3D -1) {
>> +        error_setg(errp, "Failed to create a pipe in %s", __func__);
>      "Failed to create signalfd pipe"
OK.
>
>>           free(info);
>>           return -1;
>>       }
>> @@ -94,17 +97,21 @@ static int qemu_signalfd_compat(const sigset_t *ma=
sk)
>>       return fds[0];
>>   }
>>  =20
>> -int qemu_signalfd(const sigset_t *mask)
>> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>>   {
>> -#if defined(CONFIG_SIGNALFD)
>>       int ret;
>> +    Error *local_err =3D NULL;
>>  =20
>> +#if defined(CONFIG_SIGNALFD)
>>       ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>>       if (ret !=3D -1) {
>>           qemu_set_cloexec(ret);
>>           return ret;
>>       }
>>   #endif
>> -
>> -    return qemu_signalfd_compat(mask);
>> +    ret =3D qemu_signalfd_compat(mask, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +    }
> Using a local_err is not required - you can just pass errp stright
> to qemu_signalfd_compat() and then check
>
>     if (ret < 0)
For the use of a local error object & error_propagate call, I'd like to=20
explain here. :)
In our code, the initial caller passes two kinds of Error to the call=20
trace, one is
something like &error_abort and &error_fatal, the other is NULL.

For the former, the exit() occurs in the functions where=20
error_handle_fatal() is called
(e.g. called by error_propagate/error_setg/...). The patch3:=20
qemu_init_vcpu is the case,
that means the system will exit in the final callee:=20
qemu_thread_create(), instead of
the initial caller pc_new_cpu(). In such case, I think propagating seems=20
more reasonable.

For the latter, suppose we pass errp straightly. As NULL is passed, the=20
error occurs in the
final callee will automatically "propagating" to the initial caller, and=20
let it handle this error.
The patch1: qemu_signal_init is this case, let the caller of=20
qemu_init_main_loop handle.
In such case, the error_propagate is indeed needless.

How do you think passing errp straightly for the latter case, and use a=20
local error object &
error_propagate for the former case? This is a distinct treatment, but=20
would shorten the code.

Have a nice day, thanks again
Fei
>> +    return ret;
>>   }
>> diff --git a/util/main-loop.c b/util/main-loop.c
>> index affe0403c5..20f6ad3849 100644
>> --- a/util/main-loop.c
>> +++ b/util/main-loop.c
>> @@ -71,10 +71,11 @@ static void sigfd_handler(void *opaque)
>>       }
>>   }
>>  =20
>> -static int qemu_signal_init(void)
>> +static int qemu_signal_init(Error **errp)
>>   {
>>       int sigfd;
>>       sigset_t set;
>> +    Error *local_err =3D NULL;
>>  =20
>>       /*
>>        * SIG_IPI must be blocked in the main thread and must not be ca=
ught
>> @@ -94,9 +95,10 @@ static int qemu_signal_init(void)
>>       pthread_sigmask(SIG_BLOCK, &set, NULL);
>>  =20
>>       sigdelset(&set, SIG_IPI);
>> -    sigfd =3D qemu_signalfd(&set);
>> +    sigfd =3D qemu_signalfd(&set, &local_err);
>>       if (sigfd =3D=3D -1) {
>>           fprintf(stderr, "failed to create signalfd\n");
>> +        error_propagate(errp, local_err);
>>           return -errno;
>>       }
> Again, no need for local_err - just pass errp stright in
>
>>  =20
>> @@ -109,7 +111,7 @@ static int qemu_signal_init(void)
>>  =20
>>   #else /* _WIN32 */
>>  =20
>> -static int qemu_signal_init(void)
>> +static int qemu_signal_init(Error **errp)
>>   {
>>       return 0;
>>   }
>> @@ -148,8 +150,9 @@ int qemu_init_main_loop(Error **errp)
>>  =20
>>       init_clocks(qemu_timer_notify_cb);
>>  =20
>> -    ret =3D qemu_signal_init();
>> +    ret =3D qemu_signal_init(&local_error);
>>       if (ret) {
>> +        error_propagate(errp, local_error);
>>           return ret;
>>       }
> Again, no need for local_error.
>
>
> Regards,
> Daniel
