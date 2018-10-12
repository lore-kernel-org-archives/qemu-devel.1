Received: from eggs.gnu.org ([2001:4830:134:3::10]:46256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAsJc-0002OO-UP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAsJZ-0007Mv-LS
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAsJZ-0007MF-Cy
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:56:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-2-fli@suse.com>
	<87in286bst.fsf@dusky.pond.sub.org>
	<3bef7443-9212-db30-a27f-4aa1bd70e65b@suse.com>
Date: Fri, 12 Oct 2018 09:56:43 +0200
In-Reply-To: <3bef7443-9212-db30-a27f-4aa1bd70e65b@suse.com> (Fei Li's message
	of "Fri, 12 Oct 2018 12:24:13 +0800")
Message-ID: <87zhvjsimc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Fei Li <fli@suse.com>
Cc: Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

Fei Li <fli@suse.com> writes:

> On 10/11/2018 06:02 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> Currently, when qemu_signal_init() fails it only returns a non-zero
>>> value but without propagating any Error. But its callers need a
>>> non-null err when runs error_report_err(err), or else 0->msg occurs.
>> The bug is in qemu_init_main_loop():
>>
>>      ret =3D qemu_signal_init();
>>      if (ret) {
>>          return ret;
>>      }
>>
>> Fails without setting an error, unlike the other failures.  Its callers
>> crash then.
> Thanks!

Consider working that into your commit message.

>>> To avoid such segmentation fault, add a new Error parameter to make
>>> the call trace to propagate the err to the final caller.
>>>
>>> Signed-off-by: Fei Li <fli@suse.com>
>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>   include/qemu/osdep.h | 2 +-
>>>   util/compatfd.c      | 9 ++++++---
>>>   util/main-loop.c     | 9 ++++-----
>>>   3 files changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>> index 4f8559e550..f1f56763a0 100644
>>> --- a/include/qemu/osdep.h
>>> +++ b/include/qemu/osdep.h
>>> @@ -421,7 +421,7 @@ struct qemu_signalfd_siginfo {
>>>                                additional fields in the future) */
>>>   };
>>>   -int qemu_signalfd(const sigset_t *mask);
>>> +int qemu_signalfd(const sigset_t *mask, Error **errp);
>>>   void sigaction_invoke(struct sigaction *action,
>>>                         struct qemu_signalfd_siginfo *info);
>>>   #endif
>>> diff --git a/util/compatfd.c b/util/compatfd.c
>>> index 980bd33e52..d3ed890405 100644
>>> --- a/util/compatfd.c
>>> +++ b/util/compatfd.c
>>> @@ -16,6 +16,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qemu-common.h"
>>>   #include "qemu/thread.h"
>>> +#include "qapi/error.h"
>>>     #include <sys/syscall.h>
>>>   @@ -65,7 +66,7 @@ static void *sigwait_compat(void *opaque)
>>>       }
>>>   }
>>>   -static int qemu_signalfd_compat(const sigset_t *mask)
>>> +static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
>>>   {
>>>       struct sigfd_compat_info *info;
>>>       QemuThread thread;
>>> @@ -73,11 +74,13 @@ static int qemu_signalfd_compat(const sigset_t *mas=
k)
>>>         info =3D malloc(sizeof(*info));
>>>       if (info =3D=3D NULL) {
>>> +        error_setg(errp, "Failed to allocate signalfd memory");
>>>           errno =3D ENOMEM;
>>>           return -1;
>>>       }
>>>         if (pipe(fds) =3D=3D -1) {
>>> +        error_setg(errp, "Failed to create signalfd pipe");
>>>           free(info);
>>>           return -1;
>>>       }
>>> @@ -94,7 +97,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>>>       return fds[0];
>>>   }
>>>   -int qemu_signalfd(const sigset_t *mask)
>>> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>>>   {
>>>   #if defined(CONFIG_SIGNALFD)
>>>       int ret;
>>> @@ -106,5 +109,5 @@ int qemu_signalfd(const sigset_t *mask)
>>>       }
>>>   #endif
>>>   -    return qemu_signalfd_compat(mask);
>>> +    return qemu_signalfd_compat(mask, errp);
>>>   }
>> I think this takes the Error conversion too far.
>>
>> qemu_signalfd() is like the signalfd() system call, only portable, and
>> setting FD_CLOEXEC.  In particular, it reports failure just like a
>> system call: it sets errno and returns -1.  I'd prefer to keep it that
>> way.  Instead...
>>
>>> diff --git a/util/main-loop.c b/util/main-loop.c
>>> index affe0403c5..9671b6d226 100644
>>> --- a/util/main-loop.c
>>> +++ b/util/main-loop.c
>>> @@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
>>>       }
>>>   }
>>>   -static int qemu_signal_init(void)
>>> +static int qemu_signal_init(Error **errp)
>>>   {
>>>       int sigfd;
>>>       sigset_t set;
>>> @@ -94,9 +94,8 @@ static int qemu_signal_init(void)
>>>       pthread_sigmask(SIG_BLOCK, &set, NULL);
>>>         sigdelset(&set, SIG_IPI);
>>> -    sigfd =3D qemu_signalfd(&set);
>>> +    sigfd =3D qemu_signalfd(&set, errp);
>>>       if (sigfd =3D=3D -1) {
>>> -        fprintf(stderr, "failed to create signalfd\n");
>>>           return -errno;
>>>       }
>>>=20=20=20
>> ... change this function so:
>>
>>         pthread_sigmask(SIG_BLOCK, &set, NULL);
>>             sigdelset(&set, SIG_IPI);
>>         sigfd =3D qemu_signalfd(&set);
>>         if (sigfd =3D=3D -1) {
>>    -        fprintf(stderr, "failed to create signalfd\n");
>>    +        error_setg_errno(errp, errno, "failed to create signalfd");
>>             return -errno;
>>         }
>>
>> Does this make sense?
> Yes, it looks more concise if we only have this patch, but triggers
> one errno-set
> issue after applying patch 7/7, which adds a Error **errp parameter for
> qemu_thread_create() to let its callers handle the error instead of
> exit() directly
> to add the robustness.

I guess you're talking about the qemu_thread_create() in
qemu_signalfd_compat().  Correct?

> For the patch series' current implementation, the=C2=A0 modified
> qemu_thread_create()
> in 7/7 patch returns a Boolean value to indicate whether it succeeds
> and set the
> error reason into the passed errp, and did not set the errno. Actually
> another
> similar errno-set issue has been talked in last patch. :)
> If we set the errno in future qemu_thread_create(), we need to
> distinguish the Linux
> and Windows implementation. For Linux, we can use error_setg_errno()
> to set errno.
> But for Windows, I am not sure if we can use
>
> "errno =3D GetLastError()"

