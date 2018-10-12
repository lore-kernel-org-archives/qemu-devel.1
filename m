Received: from eggs.gnu.org ([2001:4830:134:3::10]:54197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAv20-0000rT-Ex
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAv1w-0005Q8-50
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:50:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:33154 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gAv1v-0005PB-Qz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:50:52 -0400
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-3-fli@suse.com>
	<87h8hs4oe3.fsf@dusky.pond.sub.org>
	<ccdf2dd1-412d-ee82-e77d-9eac6c7d86d9@suse.com>
	<87sh1bshmb.fsf@dusky.pond.sub.org>
	<821c0332-2a8c-b5d1-8dd5-e9959e548f21@suse.com>
From: Fei Li <fli@suse.com>
Message-ID: <08ef6a4d-d33a-ab33-3b95-d7a6acc64d02@suse.com>
Date: Fri, 12 Oct 2018 18:50:40 +0800
MIME-Version: 1.0
In-Reply-To: <821c0332-2a8c-b5d1-8dd5-e9959e548f21@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: quintela@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com



On 10/12/2018 06:23 PM, Fei Li wrote:
>
>
> On 10/12/2018 04:18 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> On 10/11/2018 09:13 PM, Markus Armbruster wrote:
>>>> Fei Li <fli@suse.com> writes:
>>>>
>>>>> Add a new Error parameter for vnc_display_init() to handle errors
>>>>> in its caller: vnc_init_func(), just like vnc_display_open() does.
>>>>> And let the call trace propagate the Error.
>>>>>
>>>>> Besides, make vnc_start_worker_thread() return a bool to indicate
>>>>> whether it succeeds instead of returning nothing.
>>>>>
>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 include/ui/console.h |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 ui/vnc-jobs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 9 ++++++---
>>>>> =C2=A0=C2=A0 ui/vnc-jobs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 ui/vnc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++++---
>>>>> =C2=A0=C2=A0 4 files changed, 17 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/include/ui/console.h b/include/ui/console.h
>>>>> index fb969caf70..c17803c530 100644
>>>>> --- a/include/ui/console.h
>>>>> +++ b/include/ui/console.h
>>>>> @@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions=20
>>>>> *opts);
>>>>> =C2=A0=C2=A0 void qemu_display_init(DisplayState *ds, DisplayOption=
s *opts);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /* vnc.c */
>>>>> -void vnc_display_init(const char *id);
>>>>> +void vnc_display_init(const char *id, Error **errp);
>>>>> =C2=A0=C2=A0 void vnc_display_open(const char *id, Error **errp);
>>>>> =C2=A0=C2=A0 void vnc_display_add_client(const char *id, int csock,=
 bool=20
>>>>> skipauth);
>>>>> =C2=A0=C2=A0 int vnc_display_password(const char *id, const char *p=
assword);
>>>>> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
>>>>> index 929391f85d..8807d7217c 100644
>>>>> --- a/ui/vnc-jobs.c
>>>>> +++ b/ui/vnc-jobs.c
>>>>> @@ -331,15 +331,18 @@ static bool vnc_worker_thread_running(void)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return queue; /* Check global =
queue */
>>>>> =C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 -void vnc_start_worker_thread(void)
>>>>> +bool vnc_start_worker_thread(Error **errp)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VncJobQueue *q;
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (vnc_worker_thread_running())
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ;
>>>>> +=C2=A0=C2=A0=C2=A0 if (vnc_worker_thread_running()) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q =3D vnc_queue_in=
it();
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_create(&q->thread,=
 "vnc_worker",=20
>>>>> vnc_worker_thread, q,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 QEMU_THREAD_DETACHED);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue =3D q; /* Set global que=
ue */
>>>>> +out:
>>>>> +=C2=A0=C2=A0=C2=A0 return true;
>>>>> =C2=A0=C2=A0 }
>>>> This function cannot fail.=C2=A0 Why convert it to Error, and compli=
cate=20
>>>> its
>>>> caller?
>>> [Issue1]
>>> Actually, this is to pave the way for patch 7/7, in case
>>> qemu_thread_create() fails.
>>> Patch 7/7 is long enough, thus I wrote the patch 1/2/3 separately to=20
>>> mainly
>>> connects the broken errp for callers who initially have the errp.
>>>
>>> [I am back... If the other codes in this patches be squashed, maybe
>>> merge [Issue1]
>>> into patch 7/7 looks more intuitive.]
>>>>> diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
>>>>> index 59f66bcc35..14640593db 100644
>>>>> --- a/ui/vnc-jobs.h
>>>>> +++ b/ui/vnc-jobs.h
>>>>> @@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
>>>>> =C2=A0=C2=A0 void vnc_jobs_join(VncState *vs);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 void vnc_jobs_consume_buffer(VncState *vs)=
;
>>>>> -void vnc_start_worker_thread(void);
>>>>> +bool vnc_start_worker_thread(Error **errp);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /* Locks */
>>>>> =C2=A0=C2=A0 static inline int vnc_trylock_display(VncDisplay *vd)
>>>>> diff --git a/ui/vnc.c b/ui/vnc.c
>>>>> index cf221c83cc..f3806e76db 100644
>>>>> --- a/ui/vnc.c
>>>>> +++ b/ui/vnc.c
>>>>> @@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps=20
>>>>> dcl_ops =3D {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dpy_cursor_define=C2=A0=C2=A0=
=C2=A0 =3D vnc_dpy_cursor_define,
>>>>> =C2=A0=C2=A0 };
>>>>> =C2=A0=C2=A0 -void vnc_display_init(const char *id)
>>>>> +void vnc_display_init(const char *id, Error **errp)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VncDisplay *vd;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vnc_display_fin=
d(id) !=3D NULL) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd =3D g_malloc0(si=
zeof(*vd));
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->id =3D strdup(i=
d);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QTAILQ_INSERT_TAIL(=
&vnc_displays, vd, next);
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QTAILQ_INIT(&vd->cl=
ients);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->expires =3D TIM=
E_MAX;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (keyboard_layout=
) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trace_vnc_key_map_init(keyboard_layout);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vd->kbd_layout =3D init_keyboard_layout(name2keysym,=20
>>>> keyboard_layout);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vd->kbd_layout =3D init_keyboard_layout(name2keysym,=20
>>>> "en-us");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vd->kbd_layout=
) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 exit(1);
>>>>
>>>> Uh, init_keyboard_layout() reports errors to stderr, and the exit(1)
>>>> here makes them fatal.=C2=A0 Okay before this patch, but inappropria=
te
>>>> afterwards.=C2=A0 I'm afraid you have to convert init_keyboard_layou=
t() to
>>>> Error first.
>>> [Issue2]
>>> Right. But I notice the returned kbd_layout_t *kbd_layout is a static
>>> value and also
>>> will be used by others, how about passing the errp parameter to
>>> init_keyboard_layout()
>>> as follows? And for its other callers, just pass NULL.
>>>
>>> @@ -3222,13 +3222,13 @@ void vnc_display_init(const char *id, Error=20
>>> **errp)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (keyboard_layout) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vnc_key_=
map_init(keyboard_layout);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_k=
eyboard_layout(name2keysym,=20
>>> keyboard_layout);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_k=
eyboard_layout(name2keysym,=20
>>> keyboard_layout, errp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_k=
eyboard_layout(name2keysym, "en-us");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->kbd_layout =3D init_k=
eyboard_layout(name2keysym, "en-us",=20
>>> errp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vd->kbd_layout) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Sounds good to me, except you should pass &error_fatal instead of NULL
>> to preserve "report error and exit" semantics.
> Yes, you are right. I should pass &error_fatal and let the following=20
> error_setg() handle this.
>
> @@ -94,7 +94,7 @@ static kbd_layout_t *parse_keyboard_layout(const=20
> name2keysym_t *table,
> =C2=A0=C2=A0=C2=A0=C2=A0 f =3D filename ? fopen(filename, "r") : NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(filename);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!f) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Could not =
read keymap file: '%s'\n", language);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "could not=
 read keymap file: '%s'\n",=20
> language);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->share_policy =3D=
 VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
