Received: from eggs.gnu.org ([2001:4830:134:3::10]:48283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f85bh-0005GV-9f
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f85bc-0002R1-Bx
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:59:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
Date: Mon, 16 Apr 2018 16:59:40 +0200
Message-ID: <w517ep7gpsz.fsf@maestria.local.igalia.com>
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

On Fri 13 Apr 2018 04:23:07 PM CEST, Max Reitz wrote:
> On 2018-04-12 19:07, Alberto Garcia wrote:
>> Hello,
>> 
>> I mentioned this some time ago, but I'd like to retake it now: I'm
>> checking how to copy arbitrary nodes on a backing chain, so if I have
>> e.g.
>> 
>>    [A] <- [B] <- [C] <- [D]
>> 
>> I'd like to end up with
>> 
>>    [A] <- [E] <- [C] <- [D]
>> 
>> where [E] is a copy of [B]. The most obvious use case is to move [B]
>> to a different storage backend.
>> 
>> At the moment we can already copy [B] into [E] (outside QEMU) and then
>> do
>> 
>>    change-backing-file device=[D] image-node-name=[C] backing-file=[E]
>> 
>> However this only changes the image on disk and the bs->backing_file
>> string in memory. QEMU keeps using the [B] BlockDriverState, and we
>> need to make it switch to [E].
>> 
>> One possible way to do this would be to modify blockdev-mirror so the
>> source image can be located anywhere on a chain. Currently there's
>> bs->backing_blocker preventing that, plus qmp_blockdev_mirror()
>> refuses to take any non-root source node. Other than permission
>> changes I don't think the algorithm itself needs any additional
>> modification, although I suppose we'd like to change the backing file
>> as part of the same job, and that would require API changes.
>
> Another way would be to write blockdev-copy. :-)

Something like blockdev-backup but without copying data from backing
files? blockdev-mirror already allows configuring that using the
MirrorSyncMode parameter.

> I don't think there should be a limitation which nodes can be used as
> the source of blockdev-mirror, and I think the hardest part about
> lifting that limitation is about thinking what might break...  Maybe
> we should just drop the limitation and deal with the fallout later?  I
> can't imagine a single node configuration where we'd want to disallow
> copying off a node, so I suppose if that breaks in some edge case that
> wouldn't be something we'd have to disallow again but we'd just have
> to fix it.

I can't think of any problem either. The important question is what to
do if the source node is read/write, but that's what blockdev-mirror is
already about. In all other cases the source node is going to be read
only, isn't it?

>> One other way is to have a more generic replace-node command which
>> would call bdrv_replace_node(), but I don't know if we want to expose
>> that and I don't have any other use case for it at the moment.
>
> I think we do want to expose that.  As far as I'm informed, for graph
> manipulation we want a command that can replace nodes (including
> replacing nothing by a new node or replacing an existing node by
> nothing, if the parent supports that).

Was there any discussion about this in the mailing list? (proposed name
for this function, features, etc.)

> Also, well, there is blockdev-mirror already has a @replaces
> parameter, right?  That was supposed to work with quorum, but it seems
> obvious to use it here, too.

Yes, it could be used for this.

Berto
