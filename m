Received: from eggs.gnu.org ([209.51.188.92]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj2ih-0004go-8O
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj2fu-0002n6-RX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:53:13 -0500
Received: from m50-110.126.com ([123.125.50.110]:51127)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj2ft-0002lo-Cd
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:53:10 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-13-fli@suse.com>
	<87h8ekl5l9.fsf@dusky.pond.sub.org>
	<BF248B0E-5197-4777-8CE9-F9E43B7177C3@126.com>
	<df98f3b8-a2c8-f3d8-1bfa-3929fff61621@126.com>
	<871s5fqu2r.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <faba252d-c6b3-b0ea-2b9a-1a940742f67f@126.com>
Date: Mon, 14 Jan 2019 21:52:50 +0800
MIME-Version: 1.0
In-Reply-To: <871s5fqu2r.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, shirley17fei@gmail.com


在 2019/1/14 下午8:53, Markus Armbruster 写道:
> Fei Li <lifei1214@126.com> writes:
>
>> 在 2019/1/9 上午12:18, fei 写道:
>>>> 在 2019年1月8日，01:50，Markus Armbruster <armbru@redhat.com> 写道：
>>>>
>>>> Fei Li <fli@suse.com> writes:
>>>>
>>>>> For iothread_complete: utilize the existed errp to propagate the
>>>>> error and do the corresponding cleanup to replace the temporary
>>>>> &error_abort.
>>>>>
>>>>> For qemu_signalfd_compat: add a local_err to hold the error, and
>>>>> return the corresponding error code to replace the temporary
>>>>> &error_abort.
>>>> I'd split the patch.
>>> Ok.
>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>> Cc: Eric Blake <eblake@redhat.com>
>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> ---
>>>>> iothread.c      | 17 +++++++++++------
>>>>> util/compatfd.c | 11 ++++++++---
>>>>> 2 files changed, 19 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/iothread.c b/iothread.c
>>>>> index 8e8aa01999..7335dacf0b 100644
>>>>> --- a/iothread.c
>>>>> +++ b/iothread.c
>>>>> @@ -164,9 +164,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
>>>>>                                   &local_error);
>>>>>       if (local_error) {
>>>>>           error_propagate(errp, local_error);
>>>>> -        aio_context_unref(iothread->ctx);
>>>>> -        iothread->ctx = NULL;
>>>>> -        return;
>>>>> +        goto fail;
>>>>>       }
>>>>>
>>>>>       qemu_mutex_init(&iothread->init_done_lock);
>>>>> @@ -178,9 +176,12 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
>>>>>        */
>>>>>       name = object_get_canonical_path_component(OBJECT(obj));
>>>>>       thread_name = g_strdup_printf("IO %s", name);
>>>>> -    /* TODO: let the further caller handle the error instead of abort() here */
>>>>> -    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
>>>>> -                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
>>>>> +    if (!qemu_thread_create(&iothread->thread, thread_name, iothread_run,
>>>>> +                            iothread, QEMU_THREAD_JOINABLE, errp)) {
>>>>> +        g_free(thread_name);
>>>>> +        g_free(name);
>>>> I suspect you're missing cleanup here:
>>>>
>>>>             qemu_cond_destroy(&iothread->init_done_cond);
>>>>             qemu_mutex_destroy(&iothread->init_done_lock);
>>> I remember I checked the code, when ucc->complete() fails, there’s a finalize() function to do the destroy.
>> To be specific, the qemu_xxx_destroy() is called by
>>
>> object_unref() => object_finalize() => object_deinit() =>
>> type->instance_finalize(obj); (that is, iothread_instance_finalize).
>>
>> For the iothread_complete(), it is only called in
>> user_creatable_complete() as ucc->complete().
>> I checked the code, when callers of user_creatable_complete() fails,
>> all of them will call
>> object_unref() to call the qemu_xxx_destroy(), except one &error_abort
>> case (e.i. desugar_shm()).
> I'm not familiar with iothread.c.  But like anyone capable of reading C,
> I can find out stuff.
>
> iothread_instance_finalize() guards its cleanups.  In particular, it
> cleans up ->init_done_cond and init_done_lock only when ->thread_id !=
> -1.
Ah, sorry that I overlooked the "if (iothread->thread_id != -1)".
So embarrassed, and sorry for the trouble.. You are right, and I
will add the qemu_xxx_destroy() in the next version. ;)


Have a nice day, thanks so much!
Fei
>
> iothread_instance_init() initializes ->thread_id = -1.
>
> iothread_run() sets it to the actual thread ID.
>
> When iothread_instance_complete() succeeds, it has waited for
> ->thread_id to become != -1, in the /* Wait for initialization to
> complete */ loop.
>
> When it fails, ->thread_id is still -1.
>
> Therefore, you cannot rely on iothread_instance_finalize() for cleaning
> up ->init_done_lock and ->init_done_cond on iothread_instance_complete()
> failure.
>
> I'm pretty sure you could've figured this out yourself instead of
> relying on me.
>
> [...]
