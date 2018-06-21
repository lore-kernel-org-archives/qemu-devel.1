Received: from eggs.gnu.org ([2001:4830:134:3::10]:52704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVuwk-0001jc-9H
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVuwh-0004cw-1d
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:28:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:16897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fVuwg-0004cA-QH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:27:58 -0400
Message-Id: <d565e8658b3614c57d32598e2e5622d4e40e8dd7.1529568501.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529568501.git.balaton@eik.bme.hu>
References: <cover.1529568501.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 21 Jun 2018 10:08:21 +0200
Subject: [Qemu-devel] [PATCH 4/5] sm501: Set updated region dirty after 2D
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

Set the changed memory region dirty after performed a 2D operation to
ensure that the screen is updated properly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index a6232ed..e426d2f 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -774,6 +774,11 @@ static void sm501_2d_operation(SM501State *s)
         abort();
         break;
     }
+
+    memory_region_set_dirty(&s->local_mem_region,
+                            s->twoD_destination_base & 0x03FFFFFF,
+                            (dst_y + operation_height) * dst_width +
+                            dst_x + operation_width);
 }
 
 static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
-- 
2.7.6
