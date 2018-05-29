Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY83-0001Mh-TA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY80-0001Wv-Kc
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:07 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:38675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNY80-0001WB-EM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:04 -0400
Received: from player718.ha.ovh.net (unknown [10.109.108.63])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 08BE7139F68
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:29:02 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 29 May 2018 08:28:35 +0200
Message-Id: <20180529062838.20556-4-clg@kaod.org>
In-Reply-To: <20180529062838.20556-1-clg@kaod.org>
References: <20180529062838.20556-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] net/ftgmac100: fix multicast hash routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Based on the multicast hash calculation of the FTGMAC100 Linux driver.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 50af1222464a..fd7699b1c05e 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -778,8 +778,8 @@ static int ftgmac100_filter(FTGMAC100State *s, const =
uint8_t *buf, size_t len)
                 return 0;
             }
=20
-            /* TODO: this does not seem to work for ftgmac100 */
-            mcast_idx =3D net_crc32(buf, ETH_ALEN) >> 26;
+            mcast_idx =3D net_crc32_le(buf, ETH_ALEN);
+            mcast_idx =3D (~(mcast_idx >> 2)) & 0x3f;
             if (!(s->math[mcast_idx / 32] & (1 << (mcast_idx % 32)))) {
                 return 0;
             }
--=20
2.13.6
