Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEfnj-0006if-8I
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEfne-0002l5-At
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:14:39 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEfne-0002h6-4P
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:14:34 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cEfnY-0002KI-J6 from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:14:28 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Wed, 7 Dec 2016 09:14:18 -0800
Message-ID: <1481130858-31767-1-git-send-email-julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Correct value of ARM Cortex-A8 MVFR1 register.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
---
 target-arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-arm/cpu.c b/target-arm/cpu.c
index 7946877..a609211 100644
--- a/target-arm/cpu.c
+++ b/target-arm/cpu.c
@@ -1109,7 +1109,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->midr = 0x410fc080;
     cpu->reset_fpsid = 0x410330c0;
     cpu->mvfr0 = 0x11110222;
-    cpu->mvfr1 = 0x00011100;
+    cpu->mvfr1 = 0x00011111;
     cpu->ctr = 0x82048004;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
-- 
1.9.1
