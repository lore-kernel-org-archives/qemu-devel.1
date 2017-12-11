Received: from eggs.gnu.org ([2001:4830:134:3::10]:41957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOT0i-0003hS-Pu
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOT0g-0000dN-RN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:41:04 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<40da8b0d-8039-634c-f50e-1d6326d7fca5@virtuozzo.com>
	<37d0e96a-d572-3290-61e7-87e59de2f59b@redhat.com>
	<2a255dee-97c6-5d6d-3152-df0b7fc2d4f0@virtuozzo.com>
	<0c66a77a-c95a-2071-9422-a2ce0622dbbe@redhat.com>
	<20171211111529.GB7707@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <f916db57-e4a9-1903-9957-d1afb0fdd495@redhat.com>
Date: Mon, 11 Dec 2017 13:40:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171211111529.GB7707@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com



On 12/11/2017 06:15 AM, Kevin Wolf wrote:
> Am 09.12.2017 um 01:57 hat John Snow geschrieben:
>> Here's an idea of what this API might look like without revealing
>> explicit merge/split primitives.
>>
>> A new bitmap property that lets us set retention:
>>
>> :: block-dirty-bitmap-set-retention bitmap=3Dfoo slices=3D10
>>
>> Or something similar, where the default property for all bitmaps is
>> zero -- the current behavior: no copies retained.
>>
>> By setting it to a non-zero positive integer, the incremental backup
>> mode will automatically save a disabled copy when possible.
>=20
> -EMAGIC
>=20
> Operations that create or delete user-visible objects should be
> explicit, not automatic. You're trying to implement management layer
> functionality in qemu here, but incomplete enough that the artifacts of
> it are still visible externally. (A complete solution within qemu
> wouldn't expose low-level concepts such as bitmaps on an external
> interface, but you would expose something like checkpoints.)
>=20
> Usually it's not a good idea to have a design where qemu implements
> enough to restrict management tools to whatever use case we had in mind=
,
> but not enough to make the management tool's life substantially easier
> (by not having to care about some low-level concepts).
>=20
>> "What happens if we exceed our retention?"
>>
>> (A) We push the last one out automatically, or
>> (B) We fail the operation immediately.
>>
>> A is more convenient, but potentially unsafe if the management tool or
>> user wasn't aware that was going to happen.
>> B is more annoying, but definitely more safe as it means we cannot los=
e
>> a bitmap accidentally.
>=20
> Both mean that the management layer has not only to deal with the
> deletion of bitmaps as it wants to have them, but also to keep the
> retention counter somewhere and predict what qemu is going to do to the
> bitmaps and whether any corrective action needs to be taken.
>=20
> This is making things more complex rather than simpler.
>=20
>> I would argue for B with perhaps a force-cycle=3Dtrue|false that defau=
lts
>> to false to let management tools say "Yes, go ahead, remove the old on=
e"
>> with additionally some return to let us know it happened:
>>
>> {"return": {
>>   "dropped-slices": [ {"bitmap0": 0}, ...]
>> }}
>>
>> This would introduce some concept of bitmap slices into the mix as ID'=
d
>> children of a bitmap. I would propose that these slices are numbered a=
nd
>> monotonically increasing. "bitmap0" as an object starts with no slices=
,
>> but every incremental backup creates slice 0, slice 1, slice 2, and so
>> on. Even after we start deleting some, they stay ordered. These number=
s
>> then stand in for points in time.
>>
>> The counter can (must?) be reset and all slices forgotten when
>> performing a full backup while providing a bitmap argument.
>>
>> "How can a user make use of the slices once they're made?"
>>
>> Let's consider something like mode=3Dpartial in contrast to
>> mode=3Dincremental, and an example where we have 6 prior slices:
>> 0,1,2,3,4,5, (and, unnamed, the 'active' slice.)
>>
>> mode=3Dpartial bitmap=3Dfoo slice=3D4
>>
>> This would create a backup from slice 4 to the current time =CE=B1. Th=
is
>> includes all clusters from 4, 5, and the active bitmap.
>>
>> I don't think it is meaningful to define any end point that isn't the
>> current time, so I've omitted that as a possibility.
>=20
> John, what are you doing here? This adds option after option, and even
> additional slice object, only complicating an easy thing more and more.
> I'm not sure if that was your intention, but I feel I'm starting to
> understand better how Linus's rants come about.
>=20
> Let me summarise what this means for management layer:
>=20
> * The management layer has to manage bitmaps. They have direct control
>   over creation and deletion of bitmaps. So far so good.
>=20
> * It also has to manage slices in those bitmaps objects; and these
>   slices are what contains the actual bitmaps. In order to identify a
>   bitmap in qemu, you need:
>=20
>     a) the node name
>     b) the bitmap ID, and
>     c) the slice number
>=20
>   The slice number is assigned by qemu and libvirt has to wait until
>   qemu tells it about the slice number of a newly created slice. If
>   libvirt doesn't receive the reply to the command that started the
>   block job, it needs to be able to query this information from qemu,
>   e.g. in query-block-jobs.
>=20
> * Slices are automatically created when you start a backup job with a
>   bitmap. It doesn't matter whether you even intend to do an incrementa=
l
>   backup against this point in time. qemu knows better.
>=20
> * In order to delete a slice that you don't need any more, you have to
>   create more slices (by doing more backups), but you don't get to
>   decide which one is dropped. qemu helpfully just drops the oldest one=
.
>   It doesn't matter if you want to keep an older one so you can do an
>   incremental backup for a longer timespan. Don't worry about your
>   backup strategy, qemu knows better.
>=20
> * Of course, just creating a new backup job doesn't mean that removing
>   the old slice works, even if you give the respective option. That's
>   what the 'dropped-slices' return is for. So once again wait for
>   whatever qemu did and reproduce it in the data structures of the
>   management tool. It's also more information that needs to be exposed
>   in query-block-jobs because libvirt might miss the return value.
>=20
> * Hmm... What happens if you start n backup block jobs, with n > slices=
?
>   Sounds like a great way to introduce subtle bugs in both qemu and the
>   management layer.
>=20
> Do you really think working with this API would be fun for libvirt?
>=20
>> "Does a partial backup create a new point in time?"
>>
>> If yes: This means that the next incremental backup must necessarily b=
e
>> based off of the last partial backup that was made. This seems a littl=
e
>> inconvenient. This would mean that point in time =CE=B1 becomes "slice=
 6."
