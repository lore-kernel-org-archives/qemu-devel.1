Received: from eggs.gnu.org ([209.51.188.92]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghaKW-0004Q8-Gm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghaKU-0004Cu-83
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:25:04 -0500
Received: from m50-112.126.com ([123.125.50.112]:58539)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghaKS-00047H-SX
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:25:02 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
	<5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
	<87pnt7awhg.fsf@dusky.pond.sub.org>
	<cc1bec76-7724-2d0d-733c-e84f029776e4@126.com>
	<87o98pdfbf.fsf@dusky.pond.sub.org>
	<7A219BBE-8D9D-4B40-892E-AA48D22F5967@126.com>
	<87tvig7tsu.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <016ae7bc-6271-59a7-36a1-c2b8a210020f@126.com>
Date: Thu, 10 Jan 2019 21:24:54 +0800
MIME-Version: 1.0
In-Reply-To: <87tvig7tsu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 16/16] qemu_thread_join: fix
 segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, shirley17fei@gmail.com


在 2019/1/10 下午5:20, Markus Armbruster 写道:
> fei <lifei1214@126.com> writes:
>
>>> 在 2019年1月9日，23:24，Markus Armbruster <armbru@redhat.com> 写道：
>>>
>>> Fei Li <lifei1214@126.com> writes:
>>>
>>>>> 在 2019/1/9 上午1:29, Markus Armbruster 写道:
>>>>> fei <lifei1214@126.com> writes:
>>>>>
>>>>>>> 在 2019年1月8日，01:55，Markus Armbruster <armbru@redhat.com> 写道：
>>>>>>>
>>>>>>> Fei Li <fli@suse.com> writes:
>>>>>>>
>>>>>>>> To avoid the segmentation fault in qemu_thread_join(), just directly
>>>>>>>> return when the QemuThread *thread failed to be created in either
>>>>>>>> qemu-thread-posix.c or qemu-thread-win32.c.
>>>>>>>>
>>>>>>>> Cc: Stefan Weil <sw@weilnetz.de>
>>>>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>>>>> ---
>>>>>>>> util/qemu-thread-posix.c | 3 +++
>>>>>>>> util/qemu-thread-win32.c | 2 +-
>>>>>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>>>>>> index 39834b0551..3548935dac 100644
>>>>>>>> --- a/util/qemu-thread-posix.c
>>>>>>>> +++ b/util/qemu-thread-posix.c
>>>>>>>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>>>>>>>      int err;
>>>>>>>>      void *ret;
>>>>>>>>
>>>>>>>> +    if (!thread->thread) {
>>>>>>>> +        return NULL;
>>>>>>>> +    }
>>>>>>> How can this happen?
>>>>>> I think I have answered this earlier, please check the following link to see whether it helps:
>>>>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html
>>>>> Thanks for the pointer.  Unfortunately, I don't understand your
>>>>> explanation.  You also wrote there "I will remove this patch in next
>>>>> version"; looks like you've since changed your mind.
>>>> Emm, issues left over from history.. The background is I was hurry to
>>>> make those five
>>>> Reviewed-by patches be merged, including this v9 16/16 patch but not
>>>> the real
>>>> qemu_thread_create() modification. But actually this patch is to fix
>>>> the segmentation
>>>> fault after we modified qemu_thread_create() related functions
>>>> although it has got a
>>>> Reviewed-by earlier. :) Thus to not make troube, I wrote the
>>>> "remove..." sentence
>>>> to separate it from those 5 Reviewed-by patches, and were plan to send
>>>> only four patches.
>>>> But later I got a message that these five patches are not that urgent
>>>> to catch qemu v3.1,
>>>> thus I joined the earlier 5 R-b patches into the later v8 & v9 to have
>>>> a better review.
>>>>
>>>> Sorry for the trouble, I need to explain it without involving too much
>>>> background..
>>>>
>>>> Back at the farm: in our current qemu code, some cleanups use a loop
>>>> to join()
>>>> the total number of threads if caller fails. This is not a problem
>>>> until applying the
>>>> qemu_thread_create() modification. E.g. when compress_threads_save_setup()
>>>> fails while trying to create the last do_data_compress thread,
>>>> segmentation fault
>>>> will occur when join() is called (sadly there's not enough condition
>>>> to filter this
>>>> unsuccessful created thread) as this thread is actually not be created.
>>>>
>>>> Hope the above makes it clear. :)
>>> Alright, let's have a look at compress_threads_save_setup():
>>>
>>>     static int compress_threads_save_setup(void)
>>>     {
>>>         int i, thread_count;
>>>
>>>         if (!migrate_use_compression()) {
>>>             return 0;
>>>         }
>>>         thread_count = migrate_compress_threads();
>>>         compress_threads = g_new0(QemuThread, thread_count);
>>>         comp_param = g_new0(CompressParam, thread_count);
>>>         qemu_cond_init(&comp_done_cond);
>>>         qemu_mutex_init(&comp_done_lock);
>>>         for (i = 0; i < thread_count; i++) {
>>>             comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
>>>             if (!comp_param[i].originbuf) {
>>>                 goto exit;
>>>             }
>>>
>>>             if (deflateInit(&comp_param[i].stream,
>>>                             migrate_compress_level()) != Z_OK) {
>>>                 g_free(comp_param[i].originbuf);
>>>                 goto exit;
>>>             }
>>>
>>>             /* comp_param[i].file is just used as a dummy buffer to save data,
>>>              * set its ops to empty.
>>>              */
>>>             comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
>>>             comp_param[i].done = true;
>>>             comp_param[i].quit = false;
>>>             qemu_mutex_init(&comp_param[i].mutex);
>>>             qemu_cond_init(&comp_param[i].cond);
>>>             qemu_thread_create(compress_threads + i, "compress",
>>>                                do_data_compress, comp_param + i,
>>>                                QEMU_THREAD_JOINABLE);
>>>         }
>>>         return 0;
>>>
>>>     exit:
>>>         compress_threads_save_cleanup();
>>>         return -1;
>>>     }
>>>
>>> At label exit, we have @i threads, all fully initialized.  That's an
>>> invariant.
>>>
>>> compress_threads_save_cleanup() finds the threads to clean up by
>>> checking comp_param[i].file:
>>>
>>>     static void compress_threads_save_cleanup(void)
>>>     {
>>>         int i, thread_count;
>>>
>>>         if (!migrate_use_compression() || !comp_param) {
>>>             return;
>>>         }
>>>
>>>         thread_count = migrate_compress_threads();
>>>         for (i = 0; i < thread_count; i++) {
>>>             /*
>>>              * we use it as a indicator which shows if the thread is
>>>              * properly init'd or not
>>>              */
>>> --->        if (!comp_param[i].file) {
>>> --->            break;
>>> --->        }
>>>
>>>             qemu_mutex_lock(&comp_param[i].mutex);
>>>             comp_param[i].quit = true;
>>>             qemu_cond_signal(&comp_param[i].cond);
>>>             qemu_mutex_unlock(&comp_param[i].mutex);
>>>
>>>             qemu_thread_join(compress_threads + i);
>>>             qemu_mutex_destroy(&comp_param[i].mutex);
>>>             qemu_cond_destroy(&comp_param[i].cond);
>>>             deflateEnd(&comp_param[i].stream);
>>>             g_free(comp_param[i].originbuf);
>>>             qemu_fclose(comp_param[i].file);
>>>             comp_param[i].file = NULL;
>>>         }
>>>         qemu_mutex_destroy(&comp_done_lock);
>>>         qemu_cond_destroy(&comp_done_cond);
>>>         g_free(compress_threads);
>>>         g_free(comp_param);
>>>         compress_threads = NULL;
>>>         comp_param = NULL;
>>>     }
>>>
>>> Due to the invariant, a comp_param[i] with a null .file doesn't need
>>> *any* cleanup.
>>>
>>> To maintain the invariant, compress_threads_save_setup() carefully
>>> cleans up any partial initializations itself before a goto exit.  Since
>>> the code is arranged smartly, the only such cleanup is the
>>> g_free(comp_param[i].originbuf) before the second goto exit.
>>>
>>> Your PATCH 13 adds a third goto exit, but neglects to clean up partial
>>> initializations.  Breaks the invariant.
>>>
>>> I see two sane solutions:
>>>
>>> 1. compress_threads_save_setup() carefully cleans up partial
>>>    initializations itself.  compress_threads_save_cleanup() copes only
>>>    with fully initialized comp_param[i].  This is how things work before
>>>    your series.
>>>
>>> 2. compress_threads_save_cleanup() copes with partially initialized
>>>    comp_param[i], i.e. does the right thing for each goto exit in
>>>    compress_threads_save_setup().  compress_threads_save_setup() doesn't
>>>    clean up partial initializations.
>>>
>>> Your PATCH 13 together with the fixup PATCH 16 does
>>>
>>> 3. A confusing mix of the two.
>>>
>>> Don't.
>> Thanks for the detail analysis! :)
>> Emm.. Actually I have thought to do the cleanup in the setup() function for the third ‘goto exit’ [1],  which is a partial initialization.
>> But due to the below [1] is too long and seems not neat (I notice that most cleanups for each thread are in the xxx_cleanup() function), I turned to modify the join() function..
>> Is the long [1] acceptable when the third ‘goto exit’ is called, or is there any other better way to do the cleanup?
>>
>> [1]
>> qemu_mutex_lock(&comp_param[i].mutex);
>>             comp_param[i].quit = true;
>>             qemu_cond_signal(&comp_param[i].cond);
>>             qemu_mutex_unlock(&comp_param[i].mutex);
>>
>> qemu_mutex_destroy(&comp_param[i].mutex);
>>             qemu_cond_destroy(&comp_param[i].cond);
>>             deflateEnd(&comp_param[i].stream);
>>             g_free(comp_param[i].originbuf);
>>             qemu_fclose(comp_param[i].file);
>>             comp_param[i].file = NULL;
> Have you considered creating the thread earlier, e.g. right after
> initializing compression with deflateInit()?
I am afraid we can not do this, as the members of comp_param[i], like 
file/done/quit/mutex/cond
will be used later in the new created thread: do_data_[de]compress via 
qemu_thread_create().


Thus it seems we have to accept the above long [1] if we do want to 
clean up partial initialization
in xxx_setup(). :(

BTW, there is no other argument can be used except the 
"(compress_threads+i)->thread" to
differentiate whether should we join() the thread, just in case we want 
to change the
xxx_cleanup() function.

  *


  *



Have a nice day, thanks
Fei
