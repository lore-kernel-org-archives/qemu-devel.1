Received: from eggs.gnu.org ([209.51.188.92]:52974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xi.wang@gmail.com>) id 1gnX8R-0001vk-G2
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 18:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xi.wang@gmail.com>) id 1gnWzD-0007xz-I3
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 18:03:41 -0500
From: Xi Wang <xi.wang@gmail.com>
Date: Sat, 26 Jan 2019 15:02:56 -0800
Message-Id: <20190126230256.10983-1-xi.wang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/riscv: fix counter-enable checks in
 ctr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Xi Wang <xi.wang@gmail.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Access to a counter in U-mode is permitted only if the corresponding
bit is set in both mcounteren and scounteren.  The current code
ignores mcounteren and checks scounteren only for U-mode access.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 target/riscv/csr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5e7e7d16b8..133f2ff7e2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -56,9 +56,15 @@ static int fs(CPURISCVState *env, int csrno)
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
-    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
-                          env->priv == PRV_S ? env->mcounteren : -1U;
-    if (!(ctr_en & (1 << (csrno & 31)))) {
+    uint32_t ctr_en = ~0u;
+
+    if (env->priv < PRV_M) {
+        ctr_en &= env->mcounteren;
+    }
+    if (env->priv < PRV_S) {
+        ctr_en &= env->scounteren;
+    }
+    if (!(ctr_en & (1u << (csrno & 31)))) {
         return -1;
     }
 #endif
-- 
2.19.1
