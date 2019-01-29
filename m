Received: from eggs.gnu.org ([209.51.188.92]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU0H-0004ju-6d
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU0G-0000I7-AE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goU0G-0008SY-3w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so18000555wmj.1
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:04:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 14:04:11 +0000
Message-Id: <20190129140411.682-3-peter.maydell@linaro.org>
In-Reply-To: <20190129140411.682-1-peter.maydell@linaro.org>
References: <20190129140411.682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] target/arm/translate-a64: Fix mishandling
 of size in FCMLA decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Desnogues <laurent.desnogues@gmail.com>

In disas_simd_indexed(), for the case of "complex fp", each indexable
element is a complex pair, so the total size is twice that indicated
in the 'size' field in the encoding. We were trying to do this
"double the size" operation with a left shift by 1, but this is
incorrect because the 'size' field is a MO_8/MO_16/MO_32/MO_64
value, and doubling the size should be done by a simple increment.

This meant we were mishandling FCMLA (by element) of values where
the real and imaginary parts are 32-bit floats, and would incorrectly
UNDEF this encoding. (No other insns take this code path, and for
16-bit floats it happens that 1 << 1 and 1 + 1 are both the same).

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a7b999d2b5a..06418f0ac3c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12680,7 +12680,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
     case 2: /* complex fp */
         /* Each indexable element is a complex pair.  */
-        size <<= 1;
+        size += 1;
         switch (size) {
         case MO_32:
             if (h && !is_q) {
-- 
2.20.1
