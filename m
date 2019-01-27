Received: from eggs.gnu.org ([209.51.188.92]:49630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnZfq-0003KZ-5A
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnZbW-00023w-Fx
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:51:24 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnZbV-00022r-8s
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:51:22 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 02:51:13 +0100
Message-Id: <20190127015113.1599-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: Replace QEMU_BUILD_BUG_ON with own macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, marcandre.lureau@redhat.com, zhangckid@gmail.com, lizhijian@cn.fujitsu.com, pbonzini@redhat.com, jasowang@redhat.com

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip.h       |  6 ++++--
 slirp/ip6.h      |  6 ++++--
 slirp/ip6_icmp.h | 12 +++++++-----
 slirp/util.h     | 25 +++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 2baeeb9a3a..77182e61a9 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -35,6 +35,8 @@
=20
 #include <glib.h>
=20
+#include "util.h"
+
 #if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
 # undef NTOHL
 # undef NTOHS
@@ -229,8 +231,8 @@ struct	ipasfrag {
 	struct ip ipf_ip;
 };
=20
-QEMU_BUILD_BUG_ON(offsetof(struct ipq, frag_link) !=3D
-                  offsetof(struct ipasfrag, ipf_link));
+SLIRP_BUILD_BUG_ON(offsetof(struct ipq, frag_link) !=3D
+                   offsetof(struct ipasfrag, ipf_link));
=20
 #define ipf_off      ipf_ip.ip_off
 #define ipf_tos      ipf_ip.ip_tos
diff --git a/slirp/ip6.h b/slirp/ip6.h
index 4e7c366505..3db099acef 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -8,6 +8,8 @@
=20
 #include <glib.h>
=20
+#include "util.h"
+
 #define ALLNODES_MULTICAST  { .s6_addr =3D \
                             { 0xff, 0x02, 0x00, 0x00,\
                             0x00, 0x00, 0x00, 0x00,\
@@ -152,7 +154,7 @@ struct ip6_pseudohdr {
  * If we marked the struct as packed then we would be unable to take
  * the address of any of the fields in it.
  */
-QEMU_BUILD_BUG_ON(sizeof(struct ip6) !=3D 40);
-QEMU_BUILD_BUG_ON(sizeof(struct ip6_pseudohdr) !=3D 40);
+SLIRP_BUILD_BUG_ON(sizeof(struct ip6) !=3D 40);
+SLIRP_BUILD_BUG_ON(sizeof(struct ip6_pseudohdr) !=3D 40);
=20
 #endif
diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index 3f44ed2f49..ea7fcfe5e6 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -6,6 +6,8 @@
 #ifndef SLIRP_IP6_ICMP_H
 #define SLIRP_IP6_ICMP_H
=20
+#include "util.h"
+
 /*
  * Interface Control Message Protocol version 6 Definitions.
  * Per RFC 4443, March 2006.
@@ -50,14 +52,14 @@ struct ndp_ra {     /* Router Advertisement Message *=
/
     uint32_t retrans_time;  /* Retrans Timer */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_ra) !=3D 12);
+SLIRP_BUILD_BUG_ON(sizeof(struct ndp_ra) !=3D 12);
=20
 struct ndp_ns {     /* Neighbor Solicitation Message */
     uint32_t reserved;
     struct in6_addr target; /* Target Address */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_ns) !=3D 20);
+SLIRP_BUILD_BUG_ON(sizeof(struct ndp_ns) !=3D 20);
=20
 struct ndp_na {     /* Neighbor Advertisement Message */
 #if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
@@ -78,7 +80,7 @@ struct ndp_na {     /* Neighbor Advertisement Message *=
/
     struct in6_addr target; /* Target Address */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_na) !=3D 20);
+SLIRP_BUILD_BUG_ON(sizeof(struct ndp_na) !=3D 20);
=20
 struct ndp_redirect {
     uint32_t reserved;
@@ -86,7 +88,7 @@ struct ndp_redirect {
     struct in6_addr dest;   /* Destination Address */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_redirect) !=3D 36);
+SLIRP_BUILD_BUG_ON(sizeof(struct ndp_redirect) !=3D 36);
=20
 /*
  * Structure of an icmpv6 header.
@@ -113,7 +115,7 @@ struct icmp6 {
 #define icmp6_redirect icmp6_body.ndp_redirect
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct icmp6) !=3D 40);
+SLIRP_BUILD_BUG_ON(sizeof(struct icmp6) !=3D 40);
=20
 #define ICMP6_MINLEN    4
 #define ICMP6_ERROR_MINLEN  8
diff --git a/slirp/util.h b/slirp/util.h
index ef75804560..fc2c2e58fe 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -48,6 +48,31 @@
 # define SLIRP_PACKED __attribute__((packed))
 #endif
=20
+#ifndef glue
+#define xglue(x, y) x ## y
+#define glue(x, y) xglue(x, y)
+#endif
+
+#define SLIRP_BUILD_BUG_ON_STRUCT(x) \
+    struct { \
+        int:(x) ? -1 : 1; \
+    }
+
+/* SLIRP_BUILD_BUG_MSG() emits the message given if _Static_assert is
+ * supported; otherwise, it will be omitted from the compiler error
+ * message (but as it remains present in the source code, it can still
+ * be useful when debugging). */
+#if defined(CONFIG_STATIC_ASSERT)
+#define SLIRP_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
+#elif defined(__COUNTER__)
+#define SLIRP_BUILD_BUG_MSG(x, msg) typedef SLIRP_BUILD_BUG_ON_STRUCT(x)=
 \
+    glue(qemu_build_bug_on__, __COUNTER__) __attribute__((unused))
+#else
+#define SLIRP_BUILD_BUG_MSG(x, msg)
+#endif
+
+#define SLIRP_BUILD_BUG_ON(x) SLIRP_BUILD_BUG_MSG(x, "not expecting: " #=
x)
+
 #define SCALE_MS 1000000
=20
 #define ETH_ALEN    6
--=20
2.20.1
