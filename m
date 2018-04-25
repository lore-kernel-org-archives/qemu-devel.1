Received: from eggs.gnu.org ([2001:4830:134:3::10]:60397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBGQ5-0006Va-CS
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBGQ3-0001za-6d
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:08:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Apr 2018 11:08:42 +0200
Message-Id: <1524647323-6449-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1524647323-6449-1-git-send-email-thuth@redhat.com>
References: <1524647323-6449-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/3] pc-bios/s390-ccw/net: Use diag308 to
 reset machine before jumping to the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

The netboot firmware so far simply jumped directly into the OS kernel
after the download has been completed. This, however, bears the risk
that the virtio-net device still might be active in the background and
incoming packets are still placed into the buffers - which could destroy
memory of the now-running Linux kernel in case it did not take over the
device fast enough. Also the SCLP console is not put into a well-defined
state here. We should hand over the system in a clean state when jumping
into the kernel, so let's use the same mechanism as it's done in the
main s390-ccw firmware and reset the machine with diag308 into a clean
state before jumping into the OS kernel code. To be able to share the
code with the main s390-ccw firmware, the related functions are now
extracted from bootmap.c into a new file called jump2ipl.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile    |  4 ++-
 pc-bios/s390-ccw/bootmap.c   | 63 +---------------------------------
 pc-bios/s390-ccw/bootmap.h   |  4 ---
 pc-bios/s390-ccw/jump2ipl.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/netboot.mak |  3 +-
 pc-bios/s390-ccw/netmain.c   | 11 +++++-
 pc-bios/s390-ccw/s390-ccw.h  |  4 +++
 7 files changed, 101 insertions(+), 69 deletions(-)
 create mode 100644 pc-bios/s390-ccw/jump2ipl.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 1712c2d..439e3cc 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,9 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o menu.o
+OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
+	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
+
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 9287b7a..7e63e6b 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -29,14 +29,6 @@
 /* Scratch space */
 static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_SIZE)));
 
-typedef struct ResetInfo {
-    uint32_t ipl_mask;
-    uint32_t ipl_addr;
-    uint32_t ipl_continue;
-} ResetInfo;
-
-static ResetInfo save;
-
 const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
                                   "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
 
@@ -57,53 +49,6 @@ static inline bool is_iso_vd_valid(IsoVolDesc *vd)
            vd->type <= VOL_DESC_TYPE_PARTITION;
 }
 
-static void jump_to_IPL_2(void)
-{
-    ResetInfo *current = 0;
-
-    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
-    *current = save;
-    ipl(); /* should not return */
-}
-
-static void jump_to_IPL_code(uint64_t address)
-{
-    /* store the subsystem information _after_ the bootmap was loaded */
-    write_subsystem_identification();
-
-    /* prevent unknown IPL types in the guest */
-    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
-        iplb.pbt = S390_IPL_TYPE_CCW;
-        set_iplb(&iplb);
-    }
-
-    /*
-     * The IPL PSW is at address 0. We also must not overwrite the
-     * content of non-BIOS memory after we loaded the guest, so we
-     * save the original content and restore it in jump_to_IPL_2.
-     */
-    ResetInfo *current = 0;
-
-    save = *current;
-    current->ipl_addr = (uint32_t) (uint64_t) &jump_to_IPL_2;
-    current->ipl_continue = address & 0x7fffffff;
-
-    debug_print_int("set IPL addr to", current->ipl_continue);
-
-    /* Ensure the guest output starts fresh */
-    sclp_print("\n");
-
-    /*
-     * HACK ALERT.
-     * We use the load normal reset to keep r15 unchanged. jump_to_IPL_2
-     * can then use r15 as its stack pointer.
-     */
-    asm volatile("lghi 1,1\n\t"
-                 "diag 1,1,0x308\n\t"
-                 : : : "1", "memory");
-    panic("\n! IPL returns !\n");
-}
-
 /***********************************************************************
  * IPL an ECKD DASD (CDL or LDL/CMS format)
  */
@@ -727,13 +672,7 @@ static void load_iso_bc_entry(IsoBcSection *load)
                         (void *)((uint64_t)bswap16(s.load_segment)),
                         blks_to_load);
 
-    /* Trying to get PSW at zero address */
-    if (*((uint64_t *)0) & IPL_PSW_MASK) {
-        jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
-    }
-
-    /* Try default linux start address */
-    jump_to_IPL_code(KERN_IMAGE_START);
+    jump_to_low_kernel();
 }
 
 static uint32_t find_iso_bc(void)
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 07eb600..bef81ff 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -355,10 +355,6 @@ static inline uint32_t iso_733_to_u32(uint64_t x)
 #define ISO_SECTOR_SIZE 2048
 /* El Torito specifies boot image size in 512 byte blocks */
 #define ET_SECTOR_SHIFT 2