>=20
> Or based off any of the previous points in time, provided that qemu
> didn't helpfully decide to delete it. Can't I still create a backup
> starting from slice 4 then?
>=20
> Also, a more general question about incremental backup: How does it pla=
y
> with snapshots? Shouldn't we expect that people sometimes use both
> snapshots and backups? Can we restrict the backup job to considering
> bitmaps only from a single node or should we be able to reference
> bitmaps of a backing file as well?
>=20
>> If no: This means that we lose the point in time when we made the
>> partial and we cannot chain off of the partial backup. It does mean th=
at
>> the next incremental backup will work as normally expected, however.
>> This means that point in time =CE=B1 cannot again be referenced by the
>> management client.
>>
>> This mirrors the dynamic between "incremental" and "differential" back=
ups.
>>
>> ..hmmm..
>>
>> You know, incremental backups are just a special case of "partial" her=
e
>> where slice is the last recorded slice... Let's look at an API like th=
is:
>>
>> mode=3D<incremental|differential> bitmap=3D<name> [slice=3DN]
>>
>> Incremental: We create a new slice if the bitmap has room for one.
>> Differential: We don't create a new slice. The data in the active bitm=
ap
>> =CE=B1 does not get cleared after the bitmap operation.
>>
>> Slice:
>> If not specified, assume we want only the active slice. This is the
>> current behavior in QEMU 2.11.
>> If specified, we create a temporary merge between bitmaps [N..=CE=B1] =
and use
>> that for the backup operation.
>>
>> "Can we delete slices?"
>>
>> Sure.
>>
>> :: block-dirty-bitmap-slice-delete bitmap=3Dfoo slice=3D4
>>
>> "Can we create a slice without making a bitmap?"
>>
>> It would be easy to do, but I'm not sure I see the utility. In using i=
t,
>> it means if you don't specify the slice manually for the next backup
>> that you will necessarily be getting something not usable.
>>
>> but we COULD do it, it would just be banking the changes in the active
>> bitmap into a new slice.
>=20
> Okay, with explicit management this is getting a little more reasonable
> now. However, I don't understand what slices buy us then compared to
> just separate bitmaps.
>=20
> Essentially, bitmaps form a second kind of backing chain. Backup always
> wants to use the combined bitmaps of some subchain. I see two easy ways
> to do this: Either pass an array of bitmaps to consider to the job, or
> store the "backing link" in the bitmap so that we can just specify a
> "base bitmap" like we usually do with normal backing files.
>=20
> The backup block job can optionally append a new bitmap to the chain
> like external snapshots do for backing chains. Deleting a bitmap in the
> chain is the merge operation, similar to a commit block job for backing
> chains.
>=20
> We know these mechanism very well because the block layer has been usin=
g
> them for ages.
>=20
>>> I also have another idea:
>>> implement new object: point-in-time or checkpoint. The should have
>>> names, and the simple add/remove API.
>>> And they will be backed by dirty bitmaps. so checkpoint deletion is
>>> bitmap merge (and delete one of them),
>>> checkpoint creation is disabling of active-checkpoint-bitmap and
>>> starting new active-checkpoint-bitmap.
>>
>> Yes, exactly! I think that's pretty similar to what I am thinking of
>> with slices.
>>
>> This sounds a little safer to me in that we can examine an operation t=
o
>> see if it's sane or not.
>=20
> Exposing checkpoints is a reasonable high-level API. The important part
> then is that you don't expose bitmaps + slices, but only checkpoints
> without bitmaps. The bitmaps are an implementation detail.
>=20
>>> Then we can implement merging of several bitmaps (from one of
>>> checkpoints to current moment) in
>>> NBD meta-context-query handling.
>>>
>> Note:
>>
>> I should say that I've had discussions with Stefan in the past over
>> things like differential mode and the feeling I got from him was that =
he
>> felt that data should be copied from QEMU precisely *once*, viewing an=
y
>> subsequent copying of the same data as redundant and wasteful.
>=20
> That's a management layer decision. Apparently there are users who want
> to copy from qemu multiple times, otherwise we wouldn't be talking abou=
t
> slices and retention.
>=20
> Kevin
>=20

Sorry.

John
