Received: from eggs.gnu.org ([2001:4830:134:3::10]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7zS-0002OO-1V
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7zR-0005Pq-1k
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:21:42 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:52 +0200
Message-Id: <20180511131953.12905-17-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/17] s390x: initialize memory region for
 memory devices
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

While s390x has no real interface for communicating devices mapped into
the physical address space of the guest, paravirtualized devices can
easily expose the applicable address range themselves.

So let's use the difference between maxram_size and ram_size as the size
for our hotplug memory area (just as on other architectures).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ee0a2b124f..09b755282b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -157,9 +157,11 @@ static void virtio_ccw_register_hcalls(void)
 #define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
 #define SEG_MSK (~0xfffffULL)
 #define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
-static void s390_memory_init(ram_addr_t mem_size)
+static void s390_memory_init(MachineState *machine)
 {
+    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     MemoryRegion *sysmem = get_system_memory();
+    ram_addr_t mem_size = machine->ram_size;
     ram_addr_t chunk, offset = 0;
     unsigned int number = 0;
     gchar *name;
@@ -181,6 +183,28 @@ static void s390_memory_init(ram_addr_t mem_size)
     }
     g_free(name);
 
+    /* always allocate the device memory information */
+    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
+
+    /* initialize device memory address space */
+    if (machine->ram_size < machine->maxram_size) {
+        ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
+
+        if (QEMU_ALIGN_UP(machine->maxram_size, TARGET_PAGE_SIZE) !=
+            machine->maxram_size) {
+            error_report("maximum memory size must be aligned to multiple of "
+                         "%d bytes", TARGET_PAGE_SIZE);
+            exit(EXIT_FAILURE);
+        }
+
+        machine->device_memory->base = machine->ram_size;
+        memory_region_init(&machine->device_memory->mr, OBJECT(ms),
+                           "device-memory", device_mem_size);
+        memory_region_add_subregion(sysmem, machine->device_memory->base,
+                                    &machine->device_memory->mr);
+
+    }
+
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
@@ -304,7 +328,7 @@ static void ccw_init(MachineState *machine)
     DeviceState *dev;
 
     s390_sclp_init();
-    s390_memory_init(machine->ram_size);
+    s390_memory_init(machine);
 
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
-- 
2.14.3
