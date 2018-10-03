Received: from eggs.gnu.org ([2001:4830:134:3::10]:57108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7jMQ-0003sB-H1
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7jMP-0007b9-Be
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:46:50 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:45108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7jMP-0007aq-5Y
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:46:49 -0400
Received: by mail-ot1-x32c.google.com with SMTP id u22so5985033ota.12
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 08:46:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4JYnEP9P01zSCX+4i-aqJpCfEDjN1GEkO6wNDp7D7PQ@mail.gmail.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
	<CAFEAcA_4JYnEP9P01zSCX+4i-aqJpCfEDjN1GEkO6wNDp7D7PQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Oct 2018 16:46:27 +0100
Message-ID: <CAFEAcA_okvcFP1nM6FZvTTFAoDYG6OavVK83cQyCT8nCQggf-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/23] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2 October 2018 at 09:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> I still got a hang on OSX on test-bdrv-drain, but I've applied
> this anyway, since hopefully it fixes the other intermittent
> failure and may reduce the likelihood with the test-bdrv-drain.

OSX seems to fail test-bdrv-drain fairly frequently. Here's
a back trace from a debug build. When run under the debugger
it seems to stop with a NULL pointer failure in notifier_list_notify();
when not run under the debugger it seems to hang eating CPU...

/bdrv-drain/iothread/drain_subtree: Process 77283 stopped
* thread #12, stop reason = EXC_BAD_ACCESS (code=1, address=0x0)
    frame #0: 0x0000000000000000
error: memory read failed for 0x0
Target 1: (test-bdrv-drain) stopped.
(lldb) bt
* thread #12, stop reason = EXC_BAD_ACCESS (code=1, address=0x0)
  * frame #0: 0x0000000000000000
    frame #1: 0x000000010016524f
test-bdrv-drain`notifier_list_notify(list=0x0000700008501e50,
data=0x0000000000000000) at notify.c:40
    frame #2: 0x0000000100150c92
test-bdrv-drain`qemu_thread_atexit_run(arg=0x0000000100b24f88) at
qemu-thread-posix.c:473
    frame #3: 0x00007fff5a0e1163
libsystem_pthread.dylib`_pthread_tsd_cleanup + 463
    frame #4: 0x00007fff5a0e0ee9 libsystem_pthread.dylib`_pthread_exit + 79
    frame #5: 0x00007fff5a0df66c libsystem_pthread.dylib`_pthread_body + 351
    frame #6: 0x00007fff5a0df50d libsystem_pthread.dylib`_pthread_start + 377
    frame #7: 0x00007fff5a0debf9 libsystem_pthread.dylib`thread_start + 13
(lldb) info thread
error: 'info' is not a valid command.
error: Unrecognized command 'info'.
(lldb) thread backtrace all
  thread #1, queue = 'com.apple.main-thread'
    frame #0: 0x00007fff59f17d82 libsystem_kernel.dylib`__semwait_signal + 10
    frame #1: 0x00007fff5a0e3824 libsystem_pthread.dylib`_pthread_join + 626
    frame #2: 0x0000000100150f2a
test-bdrv-drain`qemu_thread_join(thread=0x0000000103001058) at
qemu-thread-posix.c:565
    frame #3: 0x00000001000f6d70
test-bdrv-drain`iothread_join(iothread=0x0000000103001050) at
iothread.c:62
    frame #4: 0x000000010000a9a0
test-bdrv-drain`test_iothread_common(drain_type=BDRV_SUBTREE_DRAIN,
drain_thread=1) at test-bdrv-drain.c:762
    frame #5: 0x000000010000789f
test-bdrv-drain`test_iothread_drain_subtree at test-bdrv-drain.c:781
    frame #6: 0x00000001003aea47
libglib-2.0.0.dylib`g_test_run_suite_internal + 697
    frame #7: 0x00000001003aec0a
libglib-2.0.0.dylib`g_test_run_suite_internal + 1148
    frame #8: 0x00000001003aec0a
libglib-2.0.0.dylib`g_test_run_suite_internal + 1148
    frame #9: 0x00000001003ae020 libglib-2.0.0.dylib`g_test_run_suite + 121
    frame #10: 0x00000001003adf73 libglib-2.0.0.dylib`g_test_run + 17
    frame #11: 0x0000000100001dd0 test-bdrv-drain`main(argc=1,
argv=0x00007ffeefbffa70) at test-bdrv-drain.c:1606
    frame #12: 0x00007fff59dc7015 libdyld.dylib`start + 1
  thread #2
    frame #0: 0x00007fff59f17a16 libsystem_kernel.dylib`__psynch_cvwait + 10
    frame #1: 0x00007fff5a0e0589
