Received: from eggs.gnu.org ([2001:4830:134:3::10]:60468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frlVN-00076v-38
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frlVH-0002vQ-3i
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:50:03 -0400
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
	<abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
	<052a0e73-bef5-7ee8-5e24-3c96907247f7@virtuozzo.com>
	<78730056-1612-ba4f-af74-42c4c2f2ecf3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d6d5b315-d058-91b2-e11a-7a6fe1ec33fd@virtuozzo.com>
Date: Mon, 20 Aug 2018 17:49:36 +0300
MIME-Version: 1.0
In-Reply-To: <78730056-1612-ba4f-af74-42c4c2f2ecf3@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

20.08.2018 16:32, Max Reitz wrote:
> On 2018-08-20 11:42, Vladimir Sementsov-Ogievskiy wrote:
>> 18.08.2018 00:50, Max Reitz wrote:
>>> On 2018-08-14 19:01, Vladimir Sementsov-Ogievskiy wrote:
> [...]
>
>>>> Proposal:
>>>>
>>>> For fleecing we need two nodes:
>>>>
>>>> 1. fleecing hook. It's a filter which should be inserted on top of active
>>>> disk. It's main purpose is handling guest writes by copy-on-write operation,
>>>> i.e. it's a substitution for write-notifier in backup job.
>>>>
>>>> 2. fleecing cache. It's a target node for COW operations by fleecing-hook.
>>>> It also represents a point-in-time snapshot of active disk for the readers.
>>> It's not really COW, it's copy-before-write, isn't it?  It's something
>>> else entirely.  COW is about writing data to an overlay *instead* of
>>> writing it to the backing file.  Ideally, you don't copy anything,
>>> actually.  It's just a side effect that you need to copy things if your
>>> cluster size doesn't happen to match exactly what you're overwriting.
>> Hmm. I'm not against. But COW term was already used in backup to
>> describe this.
> Bad enough. :-)

So, we agreed about new "CBW" abbreviation? :)

