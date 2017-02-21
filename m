Received: from eggs.gnu.org ([2001:4830:134:3::10]:34840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKU-0003Qk-7n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKR-0001fO-9Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgHKR-0001ep-18
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:31 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29EDF7E9CB
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:46:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:46:27 +0100
Message-Id: <1487709988-14322-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487709988-14322-1-git-send-email-armbru@redhat.com>
References: <1487709988-14322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] net: Flatten simple union
 NetLegacyOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Simple unions are simpler than flat unions in the schema, but more
complicated in C and on the QMP wire: there's extra indirection in C
and extra nesting on the wire, both pointless.  They're best avoided
in new code.

NetLegacyOptions isn't new, but it's only used internally, not in QMP.
Convert it to a flat union.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 net/net.c        | 44 ++++++++++++++++++++++----------------------
 qapi-schema.json | 11 +++++++++++
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/net/net.c b/net/net.c
index fb7af3a..0ac3b9e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -993,47 +993,47 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
 
         /* Map the old options to the new flat type */
         switch (opts->type) {
-        case NET_LEGACY_OPTIONS_KIND_NONE:
+        case NET_LEGACY_OPTIONS_TYPE_NONE:
             return 0; /* nothing to do */
-        case NET_LEGACY_OPTIONS_KIND_NIC:
+        case NET_LEGACY_OPTIONS_TYPE_NIC:
             legacy.type = NET_CLIENT_DRIVER_NIC;
-            legacy.u.nic = *opts->u.nic.data;
+            legacy.u.nic = opts->u.nic;
             break;
-        case NET_LEGACY_OPTIONS_KIND_USER:
+        case NET_LEGACY_OPTIONS_TYPE_USER:
             legacy.type = NET_CLIENT_DRIVER_USER;
-            legacy.u.user = *opts->u.user.data;
+            legacy.u.user = opts->u.user;
             break;
-        case NET_LEGACY_OPTIONS_KIND_TAP:
+        case NET_LEGACY_OPTIONS_TYPE_TAP:
             legacy.type = NET_CLIENT_DRIVER_TAP;
-            legacy.u.tap = *opts->u.tap.data;
+            legacy.u.tap = opts->u.tap;
             break;
-        case NET_LEGACY_OPTIONS_KIND_L2TPV3:
+        case NET_LEGACY_OPTIONS_TYPE_L2TPV3:
             legacy.type = NET_CLIENT_DRIVER_L2TPV3;
-            legacy.u.l2tpv3 = *opts->u.l2tpv3.data;
+            legacy.u.l2tpv3 = opts->u.l2tpv3;
             break;
-        case NET_LEGACY_OPTIONS_KIND_SOCKET:
+        case NET_LEGACY_OPTIONS_TYPE_SOCKET:
             legacy.type = NET_CLIENT_DRIVER_SOCKET;
-            legacy.u.socket = *opts->u.socket.data;
+            legacy.u.socket = opts->u.socket;
             break;
-        case NET_LEGACY_OPTIONS_KIND_VDE:
+        case NET_LEGACY_OPTIONS_TYPE_VDE:
             legacy.type = NET_CLIENT_DRIVER_VDE;
-            legacy.u.vde = *opts->u.vde.data;
+            legacy.u.vde = opts->u.vde;
             break;
-        case NET_LEGACY_OPTIONS_KIND_DUMP:
+        case NET_LEGACY_OPTIONS_TYPE_DUMP:
             legacy.type = NET_CLIENT_DRIVER_DUMP;
-            legacy.u.dump = *opts->u.dump.data;
+            legacy.u.dump = opts->u.dump;
             break;
-        case NET_LEGACY_OPTIONS_KIND_BRIDGE:
+        case NET_LEGACY_OPTIONS_TYPE_BRIDGE:
             legacy.type = NET_CLIENT_DRIVER_BRIDGE;
-            legacy.u.bridge = *opts->u.bridge.data;
+            legacy.u.bridge = opts->u.bridge;
             break;
-        case NET_LEGACY_OPTIONS_KIND_NETMAP:
+        case NET_LEGACY_OPTIONS_TYPE_NETMAP:
             legacy.type = NET_CLIENT_DRIVER_NETMAP;
-            legacy.u.netmap = *opts->u.netmap.data;
+            legacy.u.netmap = opts->u.netmap;
             break;
-        case NET_LEGACY_OPTIONS_KIND_VHOST_USER:
+        case NET_LEGACY_OPTIONS_TYPE_VHOST_USER:
             legacy.type = NET_CLIENT_DRIVER_VHOST_USER;
-            legacy.u.vhost_user = *opts->u.vhost_user.data;
+            legacy.u.vhost_user = opts->u.vhost_user;
             break;
         default:
             abort();
@@ -1048,7 +1048,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
 
         /* Do not add to a vlan if it's a nic with a netdev= parameter. */
         if (netdev->type != NET_CLIENT_DRIVER_NIC ||
-            !opts->u.nic.data->has_netdev) {
+            !opts->u.nic.has_netdev) {
             peer = net_hub_add_port(net->has_vlan ? net->vlan : 0, NULL);
         }
 
diff --git a/qapi-schema.json b/qapi-schema.json
index a448ea8..5347781 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3959,6 +3959,15 @@
     'opts':  'NetLegacyOptions' } }
 
 ##
+# @NetLegacyOptionsType:
+#
+# Since: 1.2
+##
+{ 'enum': 'NetLegacyOptionsType',
+  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
+           'dump', 'bridge', 'netmap', 'vhost-user'] }
+
+##
 # @NetLegacyOptions:
 #
 # Like Netdev, but for use only by the legacy command line options
@@ -3966,6 +3975,8 @@
 # Since: 1.2
 ##
 { 'union': 'NetLegacyOptions',
+  'base': { 'type': 'NetLegacyOptionsType' },
+  'discriminator': 'type',
   'data': {
     'none':     'NetdevNoneOptions',
     'nic':      'NetLegacyNicOptions',
-- 
2.7.4
