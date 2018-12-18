Received: from eggs.gnu.org ([2001:4830:134:3::10]:40853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORD-0000Op-3s
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORA-00054P-JL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:06 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR9-0004Cl-R2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:04 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:53 +0100
Message-Id: <20181218230442.27887-16-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/64] slirp: use a callback structure to
 interface with qemu
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

This will bring slirp a bit forward to the state of an independent
project.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      |  6 +++++-
 slirp/libslirp.h | 13 +++++++++++--
 slirp/ncsi.c     |  2 +-
 slirp/slirp.c    | 10 +++++-----
 slirp/slirp.h    |  2 +-
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index dfc72cfc2e..a7802ddbcc 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -140,6 +140,10 @@ static NetClientInfo net_slirp_info =3D {
     .cleanup =3D net_slirp_cleanup,
 };
=20
+static const SlirpCb slirp_cb =3D {
+    .output =3D net_slirp_output,
+};
+
 static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *name, int restricted,
                           bool ipv4, const char *vnetwork, const char *v=
host,
@@ -379,7 +383,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
                           vhostname, tftp_server_name,
                           tftp_export, bootfile, dhcp,
                           dns, ip6_dns, dnssearch, vdomainname,
-                          net_slirp_output, s);
+                          &slirp_cb, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
=20
     for (config =3D slirp_configs; config; config =3D config->next) {
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 04b6db9f49..a5d1b27b5e 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -5,7 +5,16 @@
=20
 typedef struct Slirp Slirp;
=20
-typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int pkt_l=
en);
+/*
+ * Callbacks from slirp
+ *
+ * The opaque parameter comes from the opaque parameter given to slirp_i=
nit().
+ */
+typedef struct SlirpCb {
+    /* Send an ethernet frame to the guest network.  */
+    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
+} SlirpCb;
+
=20
 Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwo=
rk,
                   struct in_addr vnetmask, struct in_addr vhost,
@@ -17,7 +26,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, stru=
ct in_addr vnetwork,
                   struct in_addr vdhcp_start, struct in_addr vnameserver=
,
                   struct in6_addr vnameserver6, const char **vdnssearch,
                   const char *vdomainname,
-                  slirp_output output,
+                  const SlirpCb *callbacks,
                   void *opaque);
 void slirp_cleanup(Slirp *slirp);
=20
diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index d7701f7785..10decfb5ef 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -163,5 +163,5 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
 pkt_len)
     *pchecksum =3D htonl(checksum);
     ncsi_rsp_len +=3D 4;
=20
-    slirp->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
+    slirp->cb->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len=
);
 }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 0e4ade3e4a..7213915bf3 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -288,14 +288,14 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
                   struct in_addr vdhcp_start, struct in_addr vnameserver=
,
                   struct in6_addr vnameserver6, const char **vdnssearch,
                   const char *vdomainname,
-                  slirp_output output,
+                  const SlirpCb *callbacks,
                   void *opaque)
 {
     Slirp *slirp =3D g_malloc0(sizeof(Slirp));
=20
     slirp_init_once();
=20
-    slirp->output =3D output;
+    slirp->cb =3D callbacks;
     slirp->grand =3D g_rand_new();
     slirp->restricted =3D restricted;
=20
@@ -843,7 +843,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pk=
t, int pkt_len)
             rah->ar_sip =3D ah->ar_tip;
             memcpy(rah->ar_tha, ah->ar_sha, ETH_ALEN);
             rah->ar_tip =3D ah->ar_sip;
-            slirp->output(slirp->opaque, arp_reply, sizeof(arp_reply));
+            slirp->cb->output(slirp->opaque, arp_reply, sizeof(arp_reply=
));
         }
         break;
     case ARPOP_REPLY:
@@ -943,7 +943,7 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             /* target IP */
             rah->ar_tip =3D iph->ip_dst.s_addr;
             slirp->client_ipaddr =3D iph->ip_dst;
-            slirp->output(slirp->opaque, arp_req, sizeof(arp_req));
+            slirp->cb->output(slirp->opaque, arp_req, sizeof(arp_req));
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
@@ -1029,7 +1029,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
                 eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
                 eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]));
     memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
-    slirp->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
+    slirp->cb->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
     return 1;
 }
=20
diff --git a/slirp/slirp.h b/slirp/slirp.h
index de299aa36c..f7c087456a 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -220,7 +220,7 @@ struct Slirp {
     GRand *grand;
     QEMUTimer *ra_timer;
=20
-    slirp_output output;
+    const SlirpCb *cb;
     void *opaque;
 };
=20
--=20
2.19.2
