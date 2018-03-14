Received: from eggs.gnu.org ([2001:4830:134:3::10]:55526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1ewBlG-0008PZ-2U
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1ewBlB-0007Xt-TK
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:08:30 -0400
Received: from mx1.profitbricks.com ([46.16.72.21]:54728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1ewBlB-0007X1-JB
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:08:25 -0400
Received: from mail.pb.local (mail.pb.local [192.168.178.100])
	by mx1.profitbricks.com (Postfix) with ESMTP id DFB535F51F
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 19:08:23 +0000 (UTC)
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Wed, 14 Mar 2018 20:08:14 +0100
Message-Id: <20180314190814.22631-1-benjamin.drung@profitbricks.com>
Subject: [Qemu-devel] [PATCH 2/2 v3] slirp: Add classless static routes
 support to DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@gnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Benjamin Drung <benjamin.drung@profitbricks.com>

This patch will allow the user to specify classless static routes for
the replies from the built-in DHCP server, for example:

  qemu --net user,route=10.0.2.0/24,route=192.168.0.0/16 [...]

The QMP schema for the "route" option is ['str'], because the opts
visitor code only supports lists with a single mandatory scalar member.
The option "ipv6-net" takes two pieces and is split in net_client_init()
into "ipv6-prefix" and "ipv6-prefixlen" before calling
visit_type_Netdev()/visit_type_NetLegacy(). But that logic cannot be
used for the "route" option, because there is no intermediate format to
store the split parts for further processing without overhauling the
visitor code. Once the opts visitor supports lists with multiple
members, please update the QMP schema to:

{ 'struct': 'RouteEntry',
  'data': {
    'subnet': 'str',
    'mask_width': 'uint8',
    '*gateway': 'str' } }
[...]
'route': [ 'RouteEntry' ]

Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
---
v2: Address all remarks from Samuel Thibault:
 * Initialize values directly before usage
 * Make :gateway part optional
 * change formula for significant octet calculation
 * do not calculate significant_octets/option_length twice

v3:
 * change QMP member 'route' from ['String'] to ['str']
 * use '--net' in the documentation

 net/slirp.c      | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 qapi/net.json    |  4 ++++
 qemu-options.hx  | 14 +++++++++++-
 slirp/bootp.c    | 20 +++++++++++++++++
 slirp/bootp.h    |  2 ++
 slirp/libslirp.h |  9 +++++++-
 slirp/slirp.c    |  7 +++++-
 slirp/slirp.h    |  2 ++
 8 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 8c08e5644f..6611eb257f 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -158,7 +158,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *vnameserver, const char *vnameserver6,
                           const char *smb_export, const char *vsmbserver,
                           const char **dnssearch, const char *vdomainname,
-                          Error **errp)
+                          const strList *vroutes, Error **errp)
 {
     /* default settings according to historic slirp */
     struct in_addr net  = { .s_addr = htonl(0x0a000200) }; /* 10.0.2.0 */
@@ -177,8 +177,12 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     char buf[20];
     uint32_t addr;
     int shift;
+    unsigned int i;
     char *end;
+    unsigned int route_count;
     struct slirp_config_str *config;
+    struct StaticRoute *routes = NULL;
+    const strList *iter;
 
     if (!ipv4 && (vnetwork || vhost || vnameserver)) {
         error_setg(errp, "IPv4 disabled but netmask/host/dns provided");
@@ -365,6 +369,61 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         return -1;
     }
 
+    iter = vroutes;
+    route_count = 0;
+    while (iter) {
+        route_count++;
+        iter = iter->next;
+    }
+    routes = g_malloc(route_count * sizeof(StaticRoute));
+
+    i = 0;
+    iter = vroutes;
+    while(iter != NULL) {
+        char buf2[20];
+        const char *gateway = iter->value;
+        const char *mask;
+        char *end;
+        long mask_width;
+
+        // Split "subnet/mask[:gateway]" into its components
+        if (get_str_sep(buf2, sizeof(buf2), &gateway, ':') < 0) {
+            // Fallback to default gateway
+            routes[i].gateway.s_addr = host.s_addr;
+            mask = gateway;
+        } else {
+            if (!inet_aton(gateway, &routes[i].gateway)) {
+                error_setg(errp, "Failed to parse route gateway '%s'", gateway);
+                return -1;
+            }
+            mask = buf2;
+        }
+
+        if (get_str_sep(buf, sizeof(buf), &mask, '/') < 0) {
+            error_setg(errp, "Failed to parse route: No slash found in '%s'",
+                       mask);
+            return -1;
+        }
+        if (!inet_aton(buf, &routes[i].subnet)) {
+            error_setg(errp, "Failed to parse route subnet '%s'", buf);
+            return -1;
+        }
+
+        mask_width = strtol(mask, &end, 10);
+        if (*end != '\0') {
+            error_setg(errp,
+                       "Failed to parse netmask '%s' (trailing chars)", mask);
+            return -1;
+        } else if (mask_width < 0 || mask_width > 32) {
+            error_setg(errp,
+                       "Invalid netmask provided (must be in range 0-32)");
+            return -1;
+        }
+        routes[i].mask_width = (uint8_t)mask_width;
+
+        iter = iter->next;
+        i++;
+    }
 
     nc = qemu_new_net_client(&net_slirp_info, peer, model, name);
 
@@ -377,7 +436,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
                           vhostname, tftp_export, bootfile, dhcp,
-                          dns, ip6_dns, dnssearch, vdomainname, s);
+                          dns, ip6_dns, dnssearch, vdomainname,
+                          route_count, routes, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
 
     for (config = slirp_configs; config; config = config->next) {
@@ -409,6 +469,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     return 0;
 
 error:
+    g_free(routes);
     qemu_del_net_client(nc);
     return -1;
 }
