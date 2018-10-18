Received: from eggs.gnu.org ([2001:4830:134:3::10]:54874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dayeol@berkeley.edu>) id 1gD22u-0005Yc-92
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dayeol@berkeley.edu>) id 1gD22q-0003eM-Sj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:44:36 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:46676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1gD22q-0003Yf-Jg
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:44:32 -0400
Received: by mail-qk1-x742.google.com with SMTP id q12-v6so18093914qkl.13
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 23:44:31 -0700 (PDT)
From: Dayeol Lee <dayeol@berkeley.edu>
Date: Thu, 18 Oct 2018 06:44:26 +0000
Message-Id: <1539845066-31635-1-git-send-email-dayeol@berkeley.edu>
Subject: [Qemu-devel] [PATCH] [PATCH] target/riscv/pmp.c: pmpcfg_csr_read
 return type demotion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dayeol Lee <dayeol@berkeley.edu>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

There is a data type demotion bug in target/riscv/pmp.c
When the target_ulong is 8 bytes, pmpcfg_csr_read returns only lower 4
bytes.
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index c828950..4b6c20e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -337,7 +337,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
 
     for (i = 0; i < sizeof(target_ulong); i++) {
         val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
-        cfg_val |= (val << (i * 8));
+        cfg_val |= ((target_ulong)val << ((target_ulong)i * 8));
     }
 
     PMP_DEBUG("hart " TARGET_FMT_ld ": reg%d, val: 0x" TARGET_FMT_lx,
-- 
2.7.4
