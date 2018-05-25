Received: from eggs.gnu.org ([2001:4830:134:3::10]:38417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vc-0001kB-ND
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vY-0008FW-DJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vY-0008Er-3V
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:45 +0200
Message-Id: <20180525081754.29506-5-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 04/13] linux-user: Fix payload size logic in
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180518184715.29833-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dd77f86ea2..d02c16bbc6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1848,6 +1848,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
         /* Payload types which need a different size of payload on
          * the target must adjust tgt_len here.
          */
+        tgt_len = len;
         switch (cmsg->cmsg_level) {
         case SOL_SOCKET:
             switch (cmsg->cmsg_type) {
@@ -1857,8 +1858,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
             default:
                 break;
             }
+            break;
         default:
-            tgt_len = len;
             break;
         }
 
-- 
2.14.3
