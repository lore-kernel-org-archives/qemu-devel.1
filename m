Received: from eggs.gnu.org ([2001:4830:134:3::10]:54148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsX-0007KE-6p
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsU-0007pG-Q4
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:53 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42631
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYGsU-0007oZ-HN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:50 -0400
From: anton.ivanov@cambridgegreys.com
Date: Thu, 20 Jul 2017 20:12:26 +0100
Message-Id: <20170720191228.12342-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] [PATCH v2 3/5] GRETAP Backend for UDST
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

GRETAP Backend for Universal Datagram Socket Transport

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 net/Makefile.objs |   2 +-
 net/clients.h     |   4 +
 net/gre.c         | 340 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/net.c         |   1 +
 qapi-schema.json  |  50 +++++++-
 qemu-options.hx   |  61 +++++++++-
 6 files changed, 453 insertions(+), 5 deletions(-)
 create mode 100644 net/gre.c

diff --git a/net/Makefile.objs b/net/Makefile.objs
index ffdfb96bd0..919bc3d78f 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-y = net.o queue.o checksum.o util.o hub.o
 common-obj-y += socket.o
 common-obj-y += dump.o
 common-obj-y += eth.o
-common-obj-$(CONFIG_UDST) += udst.o l2tpv3.o
+common-obj-$(CONFIG_UDST) += udst.o l2tpv3.o gre.o
 common-obj-$(CONFIG_POSIX) += vhost-user.o
 common-obj-$(CONFIG_SLIRP) += slirp.o
 common-obj-$(CONFIG_VDE) += vde.o
diff --git a/net/clients.h b/net/clients.h
index 5cae479730..8f8a59aee3 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -49,6 +49,10 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 
 int net_init_l2tpv3(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp);
+
+int net_init_gre(const Netdev *netdev, const char *name,
+                    NetClientState *peer, Error **errp);
+
 #ifdef CONFIG_VDE
 int net_init_vde(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp);
