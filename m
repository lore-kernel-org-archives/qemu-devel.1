Received: from eggs.gnu.org ([2001:4830:134:3::10]:52154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAseW-0007mJ-Eb
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAseS-0007tu-Dt
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAseS-0007tK-61
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:18:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-3-fli@suse.com>
	<87h8hs4oe3.fsf@dusky.pond.sub.org>
	<ccdf2dd1-412d-ee82-e77d-9eac6c7d86d9@suse.com>
Date: Fri, 12 Oct 2018 10:18:20 +0200
In-Reply-To: <ccdf2dd1-412d-ee82-e77d-9eac6c7d86d9@suse.com> (Fei Li's message
	of "Fri, 12 Oct 2018 13:40:01 +0800")
Message-ID: <87sh1bshmb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v5 2/7] ui/vnc.c: polish vnc_init_func
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

> On 10/11/2018 09:13 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> Add a new Error parameter for vnc_display_init() to handle errors
>>> in its caller: vnc_init_func(), just like vnc_display_open() does.
>>> And let the call trace propagate the Error.
>>>
>>> Besides, make vnc_start_worker_thread() return a bool to indicate
>>> whether it succeeds instead of returning nothing.
>>>
>>> Signed-off-by: Fei Li <fli@suse.com>
>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>   include/ui/console.h |  2 +-
>>>   ui/vnc-jobs.c        |  9 ++++++---
>>>   ui/vnc-jobs.h        |  2 +-
>>>   ui/vnc.c             | 12 +++++++++---
>>>   4 files changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/ui/console.h b/include/ui/console.h
>>> index fb969caf70..c17803c530 100644
>>> --- a/include/ui/console.h
>>> +++ b/include/ui/console.h
>>> @@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts);
>>>   void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>>>     /* vnc.c */
>>> -void vnc_display_init(const char *id);
>>> +void vnc_display_init(const char *id, Error **errp);
>>>   void vnc_display_open(const char *id, Error **errp);
>>>   void vnc_display_add_client(const char *id, int csock, bool skipauth);
>>>   int vnc_display_password(const char *id, const char *password);
>>> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
>>> index 929391f85d..8807d7217c 100644
>>> --- a/ui/vnc-jobs.c
>>> +++ b/ui/vnc-jobs.c
>>> @@ -331,15 +331,18 @@ static bool vnc_worker_thread_running(void)
>>>       return queue; /* Check global queue */
>>>   }
>>>   -void vnc_start_worker_thread(void)
>>> +bool vnc_start_worker_thread(Error **errp)
>>>   {
>>>       VncJobQueue *q;
>>>   -    if (vnc_worker_thread_running())
>>> -        return ;
>>> +    if (vnc_worker_thread_running()) {
>>> +        goto out;
>>> +    }
>>>         q =3D vnc_queue_init();
>>>       qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
>>>                          QEMU_THREAD_DETACHED);
>>>       queue =3D q; /* Set global queue */
>>> +out:
>>> +    return true;
>>>   }
>> This function cannot fail.  Why convert it to Error, and complicate its
>> caller?
> [Issue1]
> Actually, this is to pave the way for patch 7/7, in case
> qemu_thread_create() fails.
> Patch 7/7 is long enough, thus I wrote the patch 1/2/3 separately to main=
ly
> connects the broken errp for callers who initially have the errp.
>
> [I am back... If the other codes in this patches be squashed, maybe
> merge [Issue1]
> into patch 7/7 looks more intuitive.]
>>> diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
>>> index 59f66bcc35..14640593db 100644
>>> --- a/ui/vnc-jobs.h
>>> +++ b/ui/vnc-jobs.h
>>> @@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
>>>   void vnc_jobs_join(VncState *vs);
>>>     void vnc_jobs_consume_buffer(VncState *vs);
>>> -void vnc_start_worker_thread(void);
>>> +bool vnc_start_worker_thread(Error **errp);
>>>     /* Locks */
>>>   static inline int vnc_trylock_display(VncDisplay *vd)
>>> diff --git a/ui/vnc.c b/ui/vnc.c
>>> index cf221c83cc..f3806e76db 100644
>>> --- a/ui/vnc.c
>>> +++ b/ui/vnc.c
>>> @@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps dcl_ops =3D=
 {
>>>       .dpy_cursor_define    =3D vnc_dpy_cursor_define,
>>>   };
>>>   -void vnc_display_init(const char *id)
>>> +void vnc_display_init(const char *id, Error **errp)
>>>   {
>>>       VncDisplay *vd;
>>>=20=20=20
>>         if (vnc_display_find(id) !=3D NULL) {
>>             return;
>>         }
>>         vd =3D g_malloc0(sizeof(*vd));
>>
>>         vd->id =3D strdup(id);
>>         QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
>>
>>         QTAILQ_INIT(&vd->clients);
>>         vd->expires =3D TIME_MAX;
>>
>>         if (keyboard_layout) {
>>             trace_vnc_key_map_init(keyboard_layout);
>>             vd->kbd_layout =3D init_keyboard_layout(name2keysym, keyboar=
d_layout);
>>         } else {
>>             vd->kbd_layout =3D init_keyboard_layout(name2keysym, "en-us"=
);
>>         }
>>
>>         if (!vd->kbd_layout) {
>>             exit(1);
>>
>> Uh, init_keyboard_layout() reports errors to stderr, and the exit(1)
>> here makes them fatal.  Okay before this patch, but inappropriate
>> afterwards.  I'm afraid you have to convert init_keyboard_layout() to
>> Error first.
> [Issue2]
> Right. But I notice the returned kbd_layout_t *kbd_layout is a static
> value and also
> will be used by others, how about passing the errp parameter to
> init_keyboard_layout()
> as follows? And for its other callers, just pass NULL.
>
> @@ -3222,13 +3222,13 @@ void vnc_display_init(const char *id, Error **err=
p)
>
> =C2=A0=C2=A0=C2=A0=C2=A0 if (keyboard_layout) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vnc_key_map_init(k=
eyboard_layout);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym, keyboard_layout);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym, keyboard_layout, errp);
> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym, "en-us");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym, "en-us", errp);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!vd->kbd_layout) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }

