Received: from eggs.gnu.org ([2001:4830:134:3::10]:49690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYiq-0006DL-3F
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYip-0004co-4n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:56 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYip-0004cg-0P
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:55 -0400
Received: by mail-qt0-x241.google.com with SMTP id p25so2578149qtp.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:03:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:33 -1000
Message-Id: <20170718200255.31647-9-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 08/30] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

We translate gUSA regions atomically in a parallel context.
But in a serial context a gUSA region may be interrupted.
In that case, restart the region as the kernel would.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/signal.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index ddfd75c..27867a4 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3471,6 +3471,30 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
     return (sp - frame_size) & -8ul;
 }
 
+/* Notice when we're in the middle of a gUSA region and reset.
+   Note that this will only occur for !parallel_cpus, as we will
+   translate such sequences differently in a parallel context.  */
+static void unwind_gusa(CPUSH4State *regs)
+{
+    /* If the stack pointer is sufficiently negative, and we haven't
+       completed the sequence, then reset to the entry to the region.  */
+    /* ??? The SH4 kernel checks for and address above 0xC0000000.
+       However, the page mappings in qemu linux-user aren't as restricted
+       and we wind up with the normal stack mapped above 0xF0000000.
+       That said, there is no reason why the kernel should be allowing
+       a gUSA region that spans 1GB.  Use a tighter check here, for what
+       can actually be enabled by the immediate move.  */
+    if (regs->gregs[15] >= -128u && regs->pc < regs->gregs[0]) {
+        /* Reset the PC to before the gUSA region, as computed from
+           R0 = region end, SP = -(region size), plus one more for the
+           insn that actually initializes SP to the region size.  */
+        regs->pc = regs->gregs[0] + regs->gregs[15] - 2;
+
+        /* Reset the SP to the saved version in R1.  */
+        regs->gregs[15] = regs->gregs[1];
+    }
+}
+
 static void setup_sigcontext(struct target_sigcontext *sc,
                              CPUSH4State *regs, unsigned long mask)
 {
@@ -3534,6 +3558,8 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     int i;
 
+    unwind_gusa(regs);
+
     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
     trace_user_setup_frame(regs, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
@@ -3584,6 +3610,8 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     int i;
 
+    unwind_gusa(regs);
+
     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
     trace_user_setup_rt_frame(regs, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-- 
2.9.4
