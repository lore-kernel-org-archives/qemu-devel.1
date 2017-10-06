Received: from eggs.gnu.org ([2001:4830:134:3::10]:41960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQI-0000Gc-Th
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQH-0006CH-J2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:35 -0300
Message-Id: <20171006235023.11952-41-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 40/88] hw/xen: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: replaced g_new0() -> g_new() in xen_remap_bucket() (no bzero required),
      renamed X86 -> hw/xen and few other changes]
---
 hw/9pfs/xen-9p-backend.c   |  2 +-
 hw/display/xenfb.c         |  4 ++--
 hw/i386/xen/xen-hvm.c      | 10 +++++-----
 hw/i386/xen/xen-mapcache.c | 14 +++++++-------
 hw/xen/xen_pvdev.c         |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index ee87f08926..d76fa0df8e 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -365,7 +365,7 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    xen_9pdev->rings = g_malloc0(xen_9pdev->num_rings * sizeof(Xen9pfsRing));
+    xen_9pdev->rings = g_new0(Xen9pfsRing, xen_9pdev->num_rings);
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         char *str;
         int ring_order;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 8e2547ac05..5b5fa34131 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -479,8 +479,8 @@ static int xenfb_map_fb(struct XenFB *xenfb)
     n_fbdirs = xenfb->fbpages * mode / 8;
     n_fbdirs = DIV_ROUND_UP(n_fbdirs, XC_PAGE_SIZE);
 
-    pgmfns = g_malloc0(sizeof(xen_pfn_t) * n_fbdirs);
-    fbmfns = g_malloc0(sizeof(xen_pfn_t) * xenfb->fbpages);
+    pgmfns = g_new0(xen_pfn_t, n_fbdirs);
+    fbmfns = g_new0(xen_pfn_t, xenfb->fbpages);
 
     xenfb_copy_mfns(mode, n_fbdirs, pgmfns, pd);
     map = xenforeignmemory_map(xen_fmem, xenfb->c.xendev.dom,
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d9ccd5d0d6..37a4e1cd6c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -376,7 +376,7 @@ go_physmap:
 
     mr_name = memory_region_name(mr);
 
-    physmap = g_malloc(sizeof(XenPhysmap));
+    physmap = g_new(XenPhysmap, 1);
 
     physmap->start_addr = start_addr;
     physmap->size = size;
@@ -1188,7 +1188,7 @@ static void xen_read_physmap(XenIOState *state)
         return;
 
     for (i = 0; i < num; i++) {
-        physmap = g_malloc(sizeof (XenPhysmap));
+        physmap = g_new(XenPhysmap, 1);
         physmap->phys_offset = strtoull(entries[i], NULL, 16);
         snprintf(path, sizeof(path),
                 "/local/domain/0/device-model/%d/physmap/%s/start_addr",
@@ -1240,7 +1240,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     evtchn_port_t bufioreq_evtchn;
     XenIOState *state;
 
-    state = g_malloc0(sizeof (XenIOState));
+    state = g_new0(XenIOState, 1);
 
     state->xce_handle = xenevtchn_open(NULL, 0);
     if (state->xce_handle == NULL) {
@@ -1321,7 +1321,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     }
 
     /* Note: cpus is empty at this point in init */
-    state->cpu_by_vcpu_id = g_malloc0(max_cpus * sizeof(CPUState *));
+    state->cpu_by_vcpu_id = g_new0(CPUState *, max_cpus);
 
     rc = xen_set_ioreq_server_state(xen_domid, state->ioservid, true);
     if (rc < 0) {
@@ -1330,7 +1330,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
-    state->ioreq_local_port = g_malloc0(max_cpus * sizeof (evtchn_port_t));
+    state->ioreq_local_port = g_new0(evtchn_port_t, max_cpus);
 
     /* FIXME: how about if we overflow the page here? */
     for (i = 0; i < max_cpus; i++) {
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index baab93b614..93cba7fb83 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -109,7 +109,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
     unsigned long size;
     struct rlimit rlimit_as;
 
-    mapcache = g_malloc0(sizeof (MapCache));
+    mapcache = g_new0(MapCache, 1);
 
     mapcache->phys_offset_to_gaddr = f;
     mapcache->opaque = opaque;
@@ -165,8 +165,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
 
     trace_xen_remap_bucket(address_index);
 
-    pfns = g_malloc0(nb_pfn * sizeof (xen_pfn_t));
-    err = g_malloc0(nb_pfn * sizeof (int));
+    err = g_new0(int, nb_pfn);
 
     if (entry->vaddr_base != NULL) {
         if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
@@ -180,6 +179,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     g_free(entry->valid_mapping);
     entry->valid_mapping = NULL;
 
+    pfns = g_new(xen_pfn_t, nb_pfn);
     for (i = 0; i < nb_pfn; i++) {
         pfns[i] = (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT)) + i;
     }
@@ -212,8 +212,8 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     entry->vaddr_base = vaddr_base;
     entry->paddr_index = address_index;
     entry->size = size;
-    entry->valid_mapping = (unsigned long *) g_malloc0(sizeof(unsigned long) *
-            BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
+    entry->valid_mapping = g_new0(unsigned long,
+                                  BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
 
     if (dummy) {
         entry->flags |= XEN_MAPCACHE_ENTRY_DUMMY;
@@ -300,7 +300,7 @@ tryagain:
         pentry = free_pentry;
     }
     if (!entry) {
-        entry = g_malloc0(sizeof (MapCacheEntry));
+        entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
         xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
     } else if (!entry->lock) {
@@ -334,7 +334,7 @@ tryagain:
 
     mapcache->last_entry = entry;
     if (lock) {
-        MapCacheRev *reventry = g_malloc0(sizeof(MapCacheRev));
+        MapCacheRev *reventry = g_new0(MapCacheRev, 1);
         entry->lock++;
         reventry->dma = dma;
         reventry->vaddr_req = mapcache->last_entry->vaddr_base + address_offset;
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index aed783e844..8c1c14fb60 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -43,7 +43,7 @@ static void xenstore_cleanup_dir(char *dir)
 {
     struct xs_dirs *d;
 
-    d = g_malloc(sizeof(*d));
+    d = g_new(struct xs_dirs, 1);
     d->xs_dir = dir;
     QTAILQ_INSERT_TAIL(&xs_cleanup, d, list);
 }
-- 
2.14.2
