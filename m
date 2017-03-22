Received: from eggs.gnu.org ([2001:4830:134:3::10]:51612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqcQW-0003Sb-AC
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqcQT-0000ib-2L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cqcQS-0000iQ-R3
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:19:29 -0400
Date: Wed, 22 Mar 2017 17:19:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170322091000.GA25375@lemon.lan>
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<20170321052602.GA2785@lemon>
	<CAO_EM_=RbB7FopO9z6NOGhFgLSd-hWz-oNf406fCB=sqOgP=-w@mail.gmail.com>
	<20170321125025.GA19060@lemon.lan>
	<CAO_EM_kLdLfQQjEZ4pzptStGearFNzV0gSYkER4PwKAdge=oCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_kLdLfQQjEZ4pzptStGearFNzV0gSYkER4PwKAdge=oCA@mail.gmail.com>
Subject: Re: [Qemu-devel] Assertion failure taking external snapshot with
 virtio drive + iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, 03/21 06:05, Ed Swierk wrote:
> On Tue, Mar 21, 2017 at 5:50 AM, Fam Zheng <famz@redhat.com> wrote:
> > On Tue, 03/21 05:20, Ed Swierk wrote:
> >> On Mon, Mar 20, 2017 at 10:26 PM, Fam Zheng <famz@redhat.com> wrote:
> >> > On Fri, 03/17 09:55, Ed Swierk wrote:
> >> >> I'm running into the same problem taking an external snapshot with a
> >> >> virtio-blk drive with iothread, so it's not specific to virtio-scsi.
> >> >> Run a Linux guest on qemu master
> >> >>
> >> >>   qemu-system-x86_64 -nographic -enable-kvm -monitor
> >> >> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
> >> >> iothread,id=iothread1 -drive file=/x/drive.qcow2,if=none,id=drive0
> >> >> -device virtio-blk-pci,iothread=iothread1,drive=drive0
> >> >>
> >> >> Then in the monitor
> >> >>
> >> >>   snapshot_blkdev drive0 /x/snap1.qcow2
> >> >>
> >> >> qemu bombs with
> >> >>
> >> >>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
> >> >> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.
> >> >>
> >> >> whereas without the iothread the assertion failure does not occur.
> >> >
> >> >
> >> > Can you test this one?
> >> >
> >> > ---
> >> >
> >> >
> >> > diff --git a/blockdev.c b/blockdev.c
> >> > index c5b2c2c..4c217d5 100644
> >> > --- a/blockdev.c
> >> > +++ b/blockdev.c
> >> > @@ -1772,6 +1772,8 @@ static void external_snapshot_prepare(BlkActionState *common,
> >> >          return;
> >> >      }
> >> >
> >> > +    bdrv_set_aio_context(state->new_bs, state->aio_context);
> >> > +
> >> >      /* This removes our old bs and adds the new bs. This is an operation that
> >> >       * can fail, so we need to do it in .prepare; undoing it for abort is
> >> >       * always possible. */
> >> > @@ -1789,8 +1791,6 @@ static void external_snapshot_commit(BlkActionState *common)
> >> >      ExternalSnapshotState *state =
> >> >                               DO_UPCAST(ExternalSnapshotState, common, common);
> >> >
> >> > -    bdrv_set_aio_context(state->new_bs, state->aio_context);
> >> > -
> >> >      /* We don't need (or want) to use the transactional
> >> >       * bdrv_reopen_multiple() across all the entries at once, because we
> >> >       * don't want to abort all of them if one of them fails the reopen */
> >>
> >> With this change, a different assertion fails on running snapshot_blkdev:
> >>
> >>   qemu-system-x86_64: /x/qemu/block/io.c:164: bdrv_drain_recurse:
> >> Assertion `qemu_get_current_aio_context() == qemu_get_aio_context()'
> >> failed.
> 
> Actually running snapshot_blkdev command in the text monitor doesn't
> trigger this assertion (I mixed up my notes). Instead it's triggered
> by the following sequence in qmp-shell:
> 
> (QEMU) blockdev-snapshot-sync device=drive0 format=qcow2
> snapshot-file=/x/snap1.qcow2
> {"return": {}}
> (QEMU) block-commit device=drive0
> {"return": {}}
> (QEMU) block-job-complete device=drive0
> {"return": {}}
> 
> > Is there a backtrace?
> 
> #0  0x00007ffff3757067 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x00007ffff3758448 in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  0x00007ffff3750266 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #3  0x00007ffff3750312 in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
> #4  0x0000555555b4b0bb in bdrv_drain_recurse
> (bs=bs@entry=0x555557bd6010)  at /x/qemu/block/io.c:164
> #5  0x0000555555b4b7ad in bdrv_drained_begin (bs=0x555557bd6010)  at
> /x/qemu/block/io.c:231
> #6  0x0000555555b4b802 in bdrv_parent_drained_begin
> (bs=0x5555568c1a00)  at /x/qemu/block/io.c:53
> #7  bdrv_drained_begin (bs=bs@entry=0x5555568c1a00)  at /x/qemu/block/io.c:228
> #8  0x0000555555b4be1e in bdrv_co_drain_bh_cb (opaque=0x7fff9aaece40)
> at /x/qemu/block/io.c:190
> #9  0x0000555555bb431e in aio_bh_call (bh=0x55555750e5f0)  at
> /x/qemu/util/async.c:90
> #10 aio_bh_poll (ctx=ctx@entry=0x555556718090)  at /x/qemu/util/async.c:118
> #11 0x0000555555bb72eb in aio_poll (ctx=0x555556718090,
> blocking=blocking@entry=true)  at /x/qemu/util/aio-posix.c:682
> #12 0x00005555559443ce in iothread_run (opaque=0x555556717b80)  at
> /x/qemu/iothread.c:59
> #13 0x00007ffff3ad50a4 in start_thread () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> #14 0x00007ffff380a87d in clone () from /lib/x86_64-linux-gnu/libc.so.6

Hmm, looks like a separate bug to me. In addition please apply this (the
assertion here is correct I think, but all callers are not audited yet):

diff --git a/block.c b/block.c
index 6e906ec..447d908 100644
--- a/block.c
+++ b/block.c
@@ -1737,6 +1737,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
 {
     BlockDriverState *old_bs = child->bs;
 
+    if (old_bs && new_bs) {
+        assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
+    }
     if (old_bs) {
         if (old_bs->quiesce_counter && child->role->drained_end) {
             child->role->drained_end(child);
diff --git a/block/mirror.c b/block/mirror.c
index ca4baa5..a23ca9e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1147,6 +1147,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
      * it alive until block_job_create() even if bs has no parent. */
