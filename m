Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D86C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8F120868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8F120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3vj-0008GC-31
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:43:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3p7-00030v-Sc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3p6-00030m-8a
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3p6-000309-0d
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 275CA30C1AFB;
	Fri, 24 May 2019 06:36:59 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C02BF5B689;
	Fri, 24 May 2019 06:36:53 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:40 +0200
Message-Id: <20190524063553.5339-8-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 24 May 2019 06:36:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/20] hw/i386/pc: Extract e820 memory layout
 code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"open list:X86" <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/Makefile.objs        |  2 +-
 hw/i386/e820_memory_layout.c | 62 +++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h | 76 ++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c                 | 64 +-----------------------------
 include/hw/i386/pc.h         | 48 -----------------------
 target/i386/kvm.c            |  1 +
 6 files changed, 141 insertions(+), 112 deletions(-)
 create mode 100644 hw/i386/e820_memory_layout.c
 create mode 100644 hw/i386/e820_memory_layout.h

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 5d9c9efd5f..d3374e0831 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_KVM) +=3D kvm/
-obj-y +=3D multiboot.o
+obj-y +=3D e820_memory_layout.o multiboot.o
 obj-y +=3D pc.o
 obj-$(CONFIG_I440FX) +=3D pc_piix.o
 obj-$(CONFIG_Q35) +=3D pc_q35.o
diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
new file mode 100644
index 0000000000..b9be08536c
--- /dev/null
+++ b/hw/i386/e820_memory_layout.c
@@ -0,0 +1,62 @@
+/*
+ * QEMU BIOS e820 routines
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "e820_memory_layout.h"
+
+static size_t e820_entries;
+struct e820_table e820_reserve;
+struct e820_entry *e820_table;
+
+ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
+{
+    unsigned int index =3D le32_to_cpu(e820_reserve.count);
+    uint32_t utype =3D (uint32_t)type;
+    struct e820_entry *entry;
+
+    if (type !=3D E820_RAM) {
+        /* old FW_CFG_E820_TABLE entry -- reservations only */
+        if (index >=3D E820_NR_ENTRIES) {
+            return -EBUSY;
+        }
+        entry =3D &e820_reserve.entry[index++];
+
+        entry->address =3D cpu_to_le64(address);
+        entry->length =3D cpu_to_le64(length);
+        entry->type =3D cpu_to_le32(utype);
+
+        e820_reserve.count =3D cpu_to_le32(index);
+    }
+
+    /* new "etc/e820" file -- include ram too */
+    e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
+    e820_table[e820_entries].address =3D cpu_to_le64(address);
+    e820_table[e820_entries].length =3D cpu_to_le64(length);
+    e820_table[e820_entries].type =3D cpu_to_le32(utype);
+    e820_entries++;
+
+    return e820_entries;
+}
+
+size_t e820_get_num_entries(void)
+{
+    return e820_entries;
+}
+
+bool e820_get_entry(unsigned int idx, E820Type type,
+                    uint64_t *address, uint64_t *length)
+{
+    uint32_t utype =3D (uint32_t)type;
+    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ut=
ype)) {
+        *address =3D le64_to_cpu(e820_table[idx].address);
+        *length =3D le64_to_cpu(e820_table[idx].length);
+        return true;
+    }
+    return false;
+}
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
new file mode 100644
index 0000000000..64e88e4772
--- /dev/null
+++ b/hw/i386/e820_memory_layout.h
@@ -0,0 +1,76 @@
+/*
+ * QEMU BIOS e820 routines
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_I386_E820_H
+#define HW_I386_E820_H
+
+/**
+ * E820Type: Type of the e820 address range.
+ */
+typedef enum {
+    E820_RAM        =3D 1,
+    E820_RESERVED   =3D 2,
+    E820_ACPI       =3D 3,
+    E820_NVS        =3D 4,
+    E820_UNUSABLE   =3D 5
+} E820Type;
+
+#define E820_NR_ENTRIES 16
+
+struct e820_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+} QEMU_PACKED __attribute((__aligned__(4)));
+
+struct e820_table {
+    uint32_t count;
+    struct e820_entry entry[E820_NR_ENTRIES];
+} QEMU_PACKED __attribute((__aligned__(4)));
+
+extern struct e820_table e820_reserve;
+extern struct e820_entry *e820_table;
+
+/**
+ * e820_add_entry: Add an #e820_entry to the @e820_table.
+ *
+ * Returns the number of entries of the e820_table on success,
+ *         or a negative errno otherwise.
+ *
+ * @address: The base address of the structure which the BIOS is to fill=
 in.
+ * @length: The length in bytes of the structure passed to the BIOS.
+ * @type: The #E820Type of the address range.
+ */
+ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)=
;
+
+/**
+ * e820_get_num_entries: The number of entries of the @e820_table.
+ *
+ * Returns the number of entries of the e820_table.
+ */
+size_t e820_get_num_entries(void);
+
+/**
+ * e820_get_entry: Get the address/length of an #e820_entry.
+ *
+ * If the #e820_entry stored at @index is of #E820Type @type, fills @add=
ress
+ * and @length with the #e820_entry values and return @true.
+ * Return @false otherwise.
+ *
+ * @index: The index of the #e820_entry to get values.
+ * @type: The @E820Type of the address range expected.
+ * @address: Pointer to the base address of the #e820_entry structure to
+ *           be filled.
+ * @length: Pointer to the length (in bytes) of the #e820_entry structur=
e
+ *          to be filled.
+ * @return: true if the entry was found, false otherwise.
+ */
+bool e820_get_entry(unsigned int index, E820Type type,
+                    uint64_t *address, uint64_t *length);
+
+#endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2e195049a5..fc22779ac1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,7 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "e820_memory_layout.h"
=20
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -89,22 +90,6 @@
 #define DPRINTF(fmt, ...)
 #endif
