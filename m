Received: from eggs.gnu.org ([209.51.188.92]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDk0H-0001cG-J3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDk0G-0005Mz-M9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:13:05 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Tue,  9 Apr 2019 08:04:35 +0200
Message-Id: <20190409060435.22801-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 tcg/tci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1903..20b0715b6e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -1,7 +1,7 @@
 /*
  * Tiny Code Interpreter for QEMU
  *
- * Copyright (c) 2009, 2011, 2016 Stefan Weil
+ * Copyright (c) 2009, 2011, 2016, 2019 Stefan Weil
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -159,7 +159,8 @@ static uint64_t tci_uint64(uint32_t high, uint32_t low)
 /* Read constant (native size) from bytecode. */
 static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
 {
-    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
+    tcg_target_ulong value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -167,7 +168,8 @@ static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
 /* Read unsigned constant (32 bit) from bytecode. */
 static uint32_t tci_read_i32(uint8_t **tb_ptr)
 {
-    uint32_t value = *(uint32_t *)(*tb_ptr);
+    uint32_t value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -175,7 +177,8 @@ static uint32_t tci_read_i32(uint8_t **tb_ptr)
 /* Read signed constant (32 bit) from bytecode. */
 static int32_t tci_read_s32(uint8_t **tb_ptr)
 {
-    int32_t value = *(int32_t *)(*tb_ptr);
+    int32_t value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -184,7 +187,8 @@ static int32_t tci_read_s32(uint8_t **tb_ptr)
 /* Read constant (64 bit) from bytecode. */
 static uint64_t tci_read_i64(uint8_t **tb_ptr)
 {
-    uint64_t value = *(uint64_t *)(*tb_ptr);
+    uint64_t value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -474,7 +478,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     long tcg_temps[CPU_TEMP_BUF_NLONGS];
     uintptr_t sp_value = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
-    uintptr_t ret = 0;
+    uint64_t ret = 0;
 
     regs[TCG_AREG0] = (tcg_target_ulong)env;
     regs[TCG_REG_CALL_STACK] = sp_value;
@@ -1094,7 +1098,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             /* QEMU specific operations. */
 
         case INDEX_op_exit_tb:
-            ret = *(uint64_t *)tb_ptr;
+            memcpy(&ret, tb_ptr, sizeof(uint64_t));
             goto exit;
             break;
         case INDEX_op_goto_tb:
-- 
2.11.0
