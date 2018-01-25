Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eejCx-0004Hs-5J
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eejCp-0007Ni-8n
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:12:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eejCp-0007MN-1F
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:12:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5297E4E4F3
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 15:12:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F45C5EE1F
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 15:12:46 +0000 (UTC)
Date: Thu, 25 Jan 2018 10:12:46 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <206973175.2557292.1516893166087.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAK1Eb9moXi5y0TO42smwLYn3Wgx_Zm0ndjV_u_VtRGQYtNxf6w@mail.gmail.com>
References: <20180116142316.30486-1-pbonzini@redhat.com>
	<CAK1Eb9moXi5y0TO42smwLYn3Wgx_Zm0ndjV_u_VtRGQYtNxf6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



----- Original Message -----
> From: "Fam Zheng" <famz@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>
> Sent: Thursday, January 25, 2018 4:05:27 PM
> Subject: Re: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
> 
> On Tue, Jan 16, 2018 at 10:23 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > There are cases in which a queued coroutine must be restarted from
> > non-coroutine context (with qemu_co_enter_next).  In this cases,
> > qemu_co_enter_next also needs to be thread-safe, but it cannot use a
> > CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
> > right now is rolling its own list of Coroutines) and will happen in
> > Fam's NVMe driver as well.
> >
> > This series extracts the idea of a polymorphic lockable object
> > from my "scoped lock guard" proposal, and applies it to CoQueue.
> > The implementation of QemuLockable is similar to C11 _Generic, but
> > redone using the preprocessor and GCC builtins for compatibility.
> >
> > In general, while a bit on the esoteric side, the functionality used
> > to emulate _Generic is fairly old in GCC, and the builtins are already
> > used by include/qemu/atomic.h; the series was tested with Fedora 27 (boot
> > Damn Small Linux via http) and CentOS 6 (compiled only).
> 
> I'm seeing this crash with the series:
> 
> (gdb) bt
> #0  0x00007ff76204d66b in raise () at /lib64/libc.so.6
> #1  0x00007ff76204f381 in abort () at /lib64/libc.so.6
> #2  0x00007ff7620458fa in __assert_fail_base () at /lib64/libc.so.6
> #3  0x00007ff762045972 in  () at /lib64/libc.so.6
> #4  0x000055eaab249c68 in qemu_co_mutex_unlock (mutex=0x7ff750bf7b40)
> at /stor/work/qemu/util/qemu-coroutine-lock.c:320
> #5  0x000055eaab249da3 in qemu_lockable_unlock (x=0x7ff750bf7b40) at
> /stor/work/qemu/include/qemu/lockable.h:72
> #6  0x000055eaab249da3 in qemu_co_queue_wait_impl
> (queue=0x55eaaef41a08, lock=lock@entry=0x7ff750bf7b40) at
> /stor/work/qemu/util/qemu-coroutine-lock.c:49
> #7  0x000055eaab19f2b9 in handle_dependencies
> (bs=bs@entry=0x55eaad9c6620, guest_offset=guest_offset@entry=1597440,
> cur_bytes=cur_bytes@entry=0x7ff750bf7ba0, m=m@entry=0x7ff7
> 50bf7c58) at /stor/work/qemu/block/qcow2-cluster.c:1067
> #8  0x000055eaab1a1b85 in qcow2_alloc_cluster_offset
> (bs=bs@entry=0x55eaad9c6620, offset=offset@entry=1597440,
> bytes=bytes@entry=0x7ff750bf7c4c, host_offset=host_offset@entry
> =0x7ff750bf7c50, m=m@entry=0x7ff750bf7c58) at
> /stor/work/qemu/block/qcow2-cluster.c:1497
> #9  0x000055eaab19411e in qcow2_co_pwritev (bs=0x55eaad9c6620,
> offset=1597440, bytes=8192, qiov=0x55eaaedb4880, flags=<optimized
> out>) at /stor/work/qemu/block/qcow2.c:1896
> #10 0x000055eaab1c2962 in bdrv_driver_pwritev
> (bs=bs@entry=0x55eaad9c6620, offset=offset@entry=1597440,
> bytes=bytes@entry=8192, qiov=qiov@entry=0x55eaaedb4880, flags=flags@en
> try=0) at /stor/work/qemu/block/io.c:976
> #11 0x000055eaab1c3985 in bdrv_aligned_pwritev
> (child=child@entry=0x55eaad92bd00, req=req@entry=0x7ff750bf7e70,
> offset=offset@entry=1597440, bytes=bytes@entry=8192, align=ali
> gn@entry=1, qiov=qiov@entry=0x55eaaedb4880, flags=0) at
> /stor/work/qemu/block/io.c:1534
> #12 0x000055eaab1c4ca5 in bdrv_co_pwritev (child=0x55eaad92bd00,
> offset=offset@entry=1597440, bytes=bytes@entry=8192,
> qiov=qiov@entry=0x55eaaedb4880, flags=flags@entry=0)
>    at /stor/work/qemu/block/io.c:1785
> #13 0x000055eaab1b4f06 in blk_co_pwritev (blk=0x55eaad9c63c0,
> offset=1597440, bytes=8192, qiov=0x55eaaedb4880, flags=0) at
> /stor/work/qemu/block/block-backend.c:1135
> #14 0x000055eaab1b4fff in blk_aio_write_entry (opaque=0x55eaaefc5eb0)
> at /stor/work/qemu/block/block-backend.c:1326
> #15 0x000055eaab24a77a in coroutine_trampoline (i0=<optimized out>,
> i1=<optimized out>) at /stor/work/qemu/util/coroutine-ucontext.c:79
> #16 0x00007ff762066bc0 in __start_context () at /lib64/libc.so.6
> #17 0x00007ffdf69102d0 in  ()
> #18 0x0000000000000000 in  ()
> 
> It's late today so I'll take a closer look tomorrow.

Ouch.  /me bangs the head against the wall and runs writing testcases.
Sorry.

Paolo
