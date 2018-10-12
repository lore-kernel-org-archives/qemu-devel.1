Received: from eggs.gnu.org ([2001:4830:134:3::10]:51657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAqBL-0006A0-T2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 01:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAqBH-0001eK-01
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 01:40:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39426 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gAqBG-0001YN-Jw
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 01:40:10 -0400
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-3-fli@suse.com>
	<87h8hs4oe3.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <ccdf2dd1-412d-ee82-e77d-9eac6c7d86d9@suse.com>
Date: Fri, 12 Oct 2018 13:40:01 +0800
MIME-Version: 1.0
In-Reply-To: <87h8hs4oe3.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, famz@redhat.com



On 10/11/2018 09:13 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> Add a new Error parameter for vnc_display_init() to handle errors
>> in its caller: vnc_init_func(), just like vnc_display_open() does.
>> And let the call trace propagate the Error.
>>
>> Besides, make vnc_start_worker_thread() return a bool to indicate
>> whether it succeeds instead of returning nothing.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>   include/ui/console.h |  2 +-
>>   ui/vnc-jobs.c        |  9 ++++++---
>>   ui/vnc-jobs.h        |  2 +-
>>   ui/vnc.c             | 12 +++++++++---
>>   4 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/ui/console.h b/include/ui/console.h
>> index fb969caf70..c17803c530 100644
>> --- a/include/ui/console.h
>> +++ b/include/ui/console.h
>> @@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts)=
;
>>   void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>>  =20
>>   /* vnc.c */
>> -void vnc_display_init(const char *id);
>> +void vnc_display_init(const char *id, Error **errp);
>>   void vnc_display_open(const char *id, Error **errp);
>>   void vnc_display_add_client(const char *id, int csock, bool skipauth=
);
>>   int vnc_display_password(const char *id, const char *password);
>> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
>> index 929391f85d..8807d7217c 100644
>> --- a/ui/vnc-jobs.c
>> +++ b/ui/vnc-jobs.c
>> @@ -331,15 +331,18 @@ static bool vnc_worker_thread_running(void)
>>       return queue; /* Check global queue */
>>   }
>>  =20
>> -void vnc_start_worker_thread(void)
>> +bool vnc_start_worker_thread(Error **errp)
>>   {
>>       VncJobQueue *q;
>>  =20
>> -    if (vnc_worker_thread_running())
>> -        return ;
>> +    if (vnc_worker_thread_running()) {
>> +        goto out;
>> +    }
>>  =20
>>       q =3D vnc_queue_init();
>>       qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, =
q,
>>                          QEMU_THREAD_DETACHED);
>>       queue =3D q; /* Set global queue */
>> +out:
>> +    return true;
>>   }
> This function cannot fail.  Why convert it to Error, and complicate its
> caller?
[Issue1]
Actually, this is to pave the way for patch 7/7, in case=20
qemu_thread_create() fails.
Patch 7/7 is long enough, thus I wrote the patch 1/2/3 separately to main=
ly
connects the broken errp for callers who initially have the errp.

