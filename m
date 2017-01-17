Received: from eggs.gnu.org ([2001:4830:134:3::10]:35276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSx-0003s7-9N
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSt-00019k-Mk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTZSt-00018g-GB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:43 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3125FB5991
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:30:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 17:30:31 -0200
Message-Id: <20170117193033.23178-2-ehabkost@redhat.com>
In-Reply-To: <20170117193033.23178-1-ehabkost@redhat.com>
References: <20170117193033.23178-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] stubs: Add smbios_entry_add() stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Instead of using an #ifdef in arch_init.c, add a
smbios_entry_add() stub. The stub will never be called because
the -smbios option is defined as arch-specific in
qemu-options.hx.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/arch_init.h | 1 -
 arch_init.c                | 7 -------
 stubs/smbios.c             | 7 +++++++
 vl.c                       | 2 +-
 stubs/Makefile.objs        | 1 +
 5 files changed, 9 insertions(+), 9 deletions(-)
 create mode 100644 stubs/smbios.c

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 1c9dad1b72..88dcf77a62 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -29,7 +29,6 @@ extern const uint32_t arch_type;
 
 void select_soundhw(const char *optarg);
 void do_acpitable_option(const QemuOpts *opts);
-void do_smbios_option(QemuOpts *opts);
 void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
diff --git a/arch_init.c b/arch_init.c
index 5cc58b2c35..9647c8d337 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -248,13 +248,6 @@ void do_acpitable_option(const QemuOpts *opts)
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
diff --git a/stubs/smbios.c b/stubs/smbios.c
new file mode 100644
index 0000000000..e86e8f821c
--- /dev/null
+++ b/stubs/smbios.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/smbios/smbios.h"
+
+void smbios_entry_add(QemuOpts *opts)
+{
+    abort(); /* must never be called */
+}
diff --git a/vl.c b/vl.c
index c643d3ff3a..38d812286a 100644
--- a/vl.c
+++ b/vl.c
@@ -3707,7 +3707,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                do_smbios_option(opts);
+                smbios_entry_add(opts);
                 break;
             case QEMU_OPTION_fwcfg:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 2b5bb74fce..83ddcad3c3 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -50,3 +50,4 @@ stub-obj-y += smbios_type_38.o
 stub-obj-y += ipmi.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
+stub-obj-y += smbios.o
-- 
2.11.0.259.g40922b1
