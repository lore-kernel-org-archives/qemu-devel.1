Received: from eggs.gnu.org ([2001:4830:134:3::10]:44907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDD8J-00055m-4F
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDD8G-0007cJ-3m
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDD8F-0007c6-U6
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Apr 2018 20:02:23 +0200
Message-Id: <1525111345-14606-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1525111345-14606-1-git-send-email-thuth@redhat.com>
References: <1525111345-14606-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/3] net: Remove the deprecated "vlan"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

It's been marked as deprecated since QEMU v2.9.0, so that should have
been enough time for everybody to either just drop unnecessary "vlan=0"
parameters, to switch to the modern -device + -netdev syntax for connecting
guest NICs with host network backends, or to switch to the "hubport" netdev
in case hubs are really wanted instead.

Buglink: https://bugs.launchpad.net/qemu/+bug/658904
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/qdev-device-use.txt         |  3 --
 hw/core/qdev-properties-system.c | 80 ----------------------------------------
 include/hw/qdev-properties.h     |  3 --
 include/net/net.h                |  1 -
 net/net.c                        | 12 ++----
 qapi/net.json                    | 15 ++++----
 qemu-doc.texi                    |  9 -----
 qemu-options.hx                  | 29 ++++++---------
 8 files changed, 22 insertions(+), 130 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 8f188d1..98229b3 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -277,9 +277,6 @@ devices and ne2k_isa are.
 
 Some PCI devices aren't available with -net nic, e.g. i82558a.
 
-To connect to a VLAN instead of an ordinary host part, replace
-netdev=NET-ID by vlan=VLAN.
-
 === Graphics Devices ===
 
 Host and guest part of graphics devices have always been separate.
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1d3ba72..8b22fb5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -321,86 +321,6 @@ const PropertyInfo qdev_prop_netdev = {
     .set   = set_netdev,
 };
 
-/* --- vlan --- */
-
-static int print_vlan(DeviceState *dev, Property *prop, char *dest, size_t len)
-{
-    NetClientState **ptr = qdev_get_prop_ptr(dev, prop);
-
-    if (*ptr) {
-        int id;
-        if (!net_hub_id_for_client(*ptr, &id)) {
-            return snprintf(dest, len, "%d", id);
-        }
-    }
-
-    return snprintf(dest, len, "<null>");
-}
-
-static void get_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    NetClientState **ptr = qdev_get_prop_ptr(dev, prop);
-    int32_t id = -1;
-
-    if (*ptr) {
-        int hub_id;
-        if (!net_hub_id_for_client(*ptr, &hub_id)) {
-            id = hub_id;
-        }
-    }
-
-    visit_type_int32(v, name, &id, errp);
-}
-
-static void set_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
-    NetClientState **ptr = &peers_ptr->ncs[0];
-    Error *local_err = NULL;
-    int32_t id;
-    NetClientState *hubport;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_int32(v, name, &id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    if (id == -1) {
-        *ptr = NULL;
-        return;
-    }
-    if (*ptr) {
-        error_set_from_qdev_prop_error(errp, -EINVAL, dev, prop, name);
-        return;
-    }
-
-    hubport = net_hub_port_find(id);
-    if (!hubport) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   name, prop->info->name);
-        return;
-    }
-    *ptr = hubport;
-}
-
-const PropertyInfo qdev_prop_vlan = {
-    .name  = "int32",
-    .description = "Integer VLAN id to connect to",
-    .print = print_vlan,
-    .get   = get_vlan,
-    .set   = set_vlan,
-};
 
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp)
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b2ad8e9..4f60cc8 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -29,7 +29,6 @@ extern const PropertyInfo qdev_prop_bios_chs_trans;
 extern const PropertyInfo qdev_prop_fdc_drive_type;
 extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_netdev;
-extern const PropertyInfo qdev_prop_vlan;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
@@ -195,8 +194,6 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
-#define DEFINE_PROP_VLAN(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_vlan, NICPeers)
 #define DEFINE_PROP_DRIVE(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
diff --git a/include/net/net.h b/include/net/net.h
index 1f7341e..1425960 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -37,7 +37,6 @@ typedef struct NICConf {
 
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
-    DEFINE_PROP_VLAN("vlan",     _state, _conf.peers),                   \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
 
 
diff --git a/net/net.c b/net/net.c
index 29f8398..72c275e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -965,7 +965,6 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
     const Netdev *netdev;
     const char *name;
     NetClientState *peer = NULL;
-    static bool vlan_warned;
 
     if (is_netdev) {
         netdev = object;
@@ -1036,15 +1035,10 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
             return -1;
         }
 
-        /* Do not add to a vlan if it's a nic with a netdev= parameter. */
+        /* Do not add to a hub if it's a nic with a netdev= parameter. */
         if (netdev->type != NET_CLIENT_DRIVER_NIC ||
             !opts->u.nic.has_netdev) {
-            peer = net_hub_add_port(net->has_vlan ? net->vlan : 0, NULL, NULL);
-        }
-
-        if (net->has_vlan && !vlan_warned) {
-            error_report("'vlan' is deprecated. Please use 'netdev' instead.");
-            vlan_warned = true;
+            peer = net_hub_add_port(0, NULL, NULL);
         }
     }
 
@@ -1365,7 +1359,7 @@ void qmp_set_link(const char *name, bool up, Error **errp)
          * If the peer is a HUBPORT or a backend, we do not change the
          * link status.
          *
