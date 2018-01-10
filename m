Received: from eggs.gnu.org ([2001:4830:134:3::10]:54640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZJHN-0005rs-Su
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZJHJ-00020n-B7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:31:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eZJHJ-000208-1v
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:31:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A31DC098D18
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 16:31:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 10 Jan 2018 17:30:55 +0100
Message-Id: <1515601855-24457-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Remove the deprecated way of dumping
 network packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

"-net dump" has been marked as deprecated since QEMU v2.10, since it
only works with the deprecated 'vlan' parameter. Network dumping should
be done with "-object filter-dump" nowadays instead. So let's finally
get rid of "-net dump" now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/dump.c      | 102 ++------------------------------------------------------
 net/net.c       |   9 +----
 qapi/net.json   |  27 +++------------
 qemu-doc.texi   |   6 ----
 qemu-options.hx |   8 -----
 5 files changed, 7 insertions(+), 145 deletions(-)

diff --git a/net/dump.c b/net/dump.c
index 15df9a4..f16c354 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -109,7 +109,7 @@ static int net_dump_state_init(DumpState *s, const char *filename,
 
     fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY | O_BINARY, 0644);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "-net dump: can't open %s", filename);
+        error_setg_errno(errp, errno, "net dump: can't open %s", filename);
         return -1;
     }
 
@@ -122,7 +122,7 @@ static int net_dump_state_init(DumpState *s, const char *filename,
     hdr.linktype = 1;
 
     if (write(fd, &hdr, sizeof(hdr)) < sizeof(hdr)) {
-        error_setg_errno(errp, errno, "-net dump write error");
+        error_setg_errno(errp, errno, "net dump write error");
         close(fd);
         return -1;
     }
@@ -136,104 +136,6 @@ static int net_dump_state_init(DumpState *s, const char *filename,
     return 0;
 }
 
-/* Dumping via VLAN netclient */
-
-struct DumpNetClient {
-    NetClientState nc;
-    DumpState ds;
-};
-typedef struct DumpNetClient DumpNetClient;
-
-static ssize_t dumpclient_receive(NetClientState *nc, const uint8_t *buf,
-                                  size_t size)
-{
-    DumpNetClient *dc = DO_UPCAST(DumpNetClient, nc, nc);
-    struct iovec iov = {
-        .iov_base = (void *)buf,
-        .iov_len = size
-    };
-
-    return dump_receive_iov(&dc->ds, &iov, 1);
-}
-
-static ssize_t dumpclient_receive_iov(NetClientState *nc,
-                                      const struct iovec *iov, int cnt)
-{
-    DumpNetClient *dc = DO_UPCAST(DumpNetClient, nc, nc);
-
-    return dump_receive_iov(&dc->ds, iov, cnt);
-}
-
-static void dumpclient_cleanup(NetClientState *nc)
-{
-    DumpNetClient *dc = DO_UPCAST(DumpNetClient, nc, nc);
-
-    dump_cleanup(&dc->ds);
-}
-
-static NetClientInfo net_dump_info = {
-    .type = NET_CLIENT_DRIVER_DUMP,
-    .size = sizeof(DumpNetClient),
-    .receive = dumpclient_receive,
-    .receive_iov = dumpclient_receive_iov,
-    .cleanup = dumpclient_cleanup,
-};
-
-int net_init_dump(const Netdev *netdev, const char *name,
-                  NetClientState *peer, Error **errp)
-{
-    int len, rc;
-    const char *file;
-    char def_file[128];
-    const NetdevDumpOptions *dump;
-    NetClientState *nc;
-    DumpNetClient *dnc;
-
-    assert(netdev->type == NET_CLIENT_DRIVER_DUMP);
-    dump = &netdev->u.dump;
-
-    assert(peer);
-
-    error_report("'-net dump' is deprecated. "
-                 "Please use '-object filter-dump' instead.");
-
-    if (dump->has_file) {
-        file = dump->file;
-    } else {
-        int id;
-        int ret;
-
-        ret = net_hub_id_for_client(peer, &id);
-        assert(ret == 0); /* peer must be on a hub */
-
-        snprintf(def_file, sizeof(def_file), "qemu-vlan%d.pcap", id);
-        file = def_file;
-    }
-
-    if (dump->has_len) {
-        if (dump->len > INT_MAX) {
-            error_setg(errp, "invalid length: %"PRIu64, dump->len);
-            return -1;
-        }
-        len = dump->len;
-    } else {
-        len = 65536;
-    }
-
-    nc = qemu_new_net_client(&net_dump_info, peer, "dump", name);
-    snprintf(nc->info_str, sizeof(nc->info_str),
-             "dump to %s (len=%d)", file, len);
-
-    dnc = DO_UPCAST(DumpNetClient, nc, nc);
-    rc = net_dump_state_init(&dnc->ds, file, len, errp);
-    if (rc) {
-        qemu_del_net_client(nc);
-    }
-    return rc;
-}
-
-/* Dumping via filter */
-
 #define TYPE_FILTER_DUMP "filter-dump"
 
 #define FILTER_DUMP(obj) \
diff --git a/net/net.c b/net/net.c
index 2b81c93..df12c14 100644
--- a/net/net.c
+++ b/net/net.c
@@ -60,7 +60,6 @@ static QTAILQ_HEAD(, NetClientState) net_clients;
 const char *host_net_devices[] = {
     "tap",
     "socket",
-    "dump",
 #ifdef CONFIG_NET_BRIDGE
     "bridge",
 #endif
@@ -964,7 +963,6 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #ifdef CONFIG_NETMAP
         [NET_CLIENT_DRIVER_NETMAP]    = net_init_netmap,
 #endif
-        [NET_CLIENT_DRIVER_DUMP]      = net_init_dump,
 #ifdef CONFIG_NET_BRIDGE
         [NET_CLIENT_DRIVER_BRIDGE]    = net_init_bridge,
 #endif
@@ -990,8 +988,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
         netdev = object;
         name = netdev->id;
 
-        if (netdev->type == NET_CLIENT_DRIVER_DUMP ||
-            netdev->type == NET_CLIENT_DRIVER_NIC ||
+        if (netdev->type == NET_CLIENT_DRIVER_NIC ||
             !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
                        "a netdev backend type");
@@ -1033,10 +1030,6 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
             legacy.type = NET_CLIENT_DRIVER_VDE;
             legacy.u.vde = opts->u.vde;
             break;
-        case NET_LEGACY_OPTIONS_TYPE_DUMP:
-            legacy.type = NET_CLIENT_DRIVER_DUMP;
-            legacy.u.dump = opts->u.dump;
-            break;
         case NET_LEGACY_OPTIONS_TYPE_BRIDGE:
             legacy.type = NET_CLIENT_DRIVER_BRIDGE;
             legacy.u.bridge = opts->u.bridge;
diff --git a/qapi/net.json b/qapi/net.json
index 1238ba5..15ca2ed 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -39,8 +39,8 @@
 #
 # Add a network backend.
 #
-# @type: the type of network backend.  Current valid values are 'user', 'tap',
-#        'vde', 'socket', 'dump' and 'bridge'
+# @type: the type of network backend.  Current valid values are for example
+#        'user', 'tap', 'vde', 'socket', 'hubport' and 'bridge'
 #
 # @id: the name of the new network backend
 #
@@ -372,23 +372,6 @@
     '*mode':  'uint16' } }
 
 ##
-# @NetdevDumpOptions:
-#
-# Dump VLAN network traffic to a file.
-#
-# @len: per-packet size limit (64k default). Understands [TGMKkb]
-# suffixes.
-#
-# @file: dump file path (default is qemu-vlan0.pcap)
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevDumpOptions',
-  'data': {
-    '*len':  'size',
-    '*file': 'str' } }
-
-##
 # @NetdevBridgeOptions:
 #
 # Connect a host TAP network interface to a host bridge device.
