Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBe-0005f2-Q6
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwzA-0002b6-Lu
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:42:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:28 +0200
Message-Id: <20180829094143.2102-5-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/19] target/s390x: fix IPM polluting
 irrelevant bits
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

Suppose psw.mask=0x0000000080000000, cc=2, r1=0 and we do "ipm 1".
This command must touch only bits 32-39, so the expected output
is r1=0x20000000. However, currently qemu yields r1=0x20008000,
because irrelevant parts of PSW leak into r1 during program mask
transfer.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Message-Id: <20180821025104.19604-5-pavel.zbitskiy@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c        | 17 +++++++----------
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/ipm.c           | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/s390x/ipm.c

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4f62a38c97..40e12ca2c4 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2444,20 +2444,17 @@ static DisasJumpType op_insi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ipm(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 t1;
+    TCGv_i64 t1, t2;
 
     gen_op_calc_cc(s);
-    tcg_gen_andi_i64(o->out, o->out, ~0xff000000ull);
-
     t1 = tcg_temp_new_i64();
-    tcg_gen_shli_i64(t1, psw_mask, 20);
-    tcg_gen_shri_i64(t1, t1, 36);
-    tcg_gen_or_i64(o->out, o->out, t1);
-
-    tcg_gen_extu_i32_i64(t1, cc_op);
-    tcg_gen_shli_i64(t1, t1, 28);
-    tcg_gen_or_i64(o->out, o->out, t1);
+    tcg_gen_extract_i64(t1, psw_mask, 40, 4);
+    t2 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t2, cc_op);
+    tcg_gen_deposit_i64(t1, t1, t2, 4, 60);
+    tcg_gen_deposit_i64(o->out, o->out, t1, 24, 8);
     tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return DISAS_NEXT;
 }
 
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index f62f950d8e..c800a582e5 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -2,3 +2,4 @@ VPATH+=$(SRC_PATH)/tests/tcg/s390x
 CFLAGS+=-march=zEC12 -m64
 TESTS+=hello-s390x
 TESTS+=csst
+TESTS+=ipm
diff --git a/tests/tcg/s390x/ipm.c b/tests/tcg/s390x/ipm.c
new file mode 100644
index 0000000000..742f3a18c5
--- /dev/null
+++ b/tests/tcg/s390x/ipm.c
@@ -0,0 +1,22 @@
+#include <stdint.h>
+#include <unistd.h>
+
+int main(void)
+{
+    uint32_t op1 = 0x55555555;
+    uint32_t op2 = 0x44444444;
+    uint64_t cc = 0xffffffffffffffffull;
+
+    asm volatile(
+        "    clc 0(4,%[op1]),0(%[op2])\n"
+        "    ipm %[cc]\n"
+        : [cc] "+r" (cc)
+        : [op1] "r" (&op1),
+          [op2] "r" (&op2)
+        : "cc");
+    if (cc != 0xffffffff20ffffffull) {
+        write(1, "bad cc\n", 7);
+        return 1;
+    }
+    return 0;
+}
-- 
2.14.4
