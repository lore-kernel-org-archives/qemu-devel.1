Received: from eggs.gnu.org ([209.51.188.92]:38341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn3-0004gK-H5
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn2-00005z-9C
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:45 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotmx-0008Vx-L9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:42 -0500
Received: by mail-pf1-x444.google.com with SMTP id c73so115490pfe.13
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:37 -0800 (PST)
Date: Wed, 30 Jan 2019 09:36:01 -0800
Message-Id: <20190130173601.3268-11-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 10/10] target/riscv: fix counter-enable checks
 in ctr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Xi Wang <xi.wang@gmail.com>, Palmer Dabbelt <palmer@sifive.com>

From: Xi Wang <xi.wang@gmail.com>

Access to a counter in U-mode is permitted only if the corresponding
bit is set in both mcounteren and scounteren.  The current code
ignores mcounteren and checks scounteren only for U-mode access.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e72fcf1265d4..960d2b0aa951 100644
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
2.18.1