libsystem_pthread.dylib`_pthread_cond_wait + 732
    frame #2: 0x0000000100150b5e
test-bdrv-drain`qemu_futex_wait(ev=0x00000001001bbad8, val=4294967295)
at qemu-thread-posix.c:347
    frame #3: 0x0000000100150acd
test-bdrv-drain`qemu_event_wait(ev=0x00000001001bbad8) at
qemu-thread-posix.c:442
    frame #4: 0x000000010016ca82
test-bdrv-drain`call_rcu_thread(opaque=0x0000000000000000) at
rcu.c:261
    frame #5: 0x0000000100150e76
test-bdrv-drain`qemu_thread_start(args=0x0000000100b1dfb0) at
qemu-thread-posix.c:504
    frame #6: 0x00007fff5a0df661 libsystem_pthread.dylib`_pthread_body + 340
    frame #7: 0x00007fff5a0df50d libsystem_pthread.dylib`_pthread_start + 377
    frame #8: 0x00007fff5a0debf9 libsystem_pthread.dylib`thread_start + 13
  thread #3
    frame #0: 0x00007fff59f1803a libsystem_kernel.dylib`__sigwait + 10
    frame #1: 0x00007fff5a0e1ad9 libsystem_pthread.dylib`sigwait + 61
    frame #2: 0x000000010014d781
test-bdrv-drain`sigwait_compat(opaque=0x0000000100b027d0) at
compatfd.c:36
    frame #3: 0x0000000100150e76
test-bdrv-drain`qemu_thread_start(args=0x0000000100b1e560) at
qemu-thread-posix.c:504
    frame #4: 0x00007fff5a0df661 libsystem_pthread.dylib`_pthread_body + 340
    frame #5: 0x00007fff5a0df50d libsystem_pthread.dylib`_pthread_start + 377
    frame #6: 0x00007fff5a0debf9 libsystem_pthread.dylib`thread_start + 13
* thread #12, stop reason = EXC_BAD_ACCESS (code=1, address=0x0)
  * frame #0: 0x0000000000000000
    frame #1: 0x000000010016524f
test-bdrv-drain`notifier_list_notify(list=0x0000700008501e50,
data=0x0000000000000000) at notify.c:40
    frame #2: 0x0000000100150c92
test-bdrv-drain`qemu_thread_atexit_run(arg=0x0000000100b24f88) at
qemu-thread-posix.c:473
    frame #3: 0x00007fff5a0e1163
libsystem_pthread.dylib`_pthread_tsd_cleanup + 463
    frame #4: 0x00007fff5a0e0ee9 libsystem_pthread.dylib`_pthread_exit + 79
    frame #5: 0x00007fff5a0df66c libsystem_pthread.dylib`_pthread_body + 351
    frame #6: 0x00007fff5a0df50d libsystem_pthread.dylib`_pthread_start + 377
    frame #7: 0x00007fff5a0debf9 libsystem_pthread.dylib`thread_start + 13
  thread #13
    frame #0: 0x00007fff59f17cf2 libsystem_kernel.dylib`__select + 10
    frame #1: 0x000000010039bb60 libglib-2.0.0.dylib`g_poll + 430
    frame #2: 0x0000000100149d7b
test-bdrv-drain`qemu_poll_ns(fds=0x0000000100b25570, nfds=1,
timeout=-1) at qemu-timer.c:337
    frame #3: 0x000000010014c609
test-bdrv-drain`aio_poll(ctx=0x0000000100b26330, blocking=true) at
aio-posix.c:645
    frame #4: 0x00000001000f700f
test-bdrv-drain`iothread_run(opaque=0x0000000100a03620) at
iothread.c:51
    frame #5: 0x0000000100150e76
test-bdrv-drain`qemu_thread_start(args=0x0000000100a05240) at
qemu-thread-posix.c:504
    frame #6: 0x00007fff5a0df661 libsystem_pthread.dylib`_pthread_body + 340
    frame #7: 0x00007fff5a0df50d libsystem_pthread.dylib`_pthread_start + 377
    frame #8: 0x00007fff5a0debf9 libsystem_pthread.dylib`thread_start + 13


As far as I can tell it always fails with
/bdrv-drain/iothread/drain_subtree, but this test
doesn't fail if we just run it alone, so something
earlier in the test is setting it up to go wrong.

I don't understand entirely what's going on with the
union in qemu_thread_atexit_run() (this seems to be
Paolo's code from a few years back), but the pointer
passed to qemu_thread_atexit_run() is a pointer to
zeroed memory:

(lldb) memory read -c 32 arg
0x100a25558: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0x100a25568: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

which when interpreted as a list_head means that
the iteration through the list gets a node with
NULLs in all its fields, and we try to call NULL.

thanks
-- PMM
