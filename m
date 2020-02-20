Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EEEC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6558120801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6558120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4f9h-0001FI-Is
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 01:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1j4f8c-0007wP-26
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1j4f8Y-00058A-IC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:16:41 -0500
Received: from [107.174.27.60] (port=52534 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1j4f8Y-00057Q-61; Thu, 20 Feb 2020 01:16:38 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 42C2DAE80017;
 Thu, 20 Feb 2020 01:15:04 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v7 5/5] spapr/vof: Add basic support for MBR/GPT/GRUB
Date: Thu, 20 Feb 2020 17:16:22 +1100
Message-Id: <20200220061622.15064-6-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220061622.15064-1-aik@ozlabs.ru>
References: <20200220061622.15064-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This hooks up disks to block backends so vof.bin can read MBR/GPT,
find a bootloader and run it. This bypasses the device drivers
and goes straight to the backend.

This implements basic support for 32bit big endian bootloader;
tested on GRUB.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 pc-bios/vof/Makefile     |   2 +-
 pc-bios/vof/vof.h        |  15 +++
 hw/ppc/spapr_of_client.c |  64 +++++++++
 pc-bios/vof/bootblock.c  | 242 ++++++++++++++++++++++++++++++++++
 pc-bios/vof/ci.c         |  11 ++
 pc-bios/vof/elf32.c      | 273 +++++++++++++++++++++++++++++++++++++++
 pc-bios/vof/main.c       |   1 +
 hw/ppc/trace-events      |   4 +
 pc-bios/vof.bin          | Bin 4272 -> 9180 bytes
 9 files changed, 611 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/vof/bootblock.c
 create mode 100644 pc-bios/vof/elf32.c

diff --git a/pc-bios/vof/Makefile b/pc-bios/vof/Makefile
index 49f7e240eeff..7e4227bb2cc6 100644
--- a/pc-bios/vof/Makefile
+++ b/pc-bios/vof/Makefile
@@ -8,7 +8,7 @@ build-all: vof.bin
 %.o: %.c
 	cc -m32 -mbig-endian -c -fno-stack-protector -Wno-builtin-declaration-mismatch -o $@ $<
 
-vof.elf: entry.o main.o libc.o ci.o bootmem.o
+vof.elf: entry.o main.o libc.o ci.o bootmem.o bootblock.o elf32.o
 	ld -nostdlib -e_start -Tl.lds -EB -o $@ $^
 
 %.bin: %.elf
diff --git a/pc-bios/vof/vof.h b/pc-bios/vof/vof.h
index 738b2539aa19..b16270b289b7 100644
--- a/pc-bios/vof/vof.h
+++ b/pc-bios/vof/vof.h
@@ -37,6 +37,8 @@ phandle ci_finddevice(const char *path);
 uint32_t ci_getprop(phandle ph, const char *propname, void *prop, int len);
 ihandle ci_open(const char *path);
 void ci_close(ihandle ih);
+uint32_t ci_block_size(ihandle ih);
+uint32_t ci_seek(ihandle ih, uint64_t offset);
 uint32_t ci_read(ihandle ih, void *buf, int len);
 uint32_t ci_write(ihandle ih, const void *buf, int len);
 void ci_stdout(const char *buf);
@@ -44,5 +46,18 @@ void ci_stdoutn(const char *buf, int len);
 void *ci_claim(void *virt, uint32_t size, uint32_t align);
 uint32_t ci_release(void *virt, uint32_t size);
 
+/* ELF */
+int elf_load_file(void *file_addr, uint32_t *entry,
+                  int (*pre_load)(void*, long),
+                  void (*post_load)(void*, long));
+
+/* booting from blockdev */
+void boot_block(void);
+
 /* booting from -kernel */
 void boot_from_memory(uint64_t initrd, uint64_t initrdsize);
