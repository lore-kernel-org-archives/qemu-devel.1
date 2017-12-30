Received: from eggs.gnu.org ([2001:4830:134:3::10]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@dinsnail.net>) id 1eVQ49-0005ln-Ji
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 17:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@dinsnail.net>) id 1eVQ46-0007sQ-IB
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 17:57:21 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Sat, 30 Dec 2017 23:56:22 +0100
Message-Id: <20171230225622.97409-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH v2] target/arm: Fix stlxp for aarch64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Michael Weiser <michael.weiser@gmx.de>

ldxp loads two consecutive doublewords from memory regardless of CPU
endianness. On store, stlxp currently assumes to work with a 128bit
value and consequently switches order in big-endian mode. With this
change it packs the doublewords in reverse order in anticipation of the
128bit big-endian store operation interposing them so they end up in
memory in the right order. This makes it work for both MTTCG and !MTTCG.
It effectively implements the ARM ARM STLXP operation pseudo-code:

data = if BigEndian() then el1:el2 else el2:el1;

With this change an aarch64_be Linux 4.14.4 kernel succeeds to boot up
in system emulation mode.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 target/arm/helper-a64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

v2:
- make it work for MTTCG as well by catering to the 128bit expectation

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index b84ebcae6e..3adb88db6a 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -506,8 +506,10 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
     Int128 oldv, cmpv, newv;
     bool success;
 
-    cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
-    newv = int128_make128(new_lo, new_hi);
+    /* high and low need to be switched here because this is not actually a
+     * 128bit store but two doulbewords stored consecutively */
+    cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
+    newv = int128_make128(new_hi, new_lo);
 
     if (parallel) {
 #ifndef CONFIG_ATOMIC128
-- 
2.15.1
