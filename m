Received: from eggs.gnu.org ([209.51.188.92]:60742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfY-0001TP-AW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfX-0003Dy-Es
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46178 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hMbfX-0001hD-7v
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  3 May 2019 19:06:48 +0200
Message-Id: <1556903209-6036-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 4/5] linux-user: Add support for
 setsockopt() options IPV6_<ADD|DROP>_MEMBERSHIP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, nchen@wavecomp.com, daniel.santos@pobox.com, jcmvbkbc@gmail.com, lvivier@redhat.com, thuth@redhat.com, philmd@redhat.com

From: Neng Chen <nchen@wavecomp.com>

Add support for options IPV6_ADD_MEMBERSHIP and IPV6_ADD_MEMBERSHIP
of the syscall setsockopt(). These options control membership in
multicast groups. Their argument is a pointer to a struct ipv6_mreq,
which is in turn defined as:

struct ipv6_mreq {
    /* IPv6 multicast address of group */
    struct in6_addr  ipv6mr_multiaddr;
    /* local IPv6 address of interface */
    int              ipv6mr_interface;
};

The in6_addr structure consists of fields that are always big-endian
(on any host), so the ipv6_mreq's field ipv6mr_multiaddr doesn't need
any endian conversion, whereas ipv6mr_interface does.

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf..b7eb4b7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1892,6 +1892,25 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                                        &pki, sizeof(pki)));
             break;
         }
+        case IPV6_ADD_MEMBERSHIP:
+        case IPV6_DROP_MEMBERSHIP:
+        {
+            struct ipv6_mreq ipv6mreq;
+
+            if (optlen < sizeof(ipv6mreq)) {
+                return -TARGET_EINVAL;
+            }
+
+            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))) {
+                return -TARGET_EFAULT;
+            }
+
+            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
+
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                       &ipv6mreq, sizeof(ipv6mreq)));
+            break;
+        }
         default:
             goto unimplemented;
         }
-- 
2.7.4
