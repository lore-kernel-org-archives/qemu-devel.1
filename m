Received: from eggs.gnu.org ([2001:4830:134:3::10]:34851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUwQT-0003nk-Ui
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUwQQ-0008Fk-TE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:50:42 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 18 Jun 2018 11:50:24 -0400
Message-Id: <20180618155024.1942-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, aurelien@aurel32.net, qemu-ppc@nongnu.org, agraf@suse.de
Cc: John Arbuckle <programmingkidx@gmail.com>

Fix the helper_fpscr_clrbit() function so it correctly
sets the FEX and VX bits.

Determining the value for the Floating Point Status and Control
Register's (FPSCR) FEX bit is suppose to be done like this:

FEX = (VX & VE) | (OX & OE) | (UX & UE) | (ZX & ZE) | (XX & XE))

It is described as "the logical OR of all the floating-point exception bits
masked by their respective enable bits". It was not implemented correctly. The value of FEX would stay on even when all other bits were set to off.

The VX bit is described as "the logical OR of all of the invalid operation exceptions". This bit was also not implemented correctly. It too would stay
on when all the other bits were set to off.

My main source of information is an IBM document called: 

PowerPC Microprocessor Family:
The Programming Environments for 32-Bit Microprocessors

Page 62 is where the FPSCR information is located.

This is an older copy than the one I use but it is still very useful:
https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html

I use a G3 and G5 iMac to compare bit values with QEMU. This patch fixed all the problems I was having with these bits.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
- Removed the FPSCR_VX case because it is not a bit that can be set directly.
- Replaced previous code with predefined macros fpscr_ix and fpscr_eex. 

 target/ppc/fpu_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d31a933cbb..7714bfe0f9 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -325,6 +325,34 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
         case FPSCR_RN:
             fpscr_set_rounding_mode(env);
             break;
+        case FPSCR_VXSNAN:
+        case FPSCR_VXISI:
+        case FPSCR_VXIDI:
+        case FPSCR_VXZDZ:
+        case FPSCR_VXIMZ:
+        case FPSCR_VXVC:
+        case FPSCR_VXSOFT:
+        case FPSCR_VXSQRT:
+        case FPSCR_VXCVI:
+            if (!fpscr_ix) {
+                /* Set VX bit to zero */
+                env->fpscr &= ~(1 << FPSCR_VX);
+            }
+            break;
+        case FPSCR_OX:
+        case FPSCR_UX:
+        case FPSCR_ZX:
+        case FPSCR_XX:
+        case FPSCR_VE:
+        case FPSCR_OE:
+        case FPSCR_UE:
+        case FPSCR_ZE:
+        case FPSCR_XE:
+            if (!fpscr_eex) {
+                /* Set the FEX bit */
+                env->fpscr &= ~(1 << FPSCR_FEX);
+            }
+            break;
         default:
             break;
         }
-- 
2.14.3 (Apple Git-98)
