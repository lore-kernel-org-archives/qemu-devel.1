Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdT-0004ue-EN
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdQ-0002yl-PK
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:43 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdQ-0002yU-Ig
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:40 -0400
Received: by mail-pf0-x241.google.com with SMTP id p14-v6so3429981pfh.9
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:43:02 -0700
Message-Id: <20180512004311.9299-19-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/27] target/m68k: Use floatX_silence_nan
 when we have already checked for SNaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index e41b07d042..6ec227e20f 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -31,13 +31,14 @@ static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
 {
     if (floatx80_is_signaling_nan(a, status)) {
         float_raise(float_flag_invalid, status);
+        a = floatx80_silence_nan(a, status);
     }
 
     if (status->default_nan_mode) {
         return floatx80_default_nan(status);
     }
 
-    return floatx80_maybe_silence_nan(a, status);
+    return a;
 }
 
 /*----------------------------------------------------------------------------
-- 
2.17.0
