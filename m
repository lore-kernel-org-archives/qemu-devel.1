Received: from eggs.gnu.org ([2001:4830:134:3::10]:47873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFd6C-0006sF-2i
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFd67-00056n-3u
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:10:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFd66-00056B-VJ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DDE8401DEBB
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 10:10:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 12:10:13 +0200
Message-Id: <20180507101013.32736-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
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

... to a virtual machine.  Without that we fail a ramblock register
sanity check, leading to a abort(), which isn't exactly user friendly.

https://bugzilla.redhat.com/show_bug.cgi?id=1206037
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 72181330b8..328b6413ad 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2184,6 +2184,14 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
     }
     s->vbe_size_mask = s->vbe_size - 1;
 
+    if (global_vmstate) {
+        static int have_vga;
+        if (have_vga) {
+            error_report("only one vga device is supported");
+            exit(1);
+        }
+        have_vga = true;
+    }
     s->is_vbe_vmstate = 1;
     memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
                            &error_fatal);
-- 
2.9.3
