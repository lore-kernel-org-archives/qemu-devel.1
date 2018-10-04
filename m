Received: from eggs.gnu.org ([2001:4830:134:3::10]:53240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZZ-0008LA-2T
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZT-000579-NC
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:50 +0200
Message-Id: <20181004152857.14525-9-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] s390x/tcg: store in the TB flags if AFP
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We exit the TB when changing the control registers, so just like PSW
bits, this should always be consistent for a TB.

Using the PSW bit semantic makes things a lot easier compared to
manually defining the spare, shifted bits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-4-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5e50c3a303..8c2320e882 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -255,6 +255,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 
 /* PSW defines */
 #undef PSW_MASK_PER
+#undef PSW_MASK_UNUSED_2
 #undef PSW_MASK_DAT
 #undef PSW_MASK_IO
 #undef PSW_MASK_EXT
@@ -273,6 +274,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #undef PSW_MASK_ESA_ADDR
 
 #define PSW_MASK_PER            0x4000000000000000ULL
+#define PSW_MASK_UNUSED_2       0x2000000000000000ULL
 #define PSW_MASK_DAT            0x0400000000000000ULL
 #define PSW_MASK_IO             0x0200000000000000ULL
 #define PSW_MASK_EXT            0x0100000000000000ULL
@@ -318,6 +320,9 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #define FLAG_MASK_PSW           (FLAG_MASK_PER | FLAG_MASK_DAT | FLAG_MASK_PSTATE \
                                 | FLAG_MASK_ASC | FLAG_MASK_64 | FLAG_MASK_32)
 
+/* we'll use some unused PSW positions to store CR flags in tb flags */
+#define FLAG_MASK_AFP           (PSW_MASK_UNUSED_2 >> FLAG_MASK_PSW_SHIFT)
+
 /* Control register 0 bits */
 #define CR0_LOWPROT             0x0000000010000000ULL
 #define CR0_SECONDARY           0x0000000004000000ULL
@@ -364,6 +369,9 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
     *pc = env->psw.addr;
     *cs_base = env->ex_value;
     *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->cregs[0] & CR0_AFP) {
+        *flags |= FLAG_MASK_AFP;
+    }
 }
 
 /* PER bits from control register 9 */
-- 
2.14.4
