Received: from eggs.gnu.org ([2001:4830:134:3::10]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQf-0008MH-TO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQZ-0004aW-Tw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:29 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQT-0004EB-FB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:23 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:08 +0100
Message-Id: <20181218230442.27887-31-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/64] slirp: replace HOST_WORDS_BIGENDIAN with
 glib equivalent
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

One more step towards making the project independent from QEMU.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip.h           | 8 +++++---
 slirp/ip6.h          | 3 ++-
 slirp/ip6_icmp.h     | 6 +++---
 slirp/slirp_config.h | 3 ---
 slirp/tcp.h          | 4 +++-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 59cf4aa918..83fc9cdfbf 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -33,7 +33,9 @@
 #ifndef IP_H
 #define IP_H
=20
-#ifdef HOST_WORDS_BIGENDIAN
+#include <glib.h>
+
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
 # undef NTOHL
 # undef NTOHS
 # undef HTONL
@@ -69,7 +71,7 @@ typedef uint32_t n_long;                 /* long as rec=
eived from the net */
  * Structure of an internet header, naked of options.
  */
 struct ip {
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
 	uint8_t ip_v:4,			/* version */
 		ip_hl:4;		/* header length */
 #else
@@ -135,7 +137,7 @@ struct	ip_timestamp {
 	uint8_t	ipt_code;		/* IPOPT_TS */
 	uint8_t	ipt_len;		/* size of structure (variable) */
 	uint8_t	ipt_ptr;		/* index of current entry */
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
 	uint8_t	ipt_oflw:4,		/* overflow counter */
 		ipt_flg:4;		/* flags, see below */
 #else
diff --git a/slirp/ip6.h b/slirp/ip6.h
index b1bea43b3c..14e9c78735 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -6,6 +6,7 @@
 #ifndef SLIRP_IP6_H
 #define SLIRP_IP6_H
=20
+#include <glib.h>
 #include "net/eth.h"
=20
 #define ALLNODES_MULTICAST  { .s6_addr =3D \
@@ -113,7 +114,7 @@ static inline void in6_compute_ethaddr(struct in6_add=
r ip,
  * Structure of an internet header, naked of options.
  */
 struct ip6 {
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
     uint32_t
         ip_v:4,         /* version */
         ip_tc_hi:4,     /* traffic class */
diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index b3378b17b5..32b0914055 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -34,7 +34,7 @@ struct ndp_rs {     /* Router Solicitation Message */
=20
 struct ndp_ra {     /* Router Advertisement Message */
     uint8_t chl;    /* Cur Hop Limit */
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
     uint8_t
         M:1,
         O:1,
@@ -56,7 +56,7 @@ struct ndp_ns {     /* Neighbor Solicitation Message */
 } QEMU_PACKED;
=20
 struct ndp_na {     /* Neighbor Advertisement Message */
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
     uint32_t
         R:1,                /* Router Flag */
         S:1,                /* Solicited Flag */
@@ -125,7 +125,7 @@ struct ndpopt {
 #define ndpopt_linklayer ndpopt_body.linklayer_addr
         struct prefixinfo {                     /* Prefix Information */
             uint8_t     prefix_length;
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
             uint8_t     L:1, A:1, reserved1:6;
 #else
             uint8_t     reserved1:6, A:1, L:1;
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 5126711849..b2def6d20c 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -11,8 +11,5 @@
  * You shouldn't need to touch any of these
  */
=20
-/* Define if the machine is big endian */
-//#undef HOST_WORDS_BIGENDIAN
-
 /* Define to sizeof(char *) */
 #define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
diff --git a/slirp/tcp.h b/slirp/tcp.h
index 174d3d960c..47aaea6c5b 100644
--- a/slirp/tcp.h
+++ b/slirp/tcp.h
@@ -33,6 +33,8 @@
 #ifndef TCP_H
 #define TCP_H
=20
+#include <glib.h>
+
 typedef	uint32_t tcp_seq;
=20
 #define      PR_SLOWHZ       2               /* 2 slow timeouts per seco=
nd (approx) */
@@ -51,7 +53,7 @@ struct tcphdr {
 	uint16_t th_dport;              /* destination port */
 	tcp_seq	th_seq;			/* sequence number */
 	tcp_seq	th_ack;			/* acknowledgement number */
-#ifdef HOST_WORDS_BIGENDIAN
+#if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
 	uint8_t	th_off:4,		/* data offset */
 		th_x2:4;		/* (unused) */
 #else
--=20
2.19.2
