Received: from eggs.gnu.org ([2001:4830:134:3::10]:35069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsOAX-0001yE-PJ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsO1e-0000zR-OM
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:57:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 22 Aug 2018 09:57:44 +0200
Message-Id: <20180822075750.12399-3-david@redhat.com>
In-Reply-To: <20180822075750.12399-1-david@redhat.com>
References: <20180822075750.12399-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/8] s390x/tcg: store in the TB flags if AFP
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We exit the TB when changing the control registers, so just like PSW
bits, this should always be consistent for a TB.

Using the PSW bit semantic makes things a lot easier compared to
manually defining the sapre, shifted bits.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.17.1
