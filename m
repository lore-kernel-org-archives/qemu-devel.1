Received: from eggs.gnu.org ([2001:4830:134:3::10]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fTnus-0007Gf-Uf
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fTnup-0006h9-RA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:33:22 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:41120
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fTnup-0006gR-Am
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:33:19 -0400
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
Date: Fri, 15 Jun 2018 15:33:12 +0300
MIME-Version: 1.0
In-Reply-To: <20180615120649.GC2615@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

15.06.2018 15:06, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> Invalidate cache before source start in case of failed migration.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Why doesn't the code at the bottom of migration_completion,
> fail_invalidate:   and the code in migrate_fd_cancel   handle this?
>
> What case did you see it in that those didn't handle?
> (Also I guess it probably should set s->block_inactive =3D false)

on source I see:

81392@1529065750.766289:migrate_set_state new state 7
81392@1529065750.766330:migration_thread_file_err
81392@1529065750.766332:migration_thread_after_loop

so, we are leaving loop on
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_file_get_error(s->to_d=
st_file)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrate=
_set_state(&s->state, current_active_state,
MIGRATION_STATUS_FAILED);
trace_migration_thread_file_err();
break;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

and skip migration_completion()


>
> Dave
>
>> ---
>>
>>   migration/migration.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 1e99ec9b7e..8f39e0dc02 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2806,7 +2806,14 @@ static void migration_iteration_finish(MigrationS=
tate *s)
>>       case MIGRATION_STATUS_FAILED:
>>       case MIGRATION_STATUS_CANCELLED:
>>           if (s->vm_was_running) {
>> -            vm_start();
>> +            Error *local_err =3D NULL;
>> +            bdrv_invalidate_cache_all(&local_err);
>> +            if (local_err) {
>> +                error_reportf_err(local_err, "Can't invalidate disks be=
fore "
>> +                                  "source vm start");
>> +            } else {
>> +                vm_start();
>> +            }
>>           } else {
>>               if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>>                   runstate_set(RUN_STATE_POSTMIGRATE);
>> --=20
>> 2.11.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--=20
Best regards,
Vladimir
