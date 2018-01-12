Received: from eggs.gnu.org ([2001:4830:134:3::10]:42168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eZwH5-00028R-Kg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eZwH2-0000it-DL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:09:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:7899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eZwH2-0000eh-16
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:09:20 -0500
From: Yu Ning <yu.ning@linux.intel.com>
Date: Fri, 12 Jan 2018 18:22:35 +0800
Message-Id: <1515752555-12784-1-git-send-email-yu.ning@linux.intel.com>
Subject: [Qemu-devel] [PATCH] hax: Support guest RAM sizes of 4GB or more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yu Ning <yu.ning@linux.intel.com>, Yu Ning <yu.ning@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Yu Ning <yu.ning@intel.com>

Since HAX_VM_IOCTL_ALLOC_RAM takes a 32-bit size, it cannot handle
RAM blocks of 4GB or larger, which is why HAXM can only run guests
with less than 4GB of RAM. Solve this problem by utilizing the new
HAXM API, HAX_VM_IOCTL_ADD_RAMBLOCK, which takes a 64-bit size, to
register RAM blocks with the HAXM kernel module. The new API is
first added in HAXM 7.0.0, and its availablility and be confirmed
by the presence of the HAX_CAP_64BIT_RAMBLOCK capability flag.

When the guest RAM size reaches 7GB, QEMU will ask HAXM to set up a
memory mapping that covers a 4GB region, which will fail, because
HAX_VM_IOCTL_SET_RAM also takes a 32-bit size. Work around this
limitation by splitting the large mapping into small ones and
calling HAX_VM_IOCTL_SET_RAM multiple times.

Bug: https://bugs.launchpad.net/qemu/+bug/1735576

Signed-off-by: Yu Ning <yu.ning@intel.com>
---
 include/sysemu/hax.h        |  2 +-
 target/i386/hax-all.c       |  2 ++
 target/i386/hax-darwin.c    | 27 +++++++++++++++++++++------
 target/i386/hax-darwin.h    |  1 +
 target/i386/hax-i386.h      |  1 +
 target/i386/hax-interface.h |  8 ++++++++
 target/i386/hax-mem.c       | 34 ++++++++++++++++++++++++++--------
 target/i386/hax-windows.c   | 38 +++++++++++++++++++++++++++-----------
 target/i386/hax-windows.h   |  2 ++
 9 files changed, 89 insertions(+), 26 deletions(-)

diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index f252399..1f6c461 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -27,7 +27,7 @@
 int hax_sync_vcpus(void);
 int hax_init_vcpu(CPUState *cpu);
 int hax_smp_cpu_exec(CPUState *cpu);
-int hax_populate_ram(uint64_t va, uint32_t size);
+int hax_populate_ram(uint64_t va, uint64_t size);
 
 void hax_cpu_synchronize_state(CPUState *cpu);
 void hax_cpu_synchronize_post_reset(CPUState *cpu);
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950..57921e7 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -104,6 +104,8 @@ static int hax_get_capability(struct hax_state *hax)
         return -ENOTSUP;
     }
 
