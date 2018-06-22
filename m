Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPv-0000ha-J5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPt-0003TG-6S
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:16 +1000
Message-Id: <20180622103528.28598-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/25] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, John Arbuckle <programmingkidx@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: John Arbuckle <programmingkidx@gmail.com>

Fix the helper_fpscr_clrbit() function so it correctly sets the FEX
and VX bits.

Determining the value for the Floating Point Status and Control
Register's (FPSCR) FEX bit is suppose to be done like this:

FEX = (VX & VE) | (OX & OE) | (UX & UE) | (ZX & ZE) | (XX & XE))

It is described as "the logical OR of all the floating-point exception
bits masked by their respective enable bits". It was not implemented
correctly. The value of FEX would stay on even when all other bits
were set to off.

The VX bit is described as "the logical OR of all of the invalid
operation exceptions". This bit was also not implemented correctly. It
too would stay on when all the other bits were set to off.

My main source of information is an IBM document called:

PowerPC Microprocessor Family:
The Programming Environments for 32-Bit Microprocessors

Page 62 is where the FPSCR information is located.

This is an older copy than the one I use but it is still very useful:
https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html

I use a G3 and G5 iMac to compare bit values with QEMU. This patch
fixed all the problems I was having with these bits.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
[dwg: Re-wrapped commit message]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
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
2.17.1
