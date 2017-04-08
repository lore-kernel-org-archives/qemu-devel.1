Received: from eggs.gnu.org ([2001:4830:134:3::10]:53635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cwrwZ-0004LM-Oa
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 11:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cwrwV-00048s-Kt
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 11:06:27 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1cwrwV-00048h-Em
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 11:06:23 -0400
Received: by mail-pg0-x244.google.com with SMTP id o123so20445403pga.1
	for <qemu-devel@nongnu.org>; Sat, 08 Apr 2017 08:06:23 -0700 (PDT)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Sat,  8 Apr 2017 20:35:24 +0530
Message-Id: <20170408150524.2870-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/core: fix segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Suramya Shah <shah.suramya@gmail.com>

Reproducer:
 $i386-softmmu/qemu-system-i386 -S -machine isapc,accel=tcg -device amd-iommu
Segmentation fault (core dumped)

Partial bt:
#0  bus_add_child (child=0x555556d4e520, bus=0x0) at hw/core/qdev.c:88
#1  qdev_set_parent_bus (dev=0x555556d4e520, bus=bus@entry=0x0)
at hw/core/qdev.c:119

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
 hw/core/qdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1e7fb33..07a211b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -84,7 +84,11 @@ static void bus_add_child(BusState *bus, DeviceState *child)
 {
     char name[32];
     BusChild *kid = g_malloc0(sizeof(*kid));
-
+    
+    if (!bus) {
+        error_report("bus not found ");
+        exit(0);
+    }
     kid->index = bus->max_index++;
     kid->child = child;
     object_ref(OBJECT(kid->child));
-- 
2.9.3
