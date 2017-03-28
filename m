Received: from eggs.gnu.org ([2001:4830:134:3::10]:53419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1csqze-00046q-A2
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1csqza-0003si-0V
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:17:02 -0400
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-4-vsementsov@virtuozzo.com>
	<20170307095323.GB5871@noname.str.redhat.com>
	<20170328105544.GE2509@work-vm>
	<20170328110900.GB11725@noname.redhat.com>
	<20170328111315.GF2509@work-vm>
	<20170328120900.GC11725@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4ed9821c-d19e-70fe-c7e5-fc89756b59f5@virtuozzo.com>
Date: Tue, 28 Mar 2017 16:16:37 +0300
MIME-Version: 1.0
In-Reply-To: <20170328120900.GC11725@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, quintela@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

28.03.2017 15:09, Kevin Wolf wrote:
> Am 28.03.2017 um 13:13 hat Dr. David Alan Gilbert geschrieben:
>> * Kevin Wolf (kwolf@redhat.com) wrote:
>>> Am 28.03.2017 um 12:55 hat Dr. David Alan Gilbert geschrieben:
>>>> * Kevin Wolf (kwolf@redhat.com) wrote:
>>>>> Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>>> After migration all drives are inactive and savevm will fail with
>>>>>>
>>>>>> qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
>>>>>>     Assertion `!(bs->open_flags & 0x0800)' failed.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> What's the exact state you're in? I tried to reproduce this, but just
>>>>> doing a live migration and then savevm on the destination works fine for
>>>>> me.
>>>>>
>>>>> Hm... Or do you mean on the source? In that case, I think the operation
>>>>> must fail, but of course more gracefully than now.
>>>>>
>>>>> Actually, the question that you're asking implicitly here is how the
>>>>> source qemu process should be "reactivated" after a failed migration.
>>>>> Currently, as far as I know, this is only with issuing a "cont" command.
>>>>> It might make sense to provide a way to get control without resuming the
>>>>> VM, but I doubt that adding automatic resume to every QMP command is the
>>>>> right way to achieve it.
>>>>>
>>>>> Dave, Juan, what do you think?
>>>> I'd only ever really thought of 'cont' or retrying the migration.
>>>> However, it does make sense to me that you might want to do a savevm
>>>> instead; if you can't migrate then perhaps a savevm is the best you
>>>> can do before your machine dies.  Are there any other things that
>>>> should be allowed?
>>> I think we need to ask the other way round: Any reason _not_ to allow
>>> certain operations that you can normally perform on a stopped VM?
>>>
>>>> We would want to be careful not to accidentally reactivate the disks
>>>> on the source after what was actually a succesful migration.
>>> Yes, that's exactly my concern, even with savevm. That's why I suggested
>>> we could have a 'cont'-like thing that just gets back control of the
>>> images and moves into the normal paused state, but doesn't immediately
>>> resume the actual VM.
>> OK, lets say we had that block-reactivate (for want of a better name),
>> how would we stop everything asserting if the user tried to do it
>> before they'd run block-reactivate?
> We would have to add checks to the monitor commands that assume that the
> image is activated and error out if it isn't.
>
> Maybe just adding the check to blk_is_available() would be enough, but
> we'd have to check carefully whether it covers all cases and causes no
> false positives.
>
> By the way, I wouldn't call this 'block-reactivate' because I don't
> think this should be a block-specific command. It's a VM lifecycle
> command that switches from a postmigrate state (that assumes we have no
> control over the VM's resources any more) to a paused state (where we do
> have this control). Maybe something like 'migration-abort'.

'abort' is not very good too I think. migration is completed, nothing to 
abort.. (may be successful migration to file for suspend, some kind of 
vm cloning, etc)

>
> Kevin


-- 
Best regards,
Vladimir
