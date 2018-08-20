Received: from eggs.gnu.org ([2001:4830:134:3::10]:51847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frnvp-0006ll-0Q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frnvl-0001eP-UO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:25:32 -0400
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
	<abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
	<052a0e73-bef5-7ee8-5e24-3c96907247f7@virtuozzo.com>
	<78730056-1612-ba4f-af74-42c4c2f2ecf3@redhat.com>
	<d6d5b315-d058-91b2-e11a-7a6fe1ec33fd@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7913fa3b-e50a-b508-848b-dd5b8419bdbb@redhat.com>
Date: Mon, 20 Aug 2018 19:25:10 +0200
MIME-Version: 1.0
In-Reply-To: <d6d5b315-d058-91b2-e11a-7a6fe1ec33fd@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zJVWQMUZnkGyVi2cS6HYF0pneKoLst5vd"
Subject: Re: [Qemu-devel] [RFC v2] new, node-graph-based fleecing and backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zJVWQMUZnkGyVi2cS6HYF0pneKoLst5vd
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com,
 jsnow@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <7913fa3b-e50a-b508-848b-dd5b8419bdbb@redhat.com>
Subject: Re: [RFC v2] new, node-graph-based fleecing and backup
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
 <abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
 <052a0e73-bef5-7ee8-5e24-3c96907247f7@virtuozzo.com>
 <78730056-1612-ba4f-af74-42c4c2f2ecf3@redhat.com>
 <d6d5b315-d058-91b2-e11a-7a6fe1ec33fd@virtuozzo.com>
In-Reply-To: <d6d5b315-d058-91b2-e11a-7a6fe1ec33fd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 16:49, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2018 16:32, Max Reitz wrote:
>> On 2018-08-20 11:42, Vladimir Sementsov-Ogievskiy wrote:
>>> 18.08.2018 00:50, Max Reitz wrote:
>>>> On 2018-08-14 19:01, Vladimir Sementsov-Ogievskiy wrote:
>> [...]
>>
>>>>> Proposal:
>>>>>
>>>>> For fleecing we need two nodes:
>>>>>
>>>>> 1. fleecing hook. It's a filter which should be inserted on top of =
active
>>>>> disk. It's main purpose is handling guest writes by copy-on-write o=
peration,
>>>>> i.e. it's a substitution for write-notifier in backup job.
>>>>>
>>>>> 2. fleecing cache. It's a target node for COW operations by fleecin=
g-hook.
>>>>> It also represents a point-in-time snapshot of active disk for the =
readers.
>>>> It's not really COW, it's copy-before-write, isn't it?  It's somethi=
ng
>>>> else entirely.  COW is about writing data to an overlay *instead* of=

>>>> writing it to the backing file.  Ideally, you don't copy anything,
>>>> actually.  It's just a side effect that you need to copy things if y=
our
>>>> cluster size doesn't happen to match exactly what you're overwriting=
=2E
>>> Hmm. I'm not against. But COW term was already used in backup to
>>> describe this.
>> Bad enough. :-)
>=20
> So, we agreed about new "CBW" abbreviation? :)

It is already used for the USB mass-storage command block wrapper, but I
suppose that is sufficiently different not to cause much confusion. :-)

