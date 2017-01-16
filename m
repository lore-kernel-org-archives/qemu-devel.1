Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd7-0000tQ-1I
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd5-00006Y-Sx
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAd5-00006H-K7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B04FA3B70C
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:35 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGV3001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:34 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:59:00 +0100
Message-Id: <20170116165916.8575-17-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/32] acpi: filter based on CONFIG_ACPI_X86
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

Copy the mechanism of hw/smbios/smbios-stub.c to implement an ACPI-stub
instead, so that -acpitable can be later extended to ARM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch_init.c                | 13 -------------
 hw/Makefile.objs           |  2 +-
 hw/acpi/Makefile.objs      |  7 ++++++-
 hw/acpi/acpi-stub.c        | 29 +++++++++++++++++++++++++++++
 include/sysemu/arch_init.h |  1 -
 vl.c                       |  3 ++-
 6 files changed, 38 insertions(+), 17 deletions(-)
 create mode 100644 hw/acpi/acpi-stub.c

diff --git a/arch_init.c b/arch_init.c
index 34e7694..6c4e287 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -234,19 +234,6 @@ void audio_init(void)
     }
 }
 
-void do_acpitable_option(const QemuOpts *opts)
-{
-#ifdef TARGET_I386
-    Error *err = NULL;
-
-    acpi_table_add(opts, &err);
-    if (err) {
-        error_reportf_err(err, "Wrong acpi table provided: ");
-        exit(1);
-    }
-#endif
-}
-
 int kvm_available(void)
 {
 #ifdef CONFIG_KVM
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 7be399e..a2c61f6 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,5 +1,5 @@
 devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),$(CONFIG_PCI))) += 9pfs/
-devices-dirs-$(CONFIG_ACPI) += acpi/
+devices-dirs-$(CONFIG_SOFTMMU) += acpi/
 devices-dirs-$(CONFIG_SOFTMMU) += adc/
 devices-dirs-$(CONFIG_SOFTMMU) += audio/
 devices-dirs-$(CONFIG_SOFTMMU) += block/
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index dfc8229..6acf798 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -1,9 +1,11 @@
+ifeq ($(CONFIG_ACPI),y)
 common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
 common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
+common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
 common-obj-y += bios-linker-loader.o
@@ -11,4 +13,7 @@ common-obj-y += aml-build.o
 
 common-obj-$(CONFIG_IPMI) += ipmi.o
 common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
-common-obj-$(CONFIG_ALL) += ipmi-stub.o
+else
+common-obj-y += acpi-stub.o
+endif
+common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
new file mode 100644
index 0000000..26bd22f
--- /dev/null
+++ b/hw/acpi/acpi-stub.c
@@ -0,0 +1,29 @@
+/*
+ * ACPI stubs for platforms that don't support ACPI.
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2016 Red Hat, Inc.
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
+#include "hw/acpi/acpi.h"
+
+void acpi_table_add(const QemuOpts *opts, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+}
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 88dcf77..20b01e3 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -28,7 +28,6 @@ enum {
 extern const uint32_t arch_type;
 
 void select_soundhw(const char *optarg);
-void do_acpitable_option(const QemuOpts *opts);
 void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
diff --git a/vl.c b/vl.c
index a2aff23..a52c5f2 100644
--- a/vl.c
+++ b/vl.c
@@ -65,6 +65,7 @@ int main(int argc, char **argv)
 #include "hw/bt.h"
 #include "sysemu/watchdog.h"
 #include "hw/smbios/smbios.h"
+#include "hw/acpi/acpi.h"
 #include "hw/xen/xen.h"
 #include "hw/qdev.h"
 #include "hw/loader.h"
@@ -3657,7 +3658,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                do_acpitable_option(opts);
+                acpi_table_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_smbios:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("smbios"),
-- 
2.9.3
