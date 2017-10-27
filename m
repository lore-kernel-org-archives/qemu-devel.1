Received: from eggs.gnu.org ([2001:4830:134:3::10]:49793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e7yoz-000844-HP
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e7you-0002R5-GP
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:12:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1e7you-0002QY-7S
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:12:44 -0400
Date: Fri, 27 Oct 2017 03:12:41 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171027071241.GA30326@localhost.localdomain>
References: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
	<d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
Subject: Re: [Qemu-devel] iotest 194 fails on vhdx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Oct 25, 2017 at 05:06:37PM +1100, Alexey Kardashevskiy wrote:
> On 25/10/17 15:29, Alexey Kardashevskiy wrote:
> > Hi!
> > 
> > The latest QEMU fails on:
> > tests/qemu-iotests/check -vhdx 194
> 
> 
> Bit more details:
> 
> 1. the assert started appearing from
> https://git.qemu.org/?p=qemu.git;a=commit;h=09e0c771e47 - this one just
> added the assert;
> 
> 2. if removed, then another assert alerts:
> qemu-system-ppc64: /home/aik/p/qemu/block/io.c:1423: bdrv_aligned_pwritev:
> Assertion `child->perm & BLK_PERM_WRITE' failed.
> 
> child->perm == 1 when this happens.
> 
> Any clues?
> 

Yes - what is happening is that if the VHDX image file is open RDWR, we
update the VHDX header.  However, since we are INMIGRATE, the
underlying file bs is marked as INACTIVE, and we are caught by the assert.


However, per the spec the header file and data guids only need to be updated
before the first modification is made.  We already have a latching call to
update the headers on the first write to the VHDX image (in vhdx_co_writev),
so the call to vhdx_update_headers() in vhdx_open() is a bug, and can be
removed.

Once that is fixed, 194 still fails for VHDX, but it doesn't crash.  The
failure is expected, because VHDX does not support migration (VMDK fails the
same way).  So test 194 should also be updated to exclude image formats that
set migration blockers.

(Patches sent)

-Jeff

> > 
> > 
> > /home/aik/pbuild/qemu-aikhostos2-ppc64-softmmu-debug-build/ppc64-softmmu/qemu-system-ppc64
> > \
> >  -chardev socket,id=mon,path=/home/aik/qemudest-monitor.sock \
> >  -mon chardev=mon,mode=control \
> >  -display none \
> >  -vga none \
> >  -machine accel=qtest \
> >  -nodefaults \
> >  -incoming unix:/home/aik/qemu-migration.sock \
> >  -drive if=virtio,id=drive0,file=/home/aik/dest.img,format=vhdx,cache=writeback
> > 
> > 
> > GDB says it is assert(!(bs->open_flags & BDRV_O_INACTIVE)). The very same
> > test passes with a qcow2 image. Does it look any familiar to anyone? Where
> > to start digging from? Thanks.
> > 
> > 
> > 
> > (gdb) r
> > Starting program:
> > /home/aik/pbuild/qemu-aikhostos2-ppc64-softmmu-debug-build/ppc64-softmmu/qemu-system-ppc64
> > -chardev socket,id=mon,path=/home/a
> > ik/qemudest-monitor.sock -mon chardev=mon,mode=control -display none -vga
> > none -machine accel=qtest -nodefaults -incoming unix:/home/aik/qemu-mi
> > gration.sock -drive
> > if=virtio,id=drive0,file=/home/aik/dest.img,format=vhdx,cache=writeback
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> > [New Thread 0x7ffff698eb80 (LWP 70705)]
> > [New Thread 0x7ffff607eb80 (LWP 70706)]
> > qemu-system-ppc64: /home/aik/p/qemu/block/io.c:1601: bdrv_co_pwritev:
> > Assertion `!(bs->open_flags & 0x0800)' failed.
> > 
> > Program received signal SIGABRT, Aborted.
> > 0x00007ffff77deff0 in raise () from /lib64/libc.so.6
> > (gdb) bt
> > #0  0x00007ffff77deff0 in raise () from /lib64/libc.so.6
> > #1  0x00007ffff77e136c in abort () from /lib64/libc.so.6
> > #2  0x00007ffff77d4c44 in __assert_fail_base () from /lib64/libc.so.6
> > #3  0x00007ffff77d4d34 in __assert_fail () from /lib64/libc.so.6
> > #4  0x000000001074ce44 in bdrv_co_pwritev (child=0x111c6160, offset=65536,
> > bytes=80, qiov=0x7fffffffe090, flags=0)
> >     at /home/aik/p/qemu/block/io.c:1601
> > #5  0x0000000010749408 in bdrv_rw_co_entry (opaque=0x7fffffffdfa0) at
> > /home/aik/p/qemu/block/io.c:620
> > #6  0x0000000010857188 in coroutine_trampoline (i0=287156048, i1=0) at
> > /home/aik/p/qemu/util/coroutine-ucontext.c:79
> > #7  0x00007ffff77f2b9c in makecontext () from /lib64/libc.so.6
> > #8  0x0000000000000000 in ?? ()
> > (gdb) p bs->open_flags
> > No symbol "bs" in current context.
> > (gdb) up
> > #1  0x00007ffff77e136c in abort () from /lib64/libc.so.6
> > (gdb)
> > #2  0x00007ffff77d4c44 in __assert_fail_base () from /lib64/libc.so.6
> > (gdb)
> > #3  0x00007ffff77d4d34 in __assert_fail () from /lib64/libc.so.6
> > (gdb)
> > #4  0x000000001074ce44 in bdrv_co_pwritev (child=0x111c6160, offset=65536,
> > bytes=80, qiov=0x7fffffffe090, flags=0)
> >     at /home/aik/p/qemu/block/io.c:1601
> > 1601        assert(!(bs->open_flags & BDRV_O_INACTIVE));
> > (gdb) p/x bs->open_flags
> > $2 = 0xe802
> > (gdb)
> > 
> > 
> 
> 
> -- 
> Alexey
> 
