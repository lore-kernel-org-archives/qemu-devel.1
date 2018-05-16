Received: from eggs.gnu.org ([2001:4830:134:3::10]:41987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjn-0004Vs-7T
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjm-00056Q-CS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:11 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIyjm-00056C-6e
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:10 -0400
Received: by mail-pl0-x232.google.com with SMTP id u6-v6so664517pls.9
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 08:53:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 08:52:31 -0700
Message-Id: <20180516155243.16937-17-richard.henderson@linaro.org>
In-Reply-To: <20180516155243.16937-1-richard.henderson@linaro.org>
References: <20180516155243.16937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 16/28] target/m68k: Use floatX_silence_nan when
 we have already checked for SNaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index d093997219..b45a5e8690 100644
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
