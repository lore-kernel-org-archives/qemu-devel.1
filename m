Received: from eggs.gnu.org ([209.51.188.92]:43743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grhJp-0004e5-J1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grhJn-000887-Dy
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:54:09 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:48829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1grhJj-00085l-JV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:54:05 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Feb 2019 11:53:47 +0100
Message-Id: <20190207105347.22337-4-laurent@vivier.eu>
In-Reply-To: <20190207105347.22337-1-laurent@vivier.eu>
References: <20190207105347.22337-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] linux-user: add new netlink types
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

Add QEMU_IFLA_MIN_MTU, QEMU_IFLA_MAX_MTU (from linux v4.19)
    QEMU_IFLA_BRPORT_ISOLATED (from linux v4.18) and
    QEMU_IFLA_BRPORT_BACKUP_PORT (from linux v4.19).

These new types fix this error flow with sudo:
...
Unknown host QEMU_IFLA type: 50
Unknown host QEMU_IFLA type: 51
Unknown QEMU_IFLA_BRPORT type 33
...

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190206193211.6683-1-laurent@vivier.eu>
---
 linux-user/fd-trans.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 216b9f0614..30425c9df6 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -129,6 +129,8 @@ enum {
     QEMU_IFLA_CARRIER_UP_COUNT,
     QEMU_IFLA_CARRIER_DOWN_COUNT,
     QEMU_IFLA_NEW_IFINDEX,
+    QEMU_IFLA_MIN_MTU,
+    QEMU_IFLA_MAX_MTU,
     QEMU___IFLA_MAX
 };
 
@@ -166,6 +168,8 @@ enum {
     QEMU_IFLA_BRPORT_BCAST_FLOOD,
     QEMU_IFLA_BRPORT_GROUP_FWD_MASK,
     QEMU_IFLA_BRPORT_NEIGH_SUPPRESS,
+    QEMU_IFLA_BRPORT_ISOLATED,
+    QEMU_IFLA_BRPORT_BACKUP_PORT,
     QEMU___IFLA_BRPORT_MAX
 };
 
@@ -510,6 +514,7 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_VLAN_TUNNEL:
     case QEMU_IFLA_BRPORT_BCAST_FLOOD:
     case QEMU_IFLA_BRPORT_NEIGH_SUPPRESS:
+    case QEMU_IFLA_BRPORT_ISOLATED:
         break;
     /* uint16_t */
     case QEMU_IFLA_BRPORT_PRIORITY:
@@ -523,6 +528,7 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
         break;
     /* uin32_t */
     case QEMU_IFLA_BRPORT_COST:
+    case QEMU_IFLA_BRPORT_BACKUP_PORT:
         u32 = NLA_DATA(nlattr);
         *u32 = tswap32(*u32);
         break;
@@ -787,6 +793,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
     case QEMU_IFLA_GSO_MAX_SIZE:
     case QEMU_IFLA_CARRIER_UP_COUNT:
     case QEMU_IFLA_CARRIER_DOWN_COUNT:
+    case QEMU_IFLA_MIN_MTU:
+    case QEMU_IFLA_MAX_MTU:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
-- 
2.20.1