=20
-#define E820_NR_ENTRIES		16
-
-struct e820_entry {
-    uint64_t address;
-    uint64_t length;
-    uint32_t type;
-} QEMU_PACKED __attribute((__aligned__(4)));
-
-struct e820_table {
-    uint32_t count;
-    struct e820_entry entry[E820_NR_ENTRIES];
-} QEMU_PACKED __attribute((__aligned__(4)));
-
-static struct e820_table e820_reserve;
-static struct e820_entry *e820_table;
-static size_t e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
@@ -868,53 +853,6 @@ static void handle_a20_line_change(void *opaque, int=
 irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
=20
-ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
-{
-    unsigned int index =3D le32_to_cpu(e820_reserve.count);
-    uint32_t utype =3D (uint32_t)type;
-    struct e820_entry *entry;
-
-    if (type !=3D E820_RAM) {
-        /* old FW_CFG_E820_TABLE entry -- reservations only */
-        if (index >=3D E820_NR_ENTRIES) {
-            return -EBUSY;
-        }
-        entry =3D &e820_reserve.entry[index++];
-
-        entry->address =3D cpu_to_le64(address);
-        entry->length =3D cpu_to_le64(length);
-        entry->type =3D cpu_to_le32(utype);
-
-        e820_reserve.count =3D cpu_to_le32(index);
-    }
-
-    /* new "etc/e820" file -- include ram too */
-    e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
-    e820_table[e820_entries].address =3D cpu_to_le64(address);
-    e820_table[e820_entries].length =3D cpu_to_le64(length);
-    e820_table[e820_entries].type =3D cpu_to_le32(utype);
-    e820_entries++;
-
-    return e820_entries;
-}
-
-size_t e820_get_num_entries(void)
-{
-    return e820_entries;
-}
-
-bool e820_get_entry(unsigned int idx, E820Type type,
-                    uint64_t *address, uint64_t *length)
-{
-    uint32_t utype =3D (uint32_t)type;
-    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ut=
ype)) {
-        *address =3D le64_to_cpu(e820_table[idx].address);
-        *length =3D le64_to_cpu(e820_table[idx].length);
-        return true;
-    }
-    return false;
-}
-
 /* Enables contiguous-apic-ID mode, for compatibility */
 static bool compat_apic_id_mode;
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 95bf3278f2..0f1bf667ae 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -282,54 +282,6 @@ void pc_system_firmware_init(PCMachineState *pcms, M=
emoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
=20
-/**
- * E820Type: Type of the e820 address range.
- */
-typedef enum {
-    E820_RAM        =3D 1,
-    E820_RESERVED   =3D 2,
-    E820_ACPI       =3D 3,
-    E820_NVS        =3D 4,
-    E820_UNUSABLE   =3D 5
-} E820Type;
-
-/**
- * e820_add_entry: Add an #e820_entry to the @e820_table.
- *
- * Returns the number of entries of the e820_table on success,
- *         or a negative errno otherwise.
- *
- * @address: The base address of the structure which the BIOS is to fill=
 in.
- * @length: The length in bytes of the structure passed to the BIOS.
- * @type: The #E820Type of the address range.
- */
-ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)=
;
-
-/**
- * e820_get_num_entries: The number of entries of the @e820_table.
- *
- * Returns the number of entries of the e820_table.
- */
-size_t e820_get_num_entries(void);
-
-/**
- * e820_get_entry: Get the address/length of an #e820_entry.
- *
- * If the #e820_entry stored at @index is of #E820Type @type, fills @add=
ress
- * and @length with the #e820_entry values and return @true.
- * Return @false otherwise.
- *
- * @index: The index of the #e820_entry to get values.
- * @type: The @E820Type of the address range expected.
- * @address: Pointer to the base address of the #e820_entry structure to
- *           be filled.
- * @length: Pointer to the length (in bytes) of the #e820_entry structur=
e
- *          to be filled.
- * @return: true if the entry was found, false otherwise.
- */
-bool e820_get_entry(unsigned int index, E820Type type,
-                    uint64_t *address, uint64_t *length);
-
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
=20
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5c0d..dbf890005e 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -39,6 +39,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/i386/x86-iommu.h"
+#include "hw/i386/e820_memory_layout.h"
=20
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
--=20
2.20.1


