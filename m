Received: from eggs.gnu.org ([2001:4830:134:3::10]:43790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqmeU-0006PE-KE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 17:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqmeN-0005AE-45
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 17:51:24 -0400
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
Date: Fri, 17 Aug 2018 23:50:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180814170126.56461-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sf8TrdCTpvBS1t6oVBLEprQ6upUPK2TvC"
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
--sf8TrdCTpvBS1t6oVBLEprQ6upUPK2TvC
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com,
 jsnow@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <abc754ac-f09d-53dc-087e-5bc619277cbd@redhat.com>
Subject: Re: [RFC v2] new, node-graph-based fleecing and backup
References: <20180814170126.56461-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180814170126.56461-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-14 19:01, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> [v2 is just a resend. I forget to add Den an me to cc, and I don't see =
the
> letter in my thunderbird at all. strange. sorry for that]
>=20
> Hi all!
>=20
> Here is an idea and kind of proof-of-concept of how to unify and improv=
e
> push/pull backup schemes.
>=20
> Let's start from fleecing, a way of importing a point-in-time snapshot =
not
> creating a real snapshot. Now we do it with help of backup(sync=3Dnone)=
=2E.
>=20
> Proposal:
>=20
> For fleecing we need two nodes:
>=20
> 1. fleecing hook. It's a filter which should be inserted on top of acti=
ve
> disk. It's main purpose is handling guest writes by copy-on-write opera=
tion,
> i.e. it's a substitution for write-notifier in backup job.
>=20
> 2. fleecing cache. It's a target node for COW operations by fleecing-ho=
ok.
> It also represents a point-in-time snapshot of active disk for the read=
ers.

It's not really COW, it's copy-before-write, isn't it?  It's something
else entirely.  COW is about writing data to an overlay *instead* of
writing it to the backing file.  Ideally, you don't copy anything,
actually.  It's just a side effect that you need to copy things if your
cluster size doesn't happen to match exactly what you're overwriting.

CBW is about copying everything to the overlay, and then leaving it
alone, instead writing the data to the backing file.

I'm not sure how important it is, I just wanted to make a note so we
don't misunderstand what's going on, somehow.


The fleecing hook sounds good to me, but I'm asking myself why we don't
just add that behavior to the backup filter node.  That is, re-implement
backup without before-write notifiers by making the filter node actually
do something (I think there was some reason, but I don't remember).

> The simplest realization of fleecing cache is a qcow2 temporary image, =
backed
> by active disk, i.e.:
>=20
>     +-------+
>     | Guest |
>     +---+---+
>         |
>         v
>     +---+-----------+  file     +-----------------------+
>     | Fleecing hook +---------->+ Fleecing cache(qcow2) |
>     +---+-----------+           +---+-------------------+
>         |                           |
> backing |                           |
>         v                           |
>     +---+---------+      backing    |
>     | Active disk +<----------------+
>     +-------------+
>=20
> Hm. No, because of permissions I can't do so, I have to do like this:
>=20
>     +-------+
>     | Guest |
>     +---+---+
>         |
>         v
>     +---+-----------+  file     +-----------------------+
>     | Fleecing hook +---------->+ Fleecing cache(qcow2) |
>     +---+-----------+           +-----+-----------------+
>         |                             |
> backing |                             | backing
>         v                             v
>     +---+---------+   backing   +-----+---------------------+
>     | Active disk +<------------+ hack children permissions |
>     +-------------+             |     filter node           |
>                                 +---------------------------+
>=20
> Ok, this works, it's an image fleecing scheme without any block jobs.

So this is the goal?  Hm.  How useful is that really?

I suppose technically you could allow blockdev-add'ing a backup filter
node (though only with sync=3Dnone) and that would give you the same.

> Problems with realization:
>=20
> 1 What to do with hack-permissions-node? What is a true way to implemen=
t
> something like this? How to tune permissions to avoid this additional n=
ode?

Hm, how is that different from what we currently do?  Because the block
job takes care of it?

Well, the user would have to guarantee the permissions.  And they can
only do that by manually adding a filter node in the backing chain, I
suppose.

Or they just start a block job which guarantees the permissions work...
So maybe it's best to just stay with a block job as it is.

> 2 Inserting/removing the filter. Do we have working way or developments=
 on
> it?

Berto has posted patches for an x-blockdev-reopen QMP command.

> 3. Interesting: we can't setup backing link to active disk before inser=
ting
> fleecing-hook, otherwise, it will damage this link on insertion. This m=
eans,
> that we can't create fleecing cache node in advance with all backing to=

> reference it when creating fleecing hook. And we can't prepare all the =
nodes
> in advance and then insert the filter.. We have to:
> 1. create all the nodes with all links in one big json, or

I think that should be possible with x-blockdev-reopen.

> 2. set backing links/create nodes automatically, as it is done in this =
RFC
>  (it's a bad way I think, not clear, not transparent)
>=20
> 4. Is it a good idea to use "backing" and "file" links in such way?

I don't think so, because you're pretending it to be a COW relationship
when it isn't.  Using backing for what it is is kind of OK (because
that's what the mirror and backup filters do, too), but then using
"file" additionally is a bit weird.

(Usually, "backing" refers to a filtered node with COW, and "file" then
refers to the node where the overlay driver stores its data and
metadata.  But you'd store old data there (instead of new data), and no
metadata.)

> Benefits, or, what can be done:
>=20
> 1. We can implement special Fleecing cache filter driver, which will be=
 a real
> cache: it will store some recently written clusters and RAM, it can hav=
e a
> backing (or file?) qcow2 child, to flush some clusters to the disk, etc=
=2E So,
> for each cluster of active disk we will have the following characterist=
ics:
>=20
> - changed (changed in active disk since backup start)
> - copy (we need this cluster for fleecing user. For example, in RFC pat=
ch all
> clusters are "copy", cow_bitmap is initialized to all ones. We can use =
some
> existent bitmap to initialize cow_bitmap, and it will provide an "incre=
mental"
> fleecing (for use in incremental backup push or pull)
> - cached in RAM
> - cached in disk

Would it be possible to implement such a filter driver that could just
be used as a backup target?

> On top of these characteristics we can implement the following features=
:
>=20
> 1. COR, we can cache clusters not only on writes but on reads too, if w=
e have
> free space in ram-cache (and if not, do not cache at all, don't write t=
o
> disk-cache). It may be done like bdrv_write(..., BDRV_REQ_UNNECESARY)

You can do the same with backup by just putting a fast overlay between
source and the backup, if your source is so slow, and then do COR, i.e.:

slow source --> fast overlay --> COR node --> backup filter

> 2. Benefit for guest: if cluster is unchanged and ram-cached, we can sk=
ip reading
> from the devise
>=20
> 3. If needed, we can drop unchanged ram-cached clusters from ram-cache
>=20
> 4. On guest write, if cluster is already cached, we just mark it "chang=
ed"
>=20
> 5. Lazy discards: in some setups, discards are not guaranteed to do som=
ething,
> so, we can at least defer some discards to the end of backup, if ram-ca=
che is
> full.
>=20
> 6. We can implement discard operation in fleecing cache, to make cluste=
r
> not needed (drop from cache, drop "copy" flag), so further reads of thi=
s
> cluster will return error. So, fleecing client may read cluster by clus=
ter
> and discard them to reduce COW-load of the drive. We even can combine r=
ead
> and discard into one command, something like "read-once", or it may be =
a
> flag for fleecing-cache, that all reads are "read-once".

That would definitely be possible with a dedicated fleecing backup
target filter (and normal backup).

> 7. We can provide recommendations, on which clusters should fleecing-cl=
ient
> copy first. Examples:
> a. copy ram-cached clusters first (obvious, to unload cache and reduce =
io
>    overhead)
> b. copy zero-clusters last (the don't occupy place in cache, so, lets c=
opy
>    other clusters first)
> c. copy disk-cached clusters list (if we don't care about disk space,
>    we can say, that for disk-cached clusters we already have a maximum
>    io overhead, so let's copy other clusters first)
> d. copy disk-cached clusters with high priority (but after ram-cached) =
-
>    if we don't have enough disk space
>=20
> So, there is a wide range of possible politics. How to provide these
> recommendations?
> 1. block_status
> 2. create separate interface
> 3. internal backup job may access shared fleecing object directly.

Hm, this is a completely different question now.  Sure, extending backup
or mirror (or a future blockdev-copy) would make it easiest for us.  But
then again, if you want to copy data off a point-in-time snapshot of a
volume, you can just use normal backup anyway, right?

So I'd say the purpose of fleecing is that you have an external tool
make use of it.  Since my impression was that you'd just access the
volume externally and wouldn't actually copy all of the data off of it
(because that's what you could use the backup job for), I don't think I
can say much here, because my impression seems to have been wrong.

> About internal backup:
> Of course, we need a job which will copy clusters. But it will be simpl=
ified:

So you want to completely rebuild backup based on the fact that you
specifically have fleecing now?

I don't think that will be any simpler.

I mean, it would make blockdev-copy simpler, because we could
immediately replace backup by mirror, and then we just have mirror,
which would then automatically become blockdev-copy...

But it's not really going to be simpler, because whether you put the
copy-before-write logic into a dedicated block driver, or into the
backup filter driver, doesn't really make it simpler either way.  Well,
adding a new driver always is a bit more complicated, so there's that.

> it should not care about guest writes, it copies clusters from a kind o=
f
> snapshot which is not changing in time. This job should follow recommen=
dations
> from fleecing scheme [7].
>=20
> What about the target?
>=20
> We can use separate node as target, and copy from fleecing cache to the=
 target.
> If we have only ram-cache, it would be equal to current approach (data =
is copied
> directly to the target, even on COW). If we have both ram- and disk- ca=
ches, it's
> a cool solution for slow-target: instead of make guest wait for long wr=
ite to
> backup target (when ram-cache is full) we can write to disk-cache which=
 is local
> and fast.

Or you backup to a fast overlay over a slow target, and run a live
commit on the side.

> Another option is to combine fleecing cache and target somehow (I didn'=
t think
> about this really).
>=20
> Finally, with one - two (three?) special filters we can implement all c=
urrent
> fleecing/backup schemes in unique and very configurable way  and do a l=
ot more
> cool features and possibilities.
>=20
> What do you think?

I think adding a specific fleecing target filter makes sense because you
gave many reasons for interesting new use cases that could emerge from th=
at.

But I think adding a new fleecing-hook driver just means moving the
implementation from backup to that new driver.

Max

> I really need help with fleecing graph creating/inserting/destroying, m=
y code
> about it is a hack, I don't like it, it just works.
>=20
> About testing: to show that this work I use existing fleecing test - 22=
2, a bit
> tuned (drop block-job and use new qmp command to remove filter).


--sf8TrdCTpvBS1t6oVBLEprQ6upUPK2TvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt3QzoACgkQ9AfbAGHV
z0DKXwf6A0K3ta3VNg6YNsDTu1ghZDWF78j294eansRPS55KaUI1HeU/tuXQFq8c
RvfXffVkxjUhorFRc87m8Dc6lxwSL63BPHH6sohR0MimObCzclpI2+ssEnhk7koD
7DDuVy110sBVLuOyP3SMHsQcTPCi1C5bw7vAeCkad/eJc0fno01+IBGLg/G2XnrS
pv9gJRvzlku4xDUpo5vwSMr3cG/te71iADL79KjN4wKgJTus0Aen88JT8vVt7j76
VXRwZmb/w59ePuu9yJ1/RGcNwqeA0ZmO1Ub76C6wmTIUc5oR5EFarBVKkCkWSGA0
ppirrkwVlyyHkn/0N7MMAQu/kc0uBw==
=3Et4
-----END PGP SIGNATURE-----

--sf8TrdCTpvBS1t6oVBLEprQ6upUPK2TvC--
