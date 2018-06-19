Received: from eggs.gnu.org ([2001:4830:134:3::10]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVClx-0007Dj-34
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVClw-0000xv-6I
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:17:57 -0400
Message-Id: <19b85df7e2bdf554c714ba020786658c541908de.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 09/11] sm501: Use values from the pitch
 register for 2d operations.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

From: Sebastian Bauer <mail@sebastianbauer.info>

Before, crt_h_total was used for src_width and dst_width. This is a
property of the current display setting and not relevant for the 2d
operation that also can be done off-screen. The pitch register's purpose
is to describe line pitch relevant of the 2d operation.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index e5df6c7..e126c15 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -701,8 +701,8 @@ static void sm501_2d_operation(SM501State *s)
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
2.7.6
