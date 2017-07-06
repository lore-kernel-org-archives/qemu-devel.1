Received: from eggs.gnu.org ([2001:4830:134:3::10]:59715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSub0-0007X1-UF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSub0-0002QD-1j
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:38 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSuaz-0002Q9-UJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:37 -0400
Received: by mail-qk0-x242.google.com with SMTP id 16so647437qkg.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:23:55 -1000
Message-Id: <20170706002401.10507-6-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
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
Cc: aurelien@aurel32.net, bruno@clisp.org

We translate gUSA regions atomically in a parallel context.
But in a serial context a gUSA region may be interrupted.
In that case, restart the region as the kernel would.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/signal.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3d18d1b..1e716a9 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3471,6 +3471,23 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
     return (sp - frame_size) & -8ul;
 }
 
+/* Notice when we're in the middle of a gUSA region and reset.
+   Note that this will only occur for !parallel_cpus, as we will
+   translate such sequences differently in a parallel context.  */
+static void unwind_gusa(CPUSH4State *regs)
+{
+    /* If the stack pointer is sufficiently negative... */
+    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u) {
+        /* Reset the PC to before the gUSA region, as computed from
+           R0 = region end, SP = -(region size), plus one more insn
+           that actually sets SP to the region size.  */
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
@@ -3534,6 +3551,8 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     int i;
 
+    unwind_gusa(regs);
+
     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
     trace_user_setup_frame(regs, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
@@ -3583,6 +3602,8 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     int i;
 
+    unwind_gusa(regs);
+
     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
     trace_user_setup_rt_frame(regs, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-- 
2.9.4
