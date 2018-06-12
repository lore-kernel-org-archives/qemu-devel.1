Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fSoTy-0002x4-9s
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fSoTv-0003JL-6U
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:57:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
Date: Tue, 12 Jun 2018 21:57:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] bug in reopen arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

Hi all!

I've faced the following problem:

 =C2=A0=C2=A0=C2=A0 1. create image with dirty bitmap, a.qcow2 (start qemu =
and run qmp
 =C2=A0=C2=A0=C2=A0 command block-dirty-bitmap-add)

 =C2=A0=C2=A0=C2=A0 2. run the following commands:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img create -f qcow2 -b a.q=
cow2 b.qcow2 10M
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-io -c 'write 0 512' b.qcow=
2
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img commit b.qcow2

 =C2=A0=C2=A0=C2=A0 3. last command fails with the following output:

Formatting 'b.qcow2', fmt=3Dqcow2 size=3D68719476736 backing_file=3Da.qcow2=
=20
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
wrote 512/512 bytes at offset 0
512 bytes, 1 ops; 0.0953 sec (5.243 KiB/sec and 10.4867 ops/sec)
qemu-img: #block397: Failed to make dirty bitmaps writable: Can't update=20
bitmap directory: Operation not permitted
qemu-img: Block job failed: Operation not permitted


And problem is that children are reopened _after_ parent. But qcow2=20
reopen needs write access to its file, to write IN_USE flag to=20
dirty-bitmaps extension.

I've tried to fix it as simple as:


diff --git a/block.c b/block.c
index cfe5e6080d..392b2941ac 100644
--- a/block.c
+++ b/block.c
@@ -2793,7 +2793,7 @@ static BlockReopenQueue=20
*bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,

 =C2=A0=C2=A0=C2=A0=C2=A0 if (!bs_entry) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs_entry =3D g_new0(Block=
ReopenQueueEntry, 1);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INSERT_TAIL(bs_queue, =
bs_entry, entry);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INSERT_HEAD(bs_queue, =
bs_entry, entry);
 =C2=A0=C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDECREF(bs_entry->state.o=
ptions);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDECREF(bs_entry->state.e=
xplicit_options);


But this breaks a lot of iotests. And looks like it is wrong idea,=20
because permissions should be updated for parent first. We've faced and=20
fixed similar problems with invalidation sequence. Reopen architecture=20
differs with it's bs_queue.. Any ideas how to fix this?

Similar story with invalidation includes

commit 16e977d506bcc2d9f7daa4a9f7cc2b48536d9da6
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:=C2=A0=C2=A0 Tue Jan 31 14:23:08 2017 +0300

 =C2=A0=C2=A0=C2=A0 block: bdrv_invalidate_cache: invalidate children first

and

commit dafe096057373d95847e1c99c2fece34be9fc5bb
Author: Kevin Wolf <kwolf@redhat.com>
Date:=C2=A0=C2=A0 Thu Nov 16 13:00:01 2017 +0100

 =C2=A0=C2=A0=C2=A0 block: Fix permissions in image activation

--=20
Best regards,
Vladimir