@@ -964,7 +1025,8 @@ int net_init_slirp(const Netdev *netdev, const char *name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch, user->domainname, errp);
+                         user->smbserver, dnssearch, user->domainname,
+                         user->route, errp);
 
     while (slirp_configs) {
         config = slirp_configs;
diff --git a/qapi/net.json b/qapi/net.json
index 36589857f4..a08df54bcf 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -163,6 +163,9 @@
 # @domainname: guest-visible domain name of the virtual nameserver
 #              (since 2.12)
 #
+# @route: guest-visible static classless route of the virtual nameserver
+#         (since 2.12)
+#
 # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
 #               2.6). The network prefix is given in the usual
 #               hexadecimal IPv6 address notation.
@@ -201,6 +204,7 @@
     '*dns':       'str',
     '*dnssearch': ['String'],
     '*domainname': 'str',
+    '*route':     ['str'],
     '*ipv6-prefix':      'str',
     '*ipv6-prefixlen':   'int',
     '*ipv6-host':        'str',
diff --git a/qemu-options.hx b/qemu-options.hx
index 8e88ba6b36..333908a999 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1904,7 +1904,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
     "         [,restrict=on|off][,hostname=host][,dhcpstart=addr]\n"
     "         [,dns=addr][,ipv6-dns=addr][,dnssearch=domain][,domainname=domain]\n"
-    "         [,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
+    "         [,route=addr/mask[:gateway]][,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
 #ifndef _WIN32
                                              "[,smb=dir[,smbserver=addr]]\n"
 #endif
@@ -2137,6 +2137,18 @@ qemu -net user,dnssearch=mgmt.example.org,dnssearch=example.org [...]
 @item domainname=@var{domain}
 Specifies the client domain name reported by the built-in DHCP server.
 
+@item route=@var{addr}/@var{mask}[:@var{gateway}]
+Provides an entry for the classless static routes list sent by the built-in
+DHCP server. More than one route can be transmitted by specifying
+this option multiple times. If supported, this will cause the guest to
+automatically set the given static routes instead of the given default gateway.
+If @var{gateway} is not specified, the default gateway will be used.
+
+Example:
+@example
+qemu --net user,route=10.0.2.0/24,route=192.168.0.0/16 [...]
+@end example
+
 @item tftp=@var{dir}
 When using the user mode network stack, activate a built-in TFTP
 server. The files in @var{dir} will be exposed as the root of a TFTP server.
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 9e7b53ba94..5ca3b74e3b 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -160,6 +160,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
     int dhcp_msg_type, val;
     uint8_t *q;
     uint8_t client_ethaddr[ETH_ALEN];
+    uint8_t significant_octets[slirp->route_count];
 
     /* extract exact DHCP msg type */
     dhcp_decode(bp, &dhcp_msg_type, &preq_addr);
@@ -306,6 +307,25 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
             q += val;
         }
 
