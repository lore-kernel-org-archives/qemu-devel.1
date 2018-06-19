Received: from eggs.gnu.org ([2001:4830:134:3::10]:33348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCgV-0002wP-MZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCgL-0007xB-VP
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:12:19 -0400
Message-Id: <c731f28c764cd5d7006f66c53fcb857471c26396.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 10/11] sm501: Set updated region dirty after
 2D operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Set the changed memory region dirty after performed a 2D operation to
ensure that the screen is updated properly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index e126c15..ad518ce 100644
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
