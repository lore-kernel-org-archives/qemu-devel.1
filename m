Received: from eggs.gnu.org ([2001:4830:134:3::10]:38527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ4f1-0001WN-1S
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ4ex-0003Md-00
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:12:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJ4ew-0003Lk-MP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:12:34 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 17 May 2018 00:12:13 +0200
Message-Id: <20180516221213.11111-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: update netlink emulation
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

Update enums with entries from linux 4.17

Translate entries that generate logs with iproute2 4.9.0 and
host kernel 4.15:

  # ip address show
  Unknown host QEMU_IFLA type: 43
  Unknown host QEMU_IFLA type: 43
  Unknown host QEMU_IFLA type: 43
  Unknown QEMU_IFLA_BR type 41
  Unknown QEMU_IFLA_BR type 42
  Unknown QEMU_IFLA_BR type 43
  Unknown QEMU_IFLA_BR type 44
  Unknown host QEMU_IFLA type: 43
  Unknown QEMU_IFLA_BR type 41
  Unknown QEMU_IFLA_BR type 42
  Unknown QEMU_IFLA_BR type 43
  Unknown QEMU_IFLA_BR type 44
  Unknown host QEMU_IFLA type: 43

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index af8603f1b7..dd77f86ea2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -405,6 +405,8 @@ enum {
     QEMU_IFLA_BR_PAD,
     QEMU_IFLA_BR_VLAN_STATS_ENABLED,
     QEMU_IFLA_BR_MCAST_STATS_ENABLED,
+    QEMU_IFLA_BR_MCAST_IGMP_VERSION,
+    QEMU_IFLA_BR_MCAST_MLD_VERSION,
     QEMU___IFLA_BR_MAX,
 };
 
@@ -453,6 +455,12 @@ enum {
     QEMU_IFLA_GSO_MAX_SIZE,
     QEMU_IFLA_PAD,
     QEMU_IFLA_XDP,
+    QEMU_IFLA_EVENT,
+    QEMU_IFLA_NEW_NETNSID,
+    QEMU_IFLA_IF_NETNSID,
+    QEMU_IFLA_CARRIER_UP_COUNT,
+    QEMU_IFLA_CARRIER_DOWN_COUNT,
+    QEMU_IFLA_NEW_IFINDEX,
     QEMU___IFLA_MAX
 };
 
@@ -484,6 +492,12 @@ enum {
     QEMU_IFLA_BRPORT_FLUSH,
     QEMU_IFLA_BRPORT_MULTICAST_ROUTER,
     QEMU_IFLA_BRPORT_PAD,
+    QEMU_IFLA_BRPORT_MCAST_FLOOD,
+    QEMU_IFLA_BRPORT_MCAST_TO_UCAST,
+    QEMU_IFLA_BRPORT_VLAN_TUNNEL,
+    QEMU_IFLA_BRPORT_BCAST_FLOOD,
+    QEMU_IFLA_BRPORT_GROUP_FWD_MASK,
+    QEMU_IFLA_BRPORT_NEIGH_SUPPRESS,
     QEMU___IFLA_BRPORT_MAX
 };
 
@@ -516,6 +530,15 @@ enum {
     QEMU___IFLA_INET6_MAX
 };
 
+enum {
+    QEMU_IFLA_XDP_UNSPEC,
+    QEMU_IFLA_XDP_FD,
+    QEMU_IFLA_XDP_ATTACHED,
+    QEMU_IFLA_XDP_FLAGS,
+    QEMU_IFLA_XDP_PROG_ID,
+    QEMU___IFLA_XDP_MAX,
+};
+
 typedef abi_long (*TargetFdDataFunc)(void *, size_t);
 typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
 typedef struct TargetFdTrans {
@@ -2182,6 +2205,10 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BR_NF_CALL_IPTABLES:
     case QEMU_IFLA_BR_NF_CALL_IP6TABLES:
     case QEMU_IFLA_BR_NF_CALL_ARPTABLES:
+    case QEMU_IFLA_BR_VLAN_STATS_ENABLED:
+    case QEMU_IFLA_BR_MCAST_STATS_ENABLED:
+    case QEMU_IFLA_BR_MCAST_IGMP_VERSION:
+    case QEMU_IFLA_BR_MCAST_MLD_VERSION:
         break;
     /* uint16_t */
     case QEMU_IFLA_BR_PRIORITY:
@@ -2253,6 +2280,11 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_TOPOLOGY_CHANGE_ACK:
     case QEMU_IFLA_BRPORT_CONFIG_PENDING:
     case QEMU_IFLA_BRPORT_MULTICAST_ROUTER:
+    case QEMU_IFLA_BRPORT_MCAST_FLOOD:
+    case QEMU_IFLA_BRPORT_MCAST_TO_UCAST:
+    case QEMU_IFLA_BRPORT_VLAN_TUNNEL:
+    case QEMU_IFLA_BRPORT_BCAST_FLOOD:
+    case QEMU_IFLA_BRPORT_NEIGH_SUPPRESS:
         break;
     /* uint16_t */
     case QEMU_IFLA_BRPORT_PRIORITY:
@@ -2260,6 +2292,7 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_DESIGNATED_COST:
     case QEMU_IFLA_BRPORT_ID:
     case QEMU_IFLA_BRPORT_NO:
+    case QEMU_IFLA_BRPORT_GROUP_FWD_MASK:
         u16 = NLA_DATA(nlattr);
         *u16 = tswap16(*u16);
         break;
@@ -2434,6 +2467,27 @@ static abi_long host_to_target_data_spec_nlattr(struct nlattr *nlattr,
     return 0;
 }
 
+static abi_long host_to_target_data_xdp_nlattr(struct nlattr *nlattr,
+                                               void *context)
+{
+    uint32_t *u32;
+
+    switch (nlattr->nla_type) {
+    /* uint8_t */
+    case QEMU_IFLA_XDP_ATTACHED:
+        break;
+    /* uint32_t */
+    case QEMU_IFLA_XDP_PROG_ID:
+        u32 = NLA_DATA(nlattr);
+        *u32 = tswap32(*u32);
+        break;
+    default:
+        gemu_log("Unknown host XDP type: %d\n", nlattr->nla_type);
+        break;
+    }
+    return 0;
+}
+
 static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
 {
     uint32_t *u32;
@@ -2559,6 +2613,10 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
         return host_to_target_for_each_nlattr(RTA_DATA(rtattr), rtattr->rta_len,
                                               NULL,
                                              host_to_target_data_spec_nlattr);
+    case QEMU_IFLA_XDP:
+        return host_to_target_for_each_nlattr(RTA_DATA(rtattr), rtattr->rta_len,
+                                              NULL,
+                                                host_to_target_data_xdp_nlattr);
     default:
         gemu_log("Unknown host QEMU_IFLA type: %d\n", rtattr->rta_type);
         break;
-- 
2.14.3
