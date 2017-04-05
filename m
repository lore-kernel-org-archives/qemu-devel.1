Received: from eggs.gnu.org ([2001:4830:134:3::10]:41614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpr3-0006Jq-4m
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqz-0000MV-3U
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:40:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:29260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvpqy-0000Lk-H6
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:40:25 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 5 Apr 2017 18:40:21 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A4F601@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel]  [PATCH 3/3] move xen-mapcache.c to hw/i386/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

move xen-mapcache.c to hw/i386/xen/

Signed-off -by: Anthony Xu <anthony.xu@intel.com>



---
 Makefile.target                    |   3 -
 default-configs/i386-softmmu.mak   |   1 -
 default-configs/x86_64-softmmu.mak |   1 -
 hw/i386/xen/Makefile.objs          |   2 +-
 hw/i386/xen/trace-events           |   6 +
 hw/i386/xen/xen-mapcache.c         | 459 +++++++++++++++++++++++++++++++++=
++++
 trace-events                       |   5 -
 xen-mapcache.c                     | 459 ---------------------------------=
----
 8 files changed, 466 insertions(+), 470 deletions(-)
 create mode 100644 hw/i386/xen/xen-mapcache.c
 delete mode 100644 xen-mapcache.c

diff --git a/Makefile.target b/Makefile.target
index d5ff0c7..a535980 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -149,9 +149,6 @@ obj-y +=3D dump.o
 obj-y +=3D migration/ram.o migration/savevm.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
-# xen support
-obj-$(CONFIG_XEN_I386) +=3D xen-mapcache.o
-
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y +=3D hw/sparc64/
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmm=
u.mak
index 029e952..d2ab2f6 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -39,7 +39,6 @@ CONFIG_TPM_TIS=3D$(CONFIG_TPM)
 CONFIG_MC146818RTC=3Dy
 CONFIG_PCI_PIIX=3Dy
 CONFIG_WDT_IB700=3Dy
-CONFIG_XEN_I386=3D$(CONFIG_XEN)
 CONFIG_ISA_DEBUG=3Dy
 CONFIG_ISA_TESTDEV=3Dy
 CONFIG_VMPORT=3Dy
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-so=
ftmmu.mak
index d1d7432..9bde2f1 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -39,7 +39,6 @@ CONFIG_TPM_TIS=3D$(CONFIG_TPM)
 CONFIG_MC146818RTC=3Dy
 CONFIG_PCI_PIIX=3Dy
 CONFIG_WDT_IB700=3Dy
-CONFIG_XEN_I386=3D$(CONFIG_XEN)
 CONFIG_ISA_DEBUG=3Dy
 CONFIG_ISA_TESTDEV=3Dy
 CONFIG_VMPORT=3Dy
diff --git a/hw/i386/xen/Makefile.objs b/hw/i386/xen/Makefile.objs
index daf4f53..be9d10c 100644
--- a/hw/i386/xen/Makefile.objs
+++ b/hw/i386/xen/Makefile.objs
@@ -1 +1 @@
-obj-y +=3D xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o
+obj-y +=3D xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o xen-mapcache=
.o
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index f25d622..547438d 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -15,3 +15,9 @@ cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint3=
2_t data_is_ptr, uint64
 cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t s=
ize) "I/O=3D%p pio read reg data=3D%#"PRIx64" port=3D%#"PRIx64" size=3D%d"
 cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t =
size) "I/O=3D%p pio write reg data=3D%#"PRIx64" port=3D%#"PRIx64" size=3D%d=
"
 cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr,=
 uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p cop=
y dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=3D%d =
size=3D%d"
+
+# xen-mapcache.c
+xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
+xen_remap_bucket(uint64_t index) "index %#"PRIx64
+xen_map_cache_return(void* ptr) "%p"
+
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
new file mode 100644
index 0000000..31debdf
--- /dev/null
+++ b/hw/i386/xen/xen-mapcache.c
@@ -0,0 +1,459 @@
+/*
+ * Copyright (C) 2011       Citrix Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+
+#include <sys/resource.h>
+
+#include "hw/xen/xen_backend.h"
+#include "sysemu/blockdev.h"
+#include "qemu/bitmap.h"
+
+#include <xen/hvm/params.h>
+
+#include "sysemu/xen-mapcache.h"
+#include "trace.h"
+
+
+//#define MAPCACHE_DEBUG
+
+#ifdef MAPCACHE_DEBUG
+#  define DPRINTF(fmt, ...) do { \
+    fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
+} while (0)
+#else
+#  define DPRINTF(fmt, ...) do { } while (0)
+#endif
+
+#if HOST_LONG_BITS =3D=3D 32
+#  define MCACHE_BUCKET_SHIFT 16
+#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
+#else
+#  define MCACHE_BUCKET_SHIFT 20
+#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
+#endif
+#define MCACHE_BUCKET_SIZE (1UL << MCACHE_BUCKET_SHIFT)
+
+/* This is the size of the virtual address space reserve to QEMU that will=
 not
+ * be use by MapCache.
+ * From empirical tests I observed that qemu use 75MB more than the
+ * max_mcache_size.
+ */
+#define NON_MCACHE_MEMORY_SIZE (80 * 1024 * 1024)
+
+typedef struct MapCacheEntry {
+    hwaddr paddr_index;
+    uint8_t *vaddr_base;
+    unsigned long *valid_mapping;
+    uint8_t lock;
+    hwaddr size;
+    struct MapCacheEntry *next;
+} MapCacheEntry;
+
+typedef struct MapCacheRev {
+    uint8_t *vaddr_req;
+    hwaddr paddr_index;
+    hwaddr size;
+    QTAILQ_ENTRY(MapCacheRev) next;
+} MapCacheRev;
+
+typedef struct MapCache {
+    MapCacheEntry *entry;
+    unsigned long nr_buckets;
+    QTAILQ_HEAD(map_cache_head, MapCacheRev) locked_entries;
+
+    /* For most cases (>99.9%), the page address is the same. */
+    MapCacheEntry *last_entry;
+    unsigned long max_mcache_size;
+    unsigned int mcache_bucket_shift;
+
+    phys_offset_to_gaddr_t phys_offset_to_gaddr;
+    QemuMutex lock;
+    void *opaque;
+} MapCache;
+
+static MapCache *mapcache;
+
+static inline void mapcache_lock(void)
+{
+    qemu_mutex_lock(&mapcache->lock);
+}
+
+static inline void mapcache_unlock(void)
+{
+    qemu_mutex_unlock(&mapcache->lock);
+}
+
+static inline int test_bits(int nr, int size, const unsigned long *addr)
+{
+    unsigned long res =3D find_next_zero_bit(addr, size + nr, nr);
+    if (res >=3D nr + size)
+        return 1;
+    else
+        return 0;
+}
+
+void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
+{
+    unsigned long size;
+    struct rlimit rlimit_as;
+
+    mapcache =3D g_malloc0(sizeof (MapCache));
+
+    mapcache->phys_offset_to_gaddr =3D f;
+    mapcache->opaque =3D opaque;
+    qemu_mutex_init(&mapcache->lock);
+
+    QTAILQ_INIT(&mapcache->locked_entries);
+
+    if (geteuid() =3D=3D 0) {
+        rlimit_as.rlim_cur =3D RLIM_INFINITY;
+        rlimit_as.rlim_max =3D RLIM_INFINITY;
+        mapcache->max_mcache_size =3D MCACHE_MAX_SIZE;
+    } else {
+        getrlimit(RLIMIT_AS, &rlimit_as);
+        rlimit_as.rlim_cur =3D rlimit_as.rlim_max;
+
+        if (rlimit_as.rlim_max !=3D RLIM_INFINITY) {
+            fprintf(stderr, "Warning: QEMU's maximum size of virtual"
+                    " memory is not infinity.\n");
+        }
+        if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE)=
 {
+            mapcache->max_mcache_size =3D rlimit_as.rlim_max -
+                NON_MCACHE_MEMORY_SIZE;
+        } else {
+            mapcache->max_mcache_size =3D MCACHE_MAX_SIZE;
+        }
+    }
+
+    setrlimit(RLIMIT_AS, &rlimit_as);
+
+    mapcache->nr_buckets =3D
+        (((mapcache->max_mcache_size >> XC_PAGE_SHIFT) +
+          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
+         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
+
+    size =3D mapcache->nr_buckets * sizeof (MapCacheEntry);
+    size =3D (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
+    DPRINTF("%s, nr_buckets =3D %lx size %lu\n", __func__,
+            mapcache->nr_buckets, size);
+    mapcache->entry =3D g_malloc0(size);
+}
+
+static void xen_remap_bucket(MapCacheEntry *entry,
+                             hwaddr size,
+                             hwaddr address_index)
+{
+    uint8_t *vaddr_base;
+    xen_pfn_t *pfns;
+    int *err;
+    unsigned int i;
+    hwaddr nb_pfn =3D size >> XC_PAGE_SHIFT;
+
+    trace_xen_remap_bucket(address_index);
+
+    pfns =3D g_malloc0(nb_pfn * sizeof (xen_pfn_t));
+    err =3D g_malloc0(nb_pfn * sizeof (int));
+
+    if (entry->vaddr_base !=3D NULL) {
+        ram_block_notify_remove(entry->vaddr_base, entry->size);
+        if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
+            perror("unmap fails");
+            exit(-1);
+        }
+    }
+    g_free(entry->valid_mapping);
+    entry->valid_mapping =3D NULL;
+
+    for (i =3D 0; i < nb_pfn; i++) {
+        pfns[i] =3D (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT))=
 + i;
+    }
+
+    vaddr_base =3D xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PRO=
T_WRITE,
+                                      nb_pfn, pfns, err);
+    if (vaddr_base =3D=3D NULL) {
+        perror("xenforeignmemory_map");
+        exit(-1);
+    }
+
+    entry->vaddr_base =3D vaddr_base;
+    entry->paddr_index =3D address_index;
+    entry->size =3D size;
+    entry->valid_mapping =3D (unsigned long *) g_malloc0(sizeof(unsigned l=
ong) *
+            BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
+
+    ram_block_notify_add(entry->vaddr_base, entry->size);
+    bitmap_zero(entry->valid_mapping, nb_pfn);
+    for (i =3D 0; i < nb_pfn; i++) {
+        if (!err[i]) {
+            bitmap_set(entry->valid_mapping, i, 1);
+        }
+    }
+
+    g_free(pfns);
+    g_free(err);
+}
+
+static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
+                                       uint8_t lock)
+{
+    MapCacheEntry *entry, *pentry =3D NULL;
+    hwaddr address_index;
+    hwaddr address_offset;
+    hwaddr cache_size =3D size;
+    hwaddr test_bit_size;
+    bool translated =3D false;
+
+tryagain:
+    address_index  =3D phys_addr >> MCACHE_BUCKET_SHIFT;
+    address_offset =3D phys_addr & (MCACHE_BUCKET_SIZE - 1);
+
+    trace_xen_map_cache(phys_addr);
+
+    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
+    if (size) {
+        test_bit_size =3D size + (phys_addr & (XC_PAGE_SIZE - 1));
+
+        if (test_bit_size % XC_PAGE_SIZE) {
+            test_bit_size +=3D XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZ=
E);
+        }
+    } else {
+        test_bit_size =3D XC_PAGE_SIZE;
+    }
+
+    if (mapcache->last_entry !=3D NULL &&
+        mapcache->last_entry->paddr_index =3D=3D address_index &&
+        !lock && !size &&
+        test_bits(address_offset >> XC_PAGE_SHIFT,
+                  test_bit_size >> XC_PAGE_SHIFT,
+                  mapcache->last_entry->valid_mapping)) {
+        trace_xen_map_cache_return(mapcache->last_entry->vaddr_base + addr=
ess_offset);
+        return mapcache->last_entry->vaddr_base + address_offset;
+    }
+
+    /* size is always a multiple of MCACHE_BUCKET_SIZE */
+    if (size) {
+        cache_size =3D size + address_offset;
+        if (cache_size % MCACHE_BUCKET_SIZE) {
+            cache_size +=3D MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCK=
ET_SIZE);
+        }
+    } else {
+        cache_size =3D MCACHE_BUCKET_SIZE;
+    }
+
+    entry =3D &mapcache->entry[address_index % mapcache->nr_buckets];
+
+    while (entry && entry->lock && entry->vaddr_base &&
+            (entry->paddr_index !=3D address_index || entry->size !=3D cac=
he_size ||
+             !test_bits(address_offset >> XC_PAGE_SHIFT,
+                 test_bit_size >> XC_PAGE_SHIFT,
+                 entry->valid_mapping))) {
+        pentry =3D entry;
+        entry =3D entry->next;
+    }
+    if (!entry) {
+        entry =3D g_malloc0(sizeof (MapCacheEntry));
+        pentry->next =3D entry;
+        xen_remap_bucket(entry, cache_size, address_index);
+    } else if (!entry->lock) {
+        if (!entry->vaddr_base || entry->paddr_index !=3D address_index ||
+                entry->size !=3D cache_size ||
+                !test_bits(address_offset >> XC_PAGE_SHIFT,
+                    test_bit_size >> XC_PAGE_SHIFT,
+                    entry->valid_mapping)) {
+            xen_remap_bucket(entry, cache_size, address_index);
+        }
+    }
+
+    if(!test_bits(address_offset >> XC_PAGE_SHIFT,
+                test_bit_size >> XC_PAGE_SHIFT,
+                entry->valid_mapping)) {
+        mapcache->last_entry =3D NULL;
+        if (!translated && mapcache->phys_offset_to_gaddr) {
+            phys_addr =3D mapcache->phys_offset_to_gaddr(phys_addr, size, =
mapcache->opaque);
+            translated =3D true;
+            goto tryagain;
+        }
+        trace_xen_map_cache_return(NULL);
+        return NULL;
+    }
+
+    mapcache->last_entry =3D entry;
+    if (lock) {
+        MapCacheRev *reventry =3D g_malloc0(sizeof(MapCacheRev));
+        entry->lock++;
+        reventry->vaddr_req =3D mapcache->last_entry->vaddr_base + address=
_offset;
+        reventry->paddr_index =3D mapcache->last_entry->paddr_index;
+        reventry->size =3D entry->size;
+        QTAILQ_INSERT_HEAD(&mapcache->locked_entries, reventry, next);
+    }
+
+    trace_xen_map_cache_return(mapcache->last_entry->vaddr_base + address_=
offset);
+    return mapcache->last_entry->vaddr_base + address_offset;
+}
+
+uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
+                       uint8_t lock)
+{
+    uint8_t *p;
+
+    mapcache_lock();
+    p =3D xen_map_cache_unlocked(phys_addr, size, lock);
+    mapcache_unlock();
+    return p;
+}
+
+ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+{
+    MapCacheEntry *entry =3D NULL;
+    MapCacheRev *reventry;
+    hwaddr paddr_index;
+    hwaddr size;
+    ram_addr_t raddr;
+    int found =3D 0;
+
+    mapcache_lock();
+    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+        if (reventry->vaddr_req =3D=3D ptr) {
+            paddr_index =3D reventry->paddr_index;
+            size =3D reventry->size;
+            found =3D 1;
+            break;
+        }
+    }
+    if (!found) {
+        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
+        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+            DPRINTF("   "TARGET_FMT_plx" -> %p is present\n", reventry->pa=
ddr_index,
+                    reventry->vaddr_req);
+        }
+        abort();
+        return 0;
+    }
+
+    entry =3D &mapcache->entry[paddr_index % mapcache->nr_buckets];
+    while (entry && (entry->paddr_index !=3D paddr_index || entry->size !=
=3D size)) {
+        entry =3D entry->next;
+    }
+    if (!entry) {
+        DPRINTF("Trying to find address %p that is not in the mapcache!\n"=
, ptr);
+        raddr =3D 0;
+    } else {
+        raddr =3D (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
+             ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
+    }
+    mapcache_unlock();
+    return raddr;
+}
+
+static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
+{
+    MapCacheEntry *entry =3D NULL, *pentry =3D NULL;
+    MapCacheRev *reventry;
+    hwaddr paddr_index;
+    hwaddr size;
+    int found =3D 0;
+
+    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+        if (reventry->vaddr_req =3D=3D buffer) {
+            paddr_index =3D reventry->paddr_index;
+            size =3D reventry->size;
+            found =3D 1;
+            break;
+        }
+    }
+    if (!found) {
+        DPRINTF("%s, could not find %p\n", __func__, buffer);
+        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+            DPRINTF("   "TARGET_FMT_plx" -> %p is present\n", reventry->pa=
ddr_index, reventry->vaddr_req);
+        }
+        return;
+    }
+    QTAILQ_REMOVE(&mapcache->locked_entries, reventry, next);
+    g_free(reventry);
+
+    if (mapcache->last_entry !=3D NULL &&
+        mapcache->last_entry->paddr_index =3D=3D paddr_index) {
+        mapcache->last_entry =3D NULL;
+    }
+
+    entry =3D &mapcache->entry[paddr_index % mapcache->nr_buckets];
+    while (entry && (entry->paddr_index !=3D paddr_index || entry->size !=
=3D size)) {
+        pentry =3D entry;
+        entry =3D entry->next;
+    }
+    if (!entry) {
+        DPRINTF("Trying to unmap address %p that is not in the mapcache!\n=
", buffer);
+        return;
+    }
+    entry->lock--;
+    if (entry->lock > 0 || pentry =3D=3D NULL) {
+        return;
+    }
+
+    pentry->next =3D entry->next;
+    ram_block_notify_remove(entry->vaddr_base, entry->size);
+    if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
+        perror("unmap fails");
+        exit(-1);
+    }
+    g_free(entry->valid_mapping);
+    g_free(entry);
+}
+
+void xen_invalidate_map_cache_entry(uint8_t *buffer)
+{
+    mapcache_lock();
+    xen_invalidate_map_cache_entry_unlocked(buffer);
+    mapcache_unlock();
+}
+
+void xen_invalidate_map_cache(void)
+{
+    unsigned long i;
+    MapCacheRev *reventry;
+
+    /* Flush pending AIO before destroying the mapcache */
+    bdrv_drain_all();
+
+    mapcache_lock();
+
+    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+        DPRINTF("There should be no locked mappings at this time, "
+                "but "TARGET_FMT_plx" -> %p is present\n",
+                reventry->paddr_index, reventry->vaddr_req);
+    }
+
+    for (i =3D 0; i < mapcache->nr_buckets; i++) {
+        MapCacheEntry *entry =3D &mapcache->entry[i];
+
+        if (entry->vaddr_base =3D=3D NULL) {
+            continue;
+        }
+        if (entry->lock > 0) {
+            continue;
+        }
+
+        if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
+            perror("unmap fails");
+            exit(-1);
+        }
+
+        entry->paddr_index =3D 0;
+        entry->vaddr_base =3D NULL;
+        entry->size =3D 0;
+        g_free(entry->valid_mapping);
+        entry->valid_mapping =3D NULL;
+    }
+
+    mapcache->last_entry =3D NULL;
+
+    mapcache_unlock();
+}
diff --git a/trace-events b/trace-events
index 4e14487..e582d63 100644
--- a/trace-events
+++ b/trace-events
@@ -48,11 +48,6 @@ spice_vmc_register_interface(void *scd) "spice vmc regis=
tered interface %p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interfac=
e %p"
 spice_vmc_event(int event) "spice vmc event %d"
