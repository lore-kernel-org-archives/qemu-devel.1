Received: from eggs.gnu.org ([2001:4830:134:3::10]:55405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eJjmz-0004fJ-I6
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eJjmY-0003JX-4j
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:35:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 17:34:07 +0000
Message-Id: <1511890447-13601-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user/arm/nwfpe: Check coprocessor number
 for FPA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Our copy of the nwfpe code for emulating of the old FPA11 floating
point unit doesn't check the coprocessor number in the instruction
when it emulates it.  This means that we might treat some
instructions which should really UNDEF as being FPA11 instructions by
accident.

The kernel's copy of the nwfpe code doesn't make this error; I suspect
the bug was noticed and fixed as part of the process of mainlining
the nwfpe code more than a decade ago.

Add a check that the coprocessor number (which is always in bits
[11:8] of the instruction) is either 1 or 2, which is where the
FPA11 lives.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested with a chroot of arm debian lenny, which is the last one that
still used the calling convention that mandated use of the old FPA11 FPU
and thus needs nwfpe emulation.
---
 linux-user/arm/nwfpe/fpa11.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 441e3b1..f6f8163 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -137,8 +137,17 @@ unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa, CPUARMState* qregs)
   unsigned int nRc = 0;
 //  unsigned long flags;
   FPA11 *fpa11;
+  unsigned int cp;
 //  save_flags(flags); sti();
 
+  /* Check that this is really an FPA11 instruction: the coprocessor
+   * field in bits [11:8] must be 1 or 2.
+   */
+  cp = (opcode >> 8) & 0xf;
+  if (cp != 1 && cp != 2) {
+    return 0;
+  }
+
   qemufpa=qfpa;
   user_registers=qregs;
 
-- 
2.7.4
