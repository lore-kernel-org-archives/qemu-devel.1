Received: from eggs.gnu.org ([2001:4830:134:3::10]:60624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1dIdwW-0005Wn-OY
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1dIdwS-0006af-Ri
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:36:24 -0400
Received: from forward13o.cmail.yandex.net ([37.9.109.182]:41967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rndfax@yandex.ru>) id 1dIdwS-0006Yk-G9
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:36:20 -0400
From: Aleksey Kuleshov <rndfax@yandex.ru>
MIME-Version: 1.0
Message-Id: <4392061496853374@web26g.yandex.ru>
Date: Wed, 07 Jun 2017 19:36:14 +0300
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
To: qemu-devel@nongnu.org
Cc: Marcin Krzeminski <marcin.krzeminski@nokia.com>

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
