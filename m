Received: from eggs.gnu.org ([2001:4830:134:3::10]:53922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJkPQ-0005Oe-P9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJkPP-0007W1-Tj
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:47:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJkPP-0007VJ-N9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:47:19 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 19:47:15 +0100
Message-Id: <20180518184715.29833-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Fix payload size logic in
 host_to_target_cmsg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Coverity points out that there's a missing break in the switch in
host_to_target_cmsg() where we update tgt_len for
cmsg_level/cmsg_type combinations which require a different length
for host and target (CID 1385425).  To avoid duplicating the default
case (target length same as host) in both switches, set that before
the switch so that only the cases which want to override it need any
code.

This fixes a bug where we would have used the wrong length
for SOL_SOCKET/SO_TIMESTAMP messages where the target and
host have differently sized 'struct timeval' (ie one is 32
bit and the other is 64 bit).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index af8603f1b7..88d166cdff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1825,6 +1825,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
         /* Payload types which need a different size of payload on
          * the target must adjust tgt_len here.
          */
+        tgt_len = len;
         switch (cmsg->cmsg_level) {
         case SOL_SOCKET:
             switch (cmsg->cmsg_type) {
@@ -1834,8 +1835,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
             default:
                 break;
             }
+            break;
         default:
-            tgt_len = len;
             break;
         }
 
-- 
2.17.0
