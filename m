Received: from eggs.gnu.org ([209.51.188.92]:51795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gqHpZ-0004Ne-4l
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 08:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gqHgU-0000jA-8l
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 08:19:44 -0500
Received: from m50-111.126.com ([123.125.50.111]:51744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gqHgR-0000d4-Kg
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 08:19:41 -0500
References: <20190201052551.53359-1-lifei1214@126.com>
	<87va234kkh.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <8566f644-6dc6-4a70-8c45-3c8dcfad46ac@126.com>
Date: Sun, 3 Feb 2019 21:19:24 +0800
MIME-Version: 1.0
In-Reply-To: <87va234kkh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 11/11] qemu_thread: supplement
 error handling for touch_all_pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Paolo Bonzini <pbonzini@redhat.com>


ÔÚ 2019/2/1 ÏÂÎç11:03, Markus Armbruster Ð´µÀ:
> Cc: Paolo for preexisting issues due to commit 1e356fc14be.
>
> Fei Li <lifei1214@126.com> writes:
>
>> From: Fei Li <fli@suse.com>
>>
>> Supplement the error handling for touch_all_pages: add an Error
>> parameter for it to propagate the error to its caller to do the
>> handling in case it fails.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   util/oslib-posix.c | 26 ++++++++++++++++----------
>>   1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index b6c2ee270d..b4dd3d8970 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
> Some context we'll need below:
>
>     static void sigbus_handler(int signal)
>     {
>         int i;
>         if (memset_thread) {
>             for (i = 0; i < memset_num_threads; i++) {
>                 if (qemu_thread_is_self(&memset_thread[i].pgthread)) {
>                     siglongjmp(memset_thread[i].env, 1);
>                 }
>             }
>         }
>     }
>
> Preexisting, not this patch's business: touch_all_pages() sets
> @memset_num_threads to the number of desired threads, then leisurely
> populates memset_thread[], starting threads as it goes.  If one of these
> threads catches SIGBUS before memset_thread[] is completely populated,
> memset_thread[i].pgthread can be null here.  qemu_thread_is_self()
> dereferences it.  Oops.
Ok,
>
> Note there's a time window between qemu_thread_create() starting the
> thread and storing it in memset_thread[i].pgthread.  Any fix will have
> to work even when the thread catches SIGBUS within that time window.
>
>     static void *do_touch_pages(void *arg)
>     {
>         MemsetThread *memset_args = (MemsetThread *)arg;
>         sigset_t set, oldset;
>
>         /* unblock SIGBUS */
>         sigemptyset(&set);
>         sigaddset(&set, SIGBUS);
>         pthread_sigmask(SIG_UNBLOCK, &set, &oldset);
>
>         if (sigsetjmp(memset_args->env, 1)) {
>             memset_thread_failed = true;
>         } else {
> [...]
>         }
>         pthread_sigmask(SIG_SETMASK, &oldset, NULL);
>         return NULL;
>     }
>
> We set @memset_thread_failed on SIGBUS in a memset thread.
Ok, thanks for the detail explanation.
>
>> @@ -435,7 +435,7 @@ static inline int get_memset_num_threads(int smp_cpus)
>>   }
>>   
>>   static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>> -                            int smp_cpus)
>> +                            int smp_cpus, Error **errp)
>>   {
>>       size_t numpages_per_thread;
>>       size_t size_per_thread;
>         char *addr = area;
>         int i = 0;
>
>         memset_thread_failed = false;
>
> We clear @memset_thread_failed before we create the memset threads.
>
> Preexisting, not this patch's business: use of global state without
> synchronization leaves touch_all_pages() and thus os_mem_prealloc() not
> thread-safe.  Even when that's just fine, it warrants at least a big fat
> comment, and ideally assertions to catch misuse.
>
>         memset_num_threads = get_memset_num_threads(smp_cpus);
>         memset_thread = g_new0(MemsetThread, memset_num_threads);
>         numpages_per_thread = (numpages / memset_num_threads);
>         size_per_thread = (hpagesize * numpages_per_thread);
>         for (i = 0; i < memset_num_threads; i++) {
>             memset_thread[i].addr = addr;
>> @@ -452,20 +452,29 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>>           memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
>>                                       numpages : numpages_per_thread;
>>           memset_thread[i].hpagesize = hpagesize;
>> -        /* TODO: let the callers handle the error instead of abort() here */
>> -        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
>> -                           do_touch_pages, &memset_thread[i],
>> -                           QEMU_THREAD_JOINABLE, &error_abort);
>> +        if (qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
>> +                               do_touch_pages, &memset_thread[i],
>> +                               QEMU_THREAD_JOINABLE, errp) < 0) {
>> +            memset_thread_failed = true;
> We set @memset_thread_failed when creating a memset thread fails.  @errp
> contains an error then.
>
>> +            break;
>> +        }
>>           addr += size_per_thread;
>>           numpages -= numpages_per_thread;
>>       }
>> +
>> +    memset_num_threads = i;
>>       for (i = 0; i < memset_num_threads; i++) {
>>           qemu_thread_join(&memset_thread[i].pgthread);
>>       }
>>       g_free(memset_thread);
>>       memset_thread = NULL;
>>   
>> -    return memset_thread_failed;
>> +    if (memset_thread_failed) {
>> +        error_append_hint(errp, "os_mem_prealloc: Insufficient free host "
>> +                          "memory pages available to allocate guest RAM");
>> +        return false;
> @memset_thread_failed is true when creating a memset thread failed, or a
> memset thread caught SIGBUS.
>
> @errp contains an error only if the former is the case.
>
> If we succeeded in creating all threads, but got SIGBUS, @errp is null,
> and error_append_hint() does nothing.  touch_all_pages() then fails
> without setting an error.
>
> Suggested fix: drop the memset_thread_failed = true on thread creation
> failure, and do something like
>
>         for (j = 0; j < i; j++) {
>             qemu_thread_join(&memset_thread[i].pgthread);
[j]
>         }
>         g_free(memset_thread);
>         memset_thread = NULL;
>
>         if (i < memset_num_threads) {
>             /* qemu_thread_create() has set @errp */
>             return false;
>         }
>
>         if (memset_thread_failed) {
>             error_setg(errp, "os_mem_prealloc: Insufficient free host "
>                        "memory pages available to allocate guest RAM");
>             return false;
Agree.
>> +    }
>> +    return true;
>>   }
> One more remark: when creating the N-th thread fails, we patiently wait
> for thread 0..N-1 to complete their job.  I guess that's tolerable.  If
> we want it to fail quickly, we'd need a way to tell the threads to
> abandon the job.  Perhaps sending a SIGBUS would do.
Have a nice day, thanks
Fei
>>   
>>   void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>> @@ -488,10 +497,7 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>>       }
>>   
>>       /* touch pages simultaneously */
>> -    if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
>> -        error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
>> -            "pages available to allocate guest RAM");
>> -    }
>> +    touch_all_pages(area, hpagesize, numpages, smp_cpus, errp);
>>   
>>       ret = sigaction(SIGBUS, &oldact, NULL);
>>       if (ret) {
