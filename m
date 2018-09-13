Received: from eggs.gnu.org ([2001:4830:134:3::10]:36992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1g0OeC-0002Cp-JF
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1g0Oe9-0008O6-6K
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:14:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:58264 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1g0Oe8-0008NK-P3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:14:49 -0400
References: <20180907133902.28462-1-fli@suse.com>
	<20180907133902.28462-5-fli@suse.com>
	<20180912082007.GF2526@lemon.usersys.redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <fb4cb7cb-d167-324a-a00b-e0c3a2ea23d0@suse.com>
Date: Thu, 13 Sep 2018 18:14:41 +0800
MIME-Version: 1.0
In-Reply-To: <20180912082007.GF2526@lemon.usersys.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qemu_thread_create: propagate the
 error to callers to handle
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



On 09/12/2018 04:20 PM, Fam Zheng wrote:
> On Fri, 09/07 21:39, Fei Li wrote:
>> Make qemu_thread_create() return a Boolean to indicate if it succeeds
>> rather than failing with an error. And add an Error parameter to hold
>> the error message and let the callers handle it.
>>
>> Besides, directly return if thread->data is NULL to avoid the
>> segmentation fault in qemu_thread_join in qemu-thread-win32.c.
> Please pay special attention to cleaning up code of the touched functions since
> you are adding new error paths to them. I haven't reviewed the full patch after
> pointing out a couple two places. Please audit the resource cleaning up more
> carefully in v3.
Ok, thanks for all the comments. Will pay special attention to the 
cleaning ups in next version.
>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   cpus.c                      | 45 +++++++++++++++++++++++++++--------------
>>   dump.c                      |  6 ++++--
>>   hw/misc/edu.c               |  6 ++++--
>>   hw/ppc/spapr_hcall.c        |  9 +++++++--
>>   hw/rdma/rdma_backend.c      |  3 ++-
>>   hw/usb/ccid-card-emulated.c | 13 ++++++++----
>>   include/qemu/thread.h       |  4 ++--
>>   io/task.c                   |  3 ++-
>>   iothread.c                  | 16 ++++++++++-----
>>   migration/migration.c       | 49 +++++++++++++++++++++++++++++++--------------
>>   migration/postcopy-ram.c    | 12 +++++++++--
>>   migration/ram.c             | 40 +++++++++++++++++++++++++++---------
>>   migration/savevm.c          | 11 +++++++---
>>   tests/atomic_add-bench.c    |  3 ++-
>>   tests/iothread.c            |  2 +-
>>   tests/qht-bench.c           |  3 ++-
>>   tests/rcutorture.c          |  3 ++-
>>   tests/test-aio.c            |  2 +-
>>   tests/test-rcu-list.c       |  3 ++-
>>   ui/vnc-jobs.c               |  8 ++++++--
>>   util/compatfd.c             |  7 +++++--
>>   util/oslib-posix.c          | 12 ++++++++---
>>   util/qemu-thread-posix.c    | 18 +++++++++++------
>>   util/qemu-thread-win32.c    | 15 +++++++++-----
>>   util/rcu.c                  |  3 ++-
>>   util/thread-pool.c          |  4 +++-
>>   26 files changed, 210 insertions(+), 90 deletions(-)
>>
...snip...
>>       return true;
>> diff --git a/util/compatfd.c b/util/compatfd.c
>> index d3ed890405..2532fa4d4d 100644
>> --- a/util/compatfd.c
>> +++ b/util/compatfd.c
>> @@ -91,8 +91,11 @@ static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
>>       memcpy(&info->mask, mask, sizeof(*mask));
>>       info->fd = fds[1];
>>   
>> -    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat, info,
>> -                       QEMU_THREAD_DETACHED);
>> +    if (!qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
>> +                            info, QEMU_THREAD_DETACHED, errp)) {
>> +        free(info);
> Clean up fds?
Thanks for pointing this out.
>
>> +        return -1;
>> +    }
>>   
>>       return fds[0];
>>   }
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 13b6f8d776..f34ba7ac9a 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -364,6 +364,7 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>>       size_t size_per_thread;
>>       char *addr = area;
>>       int i = 0;
>> +    Error *local_err = NULL;
>>   
>>       memset_thread_failed = false;
>>       memset_num_threads = get_memset_num_threads(smp_cpus);
>> @@ -375,15 +376,20 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>>           memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
>>                                       numpages : numpages_per_thread;
>>           memset_thread[i].hpagesize = hpagesize;
>> -        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
>> -                           do_touch_pages, &memset_thread[i],
>> -                           QEMU_THREAD_JOINABLE);
>> +        if (!qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
>> +                                do_touch_pages, &memset_thread[i],
>> +                                QEMU_THREAD_JOINABLE, &local_err)) {
>> +            error_reportf_err(local_err, "Failed to create do_touch_pages.");
>> +            memset_thread_failed = true;
>> +            goto out;
> Before freeing memset_thread, you need to join all spawned threads. Which means
> you have to remember the current value of i (as 'started_thread') here and ...
>
>> +        }
>>           addr += size_per_thread;
>>           numpages -= numpages_per_thread;
>>       }
> the 'out' label should be here, and the loop condition should be changed to 'i <
> started_thread'.
>
>>       for (i = 0; i < memset_num_threads; i++) {
>>           qemu_thread_join(&memset_thread[i].pgthread);
>>       }
>> +out:
> Otherwise the threads can cause use-after-free.
Right! Somehow overlooked the loop..
>
>>       g_free(memset_thread);
>>       memset_thread = NULL;
>>   
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index dfa66ff2fb..8e493bd653 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu/atomic.h"
>>   #include "qemu/notify.h"
>>   #include "qemu-thread-common.h"
>> +#include "qapi/error.h"
>>   
>>   static bool name_threads;
>>   
>> @@ -504,9 +505,9 @@ static void *qemu_thread_start(void *args)
>>       return start_routine(arg);
>>   }
>>   
>> -void qemu_thread_create(QemuThread *thread, const char *name,
>> -                       void *(*start_routine)(void*),
>> -                       void *arg, int mode)
>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>> +                        void *(*start_routine)(void *),
>> +                        void *arg, int mode, Error **errp)
>>   {
>>       sigset_t set, oldset;
>>       int err;
>> @@ -515,7 +516,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>>   
>>       err = pthread_attr_init(&attr);
>>       if (err) {
>> -        error_exit(err, __func__);
>> +        goto fail;
>>       }
>>   
>>       if (mode == QEMU_THREAD_DETACHED) {
>> @@ -534,12 +535,17 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>>       err = pthread_create(&thread->thread, &attr,
>>                            qemu_thread_start, qemu_thread_args);
>>   
>> -    if (err)
>> -        error_exit(err, __func__);
>> +    if (err) {
>> +        goto fail;
>> +    }
>>   
>>       pthread_sigmask(SIG_SETMASK, &oldset, NULL);
>>   
>>       pthread_attr_destroy(&attr);
>> +    return true;
>> +fail:
>> +    error_setg(errp, "qemu_thread_create failed: %s", strerror(err));
> It's better to do error_setg before 'goto fail', so that different error
> conditions have different error descriptions.
In this function, I think the returned value: err can be used to 
differentiate the failing reason.
Maybe just make the error_setg stay after 'goto fail' in this function? 
I will take care in other cases.
>
>> +    return false;
>>   }
>>   
>>   void qemu_thread_get_self(QemuThread *thread)
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index 4a363ca675..178a69ed40 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -20,6 +20,7 @@
>>   #include "qemu/thread.h"
>>   #include "qemu/notify.h"
>>   #include "qemu-thread-common.h"
>> +#include "qapi/error.h"
>>   #include <process.h>
>>   
>>   static bool name_threads;
>> @@ -366,7 +367,7 @@ void *qemu_thread_join(QemuThread *thread)
>>       HANDLE handle;
>>   
>>       data = thread->data;
>> -    if (data->mode == QEMU_THREAD_DETACHED) {
>> +    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {
>>           return NULL;
>>       }
>>   
> I think this could be a separate patch.
Ok, thanks for the advice.
>
>> @@ -388,9 +389,9 @@ void *qemu_thread_join(QemuThread *thread)
>>       return ret;
>>   }
>>   
>> -void qemu_thread_create(QemuThread *thread, const char *name,
>> -                       void *(*start_routine)(void *),
>> -                       void *arg, int mode)
>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>> +                        void *(*start_routine)(void *),
>> +                        void *arg, int mode, Error **errp)
>>   {
>>       HANDLE hThread;
>>       struct QemuThreadData *data;
>> @@ -409,10 +410,14 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>>       hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
>>                                         data, 0, &thread->tid);
>>       if (!hThread) {
>> -        error_exit(GetLastError(), __func__);
>> +        g_free(data);
>> +        error_setg_win32(errp, GetLastError(),
>> +                         "failed to creat win32_start_routine");
> "create".
Thanks!

Have a nice day :)
Fei
>
>> +        return false;
>>       }
>>       CloseHandle(hThread);
>>       thread->data = data;
>> +    return true;
>>   }
>>   
>>   void qemu_thread_get_self(QemuThread *thread)
>> diff --git a/util/rcu.c b/util/rcu.c
>> index 5676c22bd1..145dcdb0c6 100644
>> --- a/util/rcu.c
>> +++ b/util/rcu.c
>> @@ -32,6 +32,7 @@
>>   #include "qemu/atomic.h"
>>   #include "qemu/thread.h"
>>   #include "qemu/main-loop.h"
>> +#include "qapi/error.h"
>>   #if defined(CONFIG_MALLOC_TRIM)
>>   #include <malloc.h>
>>   #endif
>> @@ -325,7 +326,7 @@ static void rcu_init_complete(void)
>>        * must have been quiescent even after forking, just recreate it.
>>        */
>>       qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
>> -                       NULL, QEMU_THREAD_DETACHED);
>> +                       NULL, QEMU_THREAD_DETACHED, &error_abort);
>>   
>>       rcu_register_thread();
>>   }
>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>> index 610646d131..ad0f980783 100644
>> --- a/util/thread-pool.c
>> +++ b/util/thread-pool.c
>> @@ -22,6 +22,7 @@
>>   #include "trace.h"
>>   #include "block/thread-pool.h"
>>   #include "qemu/main-loop.h"
>> +#include "qapi/error.h"
>>   
>>   static void do_spawn_thread(ThreadPool *pool);
>>   
>> @@ -132,7 +133,8 @@ static void do_spawn_thread(ThreadPool *pool)
>>       pool->new_threads--;
>>       pool->pending_threads++;
>>   
>> -    qemu_thread_create(&t, "worker", worker_thread, pool, QEMU_THREAD_DETACHED);
>> +    qemu_thread_create(&t, "worker", worker_thread, pool,
>> +                       QEMU_THREAD_DETACHED, &error_abort);
>>   }
>>   
>>   static void spawn_thread_bh_fn(void *opaque)
>> -- 
>> 2.13.7
>>
>
