Received: from eggs.gnu.org ([2001:4830:134:3::10]:36045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqLya-0008DZ-JU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqLyZ-0005P6-Na
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:50:08 -0500
Date: Mon, 26 Feb 2018 17:49:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180226164950.GB5106@localhost.localdomain>
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Call check and invalidate_cache
 from coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 18.01.2018 um 13:43 hat Paolo Bonzini geschrieben:
> Check and invalidate_cache share some parts of the implementation
> with the regular I/O path.  This is sometimes complicated because the
> I/O path wants to use a CoMutex but that is not possible outside coroutine
> context.  By moving things to coroutine context, we can remove special
> cases.  In fact, invalidate_cache is already called from coroutine context
> because incoming migration is placed in a coroutine.
> 
> While at it, I'm including two patches from Stefan to rename the
> bdrv_create callback to bdrv_co_create, because it is already called
> from coroutine context.  The name is now bdrv_co_create_opts, with
> bdrv_co_create reserved for the QAPI-based version that Kevin is
> working on.
> 
> qcow2 still has cache flushing in non-coroutine context, coming from
> qcow2_reopen_prepare->qcow2_update_options_prepare and
> qcow2_close->qcow2_inactivate.

The patches looked good, but this deadlocks qemu-iotests 165 for me:

#0  0x0000562392ae1cb0 in qemu_coroutine_switch (from_=from_@entry=0x562393de2410, to_=to_@entry=0x7f81bf44ee48, action=action@entry=COROUTINE_YIELD) at util/coroutine-ucontext.c:219
#1  0x0000562392ae0ad1 in qemu_coroutine_yield () at util/qemu-coroutine.c:186
#2  0x0000562392ae0cb4 in qemu_co_mutex_lock_slowpath (mutex=0x562393de1870, ctx=0x562393dc1ad0) at util/qemu-coroutine-lock.c:269
#3  0x0000562392ae0cb4 in qemu_co_mutex_lock (mutex=mutex@entry=0x562393de1870) at util/qemu-coroutine-lock.c:307
#4  0x0000562392a149fc in qcow2_co_flush_to_os (bs=0x562393dd6750) at block/qcow2.c:3705
#5  0x0000562392a461c9 in bdrv_co_flush (bs=0x562393dd6750) at block/io.c:2439
#6  0x0000562392a46639 in bdrv_flush_co_entry (opaque=0x7f8195a7cd50) at block/io.c:2403
#7  0x0000562392a46639 in bdrv_flush (bs=bs@entry=0x562393dd6750) at block/io.c:2528
#8  0x0000562392a26de6 in update_header_sync (bs=bs@entry=0x562393dd6750) at block/qcow2-bitmap.c:113
#9  0x0000562392a26e5a in update_ext_header_and_dir_in_place (bs=bs@entry=0x562393dd6750, bm_list=bm_list@entry=0x562393de14f0) at block/qcow2-bitmap.c:826
#10 0x0000562392a27fa6 in qcow2_load_dirty_bitmaps (bs=bs@entry=0x562393dd6750, errp=errp@entry=0x7f8195a7ce68) at block/qcow2-bitmap.c:982
#11 0x0000562392a1947c in qcow2_do_open (bs=0x562393dd6750, options=<optimized out>, flags=8194, errp=0x7ffc3289a110) at block/qcow2.c:1501
#12 0x0000562392a198e2 in qcow2_open_entry (opaque=0x7ffc3289a0b0) at block/qcow2.c:1578
#13 0x0000562392ae1d1c in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:116
#14 0x00007f81a338d950 in __start_context () at /lib64/libc.so.6
#15 0x00007ffc32899920 in  ()
#16 0x0000000000000000 in  ()

Not saving the coroutine pointer anywhere was a bit nasty, too. gdb
only gave the coroutine pointer away with something as indirect as
'p ((BDRVQcow2State*) bs.opaque).lock.holder'.

Kevin
