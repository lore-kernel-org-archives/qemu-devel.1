Received: from eggs.gnu.org ([2001:4830:134:3::10]:53512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1z-0002WG-Sy
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1v-0007YB-5X
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:35 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwW1u-0007Xq-V8
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:31 -0400
Received: by mail-wr0-x234.google.com with SMTP id g19so68079292wrb.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:42:30 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  7 Apr 2017 16:42:20 +0100
Message-Id: <20170407154221.26918-12-alex.bennee@linaro.org>
In-Reply-To: <20170407154221.26918-1-alex.bennee@linaro.org>
References: <20170407154221.26918-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/12] cpus: call cpu_update_icount on read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This ensures each time the vCPU thread reads the icount we update the
master timer_state.qemu_icount field. This way as long as updates are
in BQL protected sections (which they should be) the main-loop can
never come to update the log and find time has gone backwards.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index 14c2149987..a6a85bfdba 100644
--- a/cpus.c
+++ b/cpus.c
@@ -253,19 +253,21 @@ void cpu_update_icount(CPUState *cpu)
 
 int64_t cpu_get_icount_raw(void)
 {
-    int64_t icount;
     CPUState *cpu = current_cpu;
 
-    icount = atomic_read(&timers_state.qemu_icount);
     if (cpu && cpu->running) {
         if (!cpu->can_do_io) {
             fprintf(stderr, "Bad icount read\n");
             exit(1);
         }
         /* Take into account what has run */
-        icount += cpu_get_icount_executed(cpu);
+        cpu_update_icount(cpu);
     }
-    return icount;
+#ifdef CONFIG_ATOMIC64
+    return atomic_read__nocheck(&timers_state.qemu_icount);
+#else /* FIXME: we need 64bit atomics to do this safely */
+    return timers_state.qemu_icount;
+#endif
 }
 
 /* Return the virtual CPU time, based on the instruction counter.  */
-- 
2.11.0
