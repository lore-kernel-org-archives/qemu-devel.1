Received: from eggs.gnu.org ([2001:4830:134:3::10]:34503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEwwc-0006rE-OS
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEwwb-0006PW-QA
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:30 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:49235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEwwb-0006Ou-KN
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:29 -0500
Received: by mail-wr0-x242.google.com with SMTP id o88so20312517wrb.6
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 04:37:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Nov 2017 13:35:20 +0100
Message-Id: <20171115123520.7464-4-richard.henderson@linaro.org>
In-Reply-To: <20171115123520.7464-1-richard.henderson@linaro.org>
References: <20171115123520.7464-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.11 3/3] target/arm: Fix GETPC usage in
 do_paired_cmpxchg64_l/be
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

Use of GETPC must be restricted to those functions that are
directly called from TCG generated code.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: 2399d4e7cec22ecf1c51062d2ebfd45220dbaace
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 96a3ecf707..b84ebcae6e 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -432,9 +432,8 @@ uint64_t HELPER(crc32c_64)(uint64_t acc, uint64_t val, uint32_t bytes)
 /* Returns 0 on success; 1 otherwise.  */
 static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
                                        uint64_t new_lo, uint64_t new_hi,
-                                       bool parallel)
+                                       bool parallel, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     Int128 oldv, cmpv, newv;
     bool success;
 
@@ -491,20 +490,19 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
 uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
                                               uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false);
+    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false, GETPC());
 }
 
 uint64_t HELPER(paired_cmpxchg64_le_parallel)(CPUARMState *env, uint64_t addr,
                                               uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true);
+    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true, GETPC());
 }
 
 static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
                                        uint64_t new_lo, uint64_t new_hi,
-                                       bool parallel)
+                                       bool parallel, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     Int128 oldv, cmpv, newv;
     bool success;
 
@@ -561,11 +559,11 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
 uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
                                      uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false);
+    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false, GETPC());
 }
 
 uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
                                      uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true);
+    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true, GETPC());
 }
-- 
2.13.6
