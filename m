Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDZeC-0008HV-FN
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDZeA-0000ZQ-15
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:04 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDZe9-0000Yc-RP
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:01 -0400
Received: by mail-pg0-x243.google.com with SMTP id m21-v6so8776089pgv.8
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:05:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  1 May 2018 11:04:54 -0700
Message-Id: <20180501180455.11214-2-richard.henderson@linaro.org>
In-Reply-To: <20180501180455.11214-1-richard.henderson@linaro.org>
References: <20180501180455.11214-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Tidy conditions in
 handle_vec_simd_shri
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

The (size > 3 && !is_q) condition is identical to the preceeding test
of bit 3 in immh; eliminate it.  For the benefit of Coverity, assert
that size is within the bounds we expect.

Fixes: Coverity CID1385846
Fixes: Coverity CID1385849
Fixes: Coverity CID1385852
Fixes: Coverity CID1385857
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bff4e13bf6..97950dce1a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9019,11 +9019,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         unallocated_encoding(s);
         return;
     }
-
-    if (size > 3 && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
+    tcg_debug_assert(size <= 3);
 
     if (!fp_access_check(s)) {
         return;
-- 
2.14.3
