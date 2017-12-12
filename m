Received: from eggs.gnu.org ([2001:4830:134:3::10]:42800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOsq9-0002sJ-BA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 17:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOsq6-0000dE-Vx
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 17:15:53 -0500
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
	<b0ff2336-6856-0f60-64eb-6b1a889b5085@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4d993ea6-9f86-b700-a4e5-fb7434a70cd8@redhat.com>
Date: Tue, 12 Dec 2017 17:15:35 -0500
MIME-Version: 1.0
In-Reply-To: <b0ff2336-6856-0f60-64eb-6b1a889b5085@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, dev@acronis.com



On 12/11/2017 07:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.12.2017 14:15, Kevin Wolf wrote:
>> Am 09.12.2017 um 01:57 hat John Snow geschrieben:
>>> Here's an idea of what this API might look like without revealing
>>> explicit merge/split primitives.
>>>
>>> A new bitmap property that lets us set retention:
>>>
>>> :: block-dirty-bitmap-set-retention bitmap=3Dfoo slices=3D10
>>>
>>> Or something similar, where the default property for all bitmaps is
>>> zero -- the current behavior: no copies retained.
>>>
>>> By setting it to a non-zero positive integer, the incremental backup
>>> mode will automatically save a disabled copy when possible.
>> -EMAGIC
>>
>> Operations that create or delete user-visible objects should be
>> explicit, not automatic. You're trying to implement management layer
>> functionality in qemu here, but incomplete enough that the artifacts o=
f
>> it are still visible externally. (A complete solution within qemu
>> wouldn't expose low-level concepts such as bitmaps on an external
>> interface, but you would expose something like checkpoints.)
>>
>> Usually it's not a good idea to have a design where qemu implements
>> enough to restrict management tools to whatever use case we had in min=
d,
>> but not enough to make the management tool's life substantially easier
>> (by not having to care about some low-level concepts).
>>
>>> "What happens if we exceed our retention?"
>>>
>>> (A) We push the last one out automatically, or
>>> (B) We fail the operation immediately.
>>>
>>> A is more convenient, but potentially unsafe if the management tool o=
r
>>> user wasn't aware that was going to happen.
>>> B is more annoying, but definitely more safe as it means we cannot lo=
se
>>> a bitmap accidentally.
>> Both mean that the management layer has not only to deal with the
>> deletion of bitmaps as it wants to have them, but also to keep the
>> retention counter somewhere and predict what qemu is going to do to th=
e
>> bitmaps and whether any corrective action needs to be taken.
>>
>> This is making things more complex rather than simpler.
>>
>>> I would argue for B with perhaps a force-cycle=3Dtrue|false that defa=
ults
>>> to false to let management tools say "Yes, go ahead, remove the old o=
ne"
>>> with additionally some return to let us know it happened:
>>>
>>> {"return": {
>>> =C2=A0=C2=A0 "dropped-slices": [ {"bitmap0": 0}, ...]
>>> }}
>>>
>>> This would introduce some concept of bitmap slices into the mix as ID=
'd
>>> children of a bitmap. I would propose that these slices are numbered =
and
>>> monotonically increasing. "bitmap0" as an object starts with no slice=
s,
>>> but every incremental backup creates slice 0, slice 1, slice 2, and s=
o
>>> on. Even after we start deleting some, they stay ordered. These numbe=
rs
>>> then stand in for points in time.
>>>
>>> The counter can (must?) be reset and all slices forgotten when
>>> performing a full backup while providing a bitmap argument.
>>>
>>> "How can a user make use of the slices once they're made?"
>>>
>>> Let's consider something like mode=3Dpartial in contrast to
>>> mode=3Dincremental, and an example where we have 6 prior slices:
>>> 0,1,2,3,4,5, (and, unnamed, the 'active' slice.)
>>>
>>> mode=3Dpartial bitmap=3Dfoo slice=3D4
>>>
>>> This would create a backup from slice 4 to the current time =CE=B1. T=
his
>>> includes all clusters from 4, 5, and the active bitmap.
>>>
>>> I don't think it is meaningful to define any end point that isn't the
>>> current time, so I've omitted that as a possibility.
>> John, what are you doing here? This adds option after option, and even
>> additional slice object, only complicating an easy thing more and more=
.
>> I'm not sure if that was your intention, but I feel I'm starting to
>> understand better how Linus's rants come about.
>>
>> Let me summarise what this means for management layer:
>>
>> * The management layer has to manage bitmaps. They have direct control
>> =C2=A0=C2=A0 over creation and deletion of bitmaps. So far so good.
>>
>> * It also has to manage slices in those bitmaps objects; and these
>> =C2=A0=C2=A0 slices are what contains the actual bitmaps. In order to =
identify a
>> =C2=A0=C2=A0 bitmap in qemu, you need:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 a) the node name
>> =C2=A0=C2=A0=C2=A0=C2=A0 b) the bitmap ID, and
>> =C2=A0=C2=A0=C2=A0=C2=A0 c) the slice number
>>
>> =C2=A0=C2=A0 The slice number is assigned by qemu and libvirt has to w=
ait until
>> =C2=A0=C2=A0 qemu tells it about the slice number of a newly created s=
lice. If
>> =C2=A0=C2=A0 libvirt doesn't receive the reply to the command that sta=
rted the
>> =C2=A0=C2=A0 block job, it needs to be able to query this information =
from qemu,
>> =C2=A0=C2=A0 e.g. in query-block-jobs.
>>
>> * Slices are automatically created when you start a backup job with a
>> =C2=A0=C2=A0 bitmap. It doesn't matter whether you even intend to do a=
n incremental
>> =C2=A0=C2=A0 backup against this point in time. qemu knows better.
>>
>> * In order to delete a slice that you don't need any more, you have to
>> =C2=A0=C2=A0 create more slices (by doing more backups), but you don't=
 get to
