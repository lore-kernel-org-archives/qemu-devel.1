Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMvQl-0006Gr-3Y
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMvQj-0005CN-Hl
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMvQj-0005Bt-8b
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:05:17 -0400
From: David Hildenbrand <david@redhat.com>
References: <20170615203735.19649-1-rth@twiddle.net>
	<7998cb6b-018e-8069-9d11-a3e1e4e70380@redhat.com>
Message-ID: <429793f7-a3c1-91ec-9a83-908ee779e703@redhat.com>
Date: Mon, 19 Jun 2017 14:05:13 +0200
MIME-Version: 1.0
In-Reply-To: <7998cb6b-018e-8069-9d11-a3e1e4e70380@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 19.06.2017 12:03, David Hildenbrand wrote:
> On 15.06.2017 22:37, Richard Henderson wrote:
>> There are no uses in a Linux system with which to test,
>> but it Looks Right by my reading of the PoO.
> 
> I am using next.git/master with this patch applied:
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=8aa8680aa383bf6e2ac
> 
> I am using QEMU with the mvcos patch and your patch applied (and a patch
> that allows enabling csst/csst2).
> 
> I am using the following qemu command line:
> 
> #!/bin/bash
> /home/dhildenb/git/qemu/s390x-softmmu/qemu-system-s390x \
> 	-nographic -nodefaults -machine s390-ccw-virtio,accel=tcg \
> 	-cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>           eimm=on,stckf=on,csst=on,csst2=on,ginste=on,exrl=on\
> 	-m 256M -smp 1 -chardev stdio,id=con0 \
> 	-device sclpconsole,chardev=con0 \
> 	-kernel vmlinux -initrd /home/dhildenb/initrd.debian
> 
> Right now, I can start a z9 compiled kernel.
> 
> When trying to start a z10 compiled kernel (which generates many csst),
> qemu simply crashes / the guests exits (have to debug) without any
> command line output.
> 
> So either something in csst is broken or in the other instructions for z10.
> 

With CONFIG_DEBUG_LOCKDEP I get a pgm exception in check_no_collision()
and the kernel can't find an exception table for it, resulting in a panic().

#0  0x00000000001cf584 in check_no_collision (chain=<optimized out>,
hlock=<optimized out>, curr=<optimized out>)
    at kernel/locking/lockdep.c:2111
#1  lookup_chain_cache (chain_key=<optimized out>, hlock=<optimized
out>, curr=<optimized out>)
    at kernel/locking/lockdep.c:2158
#2  validate_chain (curr=0xdad300 <init_task>, hlock=0x18398c8
<lock_classes>, chain_head=<optimized out>,
    chain_key=10957502631322533163, lock=<optimized out>) at
kernel/locking/lockdep.c:2252
#3  0x00000000001d089a in __lock_acquire (lock=<optimized out>,
subclass=<optimized out>, trylock=0, read=0,
    check=1, hardirqs_off=<optimized out>, nest_lock=0x0, ip=15545474,
references=<optimized out>,
    pin_count=<optimized out>) at kernel/locking/lockdep.c:3367
#4  0x00000000001d15a6 in lock_acquire (lock=<optimized out>,
subclass=<optimized out>, trylock=<optimized out>,
    read=<optimized out>, check=1, nest_lock=0x0, ip=15545474) at
kernel/locking/lockdep.c:3855
#5  0x00000000009b76cc in __mutex_lock_common (use_ww_ctx=<optimized
out>, ww_ctx=<optimized out>,
    ip=<optimized out>, nest_lock=<optimized out>, subclass=<optimized
out>, state=<optimized out>,
    lock=<optimized out>) at kernel/locking/mutex.c:756
#6  __mutex_lock (lock=0xded840 <cgroup_mutex>, state=2, subclass=0,
nest_lock=0x0, ip=<optimized out>)
    at kernel/locking/mutex.c:893
#7  0x00000000009b801a in mutex_lock_nested (lock=<optimized out>,
subclass=<optimized out>)
    at kernel/locking/mutex.c:908
#8  0x0000000000ed3482 in cgroup_init_subsys (ss=0xdd2340
<cpu_cgrp_subsys>, early=true)
    at kernel/cgroup/cgroup.c:4403
#9  0x0000000000ed3752 in cgroup_init_early () at
kernel/cgroup/cgroup.c:4481
#10 0x0000000000ebd79a in start_kernel () at init/main.c:502
#11 0x0000000000100020 in _stext () at arch/s390/kernel/head64.S:100


  1cf552:       e3 10 c0 30 00 04       lg      %r1,48(%r12)
  1cf558:       eb 11 00 33 00 0c       srlg    %r1,%r1,51
  1cf55e:       eb c1 00 05 00 0d       sllg    %r12,%r1,5
  1cf564:       b9 09 00 c1             sgr     %r12,%r1
  1cf568:       eb cc 00 04 00 0d       sllg    %r12,%r12,4
  1cf56e:       e3 c0 d0 28 00 08       ag      %r12,40(%r13)
  1cf574:       a7 f4 ff 6f             j       1cf452
<validate_chain.isra.23+0xba2>
        if (DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i
- 1))) {
  1cf578:       c0 30 00 4c cc e3       larl    %r3,b68f3e
<kallsyms_token_index+0x10626>
  1cf57e:       c0 20 00 4c 95 37       larl    %r2,b61fec
<kallsyms_token_index+0x96d4>
  1cf584:       c0 e5 00 07 f1 2e       brasl   %r14,2cd7e0 <printk>
  1cf58a:       a7 f4 00 01             j       1cf58c
<validate_chain.isra.23+0xcdc>
  1cf58e:       a7 f4 fc d9             j       1cef40
<validate_chain.isra.23+0x690>


Without CONFIG_DEBUG_LOCKDEP:

I get a similar crash in static void __init mm_init(void).


Not sure yet what the real root cause is. Maybe something not related to
CSST.


-- 

Thanks,

David
