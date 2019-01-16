Received: from eggs.gnu.org ([209.51.188.92]:39640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjpKL-0002LU-AR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjpKI-00009Y-Df
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:50:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gjpKI-00008g-5G
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:50:06 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 16 Jan 2019 18:49:38 +0100
Message-Id: <20190116174941.342900-3-sgarzare@redhat.com>
In-Reply-To: <20190116174941.342900-1-sgarzare@redhat.com>
References: <20190116174941.342900-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/5] linuxboot_dma: move common functions in
 a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Eric Blake <eblake@redhat.com>

In order to allow other option roms to use these common
useful functions and definitions, this patch put them
in two new C header files called optrom.h and
optrom_fw_cfg.h. We also add useful out*() in*()
functions for different size, and new fw_cfg functions
to use when DMA feature is not available.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 pc-bios/optionrom/linuxboot_dma.c | 100 +++++----------------------
 pc-bios/optionrom/optrom.h        | 110 ++++++++++++++++++++++++++++++
 pc-bios/optionrom/optrom_fw_cfg.h |  92 +++++++++++++++++++++++++
 3 files changed, 218 insertions(+), 84 deletions(-)
 create mode 100644 pc-bios/optionrom/optrom.h
 create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h

diff --git a/pc-bios/optionrom/linuxboot_dma.c b/pc-bios/optionrom/linuxb=
oot_dma.c
index f728dc839f..bf6ee79c38 100644
--- a/pc-bios/optionrom/linuxboot_dma.c
+++ b/pc-bios/optionrom/linuxboot_dma.c
@@ -20,6 +20,10 @@
  *     Richard W.M. Jones <rjones@redhat.com>
  */
