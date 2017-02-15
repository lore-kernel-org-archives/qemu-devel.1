Received: from eggs.gnu.org ([2001:4830:134:3::10]:58983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3Kh-0000xl-Ey
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3Kc-0006VI-Pi
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:35 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:27164)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3Kc-0006V8-F4
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:30 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Wed, 15 Feb 2017 17:23:52 +0000
Message-ID: <1487179434-13306-7-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1487179434-13306-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487179434-13306-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 6/8] loader: Support Flattened Image Trees
 (FIT images)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@imgtec.com>

From: Paul Burton <paul.burton@imgtec.com>

Introduce support for loading Flattened Image Trees, as used by modern
U-Boot. FIT images are essentially flattened device tree files which
contain binary images such as kernels, FDTs or ramdisks along with one
or more configuration nodes describing boot configurations.

The MIPS Boston board typically boots kernels in the form of FIT images,
and will make use of this code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
[yongbok.kim@imgtec.com: fixed potential memory leaks]
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/core/Makefile.objs   |   1 +
 hw/core/loader-fit.c    | 325 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/core/loader.c        |   7 +-
 include/hw/loader-fit.h |  41 ++++++
 include/hw/loader.h     |   6 +
 5 files changed, 374 insertions(+), 6 deletions(-)
 create mode 100644 hw/core/loader-fit.c
 create mode 100644 include/hw/loader-fit.h

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 7f8c9dc..ff59512 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -13,6 +13,7 @@ common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
+common-obj-$(CONFIG_SOFTMMU) += loader-fit.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += register.o
 common-obj-$(CONFIG_SOFTMMU) += or-irq.o
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
new file mode 100644
index 0000000..2b99e2a
--- /dev/null
+++ b/hw/core/loader-fit.c
@@ -0,0 +1,325 @@
+/*
+ * Flattened Image Tree loader.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "hw/loader.h"
+#include "hw/loader-fit.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/sysemu.h"
+
+#include <libfdt.h>
+#include <zlib.h>
+
+#define MAX_PATH (128)
+
+static const void *fit_load_image_alloc(const void *itb, const char *name,
+                                        int *poff, size_t *psz)
+{
+    const void *data;
+    const char *comp;
+    void *uncomp_data;
+    char path[MAX_PATH];
+    int off, sz;
+    ssize_t uncomp_len;
+
+    snprintf(path, sizeof(path), "/images/%s", name);
+
+    off = fdt_path_offset(itb, path);
+    if (off < 0) {
+        return NULL;
+    }
+    if (poff) {
+        *poff = off;
+    }
+
+    data = fdt_getprop(itb, off, "data", &sz);
+    if (!data) {
+        return NULL;
+    }
+
+    comp = fdt_getprop(itb, off, "compression", NULL);
+    if (!comp || !strcmp(comp, "none")) {
+        if (psz) {
+            *psz = sz;
+        }
+        uncomp_data = g_malloc(sz);
+        memmove(uncomp_data, data, sz);
+        return uncomp_data;
+    }
+
+    if (!strcmp(comp, "gzip")) {
+        uncomp_len = UBOOT_MAX_GUNZIP_BYTES;
+        uncomp_data = g_malloc(uncomp_len);
+
+        uncomp_len = gunzip(uncomp_data, uncomp_len, (void *) data, sz);
+        if (uncomp_len < 0) {
+            error_printf("unable to decompress %s image\n", name);
+            g_free(uncomp_data);
+            return NULL;
+        }
+
+        data = g_realloc(uncomp_data, uncomp_len);
+        if (psz) {
+            *psz = uncomp_len;
+        }
+        return data;
+    }
+
+    error_printf("unknown compression '%s'\n", comp);
+    return NULL;
+}
+
+static int fit_image_addr(const void *itb, int img, const char *name,
+                          hwaddr *addr)
+{
+    const void *prop;
+    int len;
+
+    prop = fdt_getprop(itb, img, name, &len);
+    if (!prop) {
+        return -ENOENT;
+    }
+
+    switch (len) {
+    case 4:
+        *addr = fdt32_to_cpu(*(fdt32_t *)prop);
+        return 0;
+    case 8:
+        *addr = fdt64_to_cpu(*(fdt64_t *)prop);
+        return 0;
+    default:
+        error_printf("invalid %s address length %d\n", name, len);
+        return -EINVAL;
+    }
+}
+
+static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
+                           int cfg, void *opaque, hwaddr *pend)
+{
+    const char *name;
+    const void *data;
+    const void *load_data;
+    hwaddr load_addr, entry_addr;
+    int img_off, err;
+    size_t sz;
+    int ret;
+
+    name = fdt_getprop(itb, cfg, "kernel", NULL);
+    if (!name) {
+        error_printf("no kernel specified by FIT configuration\n");
+        return -EINVAL;
+    }
+
+    data = fit_load_image_alloc(itb, name, &img_off, &sz);
+    if (!data) {
+        error_printf("unable to load kernel image from FIT\n");
+        return -EINVAL;
+    }
+
+    err = fit_image_addr(itb, img_off, "load", &load_addr);
+    if (err) {
+        error_printf("unable to read kernel load address from FIT\n");
+        ret = err;
+        goto out;
+    }
+
+    err = fit_image_addr(itb, img_off, "entry", &entry_addr);
+    if (err) {
+        error_printf("unable to read kernel entry address from FIT\n");
+        ret = err;
+        goto out;
+    }
+
+    if (ldr->kernel_filter) {
+        load_data = ldr->kernel_filter(opaque, data, &load_addr, &entry_addr);
+    }
+
+    if (pend) {
+        *pend = load_addr + sz;
+    }
+
+    load_addr = ldr->addr_to_phys(opaque, load_addr);
+    rom_add_blob_fixed(name, load_data, sz, load_addr);
+
+    ret = 0;
+out:
+    g_free((void *) data);
+    if (data != load_data) {
+        g_free((void *) load_data);
+    }
+    return ret;
+}
+
+static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
+                        int cfg, void *opaque, const void *match_data,
+                        hwaddr kernel_end)
+{
+    const char *name;
+    const void *data;
+    const void *load_data;
+    hwaddr load_addr;
+    int img_off, err;
+    size_t sz;
+    int ret;
+
+    name = fdt_getprop(itb, cfg, "fdt", NULL);
+    if (!name) {
+        return 0;
+    }
+
+    data = fit_load_image_alloc(itb, name, &img_off, &sz);
+    if (!data) {
+        error_printf("unable to load FDT image from FIT\n");
+        return -EINVAL;
+    }
+
+    err = fit_image_addr(itb, img_off, "load", &load_addr);
+    if (err == -ENOENT) {
+        load_addr = ROUND_UP(kernel_end, 64 * K_BYTE) + (10 * M_BYTE);
+    } else if (err) {
+        ret = err;
+        goto out;
+    }
+
+    if (ldr->fdt_filter) {
+        load_data = ldr->fdt_filter(opaque, data, match_data, &load_addr);
+    }
+
+    load_addr = ldr->addr_to_phys(opaque, load_addr);
+    sz = fdt_totalsize(load_data);
+    rom_add_blob_fixed(name, load_data, sz, load_addr);
+
+    ret = 0;
+out:
+    g_free((void *) data);
+    if (data != load_data) {
+        g_free((void *) load_data);
+    }
+    return ret;
+}
+
+static bool fit_cfg_compatible(const void *itb, int cfg, const char *compat)
+{
+    const void *fdt;
+    const char *fdt_name;
+    bool ret;
+
+    fdt_name = fdt_getprop(itb, cfg, "fdt", NULL);
+    if (!fdt_name) {
+        return false;
+    }
+
+    fdt = fit_load_image_alloc(itb, fdt_name, NULL, NULL);
+    if (!fdt) {
+        return false;
+    }
+
+    if (fdt_check_header(fdt)) {
+        ret = false;
+        goto out;
+    }
+
+    if (fdt_node_check_compatible(fdt, 0, compat)) {
+        ret = false;
+        goto out;
+    }
+
+    ret = true;
+out:
+    g_free((void *) fdt);
+    return ret;
+}
+
+int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
+{
+    const struct fit_loader_match *match;
+    const void *itb, *match_data = NULL;
+    const char *def_cfg_name;
+    char path[MAX_PATH];
+    int itb_size, configs, cfg_off, off, err;
+    hwaddr kernel_end;
+    int ret;
+
+    itb = load_device_tree(filename, &itb_size);
+    if (!itb) {
+        return -EINVAL;
+    }
+
+    configs = fdt_path_offset(itb, "/configurations");
+    if (configs < 0) {
+        ret = configs;
+        goto out;
+    }
+
+    cfg_off = -FDT_ERR_NOTFOUND;
+
+    if (ldr->matches) {
+        for (match = ldr->matches; match->compatible; match++) {
+            off = fdt_first_subnode(itb, configs);
+            while (off >= 0) {
+                if (fit_cfg_compatible(itb, off, match->compatible)) {
+                    cfg_off = off;
+                    match_data = match->data;
+                    break;
+                }
+
+                off = fdt_next_subnode(itb, off);
+            }
+
+            if (cfg_off >= 0) {
+                break;
+            }
+        }
+    }
+
+    if (cfg_off < 0) {
+        def_cfg_name = fdt_getprop(itb, configs, "default", NULL);
+        if (def_cfg_name) {
+            snprintf(path, sizeof(path), "/configurations/%s", def_cfg_name);
+            cfg_off = fdt_path_offset(itb, path);
+        }
+    }
+
+    if (cfg_off < 0) {
+        /* couldn't find a configuration to use */
+        ret = cfg_off;
+        goto out;
+    }
+
+    err = fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end);
+    if (err) {
+        ret = err;
+        goto out;
+    }
+
+    err = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end);
+    if (err) {
+        ret = err;
+        goto out;
+    }
+
+    ret = 0;
+out:
+    g_free((void *) itb);
+    return ret;
+}
diff --git a/hw/core/loader.c b/hw/core/loader.c
index ee5abd6..8b980e9 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -527,12 +527,7 @@ static void zfree(void *x, void *addr)
 
 #define DEFLATED	8
 
