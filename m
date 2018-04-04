Received: from eggs.gnu.org ([2001:4830:134:3::10]:42394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3kPq-0008Md-J9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3kPn-0005qn-DK
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:33:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f3kPn-0005pn-8f
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:33:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  4 Apr 2018 17:33:22 +0200
Message-Id: <1522856003-26861-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1522856003-26861-1-git-send-email-thuth@redhat.com>
References: <1522856003-26861-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 1/2] net: Get rid of 'vlan'
 terminology and use 'hub' instead in the source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

'vlan' is very confusing since it does not mean something like IEEE
802.1Q, but rather emulated hubs, so let's switch to that terminology
instead.

Buglink: https://bugs.launchpad.net/qemu/+bug/658904
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/qdev-properties-system.c | 18 +++++++++---------
 include/hw/qdev-properties.h     |  6 +++---
 include/net/net.h                |  2 +-
 net/hub.c                        |  4 ++--
 net/net.c                        |  2 +-
 net/slirp.c                      |  8 ++++----
 net/tap.c                        |  4 ++--
 qapi/net.json                    | 10 +++++-----
 qemu-options.hx                  |  6 +++---
 9 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1d3ba72..704129e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -321,9 +321,9 @@ const PropertyInfo qdev_prop_netdev = {
     .set   = set_netdev,
 };
 
-/* --- vlan --- */
+/* --- hub --- */
 
-static int print_vlan(DeviceState *dev, Property *prop, char *dest, size_t len)
+static int print_hub(DeviceState *dev, Property *prop, char *dest, size_t len)
 {
     NetClientState **ptr = qdev_get_prop_ptr(dev, prop);
 
@@ -337,7 +337,7 @@ static int print_vlan(DeviceState *dev, Property *prop, char *dest, size_t len)
     return snprintf(dest, len, "<null>");
 }
 
-static void get_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
+static void get_hub(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -355,7 +355,7 @@ static void get_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_int32(v, name, &id, errp);
 }
 
-static void set_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
+static void set_hub(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -394,12 +394,12 @@ static void set_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
     *ptr = hubport;
 }
 
-const PropertyInfo qdev_prop_vlan = {
+const PropertyInfo qdev_prop_hub = {
     .name  = "int32",
-    .description = "Integer VLAN id to connect to",
-    .print = print_vlan,
-    .get   = get_vlan,
-    .set   = set_vlan,
+    .description = "Integer hub id to connect to",
+    .print = print_hub,
+    .get   = get_hub,
+    .set   = set_hub,
 };
 
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b2ad8e9..dbc1802 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -29,7 +29,7 @@ extern const PropertyInfo qdev_prop_bios_chs_trans;
 extern const PropertyInfo qdev_prop_fdc_drive_type;
 extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_netdev;
-extern const PropertyInfo qdev_prop_vlan;
+extern const PropertyInfo qdev_prop_hub;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
@@ -195,8 +195,8 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
-#define DEFINE_PROP_VLAN(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_vlan, NICPeers)
+#define DEFINE_PROP_HUB(_n, _s, _f)             \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_hub, NICPeers)
 #define DEFINE_PROP_DRIVE(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
diff --git a/include/net/net.h b/include/net/net.h
index 1f7341e..f903465 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -37,7 +37,7 @@ typedef struct NICConf {
 
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
-    DEFINE_PROP_VLAN("vlan",     _state, _conf.peers),                   \
+    DEFINE_PROP_HUB("vlan",      _state, _conf.peers),                  \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
 
 
diff --git a/net/hub.c b/net/hub.c
index 5e84a9a..fbf0f76 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -345,10 +345,10 @@ void net_hub_check_clients(void)
             }
         }
         if (has_host_dev && !has_nic) {
-            warn_report("vlan %d with no nics", hub->id);
+            warn_report("hub %d with no nics", hub->id);
         }
         if (has_nic && !has_host_dev) {
-            warn_report("vlan %d is not connected to host network", hub->id);
+            warn_report("hub %d is not connected to host network", hub->id);
         }
     }
 }
diff --git a/net/net.c b/net/net.c
index 29f8398..c164795 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1365,7 +1365,7 @@ void qmp_set_link(const char *name, bool up, Error **errp)
          * If the peer is a HUBPORT or a backend, we do not change the
          * link status.
          *