[I am back... If the other codes in this patches be squashed, maybe=20
merge [Issue1]
into patch 7/7 looks more intuitive.]
>> diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
>> index 59f66bcc35..14640593db 100644
>> --- a/ui/vnc-jobs.h
>> +++ b/ui/vnc-jobs.h
>> @@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
>>   void vnc_jobs_join(VncState *vs);
>>  =20
>>   void vnc_jobs_consume_buffer(VncState *vs);
>> -void vnc_start_worker_thread(void);
>> +bool vnc_start_worker_thread(Error **errp);
>>  =20
>>   /* Locks */
>>   static inline int vnc_trylock_display(VncDisplay *vd)
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index cf221c83cc..f3806e76db 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps dcl_ops =3D=
 {
>>       .dpy_cursor_define    =3D vnc_dpy_cursor_define,
>>   };
>>  =20
>> -void vnc_display_init(const char *id)
>> +void vnc_display_init(const char *id, Error **errp)
>>   {
>>       VncDisplay *vd;
>>  =20
>         if (vnc_display_find(id) !=3D NULL) {
>             return;
>         }
>         vd =3D g_malloc0(sizeof(*vd));
>
>         vd->id =3D strdup(id);
>         QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
>
>         QTAILQ_INIT(&vd->clients);
>         vd->expires =3D TIME_MAX;
>
>         if (keyboard_layout) {
>             trace_vnc_key_map_init(keyboard_layout);
>             vd->kbd_layout =3D init_keyboard_layout(name2keysym, keyboa=
rd_layout);
>         } else {
>             vd->kbd_layout =3D init_keyboard_layout(name2keysym, "en-us=
");
>         }
>
>         if (!vd->kbd_layout) {
>             exit(1);
>
> Uh, init_keyboard_layout() reports errors to stderr, and the exit(1)
> here makes them fatal.  Okay before this patch, but inappropriate
> afterwards.  I'm afraid you have to convert init_keyboard_layout() to
> Error first.
[Issue2]
Right. But I notice the returned kbd_layout_t *kbd_layout is a static=20
value and also
will be used by others, how about passing the errp parameter to=20
init_keyboard_layout()
as follows? And for its other callers, just pass NULL.

@@ -3222,13 +3222,13 @@ void vnc_display_init(const char *id, Error **err=
p)

 =C2=A0=C2=A0=C2=A0=C2=A0 if (keyboard_layout) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vnc_key_map_init(=
keyboard_layout);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym,=20
keyboard_layout);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym,=20
keyboard_layout, errp);
 =C2=A0=C2=A0=C2=A0=C2=A0 } else {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym, "en-us");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_keybo=
ard_layout(name2keysym, "en-us", errp);
 =C2=A0=C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0=C2=A0 if (!vd->kbd_layout) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

>
>         }
>
>         vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
>> @@ -3235,7 +3235,9 @@ void vnc_display_init(const char *id)
>>       vd->connections_limit =3D 32;
>>  =20
>>       qemu_mutex_init(&vd->mutex);
>> -    vnc_start_worker_thread();
>> +    if (!vnc_start_worker_thread(errp)) {
>> +        return;
>> +    }
>>  =20
>>       vd->dcl.ops =3D &dcl_ops;
>>       register_displaychangelistener(&vd->dcl);
>> @@ -4079,7 +4081,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts,=
 Error **errp)
>>       char *id =3D (char *)qemu_opts_id(opts);
>>  =20
>>       assert(id);
>> -    vnc_display_init(id);
>> +    vnc_display_init(id, &local_err);
>> +    if (local_err) {
>> +        error_reportf_err(local_err, "Failed to init VNC server: ");
>> +        exit(1);
>> +    }
>>       vnc_display_open(id, &local_err);
>>       if (local_err !=3D NULL) {
>>           error_reportf_err(local_err, "Failed to start VNC server: ")=
;
> Conflicts with my "[PATCH 24/31] vl: Clean up error reporting in
> vnc_init_func()".  Your patch shows that mine is incomplete.
>
> Without my patch, there's no real reason for yours, however.  The two
> should be squashed together.
Ah, I noticed your patch 24/31. OK, let's squash.
Should I write a new patch by
- updating to error_propagate(...) if vnc_display_init() fails
&&
- modifying [Issue2] ?
Or you do this in your original patch?

BTW, for your patch 24/31, the updated passed errp for vnc_init_func is=20
&error_fatal,
then the system will exit(1) when running error_propagate(...) which call=
s
error_handle_fatal(...). This means the following two lines will not be=20
touched.
But if we want the following prepended error message, could we move it=20
earlier than
the error_propagare? I mean:

 =C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err, =
"Failed to start VNC server: ");
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(&local_err, "Fa=
iled to start VNC server: ");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_e=
rr);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

Have a nice day
Fei