@@ -468,7 +451,7 @@
 # Since: 2.7
 ##
 { 'enum': 'NetClientDriver',
-  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
+  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
             'bridge', 'hubport', 'netmap', 'vhost-user' ] }
 
 ##
@@ -495,7 +478,6 @@
     'l2tpv3':   'NetdevL2TPv3Options',
     'socket':   'NetdevSocketOptions',
     'vde':      'NetdevVdeOptions',
-    'dump':     'NetdevDumpOptions',
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
     'netmap':   'NetdevNetmapOptions',
@@ -530,7 +512,7 @@
 ##
 { 'enum': 'NetLegacyOptionsType',
   'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-           'dump', 'bridge', 'netmap', 'vhost-user'] }
+           'bridge', 'netmap', 'vhost-user'] }
 
 ##
 # @NetLegacyOptions:
@@ -550,7 +532,6 @@
     'l2tpv3':   'NetdevL2TPv3Options',
     'socket':   'NetdevSocketOptions',
     'vde':      'NetdevVdeOptions',
-    'dump':     'NetdevDumpOptions',
     'bridge':   'NetdevBridgeOptions',
     'netmap':   'NetdevNetmapOptions',
     'vhost-user': 'NetdevVhostUserOptions' } }
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 9d01598..aeaf440 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2699,12 +2699,6 @@ that can be specified with the ``-device'' parameter.
 The drive addr argument is replaced by the the addr argument
 that can be specified with the ``-device'' parameter.
 
-@subsection -net dump (since 2.10.0)
-
-The ``--net dump'' argument is now replaced with the
-``-object filter-dump'' argument which works in combination
-with the modern ``-netdev`` backends instead.
-
 @subsection -usbdevice (since 2.10.0)
 
 The ``-usbdevice DEV'' argument is now a synonym for setting
diff --git a/qemu-options.hx b/qemu-options.hx
index 9ec4af7..130016c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2024,8 +2024,6 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                configure or create an on-board (or machine default) NIC and\n"
     "                connect it either to VLAN 'n' or the netdev 'nd' (for pluggable\n"
     "                NICs please use '-device devtype,netdev=nd' instead)\n"
-    "-net dump[,vlan=n][,file=f][,len=n]\n"
-    "                dump traffic on vlan 'n' to file 'f' (max n bytes per packet)\n"
     "-net none       use it alone to have zero network devices. If no -net option\n"
     "                is provided, the default is '-net nic -net user'\n"
     "-net ["
@@ -2473,12 +2471,6 @@ qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,sha
      -device virtio-net-pci,netdev=net0
 @end example
 
-@item -net dump[,vlan=@var{n}][,file=@var{file}][,len=@var{len}]
-Dump network traffic on VLAN @var{n} to file @var{file} (@file{qemu-vlan0.pcap} by default).
-At most @var{len} bytes (64k by default) per packet are stored. The file format is
-libpcap, so it can be analyzed with tools such as tcpdump or Wireshark.
-Note: For devices created with '-netdev', use '-object filter-dump,...' instead.
-
 @item -net none
 Indicate that no network devices should be configured. It is used to
 override the default configuration (@option{-net nic -net user}) which
-- 
1.8.3.1
