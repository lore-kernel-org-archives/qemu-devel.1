Received: from eggs.gnu.org ([2001:4830:134:3::10]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy5-0003Up-1a
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy0-00025n-V4
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:17 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:03 +0200
Message-Id: <1508343141-31835-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/29] nios2: define tcg_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Marek Vasut <marex@denx.de>

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
index 6b09618..54fbe89 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -948,6 +948,7 @@ void nios2_tcg_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
+    tcg_ctx.tcg_env = cpu_env;
 
     for (i = 0; i < NUM_CORE_REGS; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
-- 
1.8.3.1
