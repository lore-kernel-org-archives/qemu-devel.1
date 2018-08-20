Received: from eggs.gnu.org ([2001:4830:134:3::10]:51890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlY-00037Q-P4
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlL-0003Iy-M9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frqlK-0003EI-JS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:55 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 22:26:02 +0200
Message-Id: <20180820202604.14218-6-laurent@vivier.eu>
In-Reply-To: <20180820202604.14218-1-laurent@vivier.eu>
References: <20180820202604.14218-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/7] linux-user: introduce QEMU_RTA_* to use
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Following commit will introduce RTA_PREF that appears only with
kernel v4.1. To avoid to manage a specific case for it, this patch
introduces the full list of rtattr_type_t prefixed with QEMU_ (as we
did for IFLA values)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180820171557.7734-3-laurent@vivier.eu>
[lv: added more RTA_* from linux v4.18]
---
 linux-user/syscall.c | 56 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e66faf1c62..9effbb316a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -539,6 +539,40 @@ enum {
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
+    QEMU_RTA_IP_PROTO,
+    QEMU_RTA_SPORT,
+    QEMU_RTA_DPORT,
+    QEMU___RTA_MAX
+};
+
 typedef abi_long (*TargetFdDataFunc)(void *, size_t);
 typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
 typedef struct TargetFdTrans {
@@ -2661,14 +2695,14 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
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
@@ -2808,13 +2842,13 @@ static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
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
