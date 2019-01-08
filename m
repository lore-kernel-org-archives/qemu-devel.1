Received: from eggs.gnu.org ([209.51.188.92]:38485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtjR-0005cq-JX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtjQ-0001za-7W
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:55:57 -0500
Received: from m15-111.126.com ([220.181.15.111]:42418)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtjM-0001UA-Rn
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:55:56 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87lg3wmln8.fsf@dusky.pond.sub.org>
Date: Tue, 8 Jan 2019 23:55:37 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DCFD2A7-85F6-42ED-8CBB-B42B6605BE6F@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-7-fli@suse.com>
	<87lg3wmln8.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 06/16] qemu_thread: Make
 qemu_thread_create() handle errors properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Paolo Bonzini <pbonzini@redhat.com>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:18=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> qemu_thread_create() abort()s on error. Not nice. Give it a return
>> value and an Error ** argument, so it can return success/failure.
>>=20
>> Considering qemu_thread_create() is quite widely used in qemu, split
>> this into two steps: this patch passes the &error_abort to
>> qemu_thread_create() everywhere, and the next 9 patches will improve
>> on &error_abort for callers who need.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>=20
> The commit message's title promises more than the patch delivers.
> Suggest:
>=20
>    qemu_thread: Make qemu_thread_create() take Error ** argument
Ok, thanks for the suggestion. :)
>=20
> The rest of the commit message is fine.
>=20
>> ---
>> cpus.c                      | 23 +++++++++++++++--------
>> dump.c                      |  3 ++-
>> hw/misc/edu.c               |  4 +++-
>> hw/ppc/spapr_hcall.c        |  4 +++-
>> hw/rdma/rdma_backend.c      |  3 ++-
>> hw/usb/ccid-card-emulated.c |  5 +++--
>> include/qemu/thread.h       |  4 ++--
>> io/task.c                   |  3 ++-
>> iothread.c                  |  3 ++-
>> migration/migration.c       | 11 ++++++++---
>> migration/postcopy-ram.c    |  4 +++-
>> migration/ram.c             | 12 ++++++++----
>> migration/savevm.c          |  3 ++-
>> tests/atomic_add-bench.c    |  3 ++-
>> tests/iothread.c            |  2 +-
>> tests/qht-bench.c           |  3 ++-
>> tests/rcutorture.c          |  3 ++-
>> tests/test-aio.c            |  2 +-
>> tests/test-rcu-list.c       |  3 ++-
>> ui/vnc-jobs.c               |  6 ++++--
>> util/compatfd.c             |  6 ++++--
>> util/oslib-posix.c          |  3 ++-
>> util/qemu-thread-posix.c    | 27 ++++++++++++++++++++-------
>> util/qemu-thread-win32.c    | 16 ++++++++++++----
>> util/rcu.c                  |  3 ++-
>> util/thread-pool.c          |  4 +++-
>> 26 files changed, 112 insertions(+), 51 deletions(-)
>>=20
>> diff --git a/cpus.c b/cpus.c
>> index 0ddeeefc14..25df03326b 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1961,15 +1961,17 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>>                  cpu->cpu_index);
>>=20
>> +            /* TODO: let the callers handle the error instead of abort()=
 here */
>>             qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thr=
ead_fn,
>> -                               cpu, QEMU_THREAD_JOINABLE);
>> +                               cpu, QEMU_THREAD_JOINABLE, &error_abort);=

>>=20
>>         } else {
>>             /* share a single thread for all cpus with TCG */
>>             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");=

>> +            /* TODO: let the callers handle the error instead of abort()=
 here */
>>             qemu_thread_create(cpu->thread, thread_name,
>>                                qemu_tcg_rr_cpu_thread_fn,
>> -                               cpu, QEMU_THREAD_JOINABLE);
>> +                               cpu, QEMU_THREAD_JOINABLE, &error_abort);=

