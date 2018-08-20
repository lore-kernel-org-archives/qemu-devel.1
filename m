Received: from eggs.gnu.org ([2001:4830:134:3::10]:49226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frgi5-0007AO-1d
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frgi2-00043m-GB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:42:53 -0400
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
	<abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <052a0e73-bef5-7ee8-5e24-3c96907247f7@virtuozzo.com>
Date: Mon, 20 Aug 2018 12:42:34 +0300
MIME-Version: 1.0
In-Reply-To: <abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
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

18.08.2018 00:50, Max Reitz wrote:
> On 2018-08-14 19:01, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> [v2 is just a resend. I forget to add Den an me to cc, and I don't see the
>> letter in my thunderbird at all. strange. sorry for that]
>>
>> Hi all!
>>
>> Here is an idea and kind of proof-of-concept of how to unify and improve
>> push/pull backup schemes.
>>
>> Let's start from fleecing, a way of importing a point-in-time snapshot not
>> creating a real snapshot. Now we do it with help of backup(sync=none)..
>>
>> Proposal:
>>
>> For fleecing we need two nodes:
>>
>> 1. fleecing hook. It's a filter which should be inserted on top of active
>> disk. It's main purpose is handling guest writes by copy-on-write operation,
>> i.e. it's a substitution for write-notifier in backup job.
>>
>> 2. fleecing cache. It's a target node for COW operations by fleecing-hook.
>> It also represents a point-in-time snapshot of active disk for the readers.
> It's not really COW, it's copy-before-write, isn't it?  It's something
> else entirely.  COW is about writing data to an overlay *instead* of
> writing it to the backing file.  Ideally, you don't copy anything,
> actually.  It's just a side effect that you need to copy things if your
> cluster size doesn't happen to match exactly what you're overwriting.

Hmm. I'm not against. But COW term was already used in backup to 
describe this.

>
> CBW is about copying everything to the overlay, and then leaving it
> alone, instead writing the data to the backing file.
>
> I'm not sure how important it is, I just wanted to make a note so we
> don't misunderstand what's going on, somehow.
>
>
> The fleecing hook sounds good to me, but I'm asking myself why we don't
> just add that behavior to the backup filter node.  That is, re-implement
> backup without before-write notifiers by making the filter node actually
> do something (I think there was some reason, but I don't remember).

fleecing don't need any block-job at all, so, I think it is good to have 
fleecing filter
to be separate. And then, it should be reused by internal backup.

Hm, we can call this backup-filter instead of fleecing-hook, what is the 
difference?

>
>> The simplest realization of fleecing cache is a qcow2 temporary image, backed
>> by active disk, i.e.:
>>
>>      +-------+
>>      | Guest |
>>      +---+---+
>>          |
>>          v
>>      +---+-----------+  file     +-----------------------+
>>      | Fleecing hook +---------->+ Fleecing cache(qcow2) |
>>      +---+-----------+           +---+-------------------+
>>          |                           |
>> backing |                           |
>>          v                           |
>>      +---+---------+      backing    |
>>      | Active disk +<----------------+
>>      +-------------+
>>
>> Hm. No, because of permissions I can't do so, I have to do like this:
>>
>>      +-------+
>>      | Guest |
>>      +---+---+
>>          |
>>          v
>>      +---+-----------+  file     +-----------------------+
>>      | Fleecing hook +---------->+ Fleecing cache(qcow2) |
>>      +---+-----------+           +-----+-----------------+
>>          |                             |
>> backing |                             | backing
>>          v                             v
>>      +---+---------+   backing   +-----+---------------------+
>>      | Active disk +<------------+ hack children permissions |
>>      +-------------+             |     filter node           |
>>                                  +---------------------------+
>>
>> Ok, this works, it's an image fleecing scheme without any block jobs.
> So this is the goal?  Hm.  How useful is that really?
>
> I suppose technically you could allow blockdev-add'ing a backup filter
> node (though only with sync=none) and that would give you the same.

what is backup filter node?

>
>> Problems with realization:
>>
>> 1 What to do with hack-permissions-node? What is a true way to implement
>> something like this? How to tune permissions to avoid this additional node?
> Hm, how is that different from what we currently do?  Because the block
> job takes care of it?

1. As I understand, we agreed, that it is good to use filter node 
instead of write_notifier.
2. We already have fleecing scheme, when we should create some subgraph 
between nodes.
3. If we move to filter-node instead of write_notifier, block job is not 
actually needed for fleecing, and it is good to drop it from the 
fleecing scheme, to simplify it, to make it more clear and transparent.
And finally, we will have unified filter-node-based scheme for backup 
and fleecing, modular and customisable.

>
> Well, the user would have to guarantee the permissions.  And they can
> only do that by manually adding a filter node in the backing chain, I
> suppose.
>
> Or they just start a block job which guarantees the permissions work...
> So maybe it's best to just stay with a block job as it is.
>
>> 2 Inserting/removing the filter. Do we have working way or developments on
>> it?
> Berto has posted patches for an x-blockdev-reopen QMP command.
>
>> 3. Interesting: we can't setup backing link to active disk before inserting
>> fleecing-hook, otherwise, it will damage this link on insertion. This means,
>> that we can't create fleecing cache node in advance with all backing to
>> reference it when creating fleecing hook. And we can't prepare all the nodes
>> in advance and then insert the filter.. We have to:
>> 1. create all the nodes with all links in one big json, or
> I think that should be possible with x-blockdev-reopen.
>
>> 2. set backing links/create nodes automatically, as it is done in this RFC
>>   (it's a bad way I think, not clear, not transparent)
>>
>> 4. Is it a good idea to use "backing" and "file" links in such way?
> I don't think so, because you're pretending it to be a COW relationship
> when it isn't.  Using backing for what it is is kind of OK (because
> that's what the mirror and backup filters do, too), but then using
> "file" additionally is a bit weird.
>
> (Usually, "backing" refers to a filtered node with COW, and "file" then
> refers to the node where the overlay driver stores its data and
> metadata.  But you'd store old data there (instead of new data), and no
> metadata.)
>
>> Benefits, or, what can be done:
>>
>> 1. We can implement special Fleecing cache filter driver, which will be a real
>> cache: it will store some recently written clusters and RAM, it can have a
>> backing (or file?) qcow2 child, to flush some clusters to the disk, etc. So,
>> for each cluster of active disk we will have the following characteristics:
>>
>> - changed (changed in active disk since backup start)
>> - copy (we need this cluster for fleecing user. For example, in RFC patch all
>> clusters are "copy", cow_bitmap is initialized to all ones. We can use some
>> existent bitmap to initialize cow_bitmap, and it will provide an "incremental"
>> fleecing (for use in incremental backup push or pull)
>> - cached in RAM
>> - cached in disk
> Would it be possible to implement such a filter driver that could just
> be used as a backup target?

for internal backup we need backup-job anyway, and we will be able to 
create different schemes.
One of my goals is the scheme, when we store old data from CBW 
operations into local cache, when
backup target is remote, relatively slow NBD node. In this case, cache 
is backup source, not target.

>
>> On top of these characteristics we can implement the following features:
>>
>> 1. COR, we can cache clusters not only on writes but on reads too, if we have
>> free space in ram-cache (and if not, do not cache at all, don't write to
>> disk-cache). It may be done like bdrv_write(..., BDRV_REQ_UNNECESARY)
> You can do the same with backup by just putting a fast overlay between
> source and the backup, if your source is so slow, and then do COR, i.e.:
>
> slow source --> fast overlay --> COR node --> backup filter

How will we check ram-cache size to make COR optional in this scheme?

>
>> 2. Benefit for guest: if cluster is unchanged and ram-cached, we can skip reading
>> from the devise
>>
>> 3. If needed, we can drop unchanged ram-cached clusters from ram-cache
>>
>> 4. On guest write, if cluster is already cached, we just mark it "changed"
>>
>> 5. Lazy discards: in some setups, discards are not guaranteed to do something,
>> so, we can at least defer some discards to the end of backup, if ram-cache is
>> full.
>>
>> 6. We can implement discard operation in fleecing cache, to make cluster
>> not needed (drop from cache, drop "copy" flag), so further reads of this
>> cluster will return error. So, fleecing client may read cluster by cluster
>> and discard them to reduce COW-load of the drive. We even can combine read
>> and discard into one command, something like "read-once", or it may be a
>> flag for fleecing-cache, that all reads are "read-once".
> That would definitely be possible with a dedicated fleecing backup
> target filter (and normal backup).

target-filter schemes will not work for external-backup..

>
>> 7. We can provide recommendations, on which clusters should fleecing-client
>> copy first. Examples:
>> a. copy ram-cached clusters first (obvious, to unload cache and reduce io
>>     overhead)
>> b. copy zero-clusters last (the don't occupy place in cache, so, lets copy
>>     other clusters first)
>> c. copy disk-cached clusters list (if we don't care about disk space,
>>     we can say, that for disk-cached clusters we already have a maximum
>>     io overhead, so let's copy other clusters first)
>> d. copy disk-cached clusters with high priority (but after ram-cached) -
>>     if we don't have enough disk space
>>
>> So, there is a wide range of possible politics. How to provide these
>> recommendations?
>> 1. block_status
>> 2. create separate interface
>> 3. internal backup job may access shared fleecing object directly.
> Hm, this is a completely different question now.  Sure, extending backup
> or mirror (or a future blockdev-copy) would make it easiest for us.  But
> then again, if you want to copy data off a point-in-time snapshot of a
> volume, you can just use normal backup anyway, right?

right. but how to implement all the features I listed? I see the way to 
implement them with help of two special filters. And backup job will be 
used anyway (without write-notifiers) for internal backup and will not 
be used for external backup (fleecing).

>
> So I'd say the purpose of fleecing is that you have an external tool
> make use of it.  Since my impression was that you'd just access the
> volume externally and wouldn't actually copy all of the data off of it

not quite right. People use fleecing to implement external backup, 
managed by their third-party tool, which they want to use instead of 
internal backup. And they do copy all the data. I cant describe all the 
reasons, but example is custom storage for backup, which external tool 
can manage and Qemu can't.
So, fleecing is used for external backups (or pull backups).

> (because that's what you could use the backup job for), I don't think I
> can say much here, because my impression seems to have been wrong.
>
>> About internal backup:
>> Of course, we need a job which will copy clusters. But it will be simplified:
> So you want to completely rebuild backup based on the fact that you
> specifically have fleecing now?

I need several features, which are hard to implement using current scheme.

1. The scheme when we have a local cache as COW target and slow remote 
backup target.
How to do it now? Using two backups, one with sync=none... Not sure that 
this is right way.

2. Then, we'll need support for bitmaps in backup (sync=none). 3. Then, 
we'll need a possibility for backup(sync=none) to
not COW clusters, which are already copied to backup, and so on.

If we want a backup-filter anyway, why not to implement some cool 
features on top of it?

>
> I don't think that will be any simpler.
>
> I mean, it would make blockdev-copy simpler, because we could
> immediately replace backup by mirror, and then we just have mirror,
> which would then automatically become blockdev-copy...
>
> But it's not really going to be simpler, because whether you put the
> copy-before-write logic into a dedicated block driver, or into the
> backup filter driver, doesn't really make it simpler either way.  Well,
> adding a new driver always is a bit more complicated, so there's that.

what is the difference between separate filter driver and backup filter 
driver?

>
>> it should not care about guest writes, it copies clusters from a kind of
>> snapshot which is not changing in time. This job should follow recommendations
>> from fleecing scheme [7].
>>
>> What about the target?
>>
>> We can use separate node as target, and copy from fleecing cache to the target.
>> If we have only ram-cache, it would be equal to current approach (data is copied
>> directly to the target, even on COW). If we have both ram- and disk- caches, it's
>> a cool solution for slow-target: instead of make guest wait for long write to
>> backup target (when ram-cache is full) we can write to disk-cache which is local
>> and fast.
> Or you backup to a fast overlay over a slow target, and run a live
> commit on the side.

I think it will lead to larger io overhead: all clusters will go through 
overlay, not only guest-written clusters, for which we did not have time 
to copy them..

>
>> Another option is to combine fleecing cache and target somehow (I didn't think
>> about this really).
>>
>> Finally, with one - two (three?) special filters we can implement all current
>> fleecing/backup schemes in unique and very configurable way  and do a lot more
>> cool features and possibilities.
>>
>> What do you think?
> I think adding a specific fleecing target filter makes sense because you
> gave many reasons for interesting new use cases that could emerge from that.
>
> But I think adding a new fleecing-hook driver just means moving the
> implementation from backup to that new driver.

But in the same time you say that it's ok to create backup-filter 
(instead of write_notifier) and make it insertable by qapi? So, if I 
implement it in block/backup, it's ok? Why not do it separately?

>
> Max
>
>> I really need help with fleecing graph creating/inserting/destroying, my code
>> about it is a hack, I don't like it, it just works.
>>
>> About testing: to show that this work I use existing fleecing test - 222, a bit
>> tuned (drop block-job and use new qmp command to remove filter).


-- 
Best regards,
Vladimir
