Received: from eggs.gnu.org ([2001:4830:134:3::10]:53052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2Q3R-0006D6-62
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2Q3Q-000587-4a
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:32:29 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d2Q3P-00057l-Uy
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:32:28 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 24 Apr 2017 00:32:16 +0200
Message-Id: <20170423223216.17856-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH] target-s390x: Mask the SIGP order_code to 8bit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Philipp Kern <phil@philkern.de>, Aurelien Jarno <aurelien@aurel32.net>

From: Philipp Kern <phil@philkern.de>

According to "CPU Signaling and Response", "Signal-Processor Orders",
the order field is bit position 56-63. Without this, the Linux
guest kernel is sometimes unable to stop emulation and enters
an infinite loop of "XXX unknown sigp: 0xffffffff00000005".

Signed-off-by: Philipp Kern <phil@philkern.de>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This patch has been sent by Philipp Kern a lot of time ago, and it seems
has been lost. I am resending it, as it is still useful.

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 3bf09ea222..4946b56ab3 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -534,7 +534,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
     /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered register"
        as parameter (input). Status (output) is always R1. */
 
-    switch (order_code) {
+    switch (order_code & 0xff) {
     case SIGP_SET_ARCH:
         /* switch arch */
         break;
-- 
2.11.0
