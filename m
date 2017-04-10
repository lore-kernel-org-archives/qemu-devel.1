Received: from eggs.gnu.org ([2001:4830:134:3::10]:53489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqt-0002Uw-Ep
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqs-0003AF-MH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:27 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqs-00039I-Gi
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:26 -0400
Received: by mail-wm0-x231.google.com with SMTP id t189so36722602wmt.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:23 +0100
Message-Id: <20170410125524.21008-11-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/11] cpus: call cpu_update_icount on read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This ensures each time the vCPU thread reads the icount we update the
master timer_state.qemu_icount field. This way as long as updates are
in BQL protected sections (which they should be) the main-loop can
never come to update the log and find time has gone backwards.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/cpus.c b/cpus.c
index 9c8bd2c991..740b8dc3f8 100644
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
