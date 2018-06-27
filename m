Received: from eggs.gnu.org ([2001:4830:134:3::10]:60420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29P-0004ER-Nh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29N-0000TH-KL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:51 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:40033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29N-0000RR-B3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:49 -0400
Received: by mail-pf0-x236.google.com with SMTP id z24-v6so385454pfe.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:33:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:05 -0700
Message-Id: <20180627043328.11531-13-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 12/35] target/arm: Implement SVE prefetches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 21 +++++++++++++++++++++
 target/arm/sve.decode      | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 65da3e633f..27854e0042 100644
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
index 7d24c2bdc4..80b955ff84 100644
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
