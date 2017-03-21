Received: from eggs.gnu.org ([2001:4830:134:3::10]:57418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqJFC-0004AA-Hu
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqJF7-0005yD-JW
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cqJF7-0005xY-DS
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:50:29 -0400
Date: Tue, 21 Mar 2017 20:50:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170321125025.GA19060@lemon.lan>
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<20170321052602.GA2785@lemon>
	<CAO_EM_=RbB7FopO9z6NOGhFgLSd-hWz-oNf406fCB=sqOgP=-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_=RbB7FopO9z6NOGhFgLSd-hWz-oNf406fCB=sqOgP=-w@mail.gmail.com>
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

On Tue, 03/21 05:20, Ed Swierk wrote:
> On Mon, Mar 20, 2017 at 10:26 PM, Fam Zheng <famz@redhat.com> wrote:
> > On Fri, 03/17 09:55, Ed Swierk wrote:
> >> I'm running into the same problem taking an external snapshot with a
> >> virtio-blk drive with iothread, so it's not specific to virtio-scsi.
> >> Run a Linux guest on qemu master
> >>
> >>   qemu-system-x86_64 -nographic -enable-kvm -monitor
> >> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
> >> iothread,id=iothread1 -drive file=/x/drive.qcow2,if=none,id=drive0
> >> -device virtio-blk-pci,iothread=iothread1,drive=drive0
> >>
> >> Then in the monitor
> >>
> >>   snapshot_blkdev drive0 /x/snap1.qcow2
> >>
> >> qemu bombs with
> >>
> >>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
> >> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.
> >>
> >> whereas without the iothread the assertion failure does not occur.
> >
> >
> > Can you test this one?
> >
> > ---
> >
> >
> > diff --git a/blockdev.c b/blockdev.c
> > index c5b2c2c..4c217d5 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -1772,6 +1772,8 @@ static void external_snapshot_prepare(BlkActionState *common,
> >          return;
> >      }
> >
> > +    bdrv_set_aio_context(state->new_bs, state->aio_context);
> > +
> >      /* This removes our old bs and adds the new bs. This is an operation that
> >       * can fail, so we need to do it in .prepare; undoing it for abort is
> >       * always possible. */
> > @@ -1789,8 +1791,6 @@ static void external_snapshot_commit(BlkActionState *common)
> >      ExternalSnapshotState *state =
> >                               DO_UPCAST(ExternalSnapshotState, common, common);
> >
> > -    bdrv_set_aio_context(state->new_bs, state->aio_context);
> > -
> >      /* We don't need (or want) to use the transactional
> >       * bdrv_reopen_multiple() across all the entries at once, because we
> >       * don't want to abort all of them if one of them fails the reopen */
> 
> With this change, a different assertion fails on running snapshot_blkdev:
> 
>   qemu-system-x86_64: /x/qemu/block/io.c:164: bdrv_drain_recurse:
> Assertion `qemu_get_current_aio_context() == qemu_get_aio_context()'
> failed.

Is there a backtrace?
