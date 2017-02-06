Received: from eggs.gnu.org ([2001:4830:134:3::10]:37364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1calGD-0005rv-0L
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1calGB-00005i-Qk
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:31:20 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1calGB-000054-KD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:31:19 -0500
Received: by mail-wm0-x22c.google.com with SMTP id b65so125315764wmf.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 07:31:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  6 Feb 2017 15:31:04 +0000
Message-Id: <20170206153113.27729-15-alex.bennee@linaro.org>
In-Reply-To: <20170206153113.27729-1-alex.bennee@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 14/23] cputlb: tweak
 qemu_ram_addr_from_host_nofail reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This moves the helper function closer to where it is called and updates
the error message to report via error_report instead of the deprecated
fprintf.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 cputlb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index af0e65cd2c..94fa9977c5 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -246,18 +246,6 @@ void tlb_reset_dirty_range(CPUTLBEntry *tlb_entry, uintptr_t start,
     }
 }
 
-static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
-{
-    ram_addr_t ram_addr;
-
-    ram_addr = qemu_ram_addr_from_host(ptr);
-    if (ram_addr == RAM_ADDR_INVALID) {
-        fprintf(stderr, "Bad ram pointer %p\n", ptr);
-        abort();
-    }
-    return ram_addr;
-}
-
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 {
     CPUArchState *env;
@@ -469,6 +457,18 @@ static void report_bad_exec(CPUState *cpu, target_ulong addr)
     log_cpu_state_mask(LOG_GUEST_ERROR, cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
 }
 
+static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
+{
+    ram_addr_t ram_addr;
+
+    ram_addr = qemu_ram_addr_from_host(ptr);
+    if (ram_addr == RAM_ADDR_INVALID) {
+        error_report("Bad ram pointer %p", ptr);
+        abort();
+    }
+    return ram_addr;
+}
+
 /* NOTE: this function can trigger an exception */
 /* NOTE2: the returned address is not exactly the physical address: it
  * is actually a ram_addr_t (in system mode; the user mode emulation
-- 
2.11.0
