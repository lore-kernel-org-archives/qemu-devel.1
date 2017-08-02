Received: from eggs.gnu.org ([2001:4830:134:3::10]:60179)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd25o-0003Kz-Sw
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd25k-0003ss-Sw
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:26:16 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:55811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd25k-0003r9-Hq
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:26:12 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  3 Aug 2017 00:26:06 +0200
Message-Id: <20170802222607.32085-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170802222607.32085-1-samuel.thibault@ens-lyon.org>
References: <20170802222607.32085-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] slirp: fill error when failing to
 initialize user network
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

With "-netdev user,id=3Dnet0,dns=3D1.2.3.4"
error was:
qemu-system-i386: -netdev user,id=3Dnet0,dns=3D1.2.3.4: Device 'user' cou=
ld not be initialized

Error is now:
qemu-system-i386: -netdev user,id=3Dnet0,dns=3D1.2.3.4: DNS doesn't belon=
g to network

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c | 134 ++++++++++++++++++++++++++++++++++++++++++------------=
------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9fbc949e81..01ed21c006 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -91,15 +91,15 @@ static QTAILQ_HEAD(slirp_stacks, SlirpState) slirp_st=
acks =3D
     QTAILQ_HEAD_INITIALIZER(slirp_stacks);
=20
 static int slirp_hostfwd(SlirpState *s, const char *redir_str,
-                         int legacy_format);
+                         int legacy_format, Error **errp);
 static int slirp_guestfwd(SlirpState *s, const char *config_str,
-                          int legacy_format);
+                          int legacy_format, Error **errp);
=20
 #ifndef _WIN32
 static const char *legacy_smb_export;
=20
 static int slirp_smb(SlirpState *s, const char *exported_dir,
-                     struct in_addr vserver_addr);
+                     struct in_addr vserver_addr, Error **errp);
 static void slirp_smb_cleanup(SlirpState *s);
 #else
 static inline void slirp_smb_cleanup(SlirpState *s) { }
@@ -155,7 +155,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
                           const char *bootfile, const char *vdhcp_start,
                           const char *vnameserver, const char *vnameserv=
er6,
                           const char *smb_export, const char *vsmbserver=
