Received: from eggs.gnu.org ([2001:4830:134:3::10]:36800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBeEc-0005Rb-QT
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBeEY-0004jV-Sv
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:34:42 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 26 Apr 2018 12:34:30 +0200
Message-Id: <20180426103430.768-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] pc-dimm: fix error messages if no slots
 were defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

If not slots were defined we try to allocate an empty bitmap, which
fails.

Signed-off-by: David Hildenbrand <david@redhat.com>
---

This fixes the queued patch "exec: Allow memory regions with size 0"

 hw/mem/pc-dimm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 0119c68e01..f2c140947d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -118,9 +118,15 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
 {
-    unsigned long *bitmap = bitmap_new(max_slots);
+    unsigned long *bitmap;
     int slot = 0;
 
+    if (max_slots <= 0) {
+        error_setg(errp, "no free slots available");
+        return slot;
+    }
+
+    bitmap = bitmap_new(max_slots);
     object_child_foreach(qdev_get_machine(), pc_dimm_slot2bitmap, bitmap);
 
     /* check if requested slot is not occupied */
-- 
2.14.3
