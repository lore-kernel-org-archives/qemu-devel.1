Received: from eggs.gnu.org ([2001:4830:134:3::10]:37629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboW-0006cV-Rm
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboU-00036o-Py
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:40 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:45338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboU-00036O-KL
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:38 -0400
Received: by mail-pg1-x534.google.com with SMTP id f1-v6so2050391pgq.12
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:23 -0700
Message-Id: <20180809034033.10579-2-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] target/arm: Fix sign of
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

The normal vector element is sign-extended before
comparing with the wide vector element.

Cc: qemu-stable@nongnu.org (3.0.1)
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 54795c9194..9bd0694d55 100644
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
2.17.1
