Received: from eggs.gnu.org ([2001:4830:134:3::10]:35378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Xhf-0007Z3-SH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Xhc-0006sF-FT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:44:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Xhb-0006rS-VE
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:44:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id l1so6985968otj.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 08:44:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
	<20181005180901.GA32677@localhost.localdomain>
	<CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 16:43:50 +0100
Message-ID: <CAFEAcA8gYwFZynMyiEHf+VPbaBerA9JTUPAHsipEvOqkBjHxMQ@mail.gmail.com>
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
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 8 October 2018 at 10:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> I looked back at the backtrace/etc that I posted earlier in this
> thread, and it looked to me like maybe a memory corruption issue.
> So I tried running the test under valgrind on Linux, and:

...which goes away if I do a complete build from clean, so
presumably is the result of a stale .o file?

The OSX version I'm running doesn't support valgrind, but
the C compiler does have the clang sanitizers. Here's a
log from a build with -fsanitize=address -fsanitize=undefined
of commit df51a005192ee40b:

$ ./tests/test-bdrv-drain
/bdrv-drain/nested: ==60415==WARNING: ASan is ignoring requested
__asan_handle_no_return: stack top: 0x7ffee500e000; bottom
0x00010fa0d000; size: 0x7ffdd5601000 (140728183296000)
False positive error reports may follow
For details see https://github.com/google/sanitizers/issues/189
OK
/bdrv-drain/multiparent: OK
/bdrv-drain/driver-cb/drain_all: OK
/bdrv-drain/driver-cb/drain: OK
/bdrv-drain/driver-cb/drain_subtree: OK
/bdrv-drain/driver-cb/co/drain_all: OK
/bdrv-drain/driver-cb/co/drain: OK
/bdrv-drain/driver-cb/co/drain_subtree: OK
/bdrv-drain/quiesce/drain_all: OK
/bdrv-drain/quiesce/drain: OK
/bdrv-drain/quiesce/drain_subtree: OK
/bdrv-drain/quiesce/co/drain_all: OK
/bdrv-drain/quiesce/co/drain: OK
/bdrv-drain/quiesce/co/drain_subtree: OK
/bdrv-drain/graph-change/drain_subtree: OK
/bdrv-drain/graph-change/drain_all: OK
/bdrv-drain/iothread/drain_all:
=================================================================
==60415==ERROR: AddressSanitizer: heap-use-after-free on address
0x60d000010060 at pc 0x00010b329270 bp 0x7000036c9d10 sp
0x7000036c9d08
READ of size 8 at 0x60d000010060 thread T3
    #0 0x10b32926f in notifier_list_notify notify.c:39
    #1 0x10b2b8622 in qemu_thread_atexit_run qemu-thread-posix.c:473
    #2 0x7fff5a0e1162 in _pthread_tsd_cleanup
(libsystem_pthread.dylib:x86_64+0x5162)
    #3 0x7fff5a0e0ee8 in _pthread_exit (libsystem_pthread.dylib:x86_64+0x4ee8)
    #4 0x7fff5a0df66b in _pthread_body (libsystem_pthread.dylib:x86_64+0x366b)
    #5 0x7fff5a0df50c in _pthread_start (libsystem_pthread.dylib:x86_64+0x350c)
    #6 0x7fff5a0debf8 in thread_start (libsystem_pthread.dylib:x86_64+0x2bf8)

0x60d000010060 is located 48 bytes inside of 144-byte region
[0x60d000010030,0x60d0000100c0)
freed by thread T3 here:
    #0 0x10bcc51bd in wrap_free
(libclang_rt.asan_osx_dynamic.dylib:x86_64+0x551bd)
    #1 0x7fff5a0e1162 in _pthread_tsd_cleanup
(libsystem_pthread.dylib:x86_64+0x5162)
    #2 0x7fff5a0e0ee8 in _pthread_exit (libsystem_pthread.dylib:x86_64+0x4ee8)
    #3 0x7fff5a0df66b in _pthread_body (libsystem_pthread.dylib:x86_64+0x366b)
    #4 0x7fff5a0df50c in _pthread_start (libsystem_pthread.dylib:x86_64+0x350c)
    #5 0x7fff5a0debf8 in thread_start (libsystem_pthread.dylib:x86_64+0x2bf8)

previously allocated by thread T3 here:
    #0 0x10bcc5003 in wrap_malloc
(libclang_rt.asan_osx_dynamic.dylib:x86_64+0x55003)
    #1 0x7fff59dc9969 in tlv_allocate_and_initialize_for_key
(libdyld.dylib:x86_64+0x3969)
    #2 0x7fff59dca0eb in tlv_get_addr (libdyld.dylib:x86_64+0x40eb)
    #3 0x10b3558d6 in rcu_register_thread rcu.c:301
    #4 0x10b131cb7 in iothread_run iothread.c:42
    #5 0x10b2b8eff in qemu_thread_start qemu-thread-posix.c:504
    #6 0x7fff5a0df660 in _pthread_body (libsystem_pthread.dylib:x86_64+0x3660)
    #7 0x7fff5a0df50c in _pthread_start (libsystem_pthread.dylib:x86_64+0x350c)
    #8 0x7fff5a0debf8 in thread_start (libsystem_pthread.dylib:x86_64+0x2bf8)

Thread T3 created by T0 here:
    #0 0x10bcbd00d in wrap_pthread_create
(libclang_rt.asan_osx_dynamic.dylib:x86_64+0x4d00d)
    #1 0x10b2b8bb5 in qemu_thread_create qemu-thread-posix.c:534
    #2 0x10b131720 in iothread_new iothread.c:75
    #3 0x10ac04edc in test_iothread_common test-bdrv-drain.c:668
    #4 0x10abff44e in test_iothread_drain_all test-bdrv-drain.c:768
    #5 0x10ba45b2b in g_test_run_suite_internal
(libglib-2.0.0.dylib:x86_64+0x4fb2b)
    #6 0x10ba45cec in g_test_run_suite_internal
(libglib-2.0.0.dylib:x86_64+0x4fcec)
    #7 0x10ba45cec in g_test_run_suite_internal
(libglib-2.0.0.dylib:x86_64+0x4fcec)
    #8 0x10ba450fb in g_test_run_suite (libglib-2.0.0.dylib:x86_64+0x4f0fb)
    #9 0x10ba4504e in g_test_run (libglib-2.0.0.dylib:x86_64+0x4f04e)
    #10 0x10abf4515 in main test-bdrv-drain.c:1606
    #11 0x7fff59dc7014 in start (libdyld.dylib:x86_64+0x1014)

SUMMARY: AddressSanitizer: heap-use-after-free notify.c:39 in
notifier_list_notify
Shadow bytes around the buggy address:
  0x1c1a00001fb0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00001fc0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00001fd0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00001fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00001ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=>0x1c1a00002000: fa fa fa fa fa fa fd fd fd fd fd fd[fd]fd fd fd
  0x1c1a00002010: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
  0x1c1a00002020: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00002030: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00002040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c1a00002050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==60415==ABORTING
Illegal instruction: 4

Looking at the backtraces I'm wondering if this is the result of
an implicit reliance on the order in which per-thread destructors
are called (which is left unspecified by POSIX) -- the destructor
function qemu_thread_atexit_run() is called after some other
destructor, but accesses its memory.

Specifically, the memory it's trying to read looks like
the __thread local variable pollfds_cleanup_notifier in
util/aio-posix.c. So I think what is happening is:
 * util/aio-posix.c calls qemu_thread_atexit_add(), passing
   it a pointer to a thread-local variable pollfds_cleanup_notifier
 * qemu_thread_atexit_add() works by arranging to run the
   notifiers when its 'exit_key' variable's destructor is called
 * the destructor for pollfds_cleanup_notifier runs before that
   for exit_key, and so the qemu_thread_atexit_run() function
   ends up touching freed memory

I'm pretty confident this analysis of the problem is correct:
unfortunately I have no idea what the right way to fix it is...

thanks
-- PMM
