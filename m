Received: from eggs.gnu.org ([209.51.188.92]:33119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44d-0005f4-P0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44b-0005uQ-Of
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:51 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr44b-0005lY-Ga
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:49 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue,  5 Feb 2019 18:58:56 +0200
Message-Id: <20190205165927.26599-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
References: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 01/32] slirp: Avoid unaligned 16bit memory
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
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
