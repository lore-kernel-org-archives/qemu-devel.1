Received: from eggs.gnu.org ([2001:4830:134:3::10]:57175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002N9-8a
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmO-0000cw-So
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:24 -0400
Message-Id: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/11] convert CPU list to RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02179.html

Changes since v1:

- Rebase on master
- Add David's Acked-by tag to the spapr patch
- Add 2 patches on QLIST_{EMPTY,REMOVE}_RCU
- Add some fixes for test-rcu-list. I wanted to be able to get no
  races with ThreadSanitizer, but it still warns about two races.
  I'm appending the report just in case, but I think tsan is getting
  confused.
- Add RCU QSIMPLEQ and RCU QTAILQ, piggy-backing their testing
  on test-rcu-list.
- Use an RCU QTAILQ instead of an RCU QLIST for the CPU list.
  - Drop the patch that added the CPUState.in_list field,
    since with the QTAILQ it's not necessary.
- Convert a caller in target/s390x that I missed in v1.

You can fetch this series from:
  https://github.com/cota/qemu/tree/rcu-cpulist-v2

Thanks,

		Emilio
---
The aforementioned TSan report:

$ make -j 12 tests/test-rcu-simpleq tests/test-rcu-list && tests/test-rcu-list 1 1
  CC      tests/test-rcu-simpleq.o
  CC      tests/test-rcu-list.o
  LINK    tests/test-rcu-list
  LINK    tests/test-rcu-simpleq
==================
WARNING: ThreadSanitizer: data race (pid=15248)
  Atomic read of size 8 at 0x7b0800005600 by thread T2:
    #0 __tsan_atomic64_load ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interface_atomic.cc:538 (libtsan.so.0+0x6080e)
    #1 rcu_q_reader /data/src/qemu/tests/test-rcu-list.c:166 (test-rcu-list+0x9294)
    #2 qemu_thread_start /data/src/qemu/util/qemu-thread-posix.c:504 (test-rcu-list+0x9af8)

  Previous write of size 8 at 0x7b0800005600 by thread T3:
    #0 malloc ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:606 (libtsan.so.0+0x2a2f3)
    #1 g_malloc <null> (libglib-2.0.so.0+0x51858)
    #2 qemu_thread_start /data/src/qemu/util/qemu-thread-posix.c:504 (test-rcu-list+0x9af8)

  As if synchronized via sleep:
    #0 nanosleep ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:366 (libtsan.so.0+0x48d20)
    #1 g_usleep <null> (libglib-2.0.so.0+0x754de)
    #2 qemu_thread_start /data/src/qemu/util/qemu-thread-posix.c:504 (test-rcu-list+0x9af8)

  Location is heap block of size 32 at 0x7b0800005600 allocated by thread T3:
    #0 malloc ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:606 (libtsan.so.0+0x2a2f3)
    #1 g_malloc <null> (libglib-2.0.so.0+0x51858)
    #2 qemu_thread_start /data/src/qemu/util/qemu-thread-posix.c:504 (test-rcu-list+0x9af8)

  Thread T2 (tid=15251, running) created by main thread at:
    #0 pthread_create ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:915 (libtsan.so.0+0x2af6b)
    #1 qemu_thread_create /data/src/qemu/util/qemu-thread-posix.c:534 (test-rcu-list+0xadc8)
    #2 create_thread /data/src/qemu/tests/test-rcu-list.c:70 (test-rcu-list+0x944f)
    #3 rcu_qtest /data/src/qemu/tests/test-rcu-list.c:278 (test-rcu-list+0x95ea)
    #4 main /data/src/qemu/tests/test-rcu-list.c:357 (test-rcu-list+0x893f)

  Thread T3 (tid=15252, running) created by main thread at:
    #0 pthread_create ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:915 (libtsan.so.0+0x2af6b)
    #1 qemu_thread_create /data/src/qemu/util/qemu-thread-posix.c:534 (test-rcu-list+0xadc8)
    #2 create_thread /data/src/qemu/tests/test-rcu-list.c:70 (test-rcu-list+0x944f)
    #3 rcu_qtest /data/src/qemu/tests/test-rcu-list.c:280 (test-rcu-list+0x9606)
    #4 main /data/src/qemu/tests/test-rcu-list.c:357 (test-rcu-list+0x893f)

SUMMARY: ThreadSanitizer: data race /data/src/qemu/tests/test-rcu-list.c:166 in rcu_q_reader
==================
==================
WARNING: ThreadSanitizer: data race (pid=15248)
  Write of size 8 at 0x7b080000e880 by thread T1:
    #0 free ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:649 (libtsan.so.0+0x2a5ba)
    #1 reclaim_list_el /data/src/qemu/tests/test-rcu-list.c:105 (test-rcu-list+0x8e66)
    #2 call_rcu_thread /data/src/qemu/util/rcu.c:284 (test-rcu-list+0xbb57)
    #3 qemu_thread_start /data/src/qemu/util/qemu-thread-posix.c:504 (test-rcu-list+0x9af8)

  Previous atomic read of size 8 at 0x7b080000e880 by thread T2:
    #0 __tsan_atomic64_load ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interface_atomic.cc:538 (libtsan.so.0+0x6080e)
    #1 rcu_q_reader /data/src/qemu/tests/test-rcu-list.c:166 (test-rcu-list+0x9294)
    #2 qemu_thread_start /data/src/qemu/util/qemu-thread-posix.c:504 (test-rcu-list+0x9af8)

  Thread T1 (tid=15250, running) created by main thread at:
    #0 pthread_create ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:915 (libtsan.so.0+0x2af6b)
    #1 qemu_thread_create /data/src/qemu/util/qemu-thread-posix.c:534 (test-rcu-list+0xadc8)
    #2 rcu_init_complete /data/src/qemu/util/rcu.c:327 (test-rcu-list+0xb9f2)
    #3 rcu_init /data/src/qemu/util/rcu.c:383 (test-rcu-list+0x89fc)
    #4 __libc_csu_init <null> (test-rcu-list+0x35f9c)

  Thread T2 (tid=15251, running) created by main thread at:
    #0 pthread_create ../../../../gcc-8.1.0/libsanitizer/tsan/tsan_interceptors.cc:915 (libtsan.so.0+0x2af6b)
    #1 qemu_thread_create /data/src/qemu/util/qemu-thread-posix.c:534 (test-rcu-list+0xadc8)
    #2 create_thread /data/src/qemu/tests/test-rcu-list.c:70 (test-rcu-list+0x944f)
    #3 rcu_qtest /data/src/qemu/tests/test-rcu-list.c:278 (test-rcu-list+0x95ea)
    #4 main /data/src/qemu/tests/test-rcu-list.c:357 (test-rcu-list+0x893f)

SUMMARY: ThreadSanitizer: data race /data/src/qemu/tests/test-rcu-list.c:105 in reclaim_list_el
==================
tests/test-rcu-list: 1 readers; 1 updater; nodes read: 375386, nodes removed: 78728; nodes reclaimed: 78728
ThreadSanitizer: reported 2 warnings
