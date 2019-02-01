Received: from eggs.gnu.org ([209.51.188.92]:58912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0008EF-9d
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003hS-Rr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003Zj-Gl
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id t27so7662186wra.6
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:37 +0000
Message-Id: <20190201160653.13829-32-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/47] target/arm/translate-a64: Don't
 underdecode SDOT and UDOT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the AdvSIMD scalar x indexed element and vector x indexed element
encoding group, the SDOT and UDOT instructions are vector only,
and their opcode is unallocated in the scalar group. Correctly
UNDEF this unallocated encoding.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-8-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6c4b20daf2c..07fa0523935 100644
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