+    hax->supports_64bit_ramblock = !!(cap->winfo & HAX_CAP_64BIT_RAMBLOCK);
+
     if (cap->wstatus & HAX_CAP_MEMQUOTA) {
         if (cap->mem_quota < hax->mem_quota) {
             fprintf(stderr, "The VM memory needed exceeds the driver limit.\n");
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-darwin.c
index ee94174..acdde47 100644
--- a/target/i386/hax-darwin.c
+++ b/target/i386/hax-darwin.c
@@ -28,21 +28,36 @@ hax_fd hax_mod_open(void)
     return fd;
 }
 
-int hax_populate_ram(uint64_t va, uint32_t size)
+int hax_populate_ram(uint64_t va, uint64_t size)
 {
     int ret;
-    struct hax_alloc_ram_info info;
 
     if (!hax_global.vm || !hax_global.vm->fd) {
         fprintf(stderr, "Allocate memory before vm create?\n");
         return -EINVAL;
     }
 
-    info.size = size;
-    info.va = va;
-    ret = ioctl(hax_global.vm->fd, HAX_VM_IOCTL_ALLOC_RAM, &info);
+    if (hax_global.supports_64bit_ramblock) {
+        struct hax_ramblock_info ramblock = {
+            .start_va = va,
+            .size = size,
+            .reserved = 0
+        };
+
+        ret = ioctl(hax_global.vm->fd, HAX_VM_IOCTL_ADD_RAMBLOCK, &ramblock);
+    } else {
+        struct hax_alloc_ram_info info = {
+            .size = (uint32_t)size,
+            .pad = 0,
+            .va = va
+        };
+
+        ret = ioctl(hax_global.vm->fd, HAX_VM_IOCTL_ALLOC_RAM, &info);
+    }
     if (ret < 0) {
-        fprintf(stderr, "Failed to allocate %x memory\n", size);
+        fprintf(stderr, "Failed to register RAM block: ret=%d, va=0x%" PRIx64
+                ", size=0x%" PRIx64 ", method=%s\n", ret, va, size,
+                hax_global.supports_64bit_ramblock ? "new" : "legacy");
         return ret;
     }
     return 0;
diff --git a/target/i386/hax-darwin.h b/target/i386/hax-darwin.h
index fb8e25a..51af0e8 100644
--- a/target/i386/hax-darwin.h
+++ b/target/i386/hax-darwin.h
@@ -44,6 +44,7 @@ static inline void hax_close_fd(hax_fd fd)
 #define HAX_VM_IOCTL_SET_RAM _IOWR(0, 0x82, struct hax_set_ram_info)
 #define HAX_VM_IOCTL_VCPU_DESTROY _IOW(0, 0x83, uint32_t)
 #define HAX_VM_IOCTL_NOTIFY_QEMU_VERSION _IOW(0, 0x84, struct hax_qemu_version)
+#define HAX_VM_IOCTL_ADD_RAMBLOCK _IOW(0, 0x85, struct hax_ramblock_info)
 
 #define HAX_VCPU_IOCTL_RUN  _IO(0, 0xc0)
 #define HAX_VCPU_IOCTL_SET_MSRS _IOWR(0, 0xc1, struct hax_msr_data)
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 8ffe91f..6abc156 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -37,6 +37,7 @@ struct hax_state {
     uint32_t version;
     struct hax_vm *vm;
     uint64_t mem_quota;
+    bool supports_64bit_ramblock;
 };
 
 #define HAX_MAX_VCPU 0x10
diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
index d141308..93d5fcb 100644
--- a/target/i386/hax-interface.h
+++ b/target/i386/hax-interface.h
@@ -308,6 +308,13 @@ struct hax_alloc_ram_info {
     uint32_t pad;
     uint64_t va;
 } __attribute__ ((__packed__));
+
+struct hax_ramblock_info {
+    uint64_t start_va;
+    uint64_t size;
+    uint64_t reserved;
+} __attribute__ ((__packed__));
+
 #define HAX_RAM_INFO_ROM     0x01 /* Read-Only */
 #define HAX_RAM_INFO_INVALID 0x80 /* Unmapped, usually used for MMIO */
 struct hax_set_ram_info {
@@ -327,6 +334,7 @@ struct hax_set_ram_info {
 
 #define HAX_CAP_MEMQUOTA           0x2
 #define HAX_CAP_UG                 0x4
+#define HAX_CAP_64BIT_RAMBLOCK     0x8
 
 struct hax_capabilityinfo {
     /* bit 0: 1 - working
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 27a0d21..f46e855 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -174,6 +174,7 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
     ram_addr_t size = int128_get64(section->size);
     unsigned int delta;
     uint64_t host_va;
+    uint32_t max_mapping_size;
 
     /* We only care about RAM and ROM regions */
     if (!memory_region_is_ram(mr)) {
@@ -206,10 +207,23 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
         flags |= HAX_RAM_INFO_ROM;
     }
 
-    /* the kernel module interface uses 32-bit sizes (but we could split...) */
-    g_assert(size <= UINT32_MAX);
-
-    hax_update_mapping(start_pa, size, host_va, flags);
+    /*
+     * The kernel module interface uses 32-bit sizes:
+     * https://github.com/intel/haxm/blob/master/API.md#hax_vm_ioctl_set_ram
+     *
+     * If the mapping size is longer than 32 bits, we can't process it in one
+     * call into the kernel. Instead, we split the mapping into smaller ones,
+     * and call hax_update_mapping() on each.
+     */
+    max_mapping_size = UINT32_MAX & qemu_real_host_page_mask;
+    while (size > max_mapping_size) {
+        hax_update_mapping(start_pa, max_mapping_size, host_va, flags);
+        start_pa += max_mapping_size;
+        size -= max_mapping_size;
+        host_va += max_mapping_size;
+    }
+    /* Now size <= max_mapping_size */
+    hax_update_mapping(start_pa, (uint32_t)size, host_va, flags);
 }
 
 static void hax_region_add(MemoryListener *listener,
@@ -283,12 +297,16 @@ static MemoryListener hax_memory_listener = {
 static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
 {
     /*
-     * In HAX, QEMU allocates the virtual address, and HAX kernel
-     * populates the memory with physical memory. Currently we have no
-     * paging, so user should make sure enough free memory in advance.
+     * We must register each RAM block with the HAXM kernel module, or
+     * hax_set_ram() will fail for any mapping into the RAM block:
+     * https://github.com/intel/haxm/blob/master/API.md#hax_vm_ioctl_alloc_ram
+     *
+     * Old versions of the HAXM kernel module (< 6.2.0) used to preallocate all
+     * host physical pages for the RAM block as part of this registration
+     * process, hence the name hax_populate_ram().
      */
     if (hax_populate_ram((uint64_t)(uintptr_t)host, size) < 0) {
-        fprintf(stderr, "HAX failed to populate RAM");
+        fprintf(stderr, "HAX failed to populate RAM\n");
         abort();
     }
 }
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 15a180b..b1ac737 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -58,10 +58,9 @@ static int hax_open_device(hax_fd *fd)
     return fd;
 }
 
-int hax_populate_ram(uint64_t va, uint32_t size)
+int hax_populate_ram(uint64_t va, uint64_t size)
 {
     int ret;
-    struct hax_alloc_ram_info info;
     HANDLE hDeviceVM;
     DWORD dSize = 0;
 
@@ -70,18 +69,35 @@ int hax_populate_ram(uint64_t va, uint32_t size)
         return -EINVAL;
     }
 
-    info.size = size;
-    info.va = va;
-
     hDeviceVM = hax_global.vm->fd;
-
-    ret = DeviceIoControl(hDeviceVM,
-                          HAX_VM_IOCTL_ALLOC_RAM,
-                          &info, sizeof(info), NULL, 0, &dSize,
-                          (LPOVERLAPPED) NULL);
+    if (hax_global.supports_64bit_ramblock) {
+        struct hax_ramblock_info ramblock = {
+            .start_va = va,
+            .size = size,
+            .reserved = 0
+        };
+
+        ret = DeviceIoControl(hDeviceVM,
+                              HAX_VM_IOCTL_ADD_RAMBLOCK,
+                              &ramblock, sizeof(ramblock), NULL, 0, &dSize,
+                              (LPOVERLAPPED) NULL);
+    } else {
+        struct hax_alloc_ram_info info = {
+            .size = (uint32_t) size,
+            .pad = 0,
+            .va = va
+        };
+
+        ret = DeviceIoControl(hDeviceVM,
+                              HAX_VM_IOCTL_ALLOC_RAM,
+                              &info, sizeof(info), NULL, 0, &dSize,
+                              (LPOVERLAPPED) NULL);
+    }
 
     if (!ret) {
-        fprintf(stderr, "Failed to allocate %x memory\n", size);
+        fprintf(stderr, "Failed to register RAM block: va=0x%" PRIx64
+                ", size=0x%" PRIx64 ", method=%s\n", va, size,
+                hax_global.supports_64bit_ramblock ? "new" : "legacy");
         return ret;
     }
 
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 004f867..8491417 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -59,6 +59,8 @@ static inline int hax_invalid_fd(hax_fd fd)
                                             METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define HAX_VM_IOCTL_VCPU_DESTROY  CTL_CODE(HAX_DEVICE_TYPE, 0x905, \
                                             METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VM_IOCTL_ADD_RAMBLOCK  CTL_CODE(HAX_DEVICE_TYPE, 0x913, \
+                                            METHOD_BUFFERED, FILE_ANY_ACCESS)
 
 #define HAX_VCPU_IOCTL_RUN      CTL_CODE(HAX_DEVICE_TYPE, 0x906, \
                                          METHOD_BUFFERED, FILE_ANY_ACCESS)
-- 
2.7.4
