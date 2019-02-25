Received: from eggs.gnu.org ([209.51.188.92]:49051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTm-0006qZ-Hb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTb-0000pW-Fx
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:03:54 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 21:03:15 +0100
Message-Id: <20190225200318.16102-5-david@redhat.com>
In-Reply-To: <20190225200318.16102-1-david@redhat.com>
References: <20190225200318.16102-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/7] s390x/tcg: Factor out
 vec_full_reg_offset()
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

We'll use that a lot along with gvec helpers, to calculate the start
address of a vector.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5e3955e4d7..6d36cfed2a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -145,13 +145,18 @@ void s390x_translate_init(void)
     }
 }
 
+static inline int vec_full_reg_offset(uint8_t reg)
+{
+    g_assert(reg < 32);
+    return offsetof(CPUS390XState, vregs[reg][0].d);
+}
+
 static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
 {
     /* Convert element size (es) - e.g. MO_U8 - to bytes */
     const uint8_t bytes = 1 << es;
     int offs = enr * bytes;
 
-    g_assert(reg < 32);
     /*
      * vregs[n][0] is the lowest 8 byte and vregs[n][1] the highest 8 byte
      * of the 16 byte vector, on both, little and big endian systems.
@@ -178,7 +183,7 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
 #ifndef HOST_WORDS_BIGENDIAN
     offs ^= (8 - bytes);
 #endif
-    return offs + offsetof(CPUS390XState, vregs[reg][0].d);
+    return offs + vec_full_reg_offset(reg);
 }
 
 static inline int freg64_offset(uint8_t reg)
-- 
2.17.2
