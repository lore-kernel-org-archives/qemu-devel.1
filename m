Received: from eggs.gnu.org ([209.51.188.92]:42481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1hGqZX-00066y-On
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1hGqZW-0004zx-EB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:50:19 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1hGqZW-0004zI-1Y
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:50:18 -0400
Received: by mail-ot1-x333.google.com with SMTP id j10so21832240otq.0
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:50:16 -0700 (PDT)
MIME-Version: 1.0
From: Frank Yang <lfy@google.com>
Date: Wed, 17 Apr 2019 12:50:04 -0700
Message-ID: <CAEkmjvU2chrbUnbV9GHidwrVb5roP+XCu0CmygaQnaFQAw8ALQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] tsan: many race conditions involving mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

What's a quick fix for stuff like this?

WARNING: ThreadSanitizer: data race (pid=168036)
  Write of size 8 at 0x7b900017a100 by thread T1 (mutexes: write M2141):
    #0 free
/toolchain/llvm/projects/compiler-rt/lib/tsan/rtl/tsan_interceptors.cc:715:3
(qemu-system-x86_64+0x484028)
    #1 phys_sections_free
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:1455:5
(qemu-system-x86_64+0x523608)
    #2 address_space_dispatch_free
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:3236
(qemu-system-x86_64+0x523608)
    #3 flatview_destroy
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory.c:290:9
(qemu-system-x86_64+0x5bfcd1)
    #4 call_rcu_thread
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/rcu.c:284:13
(qemu-system-x86_64+0xb23274)
    #5 qemu_thread_trampoline
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/qemu-thread-posix.c:551:17
(qemu-system-x86_64+0xb033c6)

  Previous read of size 8 at 0x7b900017a100 by thread T14:
    #0 address_space_lookup_region
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:431:37
(qemu-system-x86_64+0x51b9b8)
    #1 address_space_translate_internal
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:447
(qemu-system-x86_64+0x51b9b8)
    #2 flatview_do_translate
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:616:15
(qemu-system-x86_64+0x51b318)
    #3 flatview_translate
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:680:15
(qemu-system-x86_64+0x52bf20)
    #4 address_space_translate
/usr/local/google/home/lfy/emu/external/qemu/objs/../include/exec/memory.h:1896
(qemu-system-x86_64+0x52bf20)
    #5 address_space_lduw_internal_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:264
(qemu-system-x86_64+0x52bf20)
    #6 address_space_lduw_le_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:315:12
(qemu-system-x86_64+0x52c44b)
    #7 lduw_le_phys_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:334
(qemu-system-x86_64+0x52c44b)
    #8 virtio_lduw_phys_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../include/hw/virtio/virtio-access.h:166:12
(qemu-system-x86_64+0x65c97b)
    #9 vring_avail_idx
/usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:240
(qemu-system-x86_64+0x65c97b)
    #10 virtio_queue_empty
/usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:392
(qemu-system-x86_64+0x65c97b)
    #11 virtio_queue_host_notifier_aio_poll
/usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:2427
(qemu-system-x86_64+0x65c97b)
    #12 run_poll_handlers_once
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:502:13
(qemu-system-x86_64+0xaffd63)
    #13 try_poll_mode
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:587
(qemu-system-x86_64+0xaffd63)
    #14 aio_poll
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:618
(qemu-system-x86_64+0xaffd63)
    #15 iothread_run
/usr/local/google/home/lfy/emu/external/qemu/objs/../iothread.c:64:9
(qemu-system-x86_64+0xa53344)
    #16 qemu_thread_trampoline
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/qemu-thread-posix.c:551:17
(qemu-system-x86_64+0xb033c6)
