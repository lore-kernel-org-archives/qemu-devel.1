Received: from eggs.gnu.org ([2001:4830:134:3::10]:52341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddasb-0003zP-TV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddarI-0008QO-VE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddarI-0008PB-Iw
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:33:36 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  4 Aug 2017 12:33:29 +0100
Message-Id: <20170804113329.13609-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.11] vga/migration: Update memory map in
 post_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com, jan.kiszka@siemens.com
Cc: quintela@redhat.com, maxime.coquelin@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

After migration the chain4 alias mapping added by 80763888 (in 2011)
might be missing, since there's no call to vga_update_memory_access
in the post_load after the registers are updated.  Add it back.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/display/vga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 63421f9ee8..5d3848a37e 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2044,6 +2044,7 @@ static int vga_common_post_load(void *opaque, int version_id)
     /* force refresh */
     s->graphic_mode = -1;
     vbe_update_vgaregs(s);
+    vga_update_memory_access(s);
     return 0;
 }
 
-- 
2.13.3
