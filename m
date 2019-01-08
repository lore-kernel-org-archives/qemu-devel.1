Received: from eggs.gnu.org ([209.51.188.92]:48731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gguAm-0005wB-Dx
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gguAl-0006au-AE
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:24:12 -0500
Received: from m15-111.126.com ([220.181.15.111]:56959)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gguAk-0006HM-La
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:24:11 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87a7kcl5fg.fsf@dusky.pond.sub.org>
Date: Wed, 9 Jan 2019 00:24:00 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <50C7F00E-DD75-4FFB-8590-53308C34C96F@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-15-fli@suse.com>
	<87a7kcl5fg.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 14/16] qemu_thread: supplement
 error handling for vnc_start_worker_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Gerd Hoffmann <kraxel@redhat.com>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:54=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> Supplement the error handling for vnc_thread_worker_thread: add
>> an Error parameter for it to propagate the error to its caller to
>> handle in case it fails, and make it return a Boolean to indicate
>> whether it succeeds.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>> ui/vnc-jobs.c | 17 +++++++++++------
>> ui/vnc-jobs.h |  2 +-
>> ui/vnc.c      |  4 +++-
>> 3 files changed, 15 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
>> index 5712f1f501..35a652d1fd 100644
>> --- a/ui/vnc-jobs.c
>> +++ b/ui/vnc-jobs.c
>> @@ -332,16 +332,21 @@ static bool vnc_worker_thread_running(void)
>>     return queue; /* Check global queue */
>> }
>>=20
>> -void vnc_start_worker_thread(void)
>> +bool vnc_start_worker_thread(Error **errp)
>> {
>>     VncJobQueue *q;
>>=20
>> -    if (vnc_worker_thread_running())
>> -        return ;
>> +    if (vnc_worker_thread_running()) {
>> +        goto out;
>=20
> Why not simply return true?
Sounds right.. Will remove the below =E2=80=9Cout:=E2=80=9D too.

Have a nice day, thanks
Fei

>=20
>> +    }
>>=20
>>     q =3D vnc_queue_init();
>> -    /* TODO: let the further caller handle the error instead of abort() h=
ere */
>> -    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
>> -                       q, QEMU_THREAD_DETACHED, &error_abort);
>> +    if (!qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,=

>> +                            q, QEMU_THREAD_DETACHED, errp)) {
>> +        vnc_queue_clear(q);
>> +        return false;
>> +    }
>>     queue =3D q; /* Set global queue */
>> +out:
>> +    return true;
>> }
>> diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
>> index 59f66bcc35..14640593db 100644
>> --- a/ui/vnc-jobs.h
>> +++ b/ui/vnc-jobs.h
>> @@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
>> void vnc_jobs_join(VncState *vs);
>>=20
>> void vnc_jobs_consume_buffer(VncState *vs);
>> -void vnc_start_worker_thread(void);
>> +bool vnc_start_worker_thread(Error **errp);
>>=20
>> /* Locks */
>> static inline int vnc_trylock_display(VncDisplay *vd)
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 0c1b477425..0ffe9e6a5d 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -3236,7 +3236,9 @@ void vnc_display_init(const char *id, Error **errp)=

>>     vd->connections_limit =3D 32;
>>=20
>>     qemu_mutex_init(&vd->mutex);
>> -    vnc_start_worker_thread();
>> +    if (!vnc_start_worker_thread(errp)) {
>> +        return;
>> +    }
>>=20
>>     vd->dcl.ops =3D &dcl_ops;
>>     register_displaychangelistener(&vd->dcl);
