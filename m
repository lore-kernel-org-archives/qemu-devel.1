Received: from eggs.gnu.org ([2001:4830:134:3::10]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBj-0005TP-09
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwz9-0002at-2w
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:42:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:27 +0200
Message-Id: <20180829094143.2102-4-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/19] target/s390x: fix CSST decoding and
 runtime alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Cornelia Huck <cohuck@redhat.com>

From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

CSST is defined as:

    C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)

It means that the first parameter is handled by in1_la1().
in1_la1() fills addr1 field, and not in1.

Furthermore, when extract32() is used for the alignment check, the
third parameter should specify the number of trailing bits that must
be 0. For FC these numbers are:

    FC=0 (word, 4 bytes):        2
    FC=1 (double word, 8 bytes): 3
    FC=2 (quad word, 16 bytes):  4

For SC these numbers correspond to the size:

    SC=0: 0
    SC=1: 1
    SC=2: 2
    SC=3: 3
    SC=4: 4

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Message-Id: <20180821025104.19604-4-pavel.zbitskiy@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mem_helper.c       |  2 +-
 target/s390x/translate.c        |  4 ++--
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/csst.c          | 43 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/s390x/csst.c

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e21a47fb4d..c94dbf3fcb 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1442,7 +1442,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     }
 
     /* Sanity check the alignments.  */
-    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
+    if (extract32(a1, 0, fc + 2) || extract32(a2, 0, sc)) {
         goto spec_exception;
     }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9caae5af84..4f62a38c97 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2058,9 +2058,9 @@ static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
     TCGv_i32 t_r3 = tcg_const_i32(r3);
 
     if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2);
+        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->addr1, o->in2);
     } else {
-        gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
+        gen_helper_csst(cc_op, cpu_env, t_r3, o->addr1, o->in2);
     }
     tcg_temp_free_i32(t_r3);
 
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 9f4076901f..f62f950d8e 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -1,3 +1,4 @@
 VPATH+=$(SRC_PATH)/tests/tcg/s390x
 CFLAGS+=-march=zEC12 -m64
 TESTS+=hello-s390x
+TESTS+=csst
diff --git a/tests/tcg/s390x/csst.c b/tests/tcg/s390x/csst.c
new file mode 100644
index 0000000000..1dae9071fb
--- /dev/null
+++ b/tests/tcg/s390x/csst.c
@@ -0,0 +1,43 @@
+#include <stdint.h>
+#include <unistd.h>
+
+int main(void)
+{
+    uint64_t parmlist[] = {
+        0xfedcba9876543210ull,
+        0,
+        0x7777777777777777ull,
+        0,
+    };
+    uint64_t op1 = 0x0123456789abcdefull;
+    uint64_t op2 = 0;
+    uint64_t op3 = op1;
+    uint64_t cc;
+
+    asm volatile(
+        "    lghi %%r0,%[flags]\n"
+        "    la %%r1,%[parmlist]\n"
+        "    csst %[op1],%[op2],%[op3]\n"
+        "    ipm %[cc]\n"
+        : [op1] "+m" (op1),
+          [op2] "+m" (op2),
+          [op3] "+r" (op3),
+          [cc] "=r" (cc)
+        : [flags] "K" (0x0301),
+          [parmlist] "m" (parmlist)
+        : "r0", "r1", "cc", "memory");
+    cc = (cc >> 28) & 3;
+    if (cc) {
+        write(1, "bad cc\n", 7);
+        return 1;
+    }
+    if (op1 != parmlist[0]) {
+        write(1, "bad op1\n", 8);
+        return 1;
+    }
+    if (op2 != parmlist[2]) {
+        write(1, "bad op2\n", 8);
+        return 1;
+    }
+    return 0;
+}
-- 
2.14.4
