Received: from eggs.gnu.org ([2001:4830:134:3::10]:43352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faNuG-0006k2-Oa
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faNuF-0006N3-9R
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:11:56 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
	<920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
	<e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
	<20180703111538.GB3812@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e77b0d41-ac6c-9480-3260-b3a6ed31327e@virtuozzo.com>
Date: Tue, 3 Jul 2018 19:11:40 +0300
MIME-Version: 1.0
In-Reply-To: <20180703111538.GB3812@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org

03.07.2018 14:15, Kevin Wolf wrote:
> Am 02.07.2018 um 14:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 29.06.2018 20:40, Eric Blake wrote:
>>> On 06/29/2018 12:30 PM, John Snow wrote:
>>>>
>>>> On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> We need to synchronize backup job with reading from fleecing image
>>>>> like it was done in block/replication.c.
>>>>>
>>>>> Otherwise, the following situation is theoretically possible:
>>>>>
>>>>> 1. client start reading
>>>>> 2. client understand, that there is no corresponding cluster in
>>>>>  =C2=A0=C2=A0=C2=A0 fleecing image
>>>> I don't think the client refocuses the read, but QEMU does. (the clien=
t
>>>> has no idea if it is reading from the fleecing node or the backing
>>>> file.)
>>>>
>>>> ... but understood:
>>>>
>>>>> 3. client is going to read from backing file (i.e. active image)
>>>>> 4. guest writes to active image
>>>> My question here is if QEMU will allow reads and writes to interleave =
in
>>>> general. If the client is reading from the backing file, the active
>>>> image, will QEMU allow a write to modify that data before we're done
>>>> getting that data?
>>>>
>>>>> 5. this write is stopped by backup(sync=3Dnone) and cluster is copied=
 to
>>>>>  =C2=A0=C2=A0=C2=A0 fleecing image
>>>>> 6. guest write continues...
>>>>> 7. and client reads _new_ (or partly new) date from active image
>>>>>
>>>> I can't answer this for myself one way or the other right now, but I
>>>> imagine you observed a failure in practice in your test setups, which
>>>> motivated this patch?
>>>>
>>>> A test or some proof would help justification for this patch. It would
>>>> also help prove that it solves what it claims to!
>>> In fact, do we really need a new filter, or do we just need to make the
>>> "sync":"none" blockdev-backup job take the appropriate synchronization
>>> locks?
>>>
>> How? We'll need additional mechanism like serializing requests.. Or a wa=
y to
>> reuse serializing requests. Using backup internal synchronization looks
>> simpler, and it is already used in block replication.
> But it also just an ugly hack that fixes one special case and leaves
> everything else broken. replication is usually not a good example for
> anything. It always gives me bad surprises when I have to look at it.
>
> We'll have to figure out where to fix this problem (or what it really
> is, once you look more than just at fleecing), but I think requiring the
> user to add a filter driver to work around missing serialisation in
> other code, and corrupting their image if they forget to, is not a
> reasonable solution.
>
> I see at least two things wrong in this context:
>
> * The permissions don't seem to match reality. The NBD server
>    unconditionally shares PERM_WRITE, which is wrong in this case. The
>    client wants to see a point-in-time snapshot that never changes. This
>    should become an option so that it can be properly reflected in the
>    permissions used.
>
> * Once we have proper permissions, the fleecing setup breaks down
>    because the guest needs PERM_WRITE on the backing file, but the
>    fleecing overlay allows that only if the NBD client allows it (which
>    it doesn't for fleecing).
>
>    Now we can implement an exception right into backup that installs a
>    backup filter driver between source and target if the source is the
>    backing file of the target. The filter driver would be similar to the
>    commit filter driver in that it simply promises !PERM_WRITE to its
>    parents, but allows PERM_WRITE on the source because it has installed
>    the before_write_notifier that guarantees this condition.
>
>    All writes to the target that are made by the backup job in this setup
>    (including before_write_notifier writes) need to be marked as
>    serialising so that any concurrent reads are completed first.
>
> And if we decide to add a target filter to backup, we should probably at
> the same time use a filter driver for intercepting source writes instead
> of using before_write_notifier.

Hmm, is it possible to do all the staff in one super filter driver,=20
which we insert into the tree like this:

top blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fleecing qcow2
 =C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +
 =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |backing
 =C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0 <-----+
 =C2=A0=C2=A0 super filter
 =C2=A0=C2=A0=C2=A0=C2=A0 +
 =C2=A0=C2=A0=C2=A0=C2=A0 |file
 =C2=A0=C2=A0=C2=A0=C2=A0 v
 =C2=A0=C2=A0 active image


And super filter do the following:

1. copy-on-write, before forwarding write to file, it do serializing=20
write to fleecing qcow2
2. fake .bdrv_child_perm for fleecing qcow2, like in block commit

and no block job is needed.

>
> Max, I think you intended to make both source and target children of the
> same block job node (or at least for mirror). But wouldn't that create
> loops in a setup like this? I think we may need two filters that are
> only connected through the block job, but not with block graph edges.
>
> Kevin


--=20
Best regards,
Vladimir
