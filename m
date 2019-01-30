Received: from eggs.gnu.org ([209.51.188.92]:53774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luke.r.nels@gmail.com>) id 1gox1u-0001mL-SY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 16:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luke.r.nels@gmail.com>) id 1gox1r-0004aJ-UX
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 16:04:16 -0500
From: Luke Nelson <luke.r.nels@gmail.com>
Date: Wed, 30 Jan 2019 13:03:50 -0800
Message-Id: <20190130210350.16757-1-luke.r.nels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] RISC-V: Fix pmpcfg register indexing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: lukenels@pm.me, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>

pmpcfg_csr_{read,write} do not correctly handle accesses to PMP
configurations 8 through 15 (CSR pmpcfg2) on RV64.

The current code computes the pmpcfg index using:

  (reg_index * sizeof(target_ulong))

This is incorrect on RV64.  For example, when reg_index is 2 (i.e.,
pmpcfg2), the computed configuration index will be 16-23, which
should be 8-15.

A correct way is to use (reg_index * 4) instead, which works for
both RV32 and RV64.

Cc: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 target/riscv/pmp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 15a5366616..a1bee56c86 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -311,9 +311,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
     }
 
     for (i = 0; i < sizeof(target_ulong); i++) {
-        cfg_val = (val >> 8 * i)  & 0xff;
-        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
-            cfg_val);
+        cfg_val = (val >> (i * 8)) & 0xff;
+        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
     }
 }
 
@@ -328,7 +327,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong val = 0;
 
     for (i = 0; i < sizeof(target_ulong); i++) {
-        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
+        val = pmp_read_cfg(env, (reg_index * 4) + i);
         cfg_val |= (val << (i * 8));
     }
 
-- 
2.19.1
