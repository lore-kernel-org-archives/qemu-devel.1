Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAI8-0004OF-2r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAI3-0005B6-2b
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:20 +0200
Message-Id: <20180514100023.12542-16-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 15/18] s390x/sclp: make sure ram_size and
 maxram_size stay in sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

On s390x, we sometimes have to shrink ram_size in order to be able to
correctly indicate the size to the guest.

In case maxmem is not set, ram_size and maxram_size should always be
kept equal. Make sure to also fixup maxram_size if necessary.

In case maxmem is set, we really want to bail out in case we have to
round down, as it basically can screw up the size of the device memory
area later on.

Pleas note that this fixup ususally does not happen with sane values
for the ram size.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 047d577313..0757914374 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -21,6 +21,8 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "qemu/error-report.h"
+
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -318,9 +320,19 @@ static void sclp_memory_init(SCLPDevice *sclp)
      * down to align with the nearest increment boundary. */
     initial_mem = initial_mem >> increment_size << increment_size;
 
-    machine->ram_size = initial_mem;
-    /* let's propagate the changed ram size into the global variable. */
-    ram_size = initial_mem;
+    /* also shrink maxram_size in case we don't have maxmem configured */
+    if (initial_mem != machine->ram_size) {
+        if (machine->ram_size < machine->maxram_size) {
+            error_report("Ram size ('" RAM_ADDR_FMT "') had to be rounded "
+                         "down to ('" RAM_ADDR_FMT "'), maxmem not supported",
+                         machine->ram_size, initial_mem);
+            exit(1);
+        }
+        /* propagate the changed ram size into the different places */
+        machine->ram_size = initial_mem;
+        ram_size = initial_mem;
+        machine->maxram_size = initial_mem;
+    }
 }
 
 static void sclp_init(Object *obj)
-- 
2.14.3
