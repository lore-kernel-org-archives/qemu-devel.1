Received: from eggs.gnu.org ([2001:4830:134:3::10]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j4-0002eI-Gz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j3-0000Ot-La
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:30 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:30 -0500
Message-Id: <20180619014319.28272-65-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 064/113] tcg/arm: Fix memory barrier encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Henry Wertz <hwertz10@gmail.com>, Richard Henderson <richard.henderson@linaro.org>

From: Henry Wertz <hwertz10@gmail.com>

I found with qemu 2.11.x or newer that I would get an illegal instruction
error running some Intel binaries on my ARM chromebook.  On investigation,
I found it was quitting on memory barriers.

qemu instruction:
mb $0x31
was translating as:
0x604050cc:  5bf07ff5  blpl     #0x600250a8

After patch it gives:
0x604050cc:  f57ff05b  dmb      ish

In short, I found INSN_DMB_ISH (memory barrier for ARMv7) appeared to be
correct based on online docs, but due to some endian-related shenanigans it
had to be byte-swapped to suit qemu; it appears INSN_DMB_MCR (memory
barrier for ARMv6) also should be byte swapped  (and this patch does so).
I have not checked for correctness of aarch64's barrier instruction.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Henry Wertz <hwertz10@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3f814b803797c007abfe5c4041de754e01723031)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/arm/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 98a12535a5..ccbd324262 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -159,8 +159,8 @@ typedef enum {
     INSN_STRD_IMM  = 0x004000f0,
     INSN_STRD_REG  = 0x000000f0,
 
-    INSN_DMB_ISH   = 0x5bf07ff5,
-    INSN_DMB_MCR   = 0xba0f07ee,
+    INSN_DMB_ISH   = 0xf57ff05b,
+    INSN_DMB_MCR   = 0xee070fba,
 
     /* Architected nop introduced in v6k.  */
     /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
-- 
2.11.0
