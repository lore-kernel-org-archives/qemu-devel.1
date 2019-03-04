Received: from eggs.gnu.org ([209.51.188.92]:46384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJ0-00007A-IJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIy-0000L6-Rp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:50 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:52 +0100
Message-Id: <20190304120210.31500-10-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/27] s390x/tcg: Factor out
 vec_full_reg_offset()
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

We'll use that a lot along with gvec helpers, to calculate the start
address of a vector.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225200318.16102-5-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6647a67998ba..933bf29331a2 100644
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
     /* Convert element size (es) - e.g. MO_8 - to bytes */
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