-#define KERN_IMAGE_START 0x010000UL
-#define PSW_MASK_64 0x0000000100000000ULL
-#define PSW_MASK_32 0x0000000080000000ULL
-#define IPL_PSW_MASK (PSW_MASK_32 | PSW_MASK_64)
 
 #define ISO_PRIMARY_VD_SECTOR 16
 
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
new file mode 100644
index 0000000..21b25d8
--- /dev/null
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -0,0 +1,81 @@
+/*
+ * QEMU s390-ccw firmware - jump to IPL code
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+
+#define KERN_IMAGE_START 0x010000UL
+#define PSW_MASK_64 0x0000000100000000ULL
+#define PSW_MASK_32 0x0000000080000000ULL
+#define IPL_PSW_MASK (PSW_MASK_32 | PSW_MASK_64)
+
+typedef struct ResetInfo {
+    uint32_t ipl_mask;
+    uint32_t ipl_addr;
+    uint32_t ipl_continue;
+} ResetInfo;
+
+static ResetInfo save;
+
+static void jump_to_IPL_2(void)
+{
+    ResetInfo *current = 0;
+
+    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
+    *current = save;
+    ipl(); /* should not return */
+}
+
+void jump_to_IPL_code(uint64_t address)
+{
+    /* store the subsystem information _after_ the bootmap was loaded */
+    write_subsystem_identification();
+
+    /* prevent unknown IPL types in the guest */
+    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
+        iplb.pbt = S390_IPL_TYPE_CCW;
+        set_iplb(&iplb);
+    }
+
+    /*
+     * The IPL PSW is at address 0. We also must not overwrite the
+     * content of non-BIOS memory after we loaded the guest, so we
+     * save the original content and restore it in jump_to_IPL_2.
+     */
+    ResetInfo *current = 0;
+
+    save = *current;
+    current->ipl_addr = (uint32_t) (uint64_t) &jump_to_IPL_2;
+    current->ipl_continue = address & 0x7fffffff;
+
+    debug_print_int("set IPL addr to", current->ipl_continue);
+
+    /* Ensure the guest output starts fresh */
+    sclp_print("\n");
+
+    /*
+     * HACK ALERT.
+     * We use the load normal reset to keep r15 unchanged. jump_to_IPL_2
+     * can then use r15 as its stack pointer.
+     */
+    asm volatile("lghi 1,1\n\t"
+                 "diag 1,1,0x308\n\t"
+                 : : : "1", "memory");
+    panic("\n! IPL returns !\n");
+}
+
+void jump_to_low_kernel(void)
+{
+    /* Trying to get PSW at zero address */
+    if (*((uint64_t *)0) & IPL_PSW_MASK) {
+        jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
+    }
+
+    /* Try default linux start address */
+    jump_to_IPL_code(KERN_IMAGE_START);
+}
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index a25d238..4f64128 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,7 +1,8 @@
 
 SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-NETOBJS := start.o sclp.o virtio.o virtio-net.o netmain.o libnet.a libc.a
+NETOBJS := start.o sclp.o virtio.o virtio-net.o jump2ipl.o netmain.o \
+	   libnet.a libc.a
 
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 8fa9e6c..5f28ea0 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -283,6 +283,15 @@ void panic(const char *string)
     }
 }
 
+void write_subsystem_identification(void)
+{
+    uint32_t *schid = (uint32_t *) 184;
+    uint32_t *zeroes = (uint32_t *) 188;
+
+    *schid = 0;         /* We must not set this for virtio-net */
+    *zeroes = 0;
+}
+
 static bool find_net_dev(Schib *schib, int dev_no)
 {
     int i, r;
@@ -365,7 +374,7 @@ void main(void)
 
     if (rc > 0) {
         sclp_print("Network loading done, starting kernel...\n");
-        asm volatile (" lpsw 0(%0) " : : "r"(0) : "memory");
+        jump_to_low_kernel();
     }
 
     panic("Failed to load OS from network\n");
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index fd18da2..d88e637 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -87,6 +87,10 @@ ulong get_second(void);
 /* bootmap.c */
 void zipl_load(void);
 
+/* jump2ipl.c */
+void jump_to_IPL_code(uint64_t address);
+void jump_to_low_kernel(void);
+
 /* menu.c */
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
 int menu_get_zipl_boot_index(const char *menu_data);
-- 
1.8.3.1
