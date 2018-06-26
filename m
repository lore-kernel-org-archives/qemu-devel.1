Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXiRv-00069i-4y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXiRr-0002PH-30
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:31:39 -0400
Received: from mail-db5eur01on0134.outbound.protection.outlook.com
	([104.47.2.134]:34842
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fXiRq-0002Mc-6U
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:31:35 -0400
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
	<f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
	<20180625171447.GJ2390@work-vm> <20180625175039.GK2390@work-vm>
	<40eea991-4e7f-c06b-dee4-334a245721cf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7b6640d1-9e93-4692-500b-f1bce22852ab@virtuozzo.com>
Date: Tue, 26 Jun 2018 10:31:25 +0300
MIME-Version: 1.0
In-Reply-To: <40eea991-4e7f-c06b-dee4-334a245721cf@redhat.com>
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
To: John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

25.06.2018 21:03, John Snow wrote:
>
> On 06/25/2018 01:50 PM, Dr. David Alan Gilbert wrote:
>> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>>> 15.06.2018 15:06, Dr. David Alan Gilbert wrote:
>>>>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>>>>> Invalidate cache before source start in case of failed migration.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>> Why doesn't the code at the bottom of migration_completion,
>>>>> fail_invalidate:   and the code in migrate_fd_cancel   handle this?
>>>>>
>>>>> What case did you see it in that those didn't handle?
>>>>> (Also I guess it probably should set s->block_inactive =3D false)
>>>> on source I see:
>>>>
>>>> 81392@1529065750.766289:migrate_set_state new state 7
>>>> 81392@1529065750.766330:migration_thread_file_err
>>>> 81392@1529065750.766332:migration_thread_after_loop
>>>>
>>>> so, we are leaving loop on
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_file_get_error(s-=
>to_dst_file)) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
grate_set_state(&s->state, current_active_state,
>>>> MIGRATION_STATUS_FAILED);
>>>> trace_migration_thread_file_err();
>>>> break;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> and skip migration_completion()
>>> Yeh, OK; I'd seen soemthing else a few days ago, where a cancellation
>>> test that had previously ended with a 'cancelled' state has now ended u=
p
>>> in 'failed' (which is the state 7 you have above).
>>> I suspect there's something else going on as well; I think what is
>>> supposed to happen in the case of 'cancel' is that it spins in 'cancell=
ing' for
>>> a while in migrate_fd_cancel and then at the bottom of migrate_fd_cance=
l
>>> it does the recovery, but because it's going to failed instead, then
>>> it's jumping over that recovery.
>> Going back and actually looking at the patch again;
>> can I ask for 1 small change;
>>     Can you set s->block_inactive =3D false   in the case where you
>> don't get the local_err (Like we do at the bottom of migrate_fd_cancel)
>>
>>
>> Does that make sense?
>>
>> Thanks,
>>
>> Dave
>>
> Vladimir, one more question for you because I'm not as familiar with
> this code:
>
> In the normal case we need to invalidate the qcow2 cache as a way to
> re-engage the disk (yes?) when we have failed during the late-migration
> steps.
>
> In this case, we seem to be observing a failure during the bulk transfer
> loop. Why is it important to invalidate the cache at this step -- would
> the disk have been inactivated yet? It shouldn't, because it's in the
> bulk transfer phase -- or am I missing something?
>
> I feel like this code is behaving in a way that's fairly surprising for
> a casual reader so I was hoping you could elaborate for me.
>
> --js

In my case, source is already in postcopy state, when error occured, so=20
it is inactivated.

--=20
Best regards,
Vladimir