diff --git a/net/gre.c b/net/gre.c
new file mode 100644
index 0000000000..d2c96db87e
--- /dev/null
+++ b/net/gre.c
@@ -0,0 +1,340 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2015-2017 Cambridge GREys Limited
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
+#include "net/net.h"
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
+/* IANA-assigned IP protocol ID for GRE */
+
+
+#ifndef IPPROTO_GRE
+#define IPPROTO_GRE 0x2F
+#endif
+
+#define GRE_MODE_CHECKSUM     htons(8 << 12)   /* checksum */
+#define GRE_MODE_RESERVED     htons(4 << 12)   /* unused */
+#define GRE_MODE_KEY          htons(2 << 12)   /* KEY present */
+#define GRE_MODE_SEQUENCE     htons(1 << 12)   /* no sequence */
+
+
+/* GRE TYPE for Ethernet in GRE aka GRETAP */
+
+#define GRE_IRB htons(0x6558)
+
+struct gre_minimal_header {
+   uint16_t header;
+   uint16_t arptype;
+};
+
+typedef struct GRETunnelParams {
+    /*
+     * GRE parameters
+     */
+
+    uint32_t rx_key;
+    uint32_t tx_key;
+    uint32_t sequence;
+
+    /* Flags */
+
+    bool ipv4;
+    bool ipv6;
+    bool udp;
+    bool has_sequence;
+    bool pin_sequence;
+    bool checksum;
+    bool key;
+
+    /* Precomputed GRE specific offsets */
+
+    uint32_t key_offset;
+    uint32_t sequence_offset;
+    uint32_t checksum_offset;
+
+    struct gre_minimal_header header_bits;
+
+} GRETunnelParams;
+
+
+
+static void gre_form_header(void *us)
+{
+    NetUdstState *s = (NetUdstState *) us;
+    GRETunnelParams *p = (GRETunnelParams *) s->params;
+
+    uint32_t *sequence;
+
+    *((uint32_t *) s->header_buf) = *((uint32_t *) &p->header_bits);
+
+    if (p->key) {
+        stl_be_p(
+            (uint32_t *) (s->header_buf + p->key_offset),
+            p->tx_key
+        );
+    }
+    if (p->has_sequence) {
+        sequence = (uint32_t *)(s->header_buf + p->sequence_offset);
+        if (p->pin_sequence) {
+            *sequence = 0;
+        } else {
+            stl_be_p(sequence, ++p->sequence);
+        }
+    }
+}
+
+static int gre_verify_header(void *us, uint8_t *buf)
+{
+
+    NetUdstState *s = (NetUdstState *) us;
+    GRETunnelParams *p = (GRETunnelParams *) s->params;
+    uint32_t key;
+
+
+    if (!p->ipv6) {
+        buf += sizeof(struct iphdr) /* fix for ipv4 raw */;
+    }
+
+    if (*((uint32_t *) buf) != *((uint32_t *) &p->header_bits)) {
+        if (!s->header_mismatch) {
+            error_report("header type disagreement, expecting %0x, got %0x",
+                *((uint32_t *) &p->header_bits), *((uint32_t *) buf));
+        }
+        return -1;
+    }
+
+    if (p->key) {
+        key = ldl_be_p(buf + p->key_offset);
+        if (key != p->rx_key) {
+            if (!s->header_mismatch) {
+                error_report("unknown key id %0x, expecting %0x",
+                    key, p->rx_key);
+            }
+            return -1;
+        }
+    }
+    return 0;
+}
+
+int net_init_gre(const Netdev *netdev,
+                    const char *name,
+                    NetClientState *peer, Error **errp)
+{
+    const NetdevGREOptions *gre;
+    NetUdstState *s;
+    NetClientState *nc;
+    GRETunnelParams *p;
+
+    int fd = -1, gairet;
+    struct addrinfo hints;
+    struct addrinfo *result = NULL;
+
+    nc = qemu_new_udst_net_client(name, peer);
+
+    s = DO_UPCAST(NetUdstState, nc, nc);
+
+    p = g_malloc(sizeof(GRETunnelParams));
+
+    s->params = p;
+    p->header_bits.arptype = GRE_IRB;
+    p->header_bits.header = 0;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_GRE);
+    gre = &netdev->u.gre;
+
+    if ((gre->has_ipv4 && gre->ipv4) &&
+            (gre->has_ipv6 && gre->ipv6)) {
+        error_report("please choose either ipv4 or ipv6");
+        goto outerr;
+    }
+
+    if (gre->has_ipv6 && gre->ipv6) {
+        p->ipv6 = gre->ipv6;
+    } else {
+        p->ipv6 = false;
+    }
+
+    if (gre->has_ipv4 && gre->ipv4) {
+        p->ipv4 = gre->ipv4;
+    } else {
+        p->ipv4 = false;
+    }
+
+
+    s->offset = 4;
+    p->key_offset = 4;
+    p->sequence_offset = 4;
+    p->checksum_offset = 4;
+
+    if (gre->has_rxkey || gre->has_txkey) {
+        if (gre->has_rxkey && gre->has_txkey) {
+            p->key = true;
+            p->header_bits.header |= GRE_MODE_KEY;
+        } else {
+            goto outerr;
+        }
+    } else {
+        p->key = false;
+    }
+
+    if (p->key) {
+        p->rx_key = gre->rxkey;
+        p->tx_key = gre->txkey;
+        s->offset += 4;
+        p->sequence_offset += 4;
+    }
+
+
+    if (gre->has_sequence && gre->sequence) {
+        s->offset += 4;
+        p->has_sequence = true;
+        p->header_bits.header |= GRE_MODE_SEQUENCE;
+    } else {
+        p->sequence = false;
+    }
+
+    if (gre->has_pinsequence && gre->pinsequence) {
+        /* pin sequence implies that there is sequence */
+        p->has_sequence = true;
+        p->pin_sequence = true;
+    } else {
+        p->pin_sequence = false;
+    }
+
+    memset(&hints, 0, sizeof(hints));
+
+    if (p->ipv6) {
+        hints.ai_family = AF_INET6;
+    } else {
+        if (p->ipv4) {
+            hints.ai_family = AF_INET;
+        } else {
+            hints.ai_family = AF_UNSPEC;
+        }
+    }
+
+    hints.ai_socktype = SOCK_RAW;
+    hints.ai_protocol = IPPROTO_GRE;
+
+    gairet = getaddrinfo(gre->src, NULL, &hints, &result);
+
+    if ((gairet != 0) || (result == NULL)) {
+        error_report(
+            "gre_open : could not resolve src, errno = %s",
+            gai_strerror(gairet)
+        );
+        goto outerr;
+    }
+
+    /* Update flags to match actual result of name resolution */
+
+    if (result->ai_family == AF_INET) {
+        p->ipv4 = true;
+        p->ipv6 = false;
+    } else {
+        p->ipv6 = true;
+        p->ipv4 = false;
+    }
+
+    fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
+    if (fd == -1) {
+        fd = -errno;
+        error_report("gre_open : socket creation failed, errno = %d", -fd);
+        goto outerr;
+    }
+    if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen)) {
+        error_report("gre_open :  could not bind socket err=%i", errno);
+        goto outerr;
+    }
+    if (result) {
+        freeaddrinfo(result);
+    }
+
+    memset(&hints, 0, sizeof(hints));
+
+    if (p->ipv6) {
+        hints.ai_family = AF_INET6;
+    } else {
+        hints.ai_family = AF_INET;
+    }
+    hints.ai_socktype = SOCK_RAW;
+    hints.ai_protocol = IPPROTO_GRE;
+
+    result = NULL;
+    gairet = getaddrinfo(gre->dst, NULL, &hints, &result);
+    if ((gairet != 0) || (result == NULL)) {
+        error_report(
+            "gre_open : could not resolve dst, error = %s",
+            gai_strerror(gairet)
+        );
+        goto outerr;
+    }
+
+    s->dgram_dst = g_new0(struct sockaddr_storage, 1);
+    memcpy(s->dgram_dst, result->ai_addr, result->ai_addrlen);
+    s->dst_size = result->ai_addrlen;
+
+    if (result) {
+        freeaddrinfo(result);
+    }
+
+    if ((p->ipv6) || (p->udp)) {
+        s->header_size = s->offset;
+    } else {
+        s->header_size = s->offset + sizeof(struct iphdr);
+    }
+
+    qemu_net_finalize_udst_init(s,
+        &gre_verify_header,
+        &gre_form_header,
+        fd);
+
+    p->sequence = 0;
+
+    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
+             "gre: connected");
+    return 0;
+outerr:
+    error_setg(errp, "Cannot initialize GRE transport");
+    qemu_del_net_client(nc);
+    if (fd >= 0) {
+        close(fd);
+    }
+    if (result) {
+        freeaddrinfo(result);
+    }
+    return -1;
+}
diff --git a/net/net.c b/net/net.c
index 723a256260..6163a8a3af 100644
--- a/net/net.c
+++ b/net/net.c
@@ -962,6 +962,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #endif
 #ifdef CONFIG_UDST
         [NET_CLIENT_DRIVER_L2TPV3] = net_init_l2tpv3,
