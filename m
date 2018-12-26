Received: from eggs.gnu.org ([208.118.235.92]:47943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrF-000474-UK
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrC-0007pd-Sb
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:35 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrC-0007m4-2H
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:34 -0500
Received: by mail-qk1-x743.google.com with SMTP id y16so9621714qki.7
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:28 -0800 (PST)
Date: Wed, 26 Dec 2018 09:19:59 -0800
Message-Id: <20181226172005.26990-9-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 08/14] RISC-V: Fix CLINT timecmp low 32-bit
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

A missing shift made updates to the low order bits
of timecmp erroneously copy the old low order bits
into the high order bits of the 64-bit timecmp
register. Add the missing shift and rename timecmp
local variables to timecmp_hi and timecmp_lo.

This bug didn't show up as the low order bits are
usually written first followed by the high order
bits meaning the high order bits contained an invalid
value between the timecmp_lo and timecmp_hi update.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Co-Authored-by: Johannes Haring <johannes.haring@gmx.net>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_clint.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 0d2fd52487e6..d4c159e93736 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -146,15 +146,15 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
             error_report("clint: invalid timecmp hartid: %zu", hartid);
         } else if ((addr & 0x7) == 0) {
             /* timecmp_lo */
-            uint64_t timecmp = env->timecmp;
+            uint64_t timecmp_hi = env->timecmp >> 32;
             sifive_clint_write_timecmp(RISCV_CPU(cpu),
-                timecmp << 32 | (value & 0xFFFFFFFF));
+                timecmp_hi << 32 | (value & 0xFFFFFFFF));
             return;
         } else if ((addr & 0x7) == 4) {
             /* timecmp_hi */
-            uint64_t timecmp = env->timecmp;
+            uint64_t timecmp_lo = env->timecmp;
             sifive_clint_write_timecmp(RISCV_CPU(cpu),
-                value << 32 | (timecmp & 0xFFFFFFFF));
+                value << 32 | (timecmp_lo & 0xFFFFFFFF));
         } else {
             error_report("clint: invalid timecmp write: %08x", (uint32_t)addr);
         }
-- 
2.18.1