(Or at least that's the only other use I know of.)

[...]

>>> 2. We already have fleecing scheme, when we should create some subgra=
ph
>>> between nodes.
>> Yes, but how do the permissions work right now, and why wouldn't they
>> work with your schema?
>=20
> now it uses backup job, with shared_perm =3D all for its source and tar=
get
> nodes.

Uh-huh.

So the issue is...  Hm, what exactly?  The backup node probably doesn't
want to share WRITE for the source anymore, as there is no real point in
doing so.  And for the target, the only problem may be to share
CONSISTENT_READ.  It is OK to share that in the fleecing case, but in
other cases maybe it isn't.  But that's easy enough to distinguish in
the driver.

The main issue I could see is that the overlay (the fleecing target)
might not share write permissions on its backing file (the fleecing
source)...  But your diagram shows (and bdrv_format_default_perms() as
well) that this is no the case, when the overlay is writable, the
backing file may be written to, too.

> (ha, you can look at the picture in "[PATCH v2 0/3] block nodes
> graph visualization")

:-)

>>> 3. If we move to filter-node instead of write_notifier, block job is =
not
>>> actually needed for fleecing, and it is good to drop it from the
>>> fleecing scheme, to simplify it, to make it more clear and transparen=
t.
>> If that's possible, why not.  But again, I'm not sure whether that's
>> enough of a reason for the endavour, because whether you start a block=

>> job or do some graph manipulation yourself is not really a difference =
in
>> complexity.
>=20
> not "or" but "and": in current fleecing scheme we do both graph
> manipulations and block-job stat/cancel..

Hm!  Interesting.  I didn't know blockdev-backup didn't set the target's
backing file.  It makes sense, but I didn't think about it.

Well, still, my point was whether you do a blockdev-backup +
block-job-cancel, or a blockdev-add + blockdev-reopen + blockdev-reopen
+ blockdev-del...  If there is a difference, the former is going to be
simpler, probably.

(But if there are things you can't do with the current blockdev-backup,
then, well, that doesn't help you.)

> Yes, I agree, that there no real benefit in difficulty. I just thing,
> that if we have filter node which performs "CBW" operations, block-job
> backup(sync=3Dnone) becomes actually empty, it will do nothing.

On the code side, yes, that's true.

>> But it's mostly your call, since I suppose you'd be doing most of the =
work.
>>
>>> And finally, we will have unified filter-node-based scheme for backup=

>>> and fleecing, modular and customisable.
>> [...]
>>
>>>>> Benefits, or, what can be done:
>>>>>
>>>>> 1. We can implement special Fleecing cache filter driver, which wil=
l be a real
>>>>> cache: it will store some recently written clusters and RAM, it can=
 have a
>>>>> backing (or file?) qcow2 child, to flush some clusters to the disk,=
 etc. So,
>>>>> for each cluster of active disk we will have the following characte=
ristics:
>>>>>
>>>>> - changed (changed in active disk since backup start)
>>>>> - copy (we need this cluster for fleecing user. For example, in RFC=
 patch all
>>>>> clusters are "copy", cow_bitmap is initialized to all ones. We can =
use some
>>>>> existent bitmap to initialize cow_bitmap, and it will provide an "i=
ncremental"
>>>>> fleecing (for use in incremental backup push or pull)
>>>>> - cached in RAM
>>>>> - cached in disk
>>>> Would it be possible to implement such a filter driver that could ju=
st
>>>> be used as a backup target?
>>> for internal backup we need backup-job anyway, and we will be able to=

>>> create different schemes.
>>> One of my goals is the scheme, when we store old data from CBW
>>> operations into local cache, when
>>> backup target is remote, relatively slow NBD node. In this case, cach=
e
>>> is backup source, not target.
>> Sorry, my question was badly worded.  My main point was whether you
>> could implement the filter driver in such a generic way that it wouldn=
't
>> depend on the fleecing-hook.
>=20
> yes, I want my filter nodes to be self-sufficient entities. However it
> may be more effective to have some shared data, between them, for
> example, dirty-bitmaps, specifying drive clusters, to know which
> clusters are cached, which are changed, etc.

I suppose having global dirty bitmaps may make sense.

>> Judging from your answer and from the fact that you proposed calling t=
he
>> filter node backup-filter and just using it for all backups, I suppose=

>> the answer is "yes".  So that's good.
>>
>> (Though I didn't quite understand why in your example the cache would =
be
>> the backup source, when the target is the slow node...)
>=20
> cache is a point-in-time view of active disk (actual source) for
> fleecing. So, we can start backup job to copy data from cache to target=
=2E

But wouldn't the cache need to be the immediate fleecing target for
this?  (And then you'd run another backup/mirror from it to copy the
whole disk to the real target.)

>>>>> On top of these characteristics we can implement the following feat=
ures:
>>>>>
>>>>> 1. COR, we can cache clusters not only on writes but on reads too, =
if we have
>>>>> free space in ram-cache (and if not, do not cache at all, don't wri=
te to
>>>>> disk-cache). It may be done like bdrv_write(..., BDRV_REQ_UNNECESAR=
Y)
>>>> You can do the same with backup by just putting a fast overlay betwe=
en
>>>> source and the backup, if your source is so slow, and then do COR, i=
=2Ee.:
>>>>
>>>> slow source --> fast overlay --> COR node --> backup filter
>>> How will we check ram-cache size to make COR optional in this scheme?=

>> Yes, well, if you have a caching driver already, I suppose you can jus=
t
>> use that.
>>
>> You could either write it a bit simpler to only cache on writes and th=
en
>> put a COR node on top if desired; or you implement the read cache
>> functionality directly in the node, which may make it a bit more
>> complicated, but probably also faster.
>>
>> (I guess you indeed want to go for faster when already writing a RAM
>> cache driver...)
>>
>> (I don't really understand what BDRV_REQ_UNNECESSARY is supposed to do=
,
>> though.)
>=20
> When we do "CBW", we _must_ save data before guest write, so, we write
> this data to the cache (or directly to target, like in current approach=
).
> When we do "COR", we _may_ save data to our ram-cache. It's safe to not=

> save data, as we can read it from active disk (data is not changed yet)=
=2E
> BDRV_REQ_UNNECESSARY is a proposed interface to write this unnecessary
> data to the cache: if ram-cache is full, cache will skip this write.

Hm, OK...  But deciding for each request how much priority it should get
in a potential cache node seems like an awful lot of work.  Well, I
don't even know what kind of requests you would deem unnecessary.  If it
has something to do with the state of a dirty bitmap, then having global
dirty bitmaps might remove the need for such a request flag.

[...]

>> Hm.  So what you want here is a special block driver or at least a
>> special interface that can give information to an outside tool, namely=

>> the information you listed above.
>>
>> If you want information about RAM-cached clusters, well, you can only
>> get that information from the RAM cache driver.  It probably would be
>> allocation information, do we have any way of getting that out?
>>
>> It seems you can get all of that (zero information and allocation
>> information) over NBD.  Would that be enough?
>=20
> it's a most generic and clean way, but I'm not sure that it will be
> performance-effective.

Intuitively I'd agree, but I suppose if NBD is written right, such a
request should be very fast and the response basically just consists of
the allocation information, so I don't suspect it can be much faster
than that.

(Unless you want some form of interrupts.  I suppose NBD would be the
wrong interface, then.)

[...]

>>> I need several features, which are hard to implement using current sc=
heme.
>>>
>>> 1. The scheme when we have a local cache as COW target and slow remot=
e
>>> backup target.
>>> How to do it now? Using two backups, one with sync=3Dnone... Not sure=
 that
>>> this is right way.
>> If it works...
>>
>> (I'd rather build simple building blocks that you can put together tha=
n
>> something complicated that works for a specific solution)
>=20
> exactly, I want to implement simple building blocks =3D filter nodes,
> instead of implementing all the features in backup job.

Good, good. :-)

>>> 3. Then,
>>> we'll need a possibility for backup(sync=3Dnone) to
>>> not COW clusters, which are already copied to backup, and so on.
>> Isn't that the same as 2?
>=20
> We can use one bitmap for 2 and 3, and drop bits from it, when
> external-tool has read corresponding cluster from nbd-fleecing-export..=


Oh, right, it needs to be modifiable from the outside.  I suppose that
would be possible in NBD, too.  (But I don't know exactly.)

[...]

>>>> I don't think that will be any simpler.
>>>>
>>>> I mean, it would make blockdev-copy simpler, because we could
>>>> immediately replace backup by mirror, and then we just have mirror,
>>>> which would then automatically become blockdev-copy...
>>>>
>>>> But it's not really going to be simpler, because whether you put the=

>>>> copy-before-write logic into a dedicated block driver, or into the
>>>> backup filter driver, doesn't really make it simpler either way.  We=
ll,
>>>> adding a new driver always is a bit more complicated, so there's tha=
t.
>>> what is the difference between separate filter driver and backup filt=
er
>>> driver?
>> I thought we already had a backup filter node, so you wouldn't have ha=
d
>> to create a new driver in that case.
>>
>> But we don't, so there really is no difference.  Well, apart from bein=
g
>> able to share state easier when the driver is in the same file as the =
job.
>=20
> But if we make it separate - it will be a separate "building block" to
> be reused in different schemes.

Absolutely true.

>>>>> it should not care about guest writes, it copies clusters from a ki=
nd of
>>>>> snapshot which is not changing in time. This job should follow reco=
mmendations
>>>>> from fleecing scheme [7].
>>>>>
>>>>> What about the target?
>>>>>
>>>>> We can use separate node as target, and copy from fleecing cache to=
 the target.
>>>>> If we have only ram-cache, it would be equal to current approach (d=
ata is copied
>>>>> directly to the target, even on COW). If we have both ram- and disk=
- caches, it's
>>>>> a cool solution for slow-target: instead of make guest wait for lon=
g write to
>>>>> backup target (when ram-cache is full) we can write to disk-cache w=
hich is local
>>>>> and fast.
>>>> Or you backup to a fast overlay over a slow target, and run a live
>>>> commit on the side.
>>> I think it will lead to larger io overhead: all clusters will go thro=
ugh
>>> overlay, not only guest-written clusters, for which we did not have t=
ime
>>> to copy them..
>> Well, and it probably makes sense to have some form of RAM-cache drive=
r.
>>  Then that'd be your fast overlay.
>=20
> but there no reasons to copy all the data through the cache: we need it=

> only for CBW.

Well, if there'd be a RAM-cache driver, you may use it for anything that
seems useful (I seem to remember there were some patches on the list
like three or four years ago...).

> any way, I think it will be good if both schemes will be possible.
>=20
>>>>> Another option is to combine fleecing cache and target somehow (I d=
idn't think
>>>>> about this really).
>>>>>
>>>>> Finally, with one - two (three?) special filters we can implement a=
ll current
>>>>> fleecing/backup schemes in unique and very configurable way  and do=
 a lot more
>>>>> cool features and possibilities.
>>>>>
>>>>> What do you think?
>>>> I think adding a specific fleecing target filter makes sense because=
 you
>>>> gave many reasons for interesting new use cases that could emerge fr=
om that.
>>>>
>>>> But I think adding a new fleecing-hook driver just means moving the
>>>> implementation from backup to that new driver.
>>> But in the same time you say that it's ok to create backup-filter
>>> (instead of write_notifier) and make it insertable by qapi? So, if I
>>> implement it in block/backup, it's ok? Why not do it separately?
>> Because I thought we had it already.  But we don't.  So feel free to d=
o
>> it separately. :-)
>=20
> Ok, that's good :) . Then, I'll try to reuse the filter in backup
> instead of write-notifiers, and understand do we really need internal
> state of backup block-job or not.
>=20
>> Max
>>
>=20
> PS: in background, I have unpublished work, aimed to parallelize
> backup-job into several coroutines (like it is done for mirror, qemu-im=
g
> clone cmd). And it's really hard.It creates queues of requests with
> different priority, to handle CBW requests in common pipeline, it's
> mostly a rewrite of block/backup. If we split CBW from backup to
> separate filter-node, backup becomes very simple thing (copy clusters
> from constant storage) and its parallelization becomes simpler.

If CBW is split from backup, maybe mirror could replace backup
immediately.  You'd fleece to a RAM cache target and then mirror from the=
re.

(To be precise: The exact replacement would be an active mirror, so a
mirror with copy-mode=3Dwrite-blocking, so it immediately writes the old
block to the target when it is changed in the source, and thus the RAM
cache could stay effectively empty.)

> I don't say throw the backup away, but I have several ideas, which may
> alter current approach. They may live in parallel with current backup
> path, or replace it in future, if they will be more effective.

Thing is, contrary to the impression I've probably given, we do want to
throw away backup sooner or later.  We want a single block job
(blockdev-copy) that unifies mirror, backup, and commit.

(mirror already basically supersedes commit, with live commit just being
exactly mirror; the main problem is integrating backup.  But with a
fleecing node and a RAM cache target, that would suddenly be really
simple, I assume.)

((All that's missing is sync=3Dtop, where the mirror would need to not
only check its source (which would be the RAM cache), but also its
backing file; and sync=3Dincremental, which just isn't there with mirror
at all.  OTOH, it may be possible to implement both modes simply in the
fleecing/backup node, so it only copies that respective data to the
target and the mirror simply sees nothing else.))

Max


--zJVWQMUZnkGyVi2cS6HYF0pneKoLst5vd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt6+XYACgkQ9AfbAGHV
z0DGvwf/duGIhXOymDEuMg4kSkGCjxCl3DKO1WQIa3/NeT/gFB5dt59G/+Ylt9uN
GMhwPfqHDQ3IxnOjUxXU0cLIdYFyedhXCpT+vD+X87MG4KlkJLka3Zy5K4x1ZGtT
CKcRcbC9ilHf/iKQNwRnDEgTPFfgIbVt0luhtzCQI6wzkUg8mDPAEfdjpmu4f0ho
ui+Kc3QQrnoVtUirCgIUK084l7nSl1ABjSc9kWS9n8Kj7eFvrCH7lub9zWQYPr10
T30E/fiZ9a4gyaQky1hazSfDwu0bhv1VdAO6bEaqizaxrnTnEIbumE7eyuXdYk6s
S061HOrxUI6ZijEWqsxXvwd/hRH8dg==
=8fAN
-----END PGP SIGNATURE-----

--zJVWQMUZnkGyVi2cS6HYF0pneKoLst5vd--
