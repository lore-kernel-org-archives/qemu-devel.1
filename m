Received: from eggs.gnu.org ([2001:4830:134:3::10]:45520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eOKAn-0004Hx-1I
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eOKAj-0006An-PZ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:14:53 -0500
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
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a9ebe7dc-f396-2819-de2c-ee45b82d190c@openvz.org>
Date: Mon, 11 Dec 2017 12:14:31 +0300
MIME-Version: 1.0
In-Reply-To: <0c66a77a-c95a-2071-9422-a2ce0622dbbe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

On 12/09/2017 03:57 AM, John Snow wrote:
> This is going to be a long one. Maybe go get a cup of coffee.
>
> On 12/07/2017 04:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 07.12.2017 03:38, John Snow wrote:
>>> I'm sorry, I don't think I understand.
>>>
>>> "customers needs a possibility to create a backup of data changed since
>>> some point in time."
>>>
>>> Is that not the existing case for a simple incremental backup? Granted,
>>> the point in time was decided when we created the bitmap or when we mad=
e
>>> the last backup, but it is "since some point in time."
>>>
>>> If you mean to say an arbitrary point in time after-the-fact, I don't
>>> see how the API presented here helps enable that functionality.
>>>
>>> (by "arbitrary point in time after-the-fact I mean for example: Say a
>>> user installs a malicious application in a VM on Thursday, but the
>>> bitmap was created on Monday. The user wants to go back to Wednesday
>>> evening, but we have no record of that point in time, so we cannot go
>>> back to it.)
>>>
>>> Can you elaborate on what you're trying to accomplish so I make sure I'=
m
>>> considering you carefully?
>> Yes, point in time is when we create a dirty bitmap. But we want to
>> maintain several points in time.
>> For example it may be last 10 incremental backups.
>> User wants an ability to create incremental backup which will contain
>> changes from selected point in
>> time to current moment. It is needed for example if backup was deleted
>> (to save disk space) and now user
>> wants to recreate it.
>>
>> In current scheme for incremental backup, after successful backup we
>> actually lose previous point in time,
>> and have only the last one.
> Differential backup mode may help a little in this flexibility and costs
> us basically nothing to implement:
>
> We simply always re-merge the bitmaps after creating the backup. So you
> have two options:
>
> (1) Incremental: Replace the existing point-in-time with a new one
> (2) Differential: Keep the existing point-in-time.
>
> I suspect you are wanting something a lot more powerful than this, though=
.
>
>> With ability to merge bitmap we can do the following:
>>
>> 1. create bitmap1
>> 2. disable bitmap1, do external backup by bitmap1, create bitmap2
>> 2.1 on backup fail: merge bitmap2 to bitmap1, enable bitmap1, delete
>> bitmap2
>> 2.2 on backup success: do nothing
> Okay, so bitmap1 and bitmap2 cover periods of time that are disjoint;
> where you have
>
> ----time--------------->
> [bitmap1][bitmap2....-->
>
> so you intend to accrue a number of bitmaps representing the last N
> slices of time, with only the most recent bitmap being enabled.
>
> Functionally you intend to permanently fork a bitmap every time a backup
> operation succeeds; so on incremental backup:
>
> (1) We succeed and the forked bitmap we already made gets saved as a new
> disabled bitmap instead of being deleted.
> (2) We fail, and we roll back exactly as we always have.
>
>
> Here's an idea of what this API might look like without revealing
> explicit merge/split primitives.
>
> A new bitmap property that lets us set retention:
>
> :: block-dirty-bitmap-set-retention bitmap=3Dfoo slices=3D10
>
> Or something similar, where the default property for all bitmaps is zero
> -- the current behavior: no copies retained.
>
> By setting it to a non-zero positive integer, the incremental backup
> mode will automatically save a disabled copy when possible.
>
> "What happens if we exceed our retention?"
>
> (A) We push the last one out automatically, or
> (B) We fail the operation immediately.
>
> A is more convenient, but potentially unsafe if the management tool or
> user wasn't aware that was going to happen.
> B is more annoying, but definitely more safe as it means we cannot lose
> a bitmap accidentally.
>
> I would argue for B with perhaps a force-cycle=3Dtrue|false that defaults
> to false to let management tools say "Yes, go ahead, remove the old one"
> with additionally some return to let us know it happened:
>
> {"return": {
>   "dropped-slices": [ {"bitmap0": 0}, ...]
> }}
>
> This would introduce some concept of bitmap slices into the mix as ID'd
> children of a bitmap. I would propose that these slices are numbered and
> monotonically increasing. "bitmap0" as an object starts with no slices,
> but every incremental backup creates slice 0, slice 1, slice 2, and so
> on. Even after we start deleting some, they stay ordered. These numbers
> then stand in for points in time.
>
> The counter can (must?) be reset and all slices forgotten when
> performing a full backup while providing a bitmap argument.
>
> "How can a user make use of the slices once they're made?"
>
> Let's consider something like mode=3Dpartial in contrast to
> mode=3Dincremental, and an example where we have 6 prior slices:
> 0,1,2,3,4,5, (and, unnamed, the 'active' slice.)
>
> mode=3Dpartial bitmap=3Dfoo slice=3D4
>
> This would create a backup from slice 4 to the current time =CE=B1. This
> includes all clusters from 4, 5, and the active bitmap.
>
> I don't think it is meaningful to define any end point that isn't the
> current time, so I've omitted that as a possibility.
>
> "Does a partial backup create a new point in time?"
>
> If yes: This means that the next incremental backup must necessarily be
> based off of the last partial backup that was made. This seems a little
> inconvenient. This would mean that point in time =CE=B1 becomes "slice 6.=
"
>
> If no: This means that we lose the point in time when we made the
> partial and we cannot chain off of the partial backup. It does mean that
> the next incremental backup will work as normally expected, however.
> This means that point in time =CE=B1 cannot again be referenced by the
> management client.
>
> This mirrors the dynamic between "incremental" and "differential" backups=
.
>
> ..hmmm..
>
> You know, incremental backups are just a special case of "partial" here
> where slice is the last recorded slice... Let's look at an API like this:
>
> mode=3D<incremental|differential> bitmap=3D<name> [slice=3DN]
>
> Incremental: We create a new slice if the bitmap has room for one.
> Differential: We don't create a new slice. The data in the active bitmap
> =CE=B1 does not get cleared after the bitmap operation.
>
> Slice:
> If not specified, assume we want only the active slice. This is the
> current behavior in QEMU 2.11.
> If specified, we create a temporary merge between bitmaps [N..=CE=B1] and=
 use
> that for the backup operation.
>
> "Can we delete slices?"
>
> Sure.
>
> :: block-dirty-bitmap-slice-delete bitmap=3Dfoo slice=3D4
>
> "Can we create a slice without making a bitmap?"
>
> It would be easy to do, but I'm not sure I see the utility. In using it,
> it means if you don't specify the slice manually for the next backup
> that you will necessarily be getting something not usable.
>
> but we COULD do it, it would just be banking the changes in the active
> bitmap into a new slice.
>
>> 3. disable bitmap2, do external backup by bitmap2, create bitmap3
>> 3.1 on backup fail: merge bitmap3 to bitmap2, enable bitmap2, delete
>> bitmap3
>> 3.2 on backup success: do nothing
>> ...
>>
>> so, we have disabled bitmaps bitmap_i, corresponding to difference
>> between points in time i and i+1
>> and if user wants to get data, changed from point in time number j, he
>> just merges bitmaps from
>> bitmap_j to the last(active) one to the new bitmap bitmap_temp and
>> create corresponding backup.
>>
> Roger.
>
>> instead of storing several disabled bitmaps we can store enabled
>> bitmaps, in this case we will not need
>> merge operation but instead we can implement copy operation. However
>> maintaining disabled bitmaps
>> is better, as we can then implement storing them to the qcow2 image, to
>> save RAM space.
>>
> OK, I understand what you meant by this now. It's definitely preferable
> to have inert bitmaps we don't have to worry about updating identically.
> I don't know how many checkpoints you intend to accrue, but if it's more
> than a few then the update cost on every single write may become measurab=
le.
>
>> I also have another idea:
>> implement new object: point-in-time or checkpoint. The should have
>> names, and the simple add/remove API.
>> And they will be backed by dirty bitmaps. so checkpoint deletion is
>> bitmap merge (and delete one of them),
>> checkpoint creation is disabling of active-checkpoint-bitmap and
>> starting new active-checkpoint-bitmap.
>>
> Yes, exactly! I think that's pretty similar to what I am thinking of
> with slices.
>
> This sounds a little safer to me in that we can examine an operation to
> see if it's sane or not.
>
>> Then we can implement merging of several bitmaps (from one of
>> checkpoints to current moment) in
>> NBD meta-context-query handling.
>>
> Note:
>
> I should say that I've had discussions with Stefan in the past over
> things like differential mode and the feeling I got from him was that he
> felt that data should be copied from QEMU precisely *once*, viewing any
> subsequent copying of the same data as redundant and wasteful.
>
> Once data is copied out of QEMU and it becomes inert, it should be up to
> the management utility to handle re-configuring that data in different
> forms, perhaps using bitmaps copied out alongside the initial task.
> (e.g. combining multiple incrementals into a 'differential' instead of
> allowing a differential mode.)
>
> I think his viewpoint was that copying data from QEMU is expensive and
> necessarily harder and less flexible than manipulating inert data; so he
> would prefer to see offline operations provide flexibility when possible.
>
> (Stefan, do I misrepresent your sentiment?)
>
> Maybe there's some sympathy to "What if we lose the backup, though?"
> however. I'm not against increased flexibility, but you might need to
> explain why incremental backups previously made have a reason for being
> deleted or lost.
>
>
> Did you finish your cup of coffee?
>
> --John
Guys,

the situation on our side is quite simple. Backup vendor who is trying
to integrate with us is setting fancy requirements. They have the
workflow which is integrated with several other hypervisors and
for sure they do not want to have different workflow if possible.
Actually this would be a good point for us as the closer API to
others we can provide without losing our quality/flexibility etc
more people will use QEMU as we will have more solutions.

QEMU always provide low-level API for management and does not
make any decisions. This is fine. Thus it would be nice to follow that
way again and again.

So, I do not understand why we can not provide direct access to
management. They always know better what to do in the current
approach and the simpler the interface will be, the better will be
their life.

Can we avoid to do complex things when simple alternatives are
available?

Den