No, that won't work.

> to set errno, as this seems a little weird. Do you have any idea about th=
is?
>
> BTW, if we have a decent errno-set way for Windows, I will adopt your abo=
ve
> proposal for this patch.

According to MS docs, _beginthreadex() sets errno on failure:

    If successful, each of these functions returns a handle to the newly
    created thread; however, if the newly created thread exits too
    quickly, _beginthread might not return a valid handle. (See the
    discussion in the Remarks section.) On an error, _beginthread
    returns -1L, and errno is set to EAGAIN if there are too many
    threads, to EINVAL if the argument is invalid or the stack size is
    incorrect, or to EACCES if there are insufficient resources (such as
    memory). On an error, _beginthreadex returns 0, and errno and
    _doserrno are set.

https://docs.microsoft.com/cpp/c-runtime-library/reference/beginthread-begi=
nthreadex

Looks like the current code's use of GetLastError() after
_beginthreadex() failure is wrong.

Fix that, and both qemu_thread_create() implementations set errno on
failure, which in turn lets you make qemu_signalfd_compat() and thus
qemu_signalfd() behave sanely regardless of which qemu_thread_create()
implementation they use below the hood.

> Have a nice day, thanks for the review :)
> Fei
>>> @@ -109,7 +108,7 @@ static int qemu_signal_init(void)
>>>     #else /* _WIN32 */
>>>   -static int qemu_signal_init(void)
>>> +static int qemu_signal_init(Error **errp)
>>>   {
>>>       return 0;
>>>   }
>>> @@ -148,7 +147,7 @@ int qemu_init_main_loop(Error **errp)
>>>         init_clocks(qemu_timer_notify_cb);
>>>   -    ret =3D qemu_signal_init();
>>> +    ret =3D qemu_signal_init(errp);
>>>       if (ret) {
>>>           return ret;
>>>       }
>>
