Received: from eggs.gnu.org ([2001:4830:134:3::10]:48875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl1-00021t-BB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLky-0008Rm-5e
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:11 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:48 +0200
Message-Id: <20180611121655.19616-5-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 04/11] hostmem: drop error variable from
 host_memory_backend_get_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Unused, so let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem.c       | 3 +--
 hw/mem/nvdimm.c          | 4 ++--
 hw/mem/pc-dimm.c         | 4 ++--
 hw/misc/ivshmem.c        | 3 +--
 include/sysemu/hostmem.h | 3 +--
 numa.c                   | 3 +--
 6 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 3627e61584..4908946cd3 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -247,8 +247,7 @@ bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
     return memory_region_size(&backend->mr) != 0;
 }
 
-MemoryRegion *
-host_memory_backend_get_memory(HostMemoryBackend *backend, Error **errp)
+MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend)
 {
     return host_memory_backend_mr_inited(backend) ? &backend->mr : NULL;
 }
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index f974accbdd..df9716231f 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -105,7 +105,7 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 
 static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
 {
-    MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem, errp);
+    MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem);
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
     uint64_t align, pmem_size, size = memory_region_size(mr);
 
@@ -161,7 +161,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
 
     memcpy(nvdimm->label_data + offset, buf, size);
 
-    mr = host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    mr = host_memory_backend_get_memory(dimm->hostmem);
     backend_offset = memory_region_size(mr) - nvdimm->label_size + offset;
     memory_region_set_dirty(mr, backend_offset, size);
 }
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 62b34a992e..86fbcf2d0c 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -224,12 +224,12 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
         return NULL;
     }
 
-    return host_memory_backend_get_memory(dimm->hostmem, errp);
+    return host_memory_backend_get_memory(dimm->hostmem);
 }
 
 static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
 {
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    return host_memory_backend_get_memory(dimm->hostmem);
 }
 
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 16f03701b7..ee01c5e66b 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -909,8 +909,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     if (s->hostmem != NULL) {
         IVSHMEM_DPRINTF("using hostmem\n");
 
-        s->ivshmem_bar2 = host_memory_backend_get_memory(s->hostmem,
-                                                         &error_abort);
+        s->ivshmem_bar2 = host_memory_backend_get_memory(s->hostmem);
     } else {
         Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
         assert(chr);
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 5beb0ef8ab..6e6bd2c1cb 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -62,8 +62,7 @@ struct HostMemoryBackend {
 };
 
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
-MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend,
-                                             Error **errp);
+MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend);
 
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mapped);
 bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
diff --git a/numa.c b/numa.c
index 33572bfa74..94f758c757 100644
--- a/numa.c
+++ b/numa.c
@@ -523,8 +523,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
         if (!backend) {
             continue;
         }
-        MemoryRegion *seg = host_memory_backend_get_memory(backend,
-                                                           &error_fatal);
+        MemoryRegion *seg = host_memory_backend_get_memory(backend);
 
         if (memory_region_is_mapped(seg)) {
             char *path = object_get_canonical_path_component(OBJECT(backend));
-- 
2.17.1
