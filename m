Received: from eggs.gnu.org ([2001:4830:134:3::10]:46360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ekDxs-0003Js-6e
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ekDxp-0005j5-1x
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:04:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ekDxo-0005ij-Tr
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:04:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  9 Feb 2018 20:03:40 +0100
Message-Id: <20180209190340.19516-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] net: fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>

Fixes the following ASAN warnings:

/home/elmarco/src/qemu/hw/net/net_tx_pkt.c:201:27: runtime error: member =
access within misaligned address 0x631000028846 for type 'struct ip_heade=
r', which requires 4 byte alignment
0x631000028846: note: pointer points here
 01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff  ff =
ff 00 00 00 00 00 00  00 00
             ^
/home/elmarco/src/qemu/hw/net/net_tx_pkt.c:208:63: runtime error: member =
access within misaligned address 0x631000028846 for type 'struct ip_heade=
r', which requires 4 byte alignment
0x631000028846: note: pointer points here
 01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff  ff =
ff 00 00 00 00 00 00  00 00
             ^
/home/elmarco/src/qemu/hw/net/net_tx_pkt.c:210:13: runtime error: member =
access within misaligned address 0x631000028846 for type 'struct ip_heade=
r', which requires 4 byte alignment
0x631000028846: note: pointer points here
 01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff  ff =
ff 00 00 00 00 00 00  00 00

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/net/eth.h   | 4 +++-
 hw/net/net_tx_pkt.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 09054a506d..e6dc8a7ba0 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -194,7 +194,9 @@ struct tcp_hdr {
 #define PKT_GET_IP_HDR(p)         \
     ((struct ip_header *)(((uint8_t *)(p)) + eth_get_l2_hdr_length(p)))
 #define IP_HDR_GET_LEN(p)         \
-    ((((struct ip_header *)(p))->ip_ver_len & 0x0F) << 2)
+    ((ldub_p(p + offsetof(struct ip_header, ip_ver_len)) & 0x0F) << 2)
+#define IP_HDR_GET_P(p)                                           \
+    (ldub_p(p + offsetof(struct ip_header, ip_p)))
 #define PKT_GET_IP_HDR_LEN(p)     \
     (IP_HDR_GET_LEN(PKT_GET_IP_HDR(p)))
 #define PKT_GET_IP6_HDR(p)        \
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index e29c881bc2..162f802dd7 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -205,7 +205,7 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt =
*pkt)
             return false;
         }
=20
-        pkt->l4proto =3D ((struct ip_header *) l3_hdr->iov_base)->ip_p;
+        pkt->l4proto =3D IP_HDR_GET_P(l3_hdr->iov_base);
=20
         if (IP_HDR_GET_LEN(l3_hdr->iov_base) !=3D sizeof(struct ip_heade=
r)) {
             /* copy optional IPv4 header data if any*/
--=20
2.16.1.73.g5832b7e9f2