>>=20
>>             single_tcg_halt_cond =3D cpu->halt_cond;
>>             single_tcg_cpu_thread =3D cpu->thread;
>=20
> You add this TODO comment to 24 out of 37 calls.  Can you give your
> reasons for adding it to some calls, but not to others?
For those have TODO, I polish them in the next following patches, and for th=
ose do not have TODO I just let them use &error_abort.
>=20
> [...]
>> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
>> index 55d83a907c..12291f4ccd 100644
>> --- a/include/qemu/thread.h
>> +++ b/include/qemu/thread.h
>> @@ -152,9 +152,9 @@ void qemu_event_reset(QemuEvent *ev);
>> void qemu_event_wait(QemuEvent *ev);
>> void qemu_event_destroy(QemuEvent *ev);
>>=20
>> -void qemu_thread_create(QemuThread *thread, const char *name,
>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>>                         void *(*start_routine)(void *),
>> -                        void *arg, int mode);
>> +                        void *arg, int mode, Error **errp);
>> void *qemu_thread_join(QemuThread *thread);
>> void qemu_thread_get_self(QemuThread *thread);
>> bool qemu_thread_is_self(QemuThread *thread);
> [...]
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 865e476df5..39834b0551 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -15,6 +15,7 @@
>> #include "qemu/atomic.h"
>> #include "qemu/notify.h"
>> #include "qemu-thread-common.h"
>> +#include "qapi/error.h"
>>=20
>> static bool name_threads;
>>=20
>> @@ -500,9 +501,13 @@ static void *qemu_thread_start(void *args)
>>     return r;
>> }
>>=20
>> -void qemu_thread_create(QemuThread *thread, const char *name,
>> -                       void *(*start_routine)(void*),
>> -                       void *arg, int mode)
>> +/*
>> + * Return a boolean: true/false to indicate whether it succeeds.
>> + * If fails, propagate the error to Error **errp and set the errno.
>> + */
>=20
> Let's write something that can pass as a function contract:
>=20
>   /*
>    * Create a new thread with name @name
>    * The thread executes @start_routine() with argument @arg.
>    * The thread will be created in a detached state if @mode is
>    * QEMU_THREAD_DETACHED, and in a jounable state if it's
>    * QEMU_THREAD_JOINABLE.
>    * On success, return true.
>    * On failure, set @errno, store an error through @errp and return
>    * false.
>    */
Thanks so much for amending! :)
> Personally, I'd return negative errno instead of false, and dispense
> with setting errno.
Emm, I think I have replied this in last version, but due to several reasons=
 I did not wait for your feedback and sent the v9. Sorry for that.. And I li=
ke to paste my two considerations here:
=E2=80=9C- Actually only one caller needs the errno, that is the above qemu_=
signalfd_compat().=20
- For the returning value, I remember there's once a email thread talking ab=
out it: returning a bool (and let the passed errp hold the error message) is=
 to keep the consistency with glib.
=E2=80=9D
So IMO I am wondering whether it is really needed to change the bool (true/f=
alse) to int (0/-errno), just for that sole function: qemu_signalfd_compat()=
 which needs the errno. Besides if we return -errno, for each caller we need=
 add a local variable like =E2=80=9Cret=3D qemu_thread_create()=E2=80=9D to s=
tore the -errno.

Have a nice day, thanks
Fei
>=20
>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>> +                        void *(*start_routine)(void *),
>> +                        void *arg, int mode, Error **errp)
>> {
>>     sigset_t set, oldset;
>>     int err;
>> @@ -511,7 +516,9 @@ void qemu_thread_create(QemuThread *thread, const cha=
r *name,
>>=20
>>     err =3D pthread_attr_init(&attr);
>>     if (err) {
>> -        error_exit(err, __func__);
>> +        errno =3D err;
>> +        error_setg_errno(errp, errno, "pthread_attr_init failed");
>> +        return false;
>>     }
>>=20
>>     if (mode =3D=3D QEMU_THREAD_DETACHED) {
>> @@ -529,13 +536,19 @@ void qemu_thread_create(QemuThread *thread, const c=
har *name,
>>=20
>>     err =3D pthread_create(&thread->thread, &attr,
>>                          qemu_thread_start, qemu_thread_args);
>> -
>> -    if (err)
>> -        error_exit(err, __func__);
>> +    if (err) {
>> +        errno =3D err;
>> +        error_setg_errno(errp, errno, "pthread_create failed");
>> +        pthread_attr_destroy(&attr);
>> +        g_free(qemu_thread_args->name);
>> +        g_free(qemu_thread_args);
>> +        return false;
>> +    }
>>=20
>>     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
>>=20
>>     pthread_attr_destroy(&attr);
>> +    return true;
>> }
>>=20
>> void qemu_thread_get_self(QemuThread *thread)
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index 4a363ca675..57b1143e97 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -20,6 +20,7 @@
>> #include "qemu/thread.h"
>> #include "qemu/notify.h"
>> #include "qemu-thread-common.h"
>> +#include "qapi/error.h"
>> #include <process.h>
>>=20
>> static bool name_threads;
>> @@ -388,9 +389,9 @@ void *qemu_thread_join(QemuThread *thread)
>>     return ret;
>> }
>>=20
>> -void qemu_thread_create(QemuThread *thread, const char *name,
>> -                       void *(*start_routine)(void *),
>> -                       void *arg, int mode)
>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>> +                        void *(*start_routine)(void *),
>> +                        void *arg, int mode, Error **errp)
>> {
>>     HANDLE hThread;
>>     struct QemuThreadData *data;
>> @@ -409,10 +410,17 @@ void qemu_thread_create(QemuThread *thread, const c=
har *name,
>>     hThread =3D (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
>>                                       data, 0, &thread->tid);
>>     if (!hThread) {
>> -        error_exit(GetLastError(), __func__);
>> +        if (data->mode !=3D QEMU_THREAD_DETACHED) {
>> +            DeleteCriticalSection(&data->cs);
>> +        }
>> +        error_setg_errno(errp, errno,
>> +                         "failed to create win32_start_routine");
>> +        g_free(data);
>> +        return false;
>>     }
>>     CloseHandle(hThread);
>>     thread->data =3D data;
>> +    return true;
>> }
>>=20
>> void qemu_thread_get_self(QemuThread *thread)
> [...]
