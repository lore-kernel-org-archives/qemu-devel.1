Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fftgA-0002yS-Nq
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fftg6-0004OU-Kf
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:08:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59894
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fftg6-0004Nx-DL
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:08:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6IL4EHG109155
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 17:08:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kacgshf10-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 17:08:05 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 18 Jul 2018 17:08:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180529201917.GL4756@localhost.localdomain>
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
	<20180529201917.GL4756@localhost.localdomain>
Date: Wed, 18 Jul 2018 16:07:52 -0500
Message-Id: <153194807266.31213.16487908209652714185@sif>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v4] block: fix QEMU crash
 with scsi-hd and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

Quoting Kevin Wolf (2018-05-29 15:19:17)
> Am 28.05.2018 um 14:03 hat Greg Kurz geschrieben:
> > Removing a drive with drive_del while it is being used to run an I/O
> > intensive workload can cause QEMU to crash.
> > =

> > An AIO flush can yield at some point:
> > =

> > blk_aio_flush_entry()
> >  blk_co_flush(blk)
> >   bdrv_co_flush(blk->root->bs)
> >    ...
> >     qemu_coroutine_yield()
> > =

> > and let the HMP command to run, free blk->root and give control
> > back to the AIO flush:
> > =

> >     hmp_drive_del()
> >      blk_remove_bs()
> >       bdrv_root_unref_child(blk->root)
> >        child_bs =3D blk->root->bs
> >        bdrv_detach_child(blk->root)
> >         bdrv_replace_child(blk->root, NULL)
> >          blk->root->bs =3D NULL
> >         g_free(blk->root) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D b=
lk->root becomes stale
> >        bdrv_unref(child_bs)
> >         bdrv_delete(child_bs)
> >          bdrv_close()
> >           bdrv_drained_begin()
> >            bdrv_do_drained_begin()
> >             bdrv_drain_recurse()
> >              aio_poll()
> >               ...
> >               qemu_coroutine_switch()
> > =

> > and the AIO flush completion ends up dereferencing blk->root:
> > =

> >   blk_aio_complete()
> >    scsi_aio_complete()
> >     blk_get_aio_context(blk)
> >      bs =3D blk_bs(blk)
> >  ie, bs =3D blk->root ? blk->root->bs : NULL
> >             ^^^^^
> >             stale
> > =

> > The problem is that we should avoid making block driver graph
> > changes while we have in-flight requests. Let's drain all I/O
> > for this BB before calling bdrv_root_unref_child().
> > =

> > Signed-off-by: Greg Kurz <groug@kaod.org>
> =

> Hmm... It sounded convincing, but 'make check-tests/test-replication'
> fails now. The good news is that with the drain fixes, for which I sent
> v2 today, it passes, so instead of staging it in my block branch, I'll
> put it at the end of my branch for the drain fixes.
> =

> Might take a bit longer than planned until it's in master, sorry.

I'm getting the below test-replication failure/trace trying to backport
this patch for 2.12.1 (using this tree:
https://github.com/mdroth/qemu/commits/stable-2.12-staging-f45280cbf)

Is this the same issue you saw, and if so, are the drain fixes
appropriate for 2.12.x? Are there other prereqs/follow-ups you're
aware of that would also be needed?

mdroth@sif:~/w/qemu-build4$ MALLOC_PERTURB_=3D1 gdb --args tests/test-repli=
cation
(gdb) run
Starting program: /home/mdroth/dev/kvm/qemu-build4/tests/test-replication =

[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff50bf700 (LWP 3916)]
[New Thread 0x7ffff48be700 (LWP 3917)]
/replication/primary/read: OK
/replication/primary/write: OK
/replication/primary/start: OK
/replication/primary/stop: OK
/replication/primary/do_checkpoint: OK
/replication/primary/get_error_all: OK
/replication/secondary/read: OK
/replication/secondary/write: OK
/replication/secondary/start: [New Thread 0x7fffea9f5700 (LWP 3918)]
[New Thread 0x7fffea1f4700 (LWP 3919)]
[New Thread 0x7fffe99f3700 (LWP 3920)]
[New Thread 0x7fffe91f2700 (LWP 3921)]
[New Thread 0x7fffe89f1700 (LWP 3922)]
[New Thread 0x7fffdbfff700 (LWP 3923)]
[New Thread 0x7fffdb7fe700 (LWP 3924)]
[New Thread 0x7fffda1ef700 (LWP 3925)]
[New Thread 0x7fffd99ee700 (LWP 3926)]
[New Thread 0x7fffd91ed700 (LWP 3927)]
[New Thread 0x7fffd89ec700 (LWP 3928)]
[New Thread 0x7fffbffff700 (LWP 3929)]
[New Thread 0x7fffbf7fe700 (LWP 3930)]
[New Thread 0x7fffbeffd700 (LWP 3931)]
[New Thread 0x7fffbe7fc700 (LWP 3932)]
[New Thread 0x7fffbdffb700 (LWP 3933)]
[New Thread 0x7fffbd7fa700 (LWP 3934)]
[New Thread 0x7fffbcff9700 (LWP 3935)]
[New Thread 0x7fff9bfff700 (LWP 3936)]
[New Thread 0x7fff9b7fe700 (LWP 3937)]
[New Thread 0x7fff9affd700 (LWP 3938)]
[New Thread 0x7fff9a7fc700 (LWP 3939)]
[New Thread 0x7fff99ffb700 (LWP 3940)]
OK
/replication/secondary/stop: =

Thread 1 "test-replicatio" received signal SIGSEGV, Segmentation fault.
qemu_mutex_unlock_impl (mutex=3Dmutex@entry=3D0x101010101010161, file=3Dfil=
e@entry=3D0x5555556734b0 "/home/mdroth/w/qemu4.git/util/async.c", line=3Dli=
ne@entry=3D507) at /home/mdroth/w/qemu4.git/util/qemu-thread-posix.c:94
94	    assert(mutex->initialized);
(gdb) bt
#0  qemu_mutex_unlock_impl (mutex=3Dmutex@entry=3D0x101010101010161, file=
=3Dfile@entry=3D0x5555556734b0 "/home/mdroth/w/qemu4.git/util/async.c", lin=
e=3Dline@entry=3D507)
    at /home/mdroth/w/qemu4.git/util/qemu-thread-posix.c:94
