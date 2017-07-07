Received: from eggs.gnu.org ([2001:4830:134:3::10]:34466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXVb-0006Iv-FF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXVa-0002ah-AB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:57:39 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:35396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTXVa-0002Ze-2F
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:57:38 -0400
Received: by mail-oi0-x236.google.com with SMTP id 191so33791730oii.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 10:57:37 -0700 (PDT)
MIME-Version: 1.0
Sender: rth7680@gmail.com
In-Reply-To: <20170707163826.22631-1-rth@twiddle.net>
References: <3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<20170707163826.22631-1-rth@twiddle.net>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 7 Jul 2017 07:57:36 -1000
Message-ID: <CAD-reDZ5RUnTm3JZG7rQ_dDSE41KJ_HoARQuiCLpT0wkdcowAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Fwd: [PATCH v2.5] fixup! linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Bah.  Should have gone to the list as well.

r~
---------- Forwarded message ----------
From: Richard Henderson <rth@twiddle.net>
Date: Fri, Jul 7, 2017 at 6:38 AM
Subject: [PATCH v2.5] fixup! linux-user/sh4: Notice gUSA regions during
signal delivery
To: glaubitz@physik.fu-berlin.de
Cc: laurent@vivier.eu


This fixes the signal delivery problem reported.  I'll fold this into
the patch properly for v3, but this will allow reasonable testing to
proceed in the meantime.

r~
---
 linux-user/signal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 8c0b851..d68bd26 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3476,13 +3476,18 @@ static abi_ulong get_sigframe(struct
target_sigaction *ka,
    translate such sequences differently in a parallel context.  */
 static void unwind_gusa(CPUSH4State *regs)
 {
-    /* If the stack pointer is sufficiently negative ... */
-    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u
-        /* ... and we haven't completed the sequence ... */
-        && regs->pc < regs->gregs[0]) {
+    /* If the stack pointer is sufficiently negative, and we haven't
+       completed the sequence, then reset to the entry to the region.  */
+    /* ??? The SH4 kernel checks for and address above 0xC0000000.
+       However, the page mappings in qemu linux-user aren't as restricted
+       and we wind up with the normal stack mapped above 0xF0000000.
+       That said, there is no reason why the kernel should be allowing
+       a gUSA region that spans 1GB.  Use a tighter check here, for what
+       can actually be enabled by the immediate move.  */
+    if (regs->gregs[15] >= -128u && regs->pc < regs->gregs[0]) {
         /* Reset the PC to before the gUSA region, as computed from
-           R0 = region end, SP = -(region size), plus one more insn
-           that actually sets SP to the region size.  */
+           R0 = region end, SP = -(region size), plus one more for the
+           insn that actually initializes SP to the region size.  */
         regs->pc = regs->gregs[0] + regs->gregs[15] - 2;

         /* Reset the SP to the saved version in R1.  */
--
2.9.4
