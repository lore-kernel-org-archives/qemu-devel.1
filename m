Received: from eggs.gnu.org ([209.51.188.92]:51727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyF12-0002y1-9x
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyF10-0005aH-Ev
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:05:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gyF0x-0005Oi-Rk
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:05:45 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 12:55:49 +0100
Message-Id: <20190225115552.7534-5-david@redhat.com>
In-Reply-To: <20190225115552.7534-1-david@redhat.com>
References: <20190225115552.7534-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/7] s390x/tcg: Factor out
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 916508b567..f8c285a685 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -145,12 +145,17 @@ void s390x_translate_init(void)
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
     const uint8_t bytes = 1 << es;
     int offs = enr * bytes;
 
-    g_assert(reg < 32);
     /*
      * vregs[n][0] is the lowest 8 byte and vregs[n][1] the highest 8 byte
      * of the 16 byte vector, on both, little and big endian systems.
@@ -177,7 +182,7 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
 #ifndef HOST_WORDS_BIGENDIAN
     offs ^= (8 - bytes);
 #endif
-    return offs + offsetof(CPUS390XState, vregs[reg][0].d);
+    return offs + vec_full_reg_offset(reg);
 }
 
 static inline int freg64_offset(uint8_t reg)
-- 
2.17.2
