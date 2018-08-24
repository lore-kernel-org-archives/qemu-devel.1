Received: from eggs.gnu.org ([2001:4830:134:3::10]:42258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ftCWi-0001XK-1x
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ftCWg-0000bY-W5
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:53:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ftCWg-0000bJ-QQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:53:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Aug 2018 21:53:12 +0800
Message-Id: <20180824135312.1606-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] slirp: Implement RFC2132 TFTP server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, brad@comstyle.com

This new usernet option can be used to add data for option 66 (tftp
server name) in the BOOTP reply, which is useful in PXE based automatic
OS install such as OpenBSD.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 net/slirp.c      | 7 +++++--
 qapi/net.json    | 5 ++++-
 slirp/bootp.c    | 8 ++++++++
 slirp/bootp.h    | 1 +
 slirp/libslirp.h | 3 ++-
 slirp/slirp.c    | 6 +++++-
 slirp/slirp.h    | 2 ++
 7 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 1e14318b4d..b0c68a3665 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -158,6 +158,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *vnameserver, const char *vnameserver6,
                           const char *smb_export, const char *vsmbserver,
                           const char **dnssearch, const char *vdomainname,
+                          const char *tftp_server_name,
                           Error **errp)
 {
     /* default settings according to historic slirp */
@@ -377,7 +378,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
                           vhostname, tftp_export, bootfile, dhcp,
-                          dns, ip6_dns, dnssearch, vdomainname, s);
+                          dns, ip6_dns, dnssearch, vdomainname,
+                          tftp_server_name, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
 
     for (config = slirp_configs; config; config = config->next) {
@@ -966,7 +968,8 @@ int net_init_slirp(const Netdev *netdev, const char *name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch, user->domainname, errp);
+                         user->smbserver, dnssearch, user->domainname,
+                         user->tftp_server_name, errp);
 
     while (slirp_configs) {
         config = slirp_configs;
diff --git a/qapi/net.json b/qapi/net.json
index c86f351161..b3cd42f610 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -174,6 +174,8 @@
 #
 # @guestfwd: forward guest TCP connections
 #
+# @tftp-server-name: (optional) RFC2132 "TFTP server name" string (Since 3.1)
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevUserOptions',
@@ -198,7 +200,8 @@
     '*smb':       'str',
     '*smbserver': 'str',
     '*hostfwd':   ['String'],
-    '*guestfwd':  ['String'] } }
+    '*guestfwd':  ['String'],
+    '*tftp-server-name': 'str' } }
 
 ##
 # @NetdevTapOptions:
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 9e7b53ba94..ed2cf3b96e 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -306,6 +306,14 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
             q += val;
         }
 
+        if (slirp->tftp_server_name) {
+            val = strlen(slirp->tftp_server_name);
+            *q++ = RFC2132_TFTP_SERVER_NAME;
+            *q++ = val;
+            memcpy(q, slirp->tftp_server_name, val);
+            q += val;
+        }
+
         if (slirp->vdnssearch) {
             size_t spaceleft = sizeof(rbp->bp_vend) - (q - rbp->bp_vend);
             val = slirp->vdnssearch_len;
diff --git a/slirp/bootp.h b/slirp/bootp.h
index 394525733e..4043489835 100644
--- a/slirp/bootp.h
+++ b/slirp/bootp.h
@@ -70,6 +70,7 @@
 #define RFC2132_MAX_SIZE	57
 #define RFC2132_RENEWAL_TIME    58
 #define RFC2132_REBIND_TIME     59
+#define RFC2132_TFTP_SERVER_NAME 66
 
 #define DHCPDISCOVER		1
 #define DHCPOFFER		2
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 740408a96e..8bd2ad044b 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -16,7 +16,8 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque);
+                  const char *vdomainname, const char *tftp_server_name,
+                  void *opaque);
 void slirp_cleanup(Slirp *slirp);
 
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5c3bd6163f..f62189c650 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -286,7 +286,8 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque)
+                  const char *vdomainname, const char *tftp_server_name,
+                  void *opaque)
 {
     Slirp *slirp = g_malloc0(sizeof(Slirp));
 
@@ -321,6 +322,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
     slirp->vdhcp_startaddr = vdhcp_start;
     slirp->vnameserver_addr = vnameserver;
     slirp->vnameserver_addr6 = vnameserver6;
+    if (tftp_server_name) {
+        slirp->tftp_server_name = g_strdup(tftp_server_name);
+    }
 
     if (vdnssearch) {
         translate_dnssearch(slirp, vdnssearch);
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 10b410898a..5ad982ee25 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -219,6 +219,8 @@ struct Slirp {
     GRand *grand;
     QEMUTimer *ra_timer;
 
+    char *tftp_server_name;
+
     void *opaque;
 };
 
-- 
2.17.1
