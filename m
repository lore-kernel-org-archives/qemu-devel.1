Received: from eggs.gnu.org ([209.51.188.92]:51561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyF04-0002Fd-OH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyEzv-0004Iu-Cu
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:04:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gyEzu-0004Fc-LC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:04:38 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 12:55:48 +0100
Message-Id: <20190225115552.7534-4-david@redhat.com>
In-Reply-To: <20190225115552.7534-1-david@redhat.com>
References: <20190225115552.7534-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/7] s390x/tcg: Clarify terminology in
 vec_reg_offset()
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

We will use s390x speak "Element Size" (es) for MO_8 == 0, MO_16 == 1
... Simple rename of variables.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index c646e50eb3..916508b567 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -145,10 +145,10 @@ void s390x_translate_init(void)
     }
 }
 
-static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
+static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
 {
-    const uint8_t es = 1 << size;
-    int offs = enr * es;
+    const uint8_t bytes = 1 << es;
+    int offs = enr * bytes;
 
     g_assert(reg < 32);
     /*
@@ -173,9 +173,9 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
      * the two 8 byte elements have to be loaded separately. Let's force all
      * 16 byte operations to handle it in a special way.
      */
-    g_assert(size <= MO_64);
+    g_assert(es <= MO_64);
 #ifndef HOST_WORDS_BIGENDIAN
-    offs ^= (8 - es);
+    offs ^= (8 - bytes);
 #endif
     return offs + offsetof(CPUS390XState, vregs[reg][0].d);
 }
-- 
2.17.2
