Received: from eggs.gnu.org ([2001:4830:134:3::10]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvu-0005Hl-V7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduL-0006sf-Sv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduL-0006oe-An
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduJ-0007PR-Vv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:19:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:12 +0100
Message-Id: <20180814181815.23348-43-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/45] target/arm: Fix sign of
 sve_cmpeq_ppzw/sve_cmpne_ppzw
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

The normal vector element is sign-extended before
comparing with the wide vector element.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180801123111.3595-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 54795c91945..9bd0694d55e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2436,13 +2436,13 @@ uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
 #define DO_CMP_PPZW_S(NAME, TYPE, TYPEW, OP) \
     DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H1_4, 0x1111111111111111ull)
 
-DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, uint8_t,  uint64_t, ==)
-DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, uint16_t, uint64_t, ==)
-DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, uint32_t, uint64_t, ==)
+DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, int8_t,  uint64_t, ==)
+DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, int16_t, uint64_t, ==)
+DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, int32_t, uint64_t, ==)
 
-DO_CMP_PPZW_B(sve_cmpne_ppzw_b, uint8_t,  uint64_t, !=)
-DO_CMP_PPZW_H(sve_cmpne_ppzw_h, uint16_t, uint64_t, !=)
-DO_CMP_PPZW_S(sve_cmpne_ppzw_s, uint32_t, uint64_t, !=)
+DO_CMP_PPZW_B(sve_cmpne_ppzw_b, int8_t,  uint64_t, !=)
+DO_CMP_PPZW_H(sve_cmpne_ppzw_h, int16_t, uint64_t, !=)
+DO_CMP_PPZW_S(sve_cmpne_ppzw_s, int32_t, uint64_t, !=)
 
 DO_CMP_PPZW_B(sve_cmpgt_ppzw_b, int8_t,   int64_t, >)
 DO_CMP_PPZW_H(sve_cmpgt_ppzw_h, int16_t,  int64_t, >)
-- 
2.18.0
