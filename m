Received: from eggs.gnu.org ([2001:4830:134:3::10]:59274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxn8H-00087v-7W
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxn5V-0000VM-55
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:44:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fxn5U-0000SQ-Q5
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:44:16 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Sep 2018 13:43:39 +0800
Message-Id: <20180906054340.28988-4-famz@redhat.com>
In-Reply-To: <20180906054340.28988-1-famz@redhat.com>
References: <20180906054340.28988-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] slirp: Implement RFC2132 TFTP server
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

This new usernet option can be used to add data for option 66 (tftp
server name) in the BOOTP reply, which is useful in PXE based automatic
OS install such as OpenBSD.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 net/slirp.c      | 12 ++++++++++--
 qapi/net.json    |  5 ++++-
 qemu-options.hx  |  7 ++++++-
 slirp/bootp.c    | 13 +++++++++++++
 slirp/bootp.h    |  1 +
 slirp/libslirp.h |  1 +
 slirp/slirp.c    |  2 ++
 slirp/slirp.h    |  1 +
 8 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index fd21dc728c..53f7b89696 100644
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
@@ -375,6 +376,11 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         return -1;
     }
 
+    if (tftp_server_name && strlen(tftp_server_name) > 255) {
+        error_setg(errp, "'tftp-server-name' parameter cannot exceed 255 bytes");
+        return -1;
+    }
+
     nc = qemu_new_net_client(&net_slirp_info, peer, model, name);
 
     snprintf(nc->info_str, sizeof(nc->info_str),
@@ -385,7 +391,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
 
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
-                          vhostname, tftp_export, bootfile, dhcp,
+                          vhostname, tftp_server_name,
+                          tftp_export, bootfile, dhcp,
                           dns, ip6_dns, dnssearch, vdomainname, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
 
@@ -975,7 +982,8 @@ int net_init_slirp(const Netdev *netdev, const char *name,
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 654ef484d9..2c2acbb14b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1842,7 +1842,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
     "         [,restrict=on|off][,hostname=host][,dhcpstart=addr]\n"
     "         [,dns=addr][,ipv6-dns=addr][,dnssearch=domain][,domainname=domain]\n"
-    "         [,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
+    "         [,tftp=dir][,tftp-server-name=name][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
 #ifndef _WIN32
                                              "[,smb=dir[,smbserver=addr]]\n"
 #endif
@@ -2079,6 +2079,11 @@ server. The files in @var{dir} will be exposed as the root of a TFTP server.
 The TFTP client on the guest must be configured in binary mode (use the command
 @code{bin} of the Unix TFTP client).
 
+@item tftp-server-name=@var{name}
+In BOOTP reply, broadcast @var{name} as the "TFTP server name" (RFC2132 option
+66). This can be used to advise the guest to load boot files or configurations
+from a different server than the host address.
+
 @item bootfile=@var{file}
 When using the user mode network stack, broadcast @var{file} as the BOOTP
 filename. In conjunction with @option{tftp}, this can be used to network boot
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 1e8185f0ec..7b1af73c95 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -318,6 +318,19 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
             }
         }
 
+        if (slirp->tftp_server_name) {
+            val = strlen(slirp->tftp_server_name);
+            if (q + val + 2 >= end) {
+                g_warning("DHCP packet size exceeded, "
+                    "omitting tftp-server-name option.");
+            } else {
+                *q++ = RFC2132_TFTP_SERVER_NAME;
+                *q++ = val;
+                memcpy(q, slirp->tftp_server_name, val);
+                q += val;
+            }
+        }
+
         if (slirp->vdnssearch) {
             val = slirp->vdnssearch_len;
             if (q + val >= end) {
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
index 740408a96e..42e42e9a2a 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -13,6 +13,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   bool in6_enabled,
                   struct in6_addr vprefix_addr6, uint8_t vprefix_len,
                   struct in6_addr vhost6, const char *vhostname,
+                  const char *tftp_server_name,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5c3bd6163f..51de41fc02 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -283,6 +283,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   bool in6_enabled,
                   struct in6_addr vprefix_addr6, uint8_t vprefix_len,
                   struct in6_addr vhost6, const char *vhostname,
+                  const char *tftp_server_name,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
@@ -321,6 +322,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
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
