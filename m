Received: from eggs.gnu.org ([2001:4830:134:3::10]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1frwlc-0004Am-Af
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1frwlb-0004ju-C9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:51:36 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Mon, 20 Aug 2018 22:51:03 -0400
Message-Id: <20180821025104.19604-7-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] target/s390x: fix PACK reading 1 byte less
 and writing 1 byte more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

PACK fails on the test from the Principles of Operation: F1F2F3F4
becomes 0000234C instead of 0001234C due to an off-by-one error.
Furthermore, it overwrites one extra byte to the left of F1.

If len_dest is 0, then we only want to flip the 1st byte and never loop
over the rest. Therefore, the loop condition should be > and not >=.

If len_src is 1, then we should flip the 1st byte and pack the 2nd.
Since len_src is already decremented before the loop, the first
condition should be >=, and not >.

Likewise for len_src == 2 and the second condition.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/mem_helper.c       |  6 +++---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/pack.c          | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/s390x/pack.c

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 704d0193b5..bacae4f503 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1019,15 +1019,15 @@ void HELPER(pack)(CPUS390XState *env, uint32_t len, uint64_t dest, uint64_t src)
     len_src--;
 
     /* now pack every value */
-    while (len_dest >= 0) {
+    while (len_dest > 0) {
         b = 0;
 
-        if (len_src > 0) {
+        if (len_src >= 0) {
             b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
             src--;
             len_src--;
         }
-        if (len_src > 0) {
+        if (len_src >= 0) {
             b |= cpu_ldub_data_ra(env, src, ra) << 4;
             src--;
             len_src--;
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 7de4376f52..151dc075aa 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -5,3 +5,4 @@ TESTS+=csst
 TESTS+=ipm
 TESTS+=exrl-trt
 TESTS+=exrl-trtr
+TESTS+=pack
diff --git a/tests/tcg/s390x/pack.c b/tests/tcg/s390x/pack.c
new file mode 100644
index 0000000000..4be36f29a7
--- /dev/null
+++ b/tests/tcg/s390x/pack.c
@@ -0,0 +1,21 @@
+#include <unistd.h>
+
+int main(void)
+{
+    char data[] = {0xaa, 0xaa, 0xf1, 0xf2, 0xf3, 0xc4, 0xaa, 0xaa};
+    char exp[] = {0xaa, 0xaa, 0x00, 0x01, 0x23, 0x4c, 0xaa, 0xaa};
+    int i;
+
+    asm volatile(
+        "    pack 2(4,%[data]),2(4,%[data])\n"
+        :
+        : [data] "r" (&data[0])
+        : "memory");
+    for (i = 0; i < 8; i++) {
+        if (data[i] != exp[i]) {
+            write(1, "bad data\n", 9);
+            return 1;
+        }
+    }
+    return 0;
+}
-- 
2.18.0
