Received: from eggs.gnu.org ([2001:4830:134:3::10]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7L-0006O7-Sj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7G-0000XR-W7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:11 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:37054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ7G-0000WU-Hk
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:06 -0500
Received: by mail-pg0-x231.google.com with SMTP id z17so1113789pgc.4
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:49:06 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:30 -0800
Message-Id: <1515628000-93285-12-git-send-email-mjc@sifive.com>
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 11/21] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

HTIF (Host Target Interface) provides console emulation for QEMU. HTIF
allows identical copies of BBL (Berkeley Boot Loader) and linux to run
on both Spike and QEMU. BBL provides HTIF console access via the
SBI (Supervisor Binary Interface) and the linux kernel SBI console.

The HTIF interface reads the ELF kernel and locates the 'tohost' and
'fromhost' symbols which it uses for guest to host console MMIO.

The HTIT chardev implements the pre qom legacy interface consistent
with the 16550a UART in 'hw/char/serial.c'.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/riscv_elf.c          | 244 +++++++++++++++++++++++++++
 hw/riscv/riscv_htif.c         | 373 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/riscv_elf.h  |  69 ++++++++
 include/hw/riscv/riscv_htif.h |  62 +++++++
 4 files changed, 748 insertions(+)
 create mode 100644 hw/riscv/riscv_elf.c
 create mode 100644 hw/riscv/riscv_htif.c
 create mode 100644 include/hw/riscv/riscv_elf.h
 create mode 100644 include/hw/riscv/riscv_htif.h