=20
+#include <stdint.h>
+#include "optrom.h"
+#include "optrom_fw_cfg.h"
+
 asm(
 ".text\n"
 ".global _start\n"
@@ -58,34 +62,12 @@ asm(
 "   jmp load_kernel\n"
 );
=20
-#define BIOS_CFG_DMA_ADDR_HIGH 0x514
-#define BIOS_CFG_DMA_ADDR_LOW  0x518
-
-#define uint64_t unsigned long long
-#define uint32_t unsigned int
-#define uint16_t unsigned short
-
-#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
-
-#define barrier() asm("" : : : "memory")
-
-static inline void outl(uint32_t value, uint16_t port)
-{
-    asm("outl %0, %w1" : : "a"(value), "Nd"(port));
-}
-
 static inline void set_es(void *addr)
 {
     uint32_t seg =3D (uint32_t)addr >> 4;
     asm("movl %0, %%es" : : "r"(seg));
 }
=20
-#ifdef __clang__
-#define ADDR32
-#else
-#define ADDR32 "addr32 "
-#endif
-
 static inline uint16_t readw_es(uint16_t offset)
 {
     uint16_t val;
@@ -108,56 +90,6 @@ static inline void writel_es(uint16_t offset, uint32_=
t val)
     asm(ADDR32 "movl %0, %%es:(%1)" : : "r"(val), "r"((uint32_t)offset))=
;
 }
=20
-static inline uint32_t bswap32(uint32_t x)
-{
-    asm("bswapl %0" : "=3Dr" (x) : "0" (x));
-    return x;
-}
-
-static inline uint64_t bswap64(uint64_t x)
-{
-    asm("bswapl %%eax; bswapl %%edx; xchg %%eax, %%edx" : "=3DA" (x) : "=
0" (x));
-    return x;
-}
-
-static inline uint64_t cpu_to_be64(uint64_t x)
-{
-    return bswap64(x);
-}
-
-static inline uint32_t cpu_to_be32(uint32_t x)
-{
-    return bswap32(x);
-}
-
-static inline uint32_t be32_to_cpu(uint32_t x)
-{
-    return bswap32(x);
-}
-
-/* clang is happy to inline this function, and bloats the
- * ROM.
- */
-static __attribute__((__noinline__))
-void bios_cfg_read_entry(void *buf, uint16_t entry, uint32_t len)
-{
-    struct fw_cfg_dma_access access;
-    uint32_t control =3D (entry << 16) | FW_CFG_DMA_CTL_SELECT
-                        | FW_CFG_DMA_CTL_READ;
-
-    access.address =3D cpu_to_be64((uint64_t)(uint32_t)buf);
-    access.length =3D cpu_to_be32(len);
-    access.control =3D cpu_to_be32(control);
-
-    barrier();
-
-    outl(cpu_to_be32((uint32_t)&access), BIOS_CFG_DMA_ADDR_LOW);
-
-    while (be32_to_cpu(access.control) & ~FW_CFG_DMA_CTL_ERROR) {
-        barrier();
-    }
-}
-
 /* Return top of memory using BIOS function E801. */
 static uint32_t get_e801_addr(void)
 {
@@ -211,9 +143,9 @@ void load_kernel(void)
     uint32_t initrd_end_page, max_allowed_page;
     uint32_t segment_addr, stack_addr;
=20
-    bios_cfg_read_entry(&setup_addr, FW_CFG_SETUP_ADDR, 4);
-    bios_cfg_read_entry(&setup_size, FW_CFG_SETUP_SIZE, 4);
-    bios_cfg_read_entry(setup_addr, FW_CFG_SETUP_DATA, setup_size);
+    bios_cfg_read_entry_dma(&setup_addr, FW_CFG_SETUP_ADDR, 4);
+    bios_cfg_read_entry_dma(&setup_size, FW_CFG_SETUP_SIZE, 4);
+    bios_cfg_read_entry_dma(setup_addr, FW_CFG_SETUP_DATA, setup_size);
=20
     set_es(setup_addr);
=20
@@ -223,8 +155,8 @@ void load_kernel(void)
         writel_es(0x22c, 0x37ffffff);
     }
=20
-    bios_cfg_read_entry(&initrd_addr, FW_CFG_INITRD_ADDR, 4);
-    bios_cfg_read_entry(&initrd_size, FW_CFG_INITRD_SIZE, 4);
+    bios_cfg_read_entry_dma(&initrd_addr, FW_CFG_INITRD_ADDR, 4);
+    bios_cfg_read_entry_dma(&initrd_size, FW_CFG_INITRD_SIZE, 4);
=20
     initrd_end_page =3D ((uint32_t)(initrd_addr + initrd_size) & -4096);
     max_allowed_page =3D (readl_es(0x22c) & -4096);
@@ -239,15 +171,15 @@ void load_kernel(void)
=20
     }
=20
-    bios_cfg_read_entry(initrd_addr, FW_CFG_INITRD_DATA, initrd_size);
+    bios_cfg_read_entry_dma(initrd_addr, FW_CFG_INITRD_DATA, initrd_size=
);
=20
-    bios_cfg_read_entry(&kernel_addr, FW_CFG_KERNEL_ADDR, 4);
-    bios_cfg_read_entry(&kernel_size, FW_CFG_KERNEL_SIZE, 4);
-    bios_cfg_read_entry(kernel_addr, FW_CFG_KERNEL_DATA, kernel_size);
+    bios_cfg_read_entry_dma(&kernel_addr, FW_CFG_KERNEL_ADDR, 4);
+    bios_cfg_read_entry_dma(&kernel_size, FW_CFG_KERNEL_SIZE, 4);
+    bios_cfg_read_entry_dma(kernel_addr, FW_CFG_KERNEL_DATA, kernel_size=
);
=20
-    bios_cfg_read_entry(&cmdline_addr, FW_CFG_CMDLINE_ADDR, 4);
-    bios_cfg_read_entry(&cmdline_size, FW_CFG_CMDLINE_SIZE, 4);
-    bios_cfg_read_entry(cmdline_addr, FW_CFG_CMDLINE_DATA, cmdline_size)=
;
+    bios_cfg_read_entry_dma(&cmdline_addr, FW_CFG_CMDLINE_ADDR, 4);
+    bios_cfg_read_entry_dma(&cmdline_size, FW_CFG_CMDLINE_SIZE, 4);
+    bios_cfg_read_entry_dma(cmdline_addr, FW_CFG_CMDLINE_DATA, cmdline_s=
ize);
=20
     /* Boot linux */
     segment_addr =3D ((uint32_t)setup_addr >> 4);
diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
new file mode 100644
index 0000000000..c5c8caa22f
--- /dev/null
+++ b/pc-bios/optionrom/optrom.h
@@ -0,0 +1,110 @@
+/*
+ * Common Option ROM Functions for C code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (c) 2015-2019 Red Hat Inc.
+ *   Authors:
+ *     Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
+ *     Richard W.M. Jones <rjones@redhat.com>
+ *     Stefano Garzarella <sgarzare@redhat.com>
+ */
+
+#ifndef OPTROM_H
+#define OPTROM_H
+
+#include <stdint.h>
+#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
+
+#define barrier() asm("" : : : "memory")
+
+#ifdef __clang__
+#define ADDR32
+#else
+#define ADDR32 "addr32 "
+#endif
+
+static inline void outb(uint8_t value, uint16_t port)
+{
+    asm volatile("outb %0, %w1" : : "a"(value), "Nd"(port));
+}
+
+static inline void outw(uint16_t value, uint16_t port)
+{
+    asm volatile("outw %0, %w1" : : "a"(value), "Nd"(port));
+}
+
+static inline void outl(uint32_t value, uint16_t port)
+{
+    asm volatile("outl %0, %w1" : : "a"(value), "Nd"(port));
+}
+
+static inline uint8_t inb(uint16_t port)
+{
+    uint8_t value;
+
+    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
+    return value;
+}
+
+static inline uint16_t inw(uint16_t port)
+{
+    uint16_t value;
+
+    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
+    return value;
+}
+
+static inline uint32_t inl(uint16_t port)
+{
+    uint32_t value;
+
+    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
+    return value;
+}
+
+static inline void insb(uint16_t port, uint8_t *buf, uint32_t len)
+{
+    asm volatile("rep insb (%%dx), %%es:(%%edi)"
+                 : "+c"(len), "+D"(buf) : "d"(port) : "memory");
+}
+
+static inline uint32_t bswap32(uint32_t x)
+{
+    asm("bswapl %0" : "=3Dr" (x) : "0" (x));
+    return x;
+}
+
+static inline uint64_t bswap64(uint64_t x)
+{
+    asm("bswapl %%eax; bswapl %%edx; xchg %%eax, %%edx" : "=3DA" (x) : "=
0" (x));
+    return x;
+}
+
+static inline uint64_t cpu_to_be64(uint64_t x)
+{
+    return bswap64(x);
+}
+
+static inline uint32_t cpu_to_be32(uint32_t x)
+{
+    return bswap32(x);
+}
+
+static inline uint32_t be32_to_cpu(uint32_t x)
+{
+    return bswap32(x);
+}
+
+#endif /* OPTROM_H */
diff --git a/pc-bios/optionrom/optrom_fw_cfg.h b/pc-bios/optionrom/optrom=
_fw_cfg.h
new file mode 100644
index 0000000000..a3660a5200
--- /dev/null
+++ b/pc-bios/optionrom/optrom_fw_cfg.h
@@ -0,0 +1,92 @@
+/*
+ * Common Option ROM Functions for fw_cfg
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (c) 2015-2019 Red Hat Inc.
+ *   Authors:
+ *     Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
+ *     Richard W.M. Jones <rjones@redhat.com>
+ *     Stefano Garzarella <sgarzare@redhat.com>
+ */
+
+#ifndef OPTROM_FW_CFG_H
+#define OPTROM_FW_CFG_H
+
+#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
+
+#define BIOS_CFG_IOPORT_CFG     0x510
+#define BIOS_CFG_IOPORT_DATA    0x511
+#define BIOS_CFG_DMA_ADDR_HIGH  0x514
+#define BIOS_CFG_DMA_ADDR_LOW   0x518
+
+static __attribute__((unused))
+void bios_cfg_select(uint16_t key)
+{
+    outw(key, BIOS_CFG_IOPORT_CFG);
+}
+
+static __attribute__((unused))
+void bios_cfg_read_entry_io(void *buf, uint16_t entry, uint32_t len)
+{
+    bios_cfg_select(entry);
+    insb(BIOS_CFG_IOPORT_DATA, buf, len);
+}
+
+/*
+ * clang is happy to inline this function, and bloats the
+ * ROM.
+ */
+static __attribute__((__noinline__)) __attribute__((unused))
+void bios_cfg_read_entry_dma(void *buf, uint16_t entry, uint32_t len)
+{
+    struct fw_cfg_dma_access access;
+    uint32_t control =3D (entry << 16) | FW_CFG_DMA_CTL_SELECT
+                        | FW_CFG_DMA_CTL_READ;
+
+    access.address =3D cpu_to_be64((uint64_t)(uint32_t)buf);
+    access.length =3D cpu_to_be32(len);
+    access.control =3D cpu_to_be32(control);
+
+    barrier();
+
+    outl(cpu_to_be32((uint32_t)&access), BIOS_CFG_DMA_ADDR_LOW);
+
+    while (be32_to_cpu(access.control) & ~FW_CFG_DMA_CTL_ERROR) {
+        barrier();
+    }
+}
+
+static __attribute__((unused))
+void bios_cfg_read_entry(void *buf, uint16_t entry, uint32_t len,
+                         uint32_t version)
+{
+    if (version & FW_CFG_VERSION_DMA) {
+        bios_cfg_read_entry_dma(buf, entry, len);
+    } else {
+        bios_cfg_read_entry_io(buf, entry, len);
+    }
+}
+
+static __attribute__((unused))
+uint32_t bios_cfg_version(void)
+{
+    uint32_t version;
+
+    bios_cfg_read_entry_io(&version, FW_CFG_ID, sizeof(version));
+
+    return version;
+}
+
+#endif /* OPTROM_FW_CFG_H */
--=20
2.20.1
