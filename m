Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8N-0002SV-TH
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8N-0005dd-3f
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:38396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8M-0005cs-SO
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id x17-v6so4974291pfh.5
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:27 -0700
Message-Id: <20180810193129.1556-5-richard.henderson@linaro.org>
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] target/arm: Use FZ not FZ16 for SVE FCVT
 single-half and double-half
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

We were using the wrong flush-to-zero bit for the non-half input.

Fixes: 46d33d1e3c9
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 05ba0518c8..fe7aebdc19 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4093,7 +4093,7 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
 
 static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_sh);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sh);
 }
 
 static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
@@ -4103,7 +4103,7 @@ static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 
 static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_dh);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_dh);
 }
 
 static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
-- 
2.17.1
