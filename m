Received: from eggs.gnu.org ([2001:4830:134:3::10]:38629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQg-0000Ww-Kb
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQe-0004zE-53
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:22 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UQd-0004qk-Ot
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id u74-v6so11073086oia.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 11:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 13:02:00 -0500
Message-Id: <20181005180201.11387-8-richard.henderson@linaro.org>
In-Reply-To: <20181005180201.11387-1-richard.henderson@linaro.org>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 7/8] softfloat: Specialize udiv_qrnnd for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The ISA has a 128/64-bit division instruction.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 39eb08b4f1..eafc68932b 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -641,6 +641,12 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
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
