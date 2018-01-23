Received: from eggs.gnu.org ([2001:4830:134:3::10]:43436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs1-00075X-W8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzrx-0002Ls-RO
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:18 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzrx-0002JK-FQ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:47:58 +0100
Message-Id: <20180123144807.5618-5-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 04/13] linux-user: Don't use CMSG_ALIGN(sizeof
 struct cmsghdr)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

The Linux struct cmsghdr is already guaranteed to be sufficiently
aligned that CMSG_ALIGN(sizeof struct cmsghdr) is always equal
to sizeof struct cmsghdr. Stop doing the unnecessary alignment
arithmetic for host and target cmsghdr.

This follows kernel commit 1ff8cebf49ed9e9ca2 and brings our
TARGET_CMSG_* macros back into line with the kernel ones,
as well as making them easier to understand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1513345976-22958-3-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 4 ++--
 linux-user/syscall_defs.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a1b9772a85..39553c81b6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1692,7 +1692,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
         void *target_data = TARGET_CMSG_DATA(target_cmsg);
 
         int len = tswapal(target_cmsg->cmsg_len)
-                  - TARGET_CMSG_ALIGN(sizeof (struct target_cmsghdr));
+            - sizeof(struct target_cmsghdr);
 
         space += CMSG_SPACE(len);
         if (space > msgh->msg_controllen) {
@@ -1773,7 +1773,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
         void *data = CMSG_DATA(cmsg);
         void *target_data = TARGET_CMSG_DATA(target_cmsg);
 
-        int len = cmsg->cmsg_len - CMSG_ALIGN(sizeof (struct cmsghdr));
+        int len = cmsg->cmsg_len - sizeof(struct cmsghdr);
         int tgt_len, tgt_space;
 
         /* We never copy a half-header but may copy half-data;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index bec3680b94..a35c52a60a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -303,9 +303,9 @@ struct target_cmsghdr {
                                __target_cmsg_nxthdr(mhdr, cmsg, cmsg_start)
 #define TARGET_CMSG_ALIGN(len) (((len) + sizeof (abi_long) - 1) \
                                & (size_t) ~(sizeof (abi_long) - 1))
-#define TARGET_CMSG_SPACE(len) (TARGET_CMSG_ALIGN (len) \
-                               + TARGET_CMSG_ALIGN (sizeof (struct target_cmsghdr)))
-#define TARGET_CMSG_LEN(len)   (TARGET_CMSG_ALIGN (sizeof (struct target_cmsghdr)) + (len))
+#define TARGET_CMSG_SPACE(len) (sizeof(struct target_cmsghdr) + \
+                                TARGET_CMSG_ALIGN(len))
+#define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
 
 static __inline__ struct target_cmsghdr *
 __target_cmsg_nxthdr(struct target_msghdr *__mhdr,
-- 
2.14.3
