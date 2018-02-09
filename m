Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sw-00017J-Ei
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sv-00029f-Ld
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sv-00023a-FC
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Su-0002eu-Ag
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:36 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:03:13 +0000
Message-Id: <20180209110314.11766-30-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/30] target/arm/translate.c: Fix missing
 'break' for TT insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The code where we added the TT instruction was accidentally
missing a 'break', which meant that after generating the code
to execute the TT we would fall through to 'goto illegal_op'
and generate code to take an UNDEF insn.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180206103941.13985-1-peter.maydell@linaro.org
---
 target/arm/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a8c13d3758..1270022289 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9925,6 +9925,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         tcg_temp_free_i32(addr);
                         tcg_temp_free_i32(op);
                         store_reg(s, rd, ttresp);
+                        break;
                     }
                     goto illegal_op;
                 }
-- 
2.16.1