,
-                          const char **dnssearch)
+                          const char **dnssearch, Error **errp)
 {
     /* default settings according to historic slirp */
     struct in_addr net  =3D { .s_addr =3D htonl(0x0a000200) }; /* 10.0.2=
.0 */
@@ -178,15 +178,18 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
     struct slirp_config_str *config;
=20
     if (!ipv4 && (vnetwork || vhost || vnameserver)) {
+        error_setg(errp, "IPv4 disabled but netmask/host/dns provided");
         return -1;
     }
=20
     if (!ipv6 && (vprefix6 || vhost6 || vnameserver6)) {
+        error_setg(errp, "IPv6 disabled but prefix/host6/dns6 provided")=
;
         return -1;
     }
=20
     if (!ipv4 && !ipv6) {
         /* It doesn't make sense to disable both */
+        error_setg(errp, "IPv4 and IPv6 disabled");
         return -1;
     }
=20
@@ -200,6 +203,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
     if (vnetwork) {
         if (get_str_sep(buf, sizeof(buf), &vnetwork, '/') < 0) {
             if (!inet_aton(vnetwork, &net)) {
+                error_setg(errp, "Failed to parse netmask");
                 return -1;
             }
             addr =3D ntohl(net.s_addr);
@@ -220,14 +224,19 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
             }
         } else {
             if (!inet_aton(buf, &net)) {
+                error_setg(errp, "Failed to parse netmask");
                 return -1;
             }
             shift =3D strtol(vnetwork, &end, 10);
             if (*end !=3D '\0') {
                 if (!inet_aton(vnetwork, &mask)) {
+                    error_setg(errp,
+                               "Failed to parse netmask (trailing chars)=
");
                     return -1;
                 }
             } else if (shift < 4 || shift > 32) {
+                error_setg(errp,
+                           "Invalid netmask provided (must be in range 4=
-32)");
                 return -1;
             } else {
                 mask.s_addr =3D htonl(0xffffffff << (32 - shift));
@@ -240,30 +249,43 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
     }
=20
     if (vhost && !inet_aton(vhost, &host)) {
+        error_setg(errp, "Failed to parse host");
         return -1;
     }
     if ((host.s_addr & mask.s_addr) !=3D net.s_addr) {
+        error_setg(errp, "Host doesn't belong to network");
         return -1;
     }
=20
     if (vnameserver && !inet_aton(vnameserver, &dns)) {
+        error_setg(errp, "Failed to parse DNS");
         return -1;
     }
-    if ((dns.s_addr & mask.s_addr) !=3D net.s_addr ||
-        dns.s_addr =3D=3D host.s_addr) {
+    if ((dns.s_addr & mask.s_addr) !=3D net.s_addr) {
+        error_setg(errp, "DNS doesn't belong to network");
+        return -1;
+    }
+    if (dns.s_addr =3D=3D host.s_addr) {
+        error_setg(errp, "DNS must be different from host");
         return -1;
     }
=20
     if (vdhcp_start && !inet_aton(vdhcp_start, &dhcp)) {
+        error_setg(errp, "Failed to parse DHCP start address");
         return -1;
     }
-    if ((dhcp.s_addr & mask.s_addr) !=3D net.s_addr ||
-        dhcp.s_addr =3D=3D host.s_addr || dhcp.s_addr =3D=3D dns.s_addr)=
 {
+    if ((dhcp.s_addr & mask.s_addr) !=3D net.s_addr) {
+        error_setg(errp, "DHCP doesn't belong to network");
+        return -1;
+    }
+    if (dhcp.s_addr =3D=3D host.s_addr || dhcp.s_addr =3D=3D dns.s_addr)=
 {
+        error_setg(errp, "DNS must be different from host and DNS");
         return -1;
     }
=20
 #ifndef _WIN32
     if (vsmbserver && !inet_aton(vsmbserver, &smbsrv)) {
+        error_setg(errp, "Failed to parse SMB address");
         return -1;
     }
 #endif
@@ -272,6 +294,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
     /* No inet_pton helper before Vista... */
     if (vprefix6) {
         /* Unsupported */
+        error_setg(errp, "IPv6 prefix not supported");
         return -1;
     }
     memset(&ip6_prefix, 0, sizeof(ip6_prefix));
@@ -282,6 +305,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
         vprefix6 =3D "fec0::";
     }
     if (!inet_pton(AF_INET6, vprefix6, &ip6_prefix)) {
+        error_setg(errp, "Failed to parse IPv6 prefix");
         return -1;
     }
 #endif
@@ -290,17 +314,22 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
         vprefix6_len =3D 64;
     }
     if (vprefix6_len < 0 || vprefix6_len > 126) {
+        error_setg(errp,
+                   "Invalid prefix provided (prefix len must be in range=
 0-126");
         return -1;
     }
=20
     if (vhost6) {
 #if defined(_WIN32) && (_WIN32_WINNT < 0x0600)
+        error_setg(errp, "IPv6 host not supported");
         return -1;
 #else
         if (!inet_pton(AF_INET6, vhost6, &ip6_host)) {
+            error_setg(errp, "Failed to parse IPv6 host");
             return -1;
         }
         if (!in6_equal_net(&ip6_prefix, &ip6_host, vprefix6_len)) {
+            error_setg(errp, "IPv6 Host doesn't belong to network");
             return -1;
         }
 #endif
@@ -311,12 +340,15 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
=20
     if (vnameserver6) {
 #if defined(_WIN32) && (_WIN32_WINNT < 0x0600)
+        error_setg(errp, "IPv6 DNS not supported");
         return -1;
 #else
         if (!inet_pton(AF_INET6, vnameserver6, &ip6_dns)) {
+            error_setg(errp, "Failed to parse IPv6 DNS");
             return -1;
         }
         if (!in6_equal_net(&ip6_prefix, &ip6_dns, vprefix6_len)) {
+            error_setg(errp, "IPv6 DNS doesn't belong to network");
             return -1;
         }
 #endif
@@ -343,12 +375,14 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
     for (config =3D slirp_configs; config; config =3D config->next) {
         if (config->flags & SLIRP_CFG_HOSTFWD) {
             if (slirp_hostfwd(s, config->str,
-                              config->flags & SLIRP_CFG_LEGACY) < 0)
+                              config->flags & SLIRP_CFG_LEGACY, errp) < =
0) {
                 goto error;
+            }
         } else {
             if (slirp_guestfwd(s, config->str,
-                               config->flags & SLIRP_CFG_LEGACY) < 0)
+                               config->flags & SLIRP_CFG_LEGACY, errp) <=
 0) {
                 goto error;
+            }
         }
     }
 #ifndef _WIN32
@@ -356,8 +390,9 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
         smb_export =3D legacy_smb_export;
     }
     if (smb_export) {
-        if (slirp_smb(s, smb_export, smbsrv) < 0)
+        if (slirp_smb(s, smb_export, smbsrv, errp) < 0) {
             goto error;
+        }
     }
 #endif
=20
@@ -452,7 +487,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qd=
ict)
 }
