Received: from eggs.gnu.org ([2001:4830:134:3::10]:53949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cdOhI-00014Z-Cq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cdOhF-0003zi-5g
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:02:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:50184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cdOhE-0003yB-QH
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:02:09 -0500
Date: Mon, 13 Feb 2017 23:01:31 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20170213220131.GA10356@ls3530.fritz.box>
References: <20170211221148.GA2924@ls3530.fritz.box>
	<ed7dc116-ef8a-bdba-c817-b36ebbfbf637@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed7dc116-ef8a-bdba-c817-b36ebbfbf637@amsat.org>
Subject: [Qemu-devel] [PATCH v2] linux-user: Add sockopts for IPv6 ping and
 IPv6 traceroute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

Add the neccessary sockopts for ping and traceroute on IPv6.

This fixes the following qemu warnings with IPv6:
Unsupported ancillary data: 0/2
Unsupported ancillary data: 0/11
Unsupported ancillary data: 41/25
Unsupported setsockopt level=0 optname=12 
Unsupported setsockopt level=41 optname=16
Unsupported setsockopt level=41 optname=25
Unsupported setsockopt level=41 optname=50
Unsupported setsockopt level=41 optname=51
Unsupported setsockopt level=41 optname=8
Unsupported setsockopt level=58 optname=1

Tested on hppa-linux-user and x86_64-linux-user.

Changes to v1:
- Added IPV6_PKTINFO sockopt as reported by Philippe Mathieu-Daudé

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9be8e95..97c2519 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -57,6 +57,8 @@ int __clone2(int (*fn)(void *), void *child_stack_base,
 #include <netinet/tcp.h>
 #include <linux/wireless.h>
 #include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/errqueue.h>
 #include "qemu-common.h"
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
@@ -1839,6 +1841,78 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
             }
             break;
 
+        case SOL_IP:
+            switch (cmsg->cmsg_type) {
+            case IP_TTL:
+            {
+                goto copy_word;
+            }
+            case IP_RECVERR:
+            {
+                struct errhdr_t {
+                   struct sock_extended_err ee;
+                   struct sockaddr_in offender;
+                };
+                struct errhdr_t *errh = (struct errhdr_t *)data;
+                struct errhdr_t *target_errh =
+                    (struct errhdr_t *)target_data;
+
+                __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
+                __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
+                __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
+                __put_user(errh->ee.ee_code, &target_errh->ee.ee_code);
+                __put_user(errh->ee.ee_pad, &target_errh->ee.ee_pad);
+                __put_user(errh->ee.ee_info, &target_errh->ee.ee_info);
+                __put_user(errh->ee.ee_data, &target_errh->ee.ee_data);
+                host_to_target_sockaddr((unsigned long) &target_errh->offender,
+                    (void *) &errh->offender, sizeof(errh->offender));
+		break;
+            }
+            default:
+                goto unimplemented;
+            }
+            break;
+
+        case SOL_IPV6:
+            switch (cmsg->cmsg_type) {
+            case IPV6_HOPLIMIT:
+            copy_word:
+            {
+                uint32_t *v = (uint32_t *)data;
+                uint32_t *t_int = (uint32_t *)target_data;
+                if (tgt_len != CMSG_LEN(0))
+                    goto unimplemented;
+
+                __put_user(*v, t_int);
+		break;
+            }
+            case IPV6_RECVERR:
+            {
+                struct errhdr6_t {
+                   struct sock_extended_err ee;
+                   struct sockaddr_in6 offender;
+                };
+                struct errhdr6_t *errh = (struct errhdr6_t *)data;
+                struct errhdr6_t *target_errh =
+                    (struct errhdr6_t *)target_data;
+
+                __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
+                __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
+                __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
+                __put_user(errh->ee.ee_code, &target_errh->ee.ee_code);
+                __put_user(errh->ee.ee_pad, &target_errh->ee.ee_pad);
+                __put_user(errh->ee.ee_info, &target_errh->ee.ee_info);
+                __put_user(errh->ee.ee_data, &target_errh->ee.ee_data);
+                target_errh->offender = errh->offender;
+                __put_user(errh->offender.sin6_family, &target_errh->offender.sin6_family);
+                __put_user(errh->offender.sin6_scope_id, &target_errh->offender.sin6_scope_id);
+		break;
+            }
+            default:
+                goto unimplemented;
+            }
+            break;
+
         default:
         unimplemented:
             gemu_log("Unsupported ancillary data: %d/%d\n",
@@ -2766,6 +2840,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IP_PKTINFO:
         case IP_MTU_DISCOVER:
         case IP_RECVERR:
+        case IP_RECVTTL:
         case IP_RECVTOS:
 #ifdef IP_FREEBIND
         case IP_FREEBIND:
@@ -2815,6 +2890,11 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_MTU:
         case IPV6_V6ONLY:
         case IPV6_RECVPKTINFO:
+        case IPV6_UNICAST_HOPS:
+        case IPV6_RECVERR:
+        case IPV6_PKTINFO:
+        case IPV6_RECVHOPLIMIT:
+        case IPV6_2292HOPLIMIT:
             val = 0;
             if (optlen < sizeof(uint32_t)) {
                 return -TARGET_EINVAL;
@@ -2829,9 +2909,21 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             goto unimplemented;
         }
         break;
+    case SOL_ICMPV6:
+        switch(optname) {
+        case ICMPV6_FILTER:
+        case IPV6_CHECKSUM:
+            goto icmp_filter;
+            break;
+        default:
+            goto unimplemented;
+        }
+        break;
     case SOL_RAW:
         switch (optname) {
         case ICMP_FILTER:
+        case IPV6_CHECKSUM:
+            icmp_filter:
             /* struct icmp_filter takes an u32 value */
             if (optlen < sizeof(uint32_t)) {
                 return -TARGET_EINVAL;
