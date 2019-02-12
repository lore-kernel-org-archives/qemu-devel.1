Received: from eggs.gnu.org ([209.51.188.92]:53564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqo-0005pu-Vg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqn-0002cJ-KH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:02:56 +0100
Message-Id: <20190212110308.13707-5-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/15] s390x/tcg: Factor out conversion of
 softfloat exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We want to reuse that function in vector instruction context. While at it,
cleanup the code, using defines for magic values and avoiding the
handcrafted bit conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 25 +++++++++++++------------
 target/s390x/internal.h   |  7 +++++++
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index f9ec519067..60f589608e 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -36,10 +36,18 @@
 
 #define RET128(F) (env->retxl = F.low, F.high)
 
-#define convert_bit(mask, from, to) \
-    (to < from                      \
-     ? (mask / (from / to)) & to    \
-     : (mask & from) * (to / from))
+uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
+{
+    uint8_t s390_exc = 0;
+
+    s390_exc |= (exc & float_flag_invalid) ? S390_IEEE_MASK_INVALID : 0;
+    s390_exc |= (exc & float_flag_divbyzero) ? S390_IEEE_MASK_DIVBYZERO : 0;
+    s390_exc |= (exc & float_flag_overflow) ? S390_IEEE_MASK_OVERFLOW : 0;
+    s390_exc |= (exc & float_flag_underflow) ? S390_IEEE_MASK_UNDERFLOW : 0;
+    s390_exc |= (exc & float_flag_inexact) ? S390_IEEE_MASK_INEXACT : 0;
+
+    return s390_exc;
+}
 
 /* Should be called after any operation that may raise IEEE exceptions.  */
 static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
@@ -53,14 +61,7 @@ static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
         return;
     }
     env->fpu_status.float_exception_flags = 0;
-
-    /* Convert softfloat exception bits to s390 exception bits.  */
-    s390_exc = 0;
-    s390_exc |= convert_bit(qemu_exc, float_flag_invalid, 0x80);
-    s390_exc |= convert_bit(qemu_exc, float_flag_divbyzero, 0x40);
-    s390_exc |= convert_bit(qemu_exc, float_flag_overflow, 0x20);
-    s390_exc |= convert_bit(qemu_exc, float_flag_underflow, 0x10);
-    s390_exc |= convert_bit(qemu_exc, float_flag_inexact, 0x08);
+    s390_exc = s390_softfloat_exc_to_ieee(qemu_exc);
 
     /* Install the exceptions that we raised.  */
     env->fpc |= s390_exc << 16;
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index f2a771e2b4..e1c0b1bd3b 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -308,6 +308,13 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 uint32_t set_cc_nz_f32(float32 v);
 uint32_t set_cc_nz_f64(float64 v);
 uint32_t set_cc_nz_f128(float128 v);
+#define S390_IEEE_MASK_INVALID   0x80
+#define S390_IEEE_MASK_DIVBYZERO 0x40
+#define S390_IEEE_MASK_OVERFLOW  0x20
+#define S390_IEEE_MASK_UNDERFLOW 0x10
+#define S390_IEEE_MASK_INEXACT   0x08
+#define S390_IEEE_MASK_QUANTUM   0x04
+uint8_t s390_softfloat_exc_to_ieee(unsigned int exc);
 
 
 /* gdbstub.c */
-- 
2.17.2
