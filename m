Received: from eggs.gnu.org ([209.51.188.92]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1giiRJ-0002G4-8N
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 11:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1giiRI-0003jS-E9
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 11:16:45 -0500
Received: from m50-112.126.com ([123.125.50.112]:57685)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1giiRH-0003gp-3k
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 11:16:44 -0500
From: Fei Li <lifei1214@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-13-fli@suse.com>
	<87h8ekl5l9.fsf@dusky.pond.sub.org>
	<BF248B0E-5197-4777-8CE9-F9E43B7177C3@126.com>
Message-ID: <df98f3b8-a2c8-f3d8-1bfa-3929fff61621@126.com>
Date: Mon, 14 Jan 2019 00:16:34 +0800
MIME-Version: 1.0
In-Reply-To: <BF248B0E-5197-4777-8CE9-F9E43B7177C3@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 12/16] qemu_thread: supplement
 error handling for iothread_complete/qemu_signalfd_compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com


在 2019/1/9 上午12:18, fei 写道:
>
>> 在 2019年1月8日，01:50，Markus Armbruster <armbru@redhat.com> 写道：
>>
>> Fei Li <fli@suse.com> writes:
>>
>>> For iothread_complete: utilize the existed errp to propagate the
>>> error and do the corresponding cleanup to replace the temporary
>>> &error_abort.
>>>
>>> For qemu_signalfd_compat: add a local_err to hold the error, and
>>> return the corresponding error code to replace the temporary
>>> &error_abort.
>> I'd split the patch.
> Ok.
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Fei Li <fli@suse.com>
>>> ---
>>> iothread.c      | 17 +++++++++++------
>>> util/compatfd.c | 11 ++++++++---
>>> 2 files changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/iothread.c b/iothread.c
>>> index 8e8aa01999..7335dacf0b 100644
>>> --- a/iothread.c
>>> +++ b/iothread.c
>>> @@ -164,9 +164,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
>>>                                  &local_error);
>>>      if (local_error) {
>>>          error_propagate(errp, local_error);
>>> -        aio_context_unref(iothread->ctx);
>>> -        iothread->ctx = NULL;
>>> -        return;
>>> +        goto fail;
>>>      }
>>>
>>>      qemu_mutex_init(&iothread->init_done_lock);
>>> @@ -178,9 +176,12 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
>>>       */
>>>      name = object_get_canonical_path_component(OBJECT(obj));
>>>      thread_name = g_strdup_printf("IO %s", name);
>>> -    /* TODO: let the further caller handle the error instead of abort() here */
>>> -    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
>>> -                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
>>> +    if (!qemu_thread_create(&iothread->thread, thread_name, iothread_run,
>>> +                            iothread, QEMU_THREAD_JOINABLE, errp)) {
>>> +        g_free(thread_name);
>>> +        g_free(name);
>> I suspect you're missing cleanup here:
>>
>>            qemu_cond_destroy(&iothread->init_done_cond);
>>            qemu_mutex_destroy(&iothread->init_done_lock);
> I remember I checked the code, when ucc->complete() fails, there’s a finalize() function to do the destroy.

To be specific, the qemu_xxx_destroy() is called by

object_unref() => object_finalize() => object_deinit() => 
type->instance_finalize(obj); (that is, iothread_instance_finalize).

For the iothread_complete(), it is only called in 
user_creatable_complete() as ucc->complete().
I checked the code, when callers of user_creatable_complete() fails, all 
of them will call
object_unref() to call the qemu_xxx_destroy(), except one &error_abort 
case (e.i. desugar_shm()).
> But did not test all the callers, so let’s wait for Stefan’s feedback. :)
But again, I did not do all the test. Correct me if I am wrong. :)
>> But I'm not 100% sure, to be honest.  Stefan, can you help?
>>
>>
>>> +        goto fail;
>>> +    }
>>>      g_free(thread_name);
>>>      g_free(name);
>>>
>> I'd avoid the code duplication like this:
>>
>>        thread_ok = qemu_thread_create(&iothread->thread, thread_name,
>>                                       iothread_run, iothread,
>>                                       QEMU_THREAD_JOINABLE, errp);
>>        g_free(thread_name);
>>        g_free(name);
>>        if (!thread_ok) {
>>            qemu_cond_destroy(&iothread->init_done_cond);
>>            qemu_mutex_destroy(&iothread->init_done_lock);
>>            goto fail;
>>        }

Ok, thanks.

Have a nice day
Fei
>> Matter of taste.
>>
>> Hmm, iothread.c has no maintainer.  Stefan, you created it, would you be
>> willing to serve as maintainer?
>>
