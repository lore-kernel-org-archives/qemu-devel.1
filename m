Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7ONr-0006fa-K4
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7ONo-0006IT-T3
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1g7ONo-0006I9-LJ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id 185-v6so2997808wmt.2
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 10:22:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  2 Oct 2018 19:22:45 +0200
Message-Id: <1538500966-5506-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
References: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/80] change get_image_size return type to
 int64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Previously, if the size of initrd >=2G, qemu exits with error:
root@haswell-OptiPlex-9020:/home/lizj# /home/lizhijian/lkp/qemu-colo/x86_64-softmmu/qemu-system-x86_64 -kernel ./vmlinuz-4.16.0-rc4 -initrd large.cgz -nographic
qemu: error reading initrd large.cgz: No such file or directory
root@haswell-OptiPlex-9020:/home/lizj# du -sh large.cgz
2.5G	large.cgz

this patch changes the caller side that use this function to calculate
size of initrd file as well.

v2: update error message and int64_t printing format

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-Id: <1536833233-14121-1-git-send-email-lizhijian@cn.fujitsu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/alpha/dp264.c        | 3 ++-
 hw/core/loader.c        | 5 +++--
 hw/hppa/machine.c       | 2 +-
 hw/i386/pc.c            | 7 ++++++-
 hw/mips/mips_fulong2e.c | 6 +++---
 hw/mips/mips_malta.c    | 6 +++---
 hw/mips/mips_mipssim.c  | 3 +--
 hw/mips/mips_r4k.c      | 6 +++---
 hw/moxie/moxiesim.c     | 2 +-
 include/hw/loader.h     | 2 +-
 10 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 80b987f..dd62f2a 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -150,7 +150,8 @@ static void clipper_init(MachineState *machine)
         }
 
         if (initrd_filename) {
-            long initrd_base, initrd_size;
+            long initrd_base;
+            int64_t initrd_size;
 
             initrd_size = get_image_size(initrd_filename);
             if (initrd_size < 0) {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 390987a..aa0b3fc 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -61,9 +61,10 @@
 static int roms_loaded;
 
 /* return the size or -1 if error */
-int get_image_size(const char *filename)
+int64_t get_image_size(const char *filename)
 {
-    int fd, size;
+    int fd;
+    int64_t size;
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0)
         return -1;
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 0fb8fb8..ac6dd7f 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -191,7 +191,7 @@ static void machine_hppa_init(MachineState *machine)
 
         if (initrd_filename) {
             ram_addr_t initrd_base;
-            long initrd_size;
+            int64_t initrd_size;
 
             initrd_size = get_image_size(initrd_filename);
             if (initrd_size < 0) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0314845..cd5029c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -838,7 +838,8 @@ static void load_linux(PCMachineState *pcms,
                        FWCfgState *fw_cfg)
 {
     uint16_t protocol;
-    int setup_size, kernel_size, initrd_size = 0, cmdline_size;
+    int setup_size, kernel_size, cmdline_size;
+    int64_t initrd_size = 0;
     int dtb_size, setup_data_offset;
     uint32_t initrd_max;
     uint8_t header[8192], *setup, *kernel, *initrd_data;
@@ -974,6 +975,10 @@ static void load_linux(PCMachineState *pcms,
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                     initrd_filename, strerror(errno));
             exit(1);
+        } else if (initrd_size >= initrd_max) {
+            fprintf(stderr, "qemu: initrd is too large, cannot support."
+                    "(max: %"PRIu32", need %"PRId64")\n", initrd_max, initrd_size);
+            exit(1);
         }
 
         initrd_addr = (initrd_max-initrd_size) & ~4095;
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index c1694c8..2fbba32 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -104,9 +104,9 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
 
 static int64_t load_kernel (CPUMIPSState *env)
 {
-    int64_t kernel_entry, kernel_low, kernel_high;
+    int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
     int index = 0;
-    long kernel_size, initrd_size;
+    long kernel_size;
     ram_addr_t initrd_offset;
     uint32_t *prom_buf;
     long prom_size;
@@ -150,7 +150,7 @@ static int64_t load_kernel (CPUMIPSState *env)
 
     prom_set(prom_buf, index++, "%s", loaderparams.kernel_filename);
     if (initrd_size > 0) {
-        prom_set(prom_buf, index++, "rd_start=0x%" PRIx64 " rd_size=%li %s",
+        prom_set(prom_buf, index++, "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
                  cpu_mips_phys_to_kseg0(NULL, initrd_offset), initrd_size,
                  loaderparams.kernel_cmdline);
     } else {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 40041d5..29b90ba 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -995,8 +995,8 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
 /* Kernel */
 static int64_t load_kernel (void)
 {
-    int64_t kernel_entry, kernel_high;
-    long kernel_size, initrd_size;
+    int64_t kernel_entry, kernel_high, initrd_size;
+    long kernel_size;
     ram_addr_t initrd_offset;
     int big_endian;
     uint32_t *prom_buf;
@@ -1070,7 +1070,7 @@ static int64_t load_kernel (void)
 
     prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filename);
     if (initrd_size > 0) {
-        prom_set(prom_buf, prom_index++, "rd_start=0x%" PRIx64 " rd_size=%li %s",
+        prom_set(prom_buf, prom_index++, "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
                  xlate_to_kseg0(NULL, initrd_offset), initrd_size,
                  loaderparams.kernel_cmdline);
     } else {
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 241faa1..f665752 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -58,9 +58,8 @@ typedef struct ResetData {
 
 static int64_t load_kernel(void)
 {
-    int64_t entry, kernel_high;
+    int64_t entry, kernel_high, initrd_size;
     long kernel_size;
-    long initrd_size;
     ram_addr_t initrd_offset;
     int big_endian;
 
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index d5725d0..3e852e9 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -81,8 +81,8 @@ typedef struct ResetData {
 static int64_t load_kernel(void)
 {
     const size_t params_size = 264;
-    int64_t entry, kernel_high;
-    long kernel_size, initrd_size;
+    int64_t entry, kernel_high, initrd_size;
+    long kernel_size;
     ram_addr_t initrd_offset;
     uint32_t *params_buf;
     int big_endian;
@@ -136,7 +136,7 @@ static int64_t load_kernel(void)
     params_buf[1] = tswap32(0x12345678);
 
     if (initrd_size > 0) {
-        snprintf((char *)params_buf + 8, 256, "rd_start=0x%" PRIx64 " rd_size=%li %s",
+        snprintf((char *)params_buf + 8, 256, "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
                  cpu_mips_phys_to_kseg0(NULL, initrd_offset),
                  initrd_size, loaderparams.kernel_cmdline);
     } else {
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index d41247d..4b0ce09 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -54,8 +54,8 @@ typedef struct {
 static void load_kernel(MoxieCPU *cpu, LoaderParams *loader_params)
 {
     uint64_t entry, kernel_low, kernel_high;
+    int64_t initrd_size;
     long kernel_size;
-    long initrd_size;
     ram_addr_t initrd_offset;
 
     kernel_size = load_elf(loader_params->kernel_filename,  NULL, NULL,
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 3c11297..67a0af8 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -10,7 +10,7 @@
  * Returns the size of the image file on success, -1 otherwise.
  * On error, errno is also set as appropriate.
  */
-int get_image_size(const char *filename);
+int64_t get_image_size(const char *filename);
 int load_image(const char *filename, uint8_t *addr); /* deprecated */
 ssize_t load_image_size(const char *filename, void *addr, size_t size);
 
-- 
1.8.3.1
