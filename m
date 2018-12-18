Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQB-0007wK-Iu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQ5-000447-SA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:00 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQ3-000406-Nh
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:04:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:39 +0100
Message-Id: <20181218230442.27887-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/64] slirp: associate slirp_output callback
 with the Slirp context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Let's make the slirp interface a bit more library-like.
Associate the slirp_output() with a Slirp context.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      |  5 +++--
 slirp/libslirp.h |  9 +++++----
 slirp/ncsi.c     |  2 +-
 slirp/slirp.c    | 11 +++++++----
 slirp/slirp.h    |  1 +
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index f6dc03963a..1dbd34a9da 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -99,7 +99,7 @@ static void slirp_smb_cleanup(SlirpState *s);
 static inline void slirp_smb_cleanup(SlirpState *s) { }
 #endif
=20
-void slirp_output(void *opaque, const uint8_t *pkt, int pkt_len)
+static void net_slirp_output(void *opaque, const uint8_t *pkt, int pkt_l=
en)
 {
     SlirpState *s =3D opaque;
=20
@@ -378,7 +378,8 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
                           ipv6, ip6_prefix, vprefix6_len, ip6_host,
                           vhostname, tftp_server_name,
                           tftp_export, bootfile, dhcp,
-                          dns, ip6_dns, dnssearch, vdomainname, s);
+                          dns, ip6_dns, dnssearch, vdomainname,
+                          net_slirp_output, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
=20
     for (config =3D slirp_configs; config; config =3D config->next) {
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 42e42e9a2a..52dbb9feb5 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -5,6 +5,8 @@
=20
 typedef struct Slirp Slirp;
=20
+typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int pkt_l=
en);
+
 int get_dns_addr(struct in_addr *pdns_addr);
 int get_dns6_addr(struct in6_addr *pdns6_addr, uint32_t *scope_id);
=20
@@ -17,7 +19,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, stru=
ct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver=
,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque);
+                  const char *vdomainname,
+                  slirp_output output,
+                  void *opaque);
 void slirp_cleanup(Slirp *slirp);
=20
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
@@ -26,9 +30,6 @@ void slirp_pollfds_poll(GArray *pollfds, int select_err=
or);
=20
 void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
=20
-/* you must provide the following functions: */
-void slirp_output(void *opaque, const uint8_t *pkt, int pkt_len);
-
 int slirp_add_hostfwd(Slirp *slirp, int is_udp,
                       struct in_addr host_addr, int host_port,
                       struct in_addr guest_addr, int guest_port);
diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 7116034afc..d7701f7785 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -163,5 +163,5 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
 pkt_len)
     *pchecksum =3D htonl(checksum);
     ncsi_rsp_len +=3D 4;
=20
-    slirp_output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
+    slirp->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
 }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 322edf51eb..b0380c5eaa 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -287,12 +287,15 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
                   const char *tftp_path, const char *bootfile,
                   struct in_addr vdhcp_start, struct in_addr vnameserver=
,
                   struct in6_addr vnameserver6, const char **vdnssearch,
-                  const char *vdomainname, void *opaque)
+                  const char *vdomainname,
+                  slirp_output output,
+                  void *opaque)
 {
     Slirp *slirp =3D g_malloc0(sizeof(Slirp));
=20
     slirp_init_once();
=20
+    slirp->output =3D output;
     slirp->grand =3D g_rand_new();
     slirp->restricted =3D restricted;
=20
@@ -832,7 +835,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pk=
t, int pkt_len)
             rah->ar_sip =3D ah->ar_tip;
             memcpy(rah->ar_tha, ah->ar_sha, ETH_ALEN);
             rah->ar_tip =3D ah->ar_sip;
-            slirp_output(slirp->opaque, arp_reply, sizeof(arp_reply));
+            slirp->output(slirp->opaque, arp_reply, sizeof(arp_reply));
         }
         break;
     case ARPOP_REPLY:
@@ -932,7 +935,7 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             /* target IP */
             rah->ar_tip =3D iph->ip_dst.s_addr;
             slirp->client_ipaddr =3D iph->ip_dst;
-            slirp_output(slirp->opaque, arp_req, sizeof(arp_req));
+            slirp->output(slirp->opaque, arp_req, sizeof(arp_req));
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
@@ -1018,7 +1021,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
                 eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
                 eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]));
     memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
-    slirp_output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
+    slirp->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
     return 1;
 }
=20
diff --git a/slirp/slirp.h b/slirp/slirp.h
index b80725a0d6..e3d65d68ec 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -220,6 +220,7 @@ struct Slirp {
     GRand *grand;
     QEMUTimer *ra_timer;
=20
+    slirp_output output;
     void *opaque;
 };
=20
--=20
2.19.2
