Received: from eggs.gnu.org ([209.51.188.92]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnVNB-0007Wg-9b
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnVNA-0004XD-AH
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:20:17 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnVNA-0004Wf-2a
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:20:16 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 26 Jan 2019 22:20:08 +0100
Message-Id: <20190126212010.11730-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190126212010.11730-1-samuel.thibault@ens-lyon.org>
References: <20190126212010.11730-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] slirp: Avoid unaligned 16bit memory access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Richard Henderson <richard.henderson@linaro.org>

pkt parameter may be unaligned, so we must access it byte-wise.

This fixes sparc64 host SIGBUS during pxe boot.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 slirp/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index a9674ab090..739f364770 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -829,7 +829,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, in=
t pkt_len)
     if (pkt_len < ETH_HLEN)
         return;
=20
-    proto =3D ntohs(*(uint16_t *)(pkt + 12));
+    proto =3D (((uint16_t) pkt[12]) << 8) + pkt[13];
     switch(proto) {
     case ETH_P_ARP:
         arp_input(slirp, pkt, pkt_len);
--=20
2.20.1
