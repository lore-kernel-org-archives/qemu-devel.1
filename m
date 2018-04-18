Received: from eggs.gnu.org ([2001:4830:134:3::10]:52326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f8p75-0000DF-5h
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f8p71-0001Jd-2h
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:35:15 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
Date: Wed, 18 Apr 2018 17:34:31 +0200
Message-ID: <w51bmegjzp4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon 16 Apr 2018 05:15:21 PM CEST, Max Reitz wrote:
> On 2018-04-16 16:59, Alberto Garcia wrote:
>> On Fri 13 Apr 2018 04:23:07 PM CEST, Max Reitz wrote:
>>> On 2018-04-12 19:07, Alberto Garcia wrote:
>>>> Hello,
>>>>
>>>> I mentioned this some time ago, but I'd like to retake it now: I'm
>>>> checking how to copy arbitrary nodes on a backing chain, so if I have
>>>> e.g.
>>>>
>>>>    [A] <- [B] <- [C] <- [D]
>>>>
>>>> I'd like to end up with
>>>>
>>>>    [A] <- [E] <- [C] <- [D]
>>>>
>>>> where [E] is a copy of [B]. The most obvious use case is to move [B]
>>>> to a different storage backend.
>>>>
>>>> At the moment we can already copy [B] into [E] (outside QEMU) and then
>>>> do
>>>>
>>>>    change-backing-file device=[D] image-node-name=[C] backing-file=[E]
>>>>
>>>> However this only changes the image on disk and the bs->backing_file
>>>> string in memory. QEMU keeps using the [B] BlockDriverState, and we
>>>> need to make it switch to [E].
>>>>
>>>> One possible way to do this would be to modify blockdev-mirror so the
>>>> source image can be located anywhere on a chain. Currently there's
>>>> bs->backing_blocker preventing that, plus qmp_blockdev_mirror()
>>>> refuses to take any non-root source node. Other than permission
>>>> changes I don't think the algorithm itself needs any additional
>>>> modification, although I suppose we'd like to change the backing file
>>>> as part of the same job, and that would require API changes.
>>>
>>> Another way would be to write blockdev-copy. :-)
>> 
>> Something like blockdev-backup but without copying data from backing
>> files? blockdev-mirror already allows configuring that using the
>> MirrorSyncMode parameter.
>
> No, a block job that unites blockdev-backup, blockdev-mirror, and
> block-commit.

Yeah, I was reading again the notes from December. This would then unify
all those existing commands.

Is there any other plan or roadmap for this command, or was just an idea
that was discussed as nice to have? Also, does that mean that the old
commands should not be changed now? I'm asking because there's a big
difference between updating blockdev-mirror to allow non-root source
nodes and creating this new command that would support all features of
the old ones :-)

> I think we wanted to exclude streaming, because that works
> differently.  But, well, streaming would be just installing a COR
> filter node and doing a blockdev-copy to null-co://, right? :-)

Yeah I suppose, but I don't think you can make the filter step part of
the blockdev-copy API.

> I just now remembered a bitmap issue, but that probably shouldn't stop
> you.  There is an issue with bitmaps on nodes with shared-writing
> children.
>
> Imagine you have some qcow2 node or whatever, and you have a guest
> running on it.  Then you attach a filter to it (which allows shared
> writing) and put a mirror job on top of the filter.  Now whenever the
> guest writes to the qcow2 node, the bitmap the mirror job installed on
> the filter won't reflect that.  So that's an issue, but I think that
> case isn't forbidden by the current permission system, so we're
> already screwed there.
>
> So on the contrary, I'd suspect that running mirror inside of some
> backing chain or whatever may be less problematic than running it on
> top, actually...

Yeah I don't think there's a problem there.

>>>> One other way is to have a more generic replace-node command which
>>>> would call bdrv_replace_node(), but I don't know if we want to
>>>> expose that and I don't have any other use case for it at the
>>>> moment.
>>>
>>> I think we do want to expose that.  As far as I'm informed, for
>>> graph manipulation we want a command that can replace nodes
>>> (including replacing nothing by a new node or replacing an existing
>>> node by nothing, if the parent supports that).
>> 
>> Was there any discussion about this in the mailing list? (proposed
>> name for this function, features, etc.)
>
> Well, there is x-blockdev-change.  But we probably want to expose
> bdrv_reopen() in the long run.

Exposing bdrv_reopen() itself shouldn't be too much work (it takes just
two node names, or am I missing something?).

There's still the question of how to update the backing file string (on
the overlay). stream and commit do it automatically, but if we do
bdrv_reopen() or the aforementioned modification to blockdev-mirror we'd
need to do it explicitly with change-backing-file, or extend the API to
allow for that.

Berto
