Received: from eggs.gnu.org ([2001:4830:134:3::10]:43320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d82Aj-0000iJ-3e
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d82Af-0005bR-St
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:15:13 -0400
Date: Tue, 9 May 2017 11:15:06 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170509101506.GQ16511@redhat.com>
References: <20170509093549.25157-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509093549.25157-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] curl: locking cleanups and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, jcody@redhat.com


No I'm afraid this patch series does not fix the bug.

The stack trace is below.

Rich.

Thread 4 (Thread 0x7f8595cf1700 (LWP 11235)):
#0  0x00007f86348e6700 in do_futex_wait () at /lib64/libpthread.so.0
#1  0x00007f86348e6813 in __new_sem_wait_slow () at /lib64/libpthread.so.0
#2  0x00005610e458519f in qemu_sem_timedwait (sem=sem@entry=0x5610e5db7508, ms=ms@entry=10000) at util/qemu-thread-posix.c:255
#3  0x00005610e458043c in worker_thread (opaque=0x5610e5db74a0)
    at util/thread-pool.c:92
#4  0x00007f86348dd36d in start_thread () at /lib64/libpthread.so.0
#5  0x00007f862e830e0f in clone () at /lib64/libc.so.6

Thread 3 (Thread 0x7f8621347700 (LWP 10865)):
#0  0x00007f862e826837 in ioctl () at /lib64/libc.so.6
#1  0x00005610e4216387 in kvm_vcpu_ioctl (cpu=cpu@entry=0x5610e60f2030, type=type@entry=44672) at /home/rjones/d/qemu/kvm-all.c:2154
#2  0x00005610e42164be in kvm_cpu_exec (cpu=cpu@entry=0x5610e60f2030)
    at /home/rjones/d/qemu/kvm-all.c:1992
#3  0x00005610e4202f94 in qemu_kvm_cpu_thread_fn (arg=0x5610e60f2030)
    at /home/rjones/d/qemu/cpus.c:1118
#4  0x00007f86348dd36d in start_thread () at /lib64/libpthread.so.0
#5  0x00007f862e830e0f in clone () at /lib64/libc.so.6

Thread 2 (Thread 0x7f8626559700 (LWP 10863)):
#0  0x00007f862e82b7a9 in syscall () at /lib64/libc.so.6
#1  0x00005610e4585325 in qemu_futex_wait (val=<optimized out>, f=<optimized out>) at /home/rjones/d/qemu/include/qemu/futex.h:26
#2  0x00005610e4585325 in qemu_event_wait (ev=ev@entry=0x5610e5019ee4 <rcu_call_ready_event>) at util/qemu-thread-posix.c:399
#3  0x00005610e459539e in call_rcu_thread (opaque=<optimized out>)
    at util/rcu.c:249
#4  0x00007f86348dd36d in start_thread () at /lib64/libpthread.so.0
#5  0x00007f862e830e0f in clone () at /lib64/libc.so.6

Thread 1 (Thread 0x7f863757dc80 (LWP 10861)):
#0  0x00007f862e824dc6 in ppoll () at /lib64/libc.so.6
#1  0x00005610e4580ea9 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:77
#2  0x00005610e4580ea9 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:322
#3  0x00005610e4582af4 in aio_poll (ctx=ctx@entry=0x5610e5d92860, blocking=<optimized out>) at util/aio-posix.c:622
#4  0x00007f8624848299 in curl_init_state (bs=<optimized out>, s=s@entry=0x5610e5defb10) at block/curl.c:490
#5  0x00007f8624848a51 in curl_readv_bh_cb (p=0x5610e78afb70)
    at block/curl.c:871
#6  0x00005610e457fb1e in aio_bh_call (bh=0x5610e6128f10) at util/async.c:90
#7  0x00005610e457fb1e in aio_bh_poll (ctx=ctx@entry=0x5610e5d92860)
    at util/async.c:118