=20
 static int slirp_hostfwd(SlirpState *s, const char *redir_str,
-                         int legacy_format)
+                         int legacy_format, Error **errp)
 {
     struct in_addr host_addr =3D { .s_addr =3D INADDR_ANY };
     struct in_addr guest_addr =3D { .s_addr =3D 0 };
@@ -505,14 +540,14 @@ static int slirp_hostfwd(SlirpState *s, const char =
*redir_str,
=20
     if (slirp_add_hostfwd(s->slirp, is_udp, host_addr, host_port, guest_=
addr,
                           guest_port) < 0) {
-        error_report("could not set up host forwarding rule '%s'",
-                     redir_str);
+        error_setg(errp, "Could not set up host forwarding rule '%s'",
+                   redir_str);
         return -1;
     }
     return 0;
=20
  fail_syntax:
-    error_report("invalid host forwarding rule '%s'", redir_str);
+    error_setg(errp, "Invalid host forwarding rule '%s'", redir_str);
     return -1;
 }
=20
@@ -532,7 +567,10 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdic=
t)
         redir_str =3D arg1;
     }
     if (s) {
-        slirp_hostfwd(s, redir_str, 0);
+        Error *err =3D NULL;
+        if (slirp_hostfwd(s, redir_str, 0, &err) < 0) {
+            error_report_err(err);
+        }
     }
=20
 }
@@ -540,6 +578,8 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict=
)
 int net_slirp_redir(const char *redir_str)
 {
     struct slirp_config_str *config;
+    Error *err =3D NULL;
+    int res;
=20
     if (QTAILQ_EMPTY(&slirp_stacks)) {
         config =3D g_malloc(sizeof(*config));
@@ -550,7 +590,11 @@ int net_slirp_redir(const char *redir_str)
         return 0;
     }
=20
-    return slirp_hostfwd(QTAILQ_FIRST(&slirp_stacks), redir_str, 1);
+    res =3D slirp_hostfwd(QTAILQ_FIRST(&slirp_stacks), redir_str, 1, &er=
r);
+    if (res < 0) {
+        error_report_err(err);
+    }
+    return res;
 }
=20
 #ifndef _WIN32
@@ -576,7 +620,7 @@ static void slirp_smb_cleanup(SlirpState *s)
 }
=20
 static int slirp_smb(SlirpState* s, const char *exported_dir,
-                     struct in_addr vserver_addr)
+                     struct in_addr vserver_addr, Error **errp)
 {
     char *smb_conf;
     char *smb_cmdline;
@@ -585,25 +629,25 @@ static int slirp_smb(SlirpState* s, const char *exp=
orted_dir,
=20
     passwd =3D getpwuid(geteuid());
     if (!passwd) {
-        error_report("failed to retrieve user name");
+        error_setg(errp, "Failed to retrieve user name");
         return -1;
     }
=20
     if (access(CONFIG_SMBD_COMMAND, F_OK)) {
-        error_report("could not find '%s', please install it",
-                     CONFIG_SMBD_COMMAND);
+        error_setg(errp, "Could not find '%s', please install it",
+                   CONFIG_SMBD_COMMAND);
         return -1;
     }
=20
     if (access(exported_dir, R_OK | X_OK)) {
-        error_report("error accessing shared directory '%s': %s",
-                     exported_dir, strerror(errno));
+        error_setg(errp, "Error accessing shared directory '%s': %s",
+                   exported_dir, strerror(errno));
         return -1;
     }
=20
     s->smb_dir =3D g_dir_make_tmp("qemu-smb.XXXXXX", NULL);
     if (!s->smb_dir) {
-        error_report("could not create samba server dir");
+        error_setg(errp, "Could not create samba server dir");
         return -1;
     }
     smb_conf =3D g_strdup_printf("%s/%s", s->smb_dir, "smb.conf");
@@ -611,8 +655,9 @@ static int slirp_smb(SlirpState* s, const char *expor=
ted_dir,
     f =3D fopen(smb_conf, "w");
     if (!f) {
         slirp_smb_cleanup(s);
-        error_report("could not create samba server configuration file '=
%s'",
-                     smb_conf);
+        error_setg(errp,
+                   "Could not create samba server configuration file '%s=
'",
+                    smb_conf);
         g_free(smb_conf);
         return -1;
     }
@@ -660,7 +705,7 @@ static int slirp_smb(SlirpState* s, const char *expor=
ted_dir,
         slirp_add_exec(s->slirp, 0, smb_cmdline, &vserver_addr, 445) < 0=
) {
         slirp_smb_cleanup(s);
         g_free(smb_cmdline);
-        error_report("conflicting/invalid smbserver address");
+        error_setg(errp, "Conflicting/invalid smbserver address");
         return -1;
     }
     g_free(smb_cmdline);
@@ -678,8 +723,13 @@ int net_slirp_smb(const char *exported_dir)
     }
     legacy_smb_export =3D exported_dir;
     if (!QTAILQ_EMPTY(&slirp_stacks)) {
-        return slirp_smb(QTAILQ_FIRST(&slirp_stacks), exported_dir,
-                         vserver_addr);
+        Error *err =3D NULL;
+        int res =3D slirp_smb(QTAILQ_FIRST(&slirp_stacks), exported_dir,
+                            vserver_addr, &err);
+        if (res < 0) {
+            error_report_err(err);
+        }
+        return res;
     }
     return 0;
 }
@@ -706,7 +756,7 @@ static void guestfwd_read(void *opaque, const uint8_t=
 *buf, int size)
 }