+
+/* bswap */
+#define le16_to_cpu(x) __builtin_bswap16(x)
+#define le32_to_cpu(x) __builtin_bswap32(x)
+#define le64_to_cpu(x) __builtin_bswap64(x)
diff --git a/hw/ppc/spapr_of_client.c b/hw/ppc/spapr_of_client.c
index 4c476e138e60..a36b32487349 100644
--- a/hw/ppc/spapr_of_client.c
+++ b/hw/ppc/spapr_of_client.c
@@ -43,6 +43,9 @@ typedef struct {
 typedef struct {
     DeviceState *dev;
     CharBackend *cbe;
+    BlockBackend *blk;
+    uint64_t blk_pos;
+    uint16_t blk_physical_block_size;
     char *params;
     char *path; /* the path used to open the instance */
     uint32_t phandle;
@@ -494,6 +497,8 @@ static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
     if (inst->dev) {
         const char *cdevstr = object_property_get_str(OBJECT(inst->dev),
                                                       "chardev", NULL);
+        const char *blkstr = object_property_get_str(OBJECT(inst->dev),
+                                                     "drive", NULL);
 
         if (cdevstr) {
             Chardev *cdev = qemu_chr_find(cdevstr);
@@ -501,6 +506,13 @@ static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
             if (cdev) {
                 inst->cbe = cdev->be;
             }
+        } else if (blkstr) {
+            BlockConf conf = { 0 };
+
+            inst->blk = blk_by_name(blkstr);
+            conf.blk = inst->blk;
+            blkconf_blocksizes(&conf);
+            inst->blk_physical_block_size = conf.physical_block_size;
         }
     }
 
@@ -602,6 +614,8 @@ static uint32_t of_client_write(SpaprMachineState *spapr, uint32_t ihandle,
             if (inst->cbe) {
                 toprint = qemu_chr_fe_write_all(inst->cbe, (uint8_t *) tmp,
                                                 toprint);
+            } else if (inst->blk) {
+                trace_spapr_of_client_blk_write(ihandle, len);
             }
         } else {
             /* We normally open stdout so this is fallback */
@@ -636,6 +650,17 @@ static uint32_t of_client_read(SpaprMachineState *spapr, uint32_t ihandle,
                 SpaprVioDevice *sdev = VIO_SPAPR_DEVICE(inst->dev);
 
                 ret = vty_getchars(sdev, buf, len); /* qemu_chr_fe_read_all? */
+            } else if (inst->blk) {
+                int rc = blk_pread(inst->blk, inst->blk_pos, buf, len);
+
+                if (rc > 0) {
+                    ret = rc;
+                }
+                trace_spapr_of_client_blk_read(ihandle, inst->blk_pos, len,
+                                               ret);
+                if (rc > 0) {
+                    inst->blk_pos += rc;
+                }
             }
         }
     }
@@ -643,6 +668,25 @@ static uint32_t of_client_read(SpaprMachineState *spapr, uint32_t ihandle,
     return ret;
 }
 
+static uint32_t of_client_seek(SpaprMachineState *spapr, uint32_t ihandle,
+                               uint32_t hi, uint32_t lo)
+{
+    uint32_t ret = -1;
+    uint64_t pos = ((uint64_t) hi << 32) | lo;
+    SpaprOfInstance *inst = (SpaprOfInstance *)
+        g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihandle));
+
+    if (inst) {
+        if (inst->blk) {
+            inst->blk_pos = pos;
+            ret = 1;
+            trace_spapr_of_client_blk_seek(ihandle, pos, ret);
+        }
+    }
+
+    return ret;
+}
+
 static void of_client_clamed_dump(GArray *claimed)
 {
 #ifdef DEBUG
@@ -797,6 +841,20 @@ static uint32_t of_client_call_method(SpaprMachineState *spapr,
             /* do not bother about colors now */
             ret = 0;
         }
+    } else if (inst->blk) {
+        if (strcmp(method, "block-size") == 0) {
+            ret = 0;
+            *ret2 = inst->blk_physical_block_size;
+        } else if (strcmp(method, "#blocks") == 0) {
+            ret = 0;
+            *ret2 = blk_getlength(inst->blk) / inst->blk_physical_block_size;
+        }
+     } else if (inst->dev) {
+        if (strcmp(method, "vscsi-report-luns") == 0) {
+            /* TODO: Not implemented yet, not clear when it is really needed */
+            ret = -1;
+            *ret2 = 1;
+        }
     } else {
         trace_spapr_of_client_error_unknown_method(method);
     }
