Received: from eggs.gnu.org ([2001:4830:134:3::10]:42507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9c92-0003Z8-C5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9c1e-0001cY-J0
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1g9c1e-0001c3-9Y
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:21:10 -0400
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
	<f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
	<20180625171447.GJ2390@work-vm> <20180625175039.GK2390@work-vm>
	<bf52a2b9-ca6e-7034-5566-b67684aa52b3@virtuozzo.com>
	<efb41cc7-031f-a0d7-b86f-64e163118316@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <52cb9da4-1c0a-6ca0-62ef-edae958922be@redhat.com>
Date: Mon, 8 Oct 2018 16:21:05 -0400
MIME-Version: 1.0
In-Reply-To: <efb41cc7-031f-a0d7-b86f-64e163118316@virtuozzo.com>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>



On 10/08/2018 11:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> 26.06.2018 11:44, Vladimir Sementsov-Ogievskiy wrote:
>> 25.06.2018 20:50, Dr. David Alan Gilbert wrote:
>>> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>>>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>>>> 15.06.2018 15:06, Dr. David Alan Gilbert wrote:
>>>>>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>>>>>> Invalidate cache before source start in case of failed migration.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy=20
>>>>>>> <vsementsov@virtuozzo.com>
>>>>>> Why doesn't the code at the bottom of migration_completion,
>>>>>> fail_invalidate:=C2=A0=C2=A0 and the code in migrate_fd_cancel han=
dle this?
>>>>>>
>>>>>> What case did you see it in that those didn't handle?
>>>>>> (Also I guess it probably should set s->block_inactive =3D false)
>>>>> on source I see:
>>>>>
>>>>> 81392@1529065750.766289:migrate_set_state new state 7
>>>>> 81392@1529065750.766330:migration_thread_file_err
>>>>> 81392@1529065750.766332:migration_thread_after_loop
>>>>>
>>>>> so, we are leaving loop on
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_file_get_=
error(s->to_dst_file)) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 migrate_set_state(&s->state, current_active_state,
>>>>> MIGRATION_STATUS_FAILED);
>>>>> trace_migration_thread_file_err();
>>>>> break;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> and skip migration_completion()
>>
>>
>> John is right, this ls an unrelated log, here we fail before=20
>> inactivation and there are no problems.
>>
>> Actual problem is when we fail in postcopy_start, at the end. And=20
>> source log looks like:
>>
>> 84297@1530001796.287344:migrate_set_state new state 1
>> 84297@1530001796.287374:migration_fd_outgoing fd=3D101
>> 84297@1530001796.287383:migration_set_outgoing_channel=20
>> ioc=3D0x56363454d630 ioctype=3Dqio-channel-socket hostname=3D(null)
>> 84297@1530001796.294032:migration_bitmap_sync_start
>> 84297@1530001796.300483:migration_bitmap_sync_end dirty_pages 932
>> 84297@1530001796.300561:migrate_set_state new state 4
>> 84297@1530001796.300588:migration_thread_setup_complete
>> 84297@1530001796.300593:migrate_pending pending size 1107976192 max 0=20
>> (pre =3D 0 compat=3D1107976192 post=3D0)
>> 84297@1530001796.300595:migrate_set_state new state 5
>> Tap fd 33 disable, ret 0
>> 84297@1530001796.426477:migration_bitmap_sync_start
>> 84297@1530001796.433227:migration_bitmap_sync_end dirty_pages 1091
>> 84297@1530001796.439077:migrate_global_state_pre_save saved state:=20
>> running
>> 2018-06-26T08:29:56.439134Z qemu-kvm: postcopy_start: Migration stream=
=20
>> errored -5
>> 84297@1530001796.439141:migrate_set_state new state 7
>> 84297@1530001796.439181:migration_thread_after_loop
>> Tap fd 33 enable, ret 0
>> 84297@1530001796.453639:migrate_fd_cleanup
>> qemu-kvm: block/io.c:1655: bdrv_co_pwritev: Assertion=20
>> `!(bs->open_flags & 0x0800)' failed.
>> 2018-06-26 08:29:56.605+0000: shutting down, reason=3Dcrashed
>>
>>
>>>> Yeh, OK; I'd seen soemthing else a few days ago, where a cancellatio=
n
>>>> test that had previously ended with a 'cancelled' state has now=20
>>>> ended up
>>>> in 'failed' (which is the state 7 you have above).
>>>> I suspect there's something else going on as well; I think what is
>>>> supposed to happen in the case of 'cancel' is that it spins in=20
>>>> 'cancelling' for
>>>> a while in migrate_fd_cancel and then at the bottom of=20
>>>> migrate_fd_cancel
>>>> it does the recovery, but because it's going to failed instead, then
>>>> it's jumping over that recovery.
>>> Going back and actually looking at the patch again;
>>> can I ask for 1 small change;
>>> =C2=A0=C2=A0=C2=A0 Can you set s->block_inactive =3D false=C2=A0=C2=A0=
 in the case where you
>>> don't get the local_err (Like we do at the bottom of migrate_fd_cance=
l)
>>>
>>>
>>> Does that make sense?
>>
>> Ok, I'll resend.
>>
>> Hm, looks like I'm fixing an outdated version (based on v2.9.0) And my=
=20
>> reproduce isn't appropriate for upstream.
>> But looks like current code have a possibility of the same fail:
>>
>> postcopy_start()
>> =C2=A0=C2=A0=C2=A0 ....
>> =C2=A0=C2=A0=C2=A0 ret =3D qemu_file_get_error(ms->to_dst_file);
>> =C2=A0=C2=A0=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("postcopy_star=
t: Migration stream errored");
>>
>> leads to "return MIG_ITERATE_SKIP;" in migration_iteration_run
>>
>> then the loop should finish, as state should be=20
>> MIGRATION_STATUS_FAILED, so we will not call migration_completion.
>>
>> Hm, I have questions now:
>>
>> 1. should we check s->block_inactive, and if it is false, don't=20
>> invalidate? it is done in migrate_fd_cancel(), but not don in=20
>> migration_completion().
>> 2. should we call qemu_mutex_lock_iothread() like in=20
>> migration_completion()? Why is it needed in migration_completion(),=20
>> when vm is not running?
>=20
>=20
> Hm, forgotten thread, I should resend, but what do you think about thes=
e=20
> questions?
>=20

Personally, I can't remember where we stand on this thread at all. If
you have changes that you think are still important (because you ran
into the issue again), probably best to send a respin (with a new cover
letter and updated justification) and we'll take it from there.

(I seem to recall we were working off of different versions which
handled migration differently, which was causing confusion...)

--js
