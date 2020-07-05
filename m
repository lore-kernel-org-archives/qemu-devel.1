Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADC420724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADC420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5PQ-0002Mg-NO
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FE-0007g7-EL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:48 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FC-0008LW-IZ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:48 -0400
Received: by mail-ej1-f67.google.com with SMTP id y10so39638686eje.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w6CNbDOqgBa2jafAANyOJpvIDyko1xEWleQ2s9+vC5w=;
 b=Sp6cuU4PseY+ZZR8tY1V83Gcbsm6HfDCmt2nIUQWukbn26PLIKGL0o4pouuRDgiVo1
 lXlsJLY6FkJFwLrQM6sVmvZEyRZQO8VuXTV8Z80yhoXSa1Z7xxbuqVU2IMgeaQvG6kXT
 qB/rlMJ0nXctbPDkkZw9cut/mtOSxB6NJBa6bZuduUQGhQtcYsPoTQSBXUEqDc650O0e
 hUbGtqFlKvB4MbKE1RcZldhLCie0v5nKHYUBbh8BbGzijBjkQx4M5yMZVEnUereLfo4L
 eiCX8wpOIQoc943VOTovEse2dDzIkg2wOt4hEnQP898eC1LXINQTH36+5uSX488jFnpF
 aAuA==
X-Gm-Message-State: AOAM5315vqcaj/39hfJOzHB3qQVQ7AhTCjFZS3YFGLGRa7a7kiEbDIgC
 6HH6t/e68sX721z/73UOr8NEdW4a
X-Google-Smtp-Source: ABdhPJwc8f7ZSFeAnRb7GHosYuSnq9Zz5023U+tK/mfjqTYloyYuHL89cmRoR0VvIfiqdHftd670Mw==
X-Received: by 2002:a17:906:1254:: with SMTP id
 u20mr20289978eja.540.1593957824875; 
 Sun, 05 Jul 2020 07:03:44 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:44 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 23/30] hw/avr: Add support for loading ELF/raw binaries
Date: Sun,  5 Jul 2020 16:03:08 +0200
Message-Id: <20200705140315.260514-24-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.67; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add avr_load_firmware() function to load firmware in ELF or
raw binary format.

