Received: from eggs.gnu.org ([2001:4830:134:3::10]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AM-0001cr-H0
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AL-0002Au-EB
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:54 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AL-0002Ad-8u
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:53 -0500
Received: by mail-pl0-x244.google.com with SMTP id g18so3435893plo.7
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:10 -0800
Message-Id: <20180217182323.25885-55-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 54/67] target/arm: Implement SVE prefetches
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
 target/arm/translate-sve.c |  9 +++++++++
 target/arm/sve.decode      | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ca49b94924..63c7a0e8d8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3958,3 +3958,12 @@ static void trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
     do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
                cpu_reg_sp(s, a->rn), fn);
 }
+
+/*
+ * Prefetches
+ */
+
+static void trans_PRF(DisasContext *s, arg_PRF *a, uint32_t insn)
+{
+    /* Prefetch is a nop within QEMU.  */
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index edd9340c02..f0144aa2d0 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -801,6 +801,29 @@ LD1RQ_zprr	1010010 .. 00 ..... 000 ... ..... ..... \
 LD1RQ_zpri	1010010 .. 00 0.... 001 ... ..... ..... \
 		@rpri_load_msz nreg=0
 
+# SVE 32-bit gather prefetch (scalar plus 32-bit scaled offsets)
+PRF		1000010 00 -1 ----- 0-- --- ----- 0 ----
+
+# SVE 32-bit gather prefetch (vector plus immediate)
+PRF		1000010 -- 00 ----- 111 --- ----- 0 ----
+
+# SVE contiguous prefetch (scalar plus immediate)
+PRF		1000010 11 1- ----- 0-- --- ----- 0 ----
+
+# SVE contiguous prefetch (scalar plus scalar)
+PRF		1000010 -- 00 ----- 110 --- ----- 0 ----
+
+### SVE Memory 64-bit Gather Group
+
+# SVE 64-bit gather prefetch (scalar plus 64-bit scaled offsets)
+PRF		1100010 00 11 ----- 1-- --- ----- 0 ----
+
+# SVE 64-bit gather prefetch (scalar plus unpacked 32-bit scaled offsets)
+PRF		1100010 00 -1 ----- 0-- --- ----- 0 ----
+
+# SVE 64-bit gather prefetch (vector plus immediate)
+PRF		1100010 -- 00 ----- 111 --- ----- 0 ----
+
 ### SVE Memory Store Group
 
 # SVE store predicate register
-- 
2.14.3