>> =C2=A0=C2=A0 decide which one is dropped. qemu helpfully just drops th=
e oldest one.
>> =C2=A0=C2=A0 It doesn't matter if you want to keep an older one so you=
 can do an
>> =C2=A0=C2=A0 incremental backup for a longer timespan. Don't worry abo=
ut your
>> =C2=A0=C2=A0 backup strategy, qemu knows better.
>>
>> * Of course, just creating a new backup job doesn't mean that removing
>> =C2=A0=C2=A0 the old slice works, even if you give the respective opti=
on. That's
>> =C2=A0=C2=A0 what the 'dropped-slices' return is for. So once again wa=
it for
>> =C2=A0=C2=A0 whatever qemu did and reproduce it in the data structures=
 of the
>> =C2=A0=C2=A0 management tool. It's also more information that needs to=
 be exposed
>> =C2=A0=C2=A0 in query-block-jobs because libvirt might miss the return=
 value.
>>
>> * Hmm... What happens if you start n backup block jobs, with n > slice=
s?
>> =C2=A0=C2=A0 Sounds like a great way to introduce subtle bugs in both =
qemu and the
>> =C2=A0=C2=A0 management layer.
>>
>> Do you really think working with this API would be fun for libvirt?
>>
>>> "Does a partial backup create a new point in time?"
>>>
>>> If yes: This means that the next incremental backup must necessarily =
be
>>> based off of the last partial backup that was made. This seems a litt=
le
>>> inconvenient. This would mean that point in time =CE=B1 becomes "slic=
e 6."
>> Or based off any of the previous points in time, provided that qemu
>> didn't helpfully decide to delete it. Can't I still create a backup
>> starting from slice 4 then?
>>
>> Also, a more general question about incremental backup: How does it pl=
ay
>> with snapshots? Shouldn't we expect that people sometimes use both
>> snapshots and backups? Can we restrict the backup job to considering
>> bitmaps only from a single node or should we be able to reference
>> bitmaps of a backing file as well?
>>
>>> If no: This means that we lose the point in time when we made the
>>> partial and we cannot chain off of the partial backup. It does mean t=
hat
>>> the next incremental backup will work as normally expected, however.
>>> This means that point in time =CE=B1 cannot again be referenced by th=
e
>>> management client.
>>>
>>> This mirrors the dynamic between "incremental" and "differential"
>>> backups.
>>>
>>> ..hmmm..
>>>
>>> You know, incremental backups are just a special case of "partial" he=
re
>>> where slice is the last recorded slice... Let's look at an API like
>>> this:
>>>
>>> mode=3D<incremental|differential> bitmap=3D<name> [slice=3DN]
>>>
>>> Incremental: We create a new slice if the bitmap has room for one.
>>> Differential: We don't create a new slice. The data in the active bit=
map
>>> =CE=B1 does not get cleared after the bitmap operation.
>>>
>>> Slice:
>>> If not specified, assume we want only the active slice. This is the
>>> current behavior in QEMU 2.11.
>>> If specified, we create a temporary merge between bitmaps [N..=CE=B1]=
 and use