>>>>> @@ -3235,7 +3235,9 @@ void vnc_display_init(const char *id)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->connections_limit =3D 32;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&v=
d->mutex);
>>>>> -=C2=A0=C2=A0=C2=A0 vnc_start_worker_thread();
>>>>> +=C2=A0=C2=A0=C2=A0 if (!vnc_start_worker_thread(errp)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd->dcl.ops =3D &d=
cl_ops;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_displaychangelistener=
(&vd->dcl);
>>>>> @@ -4079,7 +4081,11 @@ int vnc_init_func(void *opaque, QemuOpts=20
>>>>> *opts, Error **errp)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *id =3D (char *)qemu_opts=
_id(opts);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(id);
>>>>> -=C2=A0=C2=A0=C2=A0 vnc_display_init(id);
>>>>> +=C2=A0=C2=A0=C2=A0 vnc_display_init(id, &local_err);
>>>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local=
_err, "Failed to init VNC server: ");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vnc_display_open(id, &local_er=
r);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_=
reportf_err(local_err, "Failed to start VNC=20
>>>>> server: ");
>>>> Conflicts with my "[PATCH 24/31] vl: Clean up error reporting in
>>>> vnc_init_func()".=C2=A0 Your patch shows that mine is incomplete.
>>>>
>>>> Without my patch, there's no real reason for yours, however.=C2=A0 T=
he two
>>>> should be squashed together.
>>> Ah, I noticed your patch 24/31. OK, let's squash.
>>> Should I write a new patch by
>>> - updating to error_propagate(...) if vnc_display_init() fails
>>> &&
>>> - modifying [Issue2] ?
>>> Or you do this in your original patch?
>> If you send a v2 along that lines, I'll probably pick your patch into =
my
>> series.=C2=A0 Should work even in case your series gets merged first.
> Good idea. I will send a separate v2 patch which also include the
> above change mentioned in [Issue1].
After thinking twice, I think move the above change mentioned in [Issue1]
to patch 7/7 is better. Thus my next separate v2 will not include it.
>>
>>> BTW, for your patch 24/31, the updated passed errp for vnc_init_func
>>> is &error_fatal,
>>> then the system will exit(1) when running error_propagate(...) which=20
>>> calls
>>> error_handle_fatal(...). This means the following two lines will not
>>> be touched.
>>> But if we want the following prepended error message, could we move i=
t
>>> earlier than
>>> the error_propagare? I mean:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_e=
rr, "Failed to start VNC server: ");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(&local_err,=
 "Failed to start VNC server: ");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Both
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate=
(errp, local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(e=
rrp, "Failed to start VNC server: ");
>>
>> and
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(&local_=
err, "Failed to start VNC server: ");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp,=
 local_err);
>>
>> work.=C2=A0 The former is slightly more efficient when errp is null. B=
ut
>> you're right, it fails to include the "Failed to start VNC server: "
>> prefix with &error_fatal.=C2=A0 Thus, the latter is preferrable.
>>
>>
> Have a nice day, thanks
> Fei
>
>
>
