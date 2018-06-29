Received: from eggs.gnu.org ([2001:4830:134:3::10]:33827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumm-0007SM-4d
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumj-0006Zd-UA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumj-0006Sf-Jn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumi-0004bj-Bc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:04 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:10 +0100
Message-Id: <20180629145347.652-19-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/55] target/arm: Implement SVE prefetches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180627043328.11531-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 21 +++++++++++++++++++++
 target/arm/sve.decode      | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 11541b1a502..c73c3fc2151 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4303,3 +4303,24 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
                cpu_reg_sp(s, a->rn), fn);
     return true;
 }
+
+/*
+ * Prefetches
+ */
+
+static bool trans_PRF(DisasContext *s, arg_PRF *a, uint32_t insn)
+{
+    /* Prefetch is a nop within QEMU.  */
+    sve_access_check(s);
+    return true;
+}
+
+static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
+{
+    if (a->rm == 31) {
+        return false;
+    }
+    /* Prefetch is a nop within QEMU.  */
+    sve_access_check(s);
+    return true;
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 7d24c2bdc4c..80b955ff840 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -794,6 +794,29 @@ LD1RQ_zprr      1010010 .. 00 ..... 000 ... ..... ..... \
 LD1RQ_zpri      1010010 .. 00 0.... 001 ... ..... ..... \
                 @rpri_load_msz nreg=0
 
+# SVE 32-bit gather prefetch (scalar plus 32-bit scaled offsets)
+PRF             1000010 00 -1 ----- 0-- --- ----- 0 ----
+
+# SVE 32-bit gather prefetch (vector plus immediate)
+PRF             1000010 -- 00 ----- 111 --- ----- 0 ----
+
+# SVE contiguous prefetch (scalar plus immediate)
+PRF             1000010 11 1- ----- 0-- --- ----- 0 ----
+
+# SVE contiguous prefetch (scalar plus scalar)
+PRF_rr          1000010 -- 00 rm:5 110 --- ----- 0 ----
+
+### SVE Memory 64-bit Gather Group
+
+# SVE 64-bit gather prefetch (scalar plus 64-bit scaled offsets)
+PRF             1100010 00 11 ----- 1-- --- ----- 0 ----
+
+# SVE 64-bit gather prefetch (scalar plus unpacked 32-bit scaled offsets)
+PRF             1100010 00 -1 ----- 0-- --- ----- 0 ----
+
+# SVE 64-bit gather prefetch (vector plus immediate)
+PRF             1100010 -- 00 ----- 111 --- ----- 0 ----
+
 ### SVE Memory Store Group
 
 # SVE store predicate register
-- 
2.17.1
