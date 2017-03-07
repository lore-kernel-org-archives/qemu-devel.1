Received: from eggs.gnu.org ([2001:4830:134:3::10]:56638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clBud-0005CB-Vc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clBuZ-0002Wx-1J
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:00:12 -0500
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-4-vsementsov@virtuozzo.com>
	<20170307095323.GB5871@noname.str.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b2c86843-1506-dba6-2446-a253f77f5b58@virtuozzo.com>
Date: Tue, 7 Mar 2017 12:59:43 +0300
MIME-Version: 1.0
In-Reply-To: <20170307095323.GB5871@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] savevm: fix savevm after migration
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

07.03.2017 12:53, Kevin Wolf wrote:
> Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> After migration all drives are inactive and savevm will fail with
>>
>> qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
>>     Assertion `!(bs->open_flags & 0x0800)' failed.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> What's the exact state you're in? I tried to reproduce this, but just
> doing a live migration and then savevm on the destination works fine for
> me.
>
> Hm... Or do you mean on the source? In that case, I think the operation
> must fail, but of course more gracefully than now.

Yes, I mean on the source. It may not be migration for "mirgration", but 
for dumping state to file. In that case it seems not wrong to make a 
snapshot on source.

>
> Actually, the question that you're asking implicitly here is how the
> source qemu process should be "reactivated" after a failed migration.
> Currently, as far as I know, this is only with issuing a "cont" command.
> It might make sense to provide a way to get control without resuming the
> VM, but I doubt that adding automatic resume to every QMP command is the
> right way to achieve it.
>
> Dave, Juan, what do you think?
>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index bf5c2ca5e1..256d06ac9f 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -145,7 +145,8 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
>>   int bdrv_can_snapshot(BlockDriverState *bs)
>>   {
>>       BlockDriver *drv = bs->drv;
>> -    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
>> +    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
>> +        (bs->open_flags & BDRV_O_INACTIVE)) {
>>           return 0;
>>       }
> I wasn't sure if this doesn't disable too much, but it seems it only
> makes 'info snapshots' turn up empty, which might not be nice, but maybe
> tolerable.
>
> At least it should definitely fix the assertion.
>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 5ecd264134..75e56d2d07 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2068,6 +2068,17 @@ int save_vmstate(Monitor *mon, const char *name)
>>       Error *local_err = NULL;
>>       AioContext *aio_context;
>>   
>> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE) ||
>> +        runstate_check(RUN_STATE_POSTMIGRATE) ||
>> +        runstate_check(RUN_STATE_PRELAUNCH))
>> +    {
>> +        bdrv_invalidate_cache_all(&local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
> This hunk can't go in before the more general question of implicitly or
> explicitly regaining control after a failed migration is answered.
>
> Kevin


-- 
Best regards,
Vladimir
