Received: from eggs.gnu.org ([2001:4830:134:3::10]:35232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZM-0001dP-9L
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZL-0001AQ-9g
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZL-0001AC-2I
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZK-0003ql-7X
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:20:55 +0000
Message-Id: <1482852077-19397-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/25] Correct value of ARM Cortex-A8 MVFR1
 register.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julian Brown <julian@codesourcery.com>

The value of the MVFR1 (Media and VFP Feature Register 1) register for
the Cortex-A8 appears to be incorrect (according to the TRM, DDI0344K),
with the "full denormal arithmetic" and "propagation of NaN" fields
holding both 0 instead of both 1.

I had a go tracing the history of the use of this value, and it seems
it's always just been wrong in QEMU: maybe it was derived from early
documentation, or guessed based on the use of a "VFP Lite" implementation
in the Cortex-A8.

Depending on the startup/early-boot code in use, this can manifest as
failure to perform denormal arithmetic properly: in our case, selecting
a Cortex-A8 CPU when using QEMU as an instruction-set simulator for
bare-metal GCC testing caused tests using denormal arithmetic to
fail. Problems might be masked (or not occur) when using a full OS kernel
with suitable trap handlers (I'm not sure).

Signed-off-by: Julian Brown <julian@codesourcery.com>
Message-id: 1481130858-31767-1-git-send-email-julian@codesourcery.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 99f0dbe..98e2c68 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1055,7 +1055,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->midr = 0x410fc080;
     cpu->reset_fpsid = 0x410330c0;
     cpu->mvfr0 = 0x11110222;
-    cpu->mvfr1 = 0x00011100;
+    cpu->mvfr1 = 0x00011111;
     cpu->ctr = 0x82048004;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
-- 
2.7.4