[AM: Corrected the type of the variable containing e_flags]
[AM: Moved definition of e_flags conversion function to boot.c]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS          |   1 +
 hw/avr/Makefile.objs |   1 +
 hw/avr/boot.c        | 116 +++++++++++++++++++++++++++++++++++++++++++
 hw/avr/boot.h        |  33 ++++++++++++
 include/elf.h        |   4 ++
 5 files changed, 155 insertions(+)
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/avr/boot.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b5f831cd7..e8e6ddcd37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -982,6 +982,7 @@ AVR MCUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+F: hw/avr/
 F: include/hw/char/avr_usart.h
 F: hw/char/avr_usart.c
 F: include/hw/timer/avr_timer16.h
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..123f174f0e
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1 @@
+obj-y += boot.o
diff --git a/hw/avr/boot.c b/hw/avr/boot.c
new file mode 100644
index 0000000000..a82508a428
--- /dev/null
+++ b/hw/avr/boot.c
@@ -0,0 +1,116 @@
+/*
+ * AVR loader helpers
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "boot.h"
+#include "qemu/error-report.h"
+
+static const char *avr_elf_e_flags_to_cpu_type(uint32_t flags)
+{
+    switch (flags & EF_AVR_MACH) {
+    case bfd_mach_avr1:
+        return AVR_CPU_TYPE_NAME("avr1");
+    case bfd_mach_avr2:
+        return AVR_CPU_TYPE_NAME("avr2");
+    case bfd_mach_avr25:
+        return AVR_CPU_TYPE_NAME("avr25");
+    case bfd_mach_avr3:
+        return AVR_CPU_TYPE_NAME("avr3");
+    case bfd_mach_avr31:
+        return AVR_CPU_TYPE_NAME("avr31");
+    case bfd_mach_avr35:
+        return AVR_CPU_TYPE_NAME("avr35");
+    case bfd_mach_avr4:
+        return AVR_CPU_TYPE_NAME("avr4");
+    case bfd_mach_avr5:
+        return AVR_CPU_TYPE_NAME("avr5");
+    case bfd_mach_avr51:
+        return AVR_CPU_TYPE_NAME("avr51");
+    case bfd_mach_avr6:
+        return AVR_CPU_TYPE_NAME("avr6");
+    case bfd_mach_avrtiny:
+        return AVR_CPU_TYPE_NAME("avrtiny");
+    case bfd_mach_avrxmega2:
+        return AVR_CPU_TYPE_NAME("xmega2");
+    case bfd_mach_avrxmega3:
+        return AVR_CPU_TYPE_NAME("xmega3");
+    case bfd_mach_avrxmega4:
+        return AVR_CPU_TYPE_NAME("xmega4");
+    case bfd_mach_avrxmega5:
+        return AVR_CPU_TYPE_NAME("xmega5");
+    case bfd_mach_avrxmega6:
+        return AVR_CPU_TYPE_NAME("xmega6");
+    case bfd_mach_avrxmega7:
+        return AVR_CPU_TYPE_NAME("xmega7");
+    default:
+        return NULL;
+    }
+}
+
+bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
+                       MemoryRegion *mr, const char *firmware)
+{
+    const char *filename;
+    int bytes_loaded;
+    uint64_t entry;
+    uint32_t e_flags;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+    if (filename == NULL) {
+        error_report("Unable to find %s", firmware);
+        return false;
+    }
+
+    bytes_loaded = load_elf_ram_sym(filename,
+                                    NULL, NULL, NULL,
+                                    &entry, NULL, NULL,
+                                    &e_flags, 0, EM_AVR, 0, 0,
+                                    NULL, true, NULL);
+    if (bytes_loaded >= 0) {
+        /* If ELF file is provided, determine CPU type reading ELF e_flags. */
+        const char *elf_cpu = avr_elf_e_flags_to_cpu_type(e_flags);
+        const char *mcu_cpu_type = object_get_typename(OBJECT(cpu));
+        int cpu_len = strlen(mcu_cpu_type) - strlen(AVR_CPU_TYPE_SUFFIX);
+
+        if (entry) {
+            error_report("BIOS entry_point must be 0x0000 "
+                         "(ELF image '%s' has entry_point 0x%04" PRIx64 ")",
+                         firmware, entry);
+            return false;
+        }
+        if (!elf_cpu) {
+            warn_report("Could not determine CPU type for ELF image '%s', "
+                        "assuming '%.*s' CPU",
+                         firmware, cpu_len, mcu_cpu_type);
+            return true;
+        }
+        if (strcmp(elf_cpu, mcu_cpu_type)) {
+            error_report("Current machine: %s with '%.*s' CPU",
+                         MACHINE_GET_CLASS(ms)->desc, cpu_len, mcu_cpu_type);
+            error_report("ELF image '%s' is for '%.*s' CPU",
+                         firmware,
+                         (int)(strlen(elf_cpu) - strlen(AVR_CPU_TYPE_SUFFIX)),
+                         elf_cpu);
+            return false;
+        }
+    } else {
+        bytes_loaded = load_image_targphys(filename, OFFSET_CODE,
+                                           memory_region_size(mr));
+    }
+    if (bytes_loaded < 0) {
+        error_report("Unable to load firmware image %s as ELF or raw binary",
+                     firmware);
+        return false;
+    }
+    return true;
+}
diff --git a/hw/avr/boot.h b/hw/avr/boot.h
new file mode 100644
index 0000000000..62bc10c922
--- /dev/null
+++ b/hw/avr/boot.h
@@ -0,0 +1,33 @@
+/*
+ * AVR loader helpers
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_AVR_BOOT_H
+#define HW_AVR_BOOT_H
+
+#include "hw/boards.h"
+#include "cpu.h"
+
+/**
+ * avr_load_firmware:   load an image into a memory region
+ *
+ * @cpu:        Handle a AVR CPU object
+ * @ms:         A MachineState
+ * @mr:         Memory Region to load into
+ * @firmware:   Path to the firmware file (raw binary or ELF format)
+ *
+ * Load a firmware supplied by the machine or by the user  with the
+ * '-bios' command line option, and put it in target memory.
+ *
+ * Returns: true on success, false on error.
+ */
+bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
+                       MemoryRegion *mr, const char *firmware);
+
+#endif
diff --git a/include/elf.h b/include/elf.h
index 8fbfe60e09..5b06b55f28 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -160,6 +160,8 @@ typedef struct mips_elf_abiflags_v0 {
 
 #define EM_CRIS         76      /* Axis Communications 32-bit embedded processor */
 
+#define EM_AVR          83      /* AVR 8-bit microcontroller */
+
 #define EM_V850		87	/* NEC v850 */
 
 #define EM_H8_300H      47      /* Hitachi H8/300H */
@@ -202,6 +204,8 @@ typedef struct mips_elf_abiflags_v0 {
 #define EM_MOXIE           223     /* Moxie processor family */
 #define EM_MOXIE_OLD       0xFEED
 
+#define EF_AVR_MACH     0x7F       /* Mask for AVR e_flags to get core type */
+
 /* This is the info that is needed to parse the dynamic section of the file */
 #define DT_NULL		0
 #define DT_NEEDED	1
-- 
2.26.2


