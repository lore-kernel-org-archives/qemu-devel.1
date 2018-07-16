Received: from eggs.gnu.org ([2001:4830:134:3::10]:50661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aY-0008U4-NO
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aX-0005ZS-O1
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aX-0005YP-F9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aU-0000ym-D7
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:02 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:53 +0100
Message-Id: <20180716164300.6731-2-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/8] target/arm: Fix LD1W and LDFF1W (scalar
 plus vector)
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

'I' was being double-incremented; correctly within the inner loop
and incorrectly within the outer loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180711103957.3040-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a03ca773542..54795c91945 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4459,7 +4459,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
     intptr_t i, oprsz = simd_oprsz(desc);                               \
     unsigned scale = simd_data(desc);                                   \
     uintptr_t ra = GETPC();                                             \
-    for (i = 0; i < oprsz; i++) {                                       \
+    for (i = 0; i < oprsz; ) {                                          \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
         do {                                                            \
             TYPEM m = 0;                                                \
@@ -4540,7 +4540,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
     uintptr_t ra = GETPC();                                             \
     bool first = true;                                                  \
     mmap_lock();                                                        \
-    for (i = 0; i < oprsz; i++) {                                       \
+    for (i = 0; i < oprsz; ) {                                          \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
         do {                                                            \
             TYPEM m = 0;                                                \
-- 
2.17.1
