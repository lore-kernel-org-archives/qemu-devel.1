Received: from eggs.gnu.org ([209.51.188.92]:52493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0001Nn-Gv
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCA-0007P1-AS
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjC9-0007LM-Va
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:50 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:04:57 +0100
Message-Id: <20190127120526.15457-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/31] slirp: Avoid marking naturally packed
 structs as QEMU_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

Various ipv6 structs in the slirp headers are marked QEMU_PACKED,
but they are actually naturally aligned and will have no padding
in them. Instead of marking them with the 'packed' attribute,
assert at compile time that they are the size we expect. This
allows us to take the address of fields within the structs
without risking undefined behaviour, and suppresses clang
-Waddress-of-packed-member warnings.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6.h      | 12 ++++++++++--
 slirp/ip6_icmp.h | 20 +++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index 14e9c78735..1e3e329ce6 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -133,7 +133,7 @@ struct ip6 {
     uint8_t     ip_nh;               /* next header */
     uint8_t     ip_hl;               /* hop limit */
     struct in6_addr ip_src, ip_dst;  /* source and dest address */
-} QEMU_PACKED;
+};
=20
 /*
  * IPv6 pseudo-header used by upper-layer protocols
@@ -145,7 +145,15 @@ struct ip6_pseudohdr {
     uint16_t    ih_zero_hi;       /* zero */
     uint8_t     ih_zero_lo;       /* zero */
     uint8_t     ih_nh;            /* next header */
-} QEMU_PACKED;
+};
=20
+/*
+ * We don't want to mark these ip6 structs as packed as they are natural=
ly
+ * correctly aligned; instead assert that there is no stray padding.
+ * If we marked the struct as packed then we would be unable to take
+ * the address of any of the fields in it.
+ */
+QEMU_BUILD_BUG_ON(sizeof(struct ip6) !=3D 40);
+QEMU_BUILD_BUG_ON(sizeof(struct ip6_pseudohdr) !=3D 40);
=20
 #endif
diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index 32b0914055..2ad2b75e67 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -48,12 +48,16 @@ struct ndp_ra {     /* Router Advertisement Message *=
/
     uint16_t lifetime;      /* Router Lifetime */
     uint32_t reach_time;    /* Reachable Time */
     uint32_t retrans_time;  /* Retrans Timer */
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(sizeof(struct ndp_ra) !=3D 12);
=20
 struct ndp_ns {     /* Neighbor Solicitation Message */
     uint32_t reserved;
     struct in6_addr target; /* Target Address */
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(sizeof(struct ndp_ns) !=3D 20);
=20
 struct ndp_na {     /* Neighbor Advertisement Message */
 #if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
@@ -72,13 +76,17 @@ struct ndp_na {     /* Neighbor Advertisement Message=
 */
         reserved_lo:24;
 #endif
     struct in6_addr target; /* Target Address */
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(sizeof(struct ndp_na) !=3D 20);
=20
 struct ndp_redirect {
     uint32_t reserved;
     struct in6_addr target; /* Target Address */
     struct in6_addr dest;   /* Destination Address */
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(sizeof(struct ndp_redirect) !=3D 36);
=20
 /*
  * Structure of an icmpv6 header.
@@ -103,7 +111,9 @@ struct icmp6 {
 #define icmp6_nns icmp6_body.ndp_ns
 #define icmp6_nna icmp6_body.ndp_na
 #define icmp6_redirect icmp6_body.ndp_redirect
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(sizeof(struct icmp6) !=3D 40);
=20
 #define ICMP6_MINLEN    4
 #define ICMP6_ERROR_MINLEN  8
--=20
2.20.1
