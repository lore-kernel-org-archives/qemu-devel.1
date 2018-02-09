Received: from eggs.gnu.org ([2001:4830:134:3::10]:55615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fuweiwei2@huawei.com>) id 1ek4ID-0003mL-ND
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fuweiwei2@huawei.com>) id 1ek4I8-0003U7-PJ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:44:25 -0500
Received: from [45.249.212.255] (port=34541 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fuweiwei2@huawei.com>)
	id 1ek4I7-0003NJ-Mg
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:44:20 -0500
From: "fuweiwei (C)" <fuweiwei2@huawei.com>
Date: Fri, 9 Feb 2018 07:57:42 +0000
Message-ID: <A73A3E8EE466CD4E9D22E0AD8ADEE00949DEB635@DGGEMA503-MBX.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Question: qemu crashed for re-entry of
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, Xieyingtai <xieyingtai@huawei.com>, "Subo (A)" <subo7@huawei.com>

We find a problem of reentrant of bdrv_drain_recurse() of the same bs, whic=
h makes
Qemu assertion failed at

     assert(!bs_->wakeup);

in BDRV_POLL_WHILE.

To construct the problem, we do block-commit job (or others) while filling =
the space in host
file-system to make it full. The VM should be automatically paused and at t=
he same time, the
block-commit job is completed. We get the following stack.

We can see in #24 calls bdrv_drain_recurse, and polls a bh of commit_comple=
te, which reopen
the image and calls bdrv_drain_recurse again.

How to solve this problem?

#0  0x00007f7209e8e157 in raise () from /usr/lib64/libc.so.6
#1  0x00007f7209e8f848 in abort () from /usr/lib64/libc.so.6
#2  0x00007f7209e871c6 in __assert_fail_base () from /usr/lib64/libc.so.6
#3  0x00007f7209e87272 in __assert_fail () from /usr/lib64/libc.so.6
#4  0x00000000007bc40f in bdrv_drain_recurse (bs=3D0x2929ee0) at block/io.c=
:164
#5  0x00000000007bc6d2 in bdrv_parent_drained_begin (bs=3D0x295a260)
    at block/io.c:53
#6  0x00000000007bd79c in bdrv_drained_begin (bs=3D0x295a260) at block/io.c=
:248
#7  0x00000000007bc6d2 in bdrv_parent_drained_begin (bs=3D0x2989260)
    at block/io.c:53
#8  0x00000000007bd79c in bdrv_drained_begin (bs=3D0x2989260) at block/io.c=
:248
#9  0x00000000007bc6d2 in bdrv_parent_drained_begin (bs=3D0x29b8260)
    at block/io.c:53
#10 0x00000000007bd79c in bdrv_drained_begin (bs=3D0x29b8260) at block/io.c=
:248
#11 0x00000000007bc6d2 in bdrv_parent_drained_begin (bs=3D0x29e6250)
    at block/io.c:53
#12 0x00000000007bd79c in bdrv_drained_begin (bs=3D0x29e6250) at block/io.c=
:248
#13 0x00000000007bc6d2 in bdrv_parent_drained_begin (bs=3D0x2a44260)
    at block/io.c:53
#14 0x00000000007bd79c in bdrv_drained_begin (bs=3D0x2a44260) at block/io.c=
:248
#15 0x00000000007bc6d2 in bdrv_parent_drained_begin (bs=3D0x2a73260)
    at block/io.c:53
#16 0x00000000007bd2f3 in bdrv_drain_all_begin () at block/io.c:325
#17 0x0000000000768de2 in bdrv_reopen_multiple (ctx=3D0x290fdb0,
    bs_queue=3Dbs_queue@entry=3D0x2bbe580, errp=3Derrp@entry=3D0x7fff9667ef=
58)
    at block.c:2098
#18 0x000000000076a8d2 in bdrv_reopen (bs=3Dbs@entry=3D0x2a73260,
    bdrv_flags=3D<optimized out>, errp=3Derrp@entry=3D0x0) at block.c:2143
#19 0x00000000007bb263 in commit_complete (job=3D0x559d160, opaque=3D0x7f71=
f8012c90)
    at block/commit.c:98
#20 0x000000000076c92d in block_job_defer_to_main_loop_bh (opaque=3D0x7f71f=
8129eb0)
    at blockjob.c:738
#21 0x0000000000763a6f in aio_bh_poll (ctx=3Dctx@entry=3D0x28fc610) at asyn=
c.c:115
#22 0x0000000000770948 in aio_dispatch (ctx=3Dctx@entry=3D0x28fc610)
    at aio_posix.c:303
#23 0x0000000000770bf6 in aio_poll (ctx=3D0x28fc610, blocking=3Dblocking@en=
try=3Dtrue)
    at aio_posix.c:476
#24 0x00000000007bc386 in bdrv_drain_recurse (bs=3D0x2929ee0) at block/io.c=
:164
#25 0x00000000007bd840 in bdrv_drain (bs=3Dbs@entry=3D0x2929ee0) at block/i=
o.c:288
#26 0x000000000076ac87 in bdrv_set_aio_context (bs=3Dbs@entry=3D0x2929ee0,
    new_context=3Dnew_context@entry=3D0x28fc610) at block.c:3826
#27 0x00000000007ae6c3 in blk_set_aio_context (blk=3D0x2929bd0,
    new_context=3D0x28fc610) at block/block_backend.c:1632
#28 0x0000000000493772 in virtio_blk_data_plane_stop (vdev=3D<optimized out=
>)
    at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/hw/block/dataplane/virtio=
_blk.c:272
#29 0x00000000006f9913 in virtio_bus_stop_ioeventfd (bus=3D0x4c48940)
    at hw/virtio/virtio_bus.c:237
#30 0x00000000004cd02b in virtio_vmstate_change (opaque=3D0x4c489b0,
    running=3D<optimized out>, state=3D<optimized out>)
    at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/hw/virtio/virtio.c:1886
