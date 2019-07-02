Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D2C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACD22146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACD22146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHh7-0005MU-Ep
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiHeJ-00035o-PG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiHeH-0007is-P2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:12:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiHeF-0006mm-3Q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:12:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A037DA3B75;
 Tue,  2 Jul 2019 12:11:56 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57C3D78367;
 Tue,  2 Jul 2019 12:11:53 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, maran.wilson@oracle.com,
 sgarzare@redhat.com, kraxel@redhat.com
Date: Tue,  2 Jul 2019 14:11:05 +0200
Message-Id: <20190702121106.28374-4-slp@redhat.com>
In-Reply-To: <20190702121106.28374-1-slp@redhat.com>
References: <20190702121106.28374-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 02 Jul 2019 12:11:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/4] hw/i386: Factorize PVH related functions
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
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract PVH related functions from pc.c, and put them in pvh.c, so
they can be shared with other components.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/Makefile.objs |   1 +
 hw/i386/pc.c          | 120 +++++-------------------------------------
 hw/i386/pvh.c         | 113 +++++++++++++++++++++++++++++++++++++++
 hw/i386/pvh.h         |  10 ++++
 4 files changed, 136 insertions(+), 108 deletions(-)
 create mode 100644 hw/i386/pvh.c
 create mode 100644 hw/i386/pvh.h

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 5d9c9efd5f..c5f20bbd72 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-y +=3D multiboot.o
+obj-y +=3D pvh.o
 obj-y +=3D pc.o
 obj-$(CONFIG_I440FX) +=3D pc_piix.o
 obj-$(CONFIG_Q35) +=3D pc_q35.o
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3983621f1c..325ec2c1c8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -42,6 +42,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "multiboot.h"
+#include "pvh.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
@@ -108,9 +109,6 @@ static struct e820_entry *e820_table;
 static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
-/* Physical Address of PVH entry point read from kernel ELF NOTE */
-static size_t pvh_start_addr;
-
 GlobalProperty pc_compat_4_0[] =3D {};
 const size_t pc_compat_4_0_len =3D G_N_ELEMENTS(pc_compat_4_0);
=20
@@ -1061,109 +1059,6 @@ struct setup_data {
     uint8_t data[0];
 } __attribute__((packed));
