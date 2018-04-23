Received: from eggs.gnu.org ([2001:4830:134:3::10]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAehW-0007y4-NL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAehV-0000Dd-NT
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:52:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 23 Apr 2018 18:51:26 +0200
Message-Id: <20180423165126.15441-12-david@redhat.com>
In-Reply-To: <20180423165126.15441-1-david@redhat.com>
References: <20180423165126.15441-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/11] vl: allow 'maxmem' without 'slot'
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

We will be able to have memory devices (e.g. virtio) not requiring the
slot parameter (e.g. not exposed via ACPI). We still need the maxmem
parameter to setup a proper memory region for device memory. And some
architectures (e.g. s390x) will have to set up the maximum possible guest
address space size based on the maxmem parameter.

As far as I can see, all code (pc.c,spapr.c,ACPI code) should handle
!slots just fine, even though maxmem is set.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 vl.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/vl.c b/vl.c
index fce1fd12d8..acb815bc14 100644
--- a/vl.c
+++ b/vl.c
@@ -2887,7 +2887,6 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 {
     uint64_t sz;
     const char *mem_str;
-    const char *maxmem_str, *slots_str;
     const ram_addr_t default_ram_size = mc->default_ram_size;
     QemuOpts *opts = qemu_find_opts_singleton("memory");
     Location loc;
@@ -2933,9 +2932,7 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
     qemu_opt_set_number(opts, "size", ram_size, &error_abort);
     *maxram_size = ram_size;
 
-    maxmem_str = qemu_opt_get(opts, "maxmem");
-    slots_str = qemu_opt_get(opts, "slots");
-    if (maxmem_str && slots_str) {
+    if (qemu_opt_get(opts, "maxmem")) {
         uint64_t slots;
 
         sz = qemu_opt_get_size(opts, "maxmem", 0);
@@ -2946,13 +2943,7 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
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
@@ -2962,10 +2953,8 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 
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
