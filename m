Received: from eggs.gnu.org ([209.51.188.92]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bk-0004K0-Eg
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bi-0002dZ-EI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Bi-0002Xu-1Y
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id 96so11363648wrb.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:26:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:26:26 +0000
Message-Id: <20190125182626.9221-8-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-1-peter.maydell@linaro.org>
References: <20190125182626.9221-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/7] target/arm/translate-a64: Don't
 underdecode SDOT and UDOT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Desnogues <laurent.desnogues@gmail.com>

In the AdvSIMD scalar x indexed element and vector x indexed element
encoding group, the SDOT and UDOT instructions are vector only,
and their opcode is unallocated in the scalar group. Correctly
UNDEF this unallocated encoding.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 474d9bfb5f0..30bc2412fc0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12641,7 +12641,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x0e: /* SDOT */
     case 0x1e: /* UDOT */
-        if (size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
+        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
             unallocated_encoding(s);
             return;
         }
-- 
2.20.1
