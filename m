Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTS-0008UK-In
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTR-00011h-Lh
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:50 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:43412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTR-00010k-F8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:49 -0400
Received: by mail-pg0-x235.google.com with SMTP id p8-v6so8565536pgq.10
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:49 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:04 +1200
Message-Id: <1527034517-7851-18-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 17/30] RISC-V: Replace __builtin_popcount
 with ctpop8 in PLIC
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

The mode variable only uses the lower 4-bits (M,H,S,U) so
replace the GCC specific __builtin_popcount with ctpop8.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index b267ff88902d..dc6f4924e282 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -383,7 +383,7 @@ static void parse_hart_config(SiFivePLICState *plic)
     p = plic->hart_config;
     while ((c = *p++)) {
         if (c == ',') {
-            addrid += __builtin_popcount(modes);
+            addrid += ctpop8(modes);
             modes = 0;
             hartid++;
         } else {
@@ -397,7 +397,7 @@ static void parse_hart_config(SiFivePLICState *plic)
         }
     }
     if (modes) {
-        addrid += __builtin_popcount(modes);
+        addrid += ctpop8(modes);
     }
     hartid++;
 
-- 
2.7.0
