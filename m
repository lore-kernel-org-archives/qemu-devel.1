Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u2-0000gQ-L3
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u1-00076y-Ls
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:26 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er4u1-00076F-Ey
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:25 -0500
Received: by mail-pf0-x242.google.com with SMTP id u5so1219285pfh.6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:48:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 08:48:16 -0800
Message-Id: <20180228164816.24110-5-richard.henderson@linaro.org>
In-Reply-To: <20180228164816.24110-1-richard.henderson@linaro.org>
References: <20180228164816.24110-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RISU 3/3] Add arm and thumb vqrdml[as]h, vcadd, vcmla
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 arm.risu   | 25 +++++++++++++++++++++++++
 thumb.risu | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arm.risu b/arm.risu
index 13ea019..af73345 100644
--- a/arm.risu
+++ b/arm.risu
@@ -831,3 +831,28 @@ VCVT_rm_neon A1 1111 00111 d 11 size:2 11 vd:4 00 rm:2 op q m 0 vm:4
 # Note that sz == 0b11 is UNPREDICTABLE (either UNDEF, NOP or as if == 0b10)
 # as is cond != 1110 (either UNDEF, NOP, cond-exec or unconditional exec)
 CRC32 A1 1110 00010 sz:2 0 rn:4 rd:4 00 c 0 0100 rm:4 !constraints { $sz != 3; }
+
+#
+# ARMv8.1 extensions
+#
+@v8_1_simd
+
+VQRDMLAH    A1 111100110 d:1 size:2 vn:4 vd:4 1011 n:1 q:1 m:1 1 vm:4
+VQRDMLAH_s  A1 1111001 q:1 1 d:1 size:2 vn:4 vd:4 1110 n:1 1 m:1 0 vm:4
+
+VQRDMLSH    A1 111100110 d:1 size:2 vn:4 vd:4 1100 n:1 q:1 m:1 1 vm:4
+VQRDMLSH_s  A1 1111001 q:1 1 d:1 size:2 vn:4 vd:4 1111 n:1 1 m:1 0 vm:4
+
+#
+# ARMv8.3 extensions
+#
+@v8_3_compnum
+
+# Disable fp16 until qemu supports it.
+VCADD       A1 1111110 rot:1 1 d:1 0 s:1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
+!constraints { $s != 0; }
+
+VCMLA       A1 1111110 rot:2 d:1 1 s:1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
+!constraints { $s != 0; }
+VCMLA_s     A1 11111110 s:1 d:1 rot:2 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
+!constraints { $s != 0; }
diff --git a/thumb.risu b/thumb.risu
index bf7556b..b8afa59 100644
--- a/thumb.risu
+++ b/thumb.risu
@@ -437,3 +437,28 @@ STR T2 11111 000 0100 rn:4 rt:4 000000 imm:2 rm:4 \
 
 # V8 only instructions
 CRC32 T1 111 1101 011 0 c rn:4 1111 rd:4 10 sz:2 rm:4 !constraints { $sz != 3; }
+
+#
+# ARMv8.1 extensions
+#
+@v8_1_simd
+
+VQRDMLAH    T1  111111110 d:1 size:2 vn:4 vd:4 1011 n:1 q:1 m:1 1 vm:4
+VQRDMLAH_s  T1  111 q:1 11111 d:1 size:2 vn:4 vd:4 1110 n:1 1 m:1 0 vm:4
+
+VQRDMLSH    T1  111111110 d:1 size:2 vn:4 vd:4 1100 n:1 q:1 m:1 1 vm:4
+VQRDMLSH_s  T1  111 q:1 11111 d:1 size:2 vn:4 vd:4 1111 n:1 1 m:1 0 vm:4
+
+#
+# ARMv8.3 extensions
+#
+@v8_3_compnum
+
+# Disable fp16 until qemu supports it.
+VCADD       T1  1111110 rot:1 1 d:1 0 s:1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
+!constraints { $s != 0; }
+
+VCMLA       T1  1111110 rot:2 d:1 1 s:1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
+!constraints { $s != 0; }
+VCMLA_s     T1  11111110 s:1 d:1 rot:2 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
+!constraints { $s != 0; }
-- 
2.14.3
