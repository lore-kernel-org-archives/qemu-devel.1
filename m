Received: from eggs.gnu.org ([2001:4830:134:3::10]:37341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Rai-0008Hs-T5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Rah-0004Ik-Ou
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:12:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Rah-0004I8-Gc
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:12:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id e21-v6so18892542otk.10
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 02:12:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005180901.GA32677@localhost.localdomain>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
	<20181005180901.GA32677@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 10:12:17 +0100
Message-ID: <CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2018 at 19:09, Kevin Wolf <kwolf@redhat.com> wrote:
> And if we disable it wholesale, then nobody has any incentive to fix any
> bug that the test case could have uncovered.

Yes, that's fair. I'm sorry; I was a bit grumpy when I wrote
that email because my test runs had been bumping into it all day.

> Look, if this were on BSD or something, I'd even setup a BSD VM and try
> to investigate. With OS X, that's not an option. If OS X users care
> about the bug, they need to fix it. If you want to give them an
> incentive, then the test case needs to stay enabled. If they don't care,
> we can disable the test case for OS X (and leave QEMU broken if it's a
> real bug, but eventually someone will certainly report a bug in a real
> life scenario in that case).

I looked back at the backtrace/etc that I posted earlier in this
thread, and it looked to me like maybe a memory corruption issue.
So I tried running the test under valgrind on Linux, and:
$ valgrind ./build/x86/tests/test-bdrv-drain
[...]
/bdrv-drain/iothread/drain_all: OK
/bdrv-drain/iothread/drain: ==7972== Thread 4:
==7972== Invalid read of size 1
==7972==    at 0x24BCBE: aio_notify (async.c:352)
==7972==    by 0x24B6FB: qemu_bh_schedule (async.c:168)
==7972==    by 0x24C0FE: aio_co_schedule (async.c:465)
==7972==    by 0x24C174: aio_co_enter (async.c:484)
==7972==    by 0x24C143: aio_co_wake (async.c:478)
==7972==    by 0x129558: co_reenter_bh (test-bdrv-drain.c:63)
==7972==    by 0x24B525: aio_bh_call (async.c:90)
==7972==    by 0x24B5BD: aio_bh_poll (async.c:118)
==7972==    by 0x250C6D: aio_poll (aio-posix.c:690)
==7972==    by 0x20BB32: iothread_run (iothread.c:51)
==7972==    by 0x253888: qemu_thread_start (qemu-thread-posix.c:504)
==7972==    by 0x19D5C6B9: start_thread (pthread_create.c:333)
==7972==  Address 0x20c0e3b0 is 176 bytes inside a block of size 312 free'd
==7972==    at 0x4C2EDEB: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7972==    by 0x18DFE289: g_source_unref_internal (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x24C241: aio_context_unref (async.c:506)
==7972==    by 0x20BBB2: iothread_join (iothread.c:65)
==7972==    by 0x12DD5E: test_iothread_common (test-bdrv-drain.c:727)
==7972==    by 0x12DDCB: test_iothread_drain (test-bdrv-drain.c:740)
==7972==    by 0x18E2687A: g_test_run_suite_internal (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x18E26A42: g_test_run_suite_internal (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x18E26A42: g_test_run_suite_internal (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x18E26C4D: g_test_run_suite (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x18E26C70: g_test_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x13073A: main (test-bdrv-drain.c:1350)
==7972==  Block was alloc'd at
==7972==    at 0x4C2FB55: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7972==    by 0x18E06810: g_malloc0 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x18DFEC29: g_source_new (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==7972==    by 0x24BE6B: aio_context_new (async.c:413)
==7972==    by 0x20BAE6: iothread_run (iothread.c:46)
==7972==    by 0x253888: qemu_thread_start (qemu-thread-posix.c:504)
==7972==    by 0x19D5C6B9: start_thread (pthread_create.c:333)
==7972==    by 0x1A07941C: clone (clone.S:109)
==7972==
OK
/bdrv-drain/iothread/drain_subtree: OK
[...]

which is indeed a use-after-free in the test immediately before
the one that crashes on OSX. Could I ask you to have a look at
that error, please? Hopefully it will turn out to be the underlying
cause of the OSX problems.

thanks
-- PMM
