Received: from eggs.gnu.org ([2001:4830:134:3::10]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmnAk-00082O-Pw
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 14:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmnAf-0000qA-UU
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 14:59:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:63542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cmnAf-0000q4-Lh
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 14:59:21 -0500
Date: Sat, 11 Mar 2017 20:59:06 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20170311195906.GA13187@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: Add missing IP_TOS,
 IPV6_TCLASS and IPV6_RECVTCLASS sockopts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Richard Henderson <rth@twiddle.net>

When running the nslookup or dig command with IPv6, the following qemu
warnings will be shown:

Unsupported ancillary data: 0/1
Unsupported setsockopt level=41 optname=67
Unsupported setsockopt level=41 optname=66
Unsupported ancillary data: 41/67

This patch adds the missing code to quiet those warnings.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 03ed370..e5f55e9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1713,6 +1713,18 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             __get_user(cred->pid, &target_cred->pid);
             __get_user(cred->uid, &target_cred->uid);
             __get_user(cred->gid, &target_cred->gid);
+        } else if (cmsg->cmsg_level == SOL_IP
+               &&  cmsg->cmsg_type == IP_TOS) {
+            char *s = (char *)data;
+            char *t = (char *)target_data;
+
+            __get_user(*s, t);
+        } else if (cmsg->cmsg_level == SOL_IPV6
+               &&  cmsg->cmsg_type == IPV6_TCLASS) {
+            int32_t *s = (int32_t *)data;
+            int32_t *t = (int32_t *)target_data;
+
+            __get_user(*s, t);
         } else {
             gemu_log("Unsupported ancillary data: %d/%d\n",
                                         cmsg->cmsg_level, cmsg->cmsg_type);
@@ -1848,6 +1860,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         case SOL_IP:
             switch (cmsg->cmsg_type) {
+            case IP_TOS:
             case IP_TTL:
             {
                 uint32_t *v = (uint32_t *)data;
@@ -2902,6 +2915,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_RECVHOPLIMIT:
         case IPV6_2292HOPLIMIT:
         case IPV6_CHECKSUM:
+        case IPV6_RECVTCLASS:
+        case IPV6_TCLASS:
             val = 0;
             if (optlen < sizeof(uint32_t)) {
                 return -TARGET_EINVAL;
