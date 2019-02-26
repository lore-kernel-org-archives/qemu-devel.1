Received: from eggs.gnu.org ([209.51.188.92]:47384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5S-0004Zi-1k
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5M-0006pd-Ks
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:47 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:45 +0100
Message-Id: <20190226113915.20150-4-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/33] s390x: Add one temporary vector
 register in CPU state for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We sometimes want to work on a temporary vector register instead of the
actual destination, because source and destination might overlap. An
alternative would be loading the vector into two i64 variables, but than
separate handling for accessing the vector elements would be needed.
This is easier. Add one for now as that seems to be enough.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h       | 11 +++++++++++
 target/s390x/translate.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index cb6d77053a..a8dc0b2b83 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -67,6 +67,17 @@ struct CPUS390XState {
      * vregs[0][0] -> vregs[15][0] are 16 floating point registers
      */
     CPU_DoubleU vregs[32][2];  /* vector registers */
+#ifdef CONFIG_TCG
+#define TMP_VREG_0   33
+    /*
+     * Temporary vector registers used while processing vector instructions
+     * in TCG. This is helpful e.g. when source and destination registers
+     * overlap for certain instructions in translate functions. Content valid
+     * only within execution of one translated block, therefore no migration is
+     * needed. Resets don't mather, but has to be properly aligned.
+     */
+    CPU_DoubleU tmp_vregs[1][2];
+#endif
     uint32_t aregs[16];    /* access registers */
     uint8_t riccb[64];     /* runtime instrumentation control */
     uint64_t gscb[4];      /* guarded storage control */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d52c02c572..8733d19182 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -147,6 +147,9 @@ void s390x_translate_init(void)
 
 static inline int vec_full_reg_offset(uint8_t reg)
 {
+    if (reg == TMP_VREG_0) {
+        return offsetof(CPUS390XState, tmp_vregs[0][0].d);
+    }
     g_assert(reg < 32);
     return offsetof(CPUS390XState, vregs[reg][0].d);
 }
-- 
2.17.2
