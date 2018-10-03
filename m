Received: from eggs.gnu.org ([2001:4830:134:3::10]:55410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7lYg-0002f7-0a
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7lYb-0005B6-VJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:37 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:43141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7lYb-0004DB-K7
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:33 -0400
Received: by mail-ot1-x336.google.com with SMTP id e21-v6so6482817otk.10
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 11:07:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Oct 2018 13:07:10 -0500
Message-Id: <20181003180711.19335-4-richard.henderson@linaro.org>
In-Reply-To: <20181003180711.19335-1-richard.henderson@linaro.org>
References: <20181003180711.19335-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/4] softfloat: Specialize udiv_qrnnd for
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

The ISA has a 128/64-bit division instruction.

Cc: qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 6d58615709..e702607b43 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -626,6 +626,12 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
     uint64_t q;
     asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
     return q;
+#elif defined(__s390x__)
+    /* Need to use a TImode type to get an even register pair for DLGR.  */
+    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
+    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
+    *r = n >> 64;
+    return n;
 #else
     uint64_t d0, d1, q0, q1, r1, r0, m;
 
-- 
2.17.1
