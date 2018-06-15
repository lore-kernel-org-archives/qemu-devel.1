Received: from eggs.gnu.org ([2001:4830:134:3::10]:41722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fTtgt-0002MA-No
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fTtgq-0003Ft-JK
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:43:19 -0400
References: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
	<20180614104656.GD8564@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8114a2a4-8bd1-809e-44c2-f3c8fb52b773@virtuozzo.com>
Date: Fri, 15 Jun 2018 21:42:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180614104656.GD8564@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] bug in reopen arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

14.06.2018 13:46, Kevin Wolf wrote:
> Am 12.06.2018 um 20:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Hi all!
>>
>> I've faced the following problem:
>>
>>  =C2=A0=C2=A0=C2=A0 1. create image with dirty bitmap, a.qcow2 (start qe=
mu and run qmp
>>  =C2=A0=C2=A0=C2=A0 command block-dirty-bitmap-add)
>>
>>  =C2=A0=C2=A0=C2=A0 2. run the following commands:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img create -f qcow2 -b =
a.qcow2 b.qcow2 10M
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-io -c 'write 0 512' b.q=
cow2
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img commit b.qcow2
>>
>>  =C2=A0=C2=A0=C2=A0 3. last command fails with the following output:
>>
>> Formatting 'b.qcow2', fmt=3Dqcow2 size=3D68719476736 backing_file=3Da.qc=
ow2
>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> wrote 512/512 bytes at offset 0
>> 512 bytes, 1 ops; 0.0953 sec (5.243 KiB/sec and 10.4867 ops/sec)
>> qemu-img: #block397: Failed to make dirty bitmaps writable: Can't update
>> bitmap directory: Operation not permitted
>> qemu-img: Block job failed: Operation not permitted
>>
>> And problem is that children are reopened _after_ parent. But qcow2 reop=
en
>> needs write access to its file, to write IN_USE flag to dirty-bitmaps
>> extension.
> I was aware of a different instance of this problem: Assume a qcow2
> image with an unknown autoclear flag (so it will be cleared on r/w
> open), which is first opened r/o and then reopened r/w. This will fail
> because .bdrv_reopen_prepare doesn't have the permissions yet.

Hm.. If I understand correctly qcow2_reopen_prepare doesn't deal with=C2=A0=
=20
autoclear flags, as it doesn't call qcow2_do_open.

>
> Simply changing the order won't fix this because in the r/w -> r/o, the
> driver will legitimately flush its caches in .bdrv_reopen_prepare, and
> for this it still needs to be able to write.
>
> We may need to have a way for nodes to access both the old and the new
> state of their children. I'm not completely sure how to achieve this
> best, though.
>
> When I thought only of permissions, the obvious and simple thing to do
> was to just get combined permissions for the old and new state, i.e.
> 'old_perm | new_perm' and 'old_shared & new_shared'. But I don't think
> this is actually enough when the child node switches between a r/w and
> a r/o file descriptor because even though QEMU's permission system would
> allow the write, you still can't successfully write to a r/o file
> descriptor.
>
> Kevin

Maybe we want two .bdrv_reopen_prepare:=20
.bdrv_reopen_prepare_before_children and=20
.bdrv_reopen_prepare_after_children. But to write something in=20
reopen_prepare, we need to move bdrv_set_perm from reopen_commit to=20
reopen_prepare.. Is it possible?

Now, I've found the following workaround, what do you think about=20
something like this as a temporary fix:

diff --git a/include/block/block.h b/include/block/block.h
index e677080c4e..c21392491d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -266,7 +266,8 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver=20
*drv, const char *node_name,
 =C2=A0BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Block=
DriverState *bs,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict=
 *options, int flags);
-int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue,=20
Error **errp);
+int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
ol cheat_reopen_rw, Error **errp);
 =C2=A0int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
 =C2=A0int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bl=
ockReopenQueue *queue, Error **errp);
diff --git a/block.c b/block.c
index 50887087f3..9b50828cd2 100644
--- a/block.c
+++ b/block.c
@@ -2988,7 +2988,8 @@ BlockReopenQueue=20
*bdrv_reopen_queue(BlockReopenQueue *bs_queue,
 =C2=A0 * All affected nodes must be drained between bdrv_reopen_queue() an=
d
 =C2=A0 * bdrv_reopen_multiple().
 =C2=A0 */
-int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue,=20
Error **errp)
+int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
ol cheat_reopen_rw, Error **errp)
 =C2=A0{
 =C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -1;
 =C2=A0=C2=A0=C2=A0=C2=A0 BlockReopenQueueEntry *bs_entry, *next;
@@ -3005,6 +3006,14 @@ int bdrv_reopen_multiple(AioContext *ctx,=20
BlockReopenQueue *bs_queue, Error **er
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs_entry->prepared =3D tr=
ue;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

+=C2=A0=C2=A0=C2=A0 if (cheat_reopen_rw) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* reverse queue, to reopen chi=
ldren first */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH_SAFE(bs_entry,=
 bs_queue, entry, next) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLE=
Q_REMOVE(bs_queue, bs_entry, BlockReopenQueueEntry,=20
entry);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLE=
Q_INSERT_HEAD(bs_queue, bs_entry, entry);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 }
+
 =C2=A0=C2=A0=C2=A0=C2=A0 /* If we reach this point, we have success and ju=
st need to apply the
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * changes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
@@ -3036,11 +3045,13 @@ int bdrv_reopen(BlockDriverState *bs, int=20
bdrv_flags, Error **errp)
 =C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -1;
 =C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
 =C2=A0=C2=A0=C2=A0=C2=A0 BlockReopenQueue *queue;
+=C2=A0=C2=A0=C2=A0 bool cheat_reopen_rw =3D bdrv_is_read_only(bs) && (bdrv=
_flags &=20
BDRV_O_RDWR);

 =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_subtree_drained_begin(bs);

 =C2=A0=C2=A0=C2=A0=C2=A0 queue =3D bdrv_reopen_queue(NULL, bs, NULL, bdrv_=
flags);
-=C2=A0=C2=A0=C2=A0 ret =3D bdrv_reopen_multiple(bdrv_get_aio_context(bs), =
queue,=20
&local_err);
+=C2=A0=C2=A0=C2=A0 ret =3D bdrv_reopen_multiple(bdrv_get_aio_context(bs), =
queue,=20
cheat_reopen_rw,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
 =C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
 =C2=A0=C2=A0=C2=A0=C2=A0 }
diff --git a/block/replication.c b/block/replication.c
index 826db7b304..e528969e2b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -411,7 +411,7 @@ static void reopen_backing_file(BlockDriverState=20
*bs, bool writable,

 =C2=A0=C2=A0=C2=A0=C2=A0 if (reopen_queue) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reopen_multiple(bdrv=
_get_aio_context(bs),
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reopen_queue, &local_err);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reopen_queue, false, &local_err);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
 =C2=A0=C2=A0=C2=A0=C2=A0 }

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 5bf5f28178..e0c4de323c 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2051,7 +2051,7 @@ static int reopen_f(BlockBackend *blk, int argc,=20
char **argv)

 =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_subtree_drained_begin(bs);
 =C2=A0=C2=A0=C2=A0=C2=A0 brq =3D bdrv_reopen_queue(NULL, bs, opts, flags);
-=C2=A0=C2=A0=C2=A0 bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &lo=
cal_err);
+=C2=A0=C2=A0=C2=A0 bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, fal=
se, &local_err);
 =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_subtree_drained_end(bs);

 =C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {


--=20
Best regards,
Vladimir
