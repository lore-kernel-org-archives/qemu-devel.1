Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frnn0-0007Bf-8g
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frnmv-0003CO-AU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frnmu-0003Bb-V7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:21 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 19:15:56 +0200
Message-Id: <20180820171557.7734-4-laurent@vivier.eu>
In-Reply-To: <20180820171557.7734-1-laurent@vivier.eu>
References: <20180820171557.7734-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 3/4] linux-user: update netlink route types
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

Add RTA_PREF and RTA_CACHEINFO.

Fix following errors when we start gedit:

  Unknown host RTA type: 12
  Unknown host RTA type: 20

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a2395eb1b6..197010945f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2690,12 +2690,17 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
 static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
 {
     uint32_t *u32;
+    struct rta_cacheinfo *ci;
+
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
     case QEMU_RTA_GATEWAY:
     case QEMU_RTA_DST:
     case QEMU_RTA_PREFSRC:
         break;
+    /* u8 */
+    case QEMU_RTA_PREF:
+        break;
     /* u32 */
     case QEMU_RTA_PRIORITY:
     case QEMU_RTA_TABLE:
@@ -2703,6 +2708,20 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
+    /* struct rta_cacheinfo */
+    case QEMU_RTA_CACHEINFO:
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
