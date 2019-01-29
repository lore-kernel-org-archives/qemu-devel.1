Received: from eggs.gnu.org ([209.51.188.92]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU0A-0004ev-NY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU00-0000Cw-J3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:30 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goTzx-0008Qo-AE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:22 -0500
Received: by mail-wr1-x441.google.com with SMTP id x10so22169000wrs.8
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:04:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 14:04:10 +0000
Message-Id: <20190129140411.682-2-peter.maydell@linaro.org>
In-Reply-To: <20190129140411.682-1-peter.maydell@linaro.org>
References: <20190129140411.682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/arm/translate-a64: Fix FCMLA
 decoding error
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

The FCMLA (by element) instruction exists in the
"vector x indexed element" encoding group, but not in
the "scalar x indexed element" group. Correctly UNDEF
the unallocated encodings.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 30bc2412fc0..a7b999d2b5a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12650,7 +12650,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
     case 0x17: /* FCMLA #270 */
-        if (!dc_isar_feature(aa64_fcma, s)) {
+        if (is_scalar || !dc_isar_feature(aa64_fcma, s)) {
             unallocated_encoding(s);
             return;
         }
-- 
2.20.1
