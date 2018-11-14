Received: from eggs.gnu.org ([2001:4830:134:3::10]:58720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQd-0008QS-Q5
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQZ-00010m-KG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuQZ-0000zd-CE
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:51 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:07 +0400
Message-Id: <20181114123643.24091-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 05/41] slirp: use a callback structure
 to interface with qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will bring slirp a bit forward to the state of an independent
project.

This could be squashed with earlier submitted "slirp: associate
slirp_output".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h |  7 +++++--
 slirp/slirp.h    |  2 +-
 net/slirp.c      |  6 +++++-
 slirp/ncsi.c     |  2 +-
 slirp/slirp.c    | 10 +++++-----
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 04b6db9f49..36d5fb9163 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -5,7 +5,10 @@
=20
 typedef struct Slirp Slirp;
=20
-typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int pkt_l=
en);
+typedef struct SlirpCb {
+    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
+} SlirpCb;
+
=20
 Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwo=
rk,
                   struct in_addr vnetmask, struct in_addr vhost,
@@ -17,7 +20,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, stru=
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
diff --git a/net/slirp.c b/net/slirp.c
index dfc72cfc2e..233f66b1ef 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -140,6 +140,10 @@ static NetClientInfo net_slirp_info =3D {
     .cleanup =3D net_slirp_cleanup,
 };
=20
+static SlirpCb slirp_cb =3D {
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
--=20
2.19.1.708.g4ede3d42df
