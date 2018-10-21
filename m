Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQn-0001iB-0h
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQj-0003iI-As
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:31 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:55698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gEJQe-0003g9-38
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:25 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 21 Oct 2018 21:30:14 +0200
Message-Id: <20181021193014.22512-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
References: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] slirp: Implement RFC2132 TFTP server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Fam Zheng <famz@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Fam Zheng <famz@redhat.com>

This new usernet option can be used to add data for option 66 (tftp
server name) in the BOOTP reply, which is useful in PXE based automatic
OS install such as OpenBSD.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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
index da6c0a1a5c..f6dc03963a 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -150,6 +150,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
                           const char *vnameserver, const char *vnameserv=
er6,
                           const char *smb_export, const char *vsmbserver=
,
                           const char **dnssearch, const char *vdomainnam=
e,
+                          const char *tftp_server_name,
                           Error **errp)
 {
     /* default settings according to historic slirp */
@@ -360,6 +361,11 @@ static int net_slirp_init(NetClientState *peer, cons=
t char *model,
         return -1;
     }
=20
+    if (tftp_server_name && strlen(tftp_server_name) > 255) {
+        error_setg(errp, "'tftp-server-name' parameter cannot exceed 255=
 bytes");
+        return -1;
+    }
+
     nc =3D qemu_new_net_client(&net_slirp_info, peer, model, name);
=20
     snprintf(nc->info_str, sizeof(nc->info_str),
@@ -370,7 +376,8 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
=20
     s->slirp =3D slirp_init(restricted, ipv4, net, mask, host,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
-                          vhostname, tftp_export, bootfile, dhcp,
+                          vhostname, tftp_server_name,
+                          tftp_export, bootfile, dhcp,
                           dns, ip6_dns, dnssearch, vdomainname, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
=20
@@ -907,7 +914,8 @@ int net_init_slirp(const Netdev *netdev, const char *=
name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch, user->domainname, e=
rrp);
+                         user->smbserver, dnssearch, user->domainname,
+                         user->tftp_server_name, errp);
=20
     while (slirp_configs) {
         config =3D slirp_configs;
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
=20
 ##
 # @NetdevTapOptions:
diff --git a/qemu-options.hx b/qemu-options.hx
index 214ce396f9..08f8516a9a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1823,7 +1823,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "         [,ipv6[=3Don|off]][,ipv6-net=3Daddr[/int]][,ipv6-host=3Dad=
dr]\n"
     "         [,restrict=3Don|off][,hostname=3Dhost][,dhcpstart=3Daddr]\=
n"
     "         [,dns=3Daddr][,ipv6-dns=3Daddr][,dnssearch=3Ddomain][,doma=
inname=3Ddomain]\n"
-    "         [,tftp=3Ddir][,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3D=
rule]"
+    "         [,tftp=3Ddir][,tftp-server-name=3Dname][,bootfile=3Df][,ho=
stfwd=3Drule][,guestfwd=3Drule]"
 #ifndef _WIN32
                                              "[,smb=3Ddir[,smbserver=3Da=
ddr]]\n"
 #endif
@@ -2060,6 +2060,11 @@ server. The files in @var{dir} will be exposed as =
the root of a TFTP server.
 The TFTP client on the guest must be configured in binary mode (use the =
command
 @code{bin} of the Unix TFTP client).
=20
+@item tftp-server-name=3D@var{name}
+In BOOTP reply, broadcast @var{name} as the "TFTP server name" (RFC2132 =
option
+66). This can be used to advise the guest to load boot files or configur=
ations
+from a different server than the host address.
+
 @item bootfile=3D@var{file}
 When using the user mode network stack, broadcast @var{file} as the BOOT=
P
 filename. In conjunction with @option{tftp}, this can be used to network=
 boot
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 1e8185f0ec..7b1af73c95 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -318,6 +318,19 @@ static void bootp_reply(Slirp *slirp, const struct b=
ootp_t *bp)
             }
         }
=20
+        if (slirp->tftp_server_name) {
+            val =3D strlen(slirp->tftp_server_name);
+            if (q + val + 2 >=3D end) {
+                g_warning("DHCP packet size exceeded, "
+                    "omitting tftp-server-name option.");
+            } else {
+                *q++ =3D RFC2132_TFTP_SERVER_NAME;
+                *q++ =3D val;
+                memcpy(q, slirp->tftp_server_name, val);
+                q +=3D val;
+            }
+        }
+
         if (slirp->vdnssearch) {
             val =3D slirp->vdnssearch_len;
             if (q + val >=3D end) {
diff --git a/slirp/bootp.h b/slirp/bootp.h
index 394525733e..4043489835 100644
--- a/slirp/bootp.h
+++ b/slirp/bootp.h
@@ -70,6 +70,7 @@
 #define RFC2132_MAX_SIZE	57
 #define RFC2132_RENEWAL_TIME    58
 #define RFC2132_REBIND_TIME     59
+#define RFC2132_TFTP_SERVER_NAME 66
=20
 #define DHCPDISCOVER		1
 #define DHCPOFFER		2
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 740408a96e..42e42e9a2a 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -13,6 +13,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, stru=
ct in_addr vnetwork,
                   bool in6_enabled,
                   struct in6_addr vprefix_addr6, uint8_t vprefix_len,
                   struct in6_addr vhost6, const char *vhostname,
+                  const char *tftp_server_name,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver=
,
                   struct in6_addr vnameserver6, const char **vdnssearch,
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5c3bd6163f..51de41fc02 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -283,6 +283,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
                   bool in6_enabled,
                   struct in6_addr vprefix_addr6, uint8_t vprefix_len,
                   struct in6_addr vhost6, const char *vhostname,
+                  const char *tftp_server_name,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver=
,
                   struct in6_addr vnameserver6, const char **vdnssearch,
@@ -321,6 +322,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
     slirp->vdhcp_startaddr =3D vdhcp_start;
     slirp->vnameserver_addr =3D vnameserver;
     slirp->vnameserver_addr6 =3D vnameserver6;
+    slirp->tftp_server_name =3D g_strdup(tftp_server_name);
=20
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
=20
     ArpTable arp_table;
     NdpTable ndp_table;
--=20
2.19.1
