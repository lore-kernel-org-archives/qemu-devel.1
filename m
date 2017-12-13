Received: from eggs.gnu.org ([2001:4830:134:3::10]:46974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eP54W-00020Q-Uo
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eP54V-0006SW-MX
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:19:32 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eP54V-0006PG-Et
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:19:31 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 11:19:19 +0000
Message-Id: <1513163959-17545-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/i386: Fix handling of VEX prefixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Alexandro Sanchez Bach <alexandro@phi.nz>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

In commit e3af7c788b73a6495eb9d94992ef11f6ad6f3c56 we
replaced direct calls to to cpu_ld*_code() with calls
to the x86_ld*_code() wrappers which incorporate an
advance of s->pc. Unfortunately we didn't notice that
in one place the old code was deliberately not incrementing
s->pc:

@@ -4501,7 +4528,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             static const int pp_prefix[4] = {
                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
             };
-            int vex3, vex2 = cpu_ldub_code(env, s->pc);
+            int vex3, vex2 = x86_ldub_code(env, s);

             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,

This meant we were mishandling this set of instructions.
Remove the manual advance of s->pc for the "is VEX" case
(which is now done by x86_ldub_code()) and instead rewind
PC in the case where we decide that this isn't really VEX.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
---
I checked the rest of the changes in e3af7c788b73a and
I don't think we made this mistake anywhere else.
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 088a9d9..ed5b69d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4547,9 +4547,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
                    otherwise the instruction is LES or LDS.  */
+                s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
                 break;
             }
-            s->pc++;
 
             /* 4.1.1-4.1.3: No preceding lock, 66, f2, f3, or rex prefixes. */
             if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ
-- 
2.7.4
