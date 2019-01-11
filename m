Received: from eggs.gnu.org ([209.51.188.92]:45095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghxNX-0000cW-03
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghxNQ-0003EU-0H
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:01:42 -0500
Received: from m50-110.126.com ([123.125.50.110]:53534)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghxNL-0002T4-91
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:01:34 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
	<5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
	<87pnt7awhg.fsf@dusky.pond.sub.org>
	<cc1bec76-7724-2d0d-733c-e84f029776e4@126.com>
	<87o98pdfbf.fsf@dusky.pond.sub.org>
	<7A219BBE-8D9D-4B40-892E-AA48D22F5967@126.com>
	<87tvig7tsu.fsf@dusky.pond.sub.org>
	<016ae7bc-6271-59a7-36a1-c2b8a210020f@126.com>
	<87tvigfqfb.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <1d097d66-775b-3a9e-ded8-15e3bc31f563@126.com>
Date: Fri, 11 Jan 2019 22:01:10 +0800
MIME-Version: 1.0
In-Reply-To: <87tvigfqfb.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org


在 2019/1/11 上午12:06, Markus Armbruster 写道:
> Fei Li <lifei1214@126.com> writes:
>
>> 在 2019/1/10 下午5:20, Markus Armbruster 写道:
>>> fei <lifei1214@126.com> writes:
>>>
>>>>> 在 2019年1月9日，23:24，Markus Armbruster <armbru@redhat.com> 写道：
>>>>>
>>>>> Fei Li <lifei1214@126.com> writes:
>>>>>
>>>>>>> 在 2019/1/9 上午1:29, Markus Armbruster 写道:
>>>>>>> fei <lifei1214@126.com> writes:
>>>>>>>
>>>>>>>>> 在 2019年1月8日，01:55，Markus Armbruster <armbru@redhat.com> 写道：
>>>>>>>>>
>>>>>>>>> Fei Li <fli@suse.com> writes:
>>>>>>>>>
>>>>>>>>>> To avoid the segmentation fault in qemu_thread_join(), just directly
>>>>>>>>>> return when the QemuThread *thread failed to be created in either
>>>>>>>>>> qemu-thread-posix.c or qemu-thread-win32.c.
>>>>>>>>>>
>>>>>>>>>> Cc: Stefan Weil <sw@weilnetz.de>
>>>>>>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>>>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>> util/qemu-thread-posix.c | 3 +++
>>>>>>>>>> util/qemu-thread-win32.c | 2 +-
>>>>>>>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>>>>>>>> index 39834b0551..3548935dac 100644
>>>>>>>>>> --- a/util/qemu-thread-posix.c
>>>>>>>>>> +++ b/util/qemu-thread-posix.c
>>>>>>>>>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>>>>>>>>>       int err;
>>>>>>>>>>       void *ret;
>>>>>>>>>>
>>>>>>>>>> +    if (!thread->thread) {
>>>>>>>>>> +        return NULL;
>>>>>>>>>> +    }
>>>>>>>>> How can this happen?
>>>>>>>> I think I have answered this earlier, please check the following link to see whether it helps:
>>>>>>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html
>>>>>>> Thanks for the pointer.  Unfortunately, I don't understand your
>>>>>>> explanation.  You also wrote there "I will remove this patch in next
>>>>>>> version"; looks like you've since changed your mind.
>>>>>> Emm, issues left over from history.. The background is I was hurry to
>>>>>> make those five
>>>>>> Reviewed-by patches be merged, including this v9 16/16 patch but not
>>>>>> the real
>>>>>> qemu_thread_create() modification. But actually this patch is to fix
>>>>>> the segmentation
>>>>>> fault after we modified qemu_thread_create() related functions
>>>>>> although it has got a
>>>>>> Reviewed-by earlier. :) Thus to not make troube, I wrote the
>>>>>> "remove..." sentence
>>>>>> to separate it from those 5 Reviewed-by patches, and were plan to send
>>>>>> only four patches.
>>>>>> But later I got a message that these five patches are not that urgent
>>>>>> to catch qemu v3.1,
>>>>>> thus I joined the earlier 5 R-b patches into the later v8 & v9 to have
>>>>>> a better review.
>>>>>>
>>>>>> Sorry for the trouble, I need to explain it without involving too much
>>>>>> background..
>>>>>>
>>>>>> Back at the farm: in our current qemu code, some cleanups use a loop
>>>>>> to join()
>>>>>> the total number of threads if caller fails. This is not a problem
>>>>>> until applying the
>>>>>> qemu_thread_create() modification. E.g. when compress_threads_save_setup()
>>>>>> fails while trying to create the last do_data_compress thread,
>>>>>> segmentation fault
>>>>>> will occur when join() is called (sadly there's not enough condition
>>>>>> to filter this
>>>>>> unsuccessful created thread) as this thread is actually not be created.
>>>>>>
>>>>>> Hope the above makes it clear. :)
>>>>> Alright, let's have a look at compress_threads_save_setup():
>>>>>
>>>>>      static int compress_threads_save_setup(void)
>>>>>      {
>>>>>          int i, thread_count;
>>>>>
>>>>>          if (!migrate_use_compression()) {
>>>>>              return 0;
>>>>>          }
>>>>>          thread_count = migrate_compress_threads();
>>>>>          compress_threads = g_new0(QemuThread, thread_count);
>>>>>          comp_param = g_new0(CompressParam, thread_count);
>>>>>          qemu_cond_init(&comp_done_cond);
>>>>>          qemu_mutex_init(&comp_done_lock);
>>>>>          for (i = 0; i < thread_count; i++) {
>>>>>              comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
>>>>>              if (!comp_param[i].originbuf) {
>>>>>                  goto exit;
>>>>>              }
>>>>>
>>>>>              if (deflateInit(&comp_param[i].stream,
>>>>>                              migrate_compress_level()) != Z_OK) {
>>>>>                  g_free(comp_param[i].originbuf);
>>>>>                  goto exit;
>>>>>              }
>>>>>
>>>>>              /* comp_param[i].file is just used as a dummy buffer to save data,
>>>>>               * set its ops to empty.
>>>>>               */
>>>>>              comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
>>>>>              comp_param[i].done = true;
>>>>>              comp_param[i].quit = false;
>>>>>              qemu_mutex_init(&comp_param[i].mutex);
>>>>>              qemu_cond_init(&comp_param[i].cond);
>>>>>              qemu_thread_create(compress_threads + i, "compress",
>>>>>                                 do_data_compress, comp_param + i,
>>>>>                                 QEMU_THREAD_JOINABLE);
>>>>>          }
>>>>>          return 0;
>>>>>
>>>>>      exit:
>>>>>          compress_threads_save_cleanup();
>>>>>          return -1;
>>>>>      }
>>>>>
>>>>> At label exit, we have @i threads, all fully initialized.  That's an
>>>>> invariant.
>>>>>
>>>>> compress_threads_save_cleanup() finds the threads to clean up by
>>>>> checking comp_param[i].file:
>>>>>
>>>>>      static void compress_threads_save_cleanup(void)
>>>>>      {
>>>>>          int i, thread_count;
>>>>>
>>>>>          if (!migrate_use_compression() || !comp_param) {
>>>>>              return;
>>>>>          }
>>>>>
>>>>>          thread_count = migrate_compress_threads();
>>>>>          for (i = 0; i < thread_count; i++) {
>>>>>              /*
>>>>>               * we use it as a indicator which shows if the thread is
>>>>>               * properly init'd or not
>>>>>               */
>>>>> --->        if (!comp_param[i].file) {
>>>>> --->            break;
>>>>> --->        }
>>>>>
>>>>>              qemu_mutex_lock(&comp_param[i].mutex);
>>>>>              comp_param[i].quit = true;
>>>>>              qemu_cond_signal(&comp_param[i].cond);
>>>>>              qemu_mutex_unlock(&comp_param[i].mutex);
>>>>>
>>>>>              qemu_thread_join(compress_threads + i);
>>>>>              qemu_mutex_destroy(&comp_param[i].mutex);
>>>>>              qemu_cond_destroy(&comp_param[i].cond);
>>>>>              deflateEnd(&comp_param[i].stream);
>>>>>              g_free(comp_param[i].originbuf);
>>>>>              qemu_fclose(comp_param[i].file);
>>>>>              comp_param[i].file = NULL;
>>>>>          }
>>>>>          qemu_mutex_destroy(&comp_done_lock);
>>>>>          qemu_cond_destroy(&comp_done_cond);
>>>>>          g_free(compress_threads);
>>>>>          g_free(comp_param);
>>>>>          compress_threads = NULL;
>>>>>          comp_param = NULL;
>>>>>      }
>>>>>
>>>>> Due to the invariant, a comp_param[i] with a null .file doesn't need
>>>>> *any* cleanup.
>>>>>
>>>>> To maintain the invariant, compress_threads_save_setup() carefully
>>>>> cleans up any partial initializations itself before a goto exit.  Since
>>>>> the code is arranged smartly, the only such cleanup is the
>>>>> g_free(comp_param[i].originbuf) before the second goto exit.
>>>>>
>>>>> Your PATCH 13 adds a third goto exit, but neglects to clean up partial
>>>>> initializations.  Breaks the invariant.
>>>>>
>>>>> I see two sane solutions:
>>>>>
>>>>> 1. compress_threads_save_setup() carefully cleans up partial
>>>>>     initializations itself.  compress_threads_save_cleanup() copes only
>>>>>     with fully initialized comp_param[i].  This is how things work before
>>>>>     your series.
>>>>>
>>>>> 2. compress_threads_save_cleanup() copes with partially initialized
>>>>>     comp_param[i], i.e. does the right thing for each goto exit in
>>>>>     compress_threads_save_setup().  compress_threads_save_setup() doesn't
>>>>>     clean up partial initializations.
>>>>>
>>>>> Your PATCH 13 together with the fixup PATCH 16 does
>>>>>
>>>>> 3. A confusing mix of the two.
>>>>>
>>>>> Don't.
>>>> Thanks for the detail analysis! :)
>>>> Emm.. Actually I have thought to do the cleanup in the setup() function for the third ‘goto exit’ [1],  which is a partial initialization.
>>>> But due to the below [1] is too long and seems not neat (I notice that most cleanups for each thread are in the xxx_cleanup() function), I turned to modify the join() function..
>>>> Is the long [1] acceptable when the third ‘goto exit’ is called, or is there any other better way to do the cleanup?
>>>>
>>>> [1]
>>>> qemu_mutex_lock(&comp_param[i].mutex);
>>>>              comp_param[i].quit = true;
>>>>              qemu_cond_signal(&comp_param[i].cond);
>>>>              qemu_mutex_unlock(&comp_param[i].mutex);
>>>>
>>>> qemu_mutex_destroy(&comp_param[i].mutex);
>>>>              qemu_cond_destroy(&comp_param[i].cond);
>>>>              deflateEnd(&comp_param[i].stream);
>>>>              g_free(comp_param[i].originbuf);
>>>>              qemu_fclose(comp_param[i].file);
>>>>              comp_param[i].file = NULL;
>>> Have you considered creating the thread earlier, e.g. right after
>>> initializing compression with deflateInit()?
>> I am afraid we can not do this, as the members of comp_param[i], like
>> file/done/quit/mutex/cond
>> will be used later in the new created thread: do_data_[de]compress via
>> qemu_thread_create().
> You're right.
>
>> Thus it seems we have to accept the above long [1] if we do want to
>> clean up partial initialization
>> in xxx_setup(). :(
>>
>> BTW, there is no other argument can be used except the
>> "(compress_threads+i)->thread" to
>> differentiate whether should we join() the thread, just in case we
>> want to change the
>> xxx_cleanup() function.
> We can try to make compress_threads_save_cleanup() cope with partially
> initialized comp_param[i].  Let's have a look at its members:
>
>      bool done;                          // no cleanup
>      bool quit;                          // see [2]
>      bool zero_page;                     // no cleanup
>      QEMUFile *file;                     // qemu_fclose() if non-null
>      QemuMutex mutex;                    // see [1]
>      QemuCond cond;                      // see [1]
>      RAMBlock *block;                    // no cleanup (must be null)
>      ram_addr_t offset;                  // no cleanup
>
>      /* internally used fields */
>      z_stream stream;                    // see [3]
>      uint8_t *originbuf;                 // unconditional g_free()
>
> [1]: we could do something like
>
>      if (comp_param[i].mutex.initialized) {
>          qemu_mutex_destroy(&comp_param[i].mutex);
>      }
>      if (comp_param[i].cond.initialized) {
>          qemu_cond_destroy(&comp_param[i].cond);
>      }
>
> but that would be unclean.  Instead, I'd initialize these guys first, so
> we can clean them up unconditionally.
>
> [2] This is used to make the thread terminate.  Must be done before we
> call qemu_thread_join().  I think it can safely be done always, as long
> as long as .mutex and .cond are initialized.  Trivial if we initialize
> them first.
Thanks for the detail analysis, it helps a lot! I translate the above 
[1] & [2] to "move the
below three '+' ahead of the initialization of comp_param[i].file" for 
xxx_setup():

+        qemu_mutex_init(&comp_param[i].mutex);
+        qemu_cond_init(&comp_param[i].cond);
+        comp_param[i].quit = false;
          /* comp_param[i].file is just used as a dummy buffer to save data,
           * set its ops to empty.
           */
          comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
          comp_param[i].done = true;
          if (!qemu_thread_create(compress_threads + i, "compress",
          ...

And accordingly, do the corresponding change for the xxx_cleanup().

> [3]: I can't see a squeaky clean way to detect whether .stream has been
> initialized with deflateInit().  Here's a slightly unclean way:
> deflateInit() sets .stream.msg to null on success, and to non-null on
> failure.  We can make it non-null until we're ready to call
> deflateInit(), then have compress_threads_save_cleanup() clean up
> .stream when it's null.  If that's too unclean for your or your
> reviewers' taste, add a boolean @stream_initialized flag.

Emm, I am not sure either. Let's cc the migration maintainers to have 
their opinions.

Have a nice day, thanks for the review. :)
Fei
