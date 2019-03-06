Received: from eggs.gnu.org ([209.51.188.92]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1crQ-0005dy-F0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1crM-0004Y0-Hz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:09:52 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1crM-0004V2-8l
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:09:48 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Mar 2019 21:09:25 +0100
Message-Id: <20190306200925.17605-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: add new netlink types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Add QEMU_IFLA_BR_VLAN_STATS_PER_PORT (from linux v4.20),
    QEMU_IFLA_BR_MULTI_BOOLOPT (from linux v5.0).

The first new entry fixes the following error:

  Unknown QEMU_IFLA_BR type 45

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 30425c9df6bc..612819c1b1ec 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -75,6 +75,8 @@ enum {
     QEMU_IFLA_BR_MCAST_STATS_ENABLED,
     QEMU_IFLA_BR_MCAST_IGMP_VERSION,
     QEMU_IFLA_BR_MCAST_MLD_VERSION,
+    QEMU_IFLA_BR_VLAN_STATS_PER_PORT,
+    QEMU_IFLA_BR_MULTI_BOOLOPT,
     QEMU___IFLA_BR_MAX,
 };
 
@@ -438,6 +440,7 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BR_MCAST_STATS_ENABLED:
     case QEMU_IFLA_BR_MCAST_IGMP_VERSION:
     case QEMU_IFLA_BR_MCAST_MLD_VERSION:
+    case QEMU_IFLA_BR_VLAN_STATS_PER_PORT:
         break;
     /* uint16_t */
     case QEMU_IFLA_BR_PRIORITY:
@@ -543,6 +546,12 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_ROOT_ID:
     case QEMU_IFLA_BRPORT_BRIDGE_ID:
         break;
+    /* br_boolopt_multi { uint32_t, uint32_t } */
+    case QEMU_IFLA_BR_MULTI_BOOLOPT:
+        u32 = NLA_DATA(nlattr);
+        u32[0] = tswap32(u32[0]); /* optval */
+        u32[1] = tswap32(u32[1]); /* optmask */
+        break;
     default:
         gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
         break;
-- 
2.20.1
