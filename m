Received: from eggs.gnu.org ([2001:4830:134:3::10]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsW-0007JM-7z
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsU-0007p7-IL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:52 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42628
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYGsU-0007oP-9i
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:50 -0400
From: anton.ivanov@cambridgegreys.com
Date: Thu, 20 Jul 2017 20:12:27 +0100
Message-Id: <20170720191228.12342-5-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] [PATCH v2 4/5] Raw Backend for UDST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Raw Socket Backend for Universal Datagram Socket Transport

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 net/Makefile.objs |   2 +-
 net/clients.h     |   3 ++
 net/net.c         |   1 +
 net/raw.c         | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json  |  20 ++++++++-
 qemu-options.hx   |  32 ++++++++++++++
 6 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 net/raw.c

diff --git a/net/Makefile.objs b/net/Makefile.objs
index 919bc3d78f..457297b5ed 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-y = net.o queue.o checksum.o util.o hub.o
 common-obj-y += socket.o
 common-obj-y += dump.o
 common-obj-y += eth.o
-common-obj-$(CONFIG_UDST) += udst.o l2tpv3.o gre.o
+common-obj-$(CONFIG_UDST) += udst.o l2tpv3.o gre.o raw.o
 common-obj-$(CONFIG_POSIX) += vhost-user.o
 common-obj-$(CONFIG_SLIRP) += slirp.o
 common-obj-$(CONFIG_VDE) += vde.o
diff --git a/net/clients.h b/net/clients.h
index 8f8a59aee3..98d8ae59b7 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -53,6 +53,9 @@ int net_init_l2tpv3(const Netdev *netdev, const char *name,
 int net_init_gre(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp);
 
+int net_init_raw(const Netdev *netdev, const char *name,
+                    NetClientState *peer, Error **errp);
+
 #ifdef CONFIG_VDE
 int net_init_vde(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp);
diff --git a/net/net.c b/net/net.c
index 6163a8a3af..8eb0aa2bee 100644
--- a/net/net.c
+++ b/net/net.c
@@ -963,6 +963,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #ifdef CONFIG_UDST
         [NET_CLIENT_DRIVER_L2TPV3] = net_init_l2tpv3,
         [NET_CLIENT_DRIVER_GRE] = net_init_gre,
+        [NET_CLIENT_DRIVER_RAW] = net_init_raw,
 #endif
 };
 
diff --git a/net/raw.c b/net/raw.c
new file mode 100644
index 0000000000..8f73248095
--- /dev/null
+++ b/net/raw.c
@@ -0,0 +1,123 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2015-2017 Cambridge Greys Limited
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2012-2014 Cisco Systems
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/ip.h>
+#include <netdb.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include "net/net.h"
+#include <sys/socket.h>
+#include <linux/if_packet.h>
+#include <net/ethernet.h>
+#include "clients.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu/sockets.h"
+#include "qemu/iov.h"
+#include "qemu/main-loop.h"
+#include "udst.h"
+
+static int noop(void *us, uint8_t *buf)
+{
+    return 0;
+}
+
+int net_init_raw(const Netdev *netdev,
+                    const char *name,
+                    NetClientState *peer, Error **errp)
+{
+
+    const NetdevRawOptions *raw;
+    NetUdstState *s;
+    NetClientState *nc;
+
+    int fd = -1;
+    int err;
+
+    struct ifreq ifr;
+    struct sockaddr_ll sock;
+
+
+    nc = qemu_new_udst_net_client(name, peer);
+
+    s = DO_UPCAST(NetUdstState, nc, nc);
+
+    fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+    if (fd == -1) {
+        err = -errno;
+        error_report("raw_open : raw socket creation failed, errno = %d", -err);
+        goto outerr;
+    }
+
+
+    s->dgram_dst = NULL;
+    s->dst_size = 0;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_RAW);
+    raw = &netdev->u.raw;
+
+    memset(&ifr, 0, sizeof(struct ifreq));
+    strncpy((char *) &ifr.ifr_name, raw->ifname, sizeof(ifr.ifr_name) - 1);
+
+    if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
+        err = -errno;
+        error_report("SIOCGIFINDEX, failed to get raw interface index for %s",
+            raw->ifname);
+        goto outerr;
+    }
+
+    sock.sll_family = AF_PACKET;
+    sock.sll_protocol = htons(ETH_P_ALL);
+    sock.sll_ifindex = ifr.ifr_ifindex;
+
+    if (bind(fd, (struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+        error_report("raw: failed to bind raw socket");
+        err = -errno;
+        goto outerr;
+    }
+
+    s->offset = 0;
+
+    qemu_net_finalize_udst_init(s,
+        &noop,
+        NULL,
+        fd);
+
+    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
+             "raw: connected");
+    return 0;
+outerr:
+    error_setg(errp, "Cannot initialize GRE transport");
+    qemu_del_net_client(nc);
+    if (fd >= 0) {
+        close(fd);
+    }
+    return -1;
+}
+
diff --git a/qapi-schema.json b/qapi-schema.json
index 3f2a9bf8a2..6882fb7fc6 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3904,6 +3904,21 @@
   'data': { } }
 
 ##