@@ -934,6 +992,12 @@ static target_ulong spapr_h_of_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            be32_to_cpu(pargs.args[0]),
                            be32_to_cpu(pargs.args[1]),
                            be32_to_cpu(pargs.args[2]));
+    } else if (cmpserv("seek", 3, 1)) {
+        pargs.args[nargs] =
+            of_client_seek(spapr,
+                           be32_to_cpu(pargs.args[0]),
+                           be32_to_cpu(pargs.args[1]),
+                           be32_to_cpu(pargs.args[2]));
     } else if (cmpserv("claim", 3, 1)) {
         pargs.args[nargs] =
             of_client_claim(spapr,
diff --git a/pc-bios/vof/bootblock.c b/pc-bios/vof/bootblock.c
new file mode 100644
index 000000000000..cbf585746734
--- /dev/null
+++ b/pc-bios/vof/bootblock.c
@@ -0,0 +1,242 @@
+#include "vof.h"
+
+#define UUID_FMT_LEN 36
+#define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
+                 "%02hhx%02hhx-%02hhx%02hhx-" \
+                 "%02hhx%02hhx-" \
+                 "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
+
+typedef struct {
+    union {
+        unsigned char data[16];
+        struct {
+            /* Generated in BE endian, can be swapped with qemu_uuid_bswap. */
+            uint32_t time_low;
+            uint16_t time_mid;
+            uint16_t time_high_and_version;
+            uint8_t  clock_seq_and_reserved;
+            uint8_t  clock_seq_low;
+	    uint8_t  node[6];
+	} fields;
+    };
+} UUID;
+
+struct gpt_header {
+	char signature[8];
+	char revision[4];
+	uint32_t header_size;
+	uint32_t crc;
+	uint32_t reserved;
+	uint64_t current_lba;
+	uint64_t backup_lba;
+	uint64_t first_usable_lba;
+	uint64_t last_usable_lba;
+	char guid[16];
+	uint64_t partition_entries_lba;
+	uint32_t nr_partition_entries;
+	uint32_t size_partition_entry;
+	uint32_t crc_partitions;
+};
+
+#define GPT_SIGNATURE "EFI PART"
+#define GPT_REVISION "\0\0\1\0" /* revision 1.0 */
+
+struct gpt_entry {
+	char partition_type_guid[16];
+	char unique_guid[16];
+	uint64_t first_lba;
+	uint64_t last_lba;
+	uint64_t attributes;
+	char name[72];                /* UTF-16LE */
+};
+
+#define GPT_MIN_PARTITIONS 128
+#define GPT_PT_ENTRY_SIZE 128
+#define SECTOR_SIZE 512
+
+static int find_prep_partition_on_gpt(ihandle blk, uint8_t *lba01,
+		uint64_t *offset, uint64_t *size)
+{
+	unsigned long i, partnum, partentrysize;
+	int ret;
+	struct gpt_header *hdr = (struct gpt_header *) (lba01 + SECTOR_SIZE);
+	UUID prep_uuid = { .fields =
+			{ 0x9e1a2d38, 0xc612, 0x4316, 0xaa, 0x26,
+			{ 0x8b, 0x49, 0x52, 0x1e, 0x5a, 0x8b} } };
+
+	if (memcmp(hdr, "EFI PART", 8))
+		return -1;
+
+	partnum = le32_to_cpu(hdr->nr_partition_entries);
+	partentrysize = le32_to_cpu(hdr->size_partition_entry);
+
+	if (partentrysize < 128 || partentrysize > 512) {
+		return -1;
+	}
+
+	for (i = 0; i < partnum; ++i) {
+		uint8_t partdata[partentrysize];
+		struct gpt_entry *entry = (struct gpt_entry *) partdata;
+		uint64_t first, last;
+		UUID parttype;
+		char uuid[UUID_FMT_LEN + 1];
+
+		ci_seek(blk, 2 * SECTOR_SIZE + i * partentrysize);
+		ret = ci_read(blk, partdata, sizeof(partdata));
+		if (ret < 0)
+			return ret;
+		else if (!ret)
+			return -1;
+
+		memcpy(parttype.data, entry->partition_type_guid, 16);
+		first = le64_to_cpu(entry->first_lba);
+		last = le64_to_cpu(entry->last_lba);
+
+		if (!memcmp(&parttype, &prep_uuid, sizeof(parttype))) {
+			*offset = first * SECTOR_SIZE;
+			*size = (last - first) * SECTOR_SIZE;
+		}
+	}
+
+	if (*offset)
+		return 0;
+
+	return -1;
+}
+
+struct partition_record {
+	uint8_t bootable;
+	uint8_t start_head;
+	uint32_t start_cylinder;
+	uint8_t start_sector;
+	uint8_t system;
+	uint8_t end_head;
+	uint8_t end_cylinder;
+	uint8_t end_sector;
+	uint32_t start_sector_abs;
+	uint32_t nb_sectors_abs;
+};
+
+static void read_partition(uint8_t *p, struct partition_record *r)
+{
+	r->bootable = p[0];
+	r->start_head = p[1];
+	r->start_cylinder = p[3] | ((p[2] << 2) & 0x0300);
+	r->start_sector = p[2] & 0x3f;
+	r->system = p[4];
+	r->end_head = p[5];
+	r->end_cylinder = p[7] | ((p[6] << 2) & 0x300);
+	r->end_sector = p[6] & 0x3f;
+	r->start_sector_abs = le32_to_cpu(*(uint32_t *)(p + 8));
+	r->nb_sectors_abs   = le32_to_cpu(*(uint32_t *)(p + 12));
+}
+
+static int find_prep_partition(ihandle blk, uint64_t *offset, uint64_t *size)
+{
+	uint8_t lba01[SECTOR_SIZE * 2];
+	int i;
+	int ret = -1;
+
+	ci_seek(blk, 0);
+	ret = ci_read(blk, lba01, sizeof(lba01));
+	if (ret < 0)
+		return ret;
+
+	if (lba01[510] != 0x55 || lba01[511] != 0xaa)
+		return find_prep_partition_on_gpt(blk, lba01, offset, size);
+
+	for (i = 0; i < 4; i++) {
+		struct partition_record part;
+
+		read_partition(&lba01[446 + 16 * i], &part);
+
+		if (!part.system || !part.nb_sectors_abs) {
+			continue;
+		}
+
+		/* 0xEE == GPT */
+		if (part.system == 0xEE) {
+			ret = find_prep_partition_on_gpt(blk, lba01, offset, size);
+		}
+		/* 0x41 == PReP */
+		if (part.system == 0x41) {
+			*offset = part.start_sector_abs;
+			*offset <<= 9;
+			*size = (uint64_t)part.nb_sectors_abs << 9;
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+static int elf_pre_load(void *destaddr, long size)
+{
+	void *ret = ci_claim(destaddr, size, 0);
+
+	return (ret == destaddr) ? 0 : -1;
+}
+
+static void try_boot_block_device(ihandle blk, const char *path)
+{
+	uint32_t rc, elf_addr = 0;
+	uint64_t offset = 0, size = 0;
+	void *grub;
+	int ret;
+
+	if (find_prep_partition(blk, &offset, &size))
+		return;
+
+	grub = ci_claim((void*)0x20000000, size, 0);
+	if (!grub)
+		return;
+
+	ci_seek(blk, offset);
+	rc = ci_read(blk, grub, size);
+	if (rc <= 0) {
+		ci_release(grub, size);
+		return;
+	}
+
+	ret = elf_load_file(grub, &elf_addr, elf_pre_load, NULL);
+	ci_release(grub, size);
+	if (ret < 0)
+		return;
+
+    ci_stdout("** Booting from ");
+    ci_stdout(path);
+    ci_stdout("\n");
+	do_boot(elf_addr, 0, 0);
+}
+
+void boot_block(void)
+{
+	char bootlist[2048], *cur, *next;
+	uint32_t cb, blk;
+	phandle chosen = ci_finddevice("/chosen");
+
+	cb = ci_getprop(chosen, "qemu,boot-list", bootlist,
+			sizeof(bootlist) - 1);
+	bootlist[sizeof(bootlist) - 1] = '\0';
+
+	if (strlen(bootlist) == 0)
+		return;
+
+	for (cur = bootlist; cb > 0; cur = next + 1) {
+		for (next = cur; cb > 0; --cb) {
+			if (*next == '\n') {
+				*next = '\0';
+				++next;
+				--cb;
+				break;
+			}
+		}
+
+		blk = ci_open(cur);
+		if (!blk)
+			continue;
+
+		try_boot_block_device(blk, cur);
+		ci_close(blk);
+	}
+}
diff --git a/pc-bios/vof/ci.c b/pc-bios/vof/ci.c
index 143676421984..584776b2ff5b 100644
--- a/pc-bios/vof/ci.c
+++ b/pc-bios/vof/ci.c
@@ -96,6 +96,17 @@ void ci_close(ihandle ih)
 	call_prom("close", 1, 0, ih);
 }
 
+uint32_t ci_block_size(ihandle ih)
+{
+	return 512;
+}
+
+uint32_t ci_seek(ihandle ih, uint64_t offset)
+{
+	return call_prom("seek", 3, 1, ih, (prom_arg_t)(offset >> 32),
+			(prom_arg_t)(offset & 0xFFFFFFFFUL));
+}
+
 uint32_t ci_read(ihandle ih, void *buf, int len)
 {
 	return call_prom("read", 3, 1, ih, buf, len);
diff --git a/pc-bios/vof/elf32.c b/pc-bios/vof/elf32.c
new file mode 100644
index 000000000000..8e0623557d3f
--- /dev/null
+++ b/pc-bios/vof/elf32.c
@@ -0,0 +1,273 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2011 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+/*
+ * 32-bit ELF loader
+ */
+#include "vof.h"
+
+/* ELF object file types */
+#define ET_NONE		0	/* No file type */
+#define ET_REL		1	/* Relocatable file */
+#define ET_EXEC		2	/* Executable file */
+#define ET_DYN		3	/* Shared object file */
+#define ET_CORE		4	/* Core file */
+
+/* ELF object endian */
+#define ELFDATA2LSB	1	/* 2's complement, little endian */
+#define ELFDATA2MSB	2	/* 2's complement, big endian */
+
+struct ehdr32 {
+	uint32_t ei_ident;
+	uint8_t ei_class;
+	uint8_t ei_data;
+	uint8_t ei_version;
+	uint8_t ei_pad[9];
+	uint16_t e_type;
+	uint16_t e_machine;
+	uint32_t e_version;
+	uint32_t e_entry;
+	uint32_t e_phoff;
+	uint32_t e_shoff;
+	uint32_t e_flags;
+	uint16_t e_ehsize;
+	uint16_t e_phentsize;
+	uint16_t e_phnum;
+	uint16_t e_shentsize;
+	uint16_t e_shnum;
+	uint16_t e_shstrndx;
+};
+
+struct phdr32 {
+	uint32_t p_type;
+	uint32_t p_offset;
+	uint32_t p_vaddr;
+	uint32_t p_paddr;
+	uint32_t p_filesz;
+	uint32_t p_memsz;
+	uint32_t p_flags;
+	uint32_t p_align;
+};
+
+static inline void bswap_16p (uint16_t *x)
+{
+        *x = __builtin_bswap16(*x);
+}
+
+static inline void bswap_32p (uint32_t *x)
+{
+        *x = __builtin_bswap32(*x);
+}
+
+static inline void bswap_64p (uint64_t *x)
+{
+        *x = __builtin_bswap64(*x);
+}
+
+static struct phdr32*
+get_phdr32(void *file_addr)
+{
+	return (struct phdr32 *) (((unsigned char *)file_addr)
+		+ ((struct ehdr32 *)file_addr)->e_phoff);
+}
+
+static void
+load_segment(void *file_addr, struct phdr32 *phdr, signed long offset,
+             int (*pre_load)(void*, long),
+             void (*post_load)(void*, long))
+{
+	unsigned long src = phdr->p_offset + (unsigned long) file_addr;
+	unsigned long destaddr;
+
+	destaddr = (unsigned long)phdr->p_paddr;
+	destaddr = destaddr + offset;
+
+	/* check if we're allowed to copy */
+	if (pre_load != NULL) {
+		if (pre_load((void*)destaddr, phdr->p_memsz) != 0)
+			return;
+	}
+
+	/* copy into storage */
+	memmove((void *)destaddr, (void *)src, phdr->p_filesz);
+
+	/* clear bss */
+	memset((void *)(destaddr + phdr->p_filesz), 0,
+	       phdr->p_memsz - phdr->p_filesz);
+
+	if (phdr->p_memsz && post_load) {
+		post_load((void*)destaddr, phdr->p_memsz);
+	}
+}
+
+unsigned int
+elf_load_segments32(void *file_addr, signed long offset,
+                    int (*pre_load)(void*, long),
+                    void (*post_load)(void*, long))
+{
+	struct ehdr32 *ehdr = (struct ehdr32 *) file_addr;
+	/* Calculate program header address */
+	struct phdr32 *phdr = get_phdr32(file_addr);
+	int i;
+
+	/* loop e_phnum times */
+	for (i = 0; i <= ehdr->e_phnum; i++) {
+		/* PT_LOAD ? */
+		if (phdr->p_type == 1) {
+			if (phdr->p_paddr != phdr->p_vaddr) {
+				return 0;
+			}
+
+			/* copy segment */
+			load_segment(file_addr, phdr, offset, pre_load,
+			             post_load);
+		}
+		/* step to next header */
+		phdr = (struct phdr32 *)(((uint8_t *)phdr) + ehdr->e_phentsize);
+	}
+
+	/* Entry point is always a virtual address, so translate it
+	 * to physical before returning it */
+	return ehdr->e_entry;
+}
+
+/**
+ * Return the base address for loading (i.e. the address of the first PT_LOAD
+ * segment)
+ * @param  file_addr	pointer to the ELF file in memory
+ * @return		the base address
+ */
+long
+elf_get_base_addr32(void *file_addr)
+{
+	struct ehdr32 *ehdr = (struct ehdr32 *) file_addr;
+	struct phdr32 *phdr = get_phdr32(file_addr);
+	int i;
+
+	/* loop e_phnum times */
+	for (i = 0; i <= ehdr->e_phnum; i++) {
+		/* PT_LOAD ? */
+		if (phdr->p_type == 1) {
+			return phdr->p_paddr;
+		}
+		/* step to next header */
+		phdr = (struct phdr32 *)(((uint8_t *)phdr) + ehdr->e_phentsize);
+	}
+
+	return 0;
+}
+
+uint32_t elf_get_eflags_32(void *file_addr)
+{
+	struct ehdr32 *ehdr = (struct ehdr32 *) file_addr;
+
+	return ehdr->e_flags;
+}
+
+void
+elf_byteswap_header32(void *file_addr)
+{
+	struct ehdr32 *ehdr = (struct ehdr32 *) file_addr;
+	struct phdr32 *phdr;
+	int i;
+
+	bswap_16p(&ehdr->e_type);
+	bswap_16p(&ehdr->e_machine);
+	bswap_32p(&ehdr->e_version);
+	bswap_32p(&ehdr->e_entry);
+	bswap_32p(&ehdr->e_phoff);
+	bswap_32p(&ehdr->e_shoff);
+	bswap_32p(&ehdr->e_flags);
+	bswap_16p(&ehdr->e_ehsize);
+	bswap_16p(&ehdr->e_phentsize);
+	bswap_16p(&ehdr->e_phnum);
+	bswap_16p(&ehdr->e_shentsize);
+	bswap_16p(&ehdr->e_shnum);
+	bswap_16p(&ehdr->e_shstrndx);
+
+	phdr = get_phdr32(file_addr);
+
+	/* loop e_phnum times */
+	for (i = 0; i <= ehdr->e_phnum; i++) {
+		bswap_32p(&phdr->p_type);
+		bswap_32p(&phdr->p_offset);
+		bswap_32p(&phdr->p_vaddr);
+		bswap_32p(&phdr->p_paddr);
+		bswap_32p(&phdr->p_filesz);
+		bswap_32p(&phdr->p_memsz);
+		bswap_32p(&phdr->p_flags);
+		bswap_32p(&phdr->p_align);
+
+		/* step to next header */
+		phdr = (struct phdr32 *)(((uint8_t *)phdr) + ehdr->e_phentsize);
+	}
+}
+
+/**
+ * elf_check_file tests if the file at file_addr is
+ * a correct endian, ELF PPC executable
+ * @param file_addr  pointer to the start of the ELF file
+ * @return           the class (1 for 32 bit, 2 for 64 bit)
+ *                   -1 if it is not an ELF file
+ *                   -2 if it has the wrong endianness
+ *                   -3 if it is not an ELF executable
+ *                   -4 if it is not for PPC
+ */
+static int
+elf_check_file(unsigned long *file_addr)
+{
+        struct ehdr32 *ehdr = (struct ehdr32 *) file_addr;
+
+        /* check if it is an ELF image at all */
+        if (ehdr->ei_ident != 0x7f454c46)
+                return -1;
+
+        if (ELFDATA2MSB != ehdr->ei_data) {
+                switch (ehdr->ei_class) {
+                case 1:
+                        elf_byteswap_header32(file_addr);
+                        break;
+                }
+        }
+
+        /* check if it is an ELF executable ... and also
+         * allow DYN files, since this is specified by ePAPR */
+        if (ehdr->e_type != ET_EXEC && ehdr->e_type != ET_DYN)
+                return -3;
+
+        /* check if it is a PPC ELF executable */
+        if (ehdr->e_machine != 0x14 && ehdr->e_machine != 0x15)
+                return -4;
+
+        return ehdr->ei_class;
+}
+
+int elf_load_file(void *file_addr, uint32_t *entry,
+              int (*pre_load)(void*, long),
+              void (*post_load)(void*, long))
+{
+        int type = elf_check_file(file_addr);
+        struct ehdr32 *ehdr = (struct ehdr32 *) file_addr;
+
+        switch (type) {
+        case 1:
+                *entry = elf_load_segments32(file_addr, 0, pre_load, post_load);
+                if (ehdr->ei_data != ELFDATA2MSB) {
+                        type = 5; /* LE32 ABIv1 */
+                }
+                break;
+        }
+        if (*entry == 0)
+                type = 0;
+
+        return type;
+}
diff --git a/pc-bios/vof/main.c b/pc-bios/vof/main.c
index eb9aa8b78a8f..d0935e78edd8 100644
--- a/pc-bios/vof/main.c
+++ b/pc-bios/vof/main.c
@@ -19,5 +19,6 @@ void entry_c(void)
 
 	ci_stdout("*** Virtual Open Firmware ***\n");
 	boot_from_memory(initrd, initrdsize);
+	boot_block();
 	ci_panic("*** No boot target ***\n");
 }
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 640d0649394d..9405d7fb2b84 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -38,6 +38,10 @@ spapr_of_client_getproplen(uint32_t ph, const char *prop, uint32_t ret) "ph=0x%x
 spapr_of_client_setprop(uint32_t ph, const char *prop, const char *val, uint32_t ret) "ph=0x%x \"%s\" [%s] => len=%d"
 spapr_of_client_open(const char *path, uint32_t ph, uint32_t ih) "%s ph=0x%x => ih=0x%x"
 spapr_of_client_interpret(const char *cmd, uint32_t param1, uint32_t param2, uint32_t ret, uint32_t ret2) "[%s] 0x%x 0x%x => 0x%x 0x%x"
+spapr_of_client_blk_write(uint32_t ih, uint32_t len) "0x%x => len=%d"
+spapr_of_client_blk_read(uint32_t ih, uint64_t pos, uint32_t len, uint32_t ret) "ih=0x%x @0x%"PRIx64" size=%d => %d"
+spapr_of_client_blk_seek(uint32_t ih, uint64_t pos, uint32_t ret) "ih=0x%x 0x%"PRIx64" => %d"
+spapr_of_client_blk_bootloader_read(uint64_t offset, uint64_t size) "0x%"PRIx64" size=0x%"PRIx64
 spapr_of_client_package_to_path(uint32_t ph, const char *tmp, uint32_t ret) "ph=0x%x => %s len=%d"
 spapr_of_client_instance_to_path(uint32_t ih, uint32_t ph, const char *tmp, uint32_t ret) "ih=0x%x ph=0x%x => %s len=%d"
 spapr_of_client_instance_to_package(uint32_t ih, uint32_t ph) "ih=0x%x => ph=0x%x"
diff --git a/pc-bios/vof.bin b/pc-bios/vof.bin
index 152d86a094ce376ee8962c3f26afeccc9e7cae58..2c6629d2c72d5d1657c5e6791c15dabbc7aecb48 100755
GIT binary patch
literal 9180
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
Y^MpskV<-9!p2Y=t@b4yz19&R`3jiY<l>h($

delta 501
zcmYk$F-Tis5C`!4PBHJr^u0$>P?1<oAPJ^6LWT%IgA{!bK@cf6ICL?jP)jHjEEMy-
z7)2fQ$t{_ZMZ}>)AdaF=B|`=~6j}(V(4j+zP&%Z9l3q|thaVhw-+lM5&6b8s4~2Ul
zOn_=M2Jm8f9~#50gXRsSGT-sYgsv3|i6rh-C@)^)-V!P3>z$D2V8|=zkr_~A5nLv?
ztg?yjPTW<>sjdZq+b4AD@Q78qcFf?mS@tXQLVTt*^^LZbv)gOTgpRk=P!qT{NQ=%S
zZt{|I9XG=i?M`B@N{8K3RCM=J$)#Z~MHeoQ8l3w$o{hJfpQ!Hi{Tpu7c{nPb|KFV4
zSmQ%|b`b`xNg1{R08e%RVg>NZbs34b{`9wlL@uCHp2@H*$Y?th_g}W((~k!UEqi^R
zHQxI5l@_&Un0-$lG@lx~&GGw&YT5!?4GQT)>eIXC3Z*$*M)wR@RsO)w8G`mXgzPH_
z^KIb#kLgq&z~(#pqL1Ov04au-{3Cg)jLa<qh&}*4&1`nePFRIq^6V8`;=0DZu{vu2
V7{C<9g;8Sshw+H{S%^hg>@Ug1pqT&w

-- 
2.17.1