+        [NET_CLIENT_DRIVER_GRE] = net_init_gre,
 #endif
 };
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 91e27ca2b0..3f2a9bf8a2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3853,7 +3853,44 @@
     'txsession':    'uint32',
     '*rxsession':   'uint32',
     '*offset':      'uint32' } }
-
+##
+# @NetdevGREOptions:
+#
+# Connect the VLAN to Ethernet over Ethernet over GRE (GRETAP) tunnel
+#
+# @src: source address
+#
+# @dst: destination address
+#
+# @ipv4: force the use of ipv4
+#
+# @ipv6: force the use of ipv6
+#
+# @sequence: have sequence counter
+#
+# @pinsequence: pin sequence counter to zero -
+#              workaround for buggy implementations or
+#              networks with packet reorder
+#
+# @txkey: 32 bit transmit key
+#
+# @rxkey: 32 bit receive key
+#
+# Note - gre checksums are not supported at present
+#
+#
+# Since 2.11
+##
+{ 'struct': 'NetdevGREOptions',
+  'data': {
+    'src':          'str',
+    'dst':          'str',
+    '*ipv4':        'bool',
+    '*ipv6':        'bool',
+    '*sequence':     'bool',
+    '*pinsequence':  'bool',
+    '*txkey':    'uint32',
+    '*rxkey':    'uint32' } }
 ##
 # @NetdevUdstOptions:
 #
@@ -3981,10 +4018,14 @@
 # Available netdev drivers.
 #
 # Since: 2.7
+#
+# udst -  since: 2.11
+#
+# gre -  since: 2.11
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
-            'bridge', 'hubport', 'netmap', 'vhost-user', 'udst' ] }
+            'bridge', 'hubport', 'netmap', 'vhost-user', 'udst', 'gre' ] }
 
 ##
 # @Netdev:
@@ -4000,6 +4041,8 @@
 # 'l2tpv3' - since 2.1
 #
 # 'udst' - since 2.11
