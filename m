Received: from eggs.gnu.org ([2001:4830:134:3::10]:37476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0f-0008Gt-Tl
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0e-0006I6-V4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eGq0e-0006HX-N4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0d-0006Ne-Li
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:37:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:37:22 +0000
Message-Id: <1511199444-17922-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
References: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] arm: check regime, not current state,
 for ATS write PAR format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In do_ats_write(), rather than using extended_addresses_enabled() to
decide whether the value we get back from get_phys_addr() is a 64-bit
format PAR or a 32-bit one, use arm_s1_regime_using_lpae_format().

This is not really the correct answer, because the PAR format
depends on the AT instruction being used, not just on the
translation regime. However getting this correct requires a
significant refactoring, so that get_phys_addr() returns raw
information about the fault which the caller can then assemble
into a suitable FSR/PAR/syndrome for its purposes, rather than
get_phys_addr() returning a pre-formatted FSR.

However this change at least improves the situation by making
the PAR work correctly for address translation operations done
at AArch64 EL2 on the EL2 translation regime. In particular,
this is necessary for Xen to be able to run in our emulation,
so this seems like a safer interim fix given that we are in freeze.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Message-id: 1509719814-6191-1-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 35c5bd6..91a9300 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2169,7 +2169,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
     ret = get_phys_addr(env, value, access_type, mmu_idx, &phys_addr, &attrs,
                         &prot, &page_size, &fsr, &fi, &cacheattrs);
-    if (extended_addresses_enabled(env)) {
+    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
         /* fsr is a DFSR/IFSR value for the long descriptor
          * translation table format, but with WnR always clear.
          * Convert it to a 64-bit PAR.
-- 
2.7.4
