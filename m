Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbK-0006JK-9H
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbJ-0007pJ-Gb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:14 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gbJ-0007p0-Au
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:13 -0400
Received: by mail-pf0-x243.google.com with SMTP id z11so13060576pfk.4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:21:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:20:03 -0700
Message-Id: <20171020232023.15010-33-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 32/52] target/sh4: check CF_PARALLEL instead
 of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 33176c9926..f918bae978 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -521,7 +521,7 @@ static void _decode_opc(DisasContext * ctx)
         /* Detect the start of a gUSA region.  If so, update envflags
            and end the TB.  This will allow us to see the end of the
            region (stored in R0) in the next TB.  */
-        if (B11_8 == 15 && B7_0s < 0 && parallel_cpus) {
+        if (B11_8 == 15 && B7_0s < 0 && (tb_cflags(ctx->tb) & CF_PARALLEL)) {
             ctx->envflags = deposit32(ctx->envflags, GUSA_SHIFT, 8, B7_0s);
             ctx->bstate = BS_STOP;
         }
-- 
2.13.6
