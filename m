Received: from eggs.gnu.org ([2001:4830:134:3::10]:44213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq8-00053C-IG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq7-0002Da-JE
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:39 +1000
Message-Id: <20180709074350.27086-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/16] sm501: Use values from the pitch register
 for 2D operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: Sebastian Bauer <mail@sebastianbauer.info>

Before, crt_h_total was used for src_width and dst_width. This is a
property of the current display setting and not relevant for the 2D
operation that also can be done off-screen. The pitch register's purpose
is to describe line pitch relevant of the 2D operation.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index b095134d6f..d4878f01c0 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -709,8 +709,8 @@ static void sm501_2d_operation(SM501State *s)
     /* get frame buffer info */
     uint8_t *src = s->local_mem + (s->twoD_source_base & 0x03FFFFFF);
     uint8_t *dst = s->local_mem + (s->twoD_destination_base & 0x03FFFFFF);
-    int src_width = (s->dc_crt_h_total & 0x00000FFF) + 1;
-    int dst_width = (s->dc_crt_h_total & 0x00000FFF) + 1;
+    int src_width = s->twoD_pitch & 0x1FFF;
+    int dst_width = (s->twoD_pitch >> 16) & 0x1FFF;
 
     if (addressing != 0x0) {
         printf("%s: only XY addressing is supported.\n", __func__);
-- 
2.17.1
