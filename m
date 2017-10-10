Received: from eggs.gnu.org ([2001:4830:134:3::10]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1wIX-0007Bc-Vz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1wIS-0005u2-4y
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:18:21 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Oct 2017 17:18:11 +0200
Message-Id: <20171010151811.19935-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] nios2: define tcg_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, qemu-stable@nongnu.org, Marek Vasut <marex@denx.de>

This should be done by all target and, since commit 53f6672bcf
("gen-icount: use tcg_ctx.tcg_env instead of cpu_env", 2017-06-30),
is causing the NIOS2 target to hang.

This is because the test for "should I exit to the main loop"
was being done with the correct offset to the icount decrementer,
but using TCG temporary 0 (the frame pointer) rather than the
env pointer.

Cc: qemu-stable@nongnu.org
Cc: Marek Vasut <marex@denx.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/nios2/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 6b0961837d..54fbe898df 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -948,6 +948,7 @@ void nios2_tcg_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
+    tcg_ctx.tcg_env = cpu_env;
 
     for (i = 0; i < NUM_CORE_REGS; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
-- 
2.14.2