-         * This behavior is compatible with qemu vlans where there could be
+         * This behavior is compatible with qemu hubs where there could be
          * multiple clients that can still communicate with each other in
          * disconnected mode. For now maintain this compatibility.
          */
diff --git a/qapi/net.json b/qapi/net.json
index 9117c56..b4fe4b6 100644
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
+# Socket netdevs are used to establish a network connection to another
+# QEMU virtual machine via a TCP socket.
 #
 # @fd: file descriptor of an already opened socket
 #
@@ -296,7 +296,7 @@
 ##
 # @NetdevL2TPv3Options:
 #
-# Connect the VLAN to Ethernet over L2TPv3 Static tunnel
+# Configure an Ethernet over L2TPv3 tunnel.
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
@@ -490,8 +490,6 @@
 #
 # Captures the configuration of a network device; legacy.
 #
-# @vlan: vlan number
-#
 # @id: identifier for monitor commands
 #
 # @name: identifier for monitor commands, ignored if @id is present
@@ -499,10 +497,11 @@
 # @opts: device type specific properties (legacy)
 #
 # Since: 1.2
+#
+# 'vlan' - removed with 2.12
 ##
 { 'struct': 'NetLegacy',
   'data': {
-    '*vlan': 'int32',
     '*id':   'str',
     '*name': 'str',
     'opts':  'NetLegacyOptions' } }
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5813d27..b901cc2 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2855,15 +2855,6 @@ with ``-device ...,netdev=x''), or ``-nic user,smb=/some/dir''
 (for embedded NICs). The new syntax allows different settings to be
 provided per NIC.
 
-@subsection -net vlan (since 2.9.0)
-
-The ``-net vlan=NN'' argument was mostly used to attach separate
-network backends to different virtual NICs.  This is the default
-behavior for ``-netdev'' and ``-nic''.  You can connect multiple
-``-netdev'' and ``-nic'' devices to the same network using the
-"hubport" network backend, created with ``-netdev hubport,hubid=NN,...''
-and ``-nic hubport,hubid=NN''.
-
 @subsection -drive cyls=...,heads=...,secs=...,trans=... (since 2.10.0)
 
 The drive geometry arguments are replaced by the the geometry arguments
diff --git a/qemu-options.hx b/qemu-options.hx
index c611766..3588b04 100644
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
@@ -2028,10 +2028,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "                provided a 'user' network connection)\n",
     QEMU_ARCH_ALL)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
-    "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
+    "-net nic[,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
     "                configure or create an on-board (or machine default) NIC and\n"
-    "                connect it either to VLAN 'n' or the netdev 'nd' (for pluggable\n"
-    "                NICs please use '-device devtype,netdev=nd' instead)\n"
+    "                connect it to hub 0 (please use -nic unless you need a hub)\n"
     "-net ["
 #ifdef CONFIG_SLIRP
     "user|"
@@ -2044,7 +2043,7 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
 #ifdef CONFIG_NETMAP
     "netmap|"
 #endif
-    "socket][,vlan=n][,option][,option][,...]\n"
+    "socket][,option][,option][,...]\n"
     "                old way to initialize a host network interface\n"
     "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
 STEXI
@@ -2462,17 +2461,14 @@ qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,sha
 Create a hub port on the emulated hub with ID @var{hubid}.
 
 The hubport netdev lets you connect a NIC to a QEMU emulated hub instead of a
-single netdev. @code{-net} and @code{-device} with the parameter @option{vlan}
-(deprecated), or @code{-nic hubport} can also be used to connect a
-network device or a NIC to a hub. Alternatively, you can also connect the
-hubport to another netdev with ID @var{nd} by using the @option{netdev=@var{nd}}
-option.
+single netdev. Alternatively, you can also connect the hubport to another
+netdev with ID @var{nd} by using the @option{netdev=@var{nd}} option.
 
-@item -net nic[,vlan=@var{n}][,netdev=@var{nd}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
+@item -net nic[,netdev=@var{nd}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
 @findex -net
 Legacy option to configure or create an on-board (or machine default) Network
-Interface Card(NIC) and connect it either to the emulated hub port ("vlan")
-with number @var{n} (@var{n} = 0 is the default), or to the netdev @var{nd}.
+Interface Card(NIC) and connect it either to the emulated hub with ID 0 (i.e.
+the default hub), or to the netdev @var{nd}.
 The NIC is an e1000 by default on the PC target. Optionally, the MAC address
 can be changed to @var{mac}, the device address set to @var{addr} (PCI cards
 only), and a @var{name} can be assigned for use in monitor commands.
@@ -2482,11 +2478,10 @@ that the card should have; this option currently only affects virtio cards; set
 NIC is created.  QEMU can emulate several different models of network card.
 Use @code{-net nic,model=help} for a list of available devices for your target.
 
-@item -net user|tap|bridge|socket|l2tpv3|vde[,...][,vlan=@var{n}][,name=@var{name}]
+@item -net user|tap|bridge|socket|l2tpv3|vde[,...][,name=@var{name}]
 Configure a host network backend (with the options corresponding to the same
-@option{-netdev} option) and connect it to the emulated hub ("vlan") with the
-number @var{n} (default is number 0). Use @var{name} to specify the name of the
-hub port.
+@option{-netdev} option) and connect it to the emulated hub 0 (the default
+hub). Use @var{name} to specify the name of the hub port.
 ETEXI
 
 STEXI
-- 
1.8.3.1
