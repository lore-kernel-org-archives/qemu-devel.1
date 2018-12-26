Received: from eggs.gnu.org ([208.118.235.92]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrZ-0004YD-GG
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrX-0007zY-Dj
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:57 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrX-0007r5-4W
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:55 -0500
Received: by mail-qt1-x843.google.com with SMTP id e5so17803252qtr.12
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:36 -0800 (PST)
Date: Wed, 26 Dec 2018 09:20:03 -0800
Message-Id: <20181226172005.26990-13-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 12/14] target/riscv/pmp.c: Fix pmp_decode_napot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Anup Patel <anup@brainfault.org>

Currently, start and end address of a PMP region are not decoded
correctly by pmp_decode_napot().

Let's say we have a 128KB PMP region with base address as 0x80000000.
Now, the PMPADDRx CSR value for this region will be 0x20003fff.

The current pmp_decode_napot() implementation will decode PMPADDRx
CSR as t1=14, base=0x100000000, and range=0x1ffff whereas it should
have decoded PMPADDRx CSR as t1=14, base=0x80000000, and range=0x1fff.

This patch fixes the base value decoding in pmp_decode_napot() when
PMPADDRx CSR is not -1 (i.e. 0xffffffffffffffff).

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 03abd8fe5eb7..15a5366616bd 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -138,7 +138,7 @@ static void pmp_decode_napot(target_ulong a, target_ulong *sa, target_ulong *ea)
         return;
     } else {
         target_ulong t1 = ctz64(~a);
-        target_ulong base = (a & ~(((target_ulong)1 << t1) - 1)) << 3;
+        target_ulong base = (a & ~(((target_ulong)1 << t1) - 1)) << 2;
         target_ulong range = ((target_ulong)1 << (t1 + 3)) - 1;
         *sa = base;
         *ea = base + range;
-- 
2.18.1