-/* This is the usual maximum in uboot, so if a uImage overflows this, it would
- * overflow on real hardware too. */
-#define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
-
-static ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src,
-                      size_t srclen)
+ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen)
 {
     z_stream s;
     ssize_t dstbytes;
diff --git a/include/hw/loader-fit.h b/include/hw/loader-fit.h
new file mode 100644
index 0000000..9e2a068
--- /dev/null
+++ b/include/hw/loader-fit.h
@@ -0,0 +1,41 @@
+/*
+ * Flattened Image Tree loader.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_LOADER_FIT_H
+#define HW_LOADER_FIT_H
+
+#include <exec/hwaddr.h>
+
+struct fit_loader_match {
+    const char *compatible;
+    const void *data;
+};
+
+struct fit_loader {
+    const struct fit_loader_match *matches;
+    hwaddr (*addr_to_phys)(void *opaque, uint64_t addr);
+    const void *(*fdt_filter)(void *opaque, const void *fdt,
+                              const void *match_data, hwaddr *load_addr);
+    const void *(*kernel_filter)(void *opaque, const void *kernel,
+                                 hwaddr *load_addr, hwaddr *entry_addr);
+};
+
+int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque);
+
+#endif /* HW_LOADER_FIT_H */
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 0dbd8d6..40c4153 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -164,6 +164,8 @@ int load_uimage(const char *filename, hwaddr *ep,
  */
 int load_ramdisk(const char *filename, hwaddr addr, uint64_t max_sz);
 
+ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen);
+
 ssize_t read_targphys(const char *name,
                       int fd, hwaddr dst_addr, size_t nbytes);
 void pstrcpy_targphys(const char *name,
@@ -214,4 +216,8 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
 int rom_add_vga(const char *file);
 int rom_add_option(const char *file, int32_t bootindex);
 
+/* This is the usual maximum in uboot, so if a uImage overflows this, it would
+ * overflow on real hardware too. */
+#define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
+
 #endif
-- 
2.7.4
