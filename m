Received: from eggs.gnu.org ([2001:4830:134:3::10]:52596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AN-0002cy-4u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AJ-0003lP-Q0
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:03 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:57332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AJ-0003ku-K5
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:59 -0400
Received: by mail-pg0-x22b.google.com with SMTP id m18so7344105pgd.13
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:51 -0700
Message-Id: <20171016172609.23422-33-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 32/50] target/sh4: check CF_PARALLEL instead
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
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
