Received: from eggs.gnu.org ([2001:4830:134:3::10]:48304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTh-0008DZ-Nu
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTf-00065t-8A
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:39990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHbTe-00065R-VU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id g21-v6so6494498pfi.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 14:23:06 -0700 (PDT)
Date: Tue, 30 Oct 2018 14:22:47 -0700
Message-Id: <20181030212249.7117-2-palmer@sifive.com>
In-Reply-To: <20181030212249.7117-1-palmer@sifive.com>
References: <20181030212249.7117-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 1/3] target/riscv/pmp.c: pmpcfg_csr_read returns
 bogus value on RV64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Dayeol Lee <dayeol@berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>

From: Dayeol Lee <dayeol@berkeley.edu>

pmp_read_cfg() returns 8-bit value, which is combined together to form a single pmpcfg CSR.
The default promotion rules will result in an integer here ("i*8" is integer, which
flows through) resulting in a 32-bit signed value on most hosts.
That's bogus on RV64I, with the high bits of the CSR being wrong.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index f432f3b7594b..03abd8fe5eb7 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -325,7 +325,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
 {
     int i;
     target_ulong cfg_val = 0;
-    uint8_t val = 0;
+    target_ulong val = 0;
 
     for (i = 0; i < sizeof(target_ulong); i++) {
         val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
-- 
2.18.1
