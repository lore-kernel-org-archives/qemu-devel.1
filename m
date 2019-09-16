Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBBC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5C021852
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfMJi/4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5C021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tGH-0007fx-8B
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD3-0006d7-Ci
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD1-0007WC-1v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD0-0007Vm-MX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id q14so39144631wrm.9
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P3cM65404bjGz2MqZOyNYA1J6K0Tji+FY3F8UQivyng=;
 b=UfMJi/4j/flplu5w63u6IyQF35+YehZAki8Kywi+0OqaPFpnrPr+QQxILE/Jydcr/U
 zd5gHwQstSEoHfTlkhlLW9h01oAPOYPxsJKGzjosLKx/gie5M/eEXyLkSUOQDry0QpTk
 txEzjBhPEV5A/jAfcS340u67utOze3paKtrdyZJkGsT8aHCUgtAbIS4UnfJtuaIbOcyt
 i0L4Kn+dlz0QTgNDkrxxc7VavmH8g7cNnqo/yTt9bcuIlTAChWjVnfkoppp+KLbC52zj
 2dvVgMlyQYPx+97IM9srcz4tjFmzA3arJWJPS3BtGUDsN1nwYtQMpLumv2wj4wEjJVPQ
 GHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=P3cM65404bjGz2MqZOyNYA1J6K0Tji+FY3F8UQivyng=;
 b=A2qE47Zo15WAREFVXnprmetJ0S/8dTVkJub32QkbT0iQyycPuQZZi7eZpxE/pK/Yk8
 QaD5IX+bhx0HhV0BtebJvbqnfFn43j36WeaXA8SEuZo12i2czsJlFZzuyx6dSOjgUEtZ
 dFhb1CcdOvoEdz+LfLjyojpGcbuCYxzG645RihVv2FnFfYxWu6SpXYVBi/NxdC6VakWw
 fpP4wrfJYpiTsd7NqTe7bykwKtZM/445M1SbkiNM/jdR7LrBamGzEiZig43u20YYMlI7
 6uStvp1O3j0yYmGx+K3GkSp51CIefp1Nhur0uvbCkSTvg+XBHS6EEVEmd8Ui8030y+A4
 7ejw==
X-Gm-Message-State: APjAAAXENrq0YemqNx8V97kkKLZKFgUNIBS9KO45Fto89632FQo73fvo
 tfsUpkPsKT/b1HUIERVjNTRJZXE9
X-Google-Smtp-Source: APXvYqwYvGXH1cR5CVHidYOct5HbuAb1F2mlEm4d7jFxmlzLNnqzr0rVrDvyVyLj5dtrgTVhQWhsdQ==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr77839wrq.301.1568644949231;
 Mon, 16 Sep 2019 07:42:29 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:56 +0200
Message-Id: <1568644929-9124-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 16/29] hw/i386/pc: Extract e820 memory layout
 code
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-3-philmd@redhat.com>
---
 hw/i386/Makefile.objs        |  2 +-
 hw/i386/e820_memory_layout.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h | 42 ++++++++++++++++++++++++++++++
 hw/i386/pc.c                 | 61 +-------------------------------------------
 include/hw/i386/pc.h         | 11 --------
 target/i386/kvm.c            |  1 +
 6 files changed, 104 insertions(+), 72 deletions(-)
 create mode 100644 hw/i386/e820_memory_layout.c
 create mode 100644 hw/i386/e820_memory_layout.h

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 5d9c9ef..d3374e0 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_KVM) += kvm/
-obj-y += multiboot.o
+obj-y += e820_memory_layout.o multiboot.o
 obj-y += pc.o
 obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
new file mode 100644
index 0000000..bcf9eaf
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
+    int index = le32_to_cpu(e820_reserve.count);
+    struct e820_entry *entry;
+
+    if (type != E820_RAM) {
+        /* old FW_CFG_E820_TABLE entry -- reservations only */
+        if (index >= E820_NR_ENTRIES) {
+            return -EBUSY;
+        }
+        entry = &e820_reserve.entry[index++];
+
+        entry->address = cpu_to_le64(address);
+        entry->length = cpu_to_le64(length);
+        entry->type = cpu_to_le32(type);
+
+        e820_reserve.count = cpu_to_le32(index);
+    }
+
+    /* new "etc/e820" file -- include ram too */
+    e820_table = g_renew(struct e820_entry, e820_table, e820_entries + 1);
+    e820_table[e820_entries].address = cpu_to_le64(address);
+    e820_table[e820_entries].length = cpu_to_le64(length);
+    e820_table[e820_entries].type = cpu_to_le32(type);
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
+bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
+{
+    if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
+        *address = le64_to_cpu(e820_table[idx].address);
+        *length = le64_to_cpu(e820_table[idx].length);
+        return true;
+    }
+    return false;
+}
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
new file mode 100644
index 0000000..2a0ceb8
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
index 31e9c1f..81e5a59 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -87,6 +87,7 @@
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
 #include "config-devices.h"
+#include "e820_memory_layout.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -98,22 +99,6 @@
 #define DPRINTF(fmt, ...)
 #endif
 
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
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
@@ -880,50 +865,6 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
 
-int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
-{
-    int index = le32_to_cpu(e820_reserve.count);
-    struct e820_entry *entry;
-
-    if (type != E820_RAM) {
-        /* old FW_CFG_E820_TABLE entry -- reservations only */
-        if (index >= E820_NR_ENTRIES) {
-            return -EBUSY;
-        }
-        entry = &e820_reserve.entry[index++];
-
-        entry->address = cpu_to_le64(address);
-        entry->length = cpu_to_le64(length);
-        entry->type = cpu_to_le32(type);
-
-        e820_reserve.count = cpu_to_le32(index);
-    }
-
-    /* new "etc/e820" file -- include ram too */
-    e820_table = g_renew(struct e820_entry, e820_table, e820_entries + 1);
-    e820_table[e820_entries].address = cpu_to_le64(address);
-    e820_table[e820_entries].length = cpu_to_le64(length);
-    e820_table[e820_entries].type = cpu_to_le32(type);
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
-bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
-{
-    if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
-        *address = le64_to_cpu(e820_table[idx].address);
-        *length = le64_to_cpu(e820_table[idx].length);
-        return true;
-    }
-    return false;
-}
-
 /* Calculates initial APIC ID for a specific CPU index
  *
  * Currently we need to be able to calculate the APIC ID from the CPU index
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 19a8378..062feeb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -291,17 +291,6 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
 
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
 extern GlobalProperty pc_compat_4_1[];
 extern const size_t pc_compat_4_1_len;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3435fc4..9206909 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -41,6 +41,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/i386/x86-iommu.h"
+#include "hw/i386/e820_memory_layout.h"
 
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
-- 
1.8.3.1