-         * This behavior is compatible with qemu vlans where there could be
+         * This behavior is compatible with qemu hubs where there could be
          * multiple clients that can still communicate with each other in
          * disconnected mode. For now maintain this compatibility.
          */
diff --git a/net/slirp.c b/net/slirp.c
index 8991816..6922524 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -415,7 +415,7 @@ static SlirpState *slirp_lookup(Monitor *mon, const char *hub_id,
         if (hub_id) {
             nc = net_hub_find_client_by_name(strtol(hub_id, NULL, 0), name);
             if (!nc) {
-                monitor_printf(mon, "unrecognized (vlan-id, stackname) pair\n");
+                monitor_printf(mon, "unrecognized (hub-id, stackname) pair\n");
                 return NULL;
             }
         } else {
@@ -870,9 +870,9 @@ void hmp_info_usernet(Monitor *mon, const QDict *qdict)
 
     QTAILQ_FOREACH(s, &slirp_stacks, entry) {
         int id;
-        bool got_vlan_id = net_hub_id_for_client(&s->nc, &id) == 0;
-        monitor_printf(mon, "VLAN %d (%s):\n",
-                       got_vlan_id ? id : -1,
+        bool got_hub_id = net_hub_id_for_client(&s->nc, &id) == 0;
+        monitor_printf(mon, "Hub %d (%s):\n",
+                       got_hub_id ? id : -1,
                        s->nc.name);
         slirp_connection_info(s->slirp, mon);
     }
diff --git a/net/tap.c b/net/tap.c
index 2b3a36f..de05f20 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -766,10 +766,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
     queues = tap->has_queues ? tap->queues : 1;
     vhostfdname = tap->has_vhostfd ? tap->vhostfd : NULL;
 
-    /* QEMU vlans does not support multiqueue tap, in this case peer is set.
+    /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->has_fds || tap->has_vhostfds)) {
-        error_setg(errp, "Multiqueue tap cannot be used with QEMU vlans");
+        error_setg(errp, "Multiqueue tap cannot be used with hubs");
         return -1;
     }
 
diff --git a/qapi/net.json b/qapi/net.json
index 9117c56..3929d70 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -209,7 +209,7 @@
 ##
 # @NetdevTapOptions:
 #
-# Connect the host TAP network interface name to the VLAN.
+# Used to configure a host TAP network interface backend.
 #
 # @ifname: interface name
 #
@@ -267,8 +267,8 @@
 ##
 # @NetdevSocketOptions:
 #
-# Connect the VLAN to a remote VLAN in another QEMU virtual machine using a TCP
-# socket connection.
+# Used to establish a network connection to another QEMU virtual machine
+# using a TCP socket connection.
 #
 # @fd: file descriptor of an already opened socket
 #
@@ -296,7 +296,7 @@
 ##
 # @NetdevL2TPv3Options:
 #
-# Connect the VLAN to Ethernet over L2TPv3 Static tunnel
+# Configure an Ethernet over L2TPv3 Static tunnel
 #
 # @src: source address
 #
@@ -352,7 +352,7 @@
 ##
 # @NetdevVdeOptions:
 #
-# Connect the VLAN to a vde switch running on the host.
+# Connect to a vde switch running on the host.
 #
 # @sock: socket path
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 3ece30d..b85c2ab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2003,7 +2003,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                configure a vhost-user network, backed by a chardev 'dev'\n"
 #endif
     "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
-    "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
+    "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
 DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "--nic [tap|bridge|"
 #ifdef CONFIG_SLIRP
@@ -2030,8 +2030,8 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
 DEF("net", HAS_ARG, QEMU_OPTION_net,
     "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
     "                configure or create an on-board (or machine default) NIC and\n"
-    "                connect it either to VLAN 'n' or the netdev 'nd' (for pluggable\n"
-    "                NICs please use '-device devtype,netdev=nd' instead)\n"
+    "                connect it either to hub (a.k.a. vlan) 'n' or the netdev 'nd' (for\n"
+    "                pluggable NICs please use '-device devtype,netdev=nd' instead)\n"
     "-net ["
 #ifdef CONFIG_SLIRP
     "user|"
-- 
1.8.3.1
