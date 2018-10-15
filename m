Received: from eggs.gnu.org ([2001:4830:134:3::10]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gBvp1-0003Wb-A2
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 01:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gBvox-00037w-5D
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 01:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gBvow-00037J-VR
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 01:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C743308FBAE
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 05:53:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Oct 2018 07:53:33 +0200
Message-Id: <20181015055333.32030-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] edid: fix alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Use stl_le_p() & friends instead of casts.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/edid-generate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index 37e60fe42a..bdf5e1d4d4 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -223,7 +223,7 @@ static void edid_desc_timing(uint8_t *desc,
 
     uint32_t clock  = 75 * (xres + xblank) * (yres + yblank);
 
-    *(uint32_t *)(desc) = cpu_to_le32(clock / 10000);
+    stl_le_p(desc, clock / 10000);
 
     desc[2] = xres   & 0xff;
     desc[3] = xblank & 0xff;
@@ -342,9 +342,9 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
                           (((info->vendor[2] - '@') & 0x1f) <<  0));
     uint16_t model_nr = 0x1234;
     uint32_t serial_nr = info->serial ? atoi(info->serial) : 0;
-    *(uint16_t *)(edid +  8) = cpu_to_be16(vendor_id);
-    *(uint16_t *)(edid + 10) = cpu_to_le16(model_nr);
-    *(uint32_t *)(edid + 12) = cpu_to_le32(serial_nr);
+    stw_be_p(edid +  8, vendor_id);
+    stw_le_p(edid + 10, model_nr);
+    stl_le_p(edid + 12, serial_nr);
 
     /* manufacture week and year */
     edid[16] = 42;
-- 
2.9.3
