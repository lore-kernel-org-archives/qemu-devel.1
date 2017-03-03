Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpge-0005nY-H8
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgd-0000Ku-KN
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpgd-0000Jj-EX
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:07 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:29 +0000
Message-Id: <1488556233-31246-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 2/6] disas/i386: Avoid NULL pointer
 dereference in error case
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

In a code path where we hit an internal disassembler error, execution
would subsequently attempt to dereference a NULL pointer.  This
should never happen, but avoid the crash.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/i386.c b/disas/i386.c
index 07f871f..f1e376c 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -4043,7 +4043,7 @@ print_insn (bfd_vma pc, disassemble_info *info)
 	    }
 	}
 
-      if (putop (dp->name, sizeflag) == 0)
+      if (dp->name != NULL && putop (dp->name, sizeflag) == 0)
         {
 	  for (i = 0; i < MAX_OPERANDS; ++i)
 	    {
-- 
2.7.4
