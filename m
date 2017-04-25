Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1d2ytV-0002Na-PX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1d2ytR-0002Q0-LX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:44:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53367 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1d2ytR-0002PJ-EY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:44:29 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 25 Apr 2017 13:44:49 +0200
Message-Id: <1493120689-120426-1-git-send-email-agraf@suse.de>
In-Reply-To: <1493120560-117434-1-git-send-email-agraf@suse.de>
References: <1493120560-117434-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PULL 1/2] target-s390x: Mask the SIGP order_code to
 8bit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philipp Kern <phil@philkern.de>

From: Philipp Kern <phil@philkern.de>

According to "CPU Signaling and Response", "Signal-Processor Orders",
the order field is bit position 56-63. Without this, the Linux
guest kernel is sometimes unable to stop emulation and enters
an infinite loop of "XXX unknown sigp: 0xffffffff00000005".

Signed-off-by: Philipp Kern <phil@philkern.de>
Reviewed-by: Thomas Huth <thuth@tuxfamily.org>
[agraf: add comment according to email]
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 target/s390x/misc_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 93b0e61..83d3894 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -515,7 +515,8 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
     /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered register"
        as parameter (input). Status (output) is always R1. */
 
-    switch (order_code) {
+    /* sigp contains the order code in bit positions 56-63, mask it here. */
+    switch (order_code & 0xff) {
     case SIGP_SET_ARCH:
         /* switch arch */
         break;
-- 
1.8.5.6
