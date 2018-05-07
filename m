Received: from eggs.gnu.org ([2001:4830:134:3::10]:38786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYi-00071z-Uw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYe-00083y-CL
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjYe-00083Y-4Y
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:14 -0300
Message-Id: <20180507170315.11497-12-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] vl: allow 'maxmem' without 'slot'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We will be able to have memory devices (e.g. virtio) not requiring the
slot parameter (e.g. not exposed via ACPI). We still need the maxmem
parameter to setup a proper memory region for device memory. And some
architectures (e.g. s390x) will have to set up the maximum possible guest
address space size based on the maxmem parameter.

As far as I can see, all code (pc.c,spapr.c,ACPI code) should handle
!slots just fine, even though maxmem is set.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-12-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/vl.c b/vl.c
index 806eec2ef6..12e31d1aa9 100644
--- a/vl.c
+++ b/vl.c
@@ -2868,7 +2868,6 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 {
     uint64_t sz;
     const char *mem_str;
-    const char *maxmem_str, *slots_str;
     const ram_addr_t default_ram_size = mc->default_ram_size;
     QemuOpts *opts = qemu_find_opts_singleton("memory");
     Location loc;
@@ -2914,9 +2913,7 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
     qemu_opt_set_number(opts, "size", ram_size, &error_abort);
     *maxram_size = ram_size;
 
-    maxmem_str = qemu_opt_get(opts, "maxmem");
-    slots_str = qemu_opt_get(opts, "slots");
-    if (maxmem_str && slots_str) {
+    if (qemu_opt_get(opts, "maxmem")) {
         uint64_t slots;
 
         sz = qemu_opt_get_size(opts, "maxmem", 0);
@@ -2927,13 +2924,7 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
                          "the initial memory size (0x" RAM_ADDR_FMT ")",
                          sz, ram_size);
             exit(EXIT_FAILURE);
-        } else if (sz > ram_size) {
-            if (!slots) {
-                error_report("invalid value of -m option: maxmem was "
-                             "specified, but no hotplug slots were specified");
-                exit(EXIT_FAILURE);
-            }
-        } else if (slots) {
+        } else if (slots && sz == ram_size) {
             error_report("invalid value of -m option maxmem: "
                          "memory slots were specified but maximum memory size "
                          "(0x%" PRIx64 ") is equal to the initial memory size "
@@ -2943,10 +2934,8 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 
         *maxram_size = sz;
         *ram_slots = slots;
-    } else if ((!maxmem_str && slots_str) ||
-            (maxmem_str && !slots_str)) {
-        error_report("invalid -m option value: missing "
-                "'%s' option", slots_str ? "maxmem" : "slots");
+    } else if (qemu_opt_get(opts, "slots")) {
+        error_report("invalid -m option value: missing 'maxmem' option");
         exit(EXIT_FAILURE);
     }
 
-- 
2.14.3