#1  0x00005555556231f5 in aio_context_release (ctx=3Dctx@entry=3D0x10101010=
1010101) at /home/mdroth/w/qemu4.git/util/async.c:507
#2  0x00005555555c6895 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x555555d0625=
0) at /home/mdroth/w/qemu4.git/block/io.c:197
#3  0x00005555555c6f0f in bdrv_do_drained_begin (bs=3D0x555555d06250, recur=
sive=3D<optimized out>, parent=3D0x0) at /home/mdroth/w/qemu4.git/block/io.=
c:290
#4  0x00005555555c6ef0 in bdrv_parent_drained_begin (ignore=3D0x0, bs=3D0x5=
55555d56fb0) at /home/mdroth/w/qemu4.git/block/io.c:53
#5  bdrv_do_drained_begin (bs=3D0x555555d56fb0, recursive=3D<optimized out>=
, parent=3D0x0) at /home/mdroth/w/qemu4.git/block/io.c:288
#6  0x00005555555c6ef0 in bdrv_parent_drained_begin (ignore=3D0x0, bs=3D0x5=
55555d37210) at /home/mdroth/w/qemu4.git/block/io.c:53
#7  bdrv_do_drained_begin (bs=3D0x555555d37210, recursive=3D<optimized out>=
, parent=3D0x0) at /home/mdroth/w/qemu4.git/block/io.c:288
#8  0x00005555555c6ef0 in bdrv_parent_drained_begin (ignore=3D0x0, bs=3D0x5=
55555d18450) at /home/mdroth/w/qemu4.git/block/io.c:53
#9  bdrv_do_drained_begin (bs=3D0x555555d18450, recursive=3D<optimized out>=
, parent=3D0x0) at /home/mdroth/w/qemu4.git/block/io.c:288
#10 0x00005555555ba6d9 in blk_drain (blk=3D0x555555d03a20) at /home/mdroth/=
w/qemu4.git/block/block-backend.c:1591
#11 0x00005555555bb12a in blk_remove_bs (blk=3Dblk@entry=3D0x555555d03a20) =
at /home/mdroth/w/qemu4.git/block/block-backend.c:775
#12 0x00005555555bb366 in blk_delete (blk=3D0x555555d03a20) at /home/mdroth=
/w/qemu4.git/block/block-backend.c:401
#13 blk_unref (blk=3D0x555555d03a20) at /home/mdroth/w/qemu4.git/block/bloc=
k-backend.c:450
#14 0x0000555555572515 in teardown_secondary () at /home/mdroth/w/qemu4.git=
/tests/test-replication.c:373
#15 0x0000555555572f2a in test_secondary_stop () at /home/mdroth/w/qemu4.gi=
t/tests/test-replication.c:477
#16 0x00007ffff77134aa in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#17 0x00007ffff77133db in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#18 0x00007ffff77133db in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#19 0x00007ffff7713682 in g_test_run_suite () from /lib/x86_64-linux-gnu/li=
bglib-2.0.so.0
#20 0x00007ffff77136a1 in g_test_run () from /lib/x86_64-linux-gnu/libglib-=
2.0.so.0
#21 0x000055555557164f in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at /home/mdroth/w/qemu4.git/tests/test-replication.c:580
(gdb)

> =

> Kevin
>=20