diff --git a/hw/riscv/riscv_elf.c b/hw/riscv/riscv_elf.c
new file mode 100644
index 0000000..355a5a1
--- /dev/null
+++ b/hw/riscv/riscv_elf.c
@@ -0,0 +1,244 @@
+/*
+ * elf.c - A simple package for manipulating symbol tables in elf binaries.
+ *
+ * Taken from
+ * https://www.cs.cmu.edu/afs/cs.cmu.edu/academic/class/15213-f03/www/
+ * ftrace/elf.c
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <glib.h>
+
+#include "hw/riscv/riscv_elf.h"
+
+/*
+ * elf_open - Map a binary into the address space and extract the
+ * locations of the static and dynamic symbol tables and their string
+ * tables. Return this information in a Elf object file handle that will
+ * be passed to all of the other elf functions.
+ */
+Elf_obj64 *elf_open64(const char *filename)
+{
+    int i, fd;
+    struct stat sbuf;
+    Elf_obj64 *ep;
+    Elf64_Shdr *shdr;
+
+    ep = g_new(Elf_obj64, 1);
+
+    /* Do some consistency checks on the binary */
+    fd = open(filename, O_RDONLY);
+    if (fd == -1) {
+        fprintf(stderr, "Can't open \"%s\": %s\n", filename, strerror(errno));
+        exit(1);
+    }
+    if (fstat(fd, &sbuf) == -1) {
+        fprintf(stderr, "Can't stat \"%s\": %s\n", filename, strerror(errno));
+        exit(1);
+    }
+    if (sbuf.st_size < sizeof(Elf64_Ehdr)) {
+        fprintf(stderr, "\"%s\" is not an ELF binary object\n", filename);
+        exit(1);
+    }
+
+    /* It looks OK, so map the Elf binary into our address space */
+    ep->mlen = sbuf.st_size;
+    ep->maddr = mmap(NULL, ep->mlen, PROT_READ, MAP_SHARED, fd, 0);
+    if (ep->maddr == (void *)-1) {
+        fprintf(stderr, "Can't mmap \"%s\": %s\n", filename, strerror(errno));
+        exit(1);
+    }
+    close(fd);
+
+    /* The Elf binary begins with the Elf header */
+    ep->ehdr = ep->maddr;
+
+    /* check we have a 64-bit little-endian RISC-V ELF object */
+    if (ep->ehdr->e_ident[EI_MAG0] != ELFMAG0 ||
+        ep->ehdr->e_ident[EI_MAG1] != ELFMAG1 ||
+        ep->ehdr->e_ident[EI_MAG2] != ELFMAG2 ||
+        ep->ehdr->e_ident[EI_MAG3] != ELFMAG3 ||
+        ep->ehdr->e_ident[EI_CLASS] != ELFCLASS64 ||
+        ep->ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
+        ep->ehdr->e_machine != EM_RISCV)
+    {
+        fprintf(stderr, "\"%s\" is not a 64-bit RISC-V ELF object\n", filename);
+        exit(1);
+    }
+
+    /*
+     * Find the static and dynamic symbol tables and their string
+     * tables in the the mapped binary. The sh_link field in symbol
+     * table section headers gives the section index of the string
+     * table for that symbol table.
+     */
+    shdr = (Elf64_Shdr *)(ep->maddr + ep->ehdr->e_shoff);
+    for (i = 0; i < ep->ehdr->e_shnum; i++) {
+        if (shdr[i].sh_type == SHT_SYMTAB) {   /* Static symbol table */
+            ep->symtab = (Elf64_Sym *)(ep->maddr + shdr[i].sh_offset);
+            ep->symtab_end = (Elf64_Sym *)((char *)ep->symtab +
+                             shdr[i].sh_size);
+            ep->strtab = (char *)(ep->maddr + shdr[shdr[i].sh_link].sh_offset);
+        }
+        if (shdr[i].sh_type == SHT_DYNSYM) {   /* Dynamic symbol table */
+            ep->dsymtab = (Elf64_Sym *)(ep->maddr + shdr[i].sh_offset);
+            ep->dsymtab_end = (Elf64_Sym *)((char *)ep->dsymtab +
+                              shdr[i].sh_size);
+            ep->dstrtab = (char *)(ep->maddr + shdr[shdr[i].sh_link].sh_offset);
+        }
+    }
+    return ep;
+}
+
+Elf_obj32 *elf_open32(const char *filename)
+{
+    int i, fd;
+    struct stat sbuf;
+    Elf_obj32 *ep;
+    Elf32_Shdr *shdr;
+
+    ep = g_new(Elf_obj32, 1);
+
+    /* Do some consistency checks on the binary */
+    fd = open(filename, O_RDONLY);
+    if (fd == -1) {
+        fprintf(stderr, "Can't open \"%s\": %s\n", filename, strerror(errno));
+        exit(1);
+    }
+    if (fstat(fd, &sbuf) == -1) {
+        fprintf(stderr, "Can't stat \"%s\": %s\n", filename, strerror(errno));
+        exit(1);
+    }
+    if (sbuf.st_size < sizeof(Elf32_Ehdr)) {
+        fprintf(stderr, "\"%s\" is not an ELF binary object\n", filename);
+        exit(1);
+    }
+
+    /* It looks OK, so map the Elf binary into our address space */
+    ep->mlen = sbuf.st_size;
+    ep->maddr = mmap(NULL, ep->mlen, PROT_READ, MAP_SHARED, fd, 0);
+    if (ep->maddr == (void *)-1) {
+        fprintf(stderr, "Can't mmap \"%s\": %s\n", filename, strerror(errno));
+        exit(1);
+    }
+    close(fd);
+
+    /* The Elf binary begins with the Elf header */
+    ep->ehdr = ep->maddr;
+
+    /* check we have a 32-bit little-endian RISC-V ELF object */
+    if (ep->ehdr->e_ident[EI_MAG0] != ELFMAG0 ||
+        ep->ehdr->e_ident[EI_MAG1] != ELFMAG1 ||
+        ep->ehdr->e_ident[EI_MAG2] != ELFMAG2 ||
+        ep->ehdr->e_ident[EI_MAG3] != ELFMAG3 ||
+        ep->ehdr->e_ident[EI_CLASS] != ELFCLASS32 ||
+        ep->ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
+        ep->ehdr->e_machine != EM_RISCV)
+    {
+        fprintf(stderr, "\"%s\" is not a 32-bit RISC-V ELF object\n", filename);
+        exit(1);
+    }
+
+    /*
+     * Find the static and dynamic symbol tables and their string
+     * tables in the the mapped binary. The sh_link field in symbol
+     * table section headers gives the section index of the string
+     * table for that symbol table.
+     */
+    shdr = (Elf32_Shdr *)(ep->maddr + ep->ehdr->e_shoff);
+    for (i = 0; i < ep->ehdr->e_shnum; i++) {
+        if (shdr[i].sh_type == SHT_SYMTAB) {   /* Static symbol table */
+            ep->symtab = (Elf32_Sym *)(ep->maddr + shdr[i].sh_offset);
+            ep->symtab_end = (Elf32_Sym *)((char *)ep->symtab +
+                             shdr[i].sh_size);
+            ep->strtab = (char *)(ep->maddr + shdr[shdr[i].sh_link].sh_offset);
+        }
+        if (shdr[i].sh_type == SHT_DYNSYM) {   /* Dynamic symbol table */
+            ep->dsymtab = (Elf32_Sym *)(ep->maddr + shdr[i].sh_offset);
+            ep->dsymtab_end = (Elf32_Sym *)((char *)ep->dsymtab +
+                              shdr[i].sh_size);
+            ep->dstrtab = (char *)(ep->maddr + shdr[shdr[i].sh_link].sh_offset);
+        }
+    }
+    return ep;
+}
+
+/*
+ * elf_close - Free up the resources of an  elf object
+ */
+void elf_close64(Elf_obj64 *ep)
+{
+    if (munmap(ep->maddr, ep->mlen) < 0) {
+        perror("munmap");
+        exit(1);
+    }
+    free(ep);
+}
+
+void elf_close32(Elf_obj32 *ep)
+{
+    if (munmap(ep->maddr, ep->mlen) < 0) {
+        perror("munmap");
+        exit(1);
+    }
+    free(ep);
+}
+
+/*
+ * elf_symname - Return ASCII name of a static symbol
+ */
+char *elf_symname64(Elf_obj64 *ep, Elf64_Sym *sym)
+{
+    return &ep->strtab[sym->st_name];
+}
+
+char *elf_symname32(Elf_obj32 *ep, Elf32_Sym *sym)
+{
+    return &ep->strtab[sym->st_name];
+}
+
+/*
+ * elf_firstsym - Return ptr to first symbol in static symbol table
+ */
+Elf64_Sym *elf_firstsym64(Elf_obj64 *ep)
+{
+    return ep->symtab;
+}
+
+Elf32_Sym *elf_firstsym32(Elf_obj32 *ep)
+{
+    return ep->symtab;
+}
+
+
+/*
+ * elf_nextsym - Return ptr to next symbol in static symbol table,
+ * or NULL if no more symbols.
+ */
+Elf64_Sym *elf_nextsym64(Elf_obj64 *ep, Elf64_Sym *sym)
+{
+    sym++;
+    if (sym < ep->symtab_end) {
+        return sym;
+    } else {
+        return NULL;
+    }
+}
+
+Elf32_Sym *elf_nextsym32(Elf_obj32 *ep, Elf32_Sym *sym)
+{
+    sym++;
+    if (sym < ep->symtab_end) {
+        return sym;
+    } else {
+        return NULL;
+    }
+}
diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
new file mode 100644
index 0000000..ca81699
--- /dev/null
+++ b/hw/riscv/riscv_htif.c
@@ -0,0 +1,373 @@
+/*
+ * QEMU RISC-V Host Target Interface (HTIF) Emulation
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
+ * This provides HTIF device emulation for QEMU. At the moment this allows
+ * for identical copies of bbl/linux to run on both spike and QEMU.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
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
+#include "hw/riscv/riscv_elf.h"
+
+#define ENABLE_CHARDEV
+
+#define RISCV_DEBUG_HTIF 0
+#define HTIF_DEBUG(fmt, ...)                                         \
+  do {                                                               \
+    if (RISCV_DEBUG_HTIF) {                                          \
+      qemu_log_mask(LOG_TRACE, "%s: " fmt, __func__, ##__VA_ARGS__); \
+    }                                                                \
+  } while (0)
+
+#ifdef ENABLE_CHARDEV
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
+    qemu_irq_raise(htifstate->irq);
+}
+
+/*
+ * Called by the char dev to supply special events to the HTIF console.
+ * Not used for HTIF.
+ */
+static void htif_event(void *opaque, int event)
+{
+    #ifdef DEBUG_CHARDEV
+    fprintf(stderr, "GOT EVENT: %d\n", event);
+    #endif
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
+#endif
+
+static void dma_strcopy(HTIFState *htifstate, char *str, hwaddr phys_addr)
+{
+    int i = 0;
+    void *base_copy_addr = htifstate->main_mem_ram_ptr + phys_addr;
+    while (*(str + i)) {
+        stb_p((void *)(base_copy_addr + i), *(str + i));
+        i++;
+    }
+    stb_p((void *)(base_copy_addr + i), 0); /* store null term */
+}
+
+static void htif_handle_tohost_write(HTIFState *htifstate, uint64_t val_written)
+{
+    HTIF_DEBUG("TOHOST WRITE WITH val 0x%016" PRIx64, val_written);
+
+    uint8_t device = val_written >> 56;
+    uint8_t cmd = val_written >> 48;
+    uint64_t payload = val_written & 0xFFFFFFFFFFFFULL;
+
+    uint64_t addr = payload >> 8;
+    hwaddr real_addr = (hwaddr)addr;
+    uint8_t what = payload & 0xFF;
+    int resp;
+
+    resp = 0; /* stop gcc complaining */
+    HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
+        " -payload: %016" PRIx64, device, cmd, payload & 0xFF, payload);
+
+    /*
+     * Currently, there is a fixed mapping of devices:
+     * 0: riscv-tests Pass/Fail Reporting Only (no syscall proxy)
+     * 1: Console
+     */
+    if (unlikely(device == 0x0)) {
+        /* frontend syscall handler, only test pass/fail support */
+        if (cmd == 0x0) {
+            HTIF_DEBUG("frontend syscall handler");
+            if (payload & 0x1) {
+                /* exit code */
+                int exit_code = payload >> 1;
+                if (exit_code) {
+                    qemu_log("*** FAILED *** (tohost = %d)", exit_code);
+                }
+                exit(exit_code);
+            }
+            qemu_log_mask(LOG_UNIMP, "pk syscall proxy not supported");
+        } else if (cmd == 0xFF) {
+            /* use what */
+            if (what == 0xFF) {
+                HTIF_DEBUG("registering name");
+                dma_strcopy(htifstate, (char *)"syscall_proxy", real_addr);
+            } else if (what == 0x0) {
+                HTIF_DEBUG("registering syscall cmd");
+                dma_strcopy(htifstate, (char *)"syscall", real_addr);
+            } else {
+                HTIF_DEBUG("registering end of cmds list");
+                dma_strcopy(htifstate, (char *)"", real_addr);
+            }
+            resp = 0x1; /* write to indicate device name placed */
+        } else {
+            qemu_log("HTIF device %d: UNKNOWN COMMAND", device);
+        }
+    } else if (likely(device == 0x1)) {
+        /* HTIF Console */
+        if (cmd == 0x0) {
+            /* this should be a queue, but not yet implemented as such */
+            htifstate->pending_read = val_written;
+            htifstate->env->mtohost = 0; /* clear to indicate we read */
+            return;
+        } else if (cmd == 0x1) {
+            #ifdef ENABLE_CHARDEV
+            qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload, 1);
+            #endif
+            resp = 0x100 | (uint8_t)payload;
+        } else if (cmd == 0xFF) {
+            /* use what */
+            if (what == 0xFF) {
+                HTIF_DEBUG("registering name");
+                dma_strcopy(htifstate, (char *)"bcd", real_addr);
+            } else if (what == 0x0) {
+                HTIF_DEBUG("registering read cmd");
+                dma_strcopy(htifstate, (char *)"read", real_addr);
+            } else if (what == 0x1) {
+                HTIF_DEBUG("registering write cmd");
+                dma_strcopy(htifstate, (char *)"write", real_addr);
+            } else {
+                HTIF_DEBUG("registering end of cmds list");
+                dma_strcopy(htifstate, (char *)"", real_addr);
+            }
+            resp = 0x1; /* write to indicate device name placed */
+        } else {
+            qemu_log("HTIF device %d: UNKNOWN COMMAND", device);
+        }
+    /* all other devices */
+    } else if (device == 0x2 && cmd == 0xFF && what == 0xFF) {
+        HTIF_DEBUG("registering no device as last");
+        stb_p((void *)(htifstate->main_mem_ram_ptr + real_addr), 0);
+        resp = 0x1; /* write to indicate device name placed */
+    } else {
+        qemu_log("HTIF UNKNOWN DEVICE OR COMMAND");
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
+    if (htifstate->env->mfromhost != 0) {
+        /* raise HTIF interrupt */
+        qemu_irq_raise(htifstate->irq);
+    }
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
+        qemu_log("Invalid htif read: address %016" PRIx64,
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
+        if (htifstate->env->mfromhost == 0x0) {
+            qemu_irq_lower(htifstate->irq);
+        }
+        htifstate->fromhost_inprogress = 0;
+    } else {
+        qemu_log("Invalid htif write: address %016" PRIx64,
+            (uint64_t)addr);
+    }
+}
+
+static const MemoryRegionOps htif_mm_ops = {
+    .read = htif_mm_read,
+    .write = htif_mm_write,
+};
+
+HTIFState *htif_mm_init(MemoryRegion *address_space,
+    const char *kernel_filename, qemu_irq irq, MemoryRegion *main_mem,
+    CPURISCVState *env, Chardev *chr)
+{
+    uint64_t fromhost_addr = 0, tohost_addr = 0;
+
+    /* get fromhost/tohost addresses from the ELF, as spike/fesvr do */
+    if (kernel_filename) {
+#if defined(TARGET_RISCV64)
+        Elf_obj64 *e = elf_open64(kernel_filename);
+#else
+        Elf_obj32 *e = elf_open32(kernel_filename);
+#endif
+
+        const char *fromhost = "fromhost";
+        const char *tohost = "tohost";
+
+#if defined(TARGET_RISCV64)
+        Elf64_Sym *curr_sym = elf_firstsym64(e);
+#else
+        Elf32_Sym *curr_sym = elf_firstsym32(e);
+#endif
+        while (curr_sym) {
+#if defined(TARGET_RISCV64)
+            char *symname = elf_symname64(e, curr_sym);
+#else
+            char *symname = elf_symname32(e, curr_sym);
+#endif
+
+            if (strcmp(fromhost, symname) == 0) {
+                /* get fromhost addr */
+                fromhost_addr = curr_sym->st_value;
+                if (curr_sym->st_size != 8) {
+                    error_report("HTIF fromhost must be 8 bytes");
+                    exit(1);
+                }
+            } else if (strcmp(tohost, symname) == 0) {
+                /* get tohost addr */
+                tohost_addr = curr_sym->st_value;
+                if (curr_sym->st_size != 8) {
+                    error_report("HTIF tohost must be 8 bytes");
+                    exit(1);
+                }
+            }
+#if defined(TARGET_RISCV64)
+            curr_sym = elf_nextsym64(e, curr_sym);
+#else
+            curr_sym = elf_nextsym32(e, curr_sym);
+#endif
+        }
+
+#if defined(TARGET_RISCV64)
+        elf_close64(e);
+#else
+        elf_close32(e);
+#endif
+    }
+
+    uint64_t base = MIN(tohost_addr, fromhost_addr);
+    uint64_t size = MAX(tohost_addr + 8, fromhost_addr + 8) - base;
+    uint64_t tohost_offset = tohost_addr - base;
+    uint64_t fromhost_offset = fromhost_addr - base;
+
+    HTIFState *s = g_malloc0(sizeof(HTIFState));
+    s->irq = irq;
+    s->address_space = address_space;
+    s->main_mem = main_mem;
+    s->main_mem_ram_ptr = memory_region_get_ram_ptr(main_mem);
+    s->env = env;
+    s->tohost_offset = tohost_offset;
+    s->fromhost_offset = fromhost_offset;
+    s->pending_read = 0;
+    s->allow_tohost = 0;
+    s->fromhost_inprogress = 0;
+#ifdef ENABLE_CHARDEV
+    qemu_chr_fe_init(&s->chr, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
+        htif_be_change, s, NULL, true);
+#endif
+    if (base) {
+        memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
+                            TYPE_HTIF_UART, size);
+        memory_region_add_subregion(address_space, base, &s->mmio);
+    }
+
+    return s;
+}
diff --git a/include/hw/riscv/riscv_elf.h b/include/hw/riscv/riscv_elf.h
new file mode 100644
index 0000000..5771829
--- /dev/null
+++ b/include/hw/riscv/riscv_elf.h
@@ -0,0 +1,69 @@
+/*
+ * elf.h - A package for manipulating Elf binaries
+ *
+ * Taken from:
+ * https://www.cs.cmu.edu/afs/cs.cmu.edu/academic/class/15213-f03/www/ftrace/
+ * elf.h
+ *
+ */
+
+#ifndef ELF_H
+#define ELF_H
+
+#include <stdint.h>
+#include <elf.h>
+
+/*
+ * This is a handle that is created by elf_open and then used by every
+ * other function in the elf package
+*/
+typedef struct {
+    void *maddr;            /* Start of mapped Elf binary segment in memory */
+    int mlen;               /* Length in bytes of the mapped Elf segment */
+    Elf64_Ehdr *ehdr;       /* Start of main Elf header (same as maddr) */
+    Elf64_Sym *symtab;      /* Start of symbol table */
+    Elf64_Sym *symtab_end;  /* End of symbol table (symtab + size) */
+    char *strtab;           /* Address of string table */
+    Elf64_Sym *dsymtab;     /* Start of dynamic symbol table */
+    Elf64_Sym *dsymtab_end; /* End of dynamic symbol table (dsymtab + size) */
+    char *dstrtab;          /* Address of dynamic string table */
+} Elf_obj64;
+
+typedef struct {
+    void *maddr;            /* Start of mapped Elf binary segment in memory */
+    int mlen;               /* Length in bytes of the mapped Elf segment */
+    Elf32_Ehdr *ehdr;       /* Start of main Elf header (same as maddr) */
+    Elf32_Sym *symtab;      /* Start of symbol table */
+    Elf32_Sym *symtab_end;  /* End of symbol table (symtab + size) */
+    char *strtab;           /* Address of string table */
+    Elf32_Sym *dsymtab;     /* Start of dynamic symbol table */
+    Elf32_Sym *dsymtab_end; /* End of dynamic symbol table (dsymtab + size) */
+    char *dstrtab;          /* Address of dynamic string table */
+} Elf_obj32;
+
+/*
+ * Create and destroy Elf object handles
+ */
+Elf_obj64 *elf_open64(const char *filename);
+Elf_obj32 *elf_open32(const char *filename);
+
+void elf_close64(Elf_obj64 *ep);
+void elf_close32(Elf_obj32 *ep);
+
+/*
+ * Functions for manipulating static symbols
+ */
+
+/* Returns pointer to the first symbol */
+Elf64_Sym *elf_firstsym64(Elf_obj64 *ep);
+Elf32_Sym *elf_firstsym32(Elf_obj32 *ep);
+
+/* Returns pointer to the next symbol, or NULL if no more symbols */
+Elf64_Sym *elf_nextsym64(Elf_obj64 *ep, Elf64_Sym *sym);
+Elf32_Sym *elf_nextsym32(Elf_obj32 *ep, Elf32_Sym *sym);
+
+/* Return symbol string name */
+char *elf_symname64(Elf_obj64 *ep, Elf64_Sym *sym);
+char *elf_symname32(Elf_obj32 *ep, Elf32_Sym *sym);
+
+#endif
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.h
new file mode 100644
index 0000000..d37291d
--- /dev/null
+++ b/include/hw/riscv/riscv_htif.h
@@ -0,0 +1,62 @@
+/*
+ * QEMU RISCV Host Target Interface (HTIF) Emulation
+ *
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
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
+    qemu_irq irq; /* host interrupt line */
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
+/* legacy pre qom */
+HTIFState *htif_mm_init(MemoryRegion *address_space,
+    const char *kernel_filename, qemu_irq irq, MemoryRegion *main_mem,
+    CPURISCVState *env, Chardev *chr);
+
+#endif
-- 
2.7.0
