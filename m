Received: from eggs.gnu.org ([2001:4830:134:3::10]:58738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXjay-00060Z-U7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXjav-0001qc-M7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:04 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com
	([40.107.3.105]:52697
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fXjau-0001qI-Vv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:01 -0400
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
	<f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
	<20180625171447.GJ2390@work-vm> <20180625175039.GK2390@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bf52a2b9-ca6e-7034-5566-b67684aa52b3@virtuozzo.com>
Date: Tue, 26 Jun 2018 11:44:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180625175039.GK2390@work-vm>
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jsnow@redhat.com

25.06.2018 20:50, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>> 15.06.2018 15:06, Dr. David Alan Gilbert wrote:
>>>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>>>> Invalidate cache before source start in case of failed migration.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>> Why doesn't the code at the bottom of migration_completion,
>>>> fail_invalidate:   and the code in migrate_fd_cancel   handle this?
>>>>
>>>> What case did you see it in that those didn't handle?
>>>> (Also I guess it probably should set s->block_inactive =3D false)
>>> on source I see:
>>>
>>> 81392@1529065750.766289:migrate_set_state new state 7
>>> 81392@1529065750.766330:migration_thread_file_err
>>> 81392@1529065750.766332:migration_thread_after_loop
>>>
>>> so, we are leaving loop on
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_file_get_error(s->=
to_dst_file)) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mig=
rate_set_state(&s->state, current_active_state,
>>> MIGRATION_STATUS_FAILED);
>>> trace_migration_thread_file_err();
>>> break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> and skip migration_completion()


John is right, this ls an unrelated log, here we fail before=20
inactivation and there are no problems.

Actual problem is when we fail in postcopy_start, at the end. And source=20
log looks like:

84297@1530001796.287344:migrate_set_state new state 1
84297@1530001796.287374:migration_fd_outgoing fd=3D101
84297@1530001796.287383:migration_set_outgoing_channel=20
ioc=3D0x56363454d630 ioctype=3Dqio-channel-socket hostname=3D(null)
84297@1530001796.294032:migration_bitmap_sync_start
84297@1530001796.300483:migration_bitmap_sync_end dirty_pages 932
84297@1530001796.300561:migrate_set_state new state 4
84297@1530001796.300588:migration_thread_setup_complete
84297@1530001796.300593:migrate_pending pending size 1107976192 max 0=20
(pre =3D 0 compat=3D1107976192 post=3D0)
84297@1530001796.300595:migrate_set_state new state 5
Tap fd 33 disable, ret 0
84297@1530001796.426477:migration_bitmap_sync_start
84297@1530001796.433227:migration_bitmap_sync_end dirty_pages 1091
84297@1530001796.439077:migrate_global_state_pre_save saved state: running
2018-06-26T08:29:56.439134Z qemu-kvm: postcopy_start: Migration stream=20
errored -5
84297@1530001796.439141:migrate_set_state new state 7
84297@1530001796.439181:migration_thread_after_loop
Tap fd 33 enable, ret 0
84297@1530001796.453639:migrate_fd_cleanup
qemu-kvm: block/io.c:1655: bdrv_co_pwritev: Assertion `!(bs->open_flags=20
& 0x0800)' failed.
2018-06-26 08:29:56.605+0000: shutting down, reason=3Dcrashed


>> Yeh, OK; I'd seen soemthing else a few days ago, where a cancellation
>> test that had previously ended with a 'cancelled' state has now ended up
>> in 'failed' (which is the state 7 you have above).
>> I suspect there's something else going on as well; I think what is
>> supposed to happen in the case of 'cancel' is that it spins in 'cancelli=
ng' for
>> a while in migrate_fd_cancel and then at the bottom of migrate_fd_cancel
>> it does the recovery, but because it's going to failed instead, then
>> it's jumping over that recovery.
> Going back and actually looking at the patch again;
> can I ask for 1 small change;
>     Can you set s->block_inactive =3D false   in the case where you
> don't get the local_err (Like we do at the bottom of migrate_fd_cancel)
>
>
> Does that make sense?

Ok, I'll resend.

Hm, looks like I'm fixing an outdated version (based on v2.9.0) And my=20
reproduce isn't appropriate for upstream.
But looks like current code have a possibility of the same fail:

postcopy_start()
 =C2=A0=C2=A0=C2=A0 ....
 =C2=A0=C2=A0=C2=A0 ret =3D qemu_file_get_error(ms->to_dst_file);
 =C2=A0=C2=A0=C2=A0 if (ret) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("postcopy_start: M=
igration stream errored");

leads to "return MIG_ITERATE_SKIP;" in migration_iteration_run

then the loop should finish, as state should be MIGRATION_STATUS_FAILED,=20
so we will not call migration_completion.

Hm, I have questions now:

1. should we check s->block_inactive, and if it is false, don't=20
invalidate? it is done in migrate_fd_cancel(), but not don in=20
migration_completion().
2. should we call qemu_mutex_lock_iothread() like in=20
migration_completion()? Why is it needed in migration_completion(), when=20
vm is not running?

>
> Thanks,
>
> Dave
>
>> Dave
>>
>>>> Dave
>>>>
>>>>> ---
>>>>>
>>>>>    migration/migration.c | 9 ++++++++-
>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index 1e99ec9b7e..8f39e0dc02 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -2806,7 +2806,14 @@ static void migration_iteration_finish(Migrati=
onState *s)
>>>>>        case MIGRATION_STATUS_FAILED:
>>>>>        case MIGRATION_STATUS_CANCELLED:
>>>>>            if (s->vm_was_running) {
>>>>> -            vm_start();
>>>>> +            Error *local_err =3D NULL;
>>>>> +            bdrv_invalidate_cache_all(&local_err);
>>>>> +            if (local_err) {
>>>>> +                error_reportf_err(local_err, "Can't invalidate disks=
 before "
>>>>> +                                  "source vm start");
>>>>> +            } else {
>>>>> +                vm_start();
>>>>> +            }
>>>>>            } else {
>>>>>                if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>>>>>                    runstate_set(RUN_STATE_POSTMIGRATE);
>>>>> --=20
>>>>> 2.11.1
>>>>>
>>>> --
>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>> --=20
>>> Best regards,
>>> Vladimir
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--=20
Best regards,
Vladimir
