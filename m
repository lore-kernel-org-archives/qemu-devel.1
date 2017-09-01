Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjjq-0004kN-L8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjjj-0003LG-0P
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:03:50 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Sep 2017 13:03:32 +0200
Message-Id: <20170901110332.32650-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of i82374
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com

When used with the following command line:

 ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374

QEMU with machine type 40p already creates the device i82374. If
specified in the command line, it will try to create it again, hence
generating the error. One way to avoid this problem is to set
user_creatable=false.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 hw/dma/i82374.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 6c0f975df0..5275d822e0 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -139,6 +139,7 @@ static void i82374_class_init(ObjectClass *klass, void *data)
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
     dc->props = i82374_properties;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo i82374_info = {
-- 
2.13.5
