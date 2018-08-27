Received: from eggs.gnu.org ([2001:4830:134:3::10]:36960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fu7BL-00015F-IA
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fu7BI-0002SX-BJ
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:23:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fu7BG-0002S0-MU
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:23:04 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 27 Aug 2018 10:22:53 +0800
Message-Id: <20180827022253.28140-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] slirp: Implement RFC2132 TFTP server name
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

v2: - Adjust parameter order and field placement to be closer to other
tftp options. [Samuel]
    - Drop 'optional'. [Eric]
---
 net/slirp.c      | 5 ++++-
 qapi/net.json    | 5 ++++-
 slirp/bootp.c    | 8 ++++++++
 slirp/bootp.h    | 1 +
 slirp/libslirp.h | 4 +++-
 slirp/slirp.c    | 5 ++++-
 slirp/slirp.h    | 1 +
 7 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 1e14318b4d..90ef09b40a 100644
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
@@ -376,6 +377,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
 
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
+                          tftp_server_name,
                           vhostname, tftp_export, bootfile, dhcp,
                           dns, ip6_dns, dnssearch, vdomainname, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
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
index c86f351161..8f99fd911d 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -174,6 +174,8 @@
 #
 # @guestfwd: forward guest TCP connections
 #
+# @tftp-server-name: RFC2132 "TFTP server name" string (Since 3.1)
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
index 740408a96e..0e84ab9b52 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -13,10 +13,12 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   bool in6_enabled,
                   struct in6_addr vprefix_addr6, uint8_t vprefix_len,
                   struct in6_addr vhost6, const char *vhostname,
+                  const char *tftp_server_name,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque);
+                  const char *vdomainname,
+                  void *opaque);
 void slirp_cleanup(Slirp *slirp);
 
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5c3bd6163f..4073b0174f 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -283,10 +283,12 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   bool in6_enabled,
                   struct in6_addr vprefix_addr6, uint8_t vprefix_len,
                   struct in6_addr vhost6, const char *vhostname,
+                  const char *tftp_server_name,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque)
+                  const char *vdomainname,
+                  void *opaque)
 {
     Slirp *slirp = g_malloc0(sizeof(Slirp));
 
@@ -321,6 +323,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
     slirp->vdhcp_startaddr = vdhcp_start;
     slirp->vnameserver_addr = vnameserver;
     slirp->vnameserver_addr6 = vnameserver6;
+    slirp->tftp_server_name = g_strdup(tftp_server_name);
 
     if (vdnssearch) {
         translate_dnssearch(slirp, vdnssearch);
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 10b410898a..b80725a0d6 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -212,6 +212,7 @@ struct Slirp {
     /* tftp states */
     char *tftp_prefix;
     struct tftp_session tftp_sessions[TFTP_SESSIONS_MAX];
+    char *tftp_server_name;
 
     ArpTable arp_table;
     NdpTable ndp_table;
-- 
2.17.1
