Received: from eggs.gnu.org ([2001:4830:134:3::10]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkG-00048r-Pm
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkF-0003jF-PT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coRkF-0003ii-Iw
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 577643DBE9
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:30:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 10:30:38 +0100
Message-Id: <1489656642-12925-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
References: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 3/7] cirrus: switch to 4 MB video memory
 by default
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

Quoting cirrus source code:
   Follow real hardware, cirrus card emulated has 4 MB video memory.
   Also accept 8 MB/16 MB for backward compatibility.

So just use 4MB by default.  We decided to leave that at 8MB by default
a while ago, for live migration compatibility reasons.  But we have
compat properties to handle that, so that isn't a compeling reason.

This also removes some sanity check inconsistencies in the cirrus code.
Some places check against the allocated video memory, some places check
against the 4MB physical hardware has.  Guest code can trigger asserts
because of that.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1489494514-15606-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 4 ++--
 include/hw/compat.h     | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index c90a4a3..6ffe64f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3023,7 +3023,7 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
 
 static Property isa_cirrus_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
-                       cirrus_vga.vga.vram_size_mb, 8),
+                       cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3092,7 +3092,7 @@ static void pci_cirrus_vga_realize(PCIDevice *dev, Error **errp)
 
 static Property pci_vga_cirrus_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct PCICirrusVGAState,
-                       cirrus_vga.vga.vram_size_mb, 8),
+                       cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index b7db438..b7e0e9f 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -18,6 +18,14 @@
         .driver   = "pci-bridge",\
         .property = "shpc",\
         .value    = "on",\
+    },{\
+        .driver   = "cirrus-vga",\
+        .property = "vgamem_mb",\
+        .value    = "8",\
+    },{\
+        .driver   = "isa-cirrus-vga",\
+        .property = "vgamem_mb",\
+        .value    = "8",\
     },
 
 #define HW_COMPAT_2_7 \
-- 
1.8.3.1
