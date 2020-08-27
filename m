Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04AC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D522177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D522177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHCA-0001AB-95
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBQ-0007xC-6F
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:12 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:56302)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBN-0005u8-TJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:11 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id CC51026329;
 Thu, 27 Aug 2020 21:39:05 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 7C96C1C07B2;
 Thu, 27 Aug 2020 21:39:05 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/20] hw/rx: Firmware and kernel loader.
Date: Thu, 27 Aug 2020 21:38:42 +0900
Message-Id: <20200827123859.81793-4-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.14;
 envelope-from=ysato@users.sourceforge.jp; helo=mail02.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suppoerted format.
ELF, HEX, SREC and Raw firmware.
fit and Raw kernel image.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/loader.h |  35 ++++++++
 hw/rx/loader.c         | 182 +++++++++++++++++++++++++++++++++++++++++
 hw/rx/Kconfig          |   1 +
 hw/rx/meson.build      |   1 +
 4 files changed, 219 insertions(+)
 create mode 100644 include/hw/rx/loader.h
 create mode 100644 hw/rx/loader.c

diff --git a/include/hw/rx/loader.h b/include/hw/rx/loader.h
new file mode 100644
index 0000000000..71f3bd2bb3
--- /dev/null
+++ b/include/hw/rx/loader.h
@@ -0,0 +1,35 @@
+/*
+ * RX QEMU frimware loader
+ *
+ * Copyright (c) 2020 Yoshinori Sato
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
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+typedef struct {
+    hwaddr ram_start;
+    size_t ram_size;
+    hwaddr entry;
+    hwaddr kernel_entry;
+    hwaddr dtb_address;
+    const char *filename;
+    const char *dtbname;
+    const char *cmdline;
+} rx_kernel_info_t;
+
+bool load_bios(const char *filename, int rom_size, Error **errp);
+
+bool load_kernel(rx_kernel_info_t *info);
diff --git a/hw/rx/loader.c b/hw/rx/loader.c
new file mode 100644
index 0000000000..c262f3ef86
--- /dev/null
+++ b/hw/rx/loader.c
@@ -0,0 +1,182 @@
+/*
+ * RX QEMU frimware loader
+ *
+ * Copyright (c) 2020 Yoshinori Sato
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
+#include "elf.h"
+#include "hw/loader.h"
+#include "hw/loader-fit.h"
+#include "hw/rx/loader.h"
+#include "sysemu/device_tree.h"
+#include "exec/cpu-defs.h"
+#include <libfdt.h>
+
+#define RX_RESET_VEC 0xfffffffc
+#define ADDRESS_TOP ((1LL << TARGET_PHYS_ADDR_SPACE_BITS) - 1)
+
+bool load_bios(const char *filename, int rom_size, Error **errp)
+{
+    int size;
+    uint64_t entry64 = UINT64_MAX;
+    uint32_t entry;
+
+    size = load_elf(filename, NULL, NULL, NULL, &entry64,
+                    NULL, NULL, NULL, 0, EM_RX, 0, 0);
+    if (size > 0) {
+        goto load_ok;
+    }
+    size = load_targphys_hex_as(filename, &entry64, NULL);
+    if (size > 0) {
+        goto load_ok;
+    }
+    size = load_targphys_srec_as(filename, &entry64, NULL);
+    if (size > 0) {
+        goto load_ok;
+    }
+    size = get_image_size(filename);
+    if (size < 0) {
+        error_setg(errp, "\"%s\" is open failed.", filename);
+        return false;
+    }
+    if (size > rom_size) {
+        error_setg(errp, "\"%s\" is too large for ROM area.", filename);
+        return false;
+    }
+
+    /*
+     * The RX CPU reset vector is at the top of the ROM,
+     * so the raw binary is loaded there.
+     */
+    rom_add_file_fixed(filename, -size, 0);
+ load_ok:
+    if (rom_ptr(RX_RESET_VEC, 4) == NULL) {
+        if (entry64 <= ADDRESS_TOP) {
+            entry = cpu_to_le32(entry64);
+            rom_add_blob_fixed("entry", &entry, 4, RX_RESET_VEC);
+        } else {
+            error_setg(errp, "Reset vector is not set");
+            return false;
+        }
+    }
+    return true;
+}
+
+static hwaddr rx_addr_to_phys(void *opaque, uint64_t addr)
+{
+    /* No address translation */
+    return addr;
+}
+
+static bool setup_commandline(void *dtb, rx_kernel_info_t *info)
+{
+    if (info->cmdline &&
+        qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
+                                info->cmdline) < 0) {
+        return false;
+    }
+    return true;
+}
+
+
+static const void *rx_fdt_filter(void *opaque, const void *fdt_orig,
+                                 const void *match_data, hwaddr *load_addr)
+{
+    rx_kernel_info_t *info = opaque;
+    void *fdt;
+    size_t fdt_sz;
+    int err;
+
+    fdt_sz = fdt_totalsize(fdt_orig) + 0x1000;
+    fdt = g_malloc0(fdt_sz);
+
+    err = fdt_open_into(fdt_orig, fdt, fdt_sz);
+    if (err) {
+        error_report("couldn't open dtb");
+        return NULL;
+    }
+
+    if (!setup_commandline(fdt, info)) {
+        error_report("couldn't set /chosen/bootargs");
+        return NULL;
+    }
+    fdt_sz = fdt_totalsize(fdt);
+    fdt = g_realloc(fdt, fdt_totalsize(fdt));
+    info->dtb_address = info->ram_start + info->ram_size - fdt_sz;
+    *load_addr = info->dtb_address;
+
+    return fdt;
+}
+
+static const void *rx_kernel_filter(void *opaque, const void *kernel,
+                                        hwaddr *load_addr, hwaddr *entry_addr)
+{
+    rx_kernel_info_t *info = opaque;
+
+    info->kernel_entry = *entry_addr;
+
+    return kernel;
+}
+
+static const struct fit_loader rx_fit_loader = {
+    .addr_to_phys = rx_addr_to_phys,
+    .fdt_filter = rx_fdt_filter,
+    .kernel_filter = rx_kernel_filter,
+};
+
+bool load_kernel(rx_kernel_info_t *info)
+{
+    ram_addr_t kernel_offset;
+    size_t kernel_size;
+
+    if (load_fit(&rx_fit_loader, info->filename, info) == 0) {
+        return true;
+    }
+
+    /*
+     * The kernel image is loaded into
+     * the latter half of the SDRAM space.
+     */
+    kernel_offset = info->ram_size / 2;
+
+    info->entry = info->ram_start + kernel_offset;
+    kernel_size = load_image_targphys(info->filename,
+                                      info->entry, info->ram_size / 2);
+    if (kernel_size == -1) {
+        return false;
+    }
+    if (info->dtbname) {
+        ram_addr_t dtb_offset;
+        int dtb_size;
+        void *dtb;
+
+        dtb = load_device_tree(info->dtbname, &dtb_size);
+        if (dtb == NULL) {
+            error_report("Couldn't open dtb file %s", info->dtbname);
+            return false;
+        }
+        if (!setup_commandline(dtb, info)) {
+            error_report("Couldn't set /chosen/bootargs");
+            return false;
+        }
+        /* DTB is located at the end of SDRAM space. */
+        dtb_size = fdt_totalsize(dtb);
+        dtb_offset = info->ram_size - dtb_size;
+        info->dtb_address = info->ram_start + dtb_offset;
+        rom_add_blob_fixed("dtb", dtb, dtb_size, info->dtb_address);
+    }
+    return true;
+}
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index 2b297c5a6a..a63e4a5520 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -8,3 +8,4 @@ config RX62N_MCU
 config RX_GDBSIM
     bool
     select RX62N_MCU
+    select FITLOADER
diff --git a/hw/rx/meson.build b/hw/rx/meson.build
index d223512a78..e73850f303 100644
--- a/hw/rx/meson.build
+++ b/hw/rx/meson.build
@@ -1,4 +1,5 @@
 rx_ss = ss.source_set()
+rx_ss.add(files('loader.c'))
 rx_ss.add(when: 'CONFIG_RX_GDBSIM', if_true: files('rx-gdbsim.c'))
 rx_ss.add(when: 'CONFIG_RX62N_MCU', if_true: files('rx62n.c'))
 
-- 
2.20.1


