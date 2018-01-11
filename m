Received: from eggs.gnu.org ([2001:4830:134:3::10]:52355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd48-0007aR-K6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd47-0000FF-KE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd47-0000Dl-Dx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd46-0005lR-DT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:19 +0000
Message-Id: <1515677902-23436-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 23/26] linux-user/arm/nwfpe: Check coprocessor
 number for FPA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
