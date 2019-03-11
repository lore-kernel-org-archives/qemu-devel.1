Received: from eggs.gnu.org ([209.51.188.92]:42970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqb-0002sV-7l
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqZ-0005Ft-74
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:52 +0100
Message-Id: <20190311090322.21603-4-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/33] s390x/tcg: Check vector register
 instructions at central point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Check them at a central point. We'll use a new instruction flag to
flag all vector instructions (IF_VEC) and handle it very similar to
AFP, whereby we use another unused position in the PSW mask to store
the state of vector register enablement per translation block.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h       |  7 +++++++
 target/s390x/translate.c | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b71ac5183dee..cb6d77053a4d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -257,6 +257,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 /* PSW defines */
 #undef PSW_MASK_PER
 #undef PSW_MASK_UNUSED_2
+#undef PSW_MASK_UNUSED_3
 #undef PSW_MASK_DAT
 #undef PSW_MASK_IO
 #undef PSW_MASK_EXT
@@ -276,6 +277,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 
 #define PSW_MASK_PER            0x4000000000000000ULL
 #define PSW_MASK_UNUSED_2       0x2000000000000000ULL
+#define PSW_MASK_UNUSED_3       0x1000000000000000ULL
 #define PSW_MASK_DAT            0x0400000000000000ULL
 #define PSW_MASK_IO             0x0200000000000000ULL
 #define PSW_MASK_EXT            0x0100000000000000ULL
@@ -323,12 +325,14 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 
 /* we'll use some unused PSW positions to store CR flags in tb flags */
 #define FLAG_MASK_AFP           (PSW_MASK_UNUSED_2 >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_VECTOR        (PSW_MASK_UNUSED_3 >> FLAG_MASK_PSW_SHIFT)
 
 /* Control register 0 bits */
 #define CR0_LOWPROT             0x0000000010000000ULL
 #define CR0_SECONDARY           0x0000000004000000ULL
 #define CR0_EDAT                0x0000000000800000ULL
 #define CR0_AFP                 0x0000000000040000ULL
+#define CR0_VECTOR              0x0000000000020000ULL
 #define CR0_EMERGENCY_SIGNAL_SC 0x0000000000004000ULL
 #define CR0_EXTERNAL_CALL_SC    0x0000000000002000ULL
 #define CR0_CKC_SC              0x0000000000000800ULL
@@ -373,6 +377,9 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
     if (env->cregs[0] & CR0_AFP) {
         *flags |= FLAG_MASK_AFP;
     }
+    if (env->cregs[0] & CR0_VECTOR) {
+        *flags |= FLAG_MASK_VECTOR;
+    }
 }
 
 /* PER bits from control register 9 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 1d8030f8cd82..d52c02c572bb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1203,6 +1203,7 @@ typedef struct {
 #define IF_BFP      0x0008      /* binary floating point instruction */
 #define IF_DFP      0x0010      /* decimal floating point instruction */
 #define IF_PRIV     0x0020      /* privileged instruction */
+#define IF_VEC      0x0040      /* vector instruction */
 
 struct DisasInsn {
     unsigned opc:16;
@@ -6337,11 +6338,22 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
             if (insn->flags & IF_DFP) {
                 dxc = 3;
             }
+            if (insn->flags & IF_VEC) {
+                dxc = 0xfe;
+            }
             if (dxc) {
                 gen_data_exception(dxc);
                 return DISAS_NORETURN;
             }
         }
+
+        /* if vector instructions not enabled, executing them is forbidden */
+        if (insn->flags & IF_VEC) {
+            if (!((s->base.tb->flags & FLAG_MASK_VECTOR))) {
+                gen_data_exception(0xfe);
+                return DISAS_NORETURN;
+            }
+        }
     }
 
     /* Check for insn specification exceptions.  */
-- 
2.17.2
