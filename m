Received: from eggs.gnu.org ([209.51.188.92]:59022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1gpNsz-00071P-Gl
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 20:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1gpNsy-0007wJ-Th
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 20:44:53 -0500
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Thu, 31 Jan 2019 20:40:44 -0500
Message-Id: <1548985244-24523-1-git-send-email-catherine.hecx@gmail.com>
Subject: [Qemu-devel] [RFC PATCH] target/arm: Fix int128_make128 lo,
 hi order in paired_cmpxchg64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Catherine Ho <catherine.hecx@gmail.com>

The lo,hi order is different from the comments. And in commit
1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128"), it changes
the original code logic. So just restore the old code logic before this 
commit:
do_paired_cmpxchg64_be():
    cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
    newv = int128_make128(new_hi, new_lo);

Fixes: 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128")

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
I didn't see any obvious real error case here, so set it as RFC

 target/arm/helper-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 101fa6d3ea..70850e564d 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -583,8 +583,8 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
      * High and low need to be switched here because this is not actually a
      * 128bit store but two doublewords stored consecutively
      */
-    Int128 cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
-    Int128 newv = int128_make128(new_lo, new_hi);
+    Int128 cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
+    Int128 newv = int128_make128(new_hi, new_lo);
     Int128 oldv;
     uintptr_t ra = GETPC();
     uint64_t o0, o1;
-- 
2.17.1
