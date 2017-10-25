Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7Eq1-0006qb-0V
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7Epw-0003Pa-Ci
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:06:48 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:53834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7Epw-0003Ok-6s
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:06:44 -0400
Received: by mail-it0-x232.google.com with SMTP id n195so12776300itg.2
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 23:06:43 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
Message-ID: <d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
Date: Wed, 25 Oct 2017 17:06:37 +1100
MIME-Version: 1.0
In-Reply-To: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] iotest 194 fails on vhdx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 25/10/17 15:29, Alexey Kardashevskiy wrote:
> Hi!
> 
> The latest QEMU fails on:
> tests/qemu-iotests/check -vhdx 194


Bit more details:

1. the assert started appearing from
https://git.qemu.org/?p=qemu.git;a=commit;h=09e0c771e47 - this one just
added the assert;

2. if removed, then another assert alerts:
qemu-system-ppc64: /home/aik/p/qemu/block/io.c:1423: bdrv_aligned_pwritev:
Assertion `child->perm & BLK_PERM_WRITE' failed.

child->perm == 1 when this happens.

Any clues?


> 
> 
> /home/aik/pbuild/qemu-aikhostos2-ppc64-softmmu-debug-build/ppc64-softmmu/qemu-system-ppc64
> \
>  -chardev socket,id=mon,path=/home/aik/qemudest-monitor.sock \
>  -mon chardev=mon,mode=control \
>  -display none \
>  -vga none \
>  -machine accel=qtest \
>  -nodefaults \
>  -incoming unix:/home/aik/qemu-migration.sock \
>  -drive if=virtio,id=drive0,file=/home/aik/dest.img,format=vhdx,cache=writeback
> 
> 
> GDB says it is assert(!(bs->open_flags & BDRV_O_INACTIVE)). The very same
> test passes with a qcow2 image. Does it look any familiar to anyone? Where
> to start digging from? Thanks.
> 
> 
> 
> (gdb) r
> Starting program:
> /home/aik/pbuild/qemu-aikhostos2-ppc64-softmmu-debug-build/ppc64-softmmu/qemu-system-ppc64
> -chardev socket,id=mon,path=/home/a
> ik/qemudest-monitor.sock -mon chardev=mon,mode=control -display none -vga
> none -machine accel=qtest -nodefaults -incoming unix:/home/aik/qemu-mi
> gration.sock -drive
> if=virtio,id=drive0,file=/home/aik/dest.img,format=vhdx,cache=writeback
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [New Thread 0x7ffff698eb80 (LWP 70705)]
> [New Thread 0x7ffff607eb80 (LWP 70706)]
> qemu-system-ppc64: /home/aik/p/qemu/block/io.c:1601: bdrv_co_pwritev:
> Assertion `!(bs->open_flags & 0x0800)' failed.
> 
> Program received signal SIGABRT, Aborted.
> 0x00007ffff77deff0 in raise () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff77deff0 in raise () from /lib64/libc.so.6
> #1  0x00007ffff77e136c in abort () from /lib64/libc.so.6
> #2  0x00007ffff77d4c44 in __assert_fail_base () from /lib64/libc.so.6
> #3  0x00007ffff77d4d34 in __assert_fail () from /lib64/libc.so.6
> #4  0x000000001074ce44 in bdrv_co_pwritev (child=0x111c6160, offset=65536,
> bytes=80, qiov=0x7fffffffe090, flags=0)
>     at /home/aik/p/qemu/block/io.c:1601
> #5  0x0000000010749408 in bdrv_rw_co_entry (opaque=0x7fffffffdfa0) at
> /home/aik/p/qemu/block/io.c:620
> #6  0x0000000010857188 in coroutine_trampoline (i0=287156048, i1=0) at
> /home/aik/p/qemu/util/coroutine-ucontext.c:79
> #7  0x00007ffff77f2b9c in makecontext () from /lib64/libc.so.6
> #8  0x0000000000000000 in ?? ()
> (gdb) p bs->open_flags
> No symbol "bs" in current context.
> (gdb) up
> #1  0x00007ffff77e136c in abort () from /lib64/libc.so.6
> (gdb)
> #2  0x00007ffff77d4c44 in __assert_fail_base () from /lib64/libc.so.6
> (gdb)
> #3  0x00007ffff77d4d34 in __assert_fail () from /lib64/libc.so.6
> (gdb)
> #4  0x000000001074ce44 in bdrv_co_pwritev (child=0x111c6160, offset=65536,
> bytes=80, qiov=0x7fffffffe090, flags=0)
>     at /home/aik/p/qemu/block/io.c:1601
> 1601        assert(!(bs->open_flags & BDRV_O_INACTIVE));
> (gdb) p/x bs->open_flags
> $2 = 0xe802
> (gdb)
> 
> 


-- 
Alexey
