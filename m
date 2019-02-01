Received: from eggs.gnu.org ([209.51.188.92]:59182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMH-0008J5-Sf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMC-0003m4-A4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:01 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMB-0003ae-UY
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:56 -0500
Received: by mail-wr1-x430.google.com with SMTP id b4so751821wrq.10
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.37
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:40 +0000
Message-Id: <20190201160653.13829-35-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 34/47] target/arm/translate-a64: Fix mishandling
 of size in FCMLA decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190129140411.682-3-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d46ea9f64e7..b864ac7a69f 100644
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
