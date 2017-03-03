Received: from eggs.gnu.org ([2001:4830:134:3::10]:51195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgl-0005ty-FH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgk-0000Lx-L1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpgk-0000Li-EH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:14 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:32 +0000
Message-Id: <1488556233-31246-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 5/6] disas/cris: Avoid unintended sign
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

In the cris disassembler we were using 'unsigned long' to calculate
addresses which are supposed to be 32 bits.  This meant that we might
accidentally sign extend or calculate a value that was outside the 32
bit range of the guest CPU.  Use 'uint32_t' instead so we give the
right answers on 64-bit hosts.

(Spotted by Coverity, CID 1005402, 1005403.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/cris.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 8a1daf9..30217f1 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -2009,7 +2009,7 @@ print_with_operands (const struct cris_opcode *opcodep,
       case 'n':
 	{
 	  /* Like N but pc-relative to the start of the insn.  */
-	  unsigned long number
+	  uint32_t number
 	    = (buffer[2] + buffer[3] * 256 + buffer[4] * 65536
 	       + buffer[5] * 0x1000000 + addr);
 
@@ -2201,7 +2201,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 		      {
 			/* It's [pc+].  This cannot possibly be anything
 			   but an address.  */
-			unsigned long number
+			uint32_t number
 			  = prefix_buffer[2] + prefix_buffer[3] * 256
 			  + prefix_buffer[4] * 65536
 			  + prefix_buffer[5] * 0x1000000;
-- 
2.7.4
