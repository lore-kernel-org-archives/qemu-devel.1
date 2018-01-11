Received: from eggs.gnu.org ([2001:4830:134:3::10]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3y-0007P8-20
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3x-0008UN-4N
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3w-0008Ns-Kb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3v-0005eM-1j
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:04 +0000
Message-Id: <1515677902-23436-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/26] target/arm: Fix stlxp for aarch64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Weiser <michael.weiser@gmx.de>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index b84ebca..3e00a9e 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -506,8 +506,11 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
     Int128 oldv, cmpv, newv;
     bool success;
 
-    cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
-    newv = int128_make128(new_lo, new_hi);
+    /* high and low need to be switched here because this is not actually a
+     * 128bit store but two doublewords stored consecutively
+     */
+    cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
+    newv = int128_make128(new_hi, new_lo);
 
     if (parallel) {
 #ifndef CONFIG_ATOMIC128
-- 
2.7.4
