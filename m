Received: from eggs.gnu.org ([2001:4830:134:3::10]:37985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiT-00025Z-FY
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiP-0007jN-60
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:21 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:36 -0800
Message-Id: <20170209045154.16868-5-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 04/22] target/openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com, qemu-trivial@nongnu.org, openrisc@lists.librecores.org

From: Stafford Horne <shorne@gmail.com>

I am working on testing instruction emulation patches for the linux
kernel. During testing I found these 2 issues:

 - sets DSX (delay slot exception) but never clears it
 - EEAR for illegal insns should point to the bad exception (as per
   openrisc spec) but its not

This patch fixes these two issues by clearing the DSX flag when not in a
delay slot and by setting EEAR to exception PC when handling illegal
instruction exceptions.

After this patch the openrisc kernel with latest patches boots great on
qemu and instruction emulation works.

Cc: qemu-trivial@nongnu.org
Cc: openrisc@lists.librecores.org
Signed-off-by: Stafford Horne <shorne@gmail.com>
Message-Id: <20170113220028.29687-1-shorne@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/interrupt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index e43fc84..a243eb2 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -38,10 +38,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         env->flags &= ~D_FLAG;
         env->sr |= SR_DSX;
         env->epcr -= 4;
+    } else {
+        env->sr &= ~SR_DSX;
     }
     if (cs->exception_index == EXCP_SYSCALL) {
         env->epcr += 4;
     }
+    /* When we have an illegal instruction the error effective address
+       shall be set to the illegal instruction address.  */
+    if (cs->exception_index == EXCP_ILLEGAL) {
+        env->eear = env->pc;
+    }
 
     /* For machine-state changed between user-mode and supervisor mode,
        we need flush TLB when we enter&exit EXCP.  */
-- 
2.9.3
