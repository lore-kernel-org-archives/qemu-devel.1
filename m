Received: from eggs.gnu.org ([2001:4830:134:3::10]:34221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1dIe1A-00020Z-Cz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1dIe17-0000rG-8f
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:12 -0400
Received: from forward14p.cmail.yandex.net ([87.250.241.142]:47377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rndfax@yandex.ru>) id 1dIe17-0000q9-1C
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:09 -0400
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::94])
	by forward14p.cmail.yandex.net (Yandex) with ESMTP id 01DBD2178F
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:41:05 +0300 (MSK)
From: Aleksey Kuleshov <rndfax@yandex.ru>
MIME-Version: 1.0
Message-Id: <4401421496853664@web26g.yandex.ru>
Date: Wed, 07 Jun 2017 19:41:04 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] m25p80: Fix WINBOND fast read command dummy
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

The original commit (3830c7a460b8252dc975f8115fdaed8c562d2d75)
stated "Datasheet states that default dummy cycles is 8 so fix it."

But since dummy cycles are handled in bytes it must be 1, not 8.

Signed-off-by: Aleksey Kuleshov <rndfax@yandex.ru>
---
 hw/block/m25p80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 190573cefa..bf36159636 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -793,7 +793,7 @@ static void decode_fast_read_cmd(Flash *s)
     switch (get_man(s)) {
     /* Dummy cycles - modeled with bytes writes instead of bits */
     case MAN_WINBOND:
-        s->needed_bytes += 8;
+        s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
         s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
-- 
2.11.0
