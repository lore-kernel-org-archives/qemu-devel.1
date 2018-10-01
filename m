Received: from eggs.gnu.org ([2001:4830:134:3::10]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g70lY-0005dZ-3c
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g70lX-0001tJ-6J
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:09:48 -0400
Date: Mon, 1 Oct 2018 18:09:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181001160937.GC4445@localhost.localdomain>
References: <20180925151541.18932-1-mreitz@redhat.com>
	<CAFEAcA-3bf02knEbNgq5ouFVnJDL6a9HqAvCo3Z4vaWYu-8yUw@mail.gmail.com>
	<CAFEAcA9cKPNKs_eR638eEqbAVW9sLxwHdnKVb-P-6hXJ3Kwyig@mail.gmail.com>
	<CAFEAcA95G4Nc4+Av0JNeh2NHa5NZR1wyos28V9xhQZn4v0WAWA@mail.gmail.com>
	<20181001141430.GA4445@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001141430.GA4445@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 00/42] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com

Am 01.10.2018 um 16:14 hat Kevin Wolf geschrieben:
> Am 01.10.2018 um 15:03 hat Peter Maydell geschrieben:
> > On 28 September 2018 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > I'm finding that test-bdrv-drain hangs intermittently on my OSX host.
> > 
> > Ping? Between this and test-replication I'm finding that my
> > parallel build tests for merges are failing about 50% of the
> > time :-(
> 
> Sorry, there wasn't much more than a weekend between your report and
> now.
> 
> For the replication one, I think we can just take the AioContext lock in
> the test case while we decide how the API should really be used. I'll
> prepare a fix for that (and hopefully I'll be able to reproduce the
> problem reliably enough to verify the fix).
> 
> Max said he could reproduce some hang in test-bdrv-drain (though we
> don't know if this has anything to do with your OS X hang, which looked
> rather odd) and would look into it, but I don't think we know the
> problem yet. I'll try to reproduce that one after fixing the replication
> test.

So I sent two patches for the two test cases that should fix the bugs
that made the tests fail relatively frequently. I can still reproduce
another hang, which is a bit mysterious to me:

Thread 2 (Thread 3321.3818):
#0  0x00007f2ebbdcc4e9 in syscall () from /lib64/libc.so.6
#1  0x00005594d095690b in qemu_futex_wait (val=<optimized out>, f=<optimized out>) at /home/kwolf/source/qemu/include/qemu/futex.h:29
#2  qemu_event_wait (ev=ev@entry=0x5594d0bff228 <rcu_call_ready_event>) at util/qemu-thread-posix.c:442
#3  0x00005594d0965f58 in call_rcu_thread (opaque=<optimized out>) at util/rcu.c:261
#4  0x00007f2ebc09d36d in start_thread () from /lib64/libpthread.so.0
#5  0x00007f2ebbdd1b4f in clone () from /lib64/libc.so.6

Thread 1 (Thread 3321.3321):
#0  0x00007f2ebc09e89d in pthread_join () from /lib64/libpthread.so.0
#1  0x00005594d0956b6f in qemu_thread_join (thread=thread@entry=0x5594d16bd0b8) at util/qemu-thread-posix.c:565
#2  0x00005594d091f4d9 in iothread_join (iothread=0x5594d16bd0b0) at tests/iothread.c:62
#3  0x00005594d08806cc in test_iothread_common (drain_type=BDRV_DRAIN_ALL, drain_thread=<optimized out>) at tests/test-bdrv-drain.c:763
#4  0x00007f2ebd58e178 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#5  0x00007f2ebd58e37b in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#6  0x00007f2ebd58e37b in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#7  0x00007f2ebd58e51b in g_test_run_suite () from /lib64/libglib-2.0.so.0
#8  0x00007f2ebd58e571 in g_test_run () from /lib64/libglib-2.0.so.0
#9  0x00005594d087a534 in main (argc=<optimized out>, argv=<optimized out>) at tests/test-bdrv-drain.c:1606

This pthread_join() is waiting for a thread that doesn't even exist any
more. I caught the bug in rr and am clearly seeing how the iothread is
notified and terminates. But pthread_join() just doesn't return.

Kevin
