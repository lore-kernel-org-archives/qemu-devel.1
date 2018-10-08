Received: from eggs.gnu.org ([2001:4830:134:3::10]:46422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5x-0001Wx-Mr
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5v-0007PD-Tv
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5p-0006yM-8U
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5R-0003lW-Gk
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 15:00:02 +0100
Message-Id: <20181008140004.12612-32-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/33] target/arm: Add v8M stack checks for
 VLDM/VSTM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add the v8M stack checks for the VLDM/VSTM
(aka VPUSH/VPOP) instructions. This code is currently
unreachable because we haven't yet implemented M profile
floating point support, but since the change is simple,
we add it now because otherwise we're likely to forget to
do it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002163556.10279-13-peter.maydell@linaro.org
---
 target/arm/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ef64d2559de..1b4bacb522b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4229,6 +4229,18 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 if (insn & (1 << 24)) /* pre-decrement */
                     tcg_gen_addi_i32(addr, addr, -((insn & 0xff) << 2));
 
+                if (s->v8m_stackcheck && rn == 13 && w) {
+                    /*
+                     * Here 'addr' is the lowest address we will store to,
+                     * and is either the old SP (if post-increment) or
+                     * the new SP (if pre-decrement). For post-increment
+                     * where the old value is below the limit and the new
+                     * value is above, it is UNKNOWN whether the limit check
+                     * triggers; we choose to trigger.
+                     */
+                    gen_helper_v8m_stackcheck(cpu_env, addr);
+                }
+
                 if (dp)
                     offset = 8;
                 else
-- 
2.19.0
