Received: from eggs.gnu.org ([209.51.188.92]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggu5v-0002pr-HH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggu5s-0008Ha-G1
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:19:10 -0500
Received: from m15-111.126.com ([220.181.15.111]:54567)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggu5o-0007mu-O0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:19:07 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87h8ekl5l9.fsf@dusky.pond.sub.org>
Date: Wed, 9 Jan 2019 00:18:56 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF248B0E-5197-4777-8CE9-F9E43B7177C3@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-13-fli@suse.com>
	<87h8ekl5l9.fsf@dusky.pond.sub.org>
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
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:50=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> For iothread_complete: utilize the existed errp to propagate the
>> error and do the corresponding cleanup to replace the temporary
>> &error_abort.
>>=20
>> For qemu_signalfd_compat: add a local_err to hold the error, and
>> return the corresponding error code to replace the temporary
>> &error_abort.
>=20
> I'd split the patch.
Ok.
>=20
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>> iothread.c      | 17 +++++++++++------
>> util/compatfd.c | 11 ++++++++---
>> 2 files changed, 19 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/iothread.c b/iothread.c
>> index 8e8aa01999..7335dacf0b 100644
>> --- a/iothread.c
>> +++ b/iothread.c
>> @@ -164,9 +164,7 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
>>                                 &local_error);
>>     if (local_error) {
>>         error_propagate(errp, local_error);
>> -        aio_context_unref(iothread->ctx);
>> -        iothread->ctx =3D NULL;
>> -        return;
>> +        goto fail;
>>     }
>>=20
>>     qemu_mutex_init(&iothread->init_done_lock);
>> @@ -178,9 +176,12 @@ static void iothread_complete(UserCreatable *obj, Er=
ror **errp)
>>      */
>>     name =3D object_get_canonical_path_component(OBJECT(obj));
>>     thread_name =3D g_strdup_printf("IO %s", name);
>> -    /* TODO: let the further caller handle the error instead of abort() h=
ere */
>> -    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
>> -                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
>> +    if (!qemu_thread_create(&iothread->thread, thread_name, iothread_run=
,
>> +                            iothread, QEMU_THREAD_JOINABLE, errp)) {
>> +        g_free(thread_name);
>> +        g_free(name);
>=20
> I suspect you're missing cleanup here:
>=20
>           qemu_cond_destroy(&iothread->init_done_cond);
>           qemu_mutex_destroy(&iothread->init_done_lock);
I remember I checked the code, when ucc->complete() fails, there=E2=80=99s a=
 finalize() function to do the destroy. But did not test all the callers, so=
 let=E2=80=99s wait for Stefan=E2=80=99s feedback. :)
>=20
> But I'm not 100% sure, to be honest.  Stefan, can you help?
>=20
>=20
>> +        goto fail;
>> +    }
>>     g_free(thread_name);
>>     g_free(name);
>>=20
>=20
> I'd avoid the code duplication like this:
>=20
>       thread_ok =3D qemu_thread_create(&iothread->thread, thread_name,
>                                      iothread_run, iothread,
>                                      QEMU_THREAD_JOINABLE, errp);
>       g_free(thread_name);
>       g_free(name);
>       if (!thread_ok) {
>           qemu_cond_destroy(&iothread->init_done_cond);
>           qemu_mutex_destroy(&iothread->init_done_lock);
>           goto fail;
>       }
>=20
> Matter of taste.
>=20
> Hmm, iothread.c has no maintainer.  Stefan, you created it, would you be
> willing to serve as maintainer?
>=20
>> @@ -191,6 +192,10 @@ static void iothread_complete(UserCreatable *obj, Er=
ror **errp)
>>                        &iothread->init_done_lock);
>>     }
>>     qemu_mutex_unlock(&iothread->init_done_lock);
>> +    return;
>> +fail:
>> +    aio_context_unref(iothread->ctx);
>> +    iothread->ctx =3D NULL;
>> }
>>=20
>> typedef struct {
>> diff --git a/util/compatfd.c b/util/compatfd.c
>> index c3d8448264..9cb13381e4 100644
>> --- a/util/compatfd.c
>> +++ b/util/compatfd.c
>> @@ -71,6 +71,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>>     struct sigfd_compat_info *info;
>>     QemuThread thread;
>>     int fds[2];
>> +    Error *local_err =3D NULL;
>>=20
>>     info =3D malloc(sizeof(*info));
>>     if (info =3D=3D NULL) {
>> @@ -89,9 +90,13 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>>     memcpy(&info->mask, mask, sizeof(*mask));
>>     info->fd =3D fds[1];
>>=20
>> -    /* TODO: let the further caller handle the error instead of abort() h=
ere */
>> -    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
>> -                       info, QEMU_THREAD_DETACHED, &error_abort);
>> +    if (!qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
>> +                            info, QEMU_THREAD_DETACHED, &local_err)) {
>> +        close(fds[0]);
>> +        close(fds[1]);
>> +        free(info);
>> +        return -1;
>=20
> Leaks @local_err.  Pass NULL instead.
Ok, thanks!

Have a nice day=20
Fei
>=20
>> +    }
>>=20
>>     return fds[0];
>> }
