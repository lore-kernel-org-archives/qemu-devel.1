Received: from eggs.gnu.org ([2001:4830:134:3::10]:58071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFzUi-0003R1-JU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFzUg-0006IE-R4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:00:44 -0400
Date: Wed, 31 May 2017 11:00:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170531090023.GA4672@noname.redhat.com>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
	<1496157773-10779-5-git-send-email-kwolf@redhat.com>
	<20170530155257.GD2665@localhost.localdomain>
	<20170530165705.GE5210@noname.redhat.com>
	<20170530184825.GE2665@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530184825.GE2665@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/4] qemu-iotests: Block
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 30.05.2017 um 20:48 hat Jeff Cody geschrieben:
> On Tue, May 30, 2017 at 06:57:05PM +0200, Kevin Wolf wrote:
> > Seems you are right, but I fail to see why the other formats shouldn't
> > work? Are these just bugs or do I make any assumption in the test script
> > that is invalid for other image formats?
> >
> 
> Well, the following formats have live migration blockers:
> 
> vmdk, vhdx, vdi, vpc, qcow, vvfat

Oh, good point. We also need to fix 181 then.

> So that leaves qed, dmg, quorum.
> 
> Of those, qed is the only one that fails.  And I would guess it is a
> bug?

It is. Manual testing of a simple block migration fails, too, with qed.
It's hanging while it tries to activate the image:

#0  0x00007f5770684eef in __GI_ppoll (fds=0x7f577e322790, nfds=1, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:56
#1  0x00007f577d11280b in qemu_poll_ns (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:77
#2  0x00007f577d11280b in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:322
#3  0x00007f577d1144ca in aio_poll (ctx=ctx@entry=0x7f577e2d8f40, blocking=<optimized out>) at util/aio-posix.c:622
#4  0x00007f577d083bb1 in qed_read_l1_table_sync (s=s@entry=0x7f577e322d90) at block/qed-table.c:183
#5  0x00007f577d082ac7 in bdrv_qed_do_open (bs=bs@entry=0x7f577e317b50, flags=8194, errp=errp@entry=0x7f57593ffbb0, options=0x0) at block/qed.c:519
#6  0x00007f577d082cc7 in bdrv_qed_invalidate_cache (bs=0x7f577e317b50, errp=0x7f57593ffbe0) at block/qed.c:1646
#7  0x00007f577d054cb4 in bdrv_invalidate_cache (bs=0x7f577e317b50, errp=errp@entry=0x7f57593ffc88) at block.c:4041
#8  0x00007f577d08f77c in blk_invalidate_cache (blk=blk@entry=0x7f577e317970, errp=errp@entry=0x7f57593ffc88) at block/block-backend.c:1537
#9  0x00007f577cfff729 in block_load (f=<optimized out>, opaque=<optimized out>, version_id=<optimized out>) at migration/block.c:930
#10 0x00007f577cff4d97 in vmstate_load (f=0x7f577e2dc750, se=0x7f577e3109e0, version_id=1) at migration/savevm.c:728
#11 0x00007f577cff5232 in qemu_loadvm_state_main (mis=0x7f577d76d860 <mis_current.32100>, f=0x7f577e2dc750) at migration/savevm.c:1917
#12 0x00007f577cff5232 in qemu_loadvm_state_main (f=f@entry=0x7f577e2dc750, mis=mis@entry=0x7f577d76d860 <mis_current.32100>) at migration/savevm.c:1948
#13 0x00007f577cff7e26 in qemu_loadvm_state (f=f@entry=0x7f577e2dc750) at migration/savevm.c:2014
#14 0x00007f577cff0113 in process_incoming_migration_co (opaque=0x7f577e2dc750) at migration/migration.c:391
#15 0x00007f577d127c6a in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:79
#16 0x00007f57705decf0 in __start_context () at /lib64/libc.so.6

> So I would make _supported_fmt be 'qcow2 raw qed dmg quorum', and the
> failure of qed is an actual failure.

Yes, sounds good.

> > What would you think about squashing this in:
> > 
> > --- a/tests/qemu-iotests/183
> > +++ b/tests/qemu-iotests/183
> > @@ -96,11 +96,8 @@ if echo "$reply" | grep "compiled without old-style" > /dev/null; then
> >      _notrun "migrate -b support not compiled in"
> >  fi
> >  
> > -while _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" "return"  |
> > -      grep '"status": "active"' > /dev/null
> > -do
> > -    sleep 0.1
> > -done
> > +QEMU_COMM_TIMEOUT=0.1 qemu_cmd_repeat=50 silent=yes \
> > +    _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" '"status": "completed"'
> >  _send_qemu_cmd $src "{ 'execute': 'query-status' }" "return"
> >  
> >  echo
> >
> 
> I like that approach.  It also worked well with the qed failure case.
> Rather than hanging during the query-migrate, it times out nicely.  All
> other formats expected to work, still worked for me.

Okay, I'll send a v3.

Kevin
