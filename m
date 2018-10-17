Received: from eggs.gnu.org ([2001:4830:134:3::10]:36432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCho5-0001JU-FF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCho2-000149-Tw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCho2-000127-Lk
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:07:54 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Oct 2018 11:07:50 +0200
Message-Id: <20181017090750.4378-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

QEMU running with options "-icount,sleep=off -rtc clock=vm" doesn't
execute emulation at maximum possible speed.
Target virtual clock may run faster or slower than realtime clock by N
times, where N value depends on various unrelated conditions (i.e. random
from the user point of view), or possibly the target hangs completely.
Bisection shows commit 281b2201e4 ("icount: remove obsolete warp call",
2016-03-15) to be the culprit, revert it.

Suggested-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpus.c b/cpus.c
index 361678e459..2872e7e37c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1224,6 +1224,10 @@ static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 {
     while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
+
+        /* Start accounting real time to the virtual clock if the CPUs
+           are idle.  */
+        qemu_clock_warp(QEMU_CLOCK_VIRTUAL);
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
 
-- 
2.17.1
