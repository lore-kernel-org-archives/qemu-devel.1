Received: from eggs.gnu.org ([2001:4830:134:3::10]:46636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpTh-0005b6-Fi
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpTb-0002uF-W3
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:50:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpTb-0002rd-PT
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:50:39 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:33 +0000
Message-Id: <1488556233-31246-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 6/6] disas/arm: Avoid unintended sign
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

When assembling 'given' from the instruction bytes, C's integer
promotion rules mean we may promote an unsigned char to a signed
integer before shifting it, and then sign extend to a 64-bit long,
which can set the high bits of the long.  The code doesn't in fact
care about the high bits if the long is 64 bits, but this is
surprising, so don't do it.

(Spotted by Coverity, CID 1005404.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Arguably 'given' should be uint32_t here rather than 'long', but a
small change to placate Coverity seemed wiser than a wholesale change
of the type of the 'given' variables/arguments through the whole
file, since this is 3rd-party code that's known to work.
---
 disas/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/arm.c b/disas/arm.c
index 93c6503..27396dd 100644
--- a/disas/arm.c
+++ b/disas/arm.c
@@ -3901,9 +3901,9 @@ print_insn_arm (bfd_vma pc, struct disassemble_info *info)
 
       status = info->read_memory_func (pc, (bfd_byte *)b, 4, info);
       if (little)
-	given = (b[0]) | (b[1] << 8) | (b[2] << 16) | (b[3] << 24);
+	given = (b[0]) | (b[1] << 8) | (b[2] << 16) | ((unsigned)b[3] << 24);
       else
-	given = (b[3]) | (b[2] << 8) | (b[1] << 16) | (b[0] << 24);
+	given = (b[3]) | (b[2] << 8) | (b[1] << 16) | ((unsigned)b[0] << 24);
     }
   else
     {
-- 
2.7.4
