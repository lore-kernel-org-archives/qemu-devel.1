Received: from eggs.gnu.org ([2001:4830:134:3::10]:55027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebAmg-0005rN-3l
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebAmc-0001vL-4u
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:51:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ebAmb-0001v8-Sq
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:51:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AF9DC047B91
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:51:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 15 Jan 2018 20:50:55 +0100
Message-Id: <1516045855-27146-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] net: Allow hubports to connect to other
 netdevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

QEMU can emulate hubs to connect NICs and netdevs. This is currently
primarily used for the mis-named 'vlan' feature of the networking
subsystem. Now the 'vlan' feature has been marked as deprecated, since
its name is rather confusing and the users often rather mis-configure
their network when trying to use it. But while the 'vlan' parameter
should be removed at one point in time, the basic idea of emulating
a hub in QEMU is still good: It's useful for bundling up the output of
multiple NICs into one single l2tp netdev for example.

Now to be able to use the hubport feature without 'vlan's, there is one
missing piece: The possibility to connect a hubport to a netdev, too.
This patch adds this possibility by introducing a new "netdev=..."
parameter to the hubports.

To bundle up the output of multiple NICs into one socket netdev, you can
now run QEMU with these parameters for example:

qemu-system-ppc64 ... -netdev socket,id=s1,connect=:11122 \
    -netdev hubport,hubid=1,id=h1,netdev=s1 \
    -netdev hubport,hubid=1,id=h2 -device e1000,netdev=h2 \
    -netdev hubport,hubid=1,id=h3 -device virtio-net-pci,netdev=h3

For using the socket netdev, you have got to start another QEMU as the
receiving side first, for example with network dumping enabled:

qemu-system-x86_64 -M isapc -netdev socket,id=s0,listen=:11122 \
    -device ne2k_isa,netdev=s0 \
    -object filter-dump,id=f1,netdev=s0,file=/tmp/dump.dat

After the ppc64 guest tried to boot from both NICs, you can see in the
dump file (using Wireshark, for example), that the output of both NICs
(the e1000 and the virtio-net-pci) has been successfully transfered
via the socket netdev in this case.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Set up peer via qemu_new_net_client() instead of duplicating the
     code to do this in net_init_hubport()

 net/hub.c       | 27 +++++++++++++++++++++------
 net/hub.h       |  3 ++-
 net/net.c       |  2 +-
 qapi/net.json   |  4 +++-
 qemu-options.hx |  8 +++++---
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/net/hub.c b/net/hub.c
index 14b4eec..5e84a9a 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "clients.h"
@@ -140,7 +141,8 @@ static NetClientInfo net_hub_port_info = {
     .cleanup = net_hub_port_cleanup,
 };
 
-static NetHubPort *net_hub_port_new(NetHub *hub, const char *name)
+static NetHubPort *net_hub_port_new(NetHub *hub, const char *name,
+                                    NetClientState *hubpeer)
 {
     NetClientState *nc;
     NetHubPort *port;
@@ -153,7 +155,7 @@ static NetHubPort *net_hub_port_new(NetHub *hub, const char *name)
         name = default_name;
     }
 
-    nc = qemu_new_net_client(&net_hub_port_info, NULL, "hub", name);
+    nc = qemu_new_net_client(&net_hub_port_info, hubpeer, "hub", name);
     port = DO_UPCAST(NetHubPort, nc, nc);
     port->id = id;
     port->hub = hub;
@@ -165,11 +167,14 @@ static NetHubPort *net_hub_port_new(NetHub *hub, const char *name)
 
 /**
  * Create a port on a given hub
+ * @hub_id: Number of the hub
  * @name: Net client name or NULL for default name.
+ * @hubpeer: Peer to use (if "netdev=id" has been specified)
  *
  * If there is no existing hub with the given id then a new hub is created.
  */
-NetClientState *net_hub_add_port(int hub_id, const char *name)
+NetClientState *net_hub_add_port(int hub_id, const char *name,
+                                 NetClientState *hubpeer)
 {
     NetHub *hub;
     NetHubPort *port;
@@ -184,7 +189,7 @@ NetClientState *net_hub_add_port(int hub_id, const char *name)
         hub = net_hub_new(hub_id);
     }
 
