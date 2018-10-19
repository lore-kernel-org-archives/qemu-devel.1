Received: from eggs.gnu.org ([2001:4830:134:3::10]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6z-0002RW-54
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6y-0003iu-Dv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY6y-0002bn-6e
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:56 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6K-0006ol-Pn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:30 +0100
Message-Id: <20181019165735.22511-41-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/45] target/arm: Promote consecutive memory
 ops for aa32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

For a sequence of loads or stores from a single register,
little-endian operations can be promoted to an 8-byte op.
This can reduce the number of operations by a factor of 8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011205206.3552-20-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7f209b4ae2b..83e88242082 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5011,6 +5011,16 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
         if (size == 3 && (interleave | spacing) != 1) {
             return 1;
         }
+        /* For our purposes, bytes are always little-endian.  */
+        if (size == 0) {
+            endian = MO_LE;
+        }
+        /* Consecutive little-endian elements from a single register
+         * can be promoted to a larger little-endian operation.
+         */
+        if (interleave == 1 && endian == MO_LE) {
+            size = 3;
+        }
         tmp64 = tcg_temp_new_i64();
         addr = tcg_temp_new_i32();
         tmp2 = tcg_const_i32(1 << size);
-- 
2.19.1
