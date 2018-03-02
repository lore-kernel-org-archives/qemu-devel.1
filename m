Received: from eggs.gnu.org ([2001:4830:134:3::10]:58538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erl8D-0007Yw-3D
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erl8B-0002Bg-Bb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:53:53 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erl8B-0002BS-3O
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:53:51 -0500
Received: by mail-pf0-x242.google.com with SMTP id y186so4034196pfb.2
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:53:50 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Sat,  3 Mar 2018 02:51:40 +1300
Message-Id: <1519998711-73430-13-git-send-email-mjc@sifive.com>
In-Reply-To: <1519998711-73430-1-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 12/23] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>, Stefan O'Rear <sorear2@gmail.com>

HTIF (Host Target Interface) provides console emulation for QEMU. HTIF
allows identical copies of BBL (Berkeley Boot Loader) and linux to run
on both Spike and QEMU. BBL provides HTIF console access via the
SBI (Supervisor Binary Interface) and the linux kernel SBI console.

The HTIT chardev implements the pre qom legacy interface consistent
with the 16550a UART in 'hw/char/serial.c'.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
Signed-off-by: Stefan O'Rear <sorear2@gmail.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/riscv_htif.c         | 258 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/riscv_htif.h |  61 ++++++++++
 2 files changed, 319 insertions(+)
 create mode 100644 hw/riscv/riscv_htif.c
 create mode 100644 include/hw/riscv/riscv_htif.h

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
new file mode 100644
index 0000000..3e17f30
--- /dev/null
+++ b/hw/riscv/riscv_htif.c
@@ -0,0 +1,258 @@
+/*
+ * QEMU RISC-V Host Target Interface (HTIF) Emulation
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ *
+ * This provides HTIF device emulation for QEMU. At the moment this allows
+ * for identical copies of bbl/linux to run on both spike and QEMU.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/riscv/riscv_htif.h"
+#include "qemu/timer.h"
+#include "exec/address-spaces.h"
+#include "qemu/error-report.h"
+
+#define RISCV_DEBUG_HTIF 0
+#define HTIF_DEBUG(fmt, ...)                                                   \
+    do {                                                                       \
+        if (RISCV_DEBUG_HTIF) {                                                \
+            qemu_log_mask(LOG_TRACE, "%s: " fmt "\n", __func__, ##__VA_ARGS__);\
+        }                                                                      \
+    } while (0)
+
+static uint64_t fromhost_addr, tohost_addr;
+
+void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
+    uint64_t st_size)
+{
+    if (strcmp("fromhost", st_name) == 0) {
+        fromhost_addr = st_value;
+        if (st_size != 8) {
+            error_report("HTIF fromhost must be 8 bytes");
+            exit(1);
+        }
+    } else if (strcmp("tohost", st_name) == 0) {
+        tohost_addr = st_value;
+        if (st_size != 8) {
+            error_report("HTIF tohost must be 8 bytes");
+            exit(1);
+        }
+    }
+}
+
+/*
+ * Called by the char dev to see if HTIF is ready to accept input.
+ */
+static int htif_can_recv(void *opaque)
+{
+    return 1;
+}
+
+/*
+ * Called by the char dev to supply input to HTIF console.
+ * We assume that we will receive one character at a time.
+ */
+static void htif_recv(void *opaque, const uint8_t *buf, int size)
+{
+    HTIFState *htifstate = opaque;
+
+    if (size != 1) {
+        return;
+    }
+
+    /* TODO - we need to check whether mfromhost is zero which indicates
+              the device is ready to receive. The current implementation
+              will drop characters */
+
+    uint64_t val_written = htifstate->pending_read;
+    uint64_t resp = 0x100 | *buf;
+
+    htifstate->env->mfromhost = (val_written >> 48 << 48) | (resp << 16 >> 16);
+}
+
+/*
+ * Called by the char dev to supply special events to the HTIF console.
+ * Not used for HTIF.
+ */
+static void htif_event(void *opaque, int event)
+{
+
+}
+
+static int htif_be_change(void *opaque)
+{
+    HTIFState *s = opaque;
+
+    qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
+        htif_be_change, s, NULL, true);
+
+    return 0;
+}
+
+static void htif_handle_tohost_write(HTIFState *htifstate, uint64_t val_written)
+{
+    uint8_t device = val_written >> 56;
+    uint8_t cmd = val_written >> 48;
+    uint64_t payload = val_written & 0xFFFFFFFFFFFFULL;
+    int resp = 0;
+
+    HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
+        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, payload);
+
+    /*
+     * Currently, there is a fixed mapping of devices:
+     * 0: riscv-tests Pass/Fail Reporting Only (no syscall proxy)
+     * 1: Console
+     */
+    if (unlikely(device == 0x0)) {
+        /* frontend syscall handler, shutdown and exit code support */
+        if (cmd == 0x0) {
+            if (payload & 0x1) {
+                /* exit code */
+                int exit_code = payload >> 1;
+                exit(exit_code);
+            } else {
+                qemu_log_mask(LOG_UNIMP, "pk syscall proxy not supported\n");
+            }
+        } else {
+            qemu_log("HTIF device %d: unknown command\n", device);
+        }
+    } else if (likely(device == 0x1)) {
+        /* HTIF Console */
+        if (cmd == 0x0) {
+            /* this should be a queue, but not yet implemented as such */
+            htifstate->pending_read = val_written;
+            htifstate->env->mtohost = 0; /* clear to indicate we read */
+            return;
+        } else if (cmd == 0x1) {
+            qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload, 1);
+            resp = 0x100 | (uint8_t)payload;
+        } else {
+            qemu_log("HTIF device %d: unknown command\n", device);
+        }
+    } else {
+        qemu_log("HTIF unknown device or command\n");
+        HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
+            " payload: %016" PRIx64, device, cmd, payload & 0xFF, payload);
+    }
+    /*
+     * - latest bbl does not set fromhost to 0 if there is a value in tohost
+     * - with this code enabled, qemu hangs waiting for fromhost to go to 0
+     * - with this code disabled, qemu works with bbl priv v1.9.1 and v1.10
+     * - HTIF needs protocol documentation and a more complete state machine
+
+        while (!htifstate->fromhost_inprogress &&
+            htifstate->env->mfromhost != 0x0) {
+        }
+    */
+    htifstate->env->mfromhost = (val_written >> 48 << 48) | (resp << 16 >> 16);
+    htifstate->env->mtohost = 0; /* clear to indicate we read */
+}
+
+#define TOHOST_OFFSET1 (htifstate->tohost_offset)
+#define TOHOST_OFFSET2 (htifstate->tohost_offset + 4)
+#define FROMHOST_OFFSET1 (htifstate->fromhost_offset)
+#define FROMHOST_OFFSET2 (htifstate->fromhost_offset + 4)
+
+/* CPU wants to read an HTIF register */
+static uint64_t htif_mm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    HTIFState *htifstate = opaque;
+    if (addr == TOHOST_OFFSET1) {
+        return htifstate->env->mtohost & 0xFFFFFFFF;
+    } else if (addr == TOHOST_OFFSET2) {
+        return (htifstate->env->mtohost >> 32) & 0xFFFFFFFF;
+    } else if (addr == FROMHOST_OFFSET1) {
+        return htifstate->env->mfromhost & 0xFFFFFFFF;
+    } else if (addr == FROMHOST_OFFSET2) {
+        return (htifstate->env->mfromhost >> 32) & 0xFFFFFFFF;
+    } else {
+        qemu_log("Invalid htif read: address %016" PRIx64 "\n",
+            (uint64_t)addr);
+        return 0;
+    }
+}
+
+/* CPU wrote to an HTIF register */
+static void htif_mm_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    HTIFState *htifstate = opaque;
+    if (addr == TOHOST_OFFSET1) {
+        if (htifstate->env->mtohost == 0x0) {
+            htifstate->allow_tohost = 1;
+            htifstate->env->mtohost = value & 0xFFFFFFFF;
+        } else {
+            htifstate->allow_tohost = 0;
+        }
+    } else if (addr == TOHOST_OFFSET2) {
+        if (htifstate->allow_tohost) {
+            htifstate->env->mtohost |= value << 32;
+            htif_handle_tohost_write(htifstate, htifstate->env->mtohost);
+        }
+    } else if (addr == FROMHOST_OFFSET1) {
+        htifstate->fromhost_inprogress = 1;
+        htifstate->env->mfromhost = value & 0xFFFFFFFF;
+    } else if (addr == FROMHOST_OFFSET2) {
+        htifstate->env->mfromhost |= value << 32;
+        htifstate->fromhost_inprogress = 0;
+    } else {
+        qemu_log("Invalid htif write: address %016" PRIx64 "\n",
+            (uint64_t)addr);
+    }
+}
+
+static const MemoryRegionOps htif_mm_ops = {
+    .read = htif_mm_read,
+    .write = htif_mm_write,
+};
+
+HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
+    CPURISCVState *env, Chardev *chr)
+{
+    uint64_t base = MIN(tohost_addr, fromhost_addr);
+    uint64_t size = MAX(tohost_addr + 8, fromhost_addr + 8) - base;
+    uint64_t tohost_offset = tohost_addr - base;
+    uint64_t fromhost_offset = fromhost_addr - base;
+
+    HTIFState *s = g_malloc0(sizeof(HTIFState));
+    s->address_space = address_space;
+    s->main_mem = main_mem;
+    s->main_mem_ram_ptr = memory_region_get_ram_ptr(main_mem);
+    s->env = env;
+    s->tohost_offset = tohost_offset;
+    s->fromhost_offset = fromhost_offset;
+    s->pending_read = 0;
+    s->allow_tohost = 0;
+    s->fromhost_inprogress = 0;
+    qemu_chr_fe_init(&s->chr, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
+        htif_be_change, s, NULL, true);
+    if (base) {
+        memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
+                            TYPE_HTIF_UART, size);
+        memory_region_add_subregion(address_space, base, &s->mmio);
+    }
+
+    return s;
+}
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.h
new file mode 100644
index 0000000..fb5f881
--- /dev/null
+++ b/include/hw/riscv/riscv_htif.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU RISCV Host Target Interface (HTIF) Emulation
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RISCV_HTIF_H
+#define HW_RISCV_HTIF_H
+
+#include "hw/hw.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "sysemu/sysemu.h"
+#include "exec/memory.h"
+#include "target/riscv/cpu.h"
+
+#define TYPE_HTIF_UART "riscv.htif.uart"
+
+typedef struct HTIFState {
+    int allow_tohost;
+    int fromhost_inprogress;
+
+    hwaddr tohost_offset;
+    hwaddr fromhost_offset;
+    uint64_t tohost_size;
+    uint64_t fromhost_size;
+    MemoryRegion mmio;
+    MemoryRegion *address_space;
+    MemoryRegion *main_mem;
+    void *main_mem_ram_ptr;
+
+    CPURISCVState *env;
+    CharBackend chr;
+    uint64_t pending_read;
+} HTIFState;
+
+extern const VMStateDescription vmstate_htif;
+extern const MemoryRegionOps htif_io_ops;
+
+/* HTIF symbol callback */
+void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
+    uint64_t st_size);
+
+/* legacy pre qom */
+HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
+    CPURISCVState *env, Chardev *chr);
+
+#endif
-- 
2.7.0