=20
 static int slirp_guestfwd(SlirpState *s, const char *config_str,
-                          int legacy_format)
+                          int legacy_format, Error **errp)
 {
     struct in_addr server =3D { .s_addr =3D 0 };
     struct GuestFwd *fwd;
@@ -746,8 +796,8 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str,
=20
     if ((strlen(p) > 4) && !strncmp(p, "cmd:", 4)) {
         if (slirp_add_exec(s->slirp, 0, &p[4], &server, port) < 0) {
-            error_report("conflicting/invalid host:port in guest forward=
ing "
-                         "rule '%s'", config_str);
+            error_setg(errp, "Conflicting/invalid host:port in guest "
+                       "forwarding rule '%s'", config_str);
             return -1;
         }
     } else {
@@ -755,21 +805,22 @@ static int slirp_guestfwd(SlirpState *s, const char=
 *config_str,
         Chardev *chr =3D qemu_chr_new(buf, p);
=20
         if (!chr) {
-            error_report("could not open guest forwarding device '%s'", =
buf);
+            error_setg(errp, "Could not open guest forwarding device '%s=
'",
+                       buf);
             return -1;
         }
=20
         fwd =3D g_new(struct GuestFwd, 1);
         qemu_chr_fe_init(&fwd->hd, chr, &err);
         if (err) {
-            error_report_err(err);
+            error_propagate(errp, err);
             g_free(fwd);
             return -1;
         }
=20
         if (slirp_add_exec(s->slirp, 3, &fwd->hd, &server, port) < 0) {
-            error_report("conflicting/invalid host:port in guest forward=
ing "
-                         "rule '%s'", config_str);
+            error_setg(errp, "Conflicting/invalid host:port in guest "
+                       "forwarding rule '%s'", config_str);
             g_free(fwd);
             return -1;
         }
@@ -783,7 +834,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str,
     return 0;
=20
  fail_syntax:
-    error_report("invalid guest forwarding rule '%s'", config_str);
+    error_setg(errp, "Invalid guest forwarding rule '%s'", config_str);
     return -1;
 }
=20
@@ -845,7 +896,6 @@ static const char **slirp_dnssearch(const StringList =
*dnsname)
 int net_init_slirp(const Netdev *netdev, const char *name,
                    NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
     struct slirp_config_str *config;
     char *vnet;
     int ret;
@@ -882,7 +932,7 @@ int net_init_slirp(const Netdev *netdev, const char *=
name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch);
+                         user->smbserver, dnssearch, errp);
=20
     while (slirp_configs) {
         config =3D slirp_configs;
@@ -919,7 +969,11 @@ int net_slirp_parse_legacy(QemuOptsList *opts_list, =
const char *optarg, int *ret
         slirp_configs =3D config;
         *ret =3D 0;
     } else {
-        *ret =3D slirp_guestfwd(QTAILQ_FIRST(&slirp_stacks), optarg, 1);
+        Error *err =3D NULL;
+        *ret =3D slirp_guestfwd(QTAILQ_FIRST(&slirp_stacks), optarg, 1, =
&err);
+        if (*ret < 0) {
+            error_report_err(err);
+        }
     }
=20
     return 1;
--=20
2.13.2
