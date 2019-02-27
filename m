Received: from eggs.gnu.org ([209.51.188.92]:46980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz6YD-0005bl-2K
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz6YB-0001Cc-Sb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:15:36 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Feb 2019 22:15:25 +0100
Message-Id: <20190227211525.2470-3-david@redhat.com>
In-Reply-To: <20190227211525.2470-1-david@redhat.com>
References: <20190227211525.2470-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC2 2/2] tests/tcg: target/s390x: Test VECTOR
 LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Hildenbrand <david@redhat.com>

Reuse the existing helpers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/helper.h        |  6 ++++++
 tests/tcg/s390x/vlgv.c          | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 tests/tcg/s390x/vlgv.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 474c2428bd..deffc4c525 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -8,6 +8,7 @@ TESTS+=exrl-trtr
 TESTS+=pack
 
 VECTOR_TESTS=vge
+VECTOR_TESTS+=vlgv
 TESTS+=$(VECTOR_TESTS)
 
 #enable vectors and optimisation for vector tests
diff --git a/tests/tcg/s390x/helper.h b/tests/tcg/s390x/helper.h
index ecbd97519b..790ced7ad7 100644
--- a/tests/tcg/s390x/helper.h
+++ b/tests/tcg/s390x/helper.h
@@ -11,6 +11,12 @@ typedef union S390Vector {
     uint8_t h[16];
 } S390Vector;
 
+#define ES_8    0
+#define ES_16   1
+#define ES_32   2
+#define ES_64   3
+#define ES_128  4
+
 static inline void check(const char *s, bool cond)
 {
     if (!cond) {
diff --git a/tests/tcg/s390x/vlgv.c b/tests/tcg/s390x/vlgv.c
new file mode 100644
index 0000000000..2a4cca3bbb
--- /dev/null
+++ b/tests/tcg/s390x/vlgv.c
@@ -0,0 +1,37 @@
+#include <stdint.h>
+#include <unistd.h>
+#include "signal-helper.inc.c"
+
+static inline void vlgv(uint64_t *r1, S390Vector *v3, const void *a2,
+                        uint8_t m4)
+{
+    asm volatile("vlgv %[r1], %[v3], 0(%[a2]), %[m4]\n"
+                 : [r1] "+d" (*r1),
+                   [v3] "+v" (v3->v)
+                 : [a2] "d" (a2),
+                   [m4] "i" (m4));
+}
+
+int main(void)
+{
+    S390Vector v3 = {
+        .q[0] = 0x0011223344556677ull,
+        .q[1] = 0x8899aabbccddeeffull,
+    };
+    uint64_t r1 = 0;
+
+    /* Directly set all ignored bits to  */
+    vlgv(&r1, &v3, (void *)(7 | ~0xf), ES_8);
+    check("8 bit", r1 == 0x77);
+    vlgv(&r1, &v3, (void *)(4 | ~0x7), ES_16);
+    check("16 bit", r1 == 0x8899);
+    vlgv(&r1, &v3, (void *)(3 | ~0x3), ES_32);
+    check("32 bit", r1 == 0xccddeeff);
+    vlgv(&r1, &v3, (void *)(1 | ~0x1), ES_64);
+    check("64 bit", r1 == 0x8899aabbccddeeffull);
+    check("v3 not modified", v3.q[0] == 0x0011223344556677ull &&
+                             v3.q[1] == 0x8899aabbccddeeffull);
+
+    CHECK_SIGILL(vlgv(&r1, &v3, NULL, ES_128));
+    return 0;
+}
-- 
2.17.2
