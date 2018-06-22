Received: from eggs.gnu.org ([2001:4830:134:3::10]:58392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWT51-0007rE-Dx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWT4y-0004np-CI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:54:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fWT4y-0004nf-5H
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:54:48 -0400
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
	<f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0cb09c1e-6ad4-7fc4-3c30-3382a0a757b0@redhat.com>
Date: Fri, 22 Jun 2018 16:54:46 -0400
MIME-Version: 1.0
In-Reply-To: <f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: invalidate cache before source
 start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com



On 06/15/2018 08:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.06.2018 15:06, Dr. David Alan Gilbert wrote:
>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>> Invalidate cache before source start in case of failed migration.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>> Why doesn't the code at the bottom of migration_completion,
>> fail_invalidate:=C2=A0=C2=A0 and the code in migrate_fd_cancel=C2=A0=C2=
=A0 handle this?
>>
>> What case did you see it in that those didn't handle?
>> (Also I guess it probably should set s->block_inactive =3D false)
>=20
> on source I see:
>=20
> 81392@1529065750.766289:migrate_set_state new state 7
> 81392@1529065750.766330:migration_thread_file_err
> 81392@1529065750.766332:migration_thread_after_loop
>=20
> so, we are leaving loop on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_file_get_error(s->t=
o_dst_file)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migr=
ate_set_state(&s->state, current_active_state,
> MIGRATION_STATUS_FAILED);
> trace_migration_thread_file_err();
> break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> and skip migration_completion()
>=20

OK, so you're saying that in migration_thread;

`
        thr_error =3D migration_detect_error(s);
        if (thr_error =3D=3D MIG_THR_ERR_FATAL) {
	    /* Stop migration */
            break;
	}
`

is triggering, so then we jump right away to

`
    trace_migration_thread_after_loop();
    migration_iteration_finish(s);
`

and in so doing, we fail before we get a chance for
migration_iteration_run to call migration_completion, which was
otherwise the mechanism that invalidated the images.

Seems like a legitimate concern that early failures versus late failures
trigger different error pathways.

David?

--js

>=20
>>
>> Dave
>>
>>> ---
>>>
>>> =C2=A0 migration/migration.c | 9 ++++++++-
>>> =C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 1e99ec9b7e..8f39e0dc02 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2806,7 +2806,14 @@ static void
>>> migration_iteration_finish(MigrationState *s)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIGRATION_STATUS_FAILED:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIGRATION_STATUS_CANCELLED:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->vm_was_=
running) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
m_start();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=
rror *local_err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_invalidate_cache_all(&local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err, "Can't invalidate disk=
s
>>> before "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "source vm start")=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
 else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vm_start();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runstate_set(RUN_STATE_POSTMIGRATE);
>>> --=C2=A0
>>> 2.11.1
>>>
>> --=20
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