-    port = net_hub_port_new(hub, name);
+    port = net_hub_port_new(hub, name, hubpeer);
     return &port->nc;
 }
 
@@ -232,7 +237,7 @@ NetClientState *net_hub_port_find(int hub_id)
         }
     }
 
-    nc = net_hub_add_port(hub_id, NULL);
+    nc = net_hub_add_port(hub_id, NULL, NULL);
     return nc;
 }
 
@@ -286,12 +291,22 @@ int net_init_hubport(const Netdev *netdev, const char *name,
                      NetClientState *peer, Error **errp)
 {
     const NetdevHubPortOptions *hubport;
+    NetClientState *hubpeer = NULL;
 
     assert(netdev->type == NET_CLIENT_DRIVER_HUBPORT);
     assert(!peer);
     hubport = &netdev->u.hubport;
 
-    net_hub_add_port(hubport->hubid, name);
+    if (hubport->has_netdev) {
+        hubpeer = qemu_find_netdev(hubport->netdev);
+        if (!hubpeer) {
+            error_setg(errp, "netdev '%s' not found", hubport->netdev);
+            return -1;
+        }
+    }
+
+    net_hub_add_port(hubport->hubid, name, hubpeer);
+
     return 0;
 }
 
diff --git a/net/hub.h b/net/hub.h
index a625eff..6a16f04 100644
--- a/net/hub.h
+++ b/net/hub.h
@@ -17,7 +17,8 @@
 
 #include "qemu-common.h"
 
-NetClientState *net_hub_add_port(int hub_id, const char *name);
+NetClientState *net_hub_add_port(int hub_id, const char *name,
+                                 NetClientState *hubpeer);
 NetClientState *net_hub_find_client_by_name(int hub_id, const char *name);
 void net_hub_info(Monitor *mon);
 void net_hub_check_clients(void);
diff --git a/net/net.c b/net/net.c
index 52c2b35..feaf3d9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1037,7 +1037,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
         /* Do not add to a vlan if it's a nic with a netdev= parameter. */
         if (netdev->type != NET_CLIENT_DRIVER_NIC ||
             !opts->u.nic.has_netdev) {
-            peer = net_hub_add_port(net->has_vlan ? net->vlan : 0, NULL);
+            peer = net_hub_add_port(net->has_vlan ? net->vlan : 0, NULL, NULL);
         }
 
         if (net->has_vlan && !vlan_warned) {
diff --git a/qapi/net.json b/qapi/net.json
index 2eb2dc2..15ca2ed 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -393,12 +393,14 @@
 # Connect two or more net clients through a software hub.
 #
 # @hubid: hub identifier number
+# @netdev: used to connect hub to a netdev instead of a device (since 2.12)
 #
 # Since: 1.2
 ##
 { 'struct': 'NetdevHubPortOptions',
   'data': {
-    'hubid':     'int32' } }
+    'hubid':     'int32',
+    '*netdev':    'str' } }
 
 ##
 # @NetdevNetmapOptions:
diff --git a/qemu-options.hx b/qemu-options.hx
index ca68d00..d0c8b06 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2017,7 +2017,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #endif
     "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
     "                configure a vhost-user network, backed by a chardev 'dev'\n"
-    "-netdev hubport,id=str,hubid=n\n"
+    "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
     "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
     "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
@@ -2443,13 +2443,15 @@ vde_switch -F -sock /tmp/myswitch
 qemu-system-i386 linux.img -net nic -net vde,sock=/tmp/myswitch
 @end example
 
-@item -netdev hubport,id=@var{id},hubid=@var{hubid}
+@item -netdev hubport,id=@var{id},hubid=@var{hubid}[,netdev=@var{nd}]
 
 Create a hub port on QEMU "vlan" @var{hubid}.
 
 The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of a single
 netdev.  @code{-net} and @code{-device} with parameter @option{vlan} create the
-required hub automatically.
+required hub automatically. Alternatively, you can also connect the hubport
+to another netdev with ID @var{nd} by using the @option{netdev=@var{nd}}
+option.
 
 @item -netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
 
-- 
1.8.3.1
