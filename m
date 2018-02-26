Received: from eggs.gnu.org ([2001:4830:134:3::10]:47955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1eqL4v-00068V-P8
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1eqL4t-0001W9-4q
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:52:37 -0500
Received: from mx1.profitbricks.com ([46.16.72.21]:54938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1eqL4s-0001Vj-RE
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:52:35 -0500
Received: from mail.pb.local (mail.pb.local [192.168.178.100])
	by mx1.profitbricks.com (Postfix) with ESMTP id 0EF725F84D
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 15:52:32 +0000 (UTC)
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Mon, 26 Feb 2018 16:52:22 +0100
Message-Id: <20180226155222.24327-1-benjamin.drung@profitbricks.com>
In-Reply-To: <ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
References: <ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
Subject: [Qemu-devel] [PATCH v3] slirp: Add domainname option to slirp's
 DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Benjamin Drung <benjamin.drung@profitbricks.com>

This patch will allow the user to include the domainname option in
replies from the built-in DHCP server.

Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
---
 net/slirp.c      |  7 ++++---
 qapi/net.json    |  4 ++++
 qemu-options.hx  |  7 +++++--
 slirp/bootp.c    |  8 ++++++++
 slirp/libslirp.h |  2 +-
 slirp/slirp.c    | 10 +++++++++-
 slirp/slirp.h    |  1 +
 7 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 8991816bbf..9511ff3bb7 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -157,7 +157,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *bootfile, const char *vdhcp_start,
                           const char *vnameserver, const char *vnameserver6,
                           const char *smb_export, const char *vsmbserver,
-                          const char **dnssearch, Error **errp)
+                          const char **dnssearch, const char *vdomainname,
+                          Error **errp)
 {
     /* default settings according to historic slirp */
     struct in_addr net  = { .s_addr = htonl(0x0a000200) }; /* 10.0.2.0 */
@@ -371,7 +372,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
                           vhostname, tftp_export, bootfile, dhcp,
-                          dns, ip6_dns, dnssearch, s);
+                          dns, ip6_dns, dnssearch, vdomainname, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
 
     for (config = slirp_configs; config; config = config->next) {
@@ -958,7 +959,7 @@ int net_init_slirp(const Netdev *netdev, const char *name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch, errp);
+                         user->smbserver, dnssearch, user->domainname, errp);
 
     while (slirp_configs) {
         config = slirp_configs;
diff --git a/qapi/net.json b/qapi/net.json
index 1238ba5de1..9dfd34cafa 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -160,6 +160,9 @@
 # @dnssearch: list of DNS suffixes to search, passed as DHCP option
 #             to the guest
 #
+# @domainname: guest-visible domain name of the virtual nameserver
+#              (since 2.12)
+#
 # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
 #               2.6). The network prefix is given in the usual
 #               hexadecimal IPv6 address notation.
@@ -197,6 +200,7 @@
     '*dhcpstart': 'str',
     '*dns':       'str',
     '*dnssearch': ['String'],
+    '*domainname': 'str',
     '*ipv6-prefix':      'str',
     '*ipv6-prefixlen':   'int',
     '*ipv6-host':        'str',
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ccd5dcaa6..c000ef454e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1906,8 +1906,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev user,id=str[,ipv4[=on|off]][,net=addr[/mask]][,host=addr]\n"
     "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
     "         [,restrict=on|off][,hostname=host][,dhcpstart=addr]\n"
-    "         [,dns=addr][,ipv6-dns=addr][,dnssearch=domain][,tftp=dir]\n"
-    "         [,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
+    "         [,dns=addr][,ipv6-dns=addr][,dnssearch=domain][,domainname=domain]\n"
+    "         [,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
 #ifndef _WIN32
                                              "[,smb=dir[,smbserver=addr]]\n"
 #endif
@@ -2116,6 +2116,9 @@ Example:
 qemu -net user,dnssearch=mgmt.example.org,dnssearch=example.org [...]
 @end example
 
+@item domainname=@var{domain}
+Specifies the client domain name reported by the built-in DHCP server.
+
 @item tftp=@var{dir}
 When using the user mode network stack, activate a built-in TFTP
 server. The files in @var{dir} will be exposed as the root of a TFTP server.
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 5dd1a415b5..9e7b53ba94 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -298,6 +298,14 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
             q += val;
         }
 
+        if (slirp->vdomainname) {
+            val = strlen(slirp->vdomainname);
+            *q++ = RFC1533_DOMAINNAME;
+            *q++ = val;
+            memcpy(q, slirp->vdomainname, val);
+            q += val;
+        }
+
         if (slirp->vdnssearch) {
             size_t spaceleft = sizeof(rbp->bp_vend) - (q - rbp->bp_vend);
             val = slirp->vdnssearch_len;
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 540b3e5903..740408a96e 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -16,7 +16,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  void *opaque);
+                  const char *vdomainname, void *opaque);
 void slirp_cleanup(Slirp *slirp);
 
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 1cb6b07004..a6ed258fc2 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -286,7 +286,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  void *opaque)
+                  const char *vdomainname, void *opaque)
 {
     Slirp *slirp = g_malloc0(sizeof(Slirp));
 
@@ -317,6 +317,13 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
     }
     slirp->tftp_prefix = g_strdup(tftp_path);
     slirp->bootp_filename = g_strdup(bootfile);
+    if (vdomainname) {
+        if (!*vdomainname) {
+            error_report("'domainname' parameter cannot be empty");
+            exit(EXIT_FAILURE);
+        }
+        slirp->vdomainname = g_strdup(vdomainname);
+    }
     slirp->vdhcp_startaddr = vdhcp_start;
     slirp->vnameserver_addr = vnameserver;
     slirp->vnameserver_addr6 = vnameserver6;
@@ -349,6 +356,7 @@ void slirp_cleanup(Slirp *slirp)
     g_free(slirp->vdnssearch);
     g_free(slirp->tftp_prefix);
     g_free(slirp->bootp_filename);
+    g_free(slirp->vdomainname);
     g_free(slirp);
 }
 
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 06febfc78b..10b410898a 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -193,6 +193,7 @@ struct Slirp {
     char *bootp_filename;
     size_t vdnssearch_len;
     uint8_t *vdnssearch;
+    char *vdomainname;
 
     /* tcp states */
     struct socket tcb;
-- 
2.14.1