=20
-
-/*
- * The entry point into the kernel for PVH boot is different from
- * the native entry point.  The PVH entry is defined by the x86/HVM
- * direct boot ABI and is available in an ELFNOTE in the kernel binary.
- *
- * This function is passed to load_elf() when it is called from
- * load_elfboot() which then additionally checks for an ELF Note of
- * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
- * parse the PVH entry address from the ELF Note.
- *
- * Due to trickery in elf_opts.h, load_elf() is actually available as
- * load_elf32() or load_elf64() and this routine needs to be able
- * to deal with being called as 32 or 64 bit.
- *
- * The address of the PVH entry point is saved to the 'pvh_start_addr'
- * global variable.  (although the entry point is 32-bit, the kernel
- * binary can be either 32-bit or 64-bit).
- */
-static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
-{
-    size_t *elf_note_data_addr;
-
-    /* Check if ELF Note header passed in is valid */
-    if (arg1 =3D=3D NULL) {
-        return 0;
-    }
-
-    if (is64) {
-        struct elf64_note *nhdr64 =3D (struct elf64_note *)arg1;
-        uint64_t nhdr_size64 =3D sizeof(struct elf64_note);
-        uint64_t phdr_align =3D *(uint64_t *)arg2;
-        uint64_t nhdr_namesz =3D nhdr64->n_namesz;
-
-        elf_note_data_addr =3D
-            ((void *)nhdr64) + nhdr_size64 +
-            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-    } else {
-        struct elf32_note *nhdr32 =3D (struct elf32_note *)arg1;
-        uint32_t nhdr_size32 =3D sizeof(struct elf32_note);
-        uint32_t phdr_align =3D *(uint32_t *)arg2;
-        uint32_t nhdr_namesz =3D nhdr32->n_namesz;
-
-        elf_note_data_addr =3D
-            ((void *)nhdr32) + nhdr_size32 +
-            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-    }
-
-    pvh_start_addr =3D *elf_note_data_addr;
-
-    return pvh_start_addr;
-}
-
-static bool load_elfboot(const char *kernel_filename,
-                   int kernel_file_size,
-                   uint8_t *header,
-                   size_t pvh_xen_start_addr,
-                   FWCfgState *fw_cfg)
-{
-    uint32_t flags =3D 0;
-    uint32_t mh_load_addr =3D 0;
-    uint32_t elf_kernel_size =3D 0;
-    uint64_t elf_entry;
-    uint64_t elf_low, elf_high;
-    int kernel_size;
-
-    if (ldl_p(header) !=3D 0x464c457f) {
-        return false; /* no elfboot */
-    }
-
-    bool elf_is64 =3D header[EI_CLASS] =3D=3D ELFCLASS64;
-    flags =3D elf_is64 ?
-        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flag=
s;
-
-    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
-        error_report("elfboot unsupported flags =3D %x", flags);
-        exit(1);
-    }
-
-    uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;
-    kernel_size =3D load_elf(kernel_filename, read_pvh_start_addr,
-                           NULL, &elf_note_type, &elf_entry,
-                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
-                           0, 0);
-
-    if (kernel_size < 0) {
-        error_report("Error while loading elf kernel");
-        exit(1);
-    }
-    mh_load_addr =3D elf_low;
-    elf_kernel_size =3D elf_high - elf_low;
-
-    if (pvh_start_addr =3D=3D 0) {
-        error_report("Error loading uncompressed kernel without PVH ELF =
Note");
-        exit(1);
-    }
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
-
-    return true;
-}
-
 static void load_linux(PCMachineState *pcms,
                        FWCfgState *fw_cfg)
 {
@@ -1203,6 +1098,9 @@ static void load_linux(PCMachineState *pcms,
     if (ldl_p(header+0x202) =3D=3D 0x53726448) {
         protocol =3D lduw_p(header+0x206);
     } else {
+        size_t pvh_start_addr;
+        uint32_t mh_load_addr =3D 0;
+        uint32_t elf_kernel_size =3D 0;
         /*
          * This could be a multiboot kernel. If it is, let's stop treati=
ng it
          * like a Linux kernel.
@@ -1220,10 +1118,16 @@ static void load_linux(PCMachineState *pcms,
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
         if (pcmc->pvh_enabled &&
-            load_elfboot(kernel_filename, kernel_size,
-                         header, pvh_start_addr, fw_cfg)) {
+            pvh_load_elfboot(kernel_filename,
+                             &mh_load_addr, &elf_kernel_size)) {
             fclose(f);
=20
+            pvh_start_addr =3D pvh_get_start_addr();
+
+            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
+            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
+            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
+
             fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
                 strlen(kernel_cmdline) + 1);
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdlin=
e);
diff --git a/hw/i386/pvh.c b/hw/i386/pvh.c
new file mode 100644
index 0000000000..61623b4533
--- /dev/null
+++ b/hw/i386/pvh.c
@@ -0,0 +1,113 @@
+/*
+ * PVH Boot Helper
+ *
+ * Copyright (C) 2019 Oracle
+ * Copyright (C) 2019 Red Hat, Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "hw/loader.h"
+#include "cpu.h"
+#include "elf.h"
+#include "pvh.h"
+
+static size_t pvh_start_addr =3D 0;
+
+size_t pvh_get_start_addr(void)
+{
+    return pvh_start_addr;
+}
+
+/*
+ * The entry point into the kernel for PVH boot is different from
+ * the native entry point.  The PVH entry is defined by the x86/HVM
+ * direct boot ABI and is available in an ELFNOTE in the kernel binary.
+ *
+ * This function is passed to load_elf() when it is called from
+ * load_elfboot() which then additionally checks for an ELF Note of
+ * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
+ * parse the PVH entry address from the ELF Note.
+ *
+ * Due to trickery in elf_opts.h, load_elf() is actually available as
+ * load_elf32() or load_elf64() and this routine needs to be able
+ * to deal with being called as 32 or 64 bit.
+ *
+ * The address of the PVH entry point is saved to the 'pvh_start_addr'
+ * global variable.  (although the entry point is 32-bit, the kernel
+ * binary can be either 32-bit or 64-bit).
+ */
+
+static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
+{
+    size_t *elf_note_data_addr;
+
+    /* Check if ELF Note header passed in is valid */
+    if (arg1 =3D=3D NULL) {
+        return 0;
+    }
+
+    if (is64) {
+        struct elf64_note *nhdr64 =3D (struct elf64_note *)arg1;
+        uint64_t nhdr_size64 =3D sizeof(struct elf64_note);
+        uint64_t phdr_align =3D *(uint64_t *)arg2;
+        uint64_t nhdr_namesz =3D nhdr64->n_namesz;
+
+        elf_note_data_addr =3D
+            ((void *)nhdr64) + nhdr_size64 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+    } else {
+        struct elf32_note *nhdr32 =3D (struct elf32_note *)arg1;
+        uint32_t nhdr_size32 =3D sizeof(struct elf32_note);
+        uint32_t phdr_align =3D *(uint32_t *)arg2;
+        uint32_t nhdr_namesz =3D nhdr32->n_namesz;
+
+        elf_note_data_addr =3D
+            ((void *)nhdr32) + nhdr_size32 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+    }
+
+    pvh_start_addr =3D *elf_note_data_addr;
+
+    return pvh_start_addr;
+}
+
+bool pvh_load_elfboot(const char *kernel_filename,
+                      uint32_t *mh_load_addr,
+                      uint32_t *elf_kernel_size)
+{
+    uint64_t elf_entry;
+    uint64_t elf_low, elf_high;
+    int kernel_size;
+    uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;
+
+    kernel_size =3D load_elf(kernel_filename, read_pvh_start_addr,
+                           NULL, &elf_note_type, &elf_entry,
+                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                           0, 0);
+
+    if (kernel_size < 0) {
+        error_report("Error while loading elf kernel");
+        return false;
+    }
+
+    if (pvh_start_addr =3D=3D 0) {
+        error_report("Error loading uncompressed kernel without PVH ELF =
Note");
+        return false;
+    }
+
+    if (mh_load_addr) {
+        *mh_load_addr =3D elf_low;
+    }
+
+    if (elf_kernel_size) {
+        *elf_kernel_size =3D elf_high - elf_low;
+    }
+
+    return true;
+}
diff --git a/hw/i386/pvh.h b/hw/i386/pvh.h
new file mode 100644
index 0000000000..ada67ff6e8
--- /dev/null
+++ b/hw/i386/pvh.h
@@ -0,0 +1,10 @@
+#ifndef HW_I386_PVH_H
+#define HW_I386_PVH_H
+
+size_t pvh_get_start_addr(void);
+
+bool pvh_load_elfboot(const char *kernel_filename,
+                      uint32_t *mh_load_addr,
+                      uint32_t *elf_kernel_size);
+
+#endif
--=20
2.21.0