>>> that for the backup operation.
>>>
>>> "Can we delete slices?"
>>>
>>> Sure.
>>>
>>> :: block-dirty-bitmap-slice-delete bitmap=3Dfoo slice=3D4
>>>
>>> "Can we create a slice without making a bitmap?"
>>>
>>> It would be easy to do, but I'm not sure I see the utility. In using =
it,
>>> it means if you don't specify the slice manually for the next backup
>>> that you will necessarily be getting something not usable.
>>>
>>> but we COULD do it, it would just be banking the changes in the activ=
e
>>> bitmap into a new slice.
>> Okay, with explicit management this is getting a little more reasonabl=
e
>> now. However, I don't understand what slices buy us then compared to
>> just separate bitmaps.
>>
>> Essentially, bitmaps form a second kind of backing chain. Backup alway=
s
>> wants to use the combined bitmaps of some subchain. I see two easy way=
s
>> to do this: Either pass an array of bitmaps to consider to the job, or
>> store the "backing link" in the bitmap so that we can just specify a
>> "base bitmap" like we usually do with normal backing files.
>>
>> The backup block job can optionally append a new bitmap to the chain
>> like external snapshots do for backing chains. Deleting a bitmap in th=
e
>> chain is the merge operation, similar to a commit block job for backin=
g
>> chains.
>>
>> We know these mechanism very well because the block layer has been usi=
ng
>> them for ages.
>>
>>>> I also have another idea:
>>>> implement new object: point-in-time or checkpoint. The should have
>>>> names, and the simple add/remove API.
>>>> And they will be backed by dirty bitmaps. so checkpoint deletion is
>>>> bitmap merge (and delete one of them),
>>>> checkpoint creation is disabling of active-checkpoint-bitmap and
>>>> starting new active-checkpoint-bitmap.
>>> Yes, exactly! I think that's pretty similar to what I am thinking of
>>> with slices.
>>>
>>> This sounds a little safer to me in that we can examine an operation =
to
>>> see if it's sane or not.
>> Exposing checkpoints is a reasonable high-level API. The important par=
t
>> then is that you don't expose bitmaps + slices, but only checkpoints
>> without bitmaps. The bitmaps are an implementation detail.
>>
>>>> Then we can implement merging of several bitmaps (from one of
>>>> checkpoints to current moment) in
>>>> NBD meta-context-query handling.
>>>>
>>> Note:
>>>
>>> I should say that I've had discussions with Stefan in the past over
>>> things like differential mode and the feeling I got from him was that=
 he
>>> felt that data should be copied from QEMU precisely *once*, viewing a=
ny
>>> subsequent copying of the same data as redundant and wasteful.
>> That's a management layer decision. Apparently there are users who wan=
t
>> to copy from qemu multiple times, otherwise we wouldn't be talking abo=
ut
>> slices and retention.
>>
>> Kevin
>=20
> You didn't touch storing-to-qcow2 and migration, which we will have to
> implement for
> these bitmap-like objects.
>=20
> By exposing low level merge/disable/enable we solve all the problem by
> less code and
> without negotiation the architecture. We avoid:
> =C2=A0- implementing new job
> =C2=A0- implementing new objects (checkpoints) and new interface for th=
em
> =C2=A0- saving these new objects to qcow2
> =C2=A0- migration of them
>=20
> Also, even if we open merge/disable/enable interface, we can implement
> checkpoints or slices
> in future, if we will be _sure_ that we need them.
>=20
> Also, I don't see what is unsafe with implementing this simple low-leve=
l
> API.
> We already have bitmaps deletion. Is it safe?
>=20
>=20

Just scrap the whole thought.
