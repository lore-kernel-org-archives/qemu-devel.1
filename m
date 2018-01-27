Received: from eggs.gnu.org ([2001:4830:134:3::10]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efQrb-0001KI-Az
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efQrX-0001mg-0J
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:49:47 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1efQrW-0001lx-OY
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:49:42 -0500
Received: by mail-lf0-x243.google.com with SMTP id 63so4033937lfv.4
	for <qemu-devel@nongnu.org>; Sat, 27 Jan 2018 05:49:42 -0800 (PST)
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sat, 27 Jan 2018 16:49:08 +0300
Message-Id: <20180127134908.24095-2-anatoly.trosinenko@gmail.com>
In-Reply-To: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

Use ldl_he_p / ldq_he_p functions instead of a plain memory access
through pointer.

Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
---
 tcg/tci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1903..410817cf6a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -159,7 +159,13 @@ static uint64_t tci_uint64(uint32_t high, uint32_t low)
 /* Read constant (native size) from bytecode. */
 static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
 {
-    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
+#if TCG_TARGET_REG_BITS == 32
+    tcg_target_ulong value = ldl_he_p(*tb_ptr);
+#elif TCG_TARGET_REG_BITS == 64
+    tcg_target_ulong value = ldq_he_p(*tb_ptr);
+#else
+#error unsupported
+#endif
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -167,7 +173,7 @@ static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
 /* Read unsigned constant (32 bit) from bytecode. */
 static uint32_t tci_read_i32(uint8_t **tb_ptr)
 {
-    uint32_t value = *(uint32_t *)(*tb_ptr);
+    uint32_t value = ldl_he_p(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -175,7 +181,7 @@ static uint32_t tci_read_i32(uint8_t **tb_ptr)
 /* Read signed constant (32 bit) from bytecode. */
 static int32_t tci_read_s32(uint8_t **tb_ptr)
 {
-    int32_t value = *(int32_t *)(*tb_ptr);
+    int32_t value = ldl_he_p(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -184,7 +190,7 @@ static int32_t tci_read_s32(uint8_t **tb_ptr)
 /* Read constant (64 bit) from bytecode. */
 static uint64_t tci_read_i64(uint8_t **tb_ptr)
 {
-    uint64_t value = *(uint64_t *)(*tb_ptr);
+    uint64_t value = ldq_he_p(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -1094,7 +1100,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             /* QEMU specific operations. */
 
         case INDEX_op_exit_tb:
-            ret = *(uint64_t *)tb_ptr;
+            ret = ldq_he_p(tb_ptr);
             goto exit;
             break;
         case INDEX_op_goto_tb:
-- 
2.14.1