+# @NetdevRawOptions:
+#
+# Connect the VLAN to an network interface using raw sockets
+#
+# @ifname: network interface name
+#
+
+# Since 2.9
+##
+{ 'struct': 'NetdevRawOptions',
+  'data': {
+    'ifname':          'str'
+} }
+
+##
 # @NetdevVdeOptions:
 #
 # Connect the VLAN to a vde switch running on the host.
@@ -4025,7 +4040,7 @@
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
-            'bridge', 'hubport', 'netmap', 'vhost-user', 'udst', 'gre' ] }
+            'bridge', 'hubport', 'netmap', 'vhost-user', 'udst', 'gre', 'raw' ] }
 
 ##
 # @Netdev:
@@ -4061,7 +4076,8 @@
     'netmap':   'NetdevNetmapOptions',
     'vhost-user': 'NetdevVhostUserOptions',
     'udst':     'NetdevUdstOptions',
-    'gre':      'NetdevGREOptions' } }
+    'gre':      'NetdevGREOptions',
+    'raw':      'NetdevRawOptions' } }
 
 ##
 # @NetLegacy:
diff --git a/qemu-options.hx b/qemu-options.hx
index 2692858d94..6a24cafdf5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1990,6 +1990,13 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use 'txkey=0x01234' to specify a txkey\n"
     "                use 'sequence=on' to add frame sequence to each packet\n"
     "                use 'pinsequence=on' to work around broken sequence handling in peer\n"
+    "-netdev raw,id=str,ifname=ifname\n"
+    "                configure a network backend with ID 'str' connected to\n"
+    "                an Ethernet interface named ifname via raw socket.\n"
+    "                This backend does not change the interface settings.\n"
+    "                Most interfaces will require being set into promisc mode,\n"
+    "                as well having most offloads (TSO, etc) turned off.\n"
+    "                Some virtual interfaces like tap support only RX.\n"
 #endif
     "-netdev socket,id=str[,fd=h][,listen=[host]:port][,connect=host:port]\n"
     "                configure a network backend to connect to another network\n"
@@ -2464,6 +2471,31 @@ qemu-system-i386 linux.img -device virtio-net-pci,netdev=gre0 -netdev gre,id=gre
 
 @end example
 
+@item -netdev raw,id=@var{id},ifname=@var{ifname}
+Connect VLAN @var{n} directly to an Ethernet interface using raw socket.
+
+This transport allows a VM to bypass most of the network stack which is
+extremely useful for tapping.
+
+@item ifname=@var{ifname}
+    interface name (mandatory)
+
+@example
+# set up the interface - put it in promiscuous mode and turn off offloads
+ifconfig eth0 up
+ifconfig eth0 promisc
+
+/sbin/ethtool -K eth0 gro off
+/sbin/ethtool -K eth0 tso off
+/sbin/ethtool -K eth0 gso off
+/sbin/ethtool -K eth0 tx off
+
+# launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
+
+qemu-system-i386 linux.img -device virtio-net-pci,netdev=raw0 -netdev raw,id=raw0,ifname=eth0
+
+@end example
+
 @item -netdev vde,id=@var{id}[,sock=@var{socketpath}][,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
 @itemx -net vde[,vlan=@var{n}][,name=@var{name}][,sock=@var{socketpath}] [,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
 Connect VLAN @var{n} to PORT @var{n} of a vde switch running on host and
-- 
2.11.0