Sounds good to me, except you should pass &error_fatal instead of NULL
to preserve "report error and exit" semantics.

>>
>>         }
>>
>>         vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
>>> @@ -3235,7 +3235,9 @@ void vnc_display_init(const char *id)
>>>       vd->connections_limit =3D 32;
>>>         qemu_mutex_init(&vd->mutex);
>>> -    vnc_start_worker_thread();
>>> +    if (!vnc_start_worker_thread(errp)) {
>>> +        return;
>>> +    }
>>>         vd->dcl.ops =3D &dcl_ops;
>>>       register_displaychangelistener(&vd->dcl);
>>> @@ -4079,7 +4081,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, =
Error **errp)
>>>       char *id =3D (char *)qemu_opts_id(opts);
>>>         assert(id);
>>> -    vnc_display_init(id);
>>> +    vnc_display_init(id, &local_err);
>>> +    if (local_err) {
>>> +        error_reportf_err(local_err, "Failed to init VNC server: ");
>>> +        exit(1);
>>> +    }
>>>       vnc_display_open(id, &local_err);
>>>       if (local_err !=3D NULL) {
>>>           error_reportf_err(local_err, "Failed to start VNC server: ");
>> Conflicts with my "[PATCH 24/31] vl: Clean up error reporting in
>> vnc_init_func()".  Your patch shows that mine is incomplete.
>>
>> Without my patch, there's no real reason for yours, however.  The two
>> should be squashed together.
> Ah, I noticed your patch 24/31. OK, let's squash.
> Should I write a new patch by
> - updating to error_propagate(...) if vnc_display_init() fails
> &&
> - modifying [Issue2] ?
> Or you do this in your original patch?

If you send a v2 along that lines, I'll probably pick your patch into my
series.  Should work even in case your series gets merged first.

> BTW, for your patch 24/31, the updated passed errp for vnc_init_func
> is &error_fatal,
> then the system will exit(1) when running error_propagate(...) which calls
> error_handle_fatal(...). This means the following two lines will not
> be touched.
> But if we want the following prepended error message, could we move it
> earlier than
> the error_propagare? I mean:
>
> =C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err, =
"Failed to start VNC server: ");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(&local_err, "Fa=
iled to start VNC server: ");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_e=
rr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> =C2=A0=C2=A0=C2=A0=C2=A0 }

Both

         error_propagate(errp, local_err);
         error_prepend(errp, "Failed to start VNC server: ");

and

        error_prepend(&local_err, "Failed to start VNC server: ");
        error_propagate(errp, local_err);

work.  The former is slightly more efficient when errp is null.  But
you're right, it fails to include the "Failed to start VNC server: "
prefix with &error_fatal.  Thus, the latter is preferrable.
