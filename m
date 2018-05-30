Received: from eggs.gnu.org ([2001:4830:134:3::10]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQa-0002Bi-Gj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQX-0001Gz-BX
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:44 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:53049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuQX-0001GT-43
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:41 -0400
Received: from player718.ha.ovh.net (unknown [10.109.122.69])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4FCC91B7DAC
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:17:37 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:17:10 +0200
Message-Id: <20180530061711.23673-4-clg@kaod.org>
In-Reply-To: <20180530061711.23673-1-clg@kaod.org>
References: <20180530061711.23673-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/4] ftgmac100: fix multicast hash routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Based on the multicast hash calculation of the FTGMAC100 Linux driver.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/net/ftgmac100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index abf80655f28f..8a7f274dc118 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -776,8 +776,8 @@ static int ftgmac100_filter(FTGMAC100State *s, const =
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