+        if (slirp->route_count > 0) {
+            uint8_t option_length = 0;
+
+            for (int i = 0; i < slirp->route_count; i++) {
+                significant_octets[i] = (slirp->routes[i].mask_width + 7) / 8;
+                option_length += significant_octets[i] + 5;
+            }
+
+            *q++ = RFC3442_CLASSLESS_STATIC_ROUTE;
+            *q++ = option_length;
+            for (int i = 0; i < slirp->route_count; i++) {
+                *q++ = slirp->routes[i].mask_width;
+                memcpy(q, &slirp->routes[i].subnet.s_addr, significant_octets[i]);
+                q += significant_octets[i];
+                memcpy(q, &slirp->routes[i].gateway.s_addr, 4);
+                q += 4;
+            }
+        }
+
         if (slirp->vdnssearch) {
             size_t spaceleft = sizeof(rbp->bp_vend) - (q - rbp->bp_vend);
             val = slirp->vdnssearch_len;
diff --git a/slirp/bootp.h b/slirp/bootp.h
index 394525733e..60bef4e80d 100644
--- a/slirp/bootp.h
+++ b/slirp/bootp.h
@@ -71,6 +71,8 @@
 #define RFC2132_RENEWAL_TIME    58
 #define RFC2132_REBIND_TIME     59
 
+#define RFC3442_CLASSLESS_STATIC_ROUTE	121
+
 #define DHCPDISCOVER		1
 #define DHCPOFFER		2
 #define DHCPREQUEST		3
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 740408a96e..3d2e395b08 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -5,6 +5,12 @@
 
 typedef struct Slirp Slirp;
 
+typedef struct StaticRoute {
+    struct in_addr subnet;
+    uint8_t mask_width;
+    struct in_addr gateway;
+} StaticRoute;
+
 int get_dns_addr(struct in_addr *pdns_addr);
 int get_dns6_addr(struct in6_addr *pdns6_addr, uint32_t *scope_id);
 
@@ -16,7 +22,8 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque);
+                  const char *vdomainname, unsigned int routes_count,
+                  const StaticRoute *vroutes, void *opaque);
 void slirp_cleanup(Slirp *slirp);
 
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 4f29753444..4e5f249eeb 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -286,7 +286,8 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque)
+                  const char *vdomainname, unsigned int route_count,
+                  const StaticRoute *vroutes, void *opaque)
 {
     Slirp *slirp = g_malloc0(sizeof(Slirp));
 
@@ -321,6 +322,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
     slirp->vdhcp_startaddr = vdhcp_start;
     slirp->vnameserver_addr = vnameserver;
     slirp->vnameserver_addr6 = vnameserver6;
+    slirp->route_count = route_count;
+    slirp->routes = g_malloc(route_count * sizeof(StaticRoute));
+    memcpy(slirp->routes, vroutes, route_count * sizeof(StaticRoute));
 
     if (vdnssearch) {
         translate_dnssearch(slirp, vdnssearch);
@@ -351,6 +355,7 @@ void slirp_cleanup(Slirp *slirp)
     g_free(slirp->tftp_prefix);
     g_free(slirp->bootp_filename);
     g_free(slirp->vdomainname);
+    g_free(slirp->routes);
     g_free(slirp);
 }
 
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 10b410898a..3c81b7f7cc 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -194,6 +194,8 @@ struct Slirp {
     size_t vdnssearch_len;
     uint8_t *vdnssearch;
     char *vdomainname;
+    unsigned int route_count;
+    struct StaticRoute *routes;
 
     /* tcp states */
     struct socket tcb;
-- 
2.14.1
