Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvz-0004hf-8U
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvy-0000LU-FY
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:15 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvkvy-0000L8-99
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:14 -0400
Received: by mail-wr0-x232.google.com with SMTP id w43so14050803wrb.0
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 06:25:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  5 Apr 2017 14:25:02 +0100
Message-Id: <20170405132503.32125-12-alex.bennee@linaro.org>
In-Reply-To: <20170405132503.32125-1-alex.bennee@linaro.org>
References: <20170405132503.32125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/12] cpus: call cpu_update_icount on read
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
 cpus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index ff75af449a..63de033cc8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -246,19 +246,17 @@ void cpu_update_icount(CPUState *cpu)
 
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
+    return atomic_read(&timers_state.qemu_icount);
 }
 
 /* Return the virtual CPU time, based on the instruction counter.  */
-- 
2.11.0
