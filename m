Received: from eggs.gnu.org ([2001:4830:134:3::10]:56035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3k-0001B2-3U
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3h-000893-TP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:36 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:50 +0100
Message-Id: <20171214171004.25058-33-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 32/46] s390x/kvm: factor out
 build_channel_report_mcic() into cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We'll need it later on in two places. Refactor it to just indicate the
validity bits. While at it, introduce a define for the used CR14 bit (we'll
also need later on).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171208160207.26494-2-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h | 23 +++++++++++++++++++++++
 target/s390x/kvm.c | 25 ++-----------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9cfbbbac04..f9d4d62c48 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -351,6 +351,9 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #define CR0_CPU_TIMER_SC        0x0000000000000400ULL
 #define CR0_SERVICE_SC          0x0000000000000200ULL
 
+/* Control register 14 bits */
+#define CR14_CHANNEL_REPORT_SC  0x0000000010000000ULL
+
 /* MMU */
 #define MMU_PRIMARY_IDX         0
 #define MMU_SECONDARY_IDX       1
@@ -674,6 +677,26 @@ struct sysib_322 {
 #define MCIC_VB_CT 0x0000000000020000ULL
 #define MCIC_VB_CC 0x0000000000010000ULL
 
+static inline uint64_t s390_build_validity_mcic(void)
+{
+    uint64_t mcic;
+
+    /*
+     * Indicate all validity bits (no damage) only. Other bits have to be
+     * added by the caller. (storage errors, subclasses and subclass modifiers)
+     */
+    mcic = MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_FP |
+           MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_PR |
+           MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
+    if (s390_has_feat(S390_FEAT_VECTOR)) {
+        mcic |= MCIC_VB_VR;
+    }
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
+        mcic |= MCIC_VB_GS;
+    }
+    return mcic;
+}
+
 
 /* cpu.c */
 int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 97c45d5537..9b8b59f2a2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1852,33 +1852,12 @@ void kvm_s390_io_interrupt(uint16_t subchannel_id,
     kvm_s390_floating_interrupt(&irq);
 }
 
-static uint64_t build_channel_report_mcic(void)
-{
-    uint64_t mcic;
-
-    /* subclass: indicate channel report pending */
-    mcic = MCIC_SC_CP |
-    /* subclass modifiers: none */
-    /* storage errors: none */
-    /* validity bits: no damage */
-        MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_FP |
-        MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_PR |
-        MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
-    if (s390_has_feat(S390_FEAT_VECTOR)) {
-        mcic |= MCIC_VB_VR;
-    }
-    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
-        mcic |= MCIC_VB_GS;
-    }
-    return mcic;
-}
-
 void kvm_s390_crw_mchk(void)
 {
     struct kvm_s390_irq irq = {
         .type = KVM_S390_MCHK,
-        .u.mchk.cr14 = 1 << 28,
-        .u.mchk.mcic = build_channel_report_mcic(),
+        .u.mchk.cr14 = CR14_CHANNEL_REPORT_SC,
+        .u.mchk.mcic = s390_build_validity_mcic() | MCIC_SC_CP,
     };
     kvm_s390_floating_interrupt(&irq);
 }
-- 
2.13.6
