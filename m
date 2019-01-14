Received: from eggs.gnu.org ([209.51.188.92]:60169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gj1kF-0007px-3G
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gj1kE-0000ee-3q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:53:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gj1kC-0000ah-1y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:53:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-13-fli@suse.com>
	<87h8ekl5l9.fsf@dusky.pond.sub.org>
	<BF248B0E-5197-4777-8CE9-F9E43B7177C3@126.com>
	<df98f3b8-a2c8-f3d8-1bfa-3929fff61621@126.com>
Date: Mon, 14 Jan 2019 13:53:16 +0100
In-Reply-To: <df98f3b8-a2c8-f3d8-1bfa-3929fff61621@126.com> (Fei Li's message
	of "Mon, 14 Jan 2019 00:16:34 +0800")
Message-ID: <871s5fqu2r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, shirley17fei@gmail.com

Fei Li <lifei1214@126.com> writes:

> =E5=9C=A8 2019/1/9 =E4=B8=8A=E5=8D=8812:18, fei =E5=86=99=E9=81=93:
>>
>>> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:50=EF=BC=8CMarku=
s Armbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> Fei Li <fli@suse.com> writes:
>>>
>>>> For iothread_complete: utilize the existed errp to propagate the
>>>> error and do the corresponding cleanup to replace the temporary
>>>> &error_abort.
>>>>
>>>> For qemu_signalfd_compat: add a local_err to hold the error, and
>>>> return the corresponding error code to replace the temporary
>>>> &error_abort.
>>> I'd split the patch.
>> Ok.
>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>> Cc: Eric Blake <eblake@redhat.com>
>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>> ---
>>>> iothread.c      | 17 +++++++++++------
>>>> util/compatfd.c | 11 ++++++++---
>>>> 2 files changed, 19 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/iothread.c b/iothread.c
>>>> index 8e8aa01999..7335dacf0b 100644
>>>> --- a/iothread.c
>>>> +++ b/iothread.c
>>>> @@ -164,9 +164,7 @@ static void iothread_complete(UserCreatable *obj, =
Error **errp)
>>>>                                  &local_error);
>>>>      if (local_error) {
>>>>          error_propagate(errp, local_error);
>>>> -        aio_context_unref(iothread->ctx);
>>>> -        iothread->ctx =3D NULL;
>>>> -        return;
>>>> +        goto fail;
>>>>      }
>>>>
>>>>      qemu_mutex_init(&iothread->init_done_lock);
>>>> @@ -178,9 +176,12 @@ static void iothread_complete(UserCreatable *obj,=
 Error **errp)
>>>>       */
>>>>      name =3D object_get_canonical_path_component(OBJECT(obj));
>>>>      thread_name =3D g_strdup_printf("IO %s", name);
>>>> -    /* TODO: let the further caller handle the error instead of abort=
() here */
>>>> -    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
>>>> -                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
>>>> +    if (!qemu_thread_create(&iothread->thread, thread_name, iothread_=
run,
>>>> +                            iothread, QEMU_THREAD_JOINABLE, errp)) {
>>>> +        g_free(thread_name);
>>>> +        g_free(name);
>>> I suspect you're missing cleanup here:
>>>
>>>            qemu_cond_destroy(&iothread->init_done_cond);
>>>            qemu_mutex_destroy(&iothread->init_done_lock);
>> I remember I checked the code, when ucc->complete() fails, there=E2=80=
=99s a finalize() function to do the destroy.
>
> To be specific, the qemu_xxx_destroy() is called by
>
> object_unref() =3D> object_finalize() =3D> object_deinit() =3D>
> type->instance_finalize(obj); (that is, iothread_instance_finalize).
>
> For the iothread_complete(), it is only called in
> user_creatable_complete() as ucc->complete().
> I checked the code, when callers of user_creatable_complete() fails,
> all of them will call
> object_unref() to call the qemu_xxx_destroy(), except one &error_abort
> case (e.i. desugar_shm()).

I'm not familiar with iothread.c.  But like anyone capable of reading C,
I can find out stuff.

iothread_instance_finalize() guards its cleanups.  In particular, it
cleans up ->init_done_cond and init_done_lock only when ->thread_id !=3D
-1.

iothread_instance_init() initializes ->thread_id =3D -1.

iothread_run() sets it to the actual thread ID.

When iothread_instance_complete() succeeds, it has waited for
->thread_id to become !=3D -1, in the /* Wait for initialization to
complete */ loop.

When it fails, ->thread_id is still -1.

Therefore, you cannot rely on iothread_instance_finalize() for cleaning
up ->init_done_lock and ->init_done_cond on iothread_instance_complete()
failure.

I'm pretty sure you could've figured this out yourself instead of
relying on me.

[...]
