Received: from eggs.gnu.org ([2001:4830:134:3::10]:55157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVo-0006Pe-TQ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVn-0005PP-Fd
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:48 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVn-0005OW-2j
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:47 -0500
Received: by mail-pg0-x241.google.com with SMTP id b1so2474762pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:46 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:45 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:40 -0800
Message-Id: <20161224040042.12654-4-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 03/65] tcg: Add deposit_z expander
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

While we don't require a new opcode, it is handy to have an expander
that knows the first source is zero.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg-op.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op.h |   6 +++
 2 files changed, 149 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b17f03f..1927e53 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -561,6 +561,64 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     tcg_temp_free_i32(t1);
 }
 
+void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
+                           unsigned int ofs, unsigned int len)
+{
+    tcg_debug_assert(ofs < 32);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= 32);
+    tcg_debug_assert(ofs + len <= 32);
+
+    if (ofs + len == 32) {
+        tcg_gen_shli_i32(ret, arg, ofs);
+    } else if (ofs == 0) {
+        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+    } else if (TCG_TARGET_HAS_deposit_i32
+               && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+        TCGv_i32 zero = tcg_const_i32(0);
+        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
+        tcg_temp_free_i32(zero);
+    } else {
+        /* To help two-operand hosts we prefer to zero-extend first,
+           which allows ARG to stay live.  */
+        switch (len) {
+        case 16:
+            if (TCG_TARGET_HAS_ext16u_i32) {
+                tcg_gen_ext16u_i32(ret, arg);
+                tcg_gen_shli_i32(ret, ret, ofs);
+                return;
+            }
+            break;
+        case 8:
+            if (TCG_TARGET_HAS_ext8u_i32) {
+                tcg_gen_ext8u_i32(ret, arg);
+                tcg_gen_shli_i32(ret, ret, ofs);
+                return;
+            }
+            break;
+        }
+        /* Otherwise prefer zero-extension over AND for code size.  */
+        switch (ofs + len) {
+        case 16:
+            if (TCG_TARGET_HAS_ext16u_i32) {
+                tcg_gen_shli_i32(ret, arg, ofs);
+                tcg_gen_ext16u_i32(ret, ret);
+                return;
+            }
+            break;
+        case 8:
+            if (TCG_TARGET_HAS_ext8u_i32) {
+                tcg_gen_shli_i32(ret, arg, ofs);
+                tcg_gen_ext8u_i32(ret, ret);
+                return;
+            }
+            break;
+        }
+        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        tcg_gen_shli_i32(ret, ret, ofs);
+    }
+}
+
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
                          unsigned int ofs, unsigned int len)
 {
@@ -1762,6 +1820,91 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     tcg_temp_free_i64(t1);
 }
 
+void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
+                           unsigned int ofs, unsigned int len)
+{
+    tcg_debug_assert(ofs < 64);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= 64);
+    tcg_debug_assert(ofs + len <= 64);
+
+    if (ofs + len == 64) {
+        tcg_gen_shli_i64(ret, arg, ofs);
+    } else if (ofs == 0) {
+        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+    } else if (TCG_TARGET_HAS_deposit_i64
+               && TCG_TARGET_deposit_i64_valid(ofs, len)) {
+        TCGv_i64 zero = tcg_const_i64(0);
+        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
+        tcg_temp_free_i64(zero);
+    } else {
+        if (TCG_TARGET_REG_BITS == 32) {
+            if (ofs >= 32) {
+                tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg),
+                                      ofs - 32, len);
+                tcg_gen_movi_i32(TCGV_LOW(ret), 0);
+                return;
+            }
+            if (ofs + len <= 32) {
+                tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
+                tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+                return;
+            }
+        }
+        /* To help two-operand hosts we prefer to zero-extend first,
+           which allows ARG to stay live.  */
+        switch (len) {
+        case 32:
+            if (TCG_TARGET_HAS_ext32u_i64) {
+                tcg_gen_ext32u_i64(ret, arg);
+                tcg_gen_shli_i64(ret, ret, ofs);
+                return;
+            }
+            break;
+        case 16:
+            if (TCG_TARGET_HAS_ext16u_i64) {
+                tcg_gen_ext16u_i64(ret, arg);
+                tcg_gen_shli_i64(ret, ret, ofs);
+                return;
+            }
+            break;
+        case 8:
+            if (TCG_TARGET_HAS_ext8u_i64) {
+                tcg_gen_ext8u_i64(ret, arg);
+                tcg_gen_shli_i64(ret, ret, ofs);
+                return;
+            }
+            break;
+        }
+        /* Otherwise prefer zero-extension over AND for code size.  */
+        switch (ofs + len) {
+        case 32:
+            if (TCG_TARGET_HAS_ext32u_i64) {
+                tcg_gen_shli_i64(ret, arg, ofs);
+                tcg_gen_ext32u_i64(ret, ret);
+                return;
+            }
+            break;
+        case 16:
+            if (TCG_TARGET_HAS_ext16u_i64) {
+                tcg_gen_shli_i64(ret, arg, ofs);
+                tcg_gen_ext16u_i64(ret, ret);
+                return;
+            }
+            break;
+        case 8:
+            if (TCG_TARGET_HAS_ext8u_i64) {
+                tcg_gen_shli_i64(ret, arg, ofs);
+                tcg_gen_ext8u_i64(ret, ret);
+                return;
+            }
+            break;
+        }
+        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        tcg_gen_shli_i64(ret, ret, ofs);
+    }
+}
+
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
                          unsigned int ofs, unsigned int len)
 {
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index b515e6f..d42fd0d 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -292,6 +292,8 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
+void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
+                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -473,6 +475,8 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
+void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
+                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
@@ -959,6 +963,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_rotr_tl tcg_gen_rotr_i64
 #define tcg_gen_rotri_tl tcg_gen_rotri_i64
 #define tcg_gen_deposit_tl tcg_gen_deposit_i64
+#define tcg_gen_deposit_z_tl tcg_gen_deposit_z_i64
 #define tcg_gen_extract_tl tcg_gen_extract_i64
 #define tcg_gen_sextract_tl tcg_gen_sextract_i64
 #define tcg_const_tl tcg_const_i64
@@ -1049,6 +1054,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_rotr_tl tcg_gen_rotr_i32
 #define tcg_gen_rotri_tl tcg_gen_rotri_i32
 #define tcg_gen_deposit_tl tcg_gen_deposit_i32
+#define tcg_gen_deposit_z_tl tcg_gen_deposit_z_i32
 #define tcg_gen_extract_tl tcg_gen_extract_i32
 #define tcg_gen_sextract_tl tcg_gen_sextract_i32
 #define tcg_const_tl tcg_const_i32
-- 
2.9.3
