Received: from eggs.gnu.org ([2001:4830:134:3::10]:33012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clC5g-0000fO-R2
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clC5f-0003Gh-Ms
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:11:36 -0500
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-3-vsementsov@virtuozzo.com>
	<20170307100204.GC5871@noname.str.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ec621d28-d6bd-a125-fa1c-5e9a09b04c22@virtuozzo.com>
Date: Tue, 7 Mar 2017 13:11:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170307100204.GC5871@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] qmp-cont: invalidate on
 RUN_STATE_PRELAUNCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

07.03.2017 13:02, Kevin Wolf wrote:
> Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> We must invalidate on RUN_STATE_PRELAUNCH too, as it is available
>> through qmp_system_reset from RUN_STATE_POSTMIGRATE. Otherwise, we will
>> come to
>>
>> qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
>>         Assertion `!(bs->open_flags & 0x0800)' failed.
>>
>> on the first write after vm start.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Wouldn't it make more sense to invalidate in qmp_system_reset() where
> the migration states are left?
>
> Or maybe BDRV_O_INACTIVE could even be tied directly to runstates? Not
> sure how realistic this one is, but if we start adding invalidate_cache
> calls all over the place, maybe that's a sign that we need to look for a
> more central place.

I've proposed it in cover letter) These bugs and my fixes are just show 
that something should be rethought.. I don't claim that these fixes are 
true way, they are just the simplest.

> Kevin
>
>>   qmp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/qmp.c b/qmp.c
>> index dfaabac1a6..e61795d033 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -198,7 +198,8 @@ void qmp_cont(Error **errp)
>>       /* Continuing after completed migration. Images have been inactivated to
>>        * allow the destination to take control. Need to get control back now. */
>>       if (runstate_check(RUN_STATE_FINISH_MIGRATE) ||
>> -        runstate_check(RUN_STATE_POSTMIGRATE))
>> +        runstate_check(RUN_STATE_POSTMIGRATE) ||
>> +        runstate_check(RUN_STATE_PRELAUNCH))
>>       {
>>           bdrv_invalidate_cache_all(&local_err);
>>           if (local_err) {
>> -- 
>> 2.11.1
>>


-- 
Best regards,
Vladimir