+#
+# 'gre' - since 2.11
 ##
 { 'union': 'Netdev',
   'base': { 'id': 'str', 'type': 'NetClientDriver' },
@@ -4017,7 +4060,8 @@
     'hubport':  'NetdevHubPortOptions',
     'netmap':   'NetdevNetmapOptions',
     'vhost-user': 'NetdevVhostUserOptions',
-    'udst':     'NetdevUdstOptions' } }
+    'udst':     'NetdevUdstOptions',
+    'gre':      'NetdevGREOptions' } }
 
 ##
 # @NetLegacy:
diff --git a/qemu-options.hx b/qemu-options.hx
index 20e0df6e9c..2692858d94 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1972,6 +1972,24 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use 'counter=off' to force a 'cut-down' L2TPv3 with no counter\n"
     "                use 'pincounter=on' to work around broken counter handling in peer\n"
     "                use 'offset=X' to add an extra offset between header and data\n"
+    "-netdev gre,id=str,src=srcaddr,dst=dstaddr[,rxkey=rxkey],txkey=txkey[,ipv6=on/off]\n"
+    "         [,ipv4=on/off][,sequence][,pinsequence]\n"
+    "                configure a network backend with ID 'str' connected to\n"
+    "                an Ethernet over GRE pseudowire (aka GRE TAP).\n"
+    "                Linux kernel 3.3+ as well as most routers and some switches\n"
+    "                can talk GRETAP. This transport allows connecting a VM to a VM,\n"
+    "                VM to a router and even VM to Host. It is a nearly-universal\n"
+    "                standard (RFC1701).\n"
+    "                use 'src=' to specify source address\n"
+    "                use 'dst=' to specify destination address\n"
+    "                use 'ipv4=on' to force v4\n"
+    "                use 'ipv6=on' to force v6\n"
+    "                GRE may use keys to prevent misconfiguration as\n"
+    "                well as a weak security measure\n"
+    "                use 'rxkey=0x01234' to specify a rxkey\n"
+    "                use 'txkey=0x01234' to specify a txkey\n"
+    "                use 'sequence=on' to add frame sequence to each packet\n"
+    "                use 'pinsequence=on' to work around broken sequence handling in peer\n"
 #endif
     "-netdev socket,id=str[,fd=h][,listen=[host]:port][,connect=host:port]\n"
     "                configure a network backend to connect to another network\n"
@@ -2395,12 +2413,53 @@ ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \
 ifconfig vmtunnel0 mtu 1500
 ifconfig vmtunnel0 up
 brctl addif br-lan vmtunnel0
+@end example
+
+Alternatively, it is possible to assign an IP address to vmtunnel0, which allows
+the VM to connect to the host directly without using Linux bridging.
+
+
+@item -netdev gre,id=@var{id},src=@var{srcaddr},dst=@var{dstaddr}[,ipv4][,ipv6][,sequence][,pinsequence][,txkey=@var{txkey}][,rxkey=@var{rxkey}]
+Connect VLAN @var{n} to a GRE pseudowire. GRE (RFC1701) is a popular
+protocol to transport various data frames between two systems.
+We are interested in a specific GRE variety where the transported
+frames are Ethernet. This GRE type is usually referred to as GRETAP.
+It is present in routers, firewalls, switches and the Linux kernel
+(from version 3.3 onwards).
+
+This transport allows a VM to communicate to another VM, router or firewall directly.
+
+@item src=@var{srcaddr}
+    source address (mandatory)
+@item dst=@var{dstaddr}
+    destination address (mandatory)
+@item ipv6
+    force v6, otherwise defaults to v4.
+@item rxkey=@var{rxkey}
+@itemx txkey=@var{txkey}
+    Keys are a weak form of security in the gre specification.
+Their function is mostly to prevent misconfiguration.
+@item sequence=on
+    Add frame sequence to GRE frames
+@item pinsequence=on
+    Work around broken sequence handling in peer. This may also help on
+networks which have packet reorder.
+
+For example, to attach a VM running on host 4.3.2.1 via GRETAP to the bridge br-lan
+on the remote Linux host 1.2.3.4:
+@example
+# Setup tunnel on linux host using raw ip as encapsulation
+# on 1.2.3.4
+ip link add gt0 type gretap local 1.2.3.4 remote 4.3.2.1
+ifconfig gt0 mtu 1500
+ifconfig gt0 up
+brctl addif br-lan gt0
 
 
 # on 4.3.2.1
 # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
 
-qemu-system-i386 linux.img -net nic -net l2tpv3,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
+qemu-system-i386 linux.img -device virtio-net-pci,netdev=gre0 -netdev gre,id=gre0,src=4.2.3.1,dst=1.2.3.4
 
 
 @end example
-- 
2.11.0
