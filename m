Received: from eggs.gnu.org ([2001:4830:134:3::10]:46179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en5Xa-0005OQ-Pu
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en5Xa-0001kC-4R
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:46 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en5XZ-0001k2-Up
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:46 -0500
Received: by mail-pl0-x244.google.com with SMTP id f4so3351328plr.10
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 08:40:45 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	a6sm29152324pfi.99.2018.02.17.08.40.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 08:40:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 08:40:37 -0800
Message-Id: <20180217164037.15727-3-richard.henderson@linaro.org>
In-Reply-To: <20180217164037.15727-1-richard.henderson@linaro.org>
References: <20180217164037.15727-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] tcg: Add missing tcg_can_emit_vec_op check
 in tcg_gen_gvec_2s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This lead to an assertion failure for 64-bit vector multiply,
which is not available in the AVX instruction set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 29f9cf34b4..432e577c35 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -979,12 +979,15 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 
     type = 0;
     if (g->fniv) {
-        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
+        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
+            && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece)) {
             type = TCG_TYPE_V256;
-        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
+        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
+                   && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece)) {
             type = TCG_TYPE_V128;
         } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
-               && check_size_impl(oprsz, 8)) {
+                   && check_size_impl(oprsz, 8)
+                   && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)) {
             type = TCG_TYPE_V64;
         }
     }
-- 
2.14.3
