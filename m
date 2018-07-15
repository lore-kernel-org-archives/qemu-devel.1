Received: from eggs.gnu.org ([2001:4830:134:3::10]:38756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1feoOe-0007H8-Fe
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1feoOb-0004rr-B6
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:17:36 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 15 Jul 2018 22:47:26 +0200
Message-Id: <20180715211731.2EBA27456B1@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH for 3.0] sam460ex: Correct use after free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

Commit 51b0d834c changed error handling to report file name in error
message but forgot to move freeing it after usage. Noticed by Coverity.

Fixes: CID 1394217
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/sam460ex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index e2b7028..0999efc 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -269,11 +269,12 @@ static int sam460ex_load_device_tree(hwaddr addr,
         exit(1);
     }
     fdt = load_device_tree(filename, &fdt_size);
-    g_free(filename);
     if (!fdt) {
         error_report("Couldn't load dtb file `%s'", filename);
+        g_free(filename);
         exit(1);
     }
+    g_free(filename);
 
     /* Manipulate device tree in memory. */
 
-- 
2.7.6
