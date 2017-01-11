Received: from eggs.gnu.org ([2001:4830:134:3::10]:45228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgM-00033x-Ss
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgL-0003JK-Gu
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:38 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgL-0003Ij-80
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:37 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so334353wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:34:58 +0100
Message-Id: <1484163327-111841-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/33] smbios: filter based on CONFIG_SMBIOS
 rather than TARGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@linaro.org>

From: Leif Lindholm <leif.lindholm@linaro.org>

-smbios command line options were accepted but silently ignored on
TARGET_ARM, due to a test for TARGET_I386 in arch_init.c.

Copy the mechanism of hw/pci/pci-stub.c to implement an smbios-stub
instead, enabled for all targets without CONFIG_SMBIOS.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Message-Id: <20161222151828.28292-1-leif.lindholm@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch_init.c                |  8 --------
 hw/Makefile.objs           |  2 +-
 hw/smbios/Makefile.objs    |  3 +++
 hw/smbios/smbios-stub.c    | 31 +++++++++++++++++++++++++++++++
 hw/smbios/smbios.c         |  2 +-
 include/hw/smbios/smbios.h |  2 +-
 include/sysemu/arch_init.h |  1 -
 vl.c                       |  2 +-
 8 files changed, 38 insertions(+), 13 deletions(-)
 create mode 100644 hw/smbios/smbios-stub.c

diff --git a/arch_init.c b/arch_init.c
index 5cc58b2..34e7694 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -28,7 +28,6 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #include "hw/audio/audio.h"
-#include "hw/smbios/smbios.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
@@ -248,13 +247,6 @@ void do_acpitable_option(const QemuOpts *opts)
 #endif
 }
 
-void do_smbios_option(QemuOpts *opts)
-{
-#ifdef TARGET_I386
-    smbios_entry_add(opts);
-#endif
-}
-
 int kvm_available(void)
 {
 #ifdef CONFIG_KVM
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 0ffd281..2a73ae5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -33,7 +33,7 @@ devices-dirs-$(CONFIG_VIRTIO) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
 devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
-devices-dirs-$(CONFIG_SMBIOS) += smbios/
+devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
diff --git a/hw/smbios/Makefile.objs b/hw/smbios/Makefile.objs
index c3d3753..ee0712b 100644
--- a/hw/smbios/Makefile.objs
+++ b/hw/smbios/Makefile.objs
@@ -1,2 +1,5 @@
 common-obj-$(CONFIG_SMBIOS) += smbios.o
 common-obj-$(call land,$(CONFIG_SMBIOS),$(CONFIG_IPMI)) += smbios_type_38.o
+
+common-obj-$(call lnot,$(CONFIG_SMBIOS)) += smbios-stub.o
+common-obj-$(CONFIG_ALL) += smbios-stub.o
diff --git a/hw/smbios/smbios-stub.c b/hw/smbios/smbios-stub.c
new file mode 100644
index 0000000..3087394
--- /dev/null
+++ b/hw/smbios/smbios-stub.c
@@ -0,0 +1,31 @@
+/*
+ * SMBIOS stubs for platforms that don't support SMBIOS.
+ *
+ * Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>
+ *                    VA Linux Systems Japan K.K.
+ * Copyright (c) 2016 Leif Lindholm <leif.lindholm@linaro.org>
+ *                    Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qerror.h"
+#include "qmp-commands.h"
+#include "hw/smbios/smbios.h"
+
+void smbios_entry_add(QemuOpts *opts, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+}
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3a96ced..1a5437a 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -882,7 +882,7 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
     }
 }
 
-void smbios_entry_add(QemuOpts *opts)
+void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
 
diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
index 1cd53cc..31e8d5f 100644
--- a/include/hw/smbios/smbios.h
+++ b/include/hw/smbios/smbios.h
@@ -257,7 +257,7 @@ struct smbios_type_127 {
     struct smbios_structure_header header;
 } QEMU_PACKED;
 
-void smbios_entry_add(QemuOpts *opts);
+void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 1c9dad1..88dcf77 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -29,7 +29,6 @@ extern const uint32_t arch_type;
 
 void select_soundhw(const char *optarg);
 void do_acpitable_option(const QemuOpts *opts);
-void do_smbios_option(QemuOpts *opts);
 void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
diff --git a/vl.c b/vl.c
index a23de18..1b81340 100644
--- a/vl.c
+++ b/vl.c
@@ -3712,7 +3712,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                do_smbios_option(opts);
+                smbios_entry_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_fwcfg:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
-- 
1.8.3.1
