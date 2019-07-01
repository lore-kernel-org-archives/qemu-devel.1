Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D437AC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5C421721
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5C421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwpK-0006Jw-VP
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwTY-0002R3-D9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwTW-00005C-8k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhwTU-0008Pe-9h
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F1DE4DB11;
 Mon,  1 Jul 2019 13:35:54 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 116F0608C2;
 Mon,  1 Jul 2019 13:35:50 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:35:23 +0200
Message-Id: <20190701133536.28946-3-philmd@redhat.com>
In-Reply-To: <20190701133536.28946-1-philmd@redhat.com>
References: <20190701133536.28946-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 01 Jul 2019 13:35:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 02/15] hw/i386/pc: Extract e820 memory
 layout code
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: KISS, do not use unsigned, do not add broken documentation
---
 hw/i386/Makefile.objs        |  2 +-
 hw/i386/e820_memory_layout.c | 59 ++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h | 42 +++++++++++++++++++++++++
 hw/i386/pc.c                 | 61 +-----------------------------------
 include/hw/i386/pc.h         | 11 -------
 target/i386/kvm.c            |  1 +
 6 files changed, 104 insertions(+), 72 deletions(-)
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
index 0000000000..bcf9eaf837
--- /dev/null
+++ b/hw/i386/e820_memory_layout.c
@@ -0,0 +1,59 @@
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
+int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
+{
+    int index =3D le32_to_cpu(e820_reserve.count);
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
+        entry->type =3D cpu_to_le32(type);
+
+        e820_reserve.count =3D cpu_to_le32(index);
+    }
+
+    /* new "etc/e820" file -- include ram too */
+    e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
+    e820_table[e820_entries].address =3D cpu_to_le64(address);
+    e820_table[e820_entries].length =3D cpu_to_le64(length);
+    e820_table[e820_entries].type =3D cpu_to_le32(type);
+    e820_entries++;
+
+    return e820_entries;
+}
+
+int e820_get_num_entries(void)
+{
+    return e820_entries;
+}
+
+bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t =
*length)
+{
+    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
+        *address =3D le64_to_cpu(e820_table[idx].address);
+        *length =3D le64_to_cpu(e820_table[idx].length);
+        return true;
+    }
+    return false;
+}
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
new file mode 100644
index 0000000000..2a0ceb8b9c
--- /dev/null
+++ b/hw/i386/e820_memory_layout.h
@@ -0,0 +1,42 @@
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
+/* e820 types */
+#define E820_RAM        1
+#define E820_RESERVED   2
+#define E820_ACPI       3
+#define E820_NVS        4
+#define E820_UNUSABLE   5
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
+int e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
+int e820_get_num_entries(void);
+bool e820_get_entry(int index, uint32_t type,
+                    uint64_t *address, uint64_t *length);
+
+
+
+#endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 691726b85b..8ac85eadf1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,7 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "e820_memory_layout.h"
=20
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -90,22 +91,6 @@
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
-static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
@@ -869,50 +854,6 @@ static void handle_a20_line_change(void *opaque, int=
 irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
=20
-int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
-{
-    int index =3D le32_to_cpu(e820_reserve.count);
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
-        entry->type =3D cpu_to_le32(type);
-
-        e820_reserve.count =3D cpu_to_le32(index);
-    }
-
-    /* new "etc/e820" file -- include ram too */
-    e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
-    e820_table[e820_entries].address =3D cpu_to_le64(address);
-    e820_table[e820_entries].length =3D cpu_to_le64(length);
-    e820_table[e820_entries].type =3D cpu_to_le32(type);
-    e820_entries++;
-
-    return e820_entries;
-}
-
-int e820_get_num_entries(void)
-{
-    return e820_entries;
-}
-
-bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t =
*length)
-{
-    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
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
index c54cc54a47..99b0a2e705 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -282,17 +282,6 @@ void pc_system_firmware_init(PCMachineState *pcms, M=
emoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
=20
-/* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
-
-int e820_add_entry(uint64_t, uint64_t, uint32_t);
-int e820_get_num_entries(void);
-bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
-
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
=20
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e4b4f5756a..cd4eb1ed0d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -38,6 +38,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/i386/x86-iommu.h"
+#include "hw/i386/e820_memory_layout.h"
=20
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
--=20
2.20.1


