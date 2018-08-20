Received: from eggs.gnu.org ([2001:4830:134:3::10]:49084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frnn0-0007Bd-88
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frnmv-0003CG-9q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frnmu-0003Ba-UT
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:21 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 19:15:55 +0200
Message-Id: <20180820171557.7734-3-laurent@vivier.eu>
In-Reply-To: <20180820171557.7734-1-laurent@vivier.eu>
References: <20180820171557.7734-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 2/4] linux-user: introduce QEMU_RTA_* to use
 with rtattr_type_t
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

Following commit will introduce RTA_PREF that appears only with
kernel v4.1. To avoid to manage a specific case for it, this patch
introduces the full list of rtattr_type_t prefixed with QEMU_ (as we
did for IFLA values)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 53 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a62cd15dc7..a2395eb1b6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -539,6 +539,37 @@ enum {
     QEMU___IFLA_XDP_MAX,
 };
 
+enum {
+    QEMU_RTA_UNSPEC,
+    QEMU_RTA_DST,
+    QEMU_RTA_SRC,
+    QEMU_RTA_IIF,
+    QEMU_RTA_OIF,
+    QEMU_RTA_GATEWAY,
+    QEMU_RTA_PRIORITY,
+    QEMU_RTA_PREFSRC,
+    QEMU_RTA_METRICS,
+    QEMU_RTA_MULTIPATH,
+    QEMU_RTA_PROTOINFO, /* no longer used */
+    QEMU_RTA_FLOW,
+    QEMU_RTA_CACHEINFO,
+    QEMU_RTA_SESSION, /* no longer used */
+    QEMU_RTA_MP_ALGO, /* no longer used */
+    QEMU_RTA_TABLE,
+    QEMU_RTA_MARK,
+    QEMU_RTA_MFC_STATS,
+    QEMU_RTA_VIA,
+    QEMU_RTA_NEWDST,
+    QEMU_RTA_PREF,
+    QEMU_RTA_ENCAP_TYPE,
+    QEMU_RTA_ENCAP,
+    QEMU_RTA_EXPIRES,
+    QEMU_RTA_PAD,
+    QEMU_RTA_UID,
+    QEMU_RTA_TTL_PROPAGATE,
+    QEMU___RTA_MAX
+};
+
 typedef abi_long (*TargetFdDataFunc)(void *, size_t);
 typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
 typedef struct TargetFdTrans {
@@ -2661,14 +2692,14 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
     uint32_t *u32;
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case RTA_GATEWAY:
-    case RTA_DST:
-    case RTA_PREFSRC:
+    case QEMU_RTA_GATEWAY:
+    case QEMU_RTA_DST:
+    case QEMU_RTA_PREFSRC:
         break;
     /* u32 */
-    case RTA_PRIORITY:
-    case RTA_TABLE:
-    case RTA_OIF:
+    case QEMU_RTA_PRIORITY:
+    case QEMU_RTA_TABLE:
+    case QEMU_RTA_OIF:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
@@ -2808,13 +2839,13 @@ static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
     uint32_t *u32;
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case RTA_DST:
-    case RTA_SRC:
-    case RTA_GATEWAY:
+    case QEMU_RTA_DST:
+    case QEMU_RTA_SRC:
+    case QEMU_RTA_GATEWAY:
         break;
     /* u32 */
-    case RTA_PRIORITY:
-    case RTA_OIF:
+    case QEMU_RTA_PRIORITY:
+    case QEMU_RTA_OIF:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
-- 
2.17.1
