Received: from eggs.gnu.org ([2001:4830:134:3::10]:41450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fs30Y-0001ID-Ft
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fs2zS-0004Ti-Fp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:30:22 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
	<abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
	<052a0e73-bef5-7ee8-5e24-3c96907247f7@virtuozzo.com>
	<78730056-1612-ba4f-af74-42c4c2f2ecf3@redhat.com>
	<d6d5b315-d058-91b2-e11a-7a6fe1ec33fd@virtuozzo.com>
	<7913fa3b-e50a-b508-848b-dd5b8419bdbb@redhat.com>
	<eeebc193-3383-450c-d3ab-b3c47dae8215@virtuozzo.com>
Message-ID: <49d7c37e-e146-29c7-df75-7720e384ab61@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:29:50 +0300
MIME-Version: 1.0
In-Reply-To: <eeebc193-3383-450c-d3ab-b3c47dae8215@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v2] new, node-graph-based fleecing and backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org

20.08.2018 21:30, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2018 20:25, Max Reitz wrote:
>> On 2018-08-20 16:49, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.08.2018 16:32, Max Reitz wrote:
>>>> On 2018-08-20 11:42, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 18.08.2018 00:50, Max Reitz wrote:
>>>>>> On 2018-08-14 19:01, Vladimir Sementsov-Ogievskiy wrote:
>>>> [...]
>>>>
>>>>>>> Proposal:
>>>>>>>
>>>>>>> For fleecing we need two nodes:
>>>>>>>
>>>>>>> 1. fleecing hook. It's a filter which should be inserted on top=20
>>>>>>> of active
>>>>>>> disk. It's main purpose is handling guest writes by=20
>>>>>>> copy-on-write operation,
>>>>>>> i.e. it's a substitution for write-notifier in backup job.
>>>>>>>
>>>>>>> 2. fleecing cache. It's a target node for COW operations by=20
>>>>>>> fleecing-hook.
>>>>>>> It also represents a point-in-time snapshot of active disk for=20
>>>>>>> the readers.
>>>>>> It's not really COW, it's copy-before-write, isn't it? It's=20
>>>>>> something
>>>>>> else entirely.=C2=A0 COW is about writing data to an overlay *instea=
d* of
>>>>>> writing it to the backing file.=C2=A0 Ideally, you don't copy anythi=
ng,
>>>>>> actually.=C2=A0 It's just a side effect that you need to copy things=
=20
>>>>>> if your
>>>>>> cluster size doesn't happen to match exactly what you're=20
>>>>>> overwriting.
>>>>> Hmm. I'm not against. But COW term was already used in backup to
>>>>> describe this.
>>>> Bad enough. :-)
>>> So, we agreed about new "CBW" abbreviation? :)
>> It is already used for the USB mass-storage command block wrapper, but I
>> suppose that is sufficiently different not to cause much confusion. :-)
>>
>> (Or at least that's the only other use I know of.)
>>
>> [...]
>>
>>>>> 2. We already have fleecing scheme, when we should create some=20
>>>>> subgraph
>>>>> between nodes.
>>>> Yes, but how do the permissions work right now, and why wouldn't they
>>>> work with your schema?
>>> now it uses backup job, with shared_perm =3D all for its source and=20
>>> target
>>> nodes.
>> Uh-huh.
>>
>> So the issue is...=C2=A0 Hm, what exactly?=C2=A0 The backup node probabl=
y doesn't
>> want to share WRITE for the source anymore, as there is no real point in
>> doing so.=C2=A0 And for the target, the only problem may be to share
>> CONSISTENT_READ.=C2=A0 It is OK to share that in the fleecing case, but =
in
>> other cases maybe it isn't.=C2=A0 But that's easy enough to distinguish =
in
>> the driver.
>>
>> The main issue I could see is that the overlay (the fleecing target)
>> might not share write permissions on its backing file (the fleecing
>> source)...=C2=A0 But your diagram shows (and bdrv_format_default_perms()=
 as
>> well) that this is no the case, when the overlay is writable, the
>> backing file may be written to, too.
>
> Hm, actually overlay may share write permission to clusters which are=20
> saved in overlay, or which are not needed (if we have dirty bitmap for=20
> incremental backup).. But we don't have such permission kind, and it=20
> looks not easy to implement it... And it may be too expensive in=20
> operation overhead.
>
>>
>>> (ha, you can look at the picture in "[PATCH v2 0/3] block nodes
>>> graph visualization")
>> :-)
>>
>>>>> 3. If we move to filter-node instead of write_notifier, block job=20
>>>>> is not
>>>>> actually needed for fleecing, and it is good to drop it from the
>>>>> fleecing scheme, to simplify it, to make it more clear and=20
>>>>> transparent.
>>>> If that's possible, why not.=C2=A0 But again, I'm not sure whether tha=
t's
>>>> enough of a reason for the endavour, because whether you start a block
>>>> job or do some graph manipulation yourself is not really a=20
>>>> difference in
>>>> complexity.
>>> not "or" but "and": in current fleecing scheme we do both graph
>>> manipulations and block-job stat/cancel..
>> Hm!=C2=A0 Interesting.=C2=A0 I didn't know blockdev-backup didn't set th=
e target's
>> backing file.=C2=A0 It makes sense, but I didn't think about it.
>>
>> Well, still, my point was whether you do a blockdev-backup +
>> block-job-cancel, or a blockdev-add + blockdev-reopen + blockdev-reopen
>> + blockdev-del...=C2=A0 If there is a difference, the former is going to=
 be
>> simpler, probably.
>>
>> (But if there are things you can't do with the current blockdev-backup,
>> then, well, that doesn't help you.)
>>
>>> Yes, I agree, that there no real benefit in difficulty. I just thing,
>>> that if we have filter node which performs "CBW" operations, block-job
>>> backup(sync=3Dnone) becomes actually empty, it will do nothing.
>> On the code side, yes, that's true.
>>
>>>> But it's mostly your call, since I suppose you'd be doing most of=20
>>>> the work.
>>>>
>>>>> And finally, we will have unified filter-node-based scheme for backup
>>>>> and fleecing, modular and customisable.
>>>> [...]
>>>>
>>>>>>> Benefits, or, what can be done:
>>>>>>>
>>>>>>> 1. We can implement special Fleecing cache filter driver, which=20
>>>>>>> will be a real
>>>>>>> cache: it will store some recently written clusters and RAM, it=20
>>>>>>> can have a
>>>>>>> backing (or file?) qcow2 child, to flush some clusters to the=20
>>>>>>> disk, etc. So,
>>>>>>> for each cluster of active disk we will have the following=20
>>>>>>> characteristics:
>>>>>>>
>>>>>>> - changed (changed in active disk since backup start)
>>>>>>> - copy (we need this cluster for fleecing user. For example, in=20
>>>>>>> RFC patch all
>>>>>>> clusters are "copy", cow_bitmap is initialized to all ones. We=20
>>>>>>> can use some
>>>>>>> existent bitmap to initialize cow_bitmap, and it will provide an=20
>>>>>>> "incremental"
>>>>>>> fleecing (for use in incremental backup push or pull)
>>>>>>> - cached in RAM
>>>>>>> - cached in disk
>>>>>> Would it be possible to implement such a filter driver that could=20
>>>>>> just
>>>>>> be used as a backup target?
>>>>> for internal backup we need backup-job anyway, and we will be able to
>>>>> create different schemes.
>>>>> One of my goals is the scheme, when we store old data from CBW
>>>>> operations into local cache, when
>>>>> backup target is remote, relatively slow NBD node. In this case,=20
>>>>> cache
>>>>> is backup source, not target.
>>>> Sorry, my question was badly worded.=C2=A0 My main point was whether y=
ou
>>>> could implement the filter driver in such a generic way that it=20
>>>> wouldn't
>>>> depend on the fleecing-hook.
>>> yes, I want my filter nodes to be self-sufficient entities. However it
>>> may be more effective to have some shared data, between them, for
>>> example, dirty-bitmaps, specifying drive clusters, to know which
>>> clusters are cached, which are changed, etc.
>> I suppose having global dirty bitmaps may make sense.
>>
>>>> Judging from your answer and from the fact that you proposed=20
>>>> calling the
>>>> filter node backup-filter and just using it for all backups, I suppose
>>>> the answer is "yes".=C2=A0 So that's good.
>>>>
>>>> (Though I didn't quite understand why in your example the cache=20
>>>> would be
>>>> the backup source, when the target is the slow node...)
>>> cache is a point-in-time view of active disk (actual source) for
>>> fleecing. So, we can start backup job to copy data from cache to=20
>>> target.
>> But wouldn't the cache need to be the immediate fleecing target for
>> this?=C2=A0 (And then you'd run another backup/mirror from it to copy th=
e
>> whole disk to the real target.)
>
> Yes, the cache is immediate fleecing target.
>
>>
>>>>>>> On top of these characteristics we can implement the following=20
>>>>>>> features:
>>>>>>>
>>>>>>> 1. COR, we can cache clusters not only on writes but on reads=20
>>>>>>> too, if we have
>>>>>>> free space in ram-cache (and if not, do not cache at all, don't=20
>>>>>>> write to
>>>>>>> disk-cache). It may be done like bdrv_write(...,=20
>>>>>>> BDRV_REQ_UNNECESARY)
>>>>>> You can do the same with backup by just putting a fast overlay=20
>>>>>> between
>>>>>> source and the backup, if your source is so slow, and then do=20
>>>>>> COR, i.e.:
>>>>>>
>>>>>> slow source --> fast overlay --> COR node --> backup filter
>>>>> How will we check ram-cache size to make COR optional in this scheme?
>>>> Yes, well, if you have a caching driver already, I suppose you can=20
>>>> just
>>>> use that.
>>>>
>>>> You could either write it a bit simpler to only cache on writes and=20
>>>> then
>>>> put a COR node on top if desired; or you implement the read cache
>>>> functionality directly in the node, which may make it a bit more
>>>> complicated, but probably also faster.
>>>>
>>>> (I guess you indeed want to go for faster when already writing a RAM
>>>> cache driver...)
>>>>
>>>> (I don't really understand what BDRV_REQ_UNNECESSARY is supposed to=20
>>>> do,
>>>> though.)
>>> When we do "CBW", we _must_ save data before guest write, so, we write
>>> this data to the cache (or directly to target, like in current=20
>>> approach).
>>> When we do "COR", we _may_ save data to our ram-cache. It's safe to not
>>> save data, as we can read it from active disk (data is not changed=20
>>> yet).
>>> BDRV_REQ_UNNECESSARY is a proposed interface to write this unnecessary
>>> data to the cache: if ram-cache is full, cache will skip this write.
>> Hm, OK...=C2=A0 But deciding for each request how much priority it shoul=
d get
>> in a potential cache node seems like an awful lot of work. Well, I
>> don't even know what kind of requests you would deem unnecessary.=C2=A0 =
If it
>> has something to do with the state of a dirty bitmap, then having global
>> dirty bitmaps might remove the need for such a request flag.
>
> Yes, if we have some "shared fleecing object", accessible by=20
> fleecing-hook filter,
> fleecing-cache filter (and backup job, if it is an internal backup),=20
> we don't need
> such flag.
>
>>
>> [...]
>>
>>>> Hm.=C2=A0 So what you want here is a special block driver or at least =
a
>>>> special interface that can give information to an outside tool, namely
>>>> the information you listed above.
>>>>
>>>> If you want information about RAM-cached clusters, well, you can only
>>>> get that information from the RAM cache driver.=C2=A0 It probably woul=
d be
>>>> allocation information, do we have any way of getting that out?
>>>>
>>>> It seems you can get all of that (zero information and allocation
>>>> information) over NBD.=C2=A0 Would that be enough?
>>> it's a most generic and clean way, but I'm not sure that it will be
>>> performance-effective.
>> Intuitively I'd agree, but I suppose if NBD is written right, such a
>> request should be very fast and the response basically just consists of
>> the allocation information, so I don't suspect it can be much faster
>> than that.
>>
>> (Unless you want some form of interrupts.=C2=A0 I suppose NBD would be t=
he
>> wrong interface, then.)
>
> Yes, for external backup through NBD it's ok to get block status, but=20
> for internal backup it seems faster to access shared fleecing object=20
> (or global bitmaps, etc).
>
> However, if we have some shared fleecing object, it's not a problem to=20
> export it as a blockstatus metadata through NBD export..
>
>>
>> [...]
>>
>>>>> I need several features, which are hard to implement using current=20
>>>>> scheme.
>>>>>
>>>>> 1. The scheme when we have a local cache as COW target and slow=20
>>>>> remote
>>>>> backup target.
>>>>> How to do it now? Using two backups, one with sync=3Dnone... Not=20
>>>>> sure that
>>>>> this is right way.
>>>> If it works...
>>>>
>>>> (I'd rather build simple building blocks that you can put together=20
>>>> than
>>>> something complicated that works for a specific solution)
>>> exactly, I want to implement simple building blocks =3D filter nodes,
>>> instead of implementing all the features in backup job.
>> Good, good. :-)
>>
>>>>> 3. Then,
>>>>> we'll need a possibility for backup(sync=3Dnone) to
>>>>> not COW clusters, which are already copied to backup, and so on.
>>>> Isn't that the same as 2?
>>> We can use one bitmap for 2 and 3, and drop bits from it, when
>>> external-tool has read corresponding cluster from nbd-fleecing-export..
>> Oh, right, it needs to be modifiable from the outside.=C2=A0 I suppose t=
hat
>> would be possible in NBD, too.=C2=A0 (But I don't know exactly.)
>
> I think it's natural to implement it through discard operation on=20
> fleecing-cache node: if fleecing-user discard something, it will not=20
> read it more and we can drop it from the cache and clear bit in shared=20
> bitmap.
>
> Then we can improve it by creating flag READ_ONCE for each READ=20
> command or for the whole connection, to discard data after each read..=20
> Or pass this flag to bdrv_read, to handle it in one command..
>
>>
>> [...]
>>
>>>>>> I don't think that will be any simpler.
>>>>>>
>>>>>> I mean, it would make blockdev-copy simpler, because we could
>>>>>> immediately replace backup by mirror, and then we just have mirror,
>>>>>> which would then automatically become blockdev-copy...
>>>>>>
>>>>>> But it's not really going to be simpler, because whether you put the
>>>>>> copy-before-write logic into a dedicated block driver, or into the
>>>>>> backup filter driver, doesn't really make it simpler either way.=C2=
=A0=20
>>>>>> Well,
>>>>>> adding a new driver always is a bit more complicated, so there's=20
>>>>>> that.
>>>>> what is the difference between separate filter driver and backup=20
>>>>> filter
>>>>> driver?
>>>> I thought we already had a backup filter node, so you wouldn't have=20
>>>> had
>>>> to create a new driver in that case.
>>>>
>>>> But we don't, so there really is no difference.=C2=A0 Well, apart from=
=20
>>>> being
>>>> able to share state easier when the driver is in the same file as=20
>>>> the job.
>>> But if we make it separate - it will be a separate "building block" to
>>> be reused in different schemes.
>> Absolutely true.
>>
>>>>>>> it should not care about guest writes, it copies clusters from a=20
>>>>>>> kind of
>>>>>>> snapshot which is not changing in time. This job should follow=20
>>>>>>> recommendations
>>>>>>> from fleecing scheme [7].
>>>>>>>
>>>>>>> What about the target?
>>>>>>>
>>>>>>> We can use separate node as target, and copy from fleecing cache=20
>>>>>>> to the target.
>>>>>>> If we have only ram-cache, it would be equal to current approach=20
>>>>>>> (data is copied
>>>>>>> directly to the target, even on COW). If we have both ram- and=20
>>>>>>> disk- caches, it's
>>>>>>> a cool solution for slow-target: instead of make guest wait for=20
>>>>>>> long write to
>>>>>>> backup target (when ram-cache is full) we can write to=20
>>>>>>> disk-cache which is local
>>>>>>> and fast.
>>>>>> Or you backup to a fast overlay over a slow target, and run a live
>>>>>> commit on the side.
>>>>> I think it will lead to larger io overhead: all clusters will go=20
>>>>> through
>>>>> overlay, not only guest-written clusters, for which we did not=20
>>>>> have time
>>>>> to copy them..
>>>> Well, and it probably makes sense to have some form of RAM-cache=20
>>>> driver.
>>>> =C2=A0 Then that'd be your fast overlay.
>>> but there no reasons to copy all the data through the cache: we need it
>>> only for CBW.
>> Well, if there'd be a RAM-cache driver, you may use it for anything that
>> seems useful (I seem to remember there were some patches on the list
>> like three or four years ago...).
>>
>>> any way, I think it will be good if both schemes will be possible.
>>>
>>>>>>> Another option is to combine fleecing cache and target somehow=20
>>>>>>> (I didn't think
>>>>>>> about this really).
>>>>>>>
>>>>>>> Finally, with one - two (three?) special filters we can=20
>>>>>>> implement all current
>>>>>>> fleecing/backup schemes in unique and very configurable way=C2=A0 a=
nd=20
>>>>>>> do a lot more
>>>>>>> cool features and possibilities.
>>>>>>>
>>>>>>> What do you think?
>>>>>> I think adding a specific fleecing target filter makes sense=20
>>>>>> because you
>>>>>> gave many reasons for interesting new use cases that could emerge=20
>>>>>> from that.
>>>>>>
>>>>>> But I think adding a new fleecing-hook driver just means moving the
>>>>>> implementation from backup to that new driver.
>>>>> But in the same time you say that it's ok to create backup-filter
>>>>> (instead of write_notifier) and make it insertable by qapi? So, if I
>>>>> implement it in block/backup, it's ok? Why not do it separately?
>>>> Because I thought we had it already.=C2=A0 But we don't.=C2=A0 So feel=
 free=20
>>>> to do
>>>> it separately. :-)
>>> Ok, that's good :) . Then, I'll try to reuse the filter in backup
>>> instead of write-notifiers, and understand do we really need internal
>>> state of backup block-job or not.
>>>
>>>> Max
>>>>
>>> PS: in background, I have unpublished work, aimed to parallelize
>>> backup-job into several coroutines (like it is done for mirror,=20
>>> qemu-img
>>> clone cmd). And it's really hard.It creates queues of requests with
>>> different priority, to handle CBW requests in common pipeline, it's
>>> mostly a rewrite of block/backup. If we split CBW from backup to
>>> separate filter-node, backup becomes very simple thing (copy clusters
>>> from constant storage) and its parallelization becomes simpler.
>> If CBW is split from backup, maybe mirror could replace backup
>> immediately.=C2=A0 You'd fleece to a RAM cache target and then mirror fr=
om=20
>> there.
>
> Hmm, good option. It would be just one mirror iteration.
> But then I'll need to=C2=A0 teach mirror to copy clusters with some=20
> priorities, to avoid ram-cache overloading (and guest io hang).
> It may be better to have a separate simple (a lot simpler than mirror)=20
> block job for it. or use a backup. Anyway, it's a separate
> building block, performance comparison will show better candidate.
>
>>
>> (To be precise: The exact replacement would be an active mirror, so a
>> mirror with copy-mode=3Dwrite-blocking, so it immediately writes the old
>> block to the target when it is changed in the source, and thus the RAM
>> cache could stay effectively empty.)
>
> Hmm, or this way. So, actually for such thing, we need a cache node=20
> which do absolutely nothing, write will be actually handled by mirror=20
> job. But in this case we cant control size of actual ram cache: if=20
> target is slow we will accumulate unfinished bdrv_mirror_top_pwritev=20
> calls, which has allocated memory and waiting in a queue to create=20
> mirror coroutine.

Oh, sorry, no. active mirror copy data synchronously on write, so, it's=20
really should be the same copy pattern as in backup.

>
>>
>>> I don't say throw the backup away, but I have several ideas, which may
>>> alter current approach. They may live in parallel with current backup
>>> path, or replace it in future, if they will be more effective.
>> Thing is, contrary to the impression I've probably given, we do want to
>> throw away backup sooner or later.=C2=A0 We want a single block job
>> (blockdev-copy) that unifies mirror, backup, and commit.
>>
>> (mirror already basically supersedes commit, with live commit just being
>> exactly mirror; the main problem is integrating backup.=C2=A0 But with a
>> fleecing node and a RAM cache target, that would suddenly be really
>> simple, I assume.)
>>
>> ((All that's missing is sync=3Dtop, where the mirror would need to not
>> only check its source (which would be the RAM cache), but also its
>> backing file; and sync=3Dincremental, which just isn't there with mirror
>> at all.=C2=A0 OTOH, it may be possible to implement both modes simply in=
 the
>> fleecing/backup node, so it only copies that respective data to the
>> target and the mirror simply sees nothing else.))
>
> Good idea. If we have fleecing-cache node as a "view" or "export", we=20
> can export only selected portions of data, marking the other as=20
> unallocated.. Or we need to share bitmaps (global bitmaps, shared=20
> fleecing state, etc) with a block-job.
>
>>
>> Max
>>
>
>


--=20
Best regards,
Vladimir
