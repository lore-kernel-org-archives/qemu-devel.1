Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPo-0005mw-1i
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00041U-Ie
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Uo-2a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:31 +0200
Message-Id: <20170718215050.3812-13-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 12/31] linux-user/sh4: Notice gUSA regions
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
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

We translate gUSA regions atomically in a parallel context.
But in a serial context a gUSA region may be interrupted.
In that case, restart the region as the kernel would.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-9-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 linux-user/signal.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3d18d1b3ee..c8b0733a7c 100644
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
@@ -3583,6 +3609,8 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     int i;
 
+    unwind_gusa(regs);
+
     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
     trace_user_setup_rt_frame(regs, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-- 
2.11.0
