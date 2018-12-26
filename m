Received: from eggs.gnu.org ([208.118.235.92]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrN-0004EG-Fj
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrH-0007rw-M3
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:41 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrD-0007mx-P4
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:36 -0500
Received: by mail-qk1-x744.google.com with SMTP id g125so9624166qke.4
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:30 -0800 (PST)
Date: Wed, 26 Dec 2018 09:20:00 -0800
Message-Id: <20181226172005.26990-10-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 09/14] RISC-V: Fix PLIC pending bitfield reads
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

The address calculation for the pending bitfield had
a copy paste bug. This bug went unnoticed because the Linux
PLIC driver does not read the pending bitfield, rather it
reads pending interrupt numbers from the claim register
and writes acknowledgements back to the claim register.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Reported-by: Vincent Siles <vincent.siles@ens-lyon.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 9cf9a1f98644..d12ec3fc9a54 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -214,7 +214,7 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
     } else if (addr >= plic->pending_base && /* 1 bit per source */
                addr < plic->pending_base + (plic->num_sources >> 3))
     {
-        uint32_t word = (addr - plic->priority_base) >> 2;
+        uint32_t word = (addr - plic->pending_base) >> 2;
         if (RISCV_DEBUG_PLIC) {
             qemu_log("plic: read pending: word=%d value=%d\n",
                 word, plic->pending[word]);
-- 
2.18.1
