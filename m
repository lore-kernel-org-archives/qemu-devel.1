Received: from eggs.gnu.org ([2001:4830:134:3::10]:52301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQfGe-0006Dp-8H
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQfGd-0003SV-DH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:06:04 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 19:05:59 +0000
Message-Id: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] disas/cris.c: Fix Coverity warning about
 unchecked NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Coverity (CID 1005689) warns that we don't check that
spec_reg_info() returned non-NULL before dereferencing.
Add the check, though as the comment notes this is
a can't-really-happen case because the earlier constraint
matching should have ruled out the "unknown reg" case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/cris.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/cris.c b/disas/cris.c
index 08161d1..8a1daf9 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -2490,7 +2490,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 	const struct cris_spec_reg *sregp
 	  = spec_reg_info ((insn >> 12) & 15, disdata->distype);
 
-	if (sregp->name == NULL)
+	if (sregp == NULL || sregp->name == NULL)
 	  /* Should have been caught as a non-match earlier.  */
 	  *tp++ = '?';
 	else
-- 
2.7.4
