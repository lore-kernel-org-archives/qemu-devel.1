Received: from eggs.gnu.org ([2001:4830:134:3::10]:37121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWOrL-0001OF-DD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWOrK-00083W-Cr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gWOrK-00080R-3x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:42 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 16:56:34 +0000
Message-Id: <20181210165636.28366-2-peter.maydell@linaro.org>
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
References: <20181210165636.28366-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 1/3] target/m68k: In dump_address_map() check for
 memory access failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In dump_address_map(), use address_space_ldl() instead of ldl_phys().
This allows us to check whether the memory access failed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 917d46efcc3..374e4861886 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -411,6 +411,7 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
     int last_attr = -1, attr = -1;
     M68kCPU *cpu = m68k_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
+    MemTxResult txres;
 
     if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
         /* 8k page */
@@ -424,22 +425,29 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
         tib_mask = M68K_4K_PAGE_MASK;
     }
     for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
-        tia = ldl_phys(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4);
-        if (!M68K_UDT_VALID(tia)) {
+        tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
+                                MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
             continue;
         }
         for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
-            tib = ldl_phys(cs->as, M68K_POINTER_BASE(tia) + j * 4);
-            if (!M68K_UDT_VALID(tib)) {
+            tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
+                                    MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
                 continue;
             }
             for (k = 0; k < tic_size; k++) {
-                tic = ldl_phys(cs->as, (tib & tib_mask) + k * 4);
-                if (!M68K_PDT_VALID(tic)) {
+                tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
+                                        MEMTXATTRS_UNSPECIFIED, &txres);
+                if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
                     continue;
                 }
                 if (M68K_PDT_INDIRECT(tic)) {
-                    tic = ldl_phys(cs->as, M68K_INDIRECT_POINTER(tic));
+                    tic = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(tic),
+                                            MEMTXATTRS_UNSPECIFIED, &txres);
+                    if (txres != MEMTX_OK) {
+                        continue;
+                    }
                 }
 
                 last_logical = logical;
-- 
2.19.2