>
>>> CBW is about copying everything to the overlay, and then leaving it
>>> alone, instead writing the data to the backing file.
>>>
>>> I'm not sure how important it is, I just wanted to make a note so we
>>> don't misunderstand what's going on, somehow.
>>>
>>>
>>> The fleecing hook sounds good to me, but I'm asking myself why we don't
>>> just add that behavior to the backup filter node.  That is, re-implement
>>> backup without before-write notifiers by making the filter node actually
>>> do something (I think there was some reason, but I don't remember).
>> fleecing don't need any block-job at all, so, I think it is good to have
>> fleecing filter
>> to be separate. And then, it should be reused by internal backup.
> Sure, but we have backup now.  Throwing it out of the window and
> rewriting it just because sounds like a lot of work for not much gain.
>
>> Hm, we can call this backup-filter instead of fleecing-hook, what is the
>> difference?
> The difference would be that instead of putting it into an entirely new
> block driver, you'd move the functionality inside of block/backup.c
> (thus relieving backup from having to use the before-write notifiers as
> I described above).  That may keep the changes easier to handle.
>
> I do think it'd be cleaner, but the question is, does it really gain you
> something?  Aside from not having to start a block job, but I don't
> really consider this an issue  (it's not really more difficult to start
> a block job than to do block graph manipulation yourself).
>
> [...]
>
>>>> Ok, this works, it's an image fleecing scheme without any block jobs.
>>> So this is the goal?  Hm.  How useful is that really?
>>>
>>> I suppose technically you could allow blockdev-add'ing a backup filter
>>> node (though only with sync=none) and that would give you the same.
>> what is backup filter node?
> Ah, right...  My mistake.  I thought backup had a filter node like
> mirror and commit do.  But it wasn't necessary so far because there was
> no permission issue with backup like there was with mirror and commit.
>
> OK, so my idea would have been that basically every block job can be
> represented with a filter node that actually performs the work.  We only
> need the block job to make it perform in background.
>
> (BDSs can only do work when requested to do so, usually by a parent --
> you need a block job if you want them to continuously perform work.)
>
> But that's just my idea, it's not really how things are right now.
>
> So from that POV, having a backup-filter/fleecing-hook that actually
> performs the backup work is something I would like -- but again, I don't
> know whether it's actually important.
>
>>>> Problems with realization:
>>>>
>>>> 1 What to do with hack-permissions-node? What is a true way to implement
>>>> something like this? How to tune permissions to avoid this additional node?
>>> Hm, how is that different from what we currently do?  Because the block
>>> job takes care of it?
>> 1. As I understand, we agreed, that it is good to use filter node
>> instead of write_notifier.
> Ah, great.
>
>> 2. We already have fleecing scheme, when we should create some subgraph
>> between nodes.
> Yes, but how do the permissions work right now, and why wouldn't they
> work with your schema?

now it uses backup job, with shared_perm = all for its source and target 
nodes. (ha, you can look at the picture in "[PATCH v2 0/3] block nodes 
graph visualization")

>
>> 3. If we move to filter-node instead of write_notifier, block job is not
>> actually needed for fleecing, and it is good to drop it from the
>> fleecing scheme, to simplify it, to make it more clear and transparent.
> If that's possible, why not.  But again, I'm not sure whether that's
> enough of a reason for the endavour, because whether you start a block
> job or do some graph manipulation yourself is not really a difference in
> complexity.

not "or" but "and": in current fleecing scheme we do both graph 
manipulations and block-job stat/cancel..

Yes, I agree, that there no real benefit in difficulty. I just thing, 
that if we have filter node which performs "CBW" operations, block-job 
backup(sync=none) becomes actually empty, it will do nothing.

>
> But it's mostly your call, since I suppose you'd be doing most of the work.
>
>> And finally, we will have unified filter-node-based scheme for backup
>> and fleecing, modular and customisable.
> [...]
>
>>>> Benefits, or, what can be done:
>>>>
>>>> 1. We can implement special Fleecing cache filter driver, which will be a real
>>>> cache: it will store some recently written clusters and RAM, it can have a
>>>> backing (or file?) qcow2 child, to flush some clusters to the disk, etc. So,
>>>> for each cluster of active disk we will have the following characteristics:
>>>>
>>>> - changed (changed in active disk since backup start)
>>>> - copy (we need this cluster for fleecing user. For example, in RFC patch all
>>>> clusters are "copy", cow_bitmap is initialized to all ones. We can use some
>>>> existent bitmap to initialize cow_bitmap, and it will provide an "incremental"
>>>> fleecing (for use in incremental backup push or pull)
>>>> - cached in RAM
>>>> - cached in disk
>>> Would it be possible to implement such a filter driver that could just
>>> be used as a backup target?
>> for internal backup we need backup-job anyway, and we will be able to
>> create different schemes.
>> One of my goals is the scheme, when we store old data from CBW
>> operations into local cache, when
>> backup target is remote, relatively slow NBD node. In this case, cache
>> is backup source, not target.
> Sorry, my question was badly worded.  My main point was whether you
> could implement the filter driver in such a generic way that it wouldn't
> depend on the fleecing-hook.

yes, I want my filter nodes to be self-sufficient entities. However it 
may be more effective to have some shared data, between them, for 
example, dirty-bitmaps, specifying drive clusters, to know which 
clusters are cached, which are changed, etc.

>
> Judging from your answer and from the fact that you proposed calling the
> filter node backup-filter and just using it for all backups, I suppose
> the answer is "yes".  So that's good.
>
> (Though I didn't quite understand why in your example the cache would be
> the backup source, when the target is the slow node...)

cache is a point-in-time view of active disk (actual source) for 
fleecing. So, we can start backup job to copy data from cache to target.

>
>>>> On top of these characteristics we can implement the following features:
>>>>
>>>> 1. COR, we can cache clusters not only on writes but on reads too, if we have
>>>> free space in ram-cache (and if not, do not cache at all, don't write to
>>>> disk-cache). It may be done like bdrv_write(..., BDRV_REQ_UNNECESARY)
>>> You can do the same with backup by just putting a fast overlay between
>>> source and the backup, if your source is so slow, and then do COR, i.e.:
>>>
>>> slow source --> fast overlay --> COR node --> backup filter
>> How will we check ram-cache size to make COR optional in this scheme?
> Yes, well, if you have a caching driver already, I suppose you can just
> use that.
>
> You could either write it a bit simpler to only cache on writes and then
> put a COR node on top if desired; or you implement the read cache
> functionality directly in the node, which may make it a bit more
> complicated, but probably also faster.
>
> (I guess you indeed want to go for faster when already writing a RAM
> cache driver...)
>
> (I don't really understand what BDRV_REQ_UNNECESSARY is supposed to do,
> though.)

When we do "CBW", we _must_ save data before guest write, so, we write 
this data to the cache (or directly to target, like in current approach).
When we do "COR", we _may_ save data to our ram-cache. It's safe to not 
save data, as we can read it from active disk (data is not changed yet). 
BDRV_REQ_UNNECESSARY is a proposed interface to write this unnecessary 
data to the cache: if ram-cache is full, cache will skip this write.

>
>>>> 2. Benefit for guest: if cluster is unchanged and ram-cached, we can skip reading
>>>> from the devise
>>>>
>>>> 3. If needed, we can drop unchanged ram-cached clusters from ram-cache
>>>>
>>>> 4. On guest write, if cluster is already cached, we just mark it "changed"
>>>>
>>>> 5. Lazy discards: in some setups, discards are not guaranteed to do something,
>>>> so, we can at least defer some discards to the end of backup, if ram-cache is
>>>> full.
>>>>
>>>> 6. We can implement discard operation in fleecing cache, to make cluster
>>>> not needed (drop from cache, drop "copy" flag), so further reads of this
>>>> cluster will return error. So, fleecing client may read cluster by cluster
>>>> and discard them to reduce COW-load of the drive. We even can combine read
>>>> and discard into one command, something like "read-once", or it may be a
>>>> flag for fleecing-cache, that all reads are "read-once".
>>> That would definitely be possible with a dedicated fleecing backup
>>> target filter (and normal backup).
>> target-filter schemes will not work for external-backup..
> I thought you were talking about what you could do with the node schema
> you gave above, i.e. inside of qemu itself.
>
>>>> 7. We can provide recommendations, on which clusters should fleecing-client
>>>> copy first. Examples:
>>>> a. copy ram-cached clusters first (obvious, to unload cache and reduce io
>>>>     overhead)
>>>> b. copy zero-clusters last (the don't occupy place in cache, so, lets copy
>>>>     other clusters first)
>>>> c. copy disk-cached clusters list (if we don't care about disk space,
>>>>     we can say, that for disk-cached clusters we already have a maximum
>>>>     io overhead, so let's copy other clusters first)
>>>> d. copy disk-cached clusters with high priority (but after ram-cached) -
>>>>     if we don't have enough disk space
>>>>
>>>> So, there is a wide range of possible politics. How to provide these
>>>> recommendations?
>>>> 1. block_status
>>>> 2. create separate interface
>>>> 3. internal backup job may access shared fleecing object directly.
>>> Hm, this is a completely different question now.  Sure, extending backup
>>> or mirror (or a future blockdev-copy) would make it easiest for us.  But
>>> then again, if you want to copy data off a point-in-time snapshot of a
>>> volume, you can just use normal backup anyway, right?
>> right. but how to implement all the features I listed? I see the way to
>> implement them with help of two special filters. And backup job will be
>> used anyway (without write-notifiers) for internal backup and will not
>> be used for external backup (fleecing).
> Hm.  So what you want here is a special block driver or at least a
> special interface that can give information to an outside tool, namely
> the information you listed above.
>
> If you want information about RAM-cached clusters, well, you can only
> get that information from the RAM cache driver.  It probably would be
> allocation information, do we have any way of getting that out?
>
> It seems you can get all of that (zero information and allocation
> information) over NBD.  Would that be enough?

it's a most generic and clean way, but I'm not sure that it will be 
performance-effective.

>
>>> So I'd say the purpose of fleecing is that you have an external tool
>>> make use of it.  Since my impression was that you'd just access the
>>> volume externally and wouldn't actually copy all of the data off of it
>> not quite right. People use fleecing to implement external backup,
>> managed by their third-party tool, which they want to use instead of
>> internal backup. And they do copy all the data. I cant describe all the
>> reasons, but example is custom storage for backup, which external tool
>> can manage and Qemu can't.
>> So, fleecing is used for external backups (or pull backups).
> Hm, OK.  I understand.
>
>>> (because that's what you could use the backup job for), I don't think I
>>> can say much here, because my impression seems to have been wrong.
>>>
>>>> About internal backup:
>>>> Of course, we need a job which will copy clusters. But it will be simplified:
>>> So you want to completely rebuild backup based on the fact that you
>>> specifically have fleecing now?
>> I need several features, which are hard to implement using current scheme.
>>
>> 1. The scheme when we have a local cache as COW target and slow remote
>> backup target.
>> How to do it now? Using two backups, one with sync=none... Not sure that
>> this is right way.
> If it works...
>
> (I'd rather build simple building blocks that you can put together than
> something complicated that works for a specific solution)

exactly, I want to implement simple building blocks = filter nodes, 
instead of implementing all the features in backup job.

>
>> 2. Then, we'll need support for bitmaps in backup (sync=none).
> What do you mean by that?  You've written about using bitmaps with
> fleecing before, but actually I didn't understand that.
>
> Do you want to expose a bitmap for the external tool so it knows what it
> should copy, and then use that bitmap during fleecing, too, because you
> know you don't have to save the non-dirty clusters because the backup
> tool isn't going to look at them anyway?

yes.

>
> In that case, sure, that is just impossible right now, but it doesn't
> seem like it needs to be.  Adding dirty bitmap support to sync=none
> doesn't seem too hard.  (Or adding it to your schema.)
>
>> 3. Then,
>> we'll need a possibility for backup(sync=none) to
>> not COW clusters, which are already copied to backup, and so on.
> Isn't that the same as 2?

We can use one bitmap for 2 and 3, and drop bits from it, when 
external-tool has read corresponding cluster from nbd-fleecing-export..

>
>> If we want a backup-filter anyway, why not to implement some cool
>> features on top of it?
> Sure, but the question is whether you need to rebuild backup for that. :-)
>
> To me, it just sounded a bit wrong to start over from the fleecing side
> of things, re-implement all of backup there (effectively), and then
> re-implement backup on top of it.
>
> But maybe it is the right way to go.  I can certainly see nothing
> absolutely wrong with putting the CBW logic into a backup filter (be it
> backup-filter or fleecing-hook), and then it makes sense to just use
> that filter node in the backup job.  It's just work, which I don't know
> whether it's necessary.  But if you're willing to do it, that's OK.
>
>>> I don't think that will be any simpler.
>>>
>>> I mean, it would make blockdev-copy simpler, because we could
>>> immediately replace backup by mirror, and then we just have mirror,
>>> which would then automatically become blockdev-copy...
>>>
>>> But it's not really going to be simpler, because whether you put the
>>> copy-before-write logic into a dedicated block driver, or into the
>>> backup filter driver, doesn't really make it simpler either way.  Well,
>>> adding a new driver always is a bit more complicated, so there's that.
>> what is the difference between separate filter driver and backup filter
>> driver?
> I thought we already had a backup filter node, so you wouldn't have had
> to create a new driver in that case.
>
> But we don't, so there really is no difference.  Well, apart from being
> able to share state easier when the driver is in the same file as the job.

But if we make it separate - it will be a separate "building block" to 
be reused in different schemes.

>
>>>> it should not care about guest writes, it copies clusters from a kind of
>>>> snapshot which is not changing in time. This job should follow recommendations
>>>> from fleecing scheme [7].
>>>>
>>>> What about the target?
>>>>
>>>> We can use separate node as target, and copy from fleecing cache to the target.
>>>> If we have only ram-cache, it would be equal to current approach (data is copied
>>>> directly to the target, even on COW). If we have both ram- and disk- caches, it's
>>>> a cool solution for slow-target: instead of make guest wait for long write to
>>>> backup target (when ram-cache is full) we can write to disk-cache which is local
>>>> and fast.
>>> Or you backup to a fast overlay over a slow target, and run a live
>>> commit on the side.
>> I think it will lead to larger io overhead: all clusters will go through
>> overlay, not only guest-written clusters, for which we did not have time
>> to copy them..
> Well, and it probably makes sense to have some form of RAM-cache driver.
>   Then that'd be your fast overlay.

but there no reasons to copy all the data through the cache: we need it 
only for CBW.

any way, I think it will be good if both schemes will be possible.

>
>>>> Another option is to combine fleecing cache and target somehow (I didn't think
>>>> about this really).
>>>>
>>>> Finally, with one - two (three?) special filters we can implement all current
>>>> fleecing/backup schemes in unique and very configurable way  and do a lot more
>>>> cool features and possibilities.
>>>>
>>>> What do you think?
>>> I think adding a specific fleecing target filter makes sense because you
>>> gave many reasons for interesting new use cases that could emerge from that.
>>>
>>> But I think adding a new fleecing-hook driver just means moving the
>>> implementation from backup to that new driver.
>> But in the same time you say that it's ok to create backup-filter
>> (instead of write_notifier) and make it insertable by qapi? So, if I
>> implement it in block/backup, it's ok? Why not do it separately?
> Because I thought we had it already.  But we don't.  So feel free to do
> it separately. :-)

Ok, that's good :) . Then, I'll try to reuse the filter in backup 
instead of write-notifiers, and understand do we really need internal 
state of backup block-job or not.

>
> Max
>

PS: in background, I have unpublished work, aimed to parallelize 
backup-job into several coroutines (like it is done for mirror, qemu-img 
clone cmd). And it's really hard. It creates queues of requests with 
different priority, to handle CBW requests in common pipeline, it's 
mostly a rewrite of block/backup. If we split CBW from backup to 
separate filter-node, backup becomes very simple thing (copy clusters 
from constant storage) and its parallelization becomes simpler.

I don't say throw the backup away, but I have several ideas, which may 
alter current approach. They may live in parallel with current backup 
path, or replace it in future, if they will be more effective.

-- 
Best regards,
Vladimir
