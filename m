Received: from eggs.gnu.org ([2001:4830:134:3::10]:35505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ct1rP-00084Y-Bc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 20:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ct1rK-00044a-7E
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 20:53:15 -0400
Received: from mail-he1eur01on0109.outbound.protection.outlook.com
	([104.47.0.109]:58000
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1ct1rJ-00043b-GM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 20:53:10 -0400
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-4-vsementsov@virtuozzo.com>
	<20170307095323.GB5871@noname.str.redhat.com>
	<20170328105544.GE2509@work-vm>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <f7766254-4bdd-1d4f-0928-de104a8debd9@openvz.org>
Date: Tue, 28 Mar 2017 14:18:00 +0300
MIME-Version: 1.0
In-Reply-To: <20170328105544.GE2509@work-vm>
Content-Type: text/plain; charset="windows-1252"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, quintela@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, jsnow@redhat.com, lirans@il.ibm.com

On 03/28/2017 01:55 PM, Dr. David Alan Gilbert wrote:
> * Kevin Wolf (kwolf@redhat.com) wrote:
>> Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> After migration all drives are inactive and savevm will fail with
>>>
>>> qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
>>>    Assertion `!(bs->open_flags & 0x0800)' failed.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> What's the exact state you're in? I tried to reproduce this, but just
>> doing a live migration and then savevm on the destination works fine for
>> me.
>>
>> Hm... Or do you mean on the source? In that case, I think the operation
>> must fail, but of course more gracefully than now.
>>
>> Actually, the question that you're asking implicitly here is how the
>> source qemu process should be "reactivated" after a failed migration.
>> Currently, as far as I know, this is only with issuing a "cont" command.
>> It might make sense to provide a way to get control without resuming the
>> VM, but I doubt that adding automatic resume to every QMP command is the
>> right way to achieve it.
>>
>> Dave, Juan, what do you think?
> I'd only ever really thought of 'cont' or retrying the migration.
> However, it does make sense to me that you might want to do a savevm instead;
> if you can't migrate then perhaps a savevm is the best you can do before
> your machine dies.  Are there any other things that should be allowed?
>
> We would want to be careful not to accidentally reactivate the disks on the source
> after what was actually a succesful migration.
>
> As for the actual patch contents, I'd leave that to you to say if it's
> OK from the block side of things.
>
> Dave
>
>>> diff --git a/block/snapshot.c b/block/snapshot.c
>>> index bf5c2ca5e1..256d06ac9f 100644
>>> --- a/block/snapshot.c
>>> +++ b/block/snapshot.c
>>> @@ -145,7 +145,8 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
>>>  int bdrv_can_snapshot(BlockDriverState *bs)
>>>  {
>>>      BlockDriver *drv = bs->drv;
>>> -    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
>>> +    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
>>> +        (bs->open_flags & BDRV_O_INACTIVE)) {
>>>          return 0;
>>>      }
>> I wasn't sure if this doesn't disable too much, but it seems it only
>> makes 'info snapshots' turn up empty, which might not be nice, but maybe
>> tolerable.
>>
>> At least it should definitely fix the assertion.
> Did Denis have some concerns about this chunk?
Yep. I really think that this check is unnecessary and wrong.
Actually all disks are in the INACTIVE state and we will face
the problem later on the actual write. This exact operation
is sane.

Den
