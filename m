Received: from eggs.gnu.org ([2001:4830:134:3::10]:51721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvs1-0005WS-CF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvrx-0004B8-Q1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:49 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvrx-0004Ae-LH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:45 -0400
Received: by mail-pg0-x242.google.com with SMTP id g20-v6so4480729pgv.1
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:48:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 10:48:39 -0700
Message-Id: <20180502174842.16253-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/5] tcg/arm: Fix memory barrier encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Henry Wertz <hwertz10@gmail.com>, qemu-stable@nongnu.org

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
---
 tcg/arm/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index dc83f3e5be..56a32a470f 100644
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
2.14.3
