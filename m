Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePqQI-0001b6-0O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePqQG-0002SH-OQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:53:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePqQG-0002MG-H8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:53:08 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 13:52:55 +0000
Message-Id: <1513345976-22958-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513345976-22958-1-git-send-email-peter.maydell@linaro.org>
References: <1513345976-22958-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: Fix length calculations in
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
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Bruno Haible <bruno@clisp.org>

The handling of length calculations in host_to_target_cmsg()
was rather confused:
 * when checking for whether the target cmsg header fit in
   the remaining buffer, we were using the host struct size,
   not the target size
 * we were setting tgt_len to "target payload + header length"
   but then using it as if it were the target payload length alone
 * in various message type cases we weren't handling the possibility
   that host or target buffers were truncated

Fix these problems. The second one in particular is liable
to result in us overrunning the guest provided buffer,
since we will try to convert more data than is actually
present.

Fixes: https://bugs.launchpad.net/qemu/+bug/1701808
Reported-by: Bruno Haible  <bruno@clisp.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116..a1b9772 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1782,7 +1782,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
          * to the guest via the CTRUNC bit), unlike truncation
          * in target_to_host_cmsg, which is a QEMU bug.
          */
-        if (msg_controllen < sizeof(struct cmsghdr)) {
+        if (msg_controllen < sizeof(struct target_cmsghdr)) {
             target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
             break;
         }
@@ -1794,8 +1794,6 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
         }
         target_cmsg->cmsg_type = tswap32(cmsg->cmsg_type);
 
-        tgt_len = TARGET_CMSG_LEN(len);
-
         /* Payload types which need a different size of payload on
          * the target must adjust tgt_len here.
          */
@@ -1809,12 +1807,13 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 break;
             }
         default:
+            tgt_len = len;
             break;
         }
 
-        if (msg_controllen < tgt_len) {
+        if (msg_controllen < TARGET_CMSG_LEN(tgt_len)) {
             target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
-            tgt_len = msg_controllen;
+            tgt_len = msg_controllen - sizeof(struct target_cmsghdr);
         }
 
         /* We must now copy-and-convert len bytes of payload
@@ -1875,6 +1874,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 uint32_t *v = (uint32_t *)data;
                 uint32_t *t_int = (uint32_t *)target_data;
 
+                if (len != sizeof(uint32_t) ||
+                    tgt_len != sizeof(uint32_t)) {
+                    goto unimplemented;
+                }
                 __put_user(*v, t_int);
                 break;
             }
@@ -1888,6 +1891,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 struct errhdr_t *target_errh =
                     (struct errhdr_t *)target_data;
 
+                if (len != sizeof(struct errhdr_t) ||
+                    tgt_len != sizeof(struct errhdr_t)) {
+                    goto unimplemented;
+                }
                 __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
                 __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
                 __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
@@ -1911,6 +1918,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 uint32_t *v = (uint32_t *)data;
                 uint32_t *t_int = (uint32_t *)target_data;
 
+                if (len != sizeof(uint32_t) ||
+                    tgt_len != sizeof(uint32_t)) {
+                    goto unimplemented;
+                }
                 __put_user(*v, t_int);
                 break;
             }
@@ -1924,6 +1935,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                 struct errhdr6_t *target_errh =
                     (struct errhdr6_t *)target_data;
 
+                if (len != sizeof(struct errhdr6_t) ||
+                    tgt_len != sizeof(struct errhdr6_t)) {
+                    goto unimplemented;
+                }
                 __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
                 __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
                 __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
@@ -1950,8 +1965,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
             }
         }
 
-        target_cmsg->cmsg_len = tswapal(tgt_len);
-        tgt_space = TARGET_CMSG_SPACE(len);
+        target_cmsg->cmsg_len = tswapal(TARGET_CMSG_LEN(tgt_len));
+        tgt_space = TARGET_CMSG_SPACE(tgt_len);
         if (msg_controllen < tgt_space) {
             tgt_space = msg_controllen;
         }
-- 
2.7.4