#8  0x00005610e4582cf4 in aio_poll (ctx=ctx@entry=0x5610e5d92860, blocking=<optimized out>) at util/aio-posix.c:682
#9  0x00007f8624848299 in curl_init_state (bs=<optimized out>, s=s@entry=0x5610e5defb10) at block/curl.c:490
#10 0x00007f8624848a51 in curl_readv_bh_cb (p=0x5610e6f01380)
    at block/curl.c:871
#11 0x00005610e457fb1e in aio_bh_call (bh=0x5610e6e1fff0) at util/async.c:90
#12 0x00005610e457fb1e in aio_bh_poll (ctx=ctx@entry=0x5610e5d92860)
    at util/async.c:118
#13 0x00005610e4582cf4 in aio_poll (ctx=ctx@entry=0x5610e5d92860, blocking=<optimized out>) at util/aio-posix.c:682
#14 0x00007f8624848299 in curl_init_state (bs=<optimized out>, s=s@entry=0x5610e5defb10) at block/curl.c:490
#15 0x00007f8624848a51 in curl_readv_bh_cb (p=0x5610e77d6ec0)
    at block/curl.c:871
#16 0x00005610e457fb1e in aio_bh_call (bh=0x5610e7229960) at util/async.c:90
#17 0x00005610e457fb1e in aio_bh_poll (ctx=ctx@entry=0x5610e5d92860)
    at util/async.c:118
#18 0x00005610e4582cf4 in aio_poll (ctx=ctx@entry=0x5610e5d92860, blocking=<optimized out>) at util/aio-posix.c:682
#19 0x00007f8624848299 in curl_init_state (bs=<optimized out>, s=s@entry=0x5610e5defb10) at block/curl.c:490
#20 0x00007f8624848a51 in curl_readv_bh_cb (p=0x5610e7877220)
    at block/curl.c:871
#21 0x00005610e457fb1e in aio_bh_call (bh=0x5610e7054e20) at util/async.c:90
#22 0x00005610e457fb1e in aio_bh_poll (ctx=ctx@entry=0x5610e5d92860)
    at util/async.c:118
#23 0x00005610e4582cf4 in aio_poll (ctx=ctx@entry=0x5610e5d92860, blocking=<optimized out>) at util/aio-posix.c:682
#24 0x00007f8624848299 in curl_init_state (bs=<optimized out>, s=s@entry=0x5610e5defb10) at block/curl.c:490
#25 0x00007f8624848a51 in curl_readv_bh_cb (p=0x5610e7903cb0)
    at block/curl.c:871
#26 0x00005610e457fb1e in aio_bh_call (bh=0x5610e7903d10) at util/async.c:90
#27 0x00005610e457fb1e in aio_bh_poll (ctx=ctx@entry=0x5610e5d92860)
    at util/async.c:118
#28 0x00005610e4582cf4 in aio_poll (ctx=ctx@entry=0x5610e5d92860, blocking=<optimized out>) at util/aio-posix.c:682
#29 0x00007f8624848299 in curl_init_state (bs=<optimized out>, s=s@entry=0x5610e5defb10) at block/curl.c:490
#30 0x00007f8624848a51 in curl_readv_bh_cb (p=0x5610e7146fb0)
    at block/curl.c:871
#31 0x00005610e457fb1e in aio_bh_call (bh=0x5610e70593d0) at util/async.c:90
#32 0x00005610e457fb1e in aio_bh_poll (ctx=ctx@entry=0x5610e5d92860)
    at util/async.c:118
#33 0x00005610e45829c0 in aio_dispatch (ctx=0x5610e5d92860)
    at util/aio-posix.c:429
#34 0x00005610e457f9fe in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:261
#35 0x00007f863235d1d7 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#36 0x00005610e4581c17 in glib_pollfds_poll () at util/main-loop.c:213
#37 0x00005610e4581c17 in os_host_main_loop_wait (timeout=<optimized out>)
    at util/main-loop.c:261
#38 0x00005610e4581c17 in main_loop_wait (nonblocking=<optimized out>)
    at util/main-loop.c:517
#39 0x00005610e41c3ad1 in main_loop () at vl.c:1899
#40 0x00005610e41c3ad1 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4719


-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
