Received: from eggs.gnu.org ([209.51.188.92]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hAuC0-0003QX-4u
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hAuBz-0005ua-9g
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hAuBz-0005uF-3w
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id z9so4534228pgu.10
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 03:29:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  1 Apr 2019 17:29:08 +0700
Message-Id: <20190401102911.8685-4-richard.henderson@linaro.org>
In-Reply-To: <20190401102911.8685-1-richard.henderson@linaro.org>
References: <20190401102911.8685-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.1 3/6] target/s390x: Use ilen from unwind
 in tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3f76a8abfd..838c32fc96 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -44,7 +44,20 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
 {
     int ret = s390_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret != 0)) {
-        cpu_loop_exit_restore(cs, retaddr);
+        cpu_restore_state(cs, retaddr, true);
+
+        /*
+         * Note that handle_mmu_fault sets ilen to either 2 (for code)
+         * or AUTO (for data).  We can resolve AUTO now, as if it was
+         * set to UNWIND -- that will have been done via assignment
+         * in cpu_restore_state.  Otherwise re-examine access_type.
+         */
+        if (access_type == MMU_INST_FETCH) {
+            CPUS390XState *env = cs->env_ptr;
+            env->int_pgm_ilen = 2;
+        }
+
+        cpu_loop_exit(cs);
     }
 }
 
-- 
2.17.1
