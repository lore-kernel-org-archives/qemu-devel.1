Received: from eggs.gnu.org ([2001:4830:134:3::10]:56959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiM-0004gv-Uf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiL-0005nt-U8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:50 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZpiL-0005nk-Pv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:49 -0400
Received: by mail-qk0-x242.google.com with SMTP id k2so4148534qkf.2
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:36:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 19:36:11 -0700
Message-Id: <20170725023611.9169-5-rth@twiddle.net>
In-Reply-To: <20170725023611.9169-1-rth@twiddle.net>
References: <20170725023611.9169-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 4/4] target/s390x: Use ilen from unwind in
 tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 026189aefd..1141f1362b 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -43,7 +43,18 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 {
     int ret = s390_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret != 0)) {
-        cpu_loop_exit_restore(cs, retaddr);
+        cpu_restore_state(cs, retaddr);
+
+        /* Note that handle_mmu_fault sets ilen to either 2 (for code)
+           or AUTO (for data).  We can resolve AUTO now, as if it was
+           set to UNWIND -- that will have been done via assignment
+           in cpu_restore_state.  Otherwise re-examine access_type.  */
+        if (access_type == MMU_INST_FETCH) {
+            CPUS390XState *env = cs->env_ptr;
+            env->int_pgm_ilen = 2;
+        }
+
+        cpu_loop_exit(cs);
     }
 }
 
-- 
2.13.3
