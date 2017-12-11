Received: from eggs.gnu.org ([2001:4830:134:3::10]:36209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eOQER-0005b5-LZ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eOQEN-0000Yb-SS
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:43:03 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eOQEN-0000T2-Li
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:42:59 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 15:42:44 +0000
Message-Id: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.11?] target/arm: Generate UNDEF for
 32-bit Thumb2 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>

The refactoring of commit 296e5a0a6c3935 has a nasty bug:
it accidentally dropped the generation of code to raise
the UNDEF exception when disas_thumb2_insn() returns nonzero.
This means that 32-bit Thumb2 instruction patterns that
ought to UNDEF just act like nops instead. This is likely
to break any number of things, including the kernel's "disable
the FPU and use the UNDEF exception to identify when to turn
it back on again" trick.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is the smallest possible fix that will correct the
bug, for possible inclusion in 2.11; for 2.12 we should
fix the asymmetry where disas_thumb() generates its own
exception-raising code but disas_thumb2() wants the caller
to do it. (This asymmetry is why we didn't notice the
problem in code review.)

I'm not sure whether this should go into 2.11 or not --
this time last week it would have been an easy "yes".

---
 target/arm/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4afb0c8..f120932 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12245,7 +12245,10 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (is_16bit) {
         disas_thumb_insn(dc, insn);
     } else {
-        disas_thumb2_insn(dc, insn);
+        if (disas_thumb2_insn(dc, insn)) {
+            gen_exception_insn(dc, 4, EXCP_UDEF, syn_uncategorized(),
+                               default_exception_el(dc));
+        }
     }
 
     /* Advance the Thumb condexec condition.  */
-- 
2.7.4
