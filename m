Received: from eggs.gnu.org ([2001:4830:134:3::10]:38893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1N-0001ql-Ho
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1J-00037j-I5
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frW1J-00037O-9T
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:01 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 00:17:06 +0200
Message-Id: <20180819221707.20693-6-laurent@vivier.eu>
In-Reply-To: <20180819221707.20693-1-laurent@vivier.eu>
References: <20180819221707.20693-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/6] linux-user: update netlink route types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Add RTA_PREF and RTA_CACHEINFO.

Fix following errors when we start gedit:

  Unknown host RTA type: 12
  Unknown host RTA type: 20

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180814161904.12216-3-laurent@vivier.eu>
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e66faf1c62..da1fcaf4ca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2659,12 +2659,17 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
 static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
 {
     uint32_t *u32;
+    struct rta_cacheinfo *ci;
+
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
     case RTA_GATEWAY:
     case RTA_DST:
     case RTA_PREFSRC:
         break;
+    /* u8 */
+    case RTA_PREF:
+        break;
     /* u32 */
     case RTA_PRIORITY:
     case RTA_TABLE:
@@ -2672,6 +2677,20 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
+    /* struct rta_cacheinfo */
+    case RTA_CACHEINFO:
+        ci = RTA_DATA(rtattr);
+        ci->rta_clntref = tswap32(ci->rta_clntref);
+        ci->rta_lastuse = tswap32(ci->rta_lastuse);
+        ci->rta_expires = tswap32(ci->rta_expires);
+        ci->rta_error = tswap32(ci->rta_error);
+        ci->rta_used = tswap32(ci->rta_used);
+#if defined(RTNETLINK_HAVE_PEERINFO)
+        ci->rta_id = tswap32(ci->rta_id);
+        ci->rta_ts = tswap32(ci->rta_ts);
+        ci->rta_tsage = tswap32(ci->rta_tsage);
+#endif
+        break;
     default:
         gemu_log("Unknown host RTA type: %d\n", rtattr->rta_type);
         break;
-- 
2.17.1