=20
-# xen-mapcache.c
-xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
-xen_remap_bucket(uint64_t index) "index %#"PRIx64
-xen_map_cache_return(void* ptr) "%p"
-
 # monitor.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d da=
ta=3D%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
diff --git a/xen-mapcache.c b/xen-mapcache.c
deleted file mode 100644
index 1a96d2e..0000000
--- a/xen-mapcache.c
+++ /dev/null
@@ -1,459 +0,0 @@
-/*
- * Copyright (C) 2011       Citrix Ltd.
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-
-#include <sys/resource.h>
-
-#include "hw/xen/xen_backend.h"
-#include "sysemu/blockdev.h"
-#include "qemu/bitmap.h"
-
-#include <xen/hvm/params.h>
-
-#include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
-
-
-//#define MAPCACHE_DEBUG
-
-#ifdef MAPCACHE_DEBUG
-#  define DPRINTF(fmt, ...) do { \
-    fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
-} while (0)
-#else
-#  define DPRINTF(fmt, ...) do { } while (0)
-#endif
-
-#if HOST_LONG_BITS =3D=3D 32
-#  define MCACHE_BUCKET_SHIFT 16
-#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
-#else
-#  define MCACHE_BUCKET_SHIFT 20
-#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
-#endif
-#define MCACHE_BUCKET_SIZE (1UL << MCACHE_BUCKET_SHIFT)
-
-/* This is the size of the virtual address space reserve to QEMU that will=
 not
- * be use by MapCache.
- * From empirical tests I observed that qemu use 75MB more than the
- * max_mcache_size.
- */
-#define NON_MCACHE_MEMORY_SIZE (80 * 1024 * 1024)
-
-typedef struct MapCacheEntry {
-    hwaddr paddr_index;
-    uint8_t *vaddr_base;
-    unsigned long *valid_mapping;
-    uint8_t lock;
-    hwaddr size;
-    struct MapCacheEntry *next;
-} MapCacheEntry;
-
-typedef struct MapCacheRev {
-    uint8_t *vaddr_req;
-    hwaddr paddr_index;
-    hwaddr size;
-    QTAILQ_ENTRY(MapCacheRev) next;
-} MapCacheRev;
-
-typedef struct MapCache {
-    MapCacheEntry *entry;
-    unsigned long nr_buckets;
-    QTAILQ_HEAD(map_cache_head, MapCacheRev) locked_entries;
-
-    /* For most cases (>99.9%), the page address is the same. */
-    MapCacheEntry *last_entry;
-    unsigned long max_mcache_size;
-    unsigned int mcache_bucket_shift;
-
-    phys_offset_to_gaddr_t phys_offset_to_gaddr;
-    QemuMutex lock;
-    void *opaque;
-} MapCache;
-
-static MapCache *mapcache;
-
-static inline void mapcache_lock(void)
-{
-    qemu_mutex_lock(&mapcache->lock);
-}
-
-static inline void mapcache_unlock(void)
-{
-    qemu_mutex_unlock(&mapcache->lock);
-}
-
-static inline int test_bits(int nr, int size, const unsigned long *addr)
-{
-    unsigned long res =3D find_next_zero_bit(addr, size + nr, nr);
-    if (res >=3D nr + size)
-        return 1;
-    else
-        return 0;
-}
-
-void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
-{
-    unsigned long size;
-    struct rlimit rlimit_as;
-
-    mapcache =3D g_malloc0(sizeof (MapCache));
-
-    mapcache->phys_offset_to_gaddr =3D f;
-    mapcache->opaque =3D opaque;
-    qemu_mutex_init(&mapcache->lock);
-
-    QTAILQ_INIT(&mapcache->locked_entries);
-
-    if (geteuid() =3D=3D 0) {
-        rlimit_as.rlim_cur =3D RLIM_INFINITY;
-        rlimit_as.rlim_max =3D RLIM_INFINITY;
-        mapcache->max_mcache_size =3D MCACHE_MAX_SIZE;
-    } else {
-        getrlimit(RLIMIT_AS, &rlimit_as);
-        rlimit_as.rlim_cur =3D rlimit_as.rlim_max;
-
-        if (rlimit_as.rlim_max !=3D RLIM_INFINITY) {
-            fprintf(stderr, "Warning: QEMU's maximum size of virtual"
-                    " memory is not infinity.\n");
-        }
-        if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE)=
 {
-            mapcache->max_mcache_size =3D rlimit_as.rlim_max -
-                NON_MCACHE_MEMORY_SIZE;
-        } else {
-            mapcache->max_mcache_size =3D MCACHE_MAX_SIZE;
-        }
-    }
-
-    setrlimit(RLIMIT_AS, &rlimit_as);
-
-    mapcache->nr_buckets =3D
-        (((mapcache->max_mcache_size >> XC_PAGE_SHIFT) +
-          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
-         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
-
-    size =3D mapcache->nr_buckets * sizeof (MapCacheEntry);
-    size =3D (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
-    DPRINTF("%s, nr_buckets =3D %lx size %lu\n", __func__,
-            mapcache->nr_buckets, size);
-    mapcache->entry =3D g_malloc0(size);
-}
-
-static void xen_remap_bucket(MapCacheEntry *entry,
-                             hwaddr size,
-                             hwaddr address_index)
-{
-    uint8_t *vaddr_base;
-    xen_pfn_t *pfns;
-    int *err;
-    unsigned int i;
-    hwaddr nb_pfn =3D size >> XC_PAGE_SHIFT;
-
-    trace_xen_remap_bucket(address_index);
-
-    pfns =3D g_malloc0(nb_pfn * sizeof (xen_pfn_t));
-    err =3D g_malloc0(nb_pfn * sizeof (int));
-
-    if (entry->vaddr_base !=3D NULL) {
-        ram_block_notify_remove(entry->vaddr_base, entry->size);
-        if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
-            perror("unmap fails");
-            exit(-1);
-        }
-    }
-    g_free(entry->valid_mapping);
-    entry->valid_mapping =3D NULL;
-
-    for (i =3D 0; i < nb_pfn; i++) {
-        pfns[i] =3D (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT))=
 + i;
-    }
-
-    vaddr_base =3D xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PRO=
T_WRITE,
-                                      nb_pfn, pfns, err);
-    if (vaddr_base =3D=3D NULL) {
-        perror("xenforeignmemory_map");
-        exit(-1);
-    }
-
-    entry->vaddr_base =3D vaddr_base;
-    entry->paddr_index =3D address_index;
-    entry->size =3D size;
-    entry->valid_mapping =3D (unsigned long *) g_malloc0(sizeof(unsigned l=
ong) *
-            BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
-
-    ram_block_notify_add(entry->vaddr_base, entry->size);
-    bitmap_zero(entry->valid_mapping, nb_pfn);
-    for (i =3D 0; i < nb_pfn; i++) {
-        if (!err[i]) {
-            bitmap_set(entry->valid_mapping, i, 1);
-        }
-    }
-
-    g_free(pfns);
-    g_free(err);
-}
-
-static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
-                                       uint8_t lock)
-{
-    MapCacheEntry *entry, *pentry =3D NULL;
-    hwaddr address_index;
-    hwaddr address_offset;
-    hwaddr cache_size =3D size;
-    hwaddr test_bit_size;
-    bool translated =3D false;
-
-tryagain:
-    address_index  =3D phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset =3D phys_addr & (MCACHE_BUCKET_SIZE - 1);
-
-    trace_xen_map_cache(phys_addr);
-
-    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
-    if (size) {
-        test_bit_size =3D size + (phys_addr & (XC_PAGE_SIZE - 1));
-
-        if (test_bit_size % XC_PAGE_SIZE) {
-            test_bit_size +=3D XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZ=
E);
-        }
-    } else {
-        test_bit_size =3D XC_PAGE_SIZE;
-    }
-
-    if (mapcache->last_entry !=3D NULL &&
-        mapcache->last_entry->paddr_index =3D=3D address_index &&
-        !lock && !size &&
-        test_bits(address_offset >> XC_PAGE_SHIFT,
-                  test_bit_size >> XC_PAGE_SHIFT,
-                  mapcache->last_entry->valid_mapping)) {
-        trace_xen_map_cache_return(mapcache->last_entry->vaddr_base + addr=
ess_offset);
-        return mapcache->last_entry->vaddr_base + address_offset;
-    }
-
-    /* size is always a multiple of MCACHE_BUCKET_SIZE */
-    if (size) {
-        cache_size =3D size + address_offset;
-        if (cache_size % MCACHE_BUCKET_SIZE) {
-            cache_size +=3D MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCK=
ET_SIZE);
-        }
-    } else {
-        cache_size =3D MCACHE_BUCKET_SIZE;
-    }
-
-    entry =3D &mapcache->entry[address_index % mapcache->nr_buckets];
-
-    while (entry && entry->lock && entry->vaddr_base &&
-            (entry->paddr_index !=3D address_index || entry->size !=3D cac=
he_size ||
-             !test_bits(address_offset >> XC_PAGE_SHIFT,
-                 test_bit_size >> XC_PAGE_SHIFT,
-                 entry->valid_mapping))) {
-        pentry =3D entry;
-        entry =3D entry->next;
-    }
-    if (!entry) {
-        entry =3D g_malloc0(sizeof (MapCacheEntry));
-        pentry->next =3D entry;
-        xen_remap_bucket(entry, cache_size, address_index);
-    } else if (!entry->lock) {
-        if (!entry->vaddr_base || entry->paddr_index !=3D address_index ||
-                entry->size !=3D cache_size ||
-                !test_bits(address_offset >> XC_PAGE_SHIFT,
-                    test_bit_size >> XC_PAGE_SHIFT,
-                    entry->valid_mapping)) {
-            xen_remap_bucket(entry, cache_size, address_index);
-        }
-    }
-
-    if(!test_bits(address_offset >> XC_PAGE_SHIFT,
-                test_bit_size >> XC_PAGE_SHIFT,
-                entry->valid_mapping)) {
-        mapcache->last_entry =3D NULL;
-        if (!translated && mapcache->phys_offset_to_gaddr) {
-            phys_addr =3D mapcache->phys_offset_to_gaddr(phys_addr, size, =
mapcache->opaque);
-            translated =3D true;
-            goto tryagain;
-        }
-        trace_xen_map_cache_return(NULL);
-        return NULL;
-    }
-
-    mapcache->last_entry =3D entry;
-    if (lock) {
-        MapCacheRev *reventry =3D g_malloc0(sizeof(MapCacheRev));
-        entry->lock++;
-        reventry->vaddr_req =3D mapcache->last_entry->vaddr_base + address=
_offset;
-        reventry->paddr_index =3D mapcache->last_entry->paddr_index;
-        reventry->size =3D entry->size;
-        QTAILQ_INSERT_HEAD(&mapcache->locked_entries, reventry, next);
-    }
-
-    trace_xen_map_cache_return(mapcache->last_entry->vaddr_base + address_=
offset);
-    return mapcache->last_entry->vaddr_base + address_offset;
-}
-
-uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock)
-{
-    uint8_t *p;
-
-    mapcache_lock();
-    p =3D xen_map_cache_unlocked(phys_addr, size, lock);
-    mapcache_unlock();
-    return p;
-}
-
-ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
-{
-    MapCacheEntry *entry =3D NULL;
-    MapCacheRev *reventry;
-    hwaddr paddr_index;
-    hwaddr size;
-    ram_addr_t raddr;
-    int found =3D 0;
-
-    mapcache_lock();
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-        if (reventry->vaddr_req =3D=3D ptr) {
-            paddr_index =3D reventry->paddr_index;
-            size =3D reventry->size;
-            found =3D 1;
-            break;
-        }
-    }
-    if (!found) {
-        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            DPRINTF("   "TARGET_FMT_plx" -> %p is present\n", reventry->pa=
ddr_index,
-                    reventry->vaddr_req);
-        }
-        abort();
-        return 0;
-    }
-
-    entry =3D &mapcache->entry[paddr_index % mapcache->nr_buckets];
-    while (entry && (entry->paddr_index !=3D paddr_index || entry->size !=
=3D size)) {
-        entry =3D entry->next;
-    }
-    if (!entry) {
-        DPRINTF("Trying to find address %p that is not in the mapcache!\n"=
, ptr);
-        raddr =3D 0;
-    } else {
-        raddr =3D (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
-             ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
-    }
-    mapcache_unlock();
-    return raddr;
-}
-
-static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
-{
-    MapCacheEntry *entry =3D NULL, *pentry =3D NULL;
-    MapCacheRev *reventry;
-    hwaddr paddr_index;
-    hwaddr size;
-    int found =3D 0;
-
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-        if (reventry->vaddr_req =3D=3D buffer) {
-            paddr_index =3D reventry->paddr_index;
-            size =3D reventry->size;
-            found =3D 1;
-            break;
-        }
-    }
-    if (!found) {
-        DPRINTF("%s, could not find %p\n", __func__, buffer);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            DPRINTF("   "TARGET_FMT_plx" -> %p is present\n", reventry->pa=
ddr_index, reventry->vaddr_req);
-        }
-        return;
-    }
-    QTAILQ_REMOVE(&mapcache->locked_entries, reventry, next);
-    g_free(reventry);
-
-    if (mapcache->last_entry !=3D NULL &&
-        mapcache->last_entry->paddr_index =3D=3D paddr_index) {
-        mapcache->last_entry =3D NULL;
-    }
-
-    entry =3D &mapcache->entry[paddr_index % mapcache->nr_buckets];
-    while (entry && (entry->paddr_index !=3D paddr_index || entry->size !=
=3D size)) {
-        pentry =3D entry;
-        entry =3D entry->next;
-    }
-    if (!entry) {
-        DPRINTF("Trying to unmap address %p that is not in the mapcache!\n=
", buffer);
-        return;
-    }
-    entry->lock--;
-    if (entry->lock > 0 || pentry =3D=3D NULL) {
-        return;
-    }
-
-    pentry->next =3D entry->next;
-    ram_block_notify_remove(entry->vaddr_base, entry->size);
-    if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
-        perror("unmap fails");
-        exit(-1);
-    }
-    g_free(entry->valid_mapping);
-    g_free(entry);
-}
-
-void xen_invalidate_map_cache_entry(uint8_t *buffer)
-{
-    mapcache_lock();
-    xen_invalidate_map_cache_entry_unlocked(buffer);
-    mapcache_unlock();
-}
-
-void xen_invalidate_map_cache(void)
-{
-    unsigned long i;
-    MapCacheRev *reventry;
-
-    /* Flush pending AIO before destroying the mapcache */
-    bdrv_drain_all();
-
-    mapcache_lock();
-
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-        DPRINTF("There should be no locked mappings at this time, "
-                "but "TARGET_FMT_plx" -> %p is present\n",
-                reventry->paddr_index, reventry->vaddr_req);
-    }
-
-    for (i =3D 0; i < mapcache->nr_buckets; i++) {
-        MapCacheEntry *entry =3D &mapcache->entry[i];
-
-        if (entry->vaddr_base =3D=3D NULL) {
-            continue;
-        }
-        if (entry->lock > 0) {
-            continue;
-        }
-
-        if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
-            perror("unmap fails");
-            exit(-1);
-        }
-
-        entry->paddr_index =3D 0;
-        entry->vaddr_base =3D NULL;
-        entry->size =3D 0;
-        g_free(entry->valid_mapping);
-        entry->valid_mapping =3D NULL;
-    }
-
-    mapcache->last_entry =3D NULL;
-
-    mapcache_unlock();
-}
--
