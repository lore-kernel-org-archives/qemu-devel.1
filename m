Received: from eggs.gnu.org ([2001:4830:134:3::10]:35714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAxSm-0002Vr-Ek
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAxSk-0001vG-PV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAxSk-0001un-H3
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:26:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-2-fli@suse.com>
	<87in286bst.fsf@dusky.pond.sub.org>
	<3bef7443-9212-db30-a27f-4aa1bd70e65b@suse.com>
	<87zhvjsimc.fsf@dusky.pond.sub.org>
	<3906b0bf-a9ec-e4ac-8948-59419b126799@suse.com>
Date: Fri, 12 Oct 2018 15:26:37 +0200
In-Reply-To: <3906b0bf-a9ec-e4ac-8948-59419b126799@suse.com> (Fei Li's message
	of "Fri, 12 Oct 2018 17:42:23 +0800")
Message-ID: <874ldr2t4i.fsf@dusky.pond.sub.org>
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
Cc: Markus Armbruster <armbru@redhat.com>, quintela@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

Fei Li <fli@suse.com> writes:

> On 10/12/2018 03:56 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> On 10/11/2018 06:02 PM, Markus Armbruster wrote:
>>>> Fei Li <fli@suse.com> writes:
>>>>
>>>>> Currently, when qemu_signal_init() fails it only returns a non-zero
>>>>> value but without propagating any Error. But its callers need a
>>>>> non-null err when runs error_report_err(err), or else 0->msg occurs.
>>>> The bug is in qemu_init_main_loop():
>>>>
>>>>       ret =3D qemu_signal_init();
>>>>       if (ret) {
>>>>           return ret;
>>>>       }
>>>>
>>>> Fails without setting an error, unlike the other failures.  Its callers
>>>> crash then.
>>> Thanks!
>> Consider working that into your commit message.
> Ok. I'd like to reword as follows:
> Currently in qemu_init_main_loop(), qemu_signal_init() fails without
> setting an error
> like the other failures. Its callers crash then when runs
> error_report_err(err).

Polishing the English a bit:

  When qemu_signal_init() fails in qemu_init_main_loop(), we return
  without setting an error.  Its callers crash then when they try to
  report the error with error_report_err().

>>
>>>>> To avoid such segmentation fault, add a new Error parameter to make
>>>>> the call trace to propagate the err to the final caller.
>>>>>
>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>> ---
>>>>>    include/qemu/osdep.h | 2 +-
>>>>>    util/compatfd.c      | 9 ++++++---
>>>>>    util/main-loop.c     | 9 ++++-----
>>>>>    3 files changed, 11 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>>>> index 4f8559e550..f1f56763a0 100644
>>>>> --- a/include/qemu/osdep.h
>>>>> +++ b/include/qemu/osdep.h
>>>>> @@ -421,7 +421,7 @@ struct qemu_signalfd_siginfo {
>>>>>                                 additional fields in the future) */
>>>>>    };
>>>>>    -int qemu_signalfd(const sigset_t *mask);
>>>>> +int qemu_signalfd(const sigset_t *mask, Error **errp);
>>>>>    void sigaction_invoke(struct sigaction *action,
>>>>>                          struct qemu_signalfd_siginfo *info);
>>>>>    #endif
>>>>> diff --git a/util/compatfd.c b/util/compatfd.c
>>>>> index 980bd33e52..d3ed890405 100644
>>>>> --- a/util/compatfd.c
>>>>> +++ b/util/compatfd.c
>>>>> @@ -16,6 +16,7 @@
>>>>>    #include "qemu/osdep.h"
>>>>>    #include "qemu-common.h"
>>>>>    #include "qemu/thread.h"
>>>>> +#include "qapi/error.h"
>>>>>      #include <sys/syscall.h>
>>>>>    @@ -65,7 +66,7 @@ static void *sigwait_compat(void *opaque)
>>>>>        }
>>>>>    }
>>>>>    -static int qemu_signalfd_compat(const sigset_t *mask)
>>>>> +static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
>>>>>    {
>>>>>        struct sigfd_compat_info *info;
>>>>>        QemuThread thread;
>>>>> @@ -73,11 +74,13 @@ static int qemu_signalfd_compat(const sigset_t *m=
ask)
>>>>>          info =3D malloc(sizeof(*info));
>>>>>        if (info =3D=3D NULL) {
>>>>> +        error_setg(errp, "Failed to allocate signalfd memory");
>>>>>            errno =3D ENOMEM;
>>>>>            return -1;
>>>>>        }
>>>>>          if (pipe(fds) =3D=3D -1) {
>>>>> +        error_setg(errp, "Failed to create signalfd pipe");
>>>>>            free(info);
>>>>>            return -1;
>>>>>        }
>>>>> @@ -94,7 +97,7 @@ static int qemu_signalfd_compat(const sigset_t *mas=
k)
>>>>>        return fds[0];
>>>>>    }
>>>>>    -int qemu_signalfd(const sigset_t *mask)
>>>>> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>>>>>    {
>>>>>    #if defined(CONFIG_SIGNALFD)
>>>>>        int ret;
>>>>> @@ -106,5 +109,5 @@ int qemu_signalfd(const sigset_t *mask)
>>>>>        }
>>>>>    #endif
>>>>>    -    return qemu_signalfd_compat(mask);
>>>>> +    return qemu_signalfd_compat(mask, errp);
>>>>>    }
>>>> I think this takes the Error conversion too far.
>>>>
>>>> qemu_signalfd() is like the signalfd() system call, only portable, and
>>>> setting FD_CLOEXEC.  In particular, it reports failure just like a
>>>> system call: it sets errno and returns -1.  I'd prefer to keep it that
>>>> way.  Instead...
>>>>
>>>>> diff --git a/util/main-loop.c b/util/main-loop.c
>>>>> index affe0403c5..9671b6d226 100644
>>>>> --- a/util/main-loop.c
>>>>> +++ b/util/main-loop.c
>>>>> @@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
>>>>>        }
>>>>>    }
>>>>>    -static int qemu_signal_init(void)
>>>>> +static int qemu_signal_init(Error **errp)
>>>>>    {
>>>>>        int sigfd;
>>>>>        sigset_t set;
>>>>> @@ -94,9 +94,8 @@ static int qemu_signal_init(void)
>>>>>        pthread_sigmask(SIG_BLOCK, &set, NULL);
>>>>>          sigdelset(&set, SIG_IPI);
>>>>> -    sigfd =3D qemu_signalfd(&set);
>>>>> +    sigfd =3D qemu_signalfd(&set, errp);
>>>>>        if (sigfd =3D=3D -1) {
>>>>> -        fprintf(stderr, "failed to create signalfd\n");
>>>>>            return -errno;
>>>>>        }
>>>>>=20=20=20=20
>>>> ... change this function so:
>>>>
>>>>          pthread_sigmask(SIG_BLOCK, &set, NULL);
>>>>              sigdelset(&set, SIG_IPI);
>>>>          sigfd =3D qemu_signalfd(&set);
>>>>          if (sigfd =3D=3D -1) {
>>>>     -        fprintf(stderr, "failed to create signalfd\n");
>>>>     +        error_setg_errno(errp, errno, "failed to create signalfd"=
);
>>>>              return -errno;
>>>>          }
>>>>
>>>> Does this make sense?
>>> Yes, it looks more concise if we only have this patch, but triggers
>>> one errno-set
>>> issue after applying patch 7/7, which adds a Error **errp parameter for
>>> qemu_thread_create() to let its callers handle the error instead of
>>> exit() directly
>>> to add the robustness.
>> I guess you're talking about the qemu_thread_create() in
>> qemu_signalfd_compat().  Correct?
> Yes.
>>
>>> For the patch series' current implementation, the=C2=A0 modified
>>> qemu_thread_create()
>>> in 7/7 patch returns a Boolean value to indicate whether it succeeds
>>> and set the
>>> error reason into the passed errp, and did not set the errno. Actually
>>> another
>>> similar errno-set issue has been talked in last patch. :)
>>> If we set the errno in future qemu_thread_create(), we need to
>>> distinguish the Linux
>>> and Windows implementation. For Linux, we can use error_setg_errno()
>>> to set errno.
>>> But for Windows, I am not sure if we can use
>>>
>>> "errno =3D GetLastError()"
>> No, that won't work.
>>
>>> to set errno, as this seems a little weird. Do you have any idea about =
this?
>>>
>>> BTW, if we have a decent errno-set way for Windows, I will adopt your a=
bove
>>> proposal for this patch.
>> According to MS docs, _beginthreadex() sets errno on failure:
>>
>>      If successful, each of these functions returns a handle to the newly
>>      created thread; however, if the newly created thread exits too
>>      quickly, _beginthread might not return a valid handle. (See the
>>      discussion in the Remarks section.) On an error, _beginthread
>>      returns -1L, and errno is set to EAGAIN if there are too many
>>      threads, to EINVAL if the argument is invalid or the stack size is
>>      incorrect, or to EACCES if there are insufficient resources (such as
>>      memory). On an error, _beginthreadex returns 0, and errno and
>>      _doserrno are set.
>>
>> https://docs.microsoft.com/cpp/c-runtime-library/reference/beginthread-b=
eginthreadex
>>
>> Looks like the current code's use of GetLastError() after
>> _beginthreadex() failure is wrong.
>>
>> Fix that, and both qemu_thread_create() implementations set errno on
>> failure, which in turn lets you make qemu_signalfd_compat() and thus
>> qemu_signalfd() behave sanely regardless of which qemu_thread_create()
>> implementation they use below the hood.
> Thanks for the detail explanation. :)
> To fix that, how about replacing the "GetLastError()" with the returned
> value "hThread" (actually returns 0)? I mean
> =C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 hThread =3D (HANDLE) _beginthreadex(NULL, 0, win32_sta=
rt_routine,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data, 0, &thread->tid);
> =C2=A0=C2=A0=C2=A0 if (!hThread) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->mode !=3D QEMU_THREA=
D_DETACHED) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Delete=
CriticalSection(&data->cs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_win32(errp, hThread,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "f=
ailed to create win32_start_routine");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0 }

No.  On failure, _beginthreadex() returns *zero*, not an error code.  It
also sets errno.  That's the error code you need to use:

    hThread =3D (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                      data, 0, &thread->tid);
    if (!hThread) {
        error_setg_errno(errp, errno, "can't create thread");
    }

Except I really wouldn't convert qemu_thread_create() to Error!  I'd
make it return zero on success, a negative errno code on failure, and
leave the Error business to its callers.  Basically, replace
error_exit(err, ...) by return err.

The caller qemu_signalfd_compat() can then do

    ret =3D qemu_thread_create(&thread, "signalfd_compat",
                             sigwait_compat, info, QEMU_THREAD_DETACHED);
    if (ret < 0) {
        errno =3D ret;
        return -1;
    }

A caller that already has an Error **errp parameter could do

    ret =3D qemu_thread_create(...);
    if (ret < 0) {
        error_setg_errno(errp, -ret, "<error message goes here>");
    }

Callers that want to continue aborting on failure simply do

    ret =3D qemu_thread_create(...);
    assert(ret >=3D 0);

If that turns out to be too much of a bother, you could create a
convenience wrapper for it:

    void qemu_thread_create_nofail(QemuThread *thread, const char *name,
                                   void *(*start_routine)(void*),
                                   void *arg, int mode)
    {
        int err =3D qemu_thread_create(thread, name, start_routine, arg, mo=
de);
        if (err) {
            error_exit(err, __func__);
        }
    }
