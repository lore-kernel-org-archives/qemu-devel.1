Received: from eggs.gnu.org ([2001:4830:134:3::10]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTt-0000Ob-MS
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTs-0001Kh-BZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:17 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTs-0001K2-4z
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:16 -0400
Received: by mail-pl0-x244.google.com with SMTP id c19-v6so11868988pls.6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:16 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:11 +1200
Message-Id: <1527034517-7851-25-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 24/30] RISC-V: Fix PLIC pending bitfield
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>

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
---
 hw/riscv/sifive_plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 28e28d932f7c..b81d29faff99 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -215,7 +215,7 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
     } else if (addr >= plic->pending_base && /* 1 bit per source */
                addr < plic->pending_base + (plic->num_sources >> 3))
     {
-        uint32_t word = (addr - plic->priority_base) >> 2;
+        uint32_t word = (addr - plic->pending_base) >> 2;
         if (RISCV_DEBUG_PLIC) {
             qemu_log("plic: read pending: word=%d value=%d\n",
                 word, plic->pending[word]);
-- 
2.7.0
