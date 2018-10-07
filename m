Received: from eggs.gnu.org ([2001:4830:134:3::10]:54608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQp-0008VL-8z
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQo-00017i-8a
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:31 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1g9DQn-0000wv-Lo
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:29 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun,  7 Oct 2018 20:05:17 +0200
Message-Id: <20181007180518.5212-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
References: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Andrew Oates <aoates@google.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Andrew Oates <aoates@google.com>

On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
read from.  On macOS, however, the socket acts like a SOCK_RAW socket
and includes the IP header as well.

This change strips the extra IP header from the received packet on macOS
before sending it to the guest.  SOCK_DGRAM ICMP sockets aren't
supported on other BSDs, but we enable this behavior for them as well to
treat the sockets the same as raw sockets.

Signed-off-by: Andrew Oates <aoates@google.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_icmp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 0b667a429a..da100d1f55 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -420,7 +420,32 @@ void icmp_receive(struct socket *so)
     icp =3D mtod(m, struct icmp *);
=20
     id =3D icp->icmp_id;
-    len =3D qemu_recv(so->s, icp, m->m_len, 0);
+    len =3D qemu_recv(so->s, icp, M_ROOM(m), 0);
+    /*
+     * The behavior of reading SOCK_DGRAM+IPPROTO_ICMP sockets is incons=
istent
+     * between host OSes.  On Linux, only the ICMP header and payload is
+     * included.  On macOS/Darwin, the socket acts like a raw socket and
+     * includes the IP header as well.  On other BSDs, SOCK_DGRAM+IPPROT=
O_ICMP
+     * sockets aren't supported at all, so we treat them like raw socket=
s.  It
+     * isn't possible to detect this difference at runtime, so we must u=
se an
+     * #ifdef to determine if we need to remove the IP header.
+     */
+#ifdef CONFIG_BSD
+    if (len >=3D sizeof(struct ip)) {
+        struct ip *inner_ip =3D mtod(m, struct ip *);
+        int inner_hlen =3D inner_ip->ip_hl << 2;
+        if (inner_hlen > len) {
+            len =3D -1;
+            errno =3D -EINVAL;
+        } else {
+            len -=3D inner_hlen;
+            memmove(icp, (unsigned char *)icp + inner_hlen, len);
+        }
+    } else {
+      len =3D -1;
+      errno =3D -EINVAL;
+    }
+#endif
     icp->icmp_id =3D id;
=20
     m->m_data -=3D hlen;
--=20
2.19.0
