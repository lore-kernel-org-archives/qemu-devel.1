Received: from eggs.gnu.org ([2001:4830:134:3::10]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e87HL-0001e0-2s
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e87HH-0007LN-0w
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:14:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e87HG-0007F9-NH
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:14:34 -0400
Date: Fri, 27 Oct 2017 19:14:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1509118355-4890-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v6] x86: use lock+addl for smp_mb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

mfence appears to be way slower than a locked instruction - let's use
lock+add unconditionally, as we always did on old 32-bit.

Results:
perf stat -r 10 -- ./virtio_ring_0_9 --sleep --host-affinity 0 --guest-affinity 0
Before:
       0.922565990 seconds time elapsed                                          ( +-  1.15% )
After:
       0.578667024 seconds time elapsed                                          ( +-  1.21% )

Just poking at SP would be the most natural, but if we then read the
value from SP, we get a false dependency which will slow us down.

This was noted in this article:
http://shipilev.net/blog/2014/on-the-fence-with-dependencies/

And is easy to reproduce by sticking a barrier in a small non-inline
function.

So let's use a negative offset - which avoids this problem since we
build with the red zone disabled.

For userspace, use an address just below the redzone.

The one difference between lock+add and mfence is that lock+addl does
not affect clflush, previous patches converted all uses of clflush to
call mb(), such that changes to smp_mb won't affect it.

Update mb/rmb/wmb on 32 bit to use the negative offset, too, for
consistency.

As a follow-up, it might be worth considering switching users
of clflush to another API (e.g. clflush_mb?) - we will
then be able to convert mb to smp_mb.

Also arguably, gcc should switch to use lock+add for __sync_synchronize.
This might be worth pursuing separately.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/include/asm/barrier.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Changes from v5:
- ringtest update
- document mb() interaction with clflush
- add micro-benchmark results


diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index bfb28ca..3c6ba1e 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -11,11 +11,11 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "mfence", \
+#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "mfence", \
 				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "lfence", \
+#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "sfence", \
+#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
 #define mb() 	asm volatile("mfence":::"memory")
@@ -30,7 +30,11 @@
 #endif
 #define dma_wmb()	barrier()
 
-#define __smp_mb()	mb()
+#ifdef CONFIG_X86_32
+#define __smp_mb()	asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
+#else
+#define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
+#endif
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 90b0133..5706e07 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -110,11 +110,15 @@ static inline void busy_wait(void)
 		barrier();
 } 
 
+#if defined(__x86_64__) || defined(__i386__)
+#define smp_mb()     asm volatile("lock; addl $0,-128(%%rsp)" ::: "memory", "cc")
+#else
 /*
  * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
  * with other __ATOMIC_SEQ_CST calls.
  */
 #define smp_mb() __sync_synchronize()
+#endif
 
 /*
  * This abuses the atomic builtins for thread fences, and
-- 
MST
